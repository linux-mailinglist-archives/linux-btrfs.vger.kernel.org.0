Return-Path: <linux-btrfs+bounces-4239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD038A41D9
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 12:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCEA1C209FC
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 10:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2812BCF9;
	Sun, 14 Apr 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfsbqciC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FE17C73
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713091130; cv=none; b=PHWOkMeJGcMTodDHsYobwgVg9Qyr6P6p93n16rovj3h8vM/2StnHb4+dT26+VwXh9Lj+5o4iTotC+lc7yvMBT0z+6MYT66WMcBCdpwrCZl/ynhbr0bDP1Xsv55T2uSgp/SEOF6XMya49zoyhg0CAgX914eT0j7SWwmKRPFOVS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713091130; c=relaxed/simple;
	bh=bT7+JZcLqMnk9cEG0aBToqKND3Ss88G2nnJSaOWQ2Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEFBltBQpSm9BQblzIN48mD0y9BQkrxeiew5JETjYy0IvI2ZLgbWTBn0b6e7HBjOjVA/6HVJl9vzLupieEGW1yNwL9Y4sk9LLdq5jD3Hiof6OOMMQwm7Bjzb35MioRV4SkAQ5Qz2Jkl3t9DJEk37PEUvhmt+MWxcOnssGu8d2nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfsbqciC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99E3C3277B
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713091129;
	bh=bT7+JZcLqMnk9cEG0aBToqKND3Ss88G2nnJSaOWQ2Eo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BfsbqciCSG3G6pmtTbSqwPuUFUjWfeK2jUelck0ckWaOGG5gOYBj0SM2oyvPXG3+b
	 cAqK0M0HpViE1xzI8gp5ueK/QAt/Ld1+3VEpD/stlfy4aKsP/uB4vjgAJnKUsXJ1vM
	 g2UHOCKe2pxhfKc98NlWGVtZrfo6gWN34iWEaZn/IQUTdYnTlSqxkVkzoUnv2b2MPm
	 tLk0xgkpuhp/J3FIP5AZicMt7RHThvFbEyn204nD80XJx7BDmzZNWSrhmPWh/pwJ9A
	 sFuqAjLXZB2AYKy/ADHu9JgUr6hynWs8nxtsfiFyOMWqs9va58vTcy7+k2QUrKYySa
	 0YuoOeoa70uLQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a526a200879so482866b.1
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 03:38:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YzuCDgxiT/mb0WWb33oxIonFxkCcseoNHHvfJR16ZNNr6k8Pczg
	dY1mUYT+T7s+cFUpKNAj8zm5IM4qBDmyGJXDZNnbl0ZQDONh0XySCbKMcIu+CI/DLuv4Pz3Ipn0
	xQjrLYasAkQdOVMBMLQbcNkY+vZ4=
X-Google-Smtp-Source: AGHT+IEPu6JkC8jrWdNX9Uxa8bJ9WWhjW3D4lc4fN5HlBU5LoPy2RCOL/JNwmXsIId/xdClqp3HofWnEGqezLdVemyg=
X-Received: by 2002:a17:906:dc92:b0:a4a:aaa9:8b3b with SMTP id
 cs18-20020a170906dc9200b00a4aaaa98b3bmr5284349ejc.77.1713091128117; Sun, 14
 Apr 2024 03:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712837044.git.fdmanana@suse.com> <1cb649870b6cad4411da7998735ab1141bb9f2f0.1712837044.git.fdmanana@suse.com>
 <20240412200657.GA1222511@perftesting> <CAL3q7H7VHRCKgh444KiAHYNg0ac8B+q9J1t7b_5zbd065=1ABw@mail.gmail.com>
In-Reply-To: <CAL3q7H7VHRCKgh444KiAHYNg0ac8B+q9J1t7b_5zbd065=1ABw@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 14 Apr 2024 11:38:11 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7aj=Zrj+En2u=yy5+_p=8o8u5D5EO9Tdh1pxXXA=Kcjw@mail.gmail.com>
Message-ID: <CAL3q7H7aj=Zrj+En2u=yy5+_p=8o8u5D5EO9Tdh1pxXXA=Kcjw@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] btrfs: add a shrinker for extent maps
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 12:07=E2=80=AFPM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Fri, Apr 12, 2024 at 9:07=E2=80=AFPM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > On Thu, Apr 11, 2024 at 05:19:07PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Extent maps are used either to represent existing file extent items, =
or to
> > > represent new extents that are going to be written and the respective=
 file
