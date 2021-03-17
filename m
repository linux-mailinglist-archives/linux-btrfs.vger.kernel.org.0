Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5C233F4E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhCQQCI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 12:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhCQQCE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 12:02:04 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB3C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 09:01:43 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f12so1774037qtq.4
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=fM1T/pXlkSAG5E3acPj6bOf+ERNfIikBO84+nXxYYbo=;
        b=NytPm+Ap+jplh0bYK2rExT4KnQ9n8daafxikQsJCPJtQ6rG6BRDUCdHwqZl28izU6B
         XiW/pUR3j4qv2aY4OcJL7vzhrABVSg9gZ5Ze+J1qsQke8QnBpeg/kY7lt8mpLNLZPMDB
         mTWPoHP/wfSwT/3o1Gn7+5GqYxFwJyjAtQvMfGGaGB0AnNR4JE27240KiKW7KDv0Okuh
         pqMdJguHc8XVoAYH27CKXJOd1WDdME2uNtlwil8G4odgmDil6OQntRG9fEsyhtxmAH4w
         ESV1fWC3XYdxX0vQS8szfDgvM1z55LNwnYohfpsw0PFN+2l3erQWXxeiZpZd/csbmHSV
         9m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=fM1T/pXlkSAG5E3acPj6bOf+ERNfIikBO84+nXxYYbo=;
        b=uTVkpT9STuPG+X9FqwhkzYjnbVkKPaPEdmRWNlpJTrdTzhsDrUmyBwGsH7QYXAtUbg
         gA6LjVebTM/4XESND1pWbXKwObC5/KV0oe2wkzTsOC0CBEyBv4l3f8Qp51ssav5KiL2o
         QFgp/r6rza17U051ElcF3uC8wF5er2935iJiw2gWIdhaEwuGFiHJ7w6LvnNX86p7kWk7
         UshWDp400/PV3cH1j8E1Puzw3YpDn9SVcTgQraMI3khfWlm+PgvrOCK0LYCt1sQyzrgc
         iNDhDhWQxpqTGRPvbnEChn/4wJFDBSKrignRRRj0Sc6zy6XIwMUtvCUgxdvC/9/g/GW1
         0r/g==
X-Gm-Message-State: AOAM533TBpZYGaNo1LmpH47PpZLk8gmDeZ9uKQ6xFK7DOoM0OMfEraqy
        hWfDghUTCj8n4G75i5BjxLjSlRKp1gvv2FywhKyypkDg92sRmA==
X-Google-Smtp-Source: ABdhPJypw6HX+hfsqRVwLqU4CRJoK2mmh77HmP1Y7rIfG3tgcA2ZxN4AgaJGvLcEVpDkSCNGdbmgb+Pko70J6Ukn6n4=
X-Received: by 2002:ac8:3981:: with SMTP id v1mr4438926qte.183.1615994771049;
 Wed, 17 Mar 2021 08:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <321e2ff322469047563dfce030814d58a8632a60.1615977471.git.johannes.thumshirn@wdc.com>
In-Reply-To: <321e2ff322469047563dfce030814d58a8632a60.1615977471.git.johannes.thumshirn@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Mar 2021 15:25:59 +0000
Message-ID: <CAL3q7H6rqxFu8TUcKNbr-h73Xa66xi3tgyT5A0Vyw5z3kYhq-A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: automatically reclaim zones
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 17, 2021 at 10:40 AM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> When a file gets deleted on a zoned file system, the space freed is no
> returned back into the block group's free space, but is migrated to
> zone_unusable.
>
> As this zone_unusable space is behind the current write pointer it is not
> possible to use it for new allocations. In the current implementation a
> zone is reset once all of the block group's space is accounted as zone
> unusable.
>
> This behaviour can lead to premature ENOSPC errors on a busy file system.
>
> Instead of only reclaiming the zone once it is completely unusable,
> kick off a reclaim job once the amount of unusable bytes exceeds a user
> configurable threshold between 51% and 100%.
>
> Similar to reclaiming unused block groups, these dirty block groups are
> added to a to_reclaim list and then on a transaction commit, the reclaim
> process is triggered but after we deleted unused block groups, which will
> free space for the relocation process.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c       | 85 ++++++++++++++++++++++++++++++++++++
>  fs/btrfs/block-group.h       |  2 +
>  fs/btrfs/ctree.h             |  5 +++
>  fs/btrfs/disk-io.c           | 11 +++++
>  fs/btrfs/free-space-cache.c  |  9 +++-
>  fs/btrfs/sysfs.c             | 35 +++++++++++++++
>  fs/btrfs/volumes.c           |  2 +-
>  fs/btrfs/volumes.h           |  1 +
>  include/trace/events/btrfs.h | 12 +++++
>  9 files changed, 160 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 85077c95b4f7..7f8ea2888e4c 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1485,6 +1485,81 @@ void btrfs_mark_bg_unused(struct btrfs_block_group=
 *bg)
