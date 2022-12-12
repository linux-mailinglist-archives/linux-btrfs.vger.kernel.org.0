Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A9264A584
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiLLRGf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 12:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiLLRGP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 12:06:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD3126DA
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 09:06:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 94C66CE0EC2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 17:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC329C433EF
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670864770;
        bh=dDsm/rP1AcA8tlfWHDNA/scQnoPeYQ/8CiuKZAmUUUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RQbxVraTMbzdZ3eqrZnJDD75u8FVqveI5snsDt6RUgDh1yg2ieSwjAbN8TuMSNmRT
         zcZHZ1Mip1SpOKvVc2DEdxPQ93BrBp6l9TfTDrdiT3VM8pzmFDBWjaRjjcLJpzWMBD
         QUw+2HmpmtnJxISz4Fc1rYDq7/eSSa9JaOGzUW1hoBQg/WRgIWvX66kJ+CpUvhNF8W
         GDtemO/mHP4QJgxubSjUGNx9JrZDLCOBEXDtpXFpDv2hkp991D1YjR1kTHPP/OjbTe
         Xnaw09S47ughsJjAEgZXvK+AeBaRnBsfDDPNipsdCb5o032fG78bCWFKciO84o6rxO
         dInmujEyT78iQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-14449b7814bso9161064fac.3
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 09:06:10 -0800 (PST)
X-Gm-Message-State: ANoB5plqWpucHw/mATkH1a/MD0++Db9bmm8oYyI/7eGX8jd9n+E9LjN6
        oSr9owilZZXBsozzNyejHuDPSRrcvTwtVs4igtY=
X-Google-Smtp-Source: AA0mqf5s05BnJhBv1cgpuDX3tdKQl5hWx71fMqzAAEcNnKxG8Cw3hZi8JW/HEl+oBp8sewbGiVETRL6sfx7OTbF0kQc=
X-Received: by 2002:a05:6870:b0d:b0:144:6d8b:c318 with SMTP id
 lh13-20020a0568700b0d00b001446d8bc318mr12768356oab.98.1670864770006; Mon, 12
 Dec 2022 09:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20221205095122.17011-1-robbieko@synology.com> <20221205095122.17011-3-robbieko@synology.com>
