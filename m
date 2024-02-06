Return-Path: <linux-btrfs+bounces-2168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E64784BE73
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 21:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC681B247A7
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 20:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE117BB3;
	Tue,  6 Feb 2024 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+PtUjyn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF17179A7
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250372; cv=none; b=bdp4OA4Q1IIpYoesMMo6f20EqQ6vUVMgXG4SxS8mwRBBpN+eJL3ScObCBi9cOb/t5sLcgXMPgY4q6UwGKX8RHp7z+VqPFQP62HZElh+3y0ob9OOcP+w60T6t3ZgJ5RAJs89F6O2xZffMp1M7kKJgUCz2yY/EHOPtsxNE4Q0ulwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250372; c=relaxed/simple;
	bh=cPESSeJpb5thhU44xJ+O7NxUpWZCe0351rFh09HzLOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXaawFJL0Vpaya7LtuAn3qj2cw3NSfPw9/31i4WJyhERfItnTavYSS4PVq9w6iCQ9QOpbOfDOCVd3aVl58kX7wpISD5Kz3zkRncVw0iZs66UquOWgV973yMszqG6KeOEl6G31ERNXKVf1fH5UCgyu35abLGWSCfjIv2hhXo1Pl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+PtUjyn; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7ce55932330so2344253241.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Feb 2024 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707250369; x=1707855169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5dCurCsdHPaoODyPcCs8I6Oa6JxUR/sdSt2yorNOwQ=;
        b=j+PtUjynxoDmPKKov7J+LpuIOudZqjHE6bKJxtrgBYHt0FVIHcGDqXfRQamES5Upgr
         AP2tD/llEpTl3Y0SPnJZcHotrKV1Uf0sQlRgE0j0B/aIZm9Zqnyqc8cfwMYwUZZcO0SC
         tNO8v7I28BpJBdJbS3a/7vfAzwxVugaiLyRIJ33VOwChIgKE0hZZGmd9HVxhjjpQ7GQ9
         LNEGAdW7yea/VXuc9E+IHXvgJkxMDIhR/hlHhAmvUFsG6yHNut9VtQLTQI52+FA6Xa73
         O2wq37t9i/Hgf1h+HuVmv8gunH2z2kcddbJVphHb56lO58ftD8EOdk6pNaFLBipeQ2Gt
         aryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707250369; x=1707855169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5dCurCsdHPaoODyPcCs8I6Oa6JxUR/sdSt2yorNOwQ=;
        b=ENYNyooiaxaJy+PKMacw6TGT2iqpuZeL9Bpd1YJV9oqHaGpi7O6B7MN6wdJdTBoJJn
         ZRT8ngzm51GiE/x7LtEfOlRdejyl7boF2+t6PweCRO7j8Sya65lKyqgJLrpZ2JjWdpaq
         leVfm8h8NPmEqFWS1PzER4xthTPobh20INkRUEnN8anKIIdgXti5pRZ47ZxPFzNOLasl
         2YVO2FCisCahPFQ2ZPCIO0JbiTm8VXleuNxri3/BIIrcgfaVx91lk7pt9YOpXOV3Ohuu
         G8C8qf928GmGS6GGLbJg6pQn3zlxE6QGtcO4AchbkCR1GC5hphhR/G4slHXO8DgawxDU
         FWhg==
X-Gm-Message-State: AOJu0Yztcsufh5eOjcelc0NWMb++cDjFyYsS+nidw3UvKPTQ3VxYQj46
	DgKm94hG1/e1AQ07eIiOWEaMAtDhVPfMbK+emz2K2kI5iDYEpzdz
