Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC92C62899C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 20:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbiKNTpb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 14:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiKNTpa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 14:45:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A49DE93
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 11:45:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5688520A45;
        Mon, 14 Nov 2022 19:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668455128;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zo4okwnZ75AwA6PWPNumLzVlnO59JIYnqa86DoMn34=;
        b=sZrrztFC9FHoRWzpMgo8qiuwwKFgiqg2o0DUThIbzR2Xw/ZKT02LC+T4r36h/5IpZ/PqtT
        tOq0LiHFgPFbKeqgFz8uCL4ocfUPlsO0Env2fta8TZ4Q5izgnLv+MoHoW1XKe0CQ2G94S3
        E6cNHw1xpHbNI/W+N/uOB/DzZMTLqn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668455128;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zo4okwnZ75AwA6PWPNumLzVlnO59JIYnqa86DoMn34=;
        b=P8cBtvZE5DnJKxIlRGGAUHq34+P0kCX4dnmbSRzperivf/9Zag0rBwWG2ijGutehT9r2VY
        KwmFoxWAAaeskyDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B1C413A8C;
        Mon, 14 Nov 2022 19:45:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YV6FCdiacmP2HwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 14 Nov 2022 19:45:28 +0000
Date:   Mon, 14 Nov 2022 20:45:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix the wrong log level of "filesystem
 defrag"
Message-ID: <20221114194502.GY5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4633d2fd0b1518238e9800b0e7a8939991ef5500.1668305578.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4633d2fd0b1518238e9800b0e7a8939991ef5500.1668305578.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 13, 2022 at 10:13:08AM +0800, Qu Wenruo wrote:
> [BUG]
> Test case fstests:btrfs/021 will fail with v6.0 btrfs-progs, with the
> extra output:
> 
>      QA output created by 021
>     +/mnt/scratch/padding-0
>     +/mnt/scratch/padding-1
>     +/mnt/scratch/padding-2
>     +/mnt/scratch/padding-3
>     +/mnt/scratch/padding-4
>     +/mnt/scratch/padding-5
>     ...
> 
> [CAUSE]
> Commit db2f85c8751c ("btrfs-progs: fi defrag: add global verbose
> option") changed the default message level to 1.
> 
> But the original code uses a different log level than the global verbose
> level (previously log level 1 is not outputed by default).
> 
> Thus this increased the output level by default.
> 
> [FIX]
> Don't use immediate number, and use LOG_INFO instead.
> 
> Fixes: db2f85c8751c ("btrfs-progs: fi defrag: add global verbose option")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  cmds/filesystem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 7c8323d9db8a..22f7bf7daeb7 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -878,7 +878,7 @@ static int defrag_callback(const char *fpath, const struct stat *sb,
>  	int fd = 0;
>  
>  	if ((typeflag == FTW_F) && S_ISREG(sb->st_mode)) {
> -		pr_verbose(1, "%s\n", fpath);
> +		pr_verbose(LOG_INFO, "%s\n", fpath);

That fixes the levels, yes but unfortunatelly the command line does not
work the same:

"btrfs defrag -v" still does not print the file names because this way
it'll set the verbosity level to 1 and LOG_INFO is 2, -vv works as
before.

>  		fd = open(fpath, defrag_open_mode);
>  		if (fd < 0) {
>  			goto error;
> @@ -1050,7 +1050,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
>  			/* errors are handled in the callback */
>  			ret = 0;
>  		} else {
> -			pr_verbose(1, "%s\n", argv[i]);
> +			pr_verbose(LOG_INFO, "%s\n", argv[i]);
>  			ret = ioctl(fd, BTRFS_IOC_DEFRAG_RANGE,
>  					&defrag_global_range);
>  			defrag_err = errno;
> -- 
> 2.38.1
