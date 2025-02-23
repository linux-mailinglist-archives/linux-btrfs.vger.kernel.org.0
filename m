Return-Path: <linux-btrfs+bounces-11717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4D6A40E46
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 12:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFFC17700E
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F3E2054F9;
	Sun, 23 Feb 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="bCFU4N7e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5271FC111
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740310282; cv=none; b=OccZqCVixRPtUloJ8OeuK3Y2q5v/xgBMTa/GjGw1IMMa08GtHJlcpS/kB42Y7ybWShbh+pwM5DDxZ1cwhYdDpyjFCztkKvB64yiad0/xsta/fIvKn39R8eacowDv+0SyI6pTHT2E1bfkxI7+dbID+Cj6A8yVjU/3bpqYFMJ7qxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740310282; c=relaxed/simple;
	bh=fmGPdf7gkYHF/DNfKMTn5LMaKvZvGVpe8aRlJzJNqe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jE3FfqlyM74ypUYgY5Mpuk5zdTKu2OdXlsqpx0SspdfTmhTXOzM/BT5OejfFeVGAMJRHakRCzEs4gEEDr0/nlqUEXt8WhR3ubAooKKrDTf8ci8i2qZEImDpcZDgCrDqitOHJhK7nZ6t0Ddxa9GOsWzguEMwgHHPJgrIlJX+m4lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=bCFU4N7e; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221050f3f00so77886825ad.2
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 03:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1740310279; x=1740915079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUXNMFDKbqHQGTvo1pxavhAWhmw7E0cfDKkZEwkQFp8=;
        b=bCFU4N7eCe1NLnc58YokAz7r5V2Z6V1iskynQ7uyjUS4d2/DVT4zTw0LkoSBV3pE0i
         /KtKB89Yvv3IXdKosB+O8F1J2Ihn/BD97Qu4r0kW07ZS15Qw28/JKgz5us6vABkirAwY
         +jHKHjC9NK3ctpFWJOF3LXa35ShYN4V6bJDbR8eGlrUhJ1pxdbO3skv0A4smRwc0o75M
         lK9HaMYk2OAXGlN0HC75f0Mh8hZnUl8DQdErIXWz9qn1GU7JApnXSordPZT6FM478MBQ
         va7NEdyPJ2dM2AQq2dQKK1HZnLQWCJNAL+YvWwzHmh/I5RSqXX+eWKeaHYe34AvD6+hy
         7RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740310279; x=1740915079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUXNMFDKbqHQGTvo1pxavhAWhmw7E0cfDKkZEwkQFp8=;
        b=hnngjikWwzjpY6esuqTEcuNboweT22R/gB0oV3rnnDAmIU9j9lWqxVqQ3ouRoudPpK
         JfyFDM0OcRYbGDX5LxyitXUS5OvNvPUsWwoe0HTrQRADoCncGgddIfTyZ3ptJhGJrcRW
         THTo/xy3pICn1TVQQdKgL/GhgMuBZRjAkA/RbkUhYPN/Vfu8F4cbApYEQipeTOETw1l4
         DvD4w9LHK0Zu82T16jZ47sSp8yyZOZHMDhJdU7oBAkYW0WDAlgqV5TGpqDuCjmQB6ONq
         2EKTTk/KDTshcs/s4MqNYL+HV/J3DsTOwkYgWwDfKxjovjStirVb8M3vXmX5STpVtPwB
         p1rQ==
X-Gm-Message-State: AOJu0YyE9sssoNk5vFjWidtj1MQkUjMWqhJPDR7kVYnMTOua5dZCh2mX
	0gJee8YrTf/yDSufzUJZX5MdukTefDiVg4fotk4qDN/nMalBmR46FEHwx1jrLvV1iKCZwH2weH9
	TWgQ7hvpxfMs/j9nHGGkhSP7etvNHNxZWSLpr875P2LuufuQ29xc=
X-Gm-Gg: ASbGncu3u61T7Vv/T+yJ3eLHwkTotuDraYoAE7Bb6ErNgykakJg4PIsSm2u52FOSaI5
	i9Wuh5pd82ptHuRFHpOEnsLQIYivW4n57JwIky6IjFO/v0AZi21Tzrg1dIoRub2ISEF1K26/Hy7
	JqUKOJVQ==
