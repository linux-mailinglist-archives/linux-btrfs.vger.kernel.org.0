Return-Path: <linux-btrfs+bounces-4139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396A28A0EA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 12:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D51B1C21A46
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDD91465A6;
	Thu, 11 Apr 2024 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUeqVtMF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB515145FF0
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830596; cv=none; b=WRFOMvX+ZXezP4KlLFOykCuf41+U2oZ9pH3aogjgHn9Tf223qFB7qDRYmhfy9p8VSOAR0s41fh22DU+aX/odU4vLh1tpidrX2DFc2FiDhz54pbMHcTBQgJE45A8MhNAOAT3GF/SWI3mjtOVSklVTqa1kxJ3ydcrfW+qMe74IK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830596; c=relaxed/simple;
	bh=Dg29meBGPYiDVZr5QffZBhfazZzBruUkflXj0NrEIJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GroLb/MKRoUREuhj50T2RXY7M7W3m0sklIyFyzHbQZKPWj7TwSqrjsVKN7z9pOC6o8vVsh/AWQgEP9SRCFFgo+OuUWytIMgLRHDJGWaaPtaWFRe+VO8/HOnP9hqK3iCIzJKG3Yp9P/Oya/tvC5weay+NJ6M53va1vzvjLG44C/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUeqVtMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75707C43394
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712830596;
	bh=Dg29meBGPYiDVZr5QffZBhfazZzBruUkflXj0NrEIJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WUeqVtMF++8bxEuLGrQdy483/sKMBladjWxJ8JlC5Pe0Zi9Aexv17babgLugthZSA
	 kFf9M94cxy8pUQ/uglFo5R0JSo9qrc6ODMDR9sS5qX+3w8GfRs/5u7/oN6XjDNocsb
	 FzBVBveLncPSkYfAMMfGwsth3jXCNv88VennTH7ODYaE2RSuyrFnVxBJcZFj5kztE9
	 8rilhwuRWR9t1Vp2W9j38BWUjkbOqwNfc3XHflj1TYn6idBHDMXGaLrdm3QSd1aT90
	 66uQqbqyrdsqbI3RC8xOoFWD7mSG/8ebqgnwc8/macA/r755xqKpp42MMzt9JhZaHd
	 CSnkKe+9bXT+w==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44665605f3so850997066b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 03:16:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YxupewbCgaiAjmRvW2BDjBTsdRVp0YpJY/niOnQV/iJkUcsq4PG
	2YfGA1K0UZipsk7PZuL4ZukSmS6g5z7TeEyvBuRZp0LBSJNcET8FA/5GIR+bWZPIKl6d2arWTG9
	0ksSQrWQzgIOyKbNu6v5KD7XLsG0=
X-Google-Smtp-Source: AGHT+IEmgnWlz+ngqTX7TMf1N8iytvDicQHQFPDA8691O19o3geFK3VLXTuq64ZQQRQ3jrNKD/oNeY4ZhqEHnA1RJgw=
X-Received: by 2002:a17:907:986:b0:a46:966b:ebfe with SMTP id
 bf6-20020a170907098600b00a46966bebfemr4194717ejc.46.1712830594956; Thu, 11
 Apr 2024 03:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712748143.git.fdmanana@suse.com> <5d1743b20f84e0262a2c229cd5e877ed0f0596a0.1712748143.git.fdmanana@suse.com>
 <ae52bfc9-ea64-4079-a98a-acd1750fe7ab@gmx.com>
In-Reply-To: <ae52bfc9-ea64-4079-a98a-acd1750fe7ab@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Apr 2024 11:15:58 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5q7FyNp1_czP=xBHxUO+_Xd5wbRdKeZXHz5R0hxQVFew@mail.gmail.com>
Message-ID: <CAL3q7H5q7FyNp1_czP=xBHxUO+_Xd5wbRdKeZXHz5R0hxQVFew@mail.gmail.com>
Subject: Re: [PATCH 09/11] btrfs: add a shrinker for extent maps
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 6:58=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/4/10 20:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Extent maps are used either to represent existing file extent items, or=
 to
