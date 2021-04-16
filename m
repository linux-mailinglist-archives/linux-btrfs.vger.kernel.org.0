Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908A3361D0C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 12:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbhDPJQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 05:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbhDPJP7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 05:15:59 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ACDC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 02:15:34 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id o2so6904859qtr.4
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=VODsK5VYhaXJlWcAUkCBZWnSMw4p7Z7TUx0r977Glog=;
        b=MxbVv4HYW4LatCtYm2twzZf2ClkzYUCyqj9ANEG2oXLr7/ngKT463VpKndlCgUwKdw
         VSEF+w/GQxBd8Equ6n+xnKDnDQy5jbBIndAiJMWfcABynV0UiiuV238xJAKekBdq20L4
         Hu/oeBvlyxrjZZkRg0TMYKojbXNTzabaE79NBHINDW4AHOvSITqWoFECfzMz8unDuNgY
         d6KTsYApuJKv3LWHi80OyRc9RhtVPjPs/GN23aT4jPkmX51A94U99Qb1725piXBg2k3y
         zMD2uzfTaHVmS5baZMcXOKD5U7rdPp033xidqfHUPIcpwOrSw+mVRvfAY55ACulOdV0D
         +MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=VODsK5VYhaXJlWcAUkCBZWnSMw4p7Z7TUx0r977Glog=;
        b=LwAd/a6NPOvDVPWf17rL3fuDPSQhwwUqp5HR13s1unj8dVXe3GOwsZ+aNvuAYpJSKf
         B9jBy8AFquT9BASOQZTVsrnFwj/Wru7WjUeEXURIb8Gt99VLn9MF953R1VB0cgRLdJ9x
         XhNmbr5eMgQFTNySHU1vbAbN95W9QbzLQFPQUrX0WdTLLzuusRDsIptbvRSEm8SkAxat
         UNG0vuRtvnq4WGhROtvloG6A4V0m3zaYgy4XdlPOAGRJ6ZfsOg4S4wrcNbHCAFCyxYjF
         rZtKIMWAJ0SymWumvACt7QDBEVUQFkz0+9anPRFrPBIqa3n7eBohJPAD7TXfS7U3GUu5
         wW8Q==
X-Gm-Message-State: AOAM533iFRQ8FJ3IDtVF6qODi5u2GxTnizqLyOHuxjHMbgc46rUEuVSV
        gfYuFU3OpkdHDI9xbL2D5ctaf1COYPGk0KD99yM=
X-Google-Smtp-Source: ABdhPJz5aui2Sz0zq8Uqi/cMwdZsD+1kZVbyb08JOHl03o58O2TNjG94OHkVzlnhG8gdR7w777l+IxEu7KcOLC7qudo=
X-Received: by 2002:ac8:5e8e:: with SMTP id r14mr6963454qtx.213.1618564533482;
 Fri, 16 Apr 2021 02:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618494550.git.johannes.thumshirn@wdc.com> <160b0452ecb4a810b819e0eae68bd9ef507cc813.1618494550.git.johannes.thumshirn@wdc.com>
In-Reply-To: <160b0452ecb4a810b819e0eae68bd9ef507cc813.1618494550.git.johannes.thumshirn@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 16 Apr 2021 10:15:22 +0100
Message-ID: <CAL3q7H5By7Pn+dRi64_N1Fdvmpc=r4c6548AdmM=NhMgnGSxMw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] btrfs: rename delete_unused_bgs_mutex
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 15, 2021 at 3:00 PM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> As a preparation for another user, rename the unused_bgs_mutex into
> reclaim_bgs_lock.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/block-group.c |  6 +++---
>  fs/btrfs/ctree.h       |  2 +-
>  fs/btrfs/disk-io.c     |  6 +++---
>  fs/btrfs/volumes.c     | 46 +++++++++++++++++++++---------------------
>  4 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 293f3169be80..bbb5a6e170c7 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1289,7 +1289,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
>          * Long running balances can keep us blocked here for eternity, s=
o
>          * simply skip deletion if we're unable to get the mutex.
>          */
> -       if (!mutex_trylock(&fs_info->delete_unused_bgs_mutex))
> +       if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
>                 return;
>
>         spin_lock(&fs_info->unused_bgs_lock);
> @@ -1462,12 +1462,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info=
 *fs_info)
