Return-Path: <linux-btrfs+bounces-4256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEFB8A4DA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D624C284AC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 11:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF44C60B9D;
	Mon, 15 Apr 2024 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1EaTKsn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF45BAE4
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180333; cv=none; b=NY7MQPwzuU95Xi4gWlPVzDIrRkiRln5l7NgLz0nMz9X0gKijRBiSThj5Vn8elQyt4PCSG0y8HsD6w/eCyhfLTQNzfSOIwhgM6em9oUeRLRnp9/lWnSXxKkfmdRLvoJic8hdiaPTftqL/x3dKasWLt1VvQmKsed1aAD04kCtvJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180333; c=relaxed/simple;
	bh=KU7NoTTTFENh7/+4vVFTQkg23ou96wVVygc6wB+4Ynk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwEA2H0gbNc5rk+26PXbtEk3WuTeXVBbzQAEGNiqtp7MmiazFsVQ08nrozHyd2JSyETRc19LyydzqJIeciAPL+tiBUvV6M2BLagjpqyHfMUMrT4WhasjUAD07Ib4H73Jbn+jjP0//kYZ86JEsqMiZe8Nkp35Myd+1TN8eLTLQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1EaTKsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D05C2BD10
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 11:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713180332;
	bh=KU7NoTTTFENh7/+4vVFTQkg23ou96wVVygc6wB+4Ynk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T1EaTKsnYAzQO9C+HMkGGpIHlDuHah9nvMB2LCbVmTB2aflCGbRkXegLasNk6hTLa
	 P7Cq8Xzpcg/pbZoqP9n2mfkIWXgepIJ9sH+qrVfFKi87v/xPOQ4EGOmNWC4tbwsTAI
	 m7MN3N8OINujy6/UxuSgOrS1ynX+/X+JRjNjo6sFJYJvMS5PtlM1nG7AAj1IZnKK6s
	 Xd05Ou0VsPv7u9pZi8y24qCYTsPmq2tmM9aGchD4YjMvSDPLZ2qVZshGAE12BtWX7O
	 isLTFsFDapso6bpf1GmnFb0ixiREreLmzskGYEfLtnYMG9hXsX48SmJZw4+D7Ou+q8
	 gp1m8tVw/imfA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2da01cb187cso55618281fa.0
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 04:25:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx/73Xwcpg5dHUbZp4oRXnUcKs0lIj57z9tDJAWrSOLPA92o/Vk
	nF7NqQfcXc0J7F5BoN+JE6o6Ba/tymdWG0CDiZJkL/JNYrqNf5KCoH9soVbtjoVv5Xy/SfWmUIo
	uFZWtUkYeLWe1G3Sm0mBLZNl3B2w=
X-Google-Smtp-Source: AGHT+IGanonTXfUc+9w/KXDYN8waXxXr9lOQ5LFuzLvCnl7fDBhUxUEBeOfWNlLx9IS6fuEmiDyHUwMFBTxzMG2RQoE=
X-Received: by 2002:a2e:a545:0:b0:2d8:58b6:c10d with SMTP id
 e5-20020a2ea545000000b002d858b6c10dmr8893321ljn.18.1713180330894; Mon, 15 Apr
 2024 04:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712837044.git.fdmanana@suse.com> <1cb649870b6cad4411da7998735ab1141bb9f2f0.1712837044.git.fdmanana@suse.com>
 <20240412200657.GA1222511@perftesting> <CAL3q7H7VHRCKgh444KiAHYNg0ac8B+q9J1t7b_5zbd065=1ABw@mail.gmail.com>
 <20240414130224.GB1930433@perftesting>
