Return-Path: <linux-btrfs+bounces-7490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7346995EF2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 12:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73691F25A56
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17550155730;
	Mon, 26 Aug 2024 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fordfrog.com header.i=@fordfrog.com header.b="J41FWgbl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from beast.visionsuite.biz (beast.visionsuite.biz [85.163.23.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B0148850
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.163.23.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669806; cv=none; b=Yopd+iAVg4hqdoX3R766bfQjPuFRdZ4ZvNOS09S4D2k1BZJ7cSE/UqMg0yjcE04fs1z2OHKient9HBR+mwVZq3V4Ky1mGUitkScgBORTiJ8sLSXZCE0bBXxSXqkorD7GOIfheTauTMNmnJHLW89y794QKE9d1EFUpPtAnYsFQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669806; c=relaxed/simple;
	bh=D7pT0P8SNkq3eX/HOCisPzYwSw82M/QrRV4qjBj1i+E=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=IgS91yVtl5z7zzm+IVPOa6Bs1Mw7eq9va/tNfvgLrsxzH7EtdNHYRVCdkM3F7RvjJzZVcqEZHccSI04MemKmxEF5AbkHyHX40rw0ecAFGyNUXAq5PL4ohciyanxOHG198gMLbzUwmJiP6FGh4bLE6xou1N9p0Z+Piyz5pdIh8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fordfrog.com; spf=pass smtp.mailfrom=fordfrog.com; dkim=pass (1024-bit key) header.d=fordfrog.com header.i=@fordfrog.com header.b=J41FWgbl; arc=none smtp.client-ip=85.163.23.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fordfrog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fordfrog.com
