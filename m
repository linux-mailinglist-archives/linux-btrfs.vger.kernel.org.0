Return-Path: <linux-btrfs+bounces-4315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72018A7239
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 19:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A920D1C215A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2301339B1;
	Tue, 16 Apr 2024 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mV98KsJH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75E1332BC
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288360; cv=none; b=q3AWD239Ld+0u/m7GBMb8BPfLkRj8iG+eupZreLbGnzDaDzNu+WYTAsp4+NlbXtZg0t9AKBOxyX8iDzAL+2EACFm9rQrUy2VR1p4WF9QxJFn4DdHstLra2YtnyZNfmuu1sd6Bzq8vvfR7g1IowcHsyLDq4WXYLdrJMcyNPzD384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288360; c=relaxed/simple;
	bh=/kWlJSS7zBtJtDgV8EHoeQt3koCkXLMn2okRgHvcohw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf6i7Cf4OOS3G3WwwitK4ZpwWq/L7n39HAzHcHZ0yVFlv49+7a6rebZ5VkbkxzAWy83Emf4ftLq0/q+czxT0Olkn2Wl6iXPAJZf7r4VZvbBrYIEMFwWlSOQVKHZz5cDIdNw/ZHz7U+sxwj2+SFhNxLO5Kx2gbbHXV+nSMn3J81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=mV98KsJH; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4dac4791267so1548578e0c.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713288356; x=1713893156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2mTvmt2RHf+Cx+fN/+61PRl0LJepWHQcF3XxlfhqGDg=;
        b=mV98KsJHxZsz/xABC12NqQ/tN5EAW+Ots+lqbG+WeCYjfGI3Oy48Nf4ezZgs6bGLSc
         QODn1PGf2R5/vXCYwTRPit1dDoLq55jEp0BL2l9EBl7uKKcogVpwjDwQRA7AlxAgGqys
         vBZqQfMYTOmkZTq8Gd22xHBZ2qbtoERc6BypvtIIQP1VWQ/eij4E4r38NoFTDeSQmd2w
         /9Z3LBG+3s6TOVjyu95HJ5AG/kyFAlpyFE4A7COkHhvjeSOCTtcNY3DBFWKsDnRoKJV/
         fBfBi6VfMDFEwDJIM8eiDIS/5WSHxIB29rhvAlr5uSW9fRStolJWluEl8P0ezsHtc7jQ
         7tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713288356; x=1713893156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mTvmt2RHf+Cx+fN/+61PRl0LJepWHQcF3XxlfhqGDg=;
        b=nBBfvul8EDYXUGEW3R7Z2SSUMJEE5dIvCMXFnC3TH0kSBXoO3mrakLQ5pAREFkOVMI
         1HXz7Vv26QSqWixw3s0YRrqz11HmdMZU/rM9GSEgMI16+35l+sHmfgKt9NLEwZDHeOqU
         zTKoDLSuDPHVew2qHNNYCkgEjMoThSEoPNJ2B5zXLif9UlCSfDQOpQ7+K8w+URRmxuFf
         PKsKabDvhxvTH5+cXQuOodTLNTU/tIT1E+rang1o1JNLfLl68Dh8n4NfWJN/fIGACCm8
         QsjlRcK+U7th+dFhDJQBPDYKCRexB+A5TtGCQgU1pn1aBYk89IMd27FkvXen3vHgVnd2
         GpZw==
X-Gm-Message-State: AOJu0YxVVV79NoBMIJW7INFZHrtRni547pOjI9KIM48s/Z/rETyxkNuq
	z3mErx/sk3ytmXwW22kF623OaSRJaZVosgTAupGBiIlFYuRt+1KjXJMM4+s7BaEDYl3jEqRfgzh
	7
X-Google-Smtp-Source: AGHT+IEPlmhXWe+jXCyjnrZVEfbIIVIMW8v/oZY5AxWYobvJkwvJ09TChlhCDGCIzdrN1QZVtAGlkQ==
X-Received: by 2002:a05:6122:2009:b0:4da:a82e:95f5 with SMTP id l9-20020a056122200900b004daa82e95f5mr10387710vkd.5.1713288356331;
        Tue, 16 Apr 2024 10:25:56 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b12-20020ad4518c000000b0069b27dad8c7sm7519284qvp.101.2024.04.16.10.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:25:55 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:25:55 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 08/10] btrfs: add a shrinker for extent maps
Message-ID: <20240416172555.GA2094489@perftesting>
References: <cover.1713267925.git.fdmanana@suse.com>
 <4bfde54904b5a91a71eb0d86b9c78367865f93d8.1713267925.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bfde54904b5a91a71eb0d86b9c78367865f93d8.1713267925.git.fdmanana@suse.com>

On Tue, Apr 16, 2024 at 02:08:10PM +0100, fdmanana@kernel.org wrote:
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
> middle of a fast fsync). This shrinker is triggered through the callbacks
> nr_cached_objects and free_cached_objects of struct super_operations.
> 
> The shrinker will iterates over all roots and over all inodes of each
> root, and keeps track of the last scanned root and inode, so that the
> next time it runs, it starts from that root and from the next inode.
> This is similar to what xfs does for its inode reclaim (implements those
> callbacks, and cycles through inodes by starting from where it ended
> last time).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

This is great, thanks Filipe!

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