In-Reply-To: <20221205095122.17011-3-robbieko@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 12 Dec 2022 17:05:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5EBemSEP6hVye631rj9MAEU4TxwfYRbAuKSC_gJMam_w@mail.gmail.com>
Message-ID: <CAL3q7H5EBemSEP6hVye631rj9MAEU4TxwfYRbAuKSC_gJMam_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: change snapshot_lock to dynamic pointer
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 5, 2022 at 10:30 AM robbieko <robbieko@synology.com> wrote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> Change snapshot_lock to dynamic pointer to allocate memory
> at the beginning of creating a subvolume/snapshot.
>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/btrfs/ctree.h   |  2 +-
>  fs/btrfs/disk-io.c | 10 ++++++++--
>  fs/btrfs/file.c    |  8 ++++----
>  fs/btrfs/inode.c   | 12 ++++++------
>  fs/btrfs/ioctl.c   |  4 ++--
>  5 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 9e6d48ff4597..99003b0dd407 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1429,7 +1429,7 @@ struct btrfs_root {
>          */
>         int dedupe_in_progress;
>         /* For exclusion of snapshot creation and nocow writes */
> -       struct btrfs_drew_lock snapshot_lock;
> +       struct btrfs_drew_lock *snapshot_lock;
>
>         atomic_t snapshot_force_cow;
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index afe16e1f0b18..5760c2b1a100 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1464,12 +1464,17 @@ static int btrfs_init_fs_root(struct btrfs_root *root,
>         int ret;
>         unsigned int nofs_flag;
>
> +       root->snapshot_lock = kzalloc(sizeof(*root->snapshot_lock), GFP_NOFS);
> +       if (!root->snapshot_lock) {
> +               ret = -ENOMEM;
> +               goto fail;
> +       }
>         /*
>          * We might be called under a transaction (e.g. indirect backref
>          * resolution) which could deadlock if it triggers memory reclaim
>          */
>         nofs_flag = memalloc_nofs_save();
> -       ret = btrfs_drew_lock_init(&root->snapshot_lock);
> +       ret = btrfs_drew_lock_init(root->snapshot_lock);
>         memalloc_nofs_restore(nofs_flag);
>         if (ret)
>                 goto fail;
> @@ -2180,7 +2185,8 @@ void btrfs_put_root(struct btrfs_root *root)
>                 WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
>                 if (root->anon_dev)
>                         free_anon_bdev(root->anon_dev);
> -               btrfs_drew_lock_destroy(&root->snapshot_lock);
> +               if (root->snapshot_lock)
> +                       btrfs_drew_lock_destroy(root->snapshot_lock);

This is leaking the memory allocated for the lock, it needs a
kfree(root->snapshot_lock) too.

Thanks.

>                 free_root_extent_buffers(root);
>  #ifdef CONFIG_BTRFS_DEBUG
>                 spin_lock(&root->fs_info->fs_roots_radix_lock);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index d01631d47806..a338fbd34472 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1379,7 +1379,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
>         if (!(inode->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
>                 return 0;
>
> -       if (!btrfs_drew_try_write_lock(&root->snapshot_lock))
> +       if (!btrfs_drew_try_write_lock(root->snapshot_lock))
>                 return -EAGAIN;
>
>         lockstart = round_down(pos, fs_info->sectorsize);
> @@ -1389,7 +1389,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
>
>         if (nowait) {
>                 if (!btrfs_try_lock_ordered_range(inode, lockstart, lockend)) {
> -                       btrfs_drew_write_unlock(&root->snapshot_lock);
> +                       btrfs_drew_write_unlock(root->snapshot_lock);
>                         return -EAGAIN;
>                 }
>         } else {
> @@ -1398,7 +1398,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
>         ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
>                         NULL, NULL, NULL, nowait, false);
>         if (ret <= 0)
> -               btrfs_drew_write_unlock(&root->snapshot_lock);
> +               btrfs_drew_write_unlock(root->snapshot_lock);
>         else
>                 *write_bytes = min_t(size_t, *write_bytes ,
>                                      num_bytes - pos + lockstart);
> @@ -1409,7 +1409,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
>
>  void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
>  {
> -       btrfs_drew_write_unlock(&inode->root->snapshot_lock);
> +       btrfs_drew_write_unlock(inode->root->snapshot_lock);
>  }
>
>  static void update_time_for_write(struct inode *inode)
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0e516aefbf51..8fe4b00d31f4 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5167,16 +5167,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
>                  * truncation, it must capture all writes that happened before
>                  * this truncation.
>                  */
> -               btrfs_drew_write_lock(&root->snapshot_lock);
> +               btrfs_drew_write_lock(root->snapshot_lock);
>                 ret = btrfs_cont_expand(BTRFS_I(inode), oldsize, newsize);
>                 if (ret) {
> -                       btrfs_drew_write_unlock(&root->snapshot_lock);
> +                       btrfs_drew_write_unlock(root->snapshot_lock);
>                         return ret;
>                 }
>
>                 trans = btrfs_start_transaction(root, 1);
>                 if (IS_ERR(trans)) {
> -                       btrfs_drew_write_unlock(&root->snapshot_lock);
> +                       btrfs_drew_write_unlock(root->snapshot_lock);
>                         return PTR_ERR(trans);
>                 }
>
> @@ -5184,7 +5184,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
>                 btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
>                 pagecache_isize_extended(inode, oldsize, newsize);
>                 ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
> -               btrfs_drew_write_unlock(&root->snapshot_lock);
> +               btrfs_drew_write_unlock(root->snapshot_lock);
>                 btrfs_end_transaction(trans);
>         } else {
>                 struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> @@ -11026,7 +11026,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
>          * completes before the first write into the swap file after it is
>          * activated, than that write would fallback to COW.
>          */
> -       if (!btrfs_drew_try_write_lock(&root->snapshot_lock)) {
> +       if (!btrfs_drew_try_write_lock(root->snapshot_lock)) {
>                 btrfs_exclop_finish(fs_info);
>                 btrfs_warn(fs_info,
>            "cannot activate swapfile because snapshot creation is in progress");
> @@ -11199,7 +11199,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
>         if (ret)
>                 btrfs_swap_deactivate(file);
>
> -       btrfs_drew_write_unlock(&root->snapshot_lock);
> +       btrfs_drew_write_unlock(root->snapshot_lock);
>
>         btrfs_exclop_finish(fs_info);
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 5785336ab7cf..9f1b81ff37a3 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1008,7 +1008,7 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
>          * possible. This is to avoid later writeback (running dealloc) to
>          * fallback to COW mode and unexpectedly fail with ENOSPC.
>          */
> -       btrfs_drew_read_lock(&root->snapshot_lock);
> +       btrfs_drew_read_lock(root->snapshot_lock);
>
>         ret = btrfs_start_delalloc_snapshot(root, false);
>         if (ret)
> @@ -1029,7 +1029,7 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
>  out:
>         if (snapshot_force_cow)
>                 atomic_dec(&root->snapshot_force_cow);
> -       btrfs_drew_read_unlock(&root->snapshot_lock);
> +       btrfs_drew_read_unlock(root->snapshot_lock);
>         return ret;
>  }
>
> --
> 2.17.1
>
