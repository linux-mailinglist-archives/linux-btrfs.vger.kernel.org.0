Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6178B1A8ECD
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Apr 2020 00:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634309AbgDNW4j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 18:56:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbgDNW4g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 18:56:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5CD71ACF2;
        Tue, 14 Apr 2020 22:56:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 92C6BDB0BA; Wed, 15 Apr 2020 00:55:54 +0200 (CEST)
Date:   Wed, 15 Apr 2020 00:55:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2 2/2] btrfs-progs: replace: New argument to resize the
 fs after replace
Message-ID: <20200414225554.GZ5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        wqu@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200320033227.3721-1-marcos@mpdesouza.com>
 <20200320033227.3721-3-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320033227.3721-3-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 20, 2020 at 12:32:27AM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> By using the -a flag on replace makes btrfs issue a resize ioctl after
> the replace finishes. This argument is a shortcut for
> 
> btrfs replace start -f 3 /dev/sdf BTRFS/
> btrfs fi resize 3:max BTRFS/
> 
> The -a stands for "automatically resize"

The single letters are reserved for the most common actions, the long
option is always safe and it's easy to add the short option later. In
case we'd like to make the auto-resize default, the 'no-' variant of
the long option would be good from the begining too.

> Fixes: #21
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes from v1:
> * Reworded the help message and the docs telling the user that the fs will be
>   resized to it's max size (suggested by Wenruo)
> * Added a warning message saying that the resize failed, asking the user to
>   resize manually. (suggested by Wenruo)
> 
>  Documentation/btrfs-replace.asciidoc |  5 ++++-
>  cmds/replace.c                       | 21 +++++++++++++++++++--
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/btrfs-replace.asciidoc b/Documentation/btrfs-replace.asciidoc
> index b73bf1b3..07cf2ae9 100644
> --- a/Documentation/btrfs-replace.asciidoc
> +++ b/Documentation/btrfs-replace.asciidoc
> @@ -18,7 +18,7 @@ SUBCOMMAND
>  *cancel* <mount_point>::
>  Cancel a running device replace operation.
>  
> -*start* [-Bfr] <srcdev>|<devid> <targetdev> <path>::
> +*start* [-aBfr] <srcdev>|<devid> <targetdev> <path>::
>  Replace device of a btrfs filesystem.
>  +
>  On a live filesystem, duplicate the data to the target device which
> @@ -53,6 +53,9 @@ never allowed to be used as the <targetdev>.
>  +
>  -B::::
>  no background replace.
> ++a::::
> +automatically resizes the filesystem to it's max size if the <targetdev> is
> +bigger than <srcdev>.
>  
>  *status* [-1] <mount_point>::
>  Print status and progress information of a running device replace operation.
> diff --git a/cmds/replace.c b/cmds/replace.c
> index 2321aa15..8761bfc0 100644
> --- a/cmds/replace.c
> +++ b/cmds/replace.c
> @@ -91,7 +91,7 @@ static int dev_replace_handle_sigint(int fd)
>  }
>  
>  static const char *const cmd_replace_start_usage[] = {
> -	"btrfs replace start [-Bfr] <srcdev>|<devid> <targetdev> <mount_point>",
> +	"btrfs replace start [-aBfr] <srcdev>|<devid> <targetdev> <mount_point>",
>  	"Replace device of a btrfs filesystem.",
>  	"On a live filesystem, duplicate the data to the target device which",
>  	"is currently stored on the source device. If the source device is not",
> @@ -104,6 +104,8 @@ static const char *const cmd_replace_start_usage[] = {
>  	"from the system, you have to use the <devid> parameter format.",
>  	"The <targetdev> needs to be same size or larger than the <srcdev>.",
>  	"",
> +	"-a     automatically resizes the filesystem to it's max size if the",
> +	"       <targetdev> is bigger than <srcdev>",
>  	"-r     only read from <srcdev> if no other zero-defect mirror exists",
>  	"       (enable this if your drive has lots of read errors, the access",
>  	"       would be very slow)",
> @@ -129,6 +131,7 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
>  	char *path;
>  	char *srcdev;
>  	char *dstdev = NULL;
> +	bool auto_resize = false;
>  	int avoid_reading_from_srcdev = 0;
>  	int force_using_targetdev = 0;
>  	u64 dstdev_block_count;
> @@ -138,8 +141,11 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
>  	u64 dstdev_size;
>  
>  	optind = 0;
> -	while ((c = getopt(argc, argv, "Brf")) != -1) {
> +	while ((c = getopt(argc, argv, "aBrf")) != -1) {
>  		switch (c) {
> +		case 'a':
> +			auto_resize = true;
> +			break;
>  		case 'B':
>  			do_not_background = 1;
>  			break;
> @@ -309,6 +315,17 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
>  			goto leave_with_error;
>  		}
>  	}
> +
> +	if (ret == 0 && auto_resize && dstdev_size > srcdev_size) {
> +		char amount[BTRFS_PATH_NAME_MAX + 1];
> +		snprintf(amount, BTRFS_PATH_NAME_MAX, "%s:max", srcdev);

The format needs the device id, not the path, so for the path-based
source device it needs to be translated.

> +
> +		if (resize_filesystem(amount, path)) {
> +			warning("resize failed, please resize the filesystem manually");

The warning is fine but should also print the exact command line or at
least the important bits.

> +			goto leave_with_error;
> +		}
> +	}
> +
>  	close_file_or_dir(fdmnt, dirstream);
>  	return 0;
>  
> -- 
> 2.25.0
