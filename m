Return-Path: <linux-btrfs+bounces-4199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC558A36B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 22:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A16128360D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 20:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA801509B5;
	Fri, 12 Apr 2024 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rVhPfGXr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1D14F9D6
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712952422; cv=none; b=spAyW7xowQFcWGnLG39RvQsjnr+nLrl10qHQXG2v5+u5uqdUwfnylQIuP08UC6yQlxc2R6h6FOysfz/tygSsQ1yXe029ozALNQujADH7okJiRZMP9GUhJ+t8/BxAVJ0kfo7VG1RfYYqGWwVLXhV6vkyJS6tJM+vh86wYkcx72Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712952422; c=relaxed/simple;
	bh=wNGPd6zmxsSOZvB1Y9+rixXvra8fmaco8/6xNltH2Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qncs1do89GGqDyWUBZWl0Jj0nXuiHnjqDTIF+E5p1gIvjhVPbAko3emySQLST+eA3aR2yHH5COuixoWUkuS9wcSz7teXL7+wW7TKi9nsd4AYMnuW8tT3K0fmSHbQH5/tb6wSTHEck8Z46ETNk2JgwRhnaTOYnrd+CKTGPyd35I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rVhPfGXr; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d5751901bso88143385a.1
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1712952419; x=1713557219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2adXF7SakD5Sp9oQK7Fg5NWHJFJq783c1g6ZtzWtXWs=;
        b=rVhPfGXreer+M4kMlhQlpR68Miwdt+6DPkl+c14/LQr2uk3h7oSXlH3pbetW/wFuhC
         F4vcrmVoW4m+OpVe4+MK3SzZU88o5aVXBne5Yk8oHfXvhdfSZqhHnPJC+V6KvqNshbLM
         +RqZqnE/C1HHwkOqIkCUCeR7TyzvqV/vh0PU9brJjoRvP6fEoEathjA4ZVo4LaV5VwW+
         7fZSnCu+cPSGPhlxdU8VPA/3rVfn/9ZIVMvT8B/3brF56CcZM60irGWK6VBYo+OZS0K8
         q9x/D76wANsQyqUV01P2p8EVDsiMuEMtncHMEFY8VbYFZXzq42Rk5o1jdw2Al1thPhbk
         p+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712952419; x=1713557219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2adXF7SakD5Sp9oQK7Fg5NWHJFJq783c1g6ZtzWtXWs=;
        b=r0fxPfk5yebyxjNYJe4SUbKo9kHC24IxA1+ZVh3M4JTKwzbaC5qq3OHkYDhyjJ6oab
         dX0yRQR85fmWHTruTWQNbgPYpxUWLPYelz/Br3MPjDdiIv6YICDqNIdYDwg74FYv/lta
         KLBihVwtppxMWgqX/D5LRdCeY19GiWUsjAPDKO5V/DWLYtMAmWgVm6CI77z2h6dNE4rR
         Ihbx0xFSXi6NdjvkrXgzcTLu9T3xD8I1Ek3d6EqbisYgNU2jG6MgtsHB2tzInbjn4OW4
         xGzsk3zjieOsRPrYX0BrBMLmqib7Sta0cZNLlbXXF3tIvuWYr46PaIAm1lYjMiEIbxFQ
         YzxQ==
X-Gm-Message-State: AOJu0YwiC5rZOVWHBJ/uyc2WGGsAmGSoDLoPG/zt+3ZFNiG+dCvxQaXj
	7q295mes6R3tiH58nJqOPcp8mXwYssfExn7W48LEM0Q9BdvDFJ7aWithWuNArT7ODd2uPmVs+m9
	q
X-Google-Smtp-Source: AGHT+IGYmtb8GHFoZCf1Fx2xF3uJbgSNmtHlw1Kd/8BAkVciqts5hJbOiDKDcKbQYOflUo6R0mgZNA==
X-Received: by 2002:ae9:e201:0:b0:78d:61e8:7421 with SMTP id c1-20020ae9e201000000b0078d61e87421mr4055886qkc.5.1712952419297;
        Fri, 12 Apr 2024 13:06:59 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m3-20020ae9e003000000b0078d4bca760asm2818046qkk.34.2024.04.12.13.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:06:58 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:06:57 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 13/15] btrfs: add a shrinker for extent maps
Message-ID: <20240412200657.GA1222511@perftesting>
References: <cover.1712837044.git.fdmanana@suse.com>
 <1cb649870b6cad4411da7998735ab1141bb9f2f0.1712837044.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb649870b6cad4411da7998735ab1141bb9f2f0.1712837044.git.fdmanana@suse.com>

