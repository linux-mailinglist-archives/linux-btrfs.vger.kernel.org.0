Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8910EA16
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 13:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLBMbt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 07:31:49 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37648 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBMbs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 07:31:48 -0500
Received: by mail-vs1-f66.google.com with SMTP id x18so8808425vsq.4
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 04:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=SnChGTuHk2N5SKueSCaHTov7fdmMtNcF5qHDcKO7t10=;
        b=RnNJS2XBEp6BtXSkk5D735iSEuL5oa8p/SQnWmui9n0Y7KFIv3rnbbtbqxzXuytlwF
         bh0Qu39Tt6gxF48l2CcCqz2lHjqHkMAcfKPTN5Qvi1LwttyG6MNEGjFYjLdHHhlQ2Tdu
         l0SuXSHQyr0UtPsMxY8kuwbmAZbi4bWRtyFGWngIfwrTqNgODLqcscNqteaNLKb4VUVx
         mwQ0MNPvQloJ3SJrtIqZqLViOqdTtWdqZfj+58SwH0a8LuqMPUiY/+8tsd4tR0YCXvoM
         VjEUg4TsrKvchUoGEpjHuuo/zgRj4b8MeCLtqUOC1gte8/w1UfE01uyqT+lI0VwkdChP
         8NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=SnChGTuHk2N5SKueSCaHTov7fdmMtNcF5qHDcKO7t10=;
        b=HoHsCxmrlvQmBH2Kl2oHhVhKX7RBMmDxrOkAWA6b/CHUcn3qi+oF75M5wmMRvP3TK/
         motAa3REStDl4fAFQPMYFraF3iPB3GkOpkLx7WKu388JsOmFS+2jbE7zNUzNBxIOhIrb
         R1XS0OuPCMHCrQnOUW+5BBR88NfGrrpXvAybnB0Aq/s+TX3aQFyPq7PgrFAEnE3e7Baq
         EfiOgvOgcafykS4eosXiAJS4QJBVpuNWh1NcurmPkPTaSIg8vJubIZ+GHQJsPbREyunr
         ZzgyXaog++f2ypDSFKbZTJh2csfO2QFn4lTuWTTiHNyliIarDz9mD1IEDG0Ac2JRqSFE
         YVwA==
X-Gm-Message-State: APjAAAXiLIxuTcS9yMwawrG/haX6kx4U6/UZHFAIyXyAh/JWYPC/t2UJ
        yRA06QddPtyxhMVrB1gpdyAgri8b+Y9NVkRHho9Dpwn5
X-Google-Smtp-Source: APXvYqybXAGkHMHh1Uin1IHLUw6KMqJXrXK5v/xAi8YZkLCEb1yuD5l3tY/ZAWNcPZjpyywiQ37FqJjeHz6M5CD1Gx0=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr10176286vsq.206.1575289905688;
 Mon, 02 Dec 2019 04:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20191202070235.33099-1-wqu@suse.com>