> > > extent items are created when the ordered extent completes.
> > >
> > > We currently don't have any limit for how many extent maps we can hav=
e,
> > > neither per inode nor globally. Most of the time this not too noticea=
ble
> > > because extent maps are removed in the following situations:
> > >
> > > 1) When evicting an inode;
> > >
> > > 2) When releasing folios (pages) through the btrfs_release_folio() ad=
dress
> > >    space operation callback.
> > >
> > >    However we won't release extent maps in the folio range if the fol=
io is
> > >    either dirty or under writeback or if the inode's i_size is less t=
han
> > >    or equals to 16M (see try_release_extent_mapping(). This 16M i_siz=
e
> > >    constraint was added back in 2008 with commit 70dec8079d78 ("Btrfs=
:
> > >    extent_io and extent_state optimizations"), but there's no explana=
tion
> > >    about why we have it or why the 16M value.
> > >
> > > This means that for buffered IO we can reach an OOM situation due to =
too
> > > many extent maps if either of the following happens:
> > >
> > > 1) There's a set of tasks constantly doing IO on many files with a si=
ze
> > >    not larger than 16M, specially if they keep the files open for ver=
y
> > >    long periods, therefore preventing inode eviction.
> > >
> > >    This requires a really high number of such files, and having many =
non
> > >    mergeable extent maps (due to random 4K writes for example) and a
> > >    machine with very little memory;
> > >
> > > 2) There's a set tasks constantly doing random write IO (therefore
> > >    creating many non mergeable extent maps) on files and keeping them
> > >    open for long periods of time, so inode eviction doesn't happen an=
d
> > >    there's always a lot of dirty pages or pages under writeback,
> > >    preventing btrfs_release_folio() from releasing the respective ext=
ent
> > >    maps.
> > >
> > > This second case was actually reported in the thread pointed by the L=
ink
> > > tag below, and it requires a very large file under heavy IO and a mac=
hine
> > > with very little amount of RAM, which is probably hard to happen in
> > > practice in a real world use case.
> > >
> > > However when using direct IO this is not so hard to happen, because t=
he
> > > page cache is not used, and therefore btrfs_release_folio() is never
> > > called. Which means extent maps are dropped only when evicting the in=
ode,
> > > and that means that if we have tasks that keep a file descriptor open=
 and
> > > keep doing IO on a very large file (or files), we can exhaust memory =
due
> > > to an unbounded amount of extent maps. This is especially easy to hap=
pen
> > > if we have a huge file with millions of small extents and their exten=
t
> > > maps are not mergeable (non contiguous offsets and disk locations).
> > > This was reported in that thread with the following fio test:
> > >
> > >    $ cat test.sh
> > >    #!/bin/bash
> > >
> > >    DEV=3D/dev/sdj
> > >    MNT=3D/mnt/sdj
> > >    MOUNT_OPTIONS=3D"-o ssd"
> > >    MKFS_OPTIONS=3D""
> > >
> > >    cat <<EOF > /tmp/fio-job.ini
> > >    [global]
> > >    name=3Dfio-rand-write
> > >    filename=3D$MNT/fio-rand-write
> > >    rw=3Drandwrite
> > >    bs=3D4K
> > >    direct=3D1
> > >    numjobs=3D16
> > >    fallocate=3Dnone
> > >    time_based
> > >    runtime=3D90000
> > >
> > >    [file1]
> > >    size=3D300G
> > >    ioengine=3Dlibaio
> > >    iodepth=3D16
> > >
> > >    EOF
> > >
> > >    umount $MNT &> /dev/null
> > >    mkfs.btrfs -f $MKFS_OPTIONS $DEV
> > >    mount $MOUNT_OPTIONS $DEV $MNT
> > >
> > >    fio /tmp/fio-job.ini
> > >    umount $MNT
> > >
> > > Monitoring the btrfs_extent_map slab while running the test with:
> > >
> > >    $ watch -d -n 1 'cat /sys/kernel/slab/btrfs_extent_map/objects \
> > >                         /sys/kernel/slab/btrfs_extent_map/total_objec=
ts'
> > >
> > > Shows the number of active and total extent maps skyrocketing to tens=
 of
> > > millions, and on systems with a short amount of memory it's easy and =
quick
> > > to get into an OOM situation, as reported in that thread.
> > >
> > > So to avoid this issue add a shrinker that will remove extents maps, =
as
> > > long as they are not pinned, and takes proper care with any concurren=
t
> > > fsync to avoid missing extents (setting the full sync flag while in t=
he
> > > middle of a fast fsync). This shrinker is similar to the one ext4 use=
s
> > > for its extent_status structure, which is analogous to btrfs' extent_=
map
> > > structure.
> > >
> > > Link: https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d4=
2c55e@amazon.com/
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > I don't like this for a few reasons
> >
> > 1. We're always starting with the first root and the first inode.  We'r=
e just
> >    going to constantly screw that first inode over and over again.
> > 2. I really, really hate our inode rb-tree, I want to reduce it's use, =
not add
> >    more users.  It would be nice if we could just utilize ->s_inodes_lr=
u instead
> >    for this, which would also give us the nice advantage of not having =
to think
> >    about order since it's already in LRU order.
> > 3. We're registering our own shrinker without a proper LRU setup.  I th=
ink it
> >    would make sense if we wanted to have a LRU for our extent maps, but=
 I think