On Thu, Apr 11, 2024 at 05:19:07PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Extent maps are used either to represent existing file extent items, or to
> represent new extents that are going to be written and the respective file
> extent items are created when the ordered extent completes.
> 
> We currently don't have any limit for how many extent maps we can have,
> neither per inode nor globally. Most of the time this not too noticeable
> because extent maps are removed in the following situations:
> 
> 1) When evicting an inode;
> 
> 2) When releasing folios (pages) through the btrfs_release_folio() address
>    space operation callback.
> 
>    However we won't release extent maps in the folio range if the folio is
>    either dirty or under writeback or if the inode's i_size is less than
>    or equals to 16M (see try_release_extent_mapping(). This 16M i_size
>    constraint was added back in 2008 with commit 70dec8079d78 ("Btrfs:
>    extent_io and extent_state optimizations"), but there's no explanation
>    about why we have it or why the 16M value.
> 
> This means that for buffered IO we can reach an OOM situation due to too
> many extent maps if either of the following happens:
> 
> 1) There's a set of tasks constantly doing IO on many files with a size
>    not larger than 16M, specially if they keep the files open for very
>    long periods, therefore preventing inode eviction.
> 
>    This requires a really high number of such files, and having many non
>    mergeable extent maps (due to random 4K writes for example) and a
>    machine with very little memory;
> 
> 2) There's a set tasks constantly doing random write IO (therefore
>    creating many non mergeable extent maps) on files and keeping them
>    open for long periods of time, so inode eviction doesn't happen and
>    there's always a lot of dirty pages or pages under writeback,
>    preventing btrfs_release_folio() from releasing the respective extent
>    maps.
> 
> This second case was actually reported in the thread pointed by the Link
> tag below, and it requires a very large file under heavy IO and a machine
> with very little amount of RAM, which is probably hard to happen in
> practice in a real world use case.
> 
> However when using direct IO this is not so hard to happen, because the
> page cache is not used, and therefore btrfs_release_folio() is never
> called. Which means extent maps are dropped only when evicting the inode,
> and that means that if we have tasks that keep a file descriptor open and
> keep doing IO on a very large file (or files), we can exhaust memory due
> to an unbounded amount of extent maps. This is especially easy to happen
> if we have a huge file with millions of small extents and their extent
> maps are not mergeable (non contiguous offsets and disk locations).
> This was reported in that thread with the following fio test:
> 
>    $ cat test.sh
>    #!/bin/bash
> 
>    DEV=/dev/sdj
>    MNT=/mnt/sdj
>    MOUNT_OPTIONS="-o ssd"
>    MKFS_OPTIONS=""
> 
>    cat <<EOF > /tmp/fio-job.ini
>    [global]
>    name=fio-rand-write
>    filename=$MNT/fio-rand-write
>    rw=randwrite
>    bs=4K
>    direct=1
>    numjobs=16
>    fallocate=none
>    time_based
>    runtime=90000
> 
>    [file1]
>    size=300G
>    ioengine=libaio
>    iodepth=16
> 
>    EOF
> 
>    umount $MNT &> /dev/null
>    mkfs.btrfs -f $MKFS_OPTIONS $DEV
>    mount $MOUNT_OPTIONS $DEV $MNT
> 
>    fio /tmp/fio-job.ini
>    umount $MNT
> 
> Monitoring the btrfs_extent_map slab while running the test with:
> 
>    $ watch -d -n 1 'cat /sys/kernel/slab/btrfs_extent_map/objects \
>                         /sys/kernel/slab/btrfs_extent_map/total_objects'
> 
> Shows the number of active and total extent maps skyrocketing to tens of
> millions, and on systems with a short amount of memory it's easy and quick
> to get into an OOM situation, as reported in that thread.
> 
> So to avoid this issue add a shrinker that will remove extents maps, as
> long as they are not pinned, and takes proper care with any concurrent
> fsync to avoid missing extents (setting the full sync flag while in the
> middle of a fast fsync). This shrinker is similar to the one ext4 uses
> for its extent_status structure, which is analogous to btrfs' extent_map
> structure.
> 
> Link: https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d42c55e@amazon.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

I don't like this for a few reasons

1. We're always starting with the first root and the first inode.  We're just
   going to constantly screw that first inode over and over again.
2. I really, really hate our inode rb-tree, I want to reduce it's use, not add
   more users.  It would be nice if we could just utilize ->s_inodes_lru instead
   for this, which would also give us the nice advantage of not having to think
   about order since it's already in LRU order.
3. We're registering our own shrinker without a proper LRU setup.  I think it
   would make sense if we wanted to have a LRU for our extent maps, but I think
   that's not a great idea.  We could get the same benefit by adding our own
   ->nr_cached_objects() and ->free_cached_objects(), I think that's a better
   approach no matter what other changes you make instead of registering our own
   shrinker.

The concept I whole heartedly agree with, this just needs some tweaks to be more
fair and cleaner.  The rest of the code is fine, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the rest of it.  Thanks,

Josef

