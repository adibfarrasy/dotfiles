def gdb [branch: string] {
    git branch | grep $"($branch)" | xargs git branch -D
}

def gl [n?: int] {
    let line_count = if ($n == null) {
        5 
    } else {
        $n
    }

    git log --pretty=%h»¦«%s»¦«%aN»¦«%aE»¦«%aD -n $"($line_count)" | lines | split column "»¦«" commit subject name email date | upsert date {|d| $d.date | into datetime} 
}
