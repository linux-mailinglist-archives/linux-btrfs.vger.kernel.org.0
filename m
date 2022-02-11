Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D85E4B2AE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 17:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351744AbiBKQsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 11:48:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351742AbiBKQsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 11:48:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F8ABD3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 08:48:06 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C3A5C1F3AA
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 16:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644598084;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D9OsCkWLJQRfsiFruG91AgM9V0qMZ2nH3uWrWWqPSK0=;
        b=kBzJ9JTuy0iJxPgrCGb+9k0I6GvhbYQ8QTQQcErbzJRn2qB5lEDmd49UIkKXm79MuFFpB2
        oD+IsXh4EMFdLAfjI12zRRMhIzJzPGT4dCNxEPCncRNHsOiDPtaeg6wKLluRqMYnRWHGbX
        Reol4yx6a09uCKjTBSzSyCNoibb+jBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644598084;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D9OsCkWLJQRfsiFruG91AgM9V0qMZ2nH3uWrWWqPSK0=;
        b=ttXaH7lcUskWBQ5NdjkNgNzC8yTnrAxwAS58dMJNve/BR86uvDpi3fUss/tQcAHQyfmu7u
        bsGj+aF0vfRVCADg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BC989A3B8B;
        Fri, 11 Feb 2022 16:48:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CC5A0DA823; Fri, 11 Feb 2022 17:44:22 +0100 (CET)
Date:   Fri, 11 Feb 2022 17:44:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Fix subvol turns RO if root is remounted RO
Message-ID: <20220211164422.GA12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
References: <20220211140918.c6wpmh3pgzjuytve@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211140918.c6wpmh3pgzjuytve@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 08:09:18AM -0600, Goldwyn Rodrigues wrote:
> If a read-write root mount is remounted as read-only, the subvolume
> is also set to read-only.

The subvolume, you mean that the subvolume becomes read-only, ie. that
it gets the BTRFS_SUBVOL_RDONLY bit set?

> Use a rw_mounts counter to check the number of read-write mounts, and change
> superblock to read-only only in case there are no read-write subvol mounts.
> Disable SB_RDONLY in flags passed so superblock does not change
> read-only.

What is the use case for that? You provide test case to verify that the
change behaves as expected, but I don't understand why we should whan
the change.

> Test case:
> DEV=/dev/vdb
> mkfs.btrfs -f $DEV
> mount $DEV /mnt
> btrfs subvol create /mnt/sv
> mount -o remount,ro /mnt
> mount -o subvol=/sv $DEV /mnt/sv
> findmnt # /mnt is RO, /mnt/sv RW
> mount -o remount,ro /mnt
> findmnt # /mnt is RO, /mnt/sv RO as well
> umount /mnt{/sv,}
> 
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a2991971c6b5..2bb6869f15af 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1060,6 +1060,9 @@ struct btrfs_fs_info {
>  	spinlock_t zone_active_bgs_lock;
>  	struct list_head zone_active_bgs;
>  
> +	/* Count of subvol mounts read-write */
> +	int rw_mounts;
> +
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
>  	struct rb_root block_tree;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 33cfc9e27451..2072759d5f22 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1835,6 +1835,11 @@ static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
>  	/* mount_subvol() will free subvol_name and mnt_root */
>  	root = mount_subvol(subvol_name, subvol_objectid, mnt_root);
>  
> +	if (!IS_ERR(root) && !(flags & SB_RDONLY)) {
> +		struct btrfs_fs_info *fs_info = btrfs_sb(mnt_root->mnt_sb);
> +		fs_info->rw_mounts++;
> +	}
> +
>  out:
>  	return root;
>  }
> @@ -1958,6 +1963,11 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  		goto out;
>  
>  	if (*flags & SB_RDONLY) {
> +
> +		if (--fs_info->rw_mounts > 0) {
> +			*flags &= ~SB_RDONLY;
> +			goto out;
> +		}
>  		/*
>  		 * this also happens on 'umount -rf' or on shutdown, when
>  		 * the filesystem is busy.
> @@ -2057,6 +2067,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  		if (ret)
>  			goto restore;
>  
> +		fs_info->rw_mounts++;
> +
>  		btrfs_clear_sb_rdonly(sb);
>  
>  		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
> 
> -- 
> Goldwyn