X-Google-Smtp-Source: AGHT+IEeYRAiBqfsZKMz7LgGw8w74Hcnvdmvp21cMj0bzfwvtfNUcTTp2EsNn3O5N6sKdGmGVIKOa5DngBAcQj2FPxQ=
X-Received: by 2002:a05:6a00:4654:b0:724:bf30:147d with SMTP id
 d2e1a72fcca58-73426ceba82mr16173402b3a.11.1740310279100; Sun, 23 Feb 2025
 03:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1660690698.git.osandov@fb.com> <1ac68be51384f9cc2433bb7979f4cda563e72976.1660690698.git.osandov@fb.com>
 <CAOcd+r1BGKYVRZK5iDdK6N0sr7CuCxvmmBjzNDXhZrv2o4cRYA@mail.gmail.com> <Z7elzqQqFb_YUO_J@telecaster>
In-Reply-To: <Z7elzqQqFb_YUO_J@telecaster>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Sun, 23 Feb 2025 13:31:08 +0200
X-Gm-Features: AWEUYZkyHE0F-oSL1M35pKZmY3dHYZV1K9hPS4g7GZj3sQqBYVxi2yr-YEzoOz4
Message-ID: <CAOcd+r0KC3VVZVi02yhMXMU_d1qfFYXbcJD34CtcTteAc2rPTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: get rid of block group caching progress logic
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Omar,

Thanks for your response. Does it make sense to remove the caching
control when the caching completes in caching_thread?

Thanks,
Alex.