> > represent new extents that are going to be written and the respective f=
ile
> > extent items are created when the ordered extent completes.
> >
> > We currently don't have any limit for how many extent maps we can have,
> > neither per inode nor globally. Most of the time this not too noticeabl=
e
> > because extent maps are removed in the following situations:
> >
> > 1) When evicting an inode;
> >
> > 2) When releasing folios (pages) through the btrfs_release_folio() addr=
ess
> >     space operation callback.
> >
> >     However we won't release extent maps in the folio range if the foli=
o is
> >     either dirty or under writeback or if the inode's i_size is less th=
an
> >     or equals to 16M (see try_release_extent_mapping(). This 16M i_size
> >     constraint was added back in 2008 with commit 70dec8079d78 ("Btrfs:
> >     extent_io and extent_state optimizations"), but there's no explanat=
ion
> >     about why we have it or why the 16M value.
> >
> > This means that for buffered IO we can reach an OOM situation due to to=
o
> > many extent maps if either of the following happens:
> >
> > 1) There's a set of tasks constantly doing IO on many files with a size
> >     not larger than 16M, specially if they keep the files open for very
> >     long periods, therefore preventing inode eviction.
> >
> >     This requires a really high number of such files, and having many n=
on
> >     mergeable extent maps (due to random 4K writes for example) and a
> >     machine with very little memory;
> >
> > 2) There's a set tasks constantly doing random write IO (therefore
> >     creating many non mergeable extent maps) on files and keeping them
> >     open for long periods of time, so inode eviction doesn't happen and
> >     there's always a lot of dirty pages or pages under writeback,
> >     preventing btrfs_release_folio() from releasing the respective exte=
nt
> >     maps.
> >
> > This second case was actually reported in the thread pointed by the Lin=
k
> > tag below, and it requires a very large file under heavy IO and a machi=
ne
> > with very little amount of RAM, which is probably hard to happen in
> > practice in a real world use case.
> >
> > However when using direct IO this is not so hard to happen, because the
> > page cache is not used, and therefore btrfs_release_folio() is never
> > called. Which means extent maps are dropped only when evicting the inod=
e,
> > and that means that if we have tasks that keep a file descriptor open a=
nd
> > keep doing IO on a very large file (or files), we can exhaust memory du=
e
> > to an unbounded amount of extent maps. This is especially easy to happe=
n
> > if we have a huge file with millions of small extents and their extent
> > maps are not mergeable (non contiguous offsets and disk locations).
> > This was reported in that thread with the following fio test:
> >
> >     $ cat test.sh
> >     #!/bin/bash
> >
> >     DEV=3D/dev/sdj
> >     MNT=3D/mnt/sdj
> >     MOUNT_OPTIONS=3D"-o ssd"
> >     MKFS_OPTIONS=3D""
> >
> >     cat <<EOF > /tmp/fio-job.ini
> >     [global]
> >     name=3Dfio-rand-write
> >     filename=3D$MNT/fio-rand-write
> >     rw=3Drandwrite
> >     bs=3D4K
> >     direct=3D1
> >     numjobs=3D16
> >     fallocate=3Dnone
> >     time_based
> >     runtime=3D90000
> >
> >     [file1]
> >     size=3D300G
> >     ioengine=3Dlibaio
> >     iodepth=3D16
> >
> >     EOF
> >
> >     umount $MNT &> /dev/null
> >     mkfs.btrfs -f $MKFS_OPTIONS $DEV
> >     mount $MOUNT_OPTIONS $DEV $MNT
> >
> >     fio /tmp/fio-job.ini
> >     umount $MNT
> >
> > Monitoring the btrfs_extent_map slab while running the test with:
> >
> >     $ watch -d -n 1 'cat /sys/kernel/slab/btrfs_extent_map/objects \
> >                          /sys/kernel/slab/btrfs_extent_map/total_object=
s'
> >
> > Shows the number of active and total extent maps skyrocketing to tens o=
f
> > millions, and on systems with a short amount of memory it's easy and qu=
ick
> > to get into an OOM situation, as reported in that thread.
> >
> > So to avoid this issue add a shrinker that will remove extents maps, as
> > long as they are not pinned, and takes proper care with any concurrent
> > fsync to avoid missing extents (setting the full sync flag while in the
> > middle of a fast fsync). This shrinker is similar to the one ext4 uses
> > for its extent_status structure, which is analogous to btrfs' extent_ma=
p
> > structure.
> >
> > Link: https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d42c=
55e@amazon.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> [...]
> > +
> > +static unsigned long btrfs_scan_root(struct btrfs_root *root,
> > +                                  unsigned long *scanned,
> > +                                  unsigned long nr_to_scan)
> > +{
> > +     unsigned long nr_dropped =3D 0;
> > +     u64 ino =3D 0;
> > +
> > +     while (*scanned < nr_to_scan) {
> > +             struct rb_node *node;
> > +             struct rb_node *prev =3D NULL;
> > +             struct btrfs_inode *inode;
> > +             bool stop_search =3D true;
> > +
> > +             spin_lock(&root->inode_lock);
> > +             node =3D root->inode_tree.rb_node;
> > +
> > +             while (node) {
> > +                     prev =3D node;
> > +                     inode =3D rb_entry(node, struct btrfs_inode, rb_n=
ode);
> > +                     if (ino < btrfs_ino(inode))
> > +                             node =3D node->rb_left;
> > +                     else if (ino > btrfs_ino(inode))
> > +                             node =3D node->rb_right;
> > +                     else
> > +                             break;
> > +             }
> > +
> > +             if (!node) {
> > +                     while (prev) {
> > +                             inode =3D rb_entry(prev, struct btrfs_ino=
de, rb_node);
> > +                             if (ino <=3D btrfs_ino(inode)) {
> > +                                     node =3D prev;
> > +                                     break;
> > +                             }
> > +                             prev =3D rb_next(prev);
> > +                     }
> > +             }
>
> The "while (node) {}" loop and above "if (!node) {}" is to locate the
> first inode after @ino (which is the last scanned inode number).
>
> Maybe extract them into a helper, with some name like
> "find_next_inode_to_scan()" could be a little easier to read?

Sure, I can do that.

>
> > +
> > +             while (node) {
> > +                     inode =3D rb_entry(node, struct btrfs_inode, rb_n=
ode);
> > +                     ino =3D btrfs_ino(inode) + 1;
> > +                     if (igrab(&inode->vfs_inode)) {
> > +                             spin_unlock(&root->inode_lock);
> > +                             stop_search =3D false;
> > +
> > +                             nr_dropped +=3D btrfs_scan_inode(inode, s=
canned,
> > +                                                            nr_to_scan=
);
> > +                             iput(&inode->vfs_inode);
> > +                             cond_resched();
> > +                             break;
> > +                     }
> > +                     node =3D rb_next(node);
> > +             }
> > +
> > +             if (stop_search) {
> > +                     spin_unlock(&root->inode_lock);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return nr_dropped;
> > +}
> > +
> > +static unsigned long btrfs_extent_maps_scan(struct shrinker *shrinker,
> > +                                         struct shrink_control *sc)
> > +{
> > +     struct btrfs_fs_info *fs_info =3D shrinker->private_data;
> > +     unsigned long nr_dropped =3D 0;
> > +     unsigned long scanned =3D 0;
> > +     u64 next_root_id =3D 0;
> > +
> > +     while (scanned < sc->nr_to_scan) {
> > +             struct btrfs_root *root;
> > +             unsigned long count;
> > +
> > +             spin_lock(&fs_info->fs_roots_radix_lock);
> > +             count =3D radix_tree_gang_lookup(&fs_info->fs_roots_radix=
,
> > +                                            (void **)&root, next_root_=
id, 1);
> > +             if (count =3D=3D 0) {
> > +                     spin_unlock(&fs_info->fs_roots_radix_lock);
> > +                     break;
> > +             }
> > +             next_root_id =3D btrfs_root_id(root) + 1;
> > +             root =3D btrfs_grab_root(root);
> > +             spin_unlock(&fs_info->fs_roots_radix_lock);
> > +
> > +             if (!root)
> > +                     continue;
> > +
> > +             if (is_fstree(btrfs_root_id(root)))
> > +                     nr_dropped +=3D btrfs_scan_root(root, &scanned, s=
c->nr_to_scan);
> > +
> > +             btrfs_put_root(root);
> > +     }
> > +
> > +     return nr_dropped;
> > +}
> > +
> > +static unsigned long btrfs_extent_maps_count(struct shrinker *shrinker=
,
> > +                                          struct shrink_control *sc)
> > +{
> > +     struct btrfs_fs_info *fs_info =3D shrinker->private_data;
> > +     const s64 total =3D percpu_counter_sum_positive(&fs_info->evictab=
le_extent_maps);
> > +
> > +     /* The unsigned long type is 32 bits on 32 bits platforms. */
> > +#if BITS_PER_LONG =3D=3D 32
> > +     if (total > ULONG_MAX)
> > +             return ULONG_MAX;
> > +#endif
>
> Can this be a simple min_t(unsigned long, total, ULONG_MAX)?

Why? Either the current if or min should be easy to understand for anyone.

I'm actually removing this altogether, as on a 32 bits systems we
can't have more than ULONG_MAX extent maps allocated any way, even if
they could be 1 byte long.
Ext4 ignores that in its shrinker for its extent_status structure for
example, which makes sense for that same reason.

>
> Another question is, since total is s64, wouldn't any negative number go
> ULONG_MAX directly for 32bit systems?

How could you have a negative number?
percpu_counter_sum_positive() guarantees a non-negative number is returned.

>
> And since the function is just a shrink hook, I'm not sure what would
> happen if we return ULONG_MAX for negative values.

Nothing. When scanning we stop iteration once we don't find more
roots/inodes/extent maps.

>
> Otherwise the idea looks pretty good, it's just me not qualified to give
> a good review.
>
> Thanks,
> Qu
> > +     return total;
> > +}
> > +
> > +int btrfs_register_extent_map_shrinker(struct btrfs_fs_info *fs_info)
> > +{
> > +     int ret;
> > +
> > +     ret =3D percpu_counter_init(&fs_info->evictable_extent_maps, 0, G=
FP_KERNEL);
> > +     if (ret)
> > +             return ret;
> > +
> > +     fs_info->extent_map_shrinker =3D shrinker_alloc(0, "em-btrfs:%s",=
 fs_info->sb->s_id);
> > +     if (!fs_info->extent_map_shrinker) {
> > +             percpu_counter_destroy(&fs_info->evictable_extent_maps);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     fs_info->extent_map_shrinker->scan_objects =3D btrfs_extent_maps_=
scan;
> > +     fs_info->extent_map_shrinker->count_objects =3D btrfs_extent_maps=
_count;
> > +     fs_info->extent_map_shrinker->private_data =3D fs_info;
> > +
> > +     shrinker_register(fs_info->extent_map_shrinker);
> > +
> > +     return 0;
> > +}
> > +
> > +void btrfs_unregister_extent_map_shrinker(struct btrfs_fs_info *fs_inf=
o)
> > +{
> > +     shrinker_free(fs_info->extent_map_shrinker);
> > +     ASSERT(percpu_counter_sum_positive(&fs_info->evictable_extent_map=
s) =3D=3D 0);
> > +     percpu_counter_destroy(&fs_info->evictable_extent_maps);
> > +}
> > diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> > index c3707461ff62..8a6be2f7a0e2 100644
> > --- a/fs/btrfs/extent_map.h
> > +++ b/fs/btrfs/extent_map.h
> > @@ -140,5 +140,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode,
> >   int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
> >                                  struct extent_map *new_em,
> >                                  bool modified);
> > +int btrfs_register_extent_map_shrinker(struct btrfs_fs_info *fs_info);
> > +void btrfs_unregister_extent_map_shrinker(struct btrfs_fs_info *fs_inf=
o);
> >
> >   #endif
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index 534d30dafe32..f1414814bd69 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -857,6 +857,8 @@ struct btrfs_fs_info {
> >       struct lockdep_map btrfs_trans_pending_ordered_map;
> >       struct lockdep_map btrfs_ordered_extent_map;
> >
> > +     struct shrinker *extent_map_shrinker;
> > +
> >   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
> >       spinlock_t ref_verify_lock;
> >       struct rb_root block_tree;

