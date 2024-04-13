Return-Path: <linux-btrfs+bounces-4208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D998A3C6E
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 13:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A49FB21C57
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C03E462;
	Sat, 13 Apr 2024 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvxHzYu5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1E31DFD0
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713006489; cv=none; b=c5IFE0QASbDnD/3bXtYELaArp9PFdhGM2Uwe6wlTOGmxWMFIxsxlqi2KsEHEsTKtMyaLRGn+YskmHZ0sCDp2ai0T1hyM6HGSVvF0W04rK7U11m60aXn4IfitCAYYOfGFAbE0nW726pBAJzUfOdgdtyTya33KfQ/Agc5lgXZGMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713006489; c=relaxed/simple;
	bh=1zYQdogTsXBGE+9bl/o+M7C64xpns/QfWPWJ5IqScuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VU+orS7P3VDH7KIcJAKOAybuPiXJVXGS7uuYv6Lnj/xD8Bc0TB0xbPqnIAs09/z7/XFD0GwG7UTyLdI3c9be9qS1WJ3Yh4BoUtKNqT8DmmqePjEQSyoRJI7JRpOGuASs292ly2+Eujz2jy54GpWTPIKCGs13Q/UVT4rUtpGaFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvxHzYu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA7EC2BBFC
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713006488;
	bh=1zYQdogTsXBGE+9bl/o+M7C64xpns/QfWPWJ5IqScuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GvxHzYu56CW/1rsh3M1UtygVQ29mFAKWFRQW0jPQ+LdNuB7aYbM6HrKjR7tJmPhUH
	 cycFoh2XFw2qF7PPSzTTRvWgLbPLtGzWlyZBPrNBFHL4TO9eEtCZqv+HOl+VBftKwo
	 pFLX5enMkGiQaBOuh4z6Jt4thYY9PDQRexGzV12M9s6CBltTJTsLuSwKkXn5CqNQJH
	 Cid6u9bf8wm6BCOSBvwaM1mdKgc4zjMI5BEn55MKaEcJlMx8+FVt59F4qEkvdBA1YC
	 AuzUXs7yGw/H/xAIQ4UUEc+q4z5w9Ed5lXzi1d+ncyFmLWp/+iDVQuSGV1mYOPoAsR
	 phhb2kvOdEGkw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51a7d4466bso194725266b.2
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 04:08:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YwoHyMxJZUbpN/Qf85qhZHmiHiL3QXweeVpNVh3VRv3U9erNnFc
	69R0RHJDvjMx9WtAZE91f2O/D7+t6eqFTLqy14RVOZPis8+Sjf+zuHjN1eDoDSPFQ5r9J5Q44Sb
	ITUl1wmuhus1N0HWRT3FD2OuJ70E=
X-Google-Smtp-Source: AGHT+IG76fZ0OzYS9NgjzEG9Wlscpm+aA7Kh7Tm2tnoUNFMFgHk9vFelNqD44xR2nOAuJgDbbxuIdDV7IhI64qpZdmU=
X-Received: by 2002:a17:907:c29:b0:a51:9304:19fa with SMTP id
 ga41-20020a1709070c2900b00a51930419famr3554131ejc.70.1713006487142; Sat, 13
 Apr 2024 04:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712837044.git.fdmanana@suse.com> <1cb649870b6cad4411da7998735ab1141bb9f2f0.1712837044.git.fdmanana@suse.com>
 <20240412200657.GA1222511@perftesting>
In-Reply-To: <20240412200657.GA1222511@perftesting>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 13 Apr 2024 12:07:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7VHRCKgh444KiAHYNg0ac8B+q9J1t7b_5zbd065=1ABw@mail.gmail.com>
Message-ID: <CAL3q7H7VHRCKgh444KiAHYNg0ac8B+q9J1t7b_5zbd065=1ABw@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] btrfs: add a shrinker for extent maps
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 9:07=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Thu, Apr 11, 2024 at 05:19:07PM +0100, fdmanana@kernel.org wrote:
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
> >    space operation callback.
> >
> >    However we won't release extent maps in the folio range if the folio=
 is
> >    either dirty or under writeback or if the inode's i_size is less tha=
n
> >    or equals to 16M (see try_release_extent_mapping(). This 16M i_size
> >    constraint was added back in 2008 with commit 70dec8079d78 ("Btrfs:
> >    extent_io and extent_state optimizations"), but there's no explanati=
on
> >    about why we have it or why the 16M value.
> >
> > This means that for buffered IO we can reach an OOM situation due to to=
o
> > many extent maps if either of the following happens:
> >
> > 1) There's a set of tasks constantly doing IO on many files with a size
> >    not larger than 16M, specially if they keep the files open for very
> >    long periods, therefore preventing inode eviction.
> >
> >    This requires a really high number of such files, and having many no=
n
> >    mergeable extent maps (due to random 4K writes for example) and a
> >    machine with very little memory;
> >
> > 2) There's a set tasks constantly doing random write IO (therefore
> >    creating many non mergeable extent maps) on files and keeping them
> >    open for long periods of time, so inode eviction doesn't happen and
> >    there's always a lot of dirty pages or pages under writeback,
> >    preventing btrfs_release_folio() from releasing the respective exten=
t
> >    maps.
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
> >    $ cat test.sh
> >    #!/bin/bash
> >
> >    DEV=3D/dev/sdj
> >    MNT=3D/mnt/sdj
> >    MOUNT_OPTIONS=3D"-o ssd"
> >    MKFS_OPTIONS=3D""
> >
> >    cat <<EOF > /tmp/fio-job.ini
> >    [global]
> >    name=3Dfio-rand-write
> >    filename=3D$MNT/fio-rand-write
> >    rw=3Drandwrite
> >    bs=3D4K
> >    direct=3D1
> >    numjobs=3D16
> >    fallocate=3Dnone
> >    time_based
> >    runtime=3D90000
> >
> >    [file1]
> >    size=3D300G
> >    ioengine=3Dlibaio
> >    iodepth=3D16
> >
> >    EOF
> >
> >    umount $MNT &> /dev/null
> >    mkfs.btrfs -f $MKFS_OPTIONS $DEV
> >    mount $MOUNT_OPTIONS $DEV $MNT
> >
> >    fio /tmp/fio-job.ini
> >    umount $MNT
> >
> > Monitoring the btrfs_extent_map slab while running the test with:
> >
> >    $ watch -d -n 1 'cat /sys/kernel/slab/btrfs_extent_map/objects \
> >                         /sys/kernel/slab/btrfs_extent_map/total_objects=
'
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
>
> I don't like this for a few reasons
>
> 1. We're always starting with the first root and the first inode.  We're =
just
>    going to constantly screw that first inode over and over again.
> 2. I really, really hate our inode rb-tree, I want to reduce it's use, no=
t add
>    more users.  It would be nice if we could just utilize ->s_inodes_lru =
instead
>    for this, which would also give us the nice advantage of not having to=
 think
