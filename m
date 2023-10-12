Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D687C6564
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 08:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347050AbjJLGW4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 02:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343510AbjJLGWz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 02:22:55 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Oct 2023 23:22:53 PDT
Received: from mail-108-mta67.mxroute.com (mail-108-mta67.mxroute.com [136.175.108.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E0BA
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 23:22:52 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta67.mxroute.com (ZoneMTA) with ESMTPSA id 18b2288c4c5000ff68.002
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 12 Oct 2023 06:17:50 +0000
X-Zone-Loop: cc632c480ad6cd800bcdc6a04b0a9fdcfd85298afc46
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
        ; s=x; h=Content-Type:MIME-Version:Message-ID:In-reply-to:Date:Subject:Cc:To:
        From:References:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sNmMRES6Vz5LdjTJp8C644dN072Otnni//0gLBoySGM=; b=qu2nq2w+w6CXZ5PanaF2wMIWd4
        uYQ9P2xqo597ZG5D3EdfkiRqag4pyntNX/2RNts+PZZMzNujaXpwapiw4apkn4mC9uJKf/BQeL4ge
        4ljnf6mnxXx7a+xtVqAYPwRCJWX8pnNVUK924bCMXezYLL7PYBBb2EFTzKFh6aKxhD0ygjDS4SKZA
        n2PabAh43xv8CWIpUU+XkO7rGWPqmA2WuhD4C2tEr4iwZ0oUCSAfyFy5p8dIIx8XryAEZ5XJ7Dd2o
        xxzQysCI8S768Px9k4C21snXmVafuVNTR3a6owiEKRnTqTCxOkUZJdrPFPYqGrR02Y2dZ1zvnQnHd
        rzS900Jw==;
References: <a6a954a1f1c7d612104279c62916f49e47ba5811.1697085884.git.wqu@suse.com>
User-agent: mu4e 1.7.5; emacs 28.2
From:   Su Yue <l@damenly.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject unknown mount options correctly
Date:   Thu, 12 Oct 2023 14:01:53 +0800
In-reply-to: <a6a954a1f1c7d612104279c62916f49e47ba5811.1697085884.git.wqu@suse.com>
Message-ID: <cyxk1i2x.fsf@damenly.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Thu 12 Oct 2023 at 15:14, Qu Wenruo <wqu@suse.com> wrote:

> [BUG]
> The following script would allow invalid mount options to be 
> specified
> (although such invalid options would just be ignored):
>
>  # mkfs.btrfs -f $dev
>  # mount $dev $mnt1		<<< Successful mount expected
>  # mount $dev $mnt2 -o junk	<<< Failed mount expected
>  # echo $?
>  0
>
> [CAUSE]
> During the mount progress, btrfs_mount_root() would go different 
> paths
> depending on if there is already a mounted btrfs for it:
>
> 	s = sget();
> 	if (s->s_root) {
> 		/* do the cleanups and reuse the existing super */
> 	} else {
> 		/* do the real mount */
> 		error = btrfs_fill_super();
> 	}
>
> Inside btrfs_fill_super() we call open_ctree() and then
> btrfs_parse_options(), which would reject all the invalid 
> options.
>
> But if we got the other path, we won't really call
> btrfs_parse_options(), thus we just ignore the mount options 
> completely.
>
> [FIX]
> Instead of pure cleanups, if we found an existing mounted btrfs, 
> we
> still do a very basic mount options check, to reject unknown 
> mount
> options.
>
> Inside btrfs_mount_root(), we have already called
> security_sb_eat_lsm_opts(), which would have already stripe the 
> security
> mount options, thus if we hit an error, it must be an invalid 
> one.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This would be the proper fix for the recently reverted commit
> 5f521494cc73 ("btrfs: reject unknown mount options early").
>
I'm a noob about selinux though. Better to draft a new fstest case 
to
avoid further regression?

--
Su

> With updated timing where the new check is after
> security_sb_eat_lsm_opts().
> ---
>  fs/btrfs/super.c | 46 
>  ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index cc326969751f..4e4a2e4ba315 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -860,6 +860,50 @@ static int btrfs_parse_device_options(const 
> char *options, blk_mode_t flags)
>  	return error;
>  }
>
> +/*
> + * Check if the @options has any invalid ones.
> + *
> + * NOTE: this can only be called after 
> security_sb_eat_lsm_opts().
> + *
> + * Return -ENOMEM if we failed to allocate the memory for the 
> string
> + * Return -EINVAL if we found invalid mount options
> + * Return 0 otherwise.
> + */
> +static int btrfs_check_invalid_options(const char *options)
> +{
> +	substring_t args[MAX_OPT_ARGS];
> +	char *opts, *orig, *p;
> +	int ret = 0;
> +
> +	if (!options)
> +		return 0;
> +
> +	opts = kstrdup(options, GFP_KERNEL);
> +	if (!opts)
> +		return -ENOMEM;
> +	orig = opts;
> +
> +	while ((p = strsep(&opts, ",")) != NULL) {
> +		int token;
> +
> +		if (!*p)
> +			continue;
> +
> +		token = match_token(p, tokens, args);
> +		switch (token) {
> +		case Opt_err:
> +			btrfs_err(NULL, "unrecognized mount option '%s'", p);
> +			ret = -EINVAL;
> +			goto out;
> +		default:
> +			break;
> +		}
> +	}
> +out:
> +	kfree(orig);
> +	return ret;
> +}
> +
>  /*
>   * Parse mount options that are related to subvolume id
>   *
> @@ -1474,6 +1518,8 @@ static struct dentry 
> *btrfs_mount_root(struct file_system_type *fs_type,
>  		btrfs_free_fs_info(fs_info);
>  		if ((flags ^ s->s_flags) & SB_RDONLY)
>  			error = -EBUSY;
> +		if (!error)
> +			error = btrfs_check_invalid_options(data);
>  	} else {
>  		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
>  		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", 
>  fs_type->name,
