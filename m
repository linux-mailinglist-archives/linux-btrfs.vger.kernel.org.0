Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE1627D1FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 16:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgI2O7A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 10:59:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:36910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbgI2O7A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 10:59:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92CC9AC12;
        Tue, 29 Sep 2020 14:58:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 816DADA701; Tue, 29 Sep 2020 16:57:39 +0200 (CEST)
Date:   Tue, 29 Sep 2020 16:57:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2 4/5] btrfs: introduce rescue=ignoredatacsums
Message-ID: <20200929145739.GH6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
References: <cover.1601318001.git.josef@toxicpanda.com>
 <1c4b7fef28dde35f38246ad17c6fd4c0cf8c5837.1601318001.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c4b7fef28dde35f38246ad17c6fd4c0cf8c5837.1601318001.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 28, 2020 at 02:34:56PM -0400, Josef Bacik wrote:
> There are cases where you can end up with bad data csums because of
> misbehaving applications.  This happens when an application modifies a
> buffer in-flight when doing an O_DIRECT write.  In order to recover the
> file we need a way to turn off data checksums so you can copy the file
> off, and then you can delete the file and restore it properly later.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/disk-io.c | 21 ++++++++++++---------
>  fs/btrfs/super.c   | 11 ++++++++++-
>  3 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index fb3cfd0aaf1e..397f5f6b88a4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1296,6 +1296,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>  #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
>  #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
>  #define BTRFS_MOUNT_IGNOREBADROOTS	(1 << 30)
> +#define BTRFS_MOUNT_IGNOREDATACSUMS	(1 << 31)
>  
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5deedfb0e5c7..6f9d37567a10 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2269,16 +2269,19 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
>  		btrfs_init_devices_late(fs_info);
>  	}
>  
> -	location.objectid = BTRFS_CSUM_TREE_OBJECTID;
> -	root = btrfs_read_tree_root(tree_root, &location);
> -	if (IS_ERR(root)) {
> -		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> -			ret = PTR_ERR(root);
> -			goto out;
> +	/* If IGNOREDATASCUMS is set don't bother reading the csum root. */
> +	if (!btrfs_test_opt(fs_info, IGNOREDATACSUMS)) {
> +		location.objectid = BTRFS_CSUM_TREE_OBJECTID;
> +		root = btrfs_read_tree_root(tree_root, &location);
> +		if (IS_ERR(root)) {
> +			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> +				ret = PTR_ERR(root);
> +				goto out;
> +			}
> +		} else {
> +			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +			fs_info->csum_root = root;
>  		}
> -	} else {
> -		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -		fs_info->csum_root = root;
>  	}
>  
>  	/*
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7cc7a9233f5e..2282f0240c1d 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -361,6 +361,7 @@ enum {
>  	Opt_usebackuproot,
>  	Opt_nologreplay,
>  	Opt_ignorebadroots,
> +	Opt_ignoredatacsums,
>  
>  	/* Deprecated options */
>  	Opt_recovery,
> @@ -457,6 +458,7 @@ static const match_table_t rescue_tokens = {
>  	{Opt_usebackuproot, "usebackuproot"},
>  	{Opt_nologreplay, "nologreplay"},
>  	{Opt_ignorebadroots, "ignorebadroots"},
> +	{Opt_ignoredatacsums, "ignoredatacsums"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -504,6 +506,10 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
>  			btrfs_set_and_info(info, IGNOREBADROOTS,
>  					   "ignoring bad roots");
>  			break;
> +		case Opt_ignoredatacsums:
> +			btrfs_set_and_info(info, IGNOREDATACSUMS,
> +					   "ignoring data csums");
> +			break;
>  		case Opt_err:
>  			btrfs_info(info, "unrecognized rescue option '%s'", p);
>  			ret = -EINVAL;
> @@ -990,7 +996,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  		goto out;
>  
>  	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
> -	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots"))
> +	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS,
> +			    "ignorebadroots") ||
> +	    check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS,
> +			    "ignoredatacsums"))
>  		ret = -EINVAL;
>  out:
>  	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&

This option is missing in the output of btrfs_show_options, but as there
are going to be several of them the compact format should be used (ie.
the option1:option2:option3).