> >    that's not a great idea.  We could get the same benefit by adding ou=
r own
> >    ->nr_cached_objects() and ->free_cached_objects(), I think that's a =
better
> >    approach no matter what other changes you make instead of registerin=
g our own
> >    shrinker.
>
> Ok, so some comments about all that.
>
> Using sb->s_inode_lru, which has the struct list_lru type is complicated.
> I had considered that some time ago, and here are the problems with it:
>
> 1) List iteration, done with list_lru_walk() (or one of its variants),
> is done while holding the lru list's spinlock.
>
> This means we can't remove all extents maps in one go as that will
> take too much time if we have millions of them for example, and make
> other tasks spin for too long on the lock.
>
> We will also need to take the inode's mmap semaphore which is a
> blocking operation, so we can't do it while under the spinlock.
>
> Sure, the lru list iteration's callback (the "isolate" argument of
> type list_lru_walk_cb) can release that lru list spinlock, do the
> extent map iteration and removal, then lock it again and return
> LRU_RETRY.
> But that will restart the search from the first element in the lru
> list. This means we can be iterating over the same inodes over and
> over.
>
> 2) You may hate the inode rb-tree, but we don't have another way to
> iterate over the inodes and be efficient to search for inodes starting
> at a particular number.
>
> 3)  ->nr_cached_objects() and ->free_cached_objects() of the super
> operations are a good alternative to registering our own shrinker.
> I went with our own shrinker because it's what ext4 is doing and it's
> simple. Changing to the super operations is fairly simple and I
> embrace it.
>
> 4) That concern about LRU is not really that relevant as you think.
>
> Look at fs/super.c:super_cache_scan() (for when we define our
> ->nr_cached_objects() and ->free_cached_objects() callbacks).
>
> Every time ->free_cached_objects() is called we do it for a number of
> items we returned with ->nr_cached_objects().
> That means we all go over all inodes and so going in LRU order or any
> other order ends up being irrelevant.
>
> The same goes for the shrinker solution.
>
> Sure you can argue that in the time between calling
> ->nr_cached_objects() and calling ->free_cached_objects() more extent
> maps may have been created.
> But that's not a big time window, not enough to add that many extent
> maps to make any practical difference.
> Plus when the shrinking is performed it's because we are under heavy
> memory pressure and removing extent maps won't have that much impact
> anyway, since page cache was freed amongst other things that have more
> impact on performance than extent maps.
>
> This is probably why ext4 is following the same approach for its
> extent_status structures as I did here (well, I followed their way of
> doing things).
> Those structures are in a rb tree of the inode, just like we do with
> our extent maps.
> And the inodes are in a regular linked list (struct
> ext4_sb_info::s_es_list) and added with list_add_tail to that list -
> they're never moved within the list (no LRU).
> When the scan callback of the shrinker is invoked, it always iterates
> the inodes in that list order - not LRU or anything "fancy".

Another example is xfs, which implements a ->nr_cached_objects() and
->free_cached_objects().
From xfs_fs_free_cached_objects() we end up at xfs_icwalk_ag, where it
walks inodes in the order they are in a radix tree, not in LRU order.
It does however keep track of the last index processed so that the
next time it is called, it starts from that index, but definitely not
LRU.

>
>
> So I'm okay with moving to an implementation based on
> ->nr_cached_objects() and calling ->free_cached_objects(), that's
> simple.
> But iterating the inodes will have to be with the rb-tree, as we don't
> have anything else that allows us to iterate and start at any given
> number.
> I can make it to remember the last scanned inode (and root) so that
> the next time the shrinking happens it will start after that last
> scanned inode.
>
> And adding our own lru implementation wouldn't make much difference
> because of all that, and would also have 2 downsides to it:
>
> 1) We would need a struct list_head  (16 bytes) plus a pointer to the
> inode (so that we can remove an extent map from the rb tree) added to
> the extent_map structure, so 24 bytes overhead.
>
> 2) All the maintenance of the list, adding to it, removing from it,
> moving elements, etc, all requires locking and overhead from lock
> contention (using the struct list_lru API or our own).
>
> So my proposal is to do this:
>
> 1) Keep using the rb tree to search for inodes - this is abstracted by
> an helper function used in 2 other places.
> 2) Remember the last scanned inode/root, and on every scan start after
> that inode.
> 3) Use ->nr_cached_objects() and calling ->free_cached_objects()
> instead of registering a shrinker.
>
> What do you think?
> Thanks.
>
> >
> > The concept I whole heartedly agree with, this just needs some tweaks t=
o be more
> > fair and cleaner.  The rest of the code is fine, you can add
> >
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> >
> > to the rest of it.  Thanks,
> >
> > Josef

