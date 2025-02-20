Return-Path: <linux-btrfs+bounces-11675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F1A3E729
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 23:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EC019C18A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 22:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7FC264631;
	Thu, 20 Feb 2025 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="r2c9sB9S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68F264620
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088786; cv=none; b=M15y2aokzYr29RhwMt7xzBSQj/385ruSKS9Zs4iP/4oZ70YsDtMiYm09z9maXiXTsA9cVwCFFXRnOhM6FBGiEvCzdSy7VnmMBbR82gRtE5zsVQvcayTkf7yfuPlw5p1I+o3ZuMD9cdAqyJmSFJmLnGWZfpaMLcICePzI/7HHsSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088786; c=relaxed/simple;
	bh=v/4DfAOcw5eVDTYHCQHmdHwkIJdbEeRnvOCqrWCkhvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJkOn02GiNXlqEpww9Jv1UAs5KnsYVG9ftl02ggwtqo49k/Ju/BVDIb+3rTpFXGrL0HcNxnVcsqaQyrb8rDYruE9ASZQ3V9JsYKnuh3g4wpgKMcGxboBn/PI+yjgWy41DD279kjcw00fo5xu4d2g0w/gAHLLHXvUwSdMMvg2ISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=r2c9sB9S; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa8c788c74so361972a91.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 13:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1740088784; x=1740693584; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ImN4lCR7ZIbg1unpaXk1ouiQnvCbRSxh/bAjoNFaL9s=;
        b=r2c9sB9SwezIQ0lNC4MW0Sf3eIDkKubrr9SeuXlVu0L2rtxZLwwgzZ7qa5aP+X9Q7S
         CJ5/prAim5/A5x35KEqVKY5vjVyDxn7cIOYI82ucBUZTdA5HPyLZVI/oXBAKFxdP+THs
         uP5RDhI6UbdI5eE/KIJU3KPUE3v95lqh27jUZKBhJhhb7sTDmlC6EeoE7bESvo3XMSMX
         CoeyKSk6S0NEckA4BunEMcx3GD2w7lb3ZmblCzMJfMNZKMGMZ5wG29yYDzZnjEOOK+HV
         E2ix/7Q3QKaxo03c+c9iguGlhAza9iMkWmlibX6n6joGunz4GFTwbcoJMTSQwi0ueYwl
         TlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740088784; x=1740693584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImN4lCR7ZIbg1unpaXk1ouiQnvCbRSxh/bAjoNFaL9s=;
        b=vkJr+4WlqMCMysJNW7H2iYjFve4RyWZPOSUmqcAzrmJTvIW+AJkTlLvrQFhb/6Au1N
         T4skCeEbB0K7+IA2QrQyI4Lq73zX4pAFf+9Wem2Ndo7nGdT1dyDF44qfHjkeAkJBsib7
         MOpgWswntF4fZvTKhD0SfSxq7ZY5JYsJIAamO/Q7pBVr1LjJ9L9oSc9JNcA91cH4msBe
         /7rNJHMCzh3vfk0fq9t3lS42oPJEd5NGzz+8JhTdNpubGOpgvd3ewwyt5oWxwu7PG2le
         bRPIzeU6+utbKPx3cVx5u2nC4pM1eTXTlY90lcOtE3Qs1KlvbJz7+rD7LdSSdJWOVLat
         7wcQ==
X-Gm-Message-State: AOJu0Yzo2MGMBnOWFK2xyxqH3NcYWbthl16DI+9Okecx+vEC3bxY6nkX
	uB0zpfZ44snGrlymNZeXEtECwpvsilSRWYaoeQllLvKiIQj/1yChh9OkNzafp7M=
