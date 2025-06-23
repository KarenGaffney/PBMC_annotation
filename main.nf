process DownloadData {
    tag "Download from public S3"

    input:
    path 'download_data.sh'

    output:
    path 'data/', emit: downloaded_data

    script:
    """
    chmod +x download_data.sh
    ./download_data.sh
    """
}

workflow {
    downloaded_data = DownloadData(file('download_data.sh'))

    downloaded_data.view()
}