X-Google-Smtp-Source: AGHT+IFMYR1HklvQ+QA1DKnazGk59YVfmgcop97mLQuvsN0bp/K3LuR4jBYemPoqX8Ok/gWDsKNQ2A==
X-Received: by 2002:a05:6102:1250:b0:46d:1b2e:79cf with SMTP id p16-20020a056102125000b0046d1b2e79cfmr556602vsg.17.1707250369295;
        Tue, 06 Feb 2024 12:12:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUAtEC/6O8ipCVxVl9jbTOyAP4jK/f9lB/z4G2G2ZKE0Qy3unw/1gek0M6sxwv2Kpu48+dvxjR64kWPL1U=
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id pc15-20020a056214488f00b0068cb2db122bsm968910qvb.57.2024.02.06.12.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:12:49 -0800 (PST)
Sender: Tavian Barnes <tavianator@gmail.com>
From: Tavian Barnes <tavianator@tavianator.com>
To: quwenruo.btrfs@gmx.com
Cc: linux-btrfs@vger.kernel.org,
	wqu@suse.com
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit something wrong
Date: Tue,  6 Feb 2024 15:12:47 -0500
Message-ID: <20240206201247.4120-1-tavianator@tavianator.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8932de78-729c-431a-b371-a858e986066d@gmx.com>
References: <8932de78-729c-431a-b371-a858e986066d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 6 Feb 2024 16:24:32 +1030, Qu Wenruo wrote:
> On 2024/2/6 14:08, tavianator@tavianator.com wrote:
> > Here's the corresponding dmesg output:
> >
> >      page:00000000789c68b4 refcount:4 mapcount:0 mapping:00000000ce99bfc3 index:0x7df93c74 pfn:0x1269558
> >      memcg:ffff9f20d10df000
> >      aops:btree_aops [btrfs] ino:1
> >      flags: 0x12ffff180000820c(referenced|uptodate|workingset|private|node=2|zone=2|lastcpupid=0xffff)
> >      page_type: 0xffffffff()
> >      raw: 12ffff180000820c 0000000000000000 dead000000000122 ffff9f118586feb8
> >      raw: 000000007df93c74 ffff9f2232376e80 00000004ffffffff ffff9f20d10df000
> >      page dumped because: eb page dump
> >      BTRFS critical (device dm-1): corrupted leaf, root=709 block=8656838410240 owner mismatch, have 2694891690930195334 expect [256, 18446744073709551360]
>
> The page index and eb->start matches page index, so that page attaching
> part is correct.
>
> And the refcount is also 4, which matches the common case.
>
> Although I still need to check the extra flags for workingset.

I did get some other splats with refcount:3, e.g.

    page:000000005ca43abb refcount:3 mapcount:0 mapping:00000000ce99bfc3 index:0x8eb49f38 pfn:0x17e8520
    page:000000005ca43abb refcount:3 mapcount:0 mapping:00000000ce99bfc3 index:0x8eb49f38 pfn:0x17e8520
    memcg:ffff9f211ab95000
    page:000000005ca43abb refcount:3 mapcount:0 mapping:00000000ce99bfc3 index:0x8eb49f38 pfn:0x17e8520
    memcg:ffff9f211ab95000
    page:000000005ca43abb refcount:3 mapcount:0 mapping:00000000ce99bfc3 index:0x8eb49f38 pfn:0x17e8520
    memcg:ffff9f211ab95000
    memcg:ffff9f211ab95000
    page:000000005ca43abb refcount:3 mapcount:0 mapping:00000000ce99bfc3 index:0x8eb49f38 pfn:0x17e8520
    memcg:ffff9f211ab95000
    BTRFS critical (device dm-1): inode mode mismatch with dir: inode mode=042255 btrfs type=2 dir type=1
    aops:btree_aops [btrfs] ino:1
    aops:btree_aops [btrfs] ino:1
    aops:btree_aops [btrfs] ino:1
    aops:btree_aops [btrfs] ino:1
    aops:btree_aops [btrfs] ino:1
    flags: 0x12ffff580000822c(referenced|uptodate|lru|workingset|private|node=2|zone=2|lastcpupid=0xffff)
    flags: 0x12ffff580000822c(referenced|uptodate|lru|workingset|private|node=2|zone=2|lastcpupid=0xffff)
    page_type: 0xffffffff()
    page_type: 0xffffffff()
    raw: 12ffff580000822c fffffabb9f5f8288 fffffabb9fa14848 ffff9f118586feb8
    raw: 12ffff580000822c fffffabb9f5f8288 fffffabb9fa14848 ffff9f118586feb8
    raw: 000000008eb49f38 ffff9f16ae564cb0 00000003ffffffff ffff9f211ab95000
    raw: 000000008eb49f38 ffff9f16ae564cb0 00000003ffffffff ffff9f211ab95000
    flags: 0x12ffff580000822c(referenced|uptodate|lru|workingset|private|node=2|zone=2|lastcpupid=0xffff)
    page dumped because: eb page dump
    page dumped because: eb page dump
    page_type: 0xffffffff()
    BTRFS critical (device dm-1): corrupted leaf, root=136202 block=9806651031552 owner mismatch, have 174692946400338119 expect [256, 18446744073709551360]
    BTRFS critical (device dm-1): corrupted leaf, root=136202 block=9806651031552 owner mismatch, have 174692946400338119 expect [256, 18446744073709551360]
    flags: 0x12ffff580000822c(referenced|uptodate|lru|workingset|private|node=2|zone=2|lastcpupid=0xffff)
    raw: 12ffff580000822c fffffabb9f5f8288 fffffabb9fa14848 ffff9f118586feb8
    raw: 000000008eb49f38 ffff9f16ae564cb0 00000003ffffffff ffff9f211ab95000
    page_type: 0xffffffff()
    page dumped because: eb page dump
    raw: 12ffff580000822c fffffabb9f5f8288 fffffabb9fa14848 ffff9f118586feb8
    BTRFS critical (device dm-1): corrupted leaf, root=136202 block=9806651031552 owner mismatch, have 174692946400338119 expect [256, 18446744073709551360]
    raw: 000000008eb49f38 ffff9f16ae564cb0 00000003ffffffff ffff9f211ab95000
    page dumped because: eb page dump
    BTRFS critical (device dm-1): corrupted leaf, root=136202 block=9806651031552 owner mismatch, have 174692946400338119 expect [256, 18446744073709551360]
    flags: 0x12ffff580000822c(referenced|uptodate|lru|workingset|private|node=2|zone=2|lastcpupid=0xffff)
    page_type: 0xffffffff()
    raw: 12ffff580000822c fffffabb9f5f8288 fffffabb9fa14848 ffff9f118586feb8
    raw: 000000008eb49f38 ffff9f16ae564cb0 00000003ffffffff ffff9f211ab95000
    page dumped because: eb page dump
    BTRFS critical (device dm-1): corrupted leaf, root=136202 block=9806651031552 owner mismatch, have 174692946400338119 expect [256, 18446744073709551360]

