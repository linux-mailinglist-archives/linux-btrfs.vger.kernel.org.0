Return-Path: <linux-btrfs+bounces-11672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C026A3E501
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 20:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFF8189F1A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 19:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFCF263C91;
	Thu, 20 Feb 2025 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="Pb1CA1Wx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086515A858
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079620; cv=none; b=aFzd4aYe+dXbslO8sZyfCaGXU72eN+kHVOSFVJrYNIUIxLgU4baTwucNjr47Y7Of0mNgqALcRr0VDPAMtyX+kL5FAkuSm5eOuviQK6d5kv7PoJRSVTGeEsBT+l8BrwScTkLrQxVRu4R/A4qIn4GvIkYWyo/UOkltnOniL8Xiq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079620; c=relaxed/simple;
	bh=ALOTnHo+tudpq5jexrVmmTIFvli60072NvG7MEuYc/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p53oK3u8AA34E7Ggb2iLCnMBnkBm0VQGMQ74OP4vggDtjEZMehNFlWOnM/NiPPiJ1fWn/k9zxEWeBjzOBAg+rgPWs15C/evV841IJNxWlk3+OXJN7ZPc0p5tqWZAR7frVgmXm/a58M6mGZQJpEl14orVVx7kj1YQ1ZkgZ3JERco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=Pb1CA1Wx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c665ef4cso21890075ad.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1740079618; x=1740684418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFKGe5oux0EL0S7IBkgRZU/u4fxwheGCAaMR1EHM3AA=;
        b=Pb1CA1WxNBQjnCp2eRwFJb/PHEZVz8b8NEkDLgY1UxXsgxSiLHigRQQZowLCvAY2wA
         AFFPBYzln2FOlmIqt/8YKi9Vvuxc/2nyOqpEE/nzD8UbYHxaICeIDH5ncvBWtDz9cd2f
         gpa8iF2U6TL/BZF2l/h/UdZFvovDruslAQ2opNADXMaC7yplYYCzZeaRAPepEaxoTEqD
         IpdSuUkYsNKMA4dhb/l8rnGXmrbJ4l5asklZxuP6MUvwh10cvemAyXZzYbDJIy3XbMxm
         zsptGtXJZB2dZ042mSEq0hnqFH7oPVuyXvisESThGE36Bf8MYwqPcl1Bq9tYRU9aMEwx
         6xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079618; x=1740684418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFKGe5oux0EL0S7IBkgRZU/u4fxwheGCAaMR1EHM3AA=;
        b=rZcKoqhQyXATqzRxPN7tnCuUEjy5UZt4Ib+q4DdbjH1tWe+mYo11grZ3+BxjmwxxO8
         E+sgKjHJDUWba9g8ChkpxAbwUwcrkgiSz4yjgruuuxK/wk3n9YK+1/YSWTkwRr2E58OP
         SckwzxX94q33EnXLW4nGrlqREArLKOSf/qTDvcXtK63Rfp+obMX7yMzyhce/fycjRaDx
         7TJWFfvezlao6ZeYZmB7K7tk7x9kExItm5WdOsdJy92g2ZzXdQaYC1PElOyYOfxcXHFb
         clk2ghkD/tg35/E8gClOGNF8RfU/LuUL6lK3zjAK9IkME2RzzPfPnleJpjYhSsP1W2GW
         Ws4Q==
X-Gm-Message-State: AOJu0YzxxQjPbwBrB1Kfp3cNyiO1gNLWCwnr1J1OYNky3V/Txg2jjDMd
	wA7Hkb3YFCQl/vorqfYgI30VF0CtJHi1gA8q+lVHJHl7alfKaw2wih1aIAI713d5m+iyA0N/s0X
	+l4wPvcdiwQwS36RfMIdvpIQo6GSdf6Mo98YjQQ==
X-Gm-Gg: ASbGncu9PnebXzrQWD24dzolKzBwF69tRl6Bw2z1L6qeRHK38Mgw7S37aUdGAYf/ZfB
	2ALEpASWgyfg2xNJSEQefjOIcVOvoG3HKkRfuiOhkZlNeHrW7ucOIxkQdjlvZRNLY6LJT+KU=
