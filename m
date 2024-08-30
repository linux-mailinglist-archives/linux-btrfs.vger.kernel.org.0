Return-Path: <linux-btrfs+bounces-7688-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B4C965840
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 09:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E911DB23E79
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 07:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B5E1531FE;
	Fri, 30 Aug 2024 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fordfrog.com header.i=@fordfrog.com header.b="fmDcc4fa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from beast.visionsuite.biz (beast.visionsuite.biz [85.163.23.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78649481D1
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.163.23.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002345; cv=none; b=ATXxBWeZ9j8aujmAhYsruX9uPOoH6CiWuXdMwQtWZjZPBSyyrG0mOKdr28EUmsuKybm2Roy+/eso2rZoNtPfWVmSsx/zOikEOzdTdV8XUts8yl0y8IyXkRNMfxZ/nWOEt9sSwyN4xa4jgXQDu1EyfmjMRx1p57kr5BmlN1xvd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002345; c=relaxed/simple;
	bh=/HChkKmwzcWEojhx3fpu3KVCt6cjfGMVad+1JhajyP0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bS9UT5aRJu+KJ1pa7xXPM8VhZ1T6DtHvAFIbAwkCsnoyqRJSjfwPX/QxVN0iPlqH864hGQOq92hINVxtviMDf0okiUf/6krgfwveSrWlMbmS4DtA3zVNdHzojcxs+5lHRqSsY8CkYPbyFqog7uHyb6GbSmqqO/DDIlju9Ogyj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fordfrog.com; spf=pass smtp.mailfrom=fordfrog.com; dkim=pass (1024-bit key) header.d=fordfrog.com header.i=@fordfrog.com header.b=fmDcc4fa; arc=none smtp.client-ip=85.163.23.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fordfrog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fordfrog.com
Received: from localhost (beast.visionsuite.biz [127.0.0.1])
	by beast.visionsuite.biz (Postfix) with ESMTP id C70954EB4A84;
	Fri, 30 Aug 2024 09:18:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at visionsuite.biz