In-Reply-To: <20240414130224.GB1930433@perftesting>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 12:24:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5aqCO5SL3hKU+G=9U1oW5H90kCJ-Vk_aKj8w1HgZfVmw@mail.gmail.com>
Message-ID: <CAL3q7H5aqCO5SL3hKU+G=9U1oW5H90kCJ-Vk_aKj8w1HgZfVmw@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] btrfs: add a shrinker for extent maps
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 2:02=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Sat, Apr 13, 2024 at 12:07:30PM +0100, Filipe Manana wrote:
> > On Fri, Apr 12, 2024 at 9:07=E2=80=AFPM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> > >
> > > On Thu, Apr 11, 2024 at 05:19:07PM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Extent maps are used either to represent existing file extent items=
, or to
> > > > represent new extents that are going to be written and the respecti=
ve file
> > > > extent items are created when the ordered extent completes.
> > > >
> > > > We currently don't have any limit for how many extent maps we can h=
ave,
> > > > neither per inode nor globally. Most of the time this not too notic=
eable
> > > > because extent maps are removed in the following situations:
> > > >
> > > > 1) When evicting an inode;
> > > >
> > > > 2) When releasing folios (pages) through the btrfs_release_folio() =
address
> > > >    space operation callback.
> > > >
> > > >    However we won't release extent maps in the folio range if the f=
olio is
> > > >    either dirty or under writeback or if the inode's i_size is less=
 than
> > > >    or equals to 16M (see try_release_extent_mapping(). This 16M i_s=
ize
> > > >    constraint was added back in 2008 with commit 70dec8079d78 ("Btr=
fs:
> > > >    extent_io and extent_state optimizations"), but there's no expla=
nation
> > > >    about why we have it or why the 16M value.
> > > >
> > > > This means that for buffered IO we can reach an OOM situation due t=
o too
> > > > many extent maps if either of the following happens:
> > > >
> > > > 1) There's a set of tasks constantly doing IO on many files with a =
size
> > > >    not larger than 16M, specially if they keep the files open for v=
ery
> > > >    long periods, therefore preventing inode eviction.
> > > >
> > > >    This requires a really high number of such files, and having man=
y non
> > > >    mergeable extent maps (due to random 4K writes for example) and =
a
> > > >    machine with very little memory;
> > > >
> > > > 2) There's a set tasks constantly doing random write IO (therefore
> > > >    creating many non mergeable extent maps) on files and keeping th=
em
> > > >    open for long periods of time, so inode eviction doesn't happen =
and
> > > >    there's always a lot of dirty pages or pages under writeback,
> > > >    preventing btrfs_release_folio() from releasing the respective e=
xtent
> > > >    maps.
> > > >
> > > > This second case was actually reported in the thread pointed by the=
 Link
> > > > tag below, and it requires a very large file under heavy IO and a m=
achine
> > > > with very little amount of RAM, which is probably hard to happen in
> > > > practice in a real world use case.
> > > >
> > > > However when using direct IO this is not so hard to happen, because=
 the