>         spin_unlock(&fs_info->unused_bgs_lock);
>  }
>
> +void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
> +{
> +       struct btrfs_block_group *bg;
> +       struct btrfs_space_info *space_info;
> +       int ret =3D 0;
> +
> +       if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
> +               return;
> +
> +       if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
> +               return;
> +
> +       mutex_lock(&fs_info->delete_unused_bgs_mutex);
> +       mutex_lock(&fs_info->reclaim_bgs_lock);

Could we just use delete_unused_bgs_mutex? I think you are using it
only because btrfs_relocate_chunk() asserts it's being held.

Just renaming delete_unused_bgs_mutex to a more generic name like
reclaim_bgs_lock, and just use that should work.

> +       while (!list_empty(&fs_info->reclaim_bgs)) {
> +               bg =3D list_first_entry(&fs_info->reclaim_bgs,
> +                                     struct btrfs_block_group,
> +                                     bg_list);
> +               list_del_init(&bg->bg_list);
> +
> +               space_info =3D bg->space_info;
> +               mutex_unlock(&fs_info->reclaim_bgs_lock);
> +
> +               down_write(&space_info->groups_sem);

Having a comment on why we lock groups_sem would be good to have, just
like at btrfs_delete_unused_bgs().

> +
> +               spin_lock(&bg->lock);
> +               if (bg->reserved || bg->pinned || bg->ro ||
> +                   list_is_singular(&bg->list)) {
> +                       /*
> +                        * We want to bail if we made new allocations or =
have
> +                        * outstanding allocations in this block group.  =
We do
> +                        * the ro check in case balance is currently acti=
ng on
> +                        * this block group.

Why is the list_is_singular() check there?

This was copied from the empty block group removal case -
btrfs_delete_unused_bgs(), but here I don't see why it's needed, since
we relocate rather than remove block groups.
The list_is_singular() from btrfs_delete_unused_bgs() is there to
prevent losing the raid profile for data when the last data block
group is removed (which implies not using space cache v1).

Other than that, overall it looks good.

Thanks.

> +                        */
> +                       spin_unlock(&bg->lock);
> +                       up_write(&space_info->groups_sem);
> +                       goto next;
> +               }
> +               spin_unlock(&bg->lock);
> +
> +               ret =3D inc_block_group_ro(bg, 0);
> +               up_write(&space_info->groups_sem);
> +               if (ret < 0) {
> +                       ret =3D 0;
> +                       goto next;
> +               }
> +
> +               trace_btrfs_reclaim_block_group(bg);
> +               ret =3D btrfs_relocate_chunk(fs_info, bg->start);
> +               if (ret)
> +                       btrfs_err(fs_info, "error relocating chunk %llu",
> +                                 bg->start);
> +
> +next:
> +               btrfs_put_block_group(bg);
> +               mutex_lock(&fs_info->reclaim_bgs_lock);
> +       }
> +       mutex_unlock(&fs_info->reclaim_bgs_lock);
> +       mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +       btrfs_exclop_finish(fs_info);
> +}
> +
> +void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg)
> +{
> +       struct btrfs_fs_info *fs_info =3D bg->fs_info;
> +
> +       mutex_lock(&fs_info->reclaim_bgs_lock);
> +       if (list_empty(&bg->bg_list)) {
> +               btrfs_get_block_group(bg);
> +               trace_btrfs_add_reclaim_block_group(bg);
> +               list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
> +       }
> +       mutex_unlock(&fs_info->reclaim_bgs_lock);
> +}
> +
>  static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_k=
ey *key,
>                            struct btrfs_path *path)
>  {
> @@ -3390,6 +3465,16 @@ int btrfs_free_block_groups(struct btrfs_fs_info *=
info)
>         }
>         spin_unlock(&info->unused_bgs_lock);
>
> +       mutex_lock(&info->reclaim_bgs_lock);
> +       while (!list_empty(&info->reclaim_bgs)) {
> +               block_group =3D list_first_entry(&info->reclaim_bgs,
> +                                              struct btrfs_block_group,
> +                                              bg_list);
> +               list_del_init(&block_group->bg_list);
> +               btrfs_put_block_group(block_group);
> +       }
> +       mutex_unlock(&info->reclaim_bgs_lock);
> +
>         spin_lock(&info->block_group_cache_lock);
>         while ((n =3D rb_last(&info->block_group_cache_tree)) !=3D NULL) =
{
>                 block_group =3D rb_entry(n, struct btrfs_block_group,
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 3ecc3372a5ce..e75c79676241 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -264,6 +264,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handl=
e *trans,
>                              u64 group_start, struct extent_map *em);
>  void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
>  void btrfs_mark_bg_unused(struct btrfs_block_group *bg);
> +void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
> +void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
>  int btrfs_read_block_groups(struct btrfs_fs_info *info);
>  int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_u=
sed,
>                            u64 type, u64 chunk_offset, u64 size);
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f2fd73e58ee6..f34dc1c61ce8 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -939,6 +939,9 @@ struct btrfs_fs_info {
>         struct mutex unused_bg_unpin_mutex;
>         struct mutex delete_unused_bgs_mutex;
>
> +       struct mutex reclaim_bgs_lock;
> +       struct list_head reclaim_bgs;
> +
>         /* Cached block sizes */
>         u32 nodesize;
>         u32 sectorsize;
> @@ -978,6 +981,8 @@ struct btrfs_fs_info {
>         spinlock_t treelog_bg_lock;
>         u64 treelog_bg;
>
> +       int bg_reclaim_threshold;
> +
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>         spinlock_t ref_verify_lock;
>         struct rb_root block_tree;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 41b718cfea40..defecef7296d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1815,6 +1815,13 @@ static int cleaner_kthread(void *arg)
>                  * unused block groups.
>                  */
>                 btrfs_delete_unused_bgs(fs_info);
> +
> +               /*
> +                * Reclaim block groups in the reclaim_bgs list after we =
deleted
> +                * all unused block_groups. This possibly gives us some m=
ore free
> +                * space.
> +                */
> +               btrfs_reclaim_bgs(fs_info);

Now with the cleaner kthread doing relocation, which can be a very
slow operation, we end up delaying iputs and other work delegated to
it for a very long time.
Not saying it needs to be fixed right away, perhaps it's not that bad,
I'm just not sure at the moment. We already do subvolume deletion in
this kthread, which is also a slow operation.

>  sleep:
>                 clear_and_wake_up_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info-=
>flags);
>                 if (kthread_should_park())
> @@ -2796,12 +2803,14 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_=
info)
>         mutex_init(&fs_info->reloc_mutex);
>         mutex_init(&fs_info->delalloc_root_mutex);
>         mutex_init(&fs_info->zoned_meta_io_lock);
> +       mutex_init(&fs_info->reclaim_bgs_lock);
>         seqlock_init(&fs_info->profiles_lock);
>
>         INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
>         INIT_LIST_HEAD(&fs_info->space_info);
>         INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
>         INIT_LIST_HEAD(&fs_info->unused_bgs);
> +       INIT_LIST_HEAD(&fs_info->reclaim_bgs);
>  #ifdef CONFIG_BTRFS_DEBUG
>         INIT_LIST_HEAD(&fs_info->allocated_roots);
>         INIT_LIST_HEAD(&fs_info->allocated_ebs);
> @@ -2890,6 +2899,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
>         fs_info->swapfile_pins =3D RB_ROOT;
>
>         fs_info->send_in_progress =3D 0;
> +
> +       fs_info->bg_reclaim_threshold =3D 75;
>  }
>
>  static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct supe=
r_block *sb)
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 9988decd5717..e54466fc101f 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -11,6 +11,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/error-injection.h>
>  #include <linux/sched/mm.h>
> +#include "misc.h"
>  #include "ctree.h"
>  #include "free-space-cache.h"
>  #include "transaction.h"
> @@ -2539,6 +2540,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs=
_info,
>  static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_=
group,
>                                         u64 bytenr, u64 size, bool used)
>  {
> +       struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>         struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
>         u64 offset =3D bytenr - block_group->start;
>         u64 to_free, to_unusable;
> @@ -2569,8 +2571,13 @@ static int __btrfs_add_free_space_zoned(struct btr=
fs_block_group *block_group,
>         }
>
>         /* All the region is now unusable. Mark it as unused and reclaim =
*/
> -       if (block_group->zone_unusable =3D=3D block_group->length)
> +       if (block_group->zone_unusable =3D=3D block_group->length) {
>                 btrfs_mark_bg_unused(block_group);
> +       } else if (block_group->zone_unusable >=3D
> +                  div_factor_fine(block_group->length,
> +                                  fs_info->bg_reclaim_threshold)) {
> +               btrfs_mark_bg_to_reclaim(block_group);
> +       }
>
>         return 0;
>  }
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 6eb1c50fa98c..bf38c7c6b804 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -965,6 +965,40 @@ static ssize_t btrfs_read_policy_store(struct kobjec=
t *kobj,
>  }
>  BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_s=
tore);
>
> +static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
> +                                              struct kobj_attribute *a,
> +                                              char *buf)
> +{
> +       struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
> +       ssize_t ret;
> +
> +       ret =3D scnprintf(buf, PAGE_SIZE, "%d\n", fs_info->bg_reclaim_thr=
eshold);
> +
> +       return ret;
> +}
> +
> +static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
> +                                               struct kobj_attribute *a,
> +                                               const char *buf, size_t l=
en)
> +{
> +       struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
> +       int thresh;
> +       int ret;
> +
> +       ret =3D kstrtoint(buf, 10, &thresh);
> +       if (ret)
> +               return ret;
> +
> +       if (thresh <=3D 50 || thresh > 100)
> +               return -EINVAL;
> +
> +       fs_info->bg_reclaim_threshold =3D thresh;
> +
> +       return len;
> +}
> +BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
> +             btrfs_bg_reclaim_threshold_store);
> +
>  static const struct attribute *btrfs_attrs[] =3D {
>         BTRFS_ATTR_PTR(, label),
>         BTRFS_ATTR_PTR(, nodesize),
> @@ -976,6 +1010,7 @@ static const struct attribute *btrfs_attrs[] =3D {
>         BTRFS_ATTR_PTR(, exclusive_operation),
>         BTRFS_ATTR_PTR(, generation),
>         BTRFS_ATTR_PTR(, read_policy),
> +       BTRFS_ATTR_PTR(, bg_reclaim_threshold),
>         NULL,
>  };
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 995920fcce9b..7e4c9dd8fc64 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3098,7 +3098,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *t=
rans, u64 chunk_offset)
>         return ret;
>  }
>
> -static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk=
_offset)
> +int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset=
)
>  {
>         struct btrfs_root *root =3D fs_info->chunk_root;
>         struct btrfs_trans_handle *trans;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index d4c3e0dd32b8..9c0d84e5ec06 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -484,6 +484,7 @@ void btrfs_describe_block_groups(u64 flags, char *buf=
, u32 size_buf);
>  int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info);
>  int btrfs_recover_balance(struct btrfs_fs_info *fs_info);
>  int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
> +int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset=
);
>  int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
>  int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
>  int btrfs_uuid_scan_kthread(void *data);
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 0551ea65374f..a41dd8a0c730 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -1903,6 +1903,18 @@ DEFINE_EVENT(btrfs__block_group, btrfs_add_unused_=
block_group,
>         TP_ARGS(bg_cache)
>  );
>
> +DEFINE_EVENT(btrfs__block_group, btrfs_add_reclaim_block_group,
> +       TP_PROTO(const struct btrfs_block_group *bg_cache),
> +
> +       TP_ARGS(bg_cache)
> +);
> +
> +DEFINE_EVENT(btrfs__block_group, btrfs_reclaim_block_group,
> +       TP_PROTO(const struct btrfs_block_group *bg_cache),
> +
> +       TP_ARGS(bg_cache)
> +);
> +
>  DEFINE_EVENT(btrfs__block_group, btrfs_skip_unused_block_group,
>         TP_PROTO(const struct btrfs_block_group *bg_cache),
>
> --
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