>    about order since it's already in LRU order.
> 3. We're registering our own shrinker without a proper LRU setup.  I thin=
k it
>    would make sense if we wanted to have a LRU for our extent maps, but I=
 think
>    that's not a great idea.  We could get the same benefit by adding our =
own
>    ->nr_cached_objects() and ->free_cached_objects(), I think that's a be=
tter
>    approach no matter what other changes you make instead of registering =
our own
>    shrinker.

Ok, so some comments about all that.

Using sb->s_inode_lru, which has the struct list_lru type is complicated.
I had considered that some time ago, and here are the problems with it:

1) List iteration, done with list_lru_walk() (or one of its variants),
is done while holding the lru list's spinlock.

This means we can't remove all extents maps in one go as that will
take too much time if we have millions of them for example, and make
other tasks spin for too long on the lock.

We will also need to take the inode's mmap semaphore which is a
blocking operation, so we can't do it while under the spinlock.

Sure, the lru list iteration's callback (the "isolate" argument of
type list_lru_walk_cb) can release that lru list spinlock, do the
extent map iteration and removal, then lock it again and return
LRU_RETRY.
But that will restart the search from the first element in the lru
list. This means we can be iterating over the same inodes over and
over.

2) You may hate the inode rb-tree, but we don't have another way to
iterate over the inodes and be efficient to search for inodes starting
at a particular number.

3)  ->nr_cached_objects() and ->free_cached_objects() of the super
operations are a good alternative to registering our own shrinker.
I went with our own shrinker because it's what ext4 is doing and it's
simple. Changing to the super operations is fairly simple and I
embrace it.

4) That concern about LRU is not really that relevant as you think.

Look at fs/super.c:super_cache_scan() (for when we define our
->nr_cached_objects() and ->free_cached_objects() callbacks).

Every time ->free_cached_objects() is called we do it for a number of
items we returned with ->nr_cached_objects().
That means we all go over all inodes and so going in LRU order or any
other order ends up being irrelevant.

The same goes for the shrinker solution.

Sure you can argue that in the time between calling
->nr_cached_objects() and calling ->free_cached_objects() more extent
maps may have been created.
But that's not a big time window, not enough to add that many extent
maps to make any practical difference.
Plus when the shrinking is performed it's because we are under heavy
memory pressure and removing extent maps won't have that much impact
anyway, since page cache was freed amongst other things that have more
impact on performance than extent maps.

This is probably why ext4 is following the same approach for its
extent_status structures as I did here (well, I followed their way of
doing things).
Those structures are in a rb tree of the inode, just like we do with
our extent maps.
And the inodes are in a regular linked list (struct
ext4_sb_info::s_es_list) and added with list_add_tail to that list -
they're never moved within the list (no LRU).
When the scan callback of the shrinker is invoked, it always iterates
the inodes in that list order - not LRU or anything "fancy".


So I'm okay with moving to an implementation based on
->nr_cached_objects() and calling ->free_cached_objects(), that's
simple.
But iterating the inodes will have to be with the rb-tree, as we don't
have anything else that allows us to iterate and start at any given
number.
I can make it to remember the last scanned inode (and root) so that
the next time the shrinking happens it will start after that last
scanned inode.

And adding our own lru implementation wouldn't make much difference
because of all that, and would also have 2 downsides to it:

1) We would need a struct list_head  (16 bytes) plus a pointer to the
inode (so that we can remove an extent map from the rb tree) added to
the extent_map structure, so 24 bytes overhead.

2) All the maintenance of the list, adding to it, removing from it,
moving elements, etc, all requires locking and overhead from lock
contention (using the struct list_lru API or our own).

So my proposal is to do this:

1) Keep using the rb tree to search for inodes - this is abstracted by
an helper function used in 2 other places.
2) Remember the last scanned inode/root, and on every scan start after
that inode.
3) Use ->nr_cached_objects() and calling ->free_cached_objects()
instead of registering a shrinker.

What do you think?
Thanks.

>
> The concept I whole heartedly agree with, this just needs some tweaks to =
be more
> fair and cleaner.  The rest of the code is fine, you can add
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> to the rest of it.  Thanks,
>
> Josef