Received: from beast.visionsuite.biz ([127.0.0.1])
	by localhost (beast.visionsuite.biz [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id 9g4OkH4dphUS; Fri, 30 Aug 2024 09:18:49 +0200 (CEST)
Received: from roundcube.visionsuite.biz (beast.visionsuite.biz [127.0.0.1])
	by beast.visionsuite.biz (Postfix) with ESMTPA id 6CD034EB4A73;
	Fri, 30 Aug 2024 09:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fordfrog.com;
	s=beast; t=1725002329;
	bh=jW61i8kyj+DRA/k+vVtW2f0zX9DqUoYET+8Zma6J/30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fmDcc4favQ7cJNtorjRA0X6ZGdkWS+XutASsAWv1iRhh/GKZR9ZMhIjLSu6l1AuVb
	 zCgZ+Lhoe8JCvmCOAV22fm6EGWRl2/W52HEaFBhlhWrtVyNvo9jitYqM218SSWb+lH
	 rntm010Lr87F3EZuQcO7YUnGwTdzAMFJo75sNyas=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Aug 2024 09:18:49 +0200
From: =?UTF-8?Q?Miroslav_=C5=A0ulc?= <miroslav.sulc@fordfrog.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Subject: Re: recovering btrfs filesystem from synology raid5
In-Reply-To: <20240829230202.GS25962@twin.jikos.cz>
References: <0eb0e2f033f40a0b14d652a6b7c220e4@fordfrog.com>
 <20240829230202.GS25962@twin.jikos.cz>
Message-ID: <d51c038fca82b2a3b247a84e14941349@fordfrog.com>
X-Sender: miroslav.sulc@fordfrog.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

hi David, thank you for your detail reply. i tried btrfs restore but 
that didn't recover anything. though i did set up the raid on my desktop 
and not on the nas because the one i have here does not support btrfs. 
from what you wrote, it comes to my mind that it would make sense to set 
up the raid on synology nas that supports btrfs and check whether that 
improves the situation or not, because of the modified system on the 
nas.

Dne 2024-08-30 01:02, David Sterba napsal:
> On Mon, Aug 26, 2024 at 12:56:39PM +0200, Miroslav Šulc wrote:
>> hello,
>> 
>> i have here a broken btrfs filesystem that was on a synology nas with
>> raid5 (mdadm + lvm)
> 
> AFAIK synology has some patches that connect btrfs and MD raid5 so it
> fixes the problems that btrfs-raid5 has. But the patches are not
> upstream and I don't know how it works.
> 
>> where one disk started to be broken and another was
>> removed from the raid roughly two months ago (but the number of events
>> on that disk isn't that much lower). more details about the raid can 
>> be
>> seen here:
>> https://lore.kernel.org/linux-raid/d6e87810cbfe40f3be74dfa6b0acb48e@fordfrog.com/T/
> 
> This looks like the problems are on the MD level with the device
> removed, added back and interrupted synchronization. The analysis 
> points
> out there are some old data or stats. More below.
> 
>> i was able to assemble the raid5 from 4 disks (3 with up-to-date data
>> and one with older data) to the extent that i can use lvm to see the
>> logical volume and btrfs filesystem on it, though the filesystem 
>> reports
>> to be broken.
>> 
>> # cat /proc/mdstat
>> Personalities : [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]
>> md127 : active raid5 dm-19[4] dm-16[3] dm-13[1] dm-10[0]
>>        31236781824 blocks super 1.2 level 5, 64k chunk, algorithm 2 
>> [5/4]
>> [UU_UU]
>>        bitmap: 0/59 pages [0KB], 65536KB chunk
>> 
>> unused devices: <none>
>> 
>> # btrfs check /dev/vg1000/lv
>> Opening filesystem to check...
>> parent transid verify failed on 4330339713024 wanted 2221844 found
>> 2221848
> 
> This error typically means old data were read, the difference is 4
> transactions.
> 
>> parent transid verify failed on 4330321559552 wanted 2221843 found
>> 1957353
>> parent transid verify failed on 4330321559552 wanted 2221843 found
>> 1957359
>> parent transid verify failed on 4330321559552 wanted 2221843 found
>> 1957359
>> Ignoring transid failure
>> corrupt leaf: root=2 block=4330321559552 slot=1, unexpected item end,
>> have 16079 expect 16105
> 
> This kind of error does not apper often, the 'transid verify failed'
> from above usually has a consistent b-tree node/leaf but from a
> different transaction "epoch". A wrong item end means there's a 
> mismatch
> in the stored and calculated data. Reasons for that can vary, a 
> software
> bug can never be ruled out (but we'd see more reports) or the recovery
> of the b-tree node/leaf was partial and the item descriptor (the stored
> part) is older than what's actually found in the leaf (the calculated
> part).
> 
>> leaf 4330321559552 items 87 free space 11792 generation 1957359 owner
>> EXTENT_TREE
>> leaf 4330321559552 flags 0x1(WRITTEN) backref revision 1
>> fs uuid 7138daf1-5d16-4053-b559-0eb7da7d0a23
>> chunk uuid 55d47533-7e1e-4dda-bc51-f5ad0006fc9f
>>          item 0 key (142836266048 UNKNOWN.164 1478857) itemoff 16105
> 
> UNKNOWN.164 must be some synology NAS specific thing
> 
>> itemsize 179
>>          item 1 key (142837019712 UNKNOWN.189 818382621) itemoff 16040
> 
> Same.
> 
>> itemsize 39
>>          item 2 key (142836675648 METADATA_ITEM 2850516995) itemoff 
>> 16218
>> itemsize 44
>>                  refs 14078082519432455026 gen 151715012486066369 
>> flags
> 
> The numbers 14078082519432455026 and 151715012486066369 are likely a
> complete garbage, either a block that was randomly overwritten or a
> random block read and interpreted.
> 
>> |FULL_BACKREF
>>                  tree block skinny level -1444450301
> 
> Levels are 0..7
> 
>> ERROR: leaf 4330321559552 slot 3 pointer invalid, offset 16369 size 33
>> leaf data limit 16283
>> ERROR: skip remaining slots
>> parent transid verify failed on 4330321559552 wanted 2221843 found
>> 1957359
>> Ignoring transid failure
>> corrupt leaf: root=2 block=4330321559552 slot=1, unexpected item end,
>> have 16079 expect 16105
>> leaf 4330321559552 items 87 free space 11792 generation 1957359 owner
>> EXTENT_TREE
>> leaf 4330321559552 flags 0x1(WRITTEN) backref revision 1
>> fs uuid 7138daf1-5d16-4053-b559-0eb7da7d0a23
>> chunk uuid 55d47533-7e1e-4dda-bc51-f5ad0006fc9f
>>          item 0 key (142836266048 UNKNOWN.164 1478857) itemoff 16105
>> itemsize 178
>>          item 1 key (142837019712 UNKNOWN.189 818382621) itemoff 16040
>> itemsize 39
>>          item 2 key (142836675648 METADATA_ITEM 2850516995) itemoff 
>> 16218
>> itemsize 44
>>                  refs 14078082519432455026 gen 151715012486066369 
>> flags
>> |FULL_BACKREF
>>                  tree block skinny level -1444450301
>> ERROR: leaf 4330321559552 slot 3 pointer invalid, offset 16369 size 33
>> leaf data limit 16283
>> ERROR: skip remaining slots
>> corrupt leaf: root=2 block=4330321559552 slot=1, unexpected item end,
>> have 16079 expect 16105
>> leaf 4330321559552 items 87 free space 11792 generation 1957359 owner
>> EXTENT_TREE
>> leaf 4330321559552 flags 0x1(WRITTEN) backref revision 1
>> fs uuid 7138daf1-5d16-4053-b559-0eb7da7d0a23
>> chunk uuid 55d47533-7e1e-4dda-bc51-f5ad0006fc9f
>>          item 0 key (142836266048 UNKNOWN.164 1478857) itemoff 16105
>> itemsize 178
>>          item 1 key (142837019712 UNKNOWN.189 818382621) itemoff 16040
>> itemsize 39
>>          item 2 key (142836675648 METADATA_ITEM 2850516995) itemoff 
>> 16218
>> itemsize 44
>>                  refs 14078082519432455026 gen 151715012486066369 
>> flags
>> |FULL_BACKREF
>>                  tree block skinny level -1444450301
>> ERROR: leaf 4330321559552 slot 3 pointer invalid, offset 16369 size 33
>> leaf data limit 16283
>> ERROR: skip remaining slots
>> ERROR: failed to read block groups: Operation not permitted
>> ERROR: cannot open file system
>> 
>> i have the disks mapped in read-only mode with overlay set up over 
>> them
>> so that i can freely experiment with the filesystem. but so far i was
>> not able to get the filesystem to a state where i could read files 
>> from
>> it, even with btrfs restore.
> 
> The recovery options for btrfs are to try to read partially consistent
> data from past generations, this is what 'btrfs restore' does, but it
> seems that the block data are mixed and even inconsistent within
> somethign that btrfs would consider a unit.
> 
>> there are some data on the filesystem that are crucial for the client 
>> so
>> my goal is to be able to recover at least those. so, i'd like to ask
>> whether there is any chance to resolve these issues shown above to be
>> able to at least list the files from the filesystem and recover at 
>> least
>> a selection of them.
> 
> You can try 'btrfs restore' if you haven't done that yet but this may
> also require to write some custom code to work around the specific
> issues you find. This is also from a custom kernel from synology with
> apparent modifications that the upstream linux kernel does not have so
> we can't help with that beyond the common points.