> > > > page cache is not used, and therefore btrfs_release_folio() is neve=
r
> > > > called. Which means extent maps are dropped only when evicting the =
inode,
> > > > and that means that if we have tasks that keep a file descriptor op=
en and
> > > > keep doing IO on a very large file (or files), we can exhaust memor=
y due
> > > > to an unbounded amount of extent maps. This is especially easy to h=
appen
> > > > if we have a huge file with millions of small extents and their ext=
ent
> > > > maps are not mergeable (non contiguous offsets and disk locations).
> > > > This was reported in that thread with the following fio test:
> > > >
> > > >    $ cat test.sh
> > > >    #!/bin/bash
> > > >
> > > >    DEV=3D/dev/sdj
> > > >    MNT=3D/mnt/sdj
> > > >    MOUNT_OPTIONS=3D"-o ssd"
> > > >    MKFS_OPTIONS=3D""
> > > >
> > > >    cat <<EOF > /tmp/fio-job.ini
> > > >    [global]
> > > >    name=3Dfio-rand-write
> > > >    filename=3D$MNT/fio-rand-write
> > > >    rw=3Drandwrite
> > > >    bs=3D4K
> > > >    direct=3D1
> > > >    numjobs=3D16
> > > >    fallocate=3Dnone
> > > >    time_based
> > > >    runtime=3D90000
> > > >
> > > >    [file1]
> > > >    size=3D300G
> > > >    ioengine=3Dlibaio
> > > >    iodepth=3D16
> > > >
> > > >    EOF
> > > >
> > > >    umount $MNT &> /dev/null
> > > >    mkfs.btrfs -f $MKFS_OPTIONS $DEV
> > > >    mount $MOUNT_OPTIONS $DEV $MNT
> > > >
> > > >    fio /tmp/fio-job.ini
> > > >    umount $MNT
> > > >
> > > > Monitoring the btrfs_extent_map slab while running the test with:
> > > >
> > > >    $ watch -d -n 1 'cat /sys/kernel/slab/btrfs_extent_map/objects \
> > > >                         /sys/kernel/slab/btrfs_extent_map/total_obj=
ects'
> > > >
> > > > Shows the number of active and total extent maps skyrocketing to te=
ns of
> > > > millions, and on systems with a short amount of memory it's easy an=
d quick
> > > > to get into an OOM situation, as reported in that thread.
> > > >
> > > > So to avoid this issue add a shrinker that will remove extents maps=
, as
> > > > long as they are not pinned, and takes proper care with any concurr=
ent
> > > > fsync to avoid missing extents (setting the full sync flag while in=
 the
> > > > middle of a fast fsync). This shrinker is similar to the one ext4 u=
ses
> > > > for its extent_status structure, which is analogous to btrfs' exten=
t_map
> > > > structure.
> > > >
> > > > Link: https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43=
d42c55e@amazon.com/
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > >
> > > I don't like this for a few reasons
> > >
> > > 1. We're always starting with the first root and the first inode.  We=
're just
> > >    going to constantly screw that first inode over and over again.
> > > 2. I really, really hate our inode rb-tree, I want to reduce it's use=
, not add
> > >    more users.  It would be nice if we could just utilize ->s_inodes_=
lru instead
> > >    for this, which would also give us the nice advantage of not havin=
g to think
> > >    about order since it's already in LRU order.
> > > 3. We're registering our own shrinker without a proper LRU setup.  I =
think it
> > >    would make sense if we wanted to have a LRU for our extent maps, b=
ut I think
> > >    that's not a great idea.  We could get the same benefit by adding =
our own
> > >    ->nr_cached_objects() and ->free_cached_objects(), I think that's =
a better
> > >    approach no matter what other changes you make instead of register=
ing our own
> > >    shrinker.
> >
> > Ok, so some comments about all that.
> >
> > Using sb->s_inode_lru, which has the struct list_lru type is complicate=
d.
> > I had considered that some time ago, and here are the problems with it:
> >
> > 1) List iteration, done with list_lru_walk() (or one of its variants),
> > is done while holding the lru list's spinlock.
> >
> > This means we can't remove all extents maps in one go as that will
> > take too much time if we have millions of them for example, and make
> > other tasks spin for too long on the lock.
> >
> > We will also need to take the inode's mmap semaphore which is a
> > blocking operation, so we can't do it while under the spinlock.
> >
> > Sure, the lru list iteration's callback (the "isolate" argument of
> > type list_lru_walk_cb) can release that lru list spinlock, do the
> > extent map iteration and removal, then lock it again and return
> > LRU_RETRY.
> > But that will restart the search from the first element in the lru
> > list. This means we can be iterating over the same inodes over and
> > over.
>
> Agreed, but at least it'll be in LRU order, we'll be visiting each inode =
in
> their LRU order.  If the first inode hasn't changed position then it hasn=
't been
> accessed in a while.
>
> We absolutely would need to use the isolate mechanism, I think we would j=
ust add
> a counter to the extent_io_tree to see how many extent states there are, =
and we
> skip anything that's already been drained.

Looking at the extent io tree is irrelevant for many scenarios, and
LRU is often a very poor choice.

For example consider an application that keeps a file descriptor open
for a very long period, like a database server (I've worked in the
past on one that did that).
If it's using direct IO and does some random reads here and there,
then caches the data in its memory (not the page cache).
The extent io tree will be empty and we'll have around the extent maps
for those ranges which the application will not use for a very long
period, maybe hours or more.

Despite that it is the most recently used inode, yet it's the one with
the most useless extents maps.

The same goes for writes, the application will cache the data in
memory and having the extent map around is useless for it.
Even if it overwrites those same ranges in the near future, since for
COW writes we create a new extent map and drop the old one, and for
NOCOW we always check file extent items in the subvolume tree, not
using any extent maps in the range. That is, the extent maps aren't
needed for the writes.

And same as before, the inode will be the most recently used.

What ext4 and xfs are doing is just fine.
There's no need to complicate something that when triggered is when
the system is already under pressure and everything is already slow
due to the memory pressure.

