Return-Path: <linux-btrfs+bounces-4242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052628A426C
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 15:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F0F1C20E78
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C9A374D4;
	Sun, 14 Apr 2024 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="owu/0J+A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14280446AC
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713099749; cv=none; b=k2W8KwSmI8ekW1vlXLl4z8URIXrtYmb8ynbgtOXSHuA6rhYuAUqDds73HycTQ4iOBbtEoUaTTxtEq1V600/Ga6wS3B1iFDgexvxeRPC8vhumZh07XUhXeXJ+drLANxuGrnTQSHzzituo7G4hvc0UuXXY3QjcwJo5IYNsQuzpAR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713099749; c=relaxed/simple;
	bh=hyZ0qtMabH4VWlbFBaBA3nyRntvZ3TcG8oZ9jXnWjd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbstqlzUNMVTUrD2AkD3AqGFhVp1y4/sIvwVgrCyYarBqoBAIJHChnp9GEd1MuXfoZKyN0lPYpQ0Ul+vTfnWHpSrqo1Nq0T6jz4qlDNBYREIS9m2SlTjPe05YrOeQG1U3ikGoLFW+7ddF8NTbSnp9PHxTfuRkjatI5djlRbzqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=owu/0J+A; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78edc3e80e6so82427885a.2
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713099746; x=1713704546; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SwANhHXykL62KAZNbPj9PBqfpCkWepRoz4wAcWu7gJw=;
        b=owu/0J+A4hKYTQKvOAj1iH4cEjlnoIjmgmR88/H0f0z7Qmfnw+aSnX3rgU6SznAU94
         mKBV+zHw2b+iKkHV0NWO7+ReppuJHv/m+KXQ21/5i1z3L4Jn6jDNTFvGda/Uh8CN4IFz
         UmOdJQqpIBOfC9HBMMxvnKwcDGAPiyMpw3uOe85MUO35tMIx4GoY4iK3XiBZUzanZAIy
         yquyLK3SOSeDzIavGRdIJ6s2w/CAwGVmOHLlQ3lx94BN7n/bVO+7Qo+Zzo6XkyoIkyN5
         qgKU6mAosfS7xCzj1HNhw2LVk5KXnyUnGNaQse2/3WJrjhItzQlg1hD9Jzvc0wEIy5Qn
         jJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713099746; x=1713704546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwANhHXykL62KAZNbPj9PBqfpCkWepRoz4wAcWu7gJw=;
        b=Gwzu+DliZcwvTXXOC7K3uBuEDK4AIRjos7plBS26MdtLFX0MuI+97drx4pzGstQCsF
         2NnNwc2uZ6OvlAa+ChvE4HuZj4DGjxerpJeSsuOmCxknlbLmY2l9P+ZqDIqTDGJjbhvX
         S6nrHvIY1hg8mHA+XFatENzOT03y1MOVfySHYIvyenrM4wCdD2/z7MFN9qfPu9WaQrlr
         0q5ZIuGIcYPn0iEETA9sR3aMX9TrO55rA3gxvpJEMJ2iTLKvRewcPEk48rACoQuFeFtO
         YNUFMPhDIWWf3fjixL6KOaCq5Z8JHW5Mtp4/qudYTMi5p88I2DBb3opbjTW5ps0NMNxc
         EUOw==
X-Gm-Message-State: AOJu0YyqwLaFASR70vcFij7W+2wzaDQvYnLV2I7CM0dneWWaAFEJOKOG
	lWKQYeGmEtmtpmuoq0p+XL+jb1fpczNnRolmz6kxY4Lo8Wy5h003EQGDB4WGNwCzVtphQPfnS/h
	O
X-Google-Smtp-Source: AGHT+IEeUd5JiiQeg2kmLDJfy+PU1xrT+8BZjw+71VS7d+mnVTEj85e6FZYvWwZZBfSXNmj3zgYKUA==
X-Received: by 2002:a05:620a:21d2:b0:78a:5eb3:8e3d with SMTP id h18-20020a05620a21d200b0078a5eb38e3dmr9055395qka.8.1713099745769;
        Sun, 14 Apr 2024 06:02:25 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a056700b0078d69b5d671sm4994234qkp.100.2024.04.14.06.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 06:02:25 -0700 (PDT)
Date: Sun, 14 Apr 2024 09:02:24 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 13/15] btrfs: add a shrinker for extent maps
Message-ID: <20240414130224.GB1930433@perftesting>
References: <cover.1712837044.git.fdmanana@suse.com>
 <1cb649870b6cad4411da7998735ab1141bb9f2f0.1712837044.git.fdmanana@suse.com>
 <20240412200657.GA1222511@perftesting>
 <CAL3q7H7VHRCKgh444KiAHYNg0ac8B+q9J1t7b_5zbd065=1ABw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7VHRCKgh444KiAHYNg0ac8B+q9J1t7b_5zbd065=1ABw@mail.gmail.com>

