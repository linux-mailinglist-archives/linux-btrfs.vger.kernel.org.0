Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134EE3991EE
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 19:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFBRvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Jun 2021 13:51:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42246 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhFBRvJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Jun 2021 13:51:09 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A3BEB1FD32;
        Wed,  2 Jun 2021 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622656165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZQEPtOYMRUtkv/Ffv2zcG2LL0/3r9LQd7PMq59OvVs=;
        b=pNm1JNswkYdEQ5b+7vPNDtGNnHF6wYPwQCqr0rt24VTfJGcJcIWVUaV1iVDmcPyVzxM3eN
        nRgoRXN5n4sGC87NDEET1T+SaR1ygj5wfTsNMG6yZFCkfh/AJc80fteKuI5eoaLLTRldxq
        GKxbZ7OkXWzdCSWvoLEs4i/rlnd5+yE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622656165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZQEPtOYMRUtkv/Ffv2zcG2LL0/3r9LQd7PMq59OvVs=;
        b=obh8g7+FOMJfIAWaC16wKuPXZfvIi+DXuSpyC09/mY4VkNbQQXXYa2lWZkWhX4Rn0dpK0k
        HF4gddP6oc31TZCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9C12FA3B88;
        Wed,  2 Jun 2021 17:49:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BB297DA823; Wed,  2 Jun 2021 19:37:07 +0200 (CEST)
Date:   Wed, 2 Jun 2021 19:37:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 30/30] btrfs: allow read-write for 4K sectorsize on
 64K page size systems
Message-ID: <20210602173707.GR31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
 <20210531085106.259490-31-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531085106.259490-31-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 04:51:06PM +0800, Qu Wenruo wrote:
> Since now we support data and metadata read-write for subpage, remove
> the RO requirement for subpage mount.
> 
> There are some extra limits though:
> - For now, subpage RW mount is still considered experimental
>   Thus that mount warning will still be there.
> 
> - No compression support
>   There are still quite some PAGE_SIZE hard coded and quite some call
>   sites use extent_clear_unlock_delalloc() to unlock locked_page.
>   This will screw up subpage helpers
> 
>   Now for subpage RW mount, no matter whatever mount option or inode
>   attr is set, all write will not be compressed.
>   Although reading compressed data has no problem.
> 
> - No defrag for subpage case
>   The defrag support for subpage case will come in later patches, which
>   will also rework the defrag workflow.
> 
> - No inline extent will be created
>   This is mostly due to the fact that filemap_fdatawrite_range() will
>   trigger more write than the range specified.
>   In fallocate calls, this behavior can make us to writeback which can
>   be inlined, before we enlarge the isize.
> 
>   This is a very special corner case, and even current btrfs check won't
>   report error on such inline extent + regular extent.
>   But considering how much effort has been put to prevent such inline +
>   regular, I'd prefer to cut off inline extent completely until we have
>   a good solution.

I think the limitations are acceptable. Inline extents can be turned off
by mount option too, defrag is optional, compression has a fallback.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 13 ++++---------
>  fs/btrfs/inode.c   |  3 +++
>  fs/btrfs/ioctl.c   |  6 ++++++
>  fs/btrfs/super.c   |  7 -------
>  fs/btrfs/sysfs.c   |  5 +++++
>  5 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 2dd48f4bec8f..7c17cb7cf4fe 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3396,15 +3396,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		goto fail_alloc;
>  	}
>  
> -	/* For 4K sector size support, it's only read-only */
> -	if (PAGE_SIZE == SZ_64K && sectorsize == SZ_4K) {
> -		if (!sb_rdonly(sb) || btrfs_super_log_root(disk_super)) {
> -			btrfs_err(fs_info,
> -	"subpage sectorsize %u only supported read-only for page size %lu",
> -				sectorsize, PAGE_SIZE);
> -			err = -EINVAL;
> -			goto fail_alloc;
> -		}
> +	if (sectorsize != PAGE_SIZE) {
> +		btrfs_warn(fs_info,
> +	"read-write for sector size %u with page size %lu is experimental",
> +			   sectorsize, PAGE_SIZE);
>  	}
>  	if (sectorsize != PAGE_SIZE) {
>  		if (btrfs_super_incompat_flags(fs_info->super_copy) &
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 85f465328ab2..27d56a77aa5f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -490,6 +490,9 @@ static noinline int add_async_extent(struct async_chunk *cow,
>   */
>  static inline bool inode_can_compress(struct btrfs_inode *inode)
>  {
> +	/* Subpage doesn't support compress yet */
> +	if (inode->root->fs_info->sectorsize < PAGE_SIZE)
> +		return false;
>  	if (inode->flags & BTRFS_INODE_NODATACOW ||
>  	    inode->flags & BTRFS_INODE_NODATASUM)
>  		return false;
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 49cfa9772c1b..11adf4670c55 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3028,6 +3028,12 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
>  		goto out;
>  	}
>  
> +	/* Subpage defrag will be supported in later commits */
> +	if (root->fs_info->sectorsize < PAGE_SIZE) {
> +		ret = -ENOTTY;

This should be -EOPNOTSUPP, that's what we've used eg. in zoned mode for
features that are not implemented yet but will be (fitrim), while for
nocow it's -EPERM as it's entirely incompatible.

ENOTTY would mean there's no such ioctl, which would be confusing
because the ioctl is otherwise valid for btrfs.