X-Google-Smtp-Source: AGHT+IEDsxxvjGIHah8PLp/bl700mAHHOdby8iv6BeAOe7BN3JMw78DYjIDRvq03gOKsqPCTQFdJNfsdkOrdFhhNJzw=
X-Received: by 2002:a05:6a00:9aa:b0:729:a31:892d with SMTP id
 d2e1a72fcca58-73426cb1292mr134774b3a.8.1740079617800; Thu, 20 Feb 2025
 11:26:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1660690698.git.osandov@fb.com> <1ac68be51384f9cc2433bb7979f4cda563e72976.1660690698.git.osandov@fb.com>
In-Reply-To: <1ac68be51384f9cc2433bb7979f4cda563e72976.1660690698.git.osandov@fb.com>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Thu, 20 Feb 2025 21:26:47 +0200
X-Gm-Features: AWEUYZnNxbOYYbR-w85KGOHrfGxkWrtVdrgwsarc9uRz-9TZ5utH8awsI8kYK2g
Message-ID: <CAOcd+r1BGKYVRZK5iDdK6N0sr7CuCxvmmBjzNDXhZrv2o4cRYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: get rid of block group caching progress logic
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Omar,

On Wed, Aug 17, 2022 at 2:13=E2=80=AFAM Omar Sandoval <osandov@osandov.com>=
 wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> struct btrfs_caching_ctl::progress and struct
> btrfs_block_group::last_byte_to_unpin were previously needed to ensure
> that unpin_extent_range() didn't return a range to the free space cache
> before the caching thread had a chance to cache that range. However, the
> previous commit made it so that we always synchronously cache the block
> group at the time that we pin the extent, so this machinery is no longer
> necessary.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/block-group.c     | 13 ------------
>  fs/btrfs/block-group.h     |  2 --
>  fs/btrfs/extent-tree.c     |  9 ++-------
>  fs/btrfs/free-space-tree.c |  8 --------
>  fs/btrfs/transaction.c     | 41 --------------------------------------
>  fs/btrfs/zoned.c           |  1 -
>  6 files changed, 2 insertions(+), 72 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 1af6fc395a52..68992ad9ff2a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -593,8 +593,6 @@ static int load_extent_tree_free(struct btrfs_caching=
_control *caching_ctl)
>
>                         if (need_resched() ||
>                             rwsem_is_contended(&fs_info->commit_root_sem)=
) {
> -                               if (wakeup)
> -                                       caching_ctl->progress =3D last;
>                                 btrfs_release_path(path);
>                                 up_read(&fs_info->commit_root_sem);
>                                 mutex_unlock(&caching_ctl->mutex);
> @@ -618,9 +616,6 @@ static int load_extent_tree_free(struct btrfs_caching=
_control *caching_ctl)
>                         key.objectid =3D last;
>                         key.offset =3D 0;
>                         key.type =3D BTRFS_EXTENT_ITEM_KEY;
> -
> -                       if (wakeup)
> -                               caching_ctl->progress =3D last;
>                         btrfs_release_path(path);
>                         goto next;
>                 }
> @@ -655,7 +650,6 @@ static int load_extent_tree_free(struct btrfs_caching=
_control *caching_ctl)
>
>         total_found +=3D add_new_free_space(block_group, last,
>                                 block_group->start + block_group->length)=
;
> -       caching_ctl->progress =3D (u64)-1;
>
>  out:
>         btrfs_free_path(path);
> @@ -725,8 +719,6 @@ static noinline void caching_thread(struct btrfs_work=
 *work)