> Then we can do our normal locking
> thing when we walk through the isolate list.
>
> >
> > 2) You may hate the inode rb-tree, but we don't have another way to
> > iterate over the inodes and be efficient to search for inodes starting
> > at a particular number.
> >
> > 3)  ->nr_cached_objects() and ->free_cached_objects() of the super
> > operations are a good alternative to registering our own shrinker.
> > I went with our own shrinker because it's what ext4 is doing and it's
> > simple. Changing to the super operations is fairly simple and I
> > embrace it.
> >
> > 4) That concern about LRU is not really that relevant as you think.
> >
> > Look at fs/super.c:super_cache_scan() (for when we define our
> > ->nr_cached_objects() and ->free_cached_objects() callbacks).
> >
> > Every time ->free_cached_objects() is called we do it for a number of
> > items we returned with ->nr_cached_objects().
> > That means we all go over all inodes and so going in LRU order or any
> > other order ends up being irrelevant.
> >
> > The same goes for the shrinker solution.
> >
> > Sure you can argue that in the time between calling
> > ->nr_cached_objects() and calling ->free_cached_objects() more extent
> > maps may have been created.
> > But that's not a big time window, not enough to add that many extent
> > maps to make any practical difference.
> > Plus when the shrinking is performed it's because we are under heavy
> > memory pressure and removing extent maps won't have that much impact
> > anyway, since page cache was freed amongst other things that have more
> > impact on performance than extent maps.
> >
> > This is probably why ext4 is following the same approach for its
> > extent_status structures as I did here (well, I followed their way of
> > doing things).
> > Those structures are in a rb tree of the inode, just like we do with
> > our extent maps.
> > And the inodes are in a regular linked list (struct
> > ext4_sb_info::s_es_list) and added with list_add_tail to that list -
> > they're never moved within the list (no LRU).
> > When the scan callback of the shrinker is invoked, it always iterates
> > the inodes in that list order - not LRU or anything "fancy".
> >
> >
> > So I'm okay with moving to an implementation based on
> > ->nr_cached_objects() and calling ->free_cached_objects(), that's
> > simple.
> > But iterating the inodes will have to be with the rb-tree, as we don't
> > have anything else that allows us to iterate and start at any given
> > number.
> > I can make it to remember the last scanned inode (and root) so that
> > the next time the shrinking happens it will start after that last
> > scanned inode.
> >
> > And adding our own lru implementation wouldn't make much difference
> > because of all that, and would also have 2 downsides to it:
> >
> > 1) We would need a struct list_head  (16 bytes) plus a pointer to the
> > inode (so that we can remove an extent map from the rb tree) added to
> > the extent_map structure, so 24 bytes overhead.
> >
> > 2) All the maintenance of the list, adding to it, removing from it,
> > moving elements, etc, all requires locking and overhead from lock
> > contention (using the struct list_lru API or our own).
> >
> > So my proposal is to do this:
> >
> > 1) Keep using the rb tree to search for inodes - this is abstracted by
> > an helper function used in 2 other places.
> > 2) Remember the last scanned inode/root, and on every scan start after
> > that inode.
> > 3) Use ->nr_cached_objects() and calling ->free_cached_objects()
> > instead of registering a shrinker.
> >
>
> I'm still looking for a way to delete our rb_tree in the future, it cause=
s us
> headaches with a lot of parallel file creates, but honestly other things =
are
> much worse than the rbtree right now.

I get it, I've thought sometime ago to replace it with an xarray or maple t=
ree.
The rb tree gets really deep after 100k inodes, plus all the cache
line pulling every time navigating the tree for a search or insertion.

On the other hand it's embedded in the inode, and unlike when using an
xarray or maple tree, doesn't require extra memory allocations for
insertions and dealing with allocation failures.
I will give it a try sometime after finishing the extent map shrinker.
After those preparatory patches it's all hidden in a helper function,
making the switch to some other data structure easy.

Thanks.

>
> This is fine with me, we're not getting rid of it anytime soon, as long a=
s we
> have a way to remember where we were then that's good enough for now and =
in
> keeping with all other existing reclaim implementations.  Thanks,
>
> Josef