On Thu, Feb 20, 2025 at 11:59=E2=80=AFPM Omar Sandoval <osandov@osandov.com=
> wrote:
>
> On Thu, Feb 20, 2025 at 09:26:47PM +0200, Alex Lyakas wrote:
> > Hi Omar,
> >
> > On Wed, Aug 17, 2022 at 2:13=E2=80=AFAM Omar Sandoval <osandov@osandov.=
com> wrote:
> > >
> > > From: Omar Sandoval <osandov@fb.com>
> > >
> > > struct btrfs_caching_ctl::progress and struct
> > > btrfs_block_group::last_byte_to_unpin were previously needed to ensur=
e
> > > that unpin_extent_range() didn't return a range to the free space cac=
he
> > > before the caching thread had a chance to cache that range. However, =
the
> > > previous commit made it so that we always synchronously cache the blo=
ck
> > > group at the time that we pin the extent, so this machinery is no lon=
ger
> > > necessary.
> > >
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > >  fs/btrfs/block-group.c     | 13 ------------
> > >  fs/btrfs/block-group.h     |  2 --
> > >  fs/btrfs/extent-tree.c     |  9 ++-------
> > >  fs/btrfs/free-space-tree.c |  8 --------
> > >  fs/btrfs/transaction.c     | 41 ------------------------------------=
--
> > >  fs/btrfs/zoned.c           |  1 -
> > >  6 files changed, 2 insertions(+), 72 deletions(-)
> > >
> > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > index 1af6fc395a52..68992ad9ff2a 100644
> > > --- a/fs/btrfs/block-group.c
> > > +++ b/fs/btrfs/block-group.c
> > > @@ -593,8 +593,6 @@ static int load_extent_tree_free(struct btrfs_cac=
hing_control *caching_ctl)
> > >
> > >                         if (need_resched() ||
> > >                             rwsem_is_contended(&fs_info->commit_root_=
sem)) {
> > > -                               if (wakeup)
> > > -                                       caching_ctl->progress =3D las=
t;
> > >                                 btrfs_release_path(path);
> > >                                 up_read(&fs_info->commit_root_sem);
> > >                                 mutex_unlock(&caching_ctl->mutex);
> > > @@ -618,9 +616,6 @@ static int load_extent_tree_free(struct btrfs_cac=
hing_control *caching_ctl)
> > >                         key.objectid =3D last;
> > >                         key.offset =3D 0;
> > >                         key.type =3D BTRFS_EXTENT_ITEM_KEY;
> > > -
> > > -                       if (wakeup)
> > > -                               caching_ctl->progress =3D last;
> > >                         btrfs_release_path(path);
> > >                         goto next;
> > >                 }
> > > @@ -655,7 +650,6 @@ static int load_extent_tree_free(struct btrfs_cac=
hing_control *caching_ctl)
> > >
> > >         total_found +=3D add_new_free_space(block_group, last,
> > >                                 block_group->start + block_group->len=
gth);
> > > -       caching_ctl->progress =3D (u64)-1;
> > >
> > >  out:
> > >         btrfs_free_path(path);
> > > @@ -725,8 +719,6 @@ static noinline void caching_thread(struct btrfs_=
work *work)
> > >         }
> > >  #endif
> > >
> > > -       caching_ctl->progress =3D (u64)-1;
> > > -
> > >         up_read(&fs_info->commit_root_sem);
> > >         btrfs_free_excluded_extents(block_group);
> > >         mutex_unlock(&caching_ctl->mutex);
> > > @@ -755,7 +747,6 @@ int btrfs_cache_block_group(struct btrfs_block_gr=
oup *cache, bool wait)
> > >         mutex_init(&caching_ctl->mutex);
> > >         init_waitqueue_head(&caching_ctl->wait);
> > >         caching_ctl->block_group =3D cache;
> > > -       caching_ctl->progress =3D cache->start;
> > >         refcount_set(&caching_ctl->count, 2);
> > >         btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NUL=
L);
> > >
> > > @@ -2076,11 +2067,9 @@ static int read_one_block_group(struct btrfs_f=
s_info *info,
> > >                 /* Should not have any excluded extents. Just in case=
, though. */
> > >                 btrfs_free_excluded_extents(cache);
> > >         } else if (cache->length =3D=3D cache->used) {
> > > -               cache->last_byte_to_unpin =3D (u64)-1;
> > >                 cache->cached =3D BTRFS_CACHE_FINISHED;
> > >                 btrfs_free_excluded_extents(cache);
> > >         } else if (cache->used =3D=3D 0) {
> > > -               cache->last_byte_to_unpin =3D (u64)-1;
> > >                 cache->cached =3D BTRFS_CACHE_FINISHED;
> > >                 add_new_free_space(cache, cache->start,
> > >                                    cache->start + cache->length);
> > > @@ -2136,7 +2125,6 @@ static int fill_dummy_bgs(struct btrfs_fs_info =
*fs_info)
> > >                 /* Fill dummy cache as FULL */
> > >                 bg->length =3D em->len;
> > >                 bg->flags =3D map->type;
> > > -               bg->last_byte_to_unpin =3D (u64)-1;
> > >                 bg->cached =3D BTRFS_CACHE_FINISHED;
> > >                 bg->used =3D em->len;
> > >                 bg->flags =3D map->type;
> > > @@ -2482,7 +2470,6 @@ struct btrfs_block_group *btrfs_make_block_grou=
p(struct btrfs_trans_handle *tran
> > >         set_free_space_tree_thresholds(cache);
> > >         cache->used =3D bytes_used;
> > >         cache->flags =3D type;
> > > -       cache->last_byte_to_unpin =3D (u64)-1;
> > >         cache->cached =3D BTRFS_CACHE_FINISHED;
> > >         cache->global_root_id =3D calculate_global_root_id(fs_info, c=
ache->start);
> > >
> > > diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> > > index 9dba28bb1806..59a86e82a28e 100644
> > > --- a/fs/btrfs/block-group.h
> > > +++ b/fs/btrfs/block-group.h
> > > @@ -63,7 +63,6 @@ struct btrfs_caching_control {
> > >         wait_queue_head_t wait;
> > >         struct btrfs_work work;
> > >         struct btrfs_block_group *block_group;
> > > -       u64 progress;
> > >         refcount_t count;
> > >  };
> > >
> > > @@ -115,7 +114,6 @@ struct btrfs_block_group {
> > >         /* Cache tracking stuff */
> > >         int cached;
> > >         struct btrfs_caching_control *caching_ctl;
> > > -       u64 last_byte_to_unpin;
> > >
> > >         struct btrfs_space_info *space_info;
> > >
> > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > index 86ac953c69ac..bcd0e72cded3 100644
> > > --- a/fs/btrfs/extent-tree.c
> > > +++ b/fs/btrfs/extent-tree.c
> > > @@ -2686,13 +2686,8 @@ static int unpin_extent_range(struct btrfs_fs_=
info *fs_info,
> > >                 len =3D cache->start + cache->length - start;
> > >                 len =3D min(len, end + 1 - start);
> > >
> > > -               down_read(&fs_info->commit_root_sem);
> > > -               if (start < cache->last_byte_to_unpin && return_free_=
space) {
> > > -                       u64 add_len =3D min(len, cache->last_byte_to_=
unpin - start);
> > > -
> > > -                       btrfs_add_free_space(cache, start, add_len);
> > > -               }
> > > -               up_read(&fs_info->commit_root_sem);
> > > +               if (return_free_space)
> > > +                       btrfs_add_free_space(cache, start, len);
> > >
> > >                 start +=3D len;
> > >                 total_unpinned +=3D len;
> > > diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> > > index 1bf89aa67216..367bcfcf68f5 100644
> > > --- a/fs/btrfs/free-space-tree.c
> > > +++ b/fs/btrfs/free-space-tree.c
> > > @@ -1453,8 +1453,6 @@ static int load_free_space_bitmaps(struct btrfs=
_caching_control *caching_ctl,
> > >                 ASSERT(key.type =3D=3D BTRFS_FREE_SPACE_BITMAP_KEY);
> > >                 ASSERT(key.objectid < end && key.objectid + key.offse=
t <=3D end);
> > >
> > > -               caching_ctl->progress =3D key.objectid;
> > > -
> > >                 offset =3D key.objectid;
> > >                 while (offset < key.objectid + key.offset) {
> > >                         bit =3D free_space_test_bit(block_group, path=
, offset);
> > > @@ -1490,8 +1488,6 @@ static int load_free_space_bitmaps(struct btrfs=
_caching_control *caching_ctl,
> > >                 goto out;
> > >         }
> > >
> > > -       caching_ctl->progress =3D (u64)-1;
> > > -
> > >         ret =3D 0;
> > >  out:
> > >         return ret;
> > > @@ -1531,8 +1527,6 @@ static int load_free_space_extents(struct btrfs=
_caching_control *caching_ctl,
> > >                 ASSERT(key.type =3D=3D BTRFS_FREE_SPACE_EXTENT_KEY);
> > >                 ASSERT(key.objectid < end && key.objectid + key.offse=
t <=3D end);
> > >
> > > -               caching_ctl->progress =3D key.objectid;
> > > -
> > >                 total_found +=3D add_new_free_space(block_group, key.=
objectid,
> > >                                                   key.objectid + key.=
offset);
> > >                 if (total_found > CACHING_CTL_WAKE_UP) {
> > > @@ -1552,8 +1546,6 @@ static int load_free_space_extents(struct btrfs=
_caching_control *caching_ctl,
> > >                 goto out;
> > >         }
> > >
> > > -       caching_ctl->progress =3D (u64)-1;
> > > -
> > >         ret =3D 0;
> > >  out:
> > >         return ret;
> > > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > > index 6e3b2cb6a04a..4c87bf2abc14 100644
> > > --- a/fs/btrfs/transaction.c
> > > +++ b/fs/btrfs/transaction.c
> > > @@ -161,7 +161,6 @@ static noinline void switch_commit_roots(struct b=
trfs_trans_handle *trans)
> > >         struct btrfs_transaction *cur_trans =3D trans->transaction;
> > >         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> > >         struct btrfs_root *root, *tmp;
> > > -       struct btrfs_caching_control *caching_ctl, *next;
> > >
> > >         /*
> > >          * At this point no one can be using this transaction to modi=
fy any tree
> > > @@ -196,46 +195,6 @@ static noinline void switch_commit_roots(struct =
btrfs_trans_handle *trans)
> > >         }
> > >         spin_unlock(&cur_trans->dropped_roots_lock);
> > >
> > > -       /*
> > > -        * We have to update the last_byte_to_unpin under the commit_=
root_sem,
> > > -        * at the same time we swap out the commit roots.
> > > -        *
> > > -        * This is because we must have a real view of the last spot =
the caching
> > > -        * kthreads were while caching.  Consider the following views=
 of the
> > > -        * extent tree for a block group
> > > -        *
> > > -        * commit root
> > > -        * +----+----+----+----+----+----+----+
> > > -        * |\\\\|    |\\\\|\\\\|    |\\\\|\\\\|
> > > -        * +----+----+----+----+----+----+----+
> > > -        * 0    1    2    3    4    5    6    7
> > > -        *
> > > -        * new commit root
> > > -        * +----+----+----+----+----+----+----+
> > > -        * |    |    |    |\\\\|    |    |\\\\|
> > > -        * +----+----+----+----+----+----+----+
> > > -        * 0    1    2    3    4    5    6    7
> > > -        *
> > > -        * If the cache_ctl->progress was at 3, then we are only allo=
wed to
> > > -        * unpin [0,1) and [2,3], because the caching thread has alre=
ady
> > > -        * processed those extents.  We are not allowed to unpin [5,6=
), because
> > > -        * the caching thread will re-start it's search from 3, and t=
hus find
> > > -        * the hole from [4,6) to add to the free space cache.
> > > -        */
> > > -       write_lock(&fs_info->block_group_cache_lock);
> > > -       list_for_each_entry_safe(caching_ctl, next,
> > > -                                &fs_info->caching_block_groups, list=
) {
> > > -               struct btrfs_block_group *cache =3D caching_ctl->bloc=
k_group;
> > > -
> > > -               if (btrfs_block_group_done(cache)) {
> > > -                       cache->last_byte_to_unpin =3D (u64)-1;
> > > -                       list_del_init(&caching_ctl->list);
> > > -                       btrfs_put_caching_control(caching_ctl);
> > Now the caching_ctl is not removed from fs_info->caching_block_groups,
> > and remains there until close_ctree(). So eventually it will be
> > removed, but for now just occupying memory. Is this intended?
>
> No, I don't think this was intentional.
>
> Thanks,
> Omar