In-Reply-To: <20191202070235.33099-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 2 Dec 2019 12:31:34 +0000
Message-ID: <CAL3q7H5xSHHgSsXU=S1pspy6hmTSzgUuD83eDEsL=2KLjU5Q2Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: relocation: Allow 'btrfs balance cancel' to return quicker
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 2, 2019 at 7:04 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [PROBLEM]
> There are quite some users reporting that 'btrfs balance cancel' slow to
> cancel current running balance, or even doesn't work for certain dead
> balance loop.
>
> With the following script showing how long it takes to fully stop a
> balance:
>   #!/bin/bash
>   dev=3D/dev/test/test
>   mnt=3D/mnt/btrfs
>
>   umount $mnt &> /dev/null
>   umount $dev &> /dev/null
>
>   mkfs.btrfs -f $dev
>   mount $dev -o nospace_cache $mnt
>
>   dd if=3D/dev/zero bs=3D1M of=3D$mnt/large &
>   dd_pid=3D$!
>
>   sleep 3
>   kill -KILL $dd_pid
>   sync
>
>   btrfs balance start --bg --full $mnt &
>   sleep 1
>
>   echo "cancel request" >> /dev/kmsg
>   time btrfs balance cancel $mnt
>   umount $mnt
>
> It takes around 7~10s to cancel the running balance in my test
> environment.
>
> [CAUSE]
> Btrfs uses btrfs_fs_info::balance_cancel_req to record how many cancel
> request are queued.
>
> And btrfs checks this value only in the following call sites:
> btrfs_balance()
> |- atomic_read(&fs_info->balance_cancel_req); <<< 1
> |- __btrfs_balance()
>    |- while (1) {
>    |  /* Per chunk iteration */
>    |-    atomic_read(&fs_info->balance_cancel_req); <<< 2
>
> The first check is near useless, as it happens at the very beginning of
> balance, thus it's too rare to hit.
>
> The sencond check is the most common hit, but it's too slow, only hit
> after each chunk get relocated.
>
> For certain bug reports, like "Found 1 extents" loop where we are
> dead-looping inside btrfs_relocate_block_group(), it's useless.
>
> [FIX]
> This patch will introduce more cancel check at the following call sites:
> btrfs_balance()
> |- __btrfs_balance()
>    |- btrfs_relocate_block_group()
>       |- while (1) { /* Per relocation-stage loop, 2~3 runs */
>       |-    should_cancel_balance()     <<< 1
>       |-    balance_block_group()
>       |- }
>
> /* Call site 1 workaround dead balance loop */
> Call site 1 will allow user to workaround the mentioned dead balance
> loop by properly canceling it.
>
> balance_block_group()
> |- while (1) { /* Per-extent iteration */
> |-    relocate_data_extent()
> |     |- relocate_file_extent_cluster()
> |        |- should_cancel_balance()     <<< 2
> |-    should_cancel_balance()           <<< 3
> |- }
> |- relocate_file_extent_cluster()
>
> /* Call site 2 for data heavy relocation */
> As we spend a lot of time doing page reading for data relocation, such
> check can make exit much quicker for data relocation.
> This check has a bytes based filter (every 32M) to prevent wasting too
> much CPU time checking it.

You really think (or observed) that reading an atomic is that much cpu
intensive?

Given the context where this is used, I would say to keep it simple
and do check after after each page -
the amount of work we do for each page is at least an order of
magnitude heavier then reading an atomic.

>
> /* Call site 3 for meta heavy relocation */
> The check has a nr_extent based filter (every 256 extents) to prevent
> wasting too much CPU time.

Same comment as before.

>
> /* Error injection to do full coverage test */
> This patch packs the regular atomic_read() into a separate function,
> should_cancel_balance() to allow error injection.
> So we can do a full coverage test.

I suppose I would do that separately (as in a separate patch). Not
sure if it's that useful to it, despite probably having been useful
for your testing/debugging.
Anyway, that may very well be subjective.

Other than that it looks good to me.
Thanks.

>
> With this patch, the response time has reduced from 7~10s to 0.5~1.5s for
> data relocation.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h      |  1 +
>  fs/btrfs/relocation.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.c    |  6 +++---
>  3 files changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b2e8fd8a8e59..a712c18d2da2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3352,6 +3352,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_=
snapshot *pending,
>                               u64 *bytes_to_reserve);
>  int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
>                               struct btrfs_pending_snapshot *pending);
> +int should_cancel_balance(struct btrfs_fs_info *fs_info);
>
>  /* scrub.c */
>  int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d897a8e5e430..c42616750e4b 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -9,6 +9,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/rbtree.h>
>  #include <linux/slab.h>
> +#include <linux/error-injection.h>
>  #include "ctree.h"
>  #include "disk-io.h"
>  #include "transaction.h"
> @@ -3223,6 +3224,16 @@ int setup_extent_mapping(struct inode *inode, u64 =
start, u64 end,
>         return ret;
>  }
>
> +int should_cancel_balance(struct btrfs_fs_info *fs_info)
> +{
> +       return atomic_read(&fs_info->balance_cancel_req);
> +}
> +/* Allow us to do error injection test to cover all cancel exit branches=
 */