Received: from localhost (beast.visionsuite.biz [127.0.0.1])
	by beast.visionsuite.biz (Postfix) with ESMTP id 724CB4E4EAD7
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 12:56:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at visionsuite.biz
Received: from beast.visionsuite.biz ([127.0.0.1])
	by localhost (beast.visionsuite.biz [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id C5JKwrVavWDY for <linux-btrfs@vger.kernel.org>;
	Mon, 26 Aug 2024 12:56:39 +0200 (CEST)
Received: from roundcube.visionsuite.biz (beast.visionsuite.biz [127.0.0.1])
	by beast.visionsuite.biz (Postfix) with ESMTPA id 999A44E4EACA
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 12:56:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fordfrog.com;
	s=beast; t=1724669799;
	bh=yxjCYGMepbBHXK6EJtetxfBq6DRMqZdfEYWOuyV2yrQ=;
	h=Date:From:To:Subject;
	b=J41FWgbl5VRcHOrJYeuuHo2CdrSjSEgvNbQKdNRz/dLDEtSdv9f7xLT8VHEA58CkY
	 WlhzqdhRubrZBwgUtjNzJ8BJW2ZNONeEiQGuMHJ/pTJ1bHnUqIhkI1dBqm7rguFAPe
	 HejYmoNtgwT6bgURwnpu+Ly9EQOvk/B0fpiWD94g=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 26 Aug 2024 12:56:39 +0200
From: =?UTF-8?Q?Miroslav_=C5=A0ulc?= <miroslav.sulc@fordfrog.com>
To: linux-btrfs@vger.kernel.org
Subject: recovering btrfs filesystem from synology raid5
Message-ID: <0eb0e2f033f40a0b14d652a6b7c220e4@fordfrog.com>
X-Sender: miroslav.sulc@fordfrog.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

hello,

i have here a broken btrfs filesystem that was on a synology nas with 
raid5 (mdadm + lvm) where one disk started to be broken and another was 
removed from the raid roughly two months ago (but the number of events 
on that disk isn't that much lower). more details about the raid can be 
seen here: 
https://lore.kernel.org/linux-raid/d6e87810cbfe40f3be74dfa6b0acb48e@fordfrog.com/T/

i was able to assemble the raid5 from 4 disks (3 with up-to-date data 
and one with older data) to the extent that i can use lvm to see the 
logical volume and btrfs filesystem on it, though the filesystem reports 
to be broken.

# cat /proc/mdstat
Personalities : [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]
md127 : active raid5 dm-19[4] dm-16[3] dm-13[1] dm-10[0]
       31236781824 blocks super 1.2 level 5, 64k chunk, algorithm 2 [5/4] 
[UU_UU]
       bitmap: 0/59 pages [0KB], 65536KB chunk

unused devices: <none>

# btrfs check /dev/vg1000/lv
Opening filesystem to check...
parent transid verify failed on 4330339713024 wanted 2221844 found 
2221848
parent transid verify failed on 4330321559552 wanted 2221843 found 
1957353
parent transid verify failed on 4330321559552 wanted 2221843 found 
1957359
parent transid verify failed on 4330321559552 wanted 2221843 found 
1957359
Ignoring transid failure
corrupt leaf: root=2 block=4330321559552 slot=1, unexpected item end, 
have 16079 expect 16105
leaf 4330321559552 items 87 free space 11792 generation 1957359 owner 
EXTENT_TREE
leaf 4330321559552 flags 0x1(WRITTEN) backref revision 1
fs uuid 7138daf1-5d16-4053-b559-0eb7da7d0a23
chunk uuid 55d47533-7e1e-4dda-bc51-f5ad0006fc9f
         item 0 key (142836266048 UNKNOWN.164 1478857) itemoff 16105 
itemsize 178
         item 1 key (142837019712 UNKNOWN.189 818382621) itemoff 16040 
itemsize 39
         item 2 key (142836675648 METADATA_ITEM 2850516995) itemoff 16218 
itemsize 44
                 refs 14078082519432455026 gen 151715012486066369 flags 
|FULL_BACKREF
                 tree block skinny level -1444450301
ERROR: leaf 4330321559552 slot 3 pointer invalid, offset 16369 size 33 
leaf data limit 16283
ERROR: skip remaining slots
parent transid verify failed on 4330321559552 wanted 2221843 found 
1957359
Ignoring transid failure
corrupt leaf: root=2 block=4330321559552 slot=1, unexpected item end, 
have 16079 expect 16105
leaf 4330321559552 items 87 free space 11792 generation 1957359 owner 
EXTENT_TREE
leaf 4330321559552 flags 0x1(WRITTEN) backref revision 1
fs uuid 7138daf1-5d16-4053-b559-0eb7da7d0a23
chunk uuid 55d47533-7e1e-4dda-bc51-f5ad0006fc9f
         item 0 key (142836266048 UNKNOWN.164 1478857) itemoff 16105 
itemsize 178
         item 1 key (142837019712 UNKNOWN.189 818382621) itemoff 16040 
itemsize 39
         item 2 key (142836675648 METADATA_ITEM 2850516995) itemoff 16218 
itemsize 44
                 refs 14078082519432455026 gen 151715012486066369 flags 
|FULL_BACKREF
                 tree block skinny level -1444450301
ERROR: leaf 4330321559552 slot 3 pointer invalid, offset 16369 size 33 
leaf data limit 16283
ERROR: skip remaining slots
corrupt leaf: root=2 block=4330321559552 slot=1, unexpected item end, 
have 16079 expect 16105
leaf 4330321559552 items 87 free space 11792 generation 1957359 owner 
EXTENT_TREE
leaf 4330321559552 flags 0x1(WRITTEN) backref revision 1
fs uuid 7138daf1-5d16-4053-b559-0eb7da7d0a23
chunk uuid 55d47533-7e1e-4dda-bc51-f5ad0006fc9f
         item 0 key (142836266048 UNKNOWN.164 1478857) itemoff 16105 
itemsize 178
         item 1 key (142837019712 UNKNOWN.189 818382621) itemoff 16040 
itemsize 39
         item 2 key (142836675648 METADATA_ITEM 2850516995) itemoff 16218 
itemsize 44
                 refs 14078082519432455026 gen 151715012486066369 flags 
|FULL_BACKREF
                 tree block skinny level -1444450301
ERROR: leaf 4330321559552 slot 3 pointer invalid, offset 16369 size 33 
leaf data limit 16283
ERROR: skip remaining slots
ERROR: failed to read block groups: Operation not permitted
ERROR: cannot open file system

i have the disks mapped in read-only mode with overlay set up over them 
so that i can freely experiment with the filesystem. but so far i was 
not able to get the filesystem to a state where i could read files from 
it, even with btrfs restore.

there are some data on the filesystem that are crucial for the client so 
my goal is to be able to recover at least those. so, i'd like to ask 
whether there is any chance to resolve these issues shown above to be 
able to at least list the files from the filesystem and recover at least 
a selection of them.

thank you in advance for any hints.

miroslav

