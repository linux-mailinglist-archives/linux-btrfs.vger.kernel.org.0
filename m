Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F830345B7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 10:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCWJ6R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCWJ5m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 05:57:42 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE5EC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Mar 2021 02:57:41 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id h3so10129618qvh.8
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Mar 2021 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7RUmMMKMvtMWfQbwg8odMyvgb1AfJLVuqMX7brhhJzw=;
        b=aQ1zr2rkzote3VUnFtr9PLRxRk5PcH07lmwlmTyA8O7SXA8yzEP6mBXAXuYyPS2+Wr
         2s3M4NNgA7rh7Is54qYeuB+xSEcsOdNyxrq6XFp2e8IQoTP3e7lmvdK8fzaIo3RrmKw/
         j/AJSE8mbeuaU0/+l+ag11WsZdbB2qIxVm1MhzXqRFrf6tcmooKDFrCvryvDt9cTBroC
         G6yYUK85wqesUZmjDSsR0bukDmpzYPFT70FKwP5+ZaF33V2EDZfZw+KS6hOkpVC32YFg
         48wG9TZwUrAZxuIGHTx96V/S66ZDT6pIUyFzd4gh3NcWYSEJxW9WTTe/+tUxRCDp7VZM
         8/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7RUmMMKMvtMWfQbwg8odMyvgb1AfJLVuqMX7brhhJzw=;
        b=G+0Sq1rN+c3YF1Cv5MecyiVeQ7lXHCwAKcb96hoVqcs8E0PJdOPDACyregAQLa8Cyh
         C+Ej/EQvmRkWTnqZFSaqOK4lzCE/7wWHMSiUGncuyok2fFIIaR3JxpZzYE5tfwIqT43D
         V8rk+cTQE12xEY9IsTCwDD2YY17VxwqHnmlmjZBBJJTkMCWfEj3/T2x4uDzmbgUNjeRa
         IHA5y+p5liRXUfuHwZMWXUnE2SzafQbgzBwKKFgoLSlniVEBGTpvETjLPeaWG7fKi+D6
         3Ex3cWLAicTGD4yY9rBdFKYWUbOOStCH/2xazcvyNP/5+u+35pldD4mVnc6qlZbXiDH0
         u6Ww==
X-Gm-Message-State: AOAM533RTPSFqx5MGSgsQKPgXcPaqeQlAat7/Pu8jXq+Ll+RaAzqAeMT
        eqhzqdGSGSeTREtqbCDQMjp/8OK5Tqr6rXr1ZPRZvBXvLmk=
X-Google-Smtp-Source: ABdhPJyGd1YiRhFmJKyediJfpTK/ec7IyNBV0G5bpmxcD5AlW2Kfaj8tvTWr/B5TQH7duQ92OY6Ww7EAamauyINk/hI=
X-Received: by 2002:a0c:a1c2:: with SMTP id e60mr3968509qva.41.1616493460953;
 Tue, 23 Mar 2021 02:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616149060.git.johannes.thumshirn@wdc.com> <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
