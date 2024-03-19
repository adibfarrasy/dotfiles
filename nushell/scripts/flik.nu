def --env cdf [svc?: string] {
    let sv = if svc == null {
        ""
    } else $svc
    cd $"/home/adibf/projects/flik-backend/($sv)"
}

def --env flikenv [svc: string] {
    open $"/home/adibf/projects/flik-backend/($svc)/config/.env.development" 
        | lines 
        | filter { |l| ($l | str contains "#") == false and $l != ""}
        | each { |l| 
            $l 
            | str replace -r "=((?![\"'])(?!\\d+$)[^\"'].*[^\"'])" "=\"${1}\""
        }
        | save -f '/tmp/flikenv'

    open /tmp/flikenv
        | from toml
        | load-env
}