>                 spin_lock(&fs_info->unused_bgs_lock);
>         }
>         spin_unlock(&fs_info->unused_bgs_lock);
> -       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +       mutex_unlock(&fs_info->reclaim_bgs_lock);
>         return;
>
>  flip_async:
>         btrfs_end_transaction(trans);
> -       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +       mutex_unlock(&fs_info->reclaim_bgs_lock);
>         btrfs_put_block_group(block_group);
>         btrfs_discard_punt_unused_bgs_list(fs_info);
>  }
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2c858d5349c8..c80302564e6b 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -957,7 +957,7 @@ struct btrfs_fs_info {
>         spinlock_t unused_bgs_lock;
>         struct list_head unused_bgs;
>         struct mutex unused_bg_unpin_mutex;
> -       struct mutex delete_unused_bgs_mutex;
> +       struct mutex reclaim_bgs_lock;
>
>         /* Cached block sizes */
>         u32 nodesize;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0a1182694f48..e52b89ad0a61 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1890,10 +1890,10 @@ static int cleaner_kthread(void *arg)
>                 btrfs_run_defrag_inodes(fs_info);
>
>                 /*
> -                * Acquires fs_info->delete_unused_bgs_mutex to avoid rac=
ing
> +                * Acquires fs_info->reclaim_bgs_lock to avoid racing
>                  * with relocation (btrfs_relocate_chunk) and relocation
>                  * acquires fs_info->cleaner_mutex (btrfs_relocate_block_=
group)
> -                * after acquiring fs_info->delete_unused_bgs_mutex. So w=
e
> +                * after acquiring fs_info->reclaim_bgs_lock. So we
>                  * can't hold, nor need to, fs_info->cleaner_mutex when d=
eleting
>                  * unused block groups.
>                  */
> @@ -2876,7 +2876,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
>         spin_lock_init(&fs_info->treelog_bg_lock);
>         rwlock_init(&fs_info->tree_mod_log_lock);
>         mutex_init(&fs_info->unused_bg_unpin_mutex);
> -       mutex_init(&fs_info->delete_unused_bgs_mutex);
> +       mutex_init(&fs_info->reclaim_bgs_lock);
>         mutex_init(&fs_info->reloc_mutex);
>         mutex_init(&fs_info->delalloc_root_mutex);
>         mutex_init(&fs_info->zoned_meta_io_lock);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b1bab75ec12a..a2a7f5ab0a3e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3118,7 +3118,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_inf=
o *fs_info, u64 chunk_offset)
>          * we release the path used to search the chunk/dev tree and befo=
re
>          * the current task acquires this mutex and calls us.
>          */
> -       lockdep_assert_held(&fs_info->delete_unused_bgs_mutex);
> +       lockdep_assert_held(&fs_info->reclaim_bgs_lock);
>
>         /* step one, relocate all the extents inside this chunk */
>         btrfs_scrub_pause(fs_info);
> @@ -3185,10 +3185,10 @@ static int btrfs_relocate_sys_chunks(struct btrfs=
_fs_info *fs_info)
>         key.type =3D BTRFS_CHUNK_ITEM_KEY;
>
>         while (1) {
> -               mutex_lock(&fs_info->delete_unused_bgs_mutex);
> +               mutex_lock(&fs_info->reclaim_bgs_lock);
>                 ret =3D btrfs_search_slot(NULL, chunk_root, &key, path, 0=
, 0);
>                 if (ret < 0) {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         goto error;
>                 }
>                 BUG_ON(ret =3D=3D 0); /* Corruption */
> @@ -3196,7 +3196,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_f=
s_info *fs_info)
>                 ret =3D btrfs_previous_item(chunk_root, path, key.objecti=
d,
>                                           key.type);
>                 if (ret)
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                 if (ret < 0)
>                         goto error;
>                 if (ret > 0)
> @@ -3217,7 +3217,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_f=
s_info *fs_info)
>                         else
>                                 BUG_ON(ret);
>                 }
> -               mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +               mutex_unlock(&fs_info->reclaim_bgs_lock);
>
>                 if (found_key.offset =3D=3D 0)
>                         break;
> @@ -3757,10 +3757,10 @@ static int __btrfs_balance(struct btrfs_fs_info *=
fs_info)
>                         goto error;
>                 }
>
> -               mutex_lock(&fs_info->delete_unused_bgs_mutex);
> +               mutex_lock(&fs_info->reclaim_bgs_lock);
>                 ret =3D btrfs_search_slot(NULL, chunk_root, &key, path, 0=
, 0);
>                 if (ret < 0) {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         goto error;
>                 }
>
> @@ -3774,7 +3774,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs=
_info)
>                 ret =3D btrfs_previous_item(chunk_root, path, 0,
>                                           BTRFS_CHUNK_ITEM_KEY);
>                 if (ret) {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         ret =3D 0;
>                         break;
>                 }
> @@ -3784,7 +3784,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs=
_info)
>                 btrfs_item_key_to_cpu(leaf, &found_key, slot);
>
>                 if (found_key.objectid !=3D key.objectid) {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         break;
>                 }
>
> @@ -3801,12 +3801,12 @@ static int __btrfs_balance(struct btrfs_fs_info *=
fs_info)
>
>                 btrfs_release_path(path);
>                 if (!ret) {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         goto loop;
>                 }
>
>                 if (counting) {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         spin_lock(&fs_info->balance_lock);
>                         bctl->stat.expected++;
>                         spin_unlock(&fs_info->balance_lock);
> @@ -3831,7 +3831,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs=
_info)
>                                         count_meta < bctl->meta.limit_min=
)
>                                 || ((chunk_type & BTRFS_BLOCK_GROUP_SYSTE=
M) &&
>                                         count_sys < bctl->sys.limit_min))=
 {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         goto loop;
>                 }
>
> @@ -3845,7 +3845,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs=
_info)
>                         ret =3D btrfs_may_alloc_data_chunk(fs_info,
>                                                          found_key.offset=
);
>                         if (ret < 0) {
> -                               mutex_unlock(&fs_info->delete_unused_bgs_=
mutex);
> +                               mutex_unlock(&fs_info->reclaim_bgs_lock);
>                                 goto error;
>                         } else if (ret =3D=3D 1) {
>                                 chunk_reserved =3D 1;
> @@ -3853,7 +3853,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs=
_info)
>                 }
>
>                 ret =3D btrfs_relocate_chunk(fs_info, found_key.offset);
> -               mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +               mutex_unlock(&fs_info->reclaim_bgs_lock);
>                 if (ret =3D=3D -ENOSPC) {
>                         enospc_errors++;
>                 } else if (ret =3D=3D -ETXTBSY) {
> @@ -4738,16 +4738,16 @@ int btrfs_shrink_device(struct btrfs_device *devi=
ce, u64 new_size)
>         key.type =3D BTRFS_DEV_EXTENT_KEY;
>
>         do {
> -               mutex_lock(&fs_info->delete_unused_bgs_mutex);
> +               mutex_lock(&fs_info->reclaim_bgs_lock);
>                 ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
>                 if (ret < 0) {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         goto done;
>                 }
>
>                 ret =3D btrfs_previous_item(root, path, 0, key.type);
>                 if (ret) {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         if (ret < 0)
>                                 goto done;
>                         ret =3D 0;
> @@ -4760,7 +4760,7 @@ int btrfs_shrink_device(struct btrfs_device *device=
, u64 new_size)
>                 btrfs_item_key_to_cpu(l, &key, path->slots[0]);
>
>                 if (key.objectid !=3D device->devid) {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         btrfs_release_path(path);
>                         break;
>                 }
> @@ -4769,7 +4769,7 @@ int btrfs_shrink_device(struct btrfs_device *device=
, u64 new_size)
>                 length =3D btrfs_dev_extent_length(l, dev_extent);
>
>                 if (key.offset + length <=3D new_size) {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         btrfs_release_path(path);
>                         break;
>                 }
> @@ -4785,12 +4785,12 @@ int btrfs_shrink_device(struct btrfs_device *devi=
ce, u64 new_size)
>                  */
>                 ret =3D btrfs_may_alloc_data_chunk(fs_info, chunk_offset)=
;
>                 if (ret < 0) {
> -                       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +                       mutex_unlock(&fs_info->reclaim_bgs_lock);
>                         goto done;
>                 }
>
>                 ret =3D btrfs_relocate_chunk(fs_info, chunk_offset);
> -               mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +               mutex_unlock(&fs_info->reclaim_bgs_lock);
>                 if (ret =3D=3D -ENOSPC) {
>                         failed++;
>                 } else if (ret) {
> @@ -8016,7 +8016,7 @@ static int relocating_repair_kthread(void *data)
>                 return -EBUSY;
>         }
>
> -       mutex_lock(&fs_info->delete_unused_bgs_mutex);
> +       mutex_lock(&fs_info->reclaim_bgs_lock);
>
>         /* Ensure block group still exists */
>         cache =3D btrfs_lookup_block_group(fs_info, target);
> @@ -8038,7 +8038,7 @@ static int relocating_repair_kthread(void *data)
>  out:
>         if (cache)
>                 btrfs_put_block_group(cache);
> -       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +       mutex_unlock(&fs_info->reclaim_bgs_lock);
>         btrfs_exclop_finish(fs_info);
>
>         return ret;
> --
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