> > Here's my reproducer if you want to try it yourself.  It uses bfs, a
> > find(1) clone I wrote with multi-threading and io_uring support.  I'm
> > in the process of adding multi-threaded stat(), which is what I assume
> > triggers the bug.
> >
> >      $ git clone "https://github.com/tavianator/bfs"
> >      $ cd bfs
> >      $ git checkout euclean
> >      $ make release
> >
> > Then repeat these steps until it triggers:
> >
> >      # sysctl vm.drop_caches=3
> >      $ ./bin/bfs /mnt -links 100
> >      bfs: error: /mnt/slash/@/var/lib/docker/btrfs/subvolumes/f07d37d1c148e9fcdbae166a3a4de36eec49009ce651174d0921fab18d55cee6/dev/ram0: Structure needs cleaning.
>
> It looks like the mount point /mnt/ is pretty large with a lot of things
> pre-populated?

Right, /mnt contains a few filesystems.  /mnt/slash is my root fs (the
subvolume @ is mounted as /).  It's quite large, with over 41 million
files and 640 subvolumes.  It's a BTRFS RAID0 array on 4 1TB NVMEs with
LUKS encryption.

> I tried to populate the btrfs with my linux git repo (which is around
> 6.5G with some GC needed), but even 256 runs didn't hit the problem.
>
> The main part of the script looks like this:
>
> for (( i = 0; i < 256; i++ )); do
> 	mount $dev1 $mnt
> 	sysctl vm.drop_caches=3
> 	/home/adam/bfs/bin/bfs $mnt -links 100
> 	umount $mnt
> done
>
> And the device looks like this:
>
> /dev/mapper/test-scratch1  10485760  6472292   3679260  64% /mnt/btrfs

I also noticed that it seems easier to reproduce right after a reboot.
I failed to reproduce it this morning, but after a reboot it triggered
immediately.

> Although the difference is, I'm using btrfs/for-next branch
> (https://github.com/btrfs/linux/tree/for-next).
>
> Maybe it's missing some fixes not yet in upstream?
> My current guess is related to my commit 09e6cef19c9f ("btrfs: refactor
> alloc_extent_buffer() to allocate-then-attach method"), but since I can
> not reproduce it, it's only a guess...

That's possible!  I tried to follow the existing code in
alloc_extent_buffer() but didn't see any obvious races.  I will try again
with the for-next tree and report back.

> Thanks,
> Qu

--

Tavian Barnes

