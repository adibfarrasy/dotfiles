def --env cdc [svc?: string] {
    let sv = if svc == null {
        ""
    } else $svc
    cd $"/home/adibf/.config/($sv)"
}

def --env cdo [svc: string] {
    cd $"/home/adibf/projects/one-percent-($svc)"
}