In-Reply-To: <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 23 Mar 2021 09:57:29 +0000
Message-ID: <CAL3q7H6ocp=t_-gdhbTVNiZCeTRRfFFm=F0j7g197qjKp+JzUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs: zoned: automatically reclaim zones
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 19, 2021 at 10:52 AM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> When a file gets deleted on a zoned file system, the space freed is not
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
> configurable threshold between 51% and 100%. It can be set per mounted
> filesystem via the sysfs tunable bg_reclaim_threshold which is set to 75%
> per default.
>
> Similar to reclaiming unused block groups, these dirty block groups are
> added to a to_reclaim list and then on a transaction commit, the reclaim
> process is triggered but after we deleted unused block groups, which will
> free space for the relocation process.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>
> AFAICT sysfs_create_files() does not have the ability to provide a is_vis=
ible
> callback, so the bg_reclaim_threshold sysfs file is visible for non zoned
> filesystems as well, even though only for zoned filesystems we're adding =
block
> groups to the reclaim list. I'm all ears for a approach that is sensible =
in
> this regard.
>
>
>  fs/btrfs/block-group.c       | 84 ++++++++++++++++++++++++++++++++++++
>  fs/btrfs/block-group.h       |  2 +
>  fs/btrfs/ctree.h             |  3 ++
>  fs/btrfs/disk-io.c           | 11 +++++
>  fs/btrfs/free-space-cache.c  |  9 +++-
>  fs/btrfs/sysfs.c             | 35 +++++++++++++++
>  fs/btrfs/volumes.c           |  2 +-
>  fs/btrfs/volumes.h           |  1 +
>  include/trace/events/btrfs.h | 12 ++++++
>  9 files changed, 157 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 9ae3ac96a521..af9026795ddd 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1485,6 +1485,80 @@ void btrfs_mark_bg_unused(struct btrfs_block_group=
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
> +       mutex_lock(&fs_info->reclaim_bgs_lock);
> +       while (!list_empty(&fs_info->reclaim_bgs)) {
> +               bg =3D list_first_entry(&fs_info->reclaim_bgs,
> +                                     struct btrfs_block_group,
> +                                     bg_list);
> +               list_del_init(&bg->bg_list);
> +
> +               space_info =3D bg->space_info;
> +               mutex_unlock(&fs_info->reclaim_bgs_lock);
> +
> +               /* Don't want to race with allocators so take the groups_=
sem */
> +               down_write(&space_info->groups_sem);
> +
> +               spin_lock(&bg->lock);
> +               if (bg->reserved || bg->pinned || bg->ro) {
> +                       /*
> +                        * We want to bail if we made new allocations or =
have
> +                        * outstanding allocations in this block group.  =
We do
> +                        * the ro check in case balance is currently acti=
ng on
> +                        * this block group.
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
> +               btrfs_info(fs_info, "reclaiming chunk %llu", bg->start);
> +               trace_btrfs_reclaim_block_group(bg);
> +               ret =3D btrfs_relocate_chunk(fs_info, bg->start);

I think you forgot to test this with lockdep enabled, it should have
complained loudly otherwise.

btrfs_relocate_chunk() calls lockdep_assert_head() to verify we are
holding fs_info->reclaim_bgs_lock,
but we just unlocked it.

Thanks.



> +               if (ret)
> +                       btrfs_err(fs_info, "error relocating chunk %llu",
> +                                 bg->start);
> +
> +next:
> +               btrfs_put_block_group(bg);
> +               mutex_lock(&fs_info->reclaim_bgs_lock);
> +       }
> +       mutex_unlock(&fs_info->reclaim_bgs_lock);
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
> @@ -3390,6 +3464,16 @@ int btrfs_free_block_groups(struct btrfs_fs_info *=
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
> index 34ec82d6df3e..0b438b97fed4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -938,6 +938,7 @@ struct btrfs_fs_info {
>         struct list_head unused_bgs;
>         struct mutex unused_bg_unpin_mutex;
>         struct mutex reclaim_bgs_lock;
> +       struct list_head reclaim_bgs;
>
>         /* Cached block sizes */
>         u32 nodesize;
> @@ -978,6 +979,8 @@ struct btrfs_fs_info {
>         spinlock_t treelog_bg_lock;
>         u64 treelog_bg;
>
> +       int bg_reclaim_threshold;
> +
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>         spinlock_t ref_verify_lock;
>         struct rb_root block_tree;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f9250f14fc1e..d4fccf113df1 100644
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
>  sleep:
>                 clear_and_wake_up_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info-=
>flags);
>                 if (kthread_should_park())
> @@ -2797,12 +2804,14 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_=
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
> @@ -2891,6 +2900,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
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
> index fb785ff53a27..c78b5ce49d47 100644
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