> +ALLOW_ERROR_INJECTION(should_cancel_balance, TRUE);
> +
> +/* Thresholds of when to check if the balance is canceled */
> +#define RELOC_CHECK_INTERVAL_NR_EXTENTS                (256)
> +#define RELOC_CHECK_INTERVAL_BYTES             (SZ_32M)
>  static int relocate_file_extent_cluster(struct inode *inode,
>                                         struct file_extent_cluster *clust=
er)
>  {
> @@ -3230,6 +3241,7 @@ static int relocate_file_extent_cluster(struct inod=
e *inode,
>         u64 page_start;
>         u64 page_end;
>         u64 offset =3D BTRFS_I(inode)->index_cnt;
> +       u64 checked_bytes =3D 0;
>         unsigned long index;
>         unsigned long last_index;
>         struct page *page;
> @@ -3344,6 +3356,14 @@ static int relocate_file_extent_cluster(struct ino=
de *inode,
>                 btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE)=
;
>                 balance_dirty_pages_ratelimited(inode->i_mapping);
>                 btrfs_throttle(fs_info);
> +
> +               checked_bytes +=3D PAGE_SIZE;
> +               if (checked_bytes >=3D RELOC_CHECK_INTERVAL_BYTES &&
> +                   should_cancel_balance(fs_info)) {
> +                       ret =3D -ECANCELED;
> +                       goto out;
> +               }
> +               checked_bytes %=3D RELOC_CHECK_INTERVAL_BYTES;
>         }
>         WARN_ON(nr !=3D cluster->nr);
>  out:
> @@ -4016,7 +4036,10 @@ static noinline_for_stack int relocate_block_group=
(struct reloc_control *rc)
>         struct btrfs_path *path;
>         struct btrfs_extent_item *ei;
>         u64 flags;
> +       u64 checked_bytes =3D 0;
> +       u64 checked_nr_extents =3D 0;
>         u32 item_size;
> +       u32 extent_size;
>         int ret;
>         int err =3D 0;
>         int progress =3D 0;
> @@ -4080,11 +4103,14 @@ static noinline_for_stack int relocate_block_grou=
p(struct reloc_control *rc)
>                 }
>
>                 if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
> +                       extent_size =3D fs_info->nodesize;
>                         ret =3D add_tree_block(rc, &key, path, &blocks);
>                 } else if (rc->stage =3D=3D UPDATE_DATA_PTRS &&
>                            (flags & BTRFS_EXTENT_FLAG_DATA)) {
> +                       extent_size =3D key.offset;
>                         ret =3D add_data_references(rc, &key, path, &bloc=
ks);
>                 } else {
> +                       extent_size =3D key.offset;
>                         btrfs_release_path(path);
>                         ret =3D 0;
>                 }
> @@ -4125,6 +4151,17 @@ static noinline_for_stack int relocate_block_group=
(struct reloc_control *rc)
>                                 break;
>                         }
>                 }
> +               checked_bytes +=3D extent_size;
> +               checked_nr_extents++;
> +
> +               if ((checked_bytes >=3D RELOC_CHECK_INTERVAL_BYTES ||
> +                    checked_nr_extents >=3D RELOC_CHECK_INTERVAL_NR_EXTE=
NTS) &&
> +                   should_cancel_balance(fs_info)) {
> +                       err =3D -ECANCELED;
> +                       break;
> +               }
> +               checked_bytes %=3D RELOC_CHECK_INTERVAL_BYTES;
> +               checked_nr_extents %=3D RELOC_CHECK_INTERVAL_NR_EXTENTS;
>         }
>         if (trans && progress && err =3D=3D -ENOSPC) {
>                 ret =3D btrfs_force_chunk_alloc(trans, rc->block_group->f=
lags);
> @@ -4365,6 +4402,10 @@ int btrfs_relocate_block_group(struct btrfs_fs_inf=
o *fs_info, u64 group_start)
>                                  rc->block_group->length);
>
>         while (1) {
> +               if (should_cancel_balance(fs_info)) {
> +                       err=3D -ECANCELED;
> +                       goto out;
> +               }
>                 mutex_lock(&fs_info->cleaner_mutex);
>                 ret =3D relocate_block_group(rc);
>                 mutex_unlock(&fs_info->cleaner_mutex);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d8e5560db285..afa3ed1b066d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3505,7 +3505,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs=
_info)
>
>         while (1) {
>                 if ((!counting && atomic_read(&fs_info->balance_pause_req=
)) ||
> -                   atomic_read(&fs_info->balance_cancel_req)) {
> +                   should_cancel_balance(fs_info)) {
>                         ret =3D -ECANCELED;
>                         goto error;
>                 }
> @@ -3670,7 +3670,7 @@ static int alloc_profile_is_valid(u64 flags, int ex=
tended)
>  static inline int balance_need_close(struct btrfs_fs_info *fs_info)
>  {
>         /* cancel requested || normal exit path */
> -       return atomic_read(&fs_info->balance_cancel_req) ||
> +       return should_cancel_balance(fs_info) ||
>                 (atomic_read(&fs_info->balance_pause_req) =3D=3D 0 &&
>                  atomic_read(&fs_info->balance_cancel_req) =3D=3D 0);
>  }
> @@ -3856,7 +3856,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>
>         if (btrfs_fs_closing(fs_info) ||
>             atomic_read(&fs_info->balance_pause_req) ||
> -           atomic_read(&fs_info->balance_cancel_req)) {
> +           should_cancel_balance(fs_info)) {
>                 ret =3D -EINVAL;
>                 goto out;
>         }
> --
> 2.24.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