On Sat, Apr 13, 2024 at 12:07:30PM +0100, Filipe Manana wrote:
> On Fri, Apr 12, 2024 at 9:07 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Thu, Apr 11, 2024 at 05:19:07PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Extent maps are used either to represent existing file extent items, or to
> > > represent new extents that are going to be written and the respective file
> > > extent items are created when the ordered extent completes.
> > >
> > > We currently don't have any limit for how many extent maps we can have,
> > > neither per inode nor globally. Most of the time this not too noticeable
> > > because extent maps are removed in the following situations:
> > >
> > > 1) When evicting an inode;
> > >
> > > 2) When releasing folios (pages) through the btrfs_release_folio() address
> > >    space operation callback.
> > >
> > >    However we won't release extent maps in the folio range if the folio is
> > >    either dirty or under writeback or if the inode's i_size is less than
> > >    or equals to 16M (see try_release_extent_mapping(). This 16M i_size
> > >    constraint was added back in 2008 with commit 70dec8079d78 ("Btrfs:
> > >    extent_io and extent_state optimizations"), but there's no explanation
> > >    about why we have it or why the 16M value.
> > >
> > > This means that for buffered IO we can reach an OOM situation due to too
> > > many extent maps if either of the following happens:
> > >
> > > 1) There's a set of tasks constantly doing IO on many files with a size
> > >    not larger than 16M, specially if they keep the files open for very
> > >    long periods, therefore preventing inode eviction.
> > >
> > >    This requires a really high number of such files, and having many non
> > >    mergeable extent maps (due to random 4K writes for example) and a
> > >    machine with very little memory;
> > >
> > > 2) There's a set tasks constantly doing random write IO (therefore
> > >    creating many non mergeable extent maps) on files and keeping them
> > >    open for long periods of time, so inode eviction doesn't happen and
> > >    there's always a lot of dirty pages or pages under writeback,
> > >    preventing btrfs_release_folio() from releasing the respective extent
> > >    maps.
> > >
> > > This second case was actually reported in the thread pointed by the Link
> > > tag below, and it requires a very large file under heavy IO and a machine
> > > with very little amount of RAM, which is probably hard to happen in
> > > practice in a real world use case.
> > >
> > > However when using direct IO this is not so hard to happen, because the
> > > page cache is not used, and therefore btrfs_release_folio() is never
> > > called. Which means extent maps are dropped only when evicting the inode,
> > > and that means that if we have tasks that keep a file descriptor open and
> > > keep doing IO on a very large file (or files), we can exhaust memory due
> > > to an unbounded amount of extent maps. This is especially easy to happen
> > > if we have a huge file with millions of small extents and their extent
> > > maps are not mergeable (non contiguous offsets and disk locations).
> > > This was reported in that thread with the following fio test:
> > >
> > >    $ cat test.sh
> > >    #!/bin/bash
> > >
> > >    DEV=/dev/sdj
> > >    MNT=/mnt/sdj
> > >    MOUNT_OPTIONS="-o ssd"
> > >    MKFS_OPTIONS=""
> > >
> > >    cat <<EOF > /tmp/fio-job.ini
> > >    [global]
> > >    name=fio-rand-write
> > >    filename=$MNT/fio-rand-write
> > >    rw=randwrite
> > >    bs=4K
> > >    direct=1
> > >    numjobs=16
> > >    fallocate=none
> > >    time_based
> > >    runtime=90000
> > >
> > >    [file1]
> > >    size=300G
> > >    ioengine=libaio
> > >    iodepth=16
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
> > >                         /sys/kernel/slab/btrfs_extent_map/total_objects'
> > >
> > > Shows the number of active and total extent maps skyrocketing to tens of
> > > millions, and on systems with a short amount of memory it's easy and quick
> > > to get into an OOM situation, as reported in that thread.
> > >
> > > So to avoid this issue add a shrinker that will remove extents maps, as
> > > long as they are not pinned, and takes proper care with any concurrent
> > > fsync to avoid missing extents (setting the full sync flag while in the
> > > middle of a fast fsync). This shrinker is similar to the one ext4 uses
> > > for its extent_status structure, which is analogous to btrfs' extent_map
> > > structure.
> > >
> > > Link: https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d42c55e@amazon.com/
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > I don't like this for a few reasons
> >
> > 1. We're always starting with the first root and the first inode.  We're just
> >    going to constantly screw that first inode over and over again.
> > 2. I really, really hate our inode rb-tree, I want to reduce it's use, not add
> >    more users.  It would be nice if we could just utilize ->s_inodes_lru instead
> >    for this, which would also give us the nice advantage of not having to think
> >    about order since it's already in LRU order.
> > 3. We're registering our own shrinker without a proper LRU setup.  I think it
> >    would make sense if we wanted to have a LRU for our extent maps, but I think
> >    that's not a great idea.  We could get the same benefit by adding our own
> >    ->nr_cached_objects() and ->free_cached_objects(), I think that's a better
> >    approach no matter what other changes you make instead of registering our own
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

Agreed, but at least it'll be in LRU order, we'll be visiting each inode in
their LRU order.  If the first inode hasn't changed position then it hasn't been
accessed in a while.

We absolutely would need to use the isolate mechanism, I think we would just add
a counter to the extent_io_tree to see how many extent states there are, and we
skip anything that's already been drained.  Then we can do our normal locking
thing when we walk through the isolate list.

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

I'm still looking for a way to delete our rb_tree in the future, it causes us
headaches with a lot of parallel file creates, but honestly other things are
much worse than the rbtree right now.

This is fine with me, we're not getting rid of it anytime soon, as long as we
have a way to remember where we were then that's good enough for now and in
keeping with all other existing reclaim implementations.  Thanks,

Josef 