X-Gm-Gg: ASbGnctDe5k1hkQEqKQFzeZlsgCQHXhUAnoGVsuMDBd/mxDRw/wIer5WN9tZEU0flET
	94UebTg5stIHyePO2Tv7OKAURJ5QRUv6535BIdBf1eWHwzxbE3a2zhtBfA9/p1hvi84+PhMDiUQ
	IO/pmyKvpMpxenvfW07HizM2TUXkv3ULQUfez1hPJWtoCIk2SDBtpV9CXm2fVx5jJsLlyh4cYd3
	1BHVNDqiQN/QYMFmqTfM1YUw4d3bX4jDjs9z9oc+0n4PBlcR9XaWwv2DXz18X2CwB4beeMHhA==
X-Google-Smtp-Source: AGHT+IFuHfnxTZY1vxbbJ5Et64rQq/usrbCq18b0D6Ibt9k5Wpl0PYnxcDK4+DWNoCJS2D31tGW+dQ==
X-Received: by 2002:a05:6a00:88f:b0:726:380a:282f with SMTP id d2e1a72fcca58-73426c843ffmr349809b3a.2.1740088783905;
        Thu, 20 Feb 2025 13:59:43 -0800 (PST)
Received: from telecaster ([2620:10d:c090:400::5:905a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546835sm14332466b3a.35.2025.02.20.13.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:59:43 -0800 (PST)
Date: Thu, 20 Feb 2025 13:59:42 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Alex Lyakas <alex.lyakas@zadara.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: get rid of block group caching progress logic
Message-ID: <Z7elzqQqFb_YUO_J@telecaster>
References: <cover.1660690698.git.osandov@fb.com>
 <1ac68be51384f9cc2433bb7979f4cda563e72976.1660690698.git.osandov@fb.com>
 <CAOcd+r1BGKYVRZK5iDdK6N0sr7CuCxvmmBjzNDXhZrv2o4cRYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOcd+r1BGKYVRZK5iDdK6N0sr7CuCxvmmBjzNDXhZrv2o4cRYA@mail.gmail.com>

On Thu, Feb 20, 2025 at 09:26:47PM +0200, Alex Lyakas wrote:
> Hi Omar,
> 
> On Wed, Aug 17, 2022 at 2:13 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > struct btrfs_caching_ctl::progress and struct
> > btrfs_block_group::last_byte_to_unpin were previously needed to ensure
> > that unpin_extent_range() didn't return a range to the free space cache
> > before the caching thread had a chance to cache that range. However, the
> > previous commit made it so that we always synchronously cache the block
> > group at the time that we pin the extent, so this machinery is no longer
> > necessary.
> >
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/block-group.c     | 13 ------------
> >  fs/btrfs/block-group.h     |  2 --
> >  fs/btrfs/extent-tree.c     |  9 ++-------
> >  fs/btrfs/free-space-tree.c |  8 --------
> >  fs/btrfs/transaction.c     | 41 --------------------------------------
> >  fs/btrfs/zoned.c           |  1 -
> >  6 files changed, 2 insertions(+), 72 deletions(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 1af6fc395a52..68992ad9ff2a 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -593,8 +593,6 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
> >
> >                         if (need_resched() ||
> >                             rwsem_is_contended(&fs_info->commit_root_sem)) {
> > -                               if (wakeup)
> > -                                       caching_ctl->progress = last;
> >                                 btrfs_release_path(path);
> >                                 up_read(&fs_info->commit_root_sem);
> >                                 mutex_unlock(&caching_ctl->mutex);
> > @@ -618,9 +616,6 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
> >                         key.objectid = last;
> >                         key.offset = 0;
> >                         key.type = BTRFS_EXTENT_ITEM_KEY;
> > -
> > -                       if (wakeup)
> > -                               caching_ctl->progress = last;
> >                         btrfs_release_path(path);
> >                         goto next;
> >                 }
> > @@ -655,7 +650,6 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
> >
> >         total_found += add_new_free_space(block_group, last,
> >                                 block_group->start + block_group->length);
> > -       caching_ctl->progress = (u64)-1;
> >
> >  out:
> >         btrfs_free_path(path);
> > @@ -725,8 +719,6 @@ static noinline void caching_thread(struct btrfs_work *work)
> >         }
> >  #endif
> >
> > -       caching_ctl->progress = (u64)-1;
> > -
> >         up_read(&fs_info->commit_root_sem);
> >         btrfs_free_excluded_extents(block_group);
> >         mutex_unlock(&caching_ctl->mutex);
> > @@ -755,7 +747,6 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
> >         mutex_init(&caching_ctl->mutex);
> >         init_waitqueue_head(&caching_ctl->wait);
> >         caching_ctl->block_group = cache;
> > -       caching_ctl->progress = cache->start;
> >         refcount_set(&caching_ctl->count, 2);
> >         btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
> >
> > @@ -2076,11 +2067,9 @@ static int read_one_block_group(struct btrfs_fs_info *info,
> >                 /* Should not have any excluded extents. Just in case, though. */
> >                 btrfs_free_excluded_extents(cache);
> >         } else if (cache->length == cache->used) {
> > -               cache->last_byte_to_unpin = (u64)-1;
> >                 cache->cached = BTRFS_CACHE_FINISHED;
> >                 btrfs_free_excluded_extents(cache);
> >         } else if (cache->used == 0) {
> > -               cache->last_byte_to_unpin = (u64)-1;
> >                 cache->cached = BTRFS_CACHE_FINISHED;
> >                 add_new_free_space(cache, cache->start,
> >                                    cache->start + cache->length);
> > @@ -2136,7 +2125,6 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
> >                 /* Fill dummy cache as FULL */
> >                 bg->length = em->len;
> >                 bg->flags = map->type;
> > -               bg->last_byte_to_unpin = (u64)-1;
> >                 bg->cached = BTRFS_CACHE_FINISHED;
> >                 bg->used = em->len;
> >                 bg->flags = map->type;
> > @@ -2482,7 +2470,6 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
> >         set_free_space_tree_thresholds(cache);
> >         cache->used = bytes_used;
> >         cache->flags = type;
> > -       cache->last_byte_to_unpin = (u64)-1;
> >         cache->cached = BTRFS_CACHE_FINISHED;
> >         cache->global_root_id = calculate_global_root_id(fs_info, cache->start);
> >
> > diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> > index 9dba28bb1806..59a86e82a28e 100644
> > --- a/fs/btrfs/block-group.h
> > +++ b/fs/btrfs/block-group.h
> > @@ -63,7 +63,6 @@ struct btrfs_caching_control {
> >         wait_queue_head_t wait;
> >         struct btrfs_work work;
> >         struct btrfs_block_group *block_group;
> > -       u64 progress;
> >         refcount_t count;
> >  };
> >
> > @@ -115,7 +114,6 @@ struct btrfs_block_group {
> >         /* Cache tracking stuff */
> >         int cached;
> >         struct btrfs_caching_control *caching_ctl;
> > -       u64 last_byte_to_unpin;
> >
> >         struct btrfs_space_info *space_info;
> >
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 86ac953c69ac..bcd0e72cded3 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -2686,13 +2686,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
> >                 len = cache->start + cache->length - start;
> >                 len = min(len, end + 1 - start);
> >
> > -               down_read(&fs_info->commit_root_sem);
> > -               if (start < cache->last_byte_to_unpin && return_free_space) {
> > -                       u64 add_len = min(len, cache->last_byte_to_unpin - start);
> > -
> > -                       btrfs_add_free_space(cache, start, add_len);
> > -               }
> > -               up_read(&fs_info->commit_root_sem);
> > +               if (return_free_space)
> > +                       btrfs_add_free_space(cache, start, len);
> >
> >                 start += len;
> >                 total_unpinned += len;
> > diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> > index 1bf89aa67216..367bcfcf68f5 100644
> > --- a/fs/btrfs/free-space-tree.c
> > +++ b/fs/btrfs/free-space-tree.c
> > @@ -1453,8 +1453,6 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
> >                 ASSERT(key.type == BTRFS_FREE_SPACE_BITMAP_KEY);
> >                 ASSERT(key.objectid < end && key.objectid + key.offset <= end);
> >
> > -               caching_ctl->progress = key.objectid;
> > -
> >                 offset = key.objectid;
> >                 while (offset < key.objectid + key.offset) {
> >                         bit = free_space_test_bit(block_group, path, offset);
> > @@ -1490,8 +1488,6 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
> >                 goto out;
> >         }
> >
> > -       caching_ctl->progress = (u64)-1;
> > -
> >         ret = 0;
> >  out:
> >         return ret;
> > @@ -1531,8 +1527,6 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
> >                 ASSERT(key.type == BTRFS_FREE_SPACE_EXTENT_KEY);
> >                 ASSERT(key.objectid < end && key.objectid + key.offset <= end);
> >
> > -               caching_ctl->progress = key.objectid;
> > -
> >                 total_found += add_new_free_space(block_group, key.objectid,
> >                                                   key.objectid + key.offset);
> >                 if (total_found > CACHING_CTL_WAKE_UP) {
> > @@ -1552,8 +1546,6 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
> >                 goto out;
> >         }
> >
> > -       caching_ctl->progress = (u64)-1;
> > -
> >         ret = 0;
> >  out:
> >         return ret;
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 6e3b2cb6a04a..4c87bf2abc14 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -161,7 +161,6 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
> >         struct btrfs_transaction *cur_trans = trans->transaction;
> >         struct btrfs_fs_info *fs_info = trans->fs_info;
> >         struct btrfs_root *root, *tmp;
> > -       struct btrfs_caching_control *caching_ctl, *next;
> >
> >         /*
> >          * At this point no one can be using this transaction to modify any tree
> > @@ -196,46 +195,6 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
> >         }
> >         spin_unlock(&cur_trans->dropped_roots_lock);
> >
> > -       /*
> > -        * We have to update the last_byte_to_unpin under the commit_root_sem,
> > -        * at the same time we swap out the commit roots.
> > -        *
> > -        * This is because we must have a real view of the last spot the caching
> > -        * kthreads were while caching.  Consider the following views of the
> > -        * extent tree for a block group
> > -        *
> > -        * commit root
> > -        * +----+----+----+----+----+----+----+
> > -        * |\\\\|    |\\\\|\\\\|    |\\\\|\\\\|
> > -        * +----+----+----+----+----+----+----+
> > -        * 0    1    2    3    4    5    6    7
> > -        *
> > -        * new commit root
> > -        * +----+----+----+----+----+----+----+
> > -        * |    |    |    |\\\\|    |    |\\\\|
> > -        * +----+----+----+----+----+----+----+
> > -        * 0    1    2    3    4    5    6    7
> > -        *
> > -        * If the cache_ctl->progress was at 3, then we are only allowed to
> > -        * unpin [0,1) and [2,3], because the caching thread has already
> > -        * processed those extents.  We are not allowed to unpin [5,6), because
> > -        * the caching thread will re-start it's search from 3, and thus find
> > -        * the hole from [4,6) to add to the free space cache.
> > -        */
> > -       write_lock(&fs_info->block_group_cache_lock);
> > -       list_for_each_entry_safe(caching_ctl, next,
> > -                                &fs_info->caching_block_groups, list) {
> > -               struct btrfs_block_group *cache = caching_ctl->block_group;
> > -
> > -               if (btrfs_block_group_done(cache)) {
> > -                       cache->last_byte_to_unpin = (u64)-1;
> > -                       list_del_init(&caching_ctl->list);
> > -                       btrfs_put_caching_control(caching_ctl);
> Now the caching_ctl is not removed from fs_info->caching_block_groups,
> and remains there until close_ctree(). So eventually it will be
> removed, but for now just occupying memory. Is this intended?

No, I don't think this was intentional.

Thanks,
Omar