>         }
>  #endif
>
> -       caching_ctl->progress =3D (u64)-1;
> -
>         up_read(&fs_info->commit_root_sem);
>         btrfs_free_excluded_extents(block_group);
>         mutex_unlock(&caching_ctl->mutex);
> @@ -755,7 +747,6 @@ int btrfs_cache_block_group(struct btrfs_block_group =
*cache, bool wait)
>         mutex_init(&caching_ctl->mutex);
>         init_waitqueue_head(&caching_ctl->wait);
>         caching_ctl->block_group =3D cache;
> -       caching_ctl->progress =3D cache->start;
>         refcount_set(&caching_ctl->count, 2);
>         btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
>
> @@ -2076,11 +2067,9 @@ static int read_one_block_group(struct btrfs_fs_in=
fo *info,
>                 /* Should not have any excluded extents. Just in case, th=
ough. */
>                 btrfs_free_excluded_extents(cache);
>         } else if (cache->length =3D=3D cache->used) {
> -               cache->last_byte_to_unpin =3D (u64)-1;
>                 cache->cached =3D BTRFS_CACHE_FINISHED;
>                 btrfs_free_excluded_extents(cache);
>         } else if (cache->used =3D=3D 0) {
> -               cache->last_byte_to_unpin =3D (u64)-1;
>                 cache->cached =3D BTRFS_CACHE_FINISHED;
>                 add_new_free_space(cache, cache->start,
>                                    cache->start + cache->length);
> @@ -2136,7 +2125,6 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_=
info)
>                 /* Fill dummy cache as FULL */
>                 bg->length =3D em->len;
>                 bg->flags =3D map->type;
> -               bg->last_byte_to_unpin =3D (u64)-1;
>                 bg->cached =3D BTRFS_CACHE_FINISHED;
>                 bg->used =3D em->len;
>                 bg->flags =3D map->type;
> @@ -2482,7 +2470,6 @@ struct btrfs_block_group *btrfs_make_block_group(st=
ruct btrfs_trans_handle *tran
>         set_free_space_tree_thresholds(cache);
>         cache->used =3D bytes_used;
>         cache->flags =3D type;
> -       cache->last_byte_to_unpin =3D (u64)-1;
>         cache->cached =3D BTRFS_CACHE_FINISHED;
>         cache->global_root_id =3D calculate_global_root_id(fs_info, cache=
->start);
>
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 9dba28bb1806..59a86e82a28e 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -63,7 +63,6 @@ struct btrfs_caching_control {
>         wait_queue_head_t wait;
>         struct btrfs_work work;
>         struct btrfs_block_group *block_group;
> -       u64 progress;
>         refcount_t count;
>  };
>
> @@ -115,7 +114,6 @@ struct btrfs_block_group {
>         /* Cache tracking stuff */
>         int cached;
>         struct btrfs_caching_control *caching_ctl;
> -       u64 last_byte_to_unpin;
>
>         struct btrfs_space_info *space_info;
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 86ac953c69ac..bcd0e72cded3 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2686,13 +2686,8 @@ static int unpin_extent_range(struct btrfs_fs_info=
 *fs_info,
>                 len =3D cache->start + cache->length - start;
>                 len =3D min(len, end + 1 - start);
>
> -               down_read(&fs_info->commit_root_sem);
> -               if (start < cache->last_byte_to_unpin && return_free_spac=
e) {
> -                       u64 add_len =3D min(len, cache->last_byte_to_unpi=
n - start);
> -
> -                       btrfs_add_free_space(cache, start, add_len);
> -               }
> -               up_read(&fs_info->commit_root_sem);
> +               if (return_free_space)
> +                       btrfs_add_free_space(cache, start, len);
>
>                 start +=3D len;
>                 total_unpinned +=3D len;
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index 1bf89aa67216..367bcfcf68f5 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1453,8 +1453,6 @@ static int load_free_space_bitmaps(struct btrfs_cac=
hing_control *caching_ctl,
>                 ASSERT(key.type =3D=3D BTRFS_FREE_SPACE_BITMAP_KEY);
>                 ASSERT(key.objectid < end && key.objectid + key.offset <=
=3D end);
>
> -               caching_ctl->progress =3D key.objectid;
> -
>                 offset =3D key.objectid;
>                 while (offset < key.objectid + key.offset) {
>                         bit =3D free_space_test_bit(block_group, path, of=
fset);
> @@ -1490,8 +1488,6 @@ static int load_free_space_bitmaps(struct btrfs_cac=
hing_control *caching_ctl,
>                 goto out;
>         }
>
> -       caching_ctl->progress =3D (u64)-1;
> -
>         ret =3D 0;
>  out:
>         return ret;
> @@ -1531,8 +1527,6 @@ static int load_free_space_extents(struct btrfs_cac=
hing_control *caching_ctl,
>                 ASSERT(key.type =3D=3D BTRFS_FREE_SPACE_EXTENT_KEY);
>                 ASSERT(key.objectid < end && key.objectid + key.offset <=
=3D end);
>
> -               caching_ctl->progress =3D key.objectid;
> -
>                 total_found +=3D add_new_free_space(block_group, key.obje=
ctid,
>                                                   key.objectid + key.offs=
et);
>                 if (total_found > CACHING_CTL_WAKE_UP) {
> @@ -1552,8 +1546,6 @@ static int load_free_space_extents(struct btrfs_cac=
hing_control *caching_ctl,
>                 goto out;
>         }
>
> -       caching_ctl->progress =3D (u64)-1;
> -
>         ret =3D 0;
>  out:
>         return ret;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 6e3b2cb6a04a..4c87bf2abc14 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -161,7 +161,6 @@ static noinline void switch_commit_roots(struct btrfs=
_trans_handle *trans)
>         struct btrfs_transaction *cur_trans =3D trans->transaction;
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         struct btrfs_root *root, *tmp;
> -       struct btrfs_caching_control *caching_ctl, *next;
>
>         /*
>          * At this point no one can be using this transaction to modify a=
ny tree
> @@ -196,46 +195,6 @@ static noinline void switch_commit_roots(struct btrf=
s_trans_handle *trans)
>         }
>         spin_unlock(&cur_trans->dropped_roots_lock);
>
> -       /*
> -        * We have to update the last_byte_to_unpin under the commit_root=
_sem,
> -        * at the same time we swap out the commit roots.
> -        *
> -        * This is because we must have a real view of the last spot the =
caching
> -        * kthreads were while caching.  Consider the following views of =
the
> -        * extent tree for a block group
> -        *
> -        * commit root
> -        * +----+----+----+----+----+----+----+
> -        * |\\\\|    |\\\\|\\\\|    |\\\\|\\\\|
> -        * +----+----+----+----+----+----+----+
> -        * 0    1    2    3    4    5    6    7
> -        *
> -        * new commit root
> -        * +----+----+----+----+----+----+----+
> -        * |    |    |    |\\\\|    |    |\\\\|
> -        * +----+----+----+----+----+----+----+
> -        * 0    1    2    3    4    5    6    7
> -        *
> -        * If the cache_ctl->progress was at 3, then we are only allowed =
to
> -        * unpin [0,1) and [2,3], because the caching thread has already
> -        * processed those extents.  We are not allowed to unpin [5,6), b=
ecause
> -        * the caching thread will re-start it's search from 3, and thus =
find
> -        * the hole from [4,6) to add to the free space cache.
> -        */
> -       write_lock(&fs_info->block_group_cache_lock);
> -       list_for_each_entry_safe(caching_ctl, next,
> -                                &fs_info->caching_block_groups, list) {
> -               struct btrfs_block_group *cache =3D caching_ctl->block_gr=
oup;
> -
> -               if (btrfs_block_group_done(cache)) {
> -                       cache->last_byte_to_unpin =3D (u64)-1;
> -                       list_del_init(&caching_ctl->list);
> -                       btrfs_put_caching_control(caching_ctl);
Now the caching_ctl is not removed from fs_info->caching_block_groups,
and remains there until close_ctree(). So eventually it will be
removed, but for now just occupying memory. Is this intended?

> -               } else {
> -                       cache->last_byte_to_unpin =3D caching_ctl->progre=
ss;
> -               }
> -       }
> -       write_unlock(&fs_info->block_group_cache_lock);
>         up_write(&fs_info->commit_root_sem);
>  }
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 61ae58c3a354..56a147a6e571 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1558,7 +1558,6 @@ void btrfs_calc_zone_unusable(struct btrfs_block_gr=
oup *cache)
>         free =3D cache->zone_capacity - cache->alloc_offset;
>
>         /* We only need ->free_space in ALLOC_SEQ block groups */
> -       cache->last_byte_to_unpin =3D (u64)-1;
>         cache->cached =3D BTRFS_CACHE_FINISHED;
>         cache->free_space_ctl->free_space =3D free;
>         cache->zone_unusable =3D unusable;
> --
> 2.37.2
>

Thanks,
Alex.

