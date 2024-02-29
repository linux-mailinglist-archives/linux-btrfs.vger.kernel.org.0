Return-Path: <linux-btrfs+bounces-2905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF09D86C42B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 09:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745811F22994
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7499D54BD3;
	Thu, 29 Feb 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="sLEH9zuB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out1.mxs.au (h1.out1.mxs.au [110.232.143.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CE50276
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196586; cv=none; b=vDiyKIY0e9HKxP+6vy8a/1hxCmtgp/S0wh9PCAKlGrLrJvLLZdHreR5KvzsOfquxnW3216RzheGmZYBU4aPIRyPlMIrt8ADgk5mG4s6c4q/84G32yMMKoa9rS1M2ELl5DlfZF5JcOOv5a9BsKOu5tOV1GqIVlXwaAtEes4beVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196586; c=relaxed/simple;
	bh=SkiYmwNn6MEpZWq0fbG/8xJ5I3G51cMxXvQEUHRbB3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gbR4M465HCwRnPZEw3Y2Vel8CTDH7kInN7q10x2fqCcmUVhJ77ghxxTy7Ck/R7kiqVO+9N3Xbem+r+fKdpqqeDT3o2XOqSIMncO9OxjAo2Rj4dQ8lHjj9BbGSBpgynzlGJKx/1kmUBEwrMVB4t3jAdjgUKtDEl1jMBVoh1kHvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=sLEH9zuB; arc=none smtp.client-ip=110.232.143.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out1.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 72f58dc6-d6df-11ee-a34a-00163c39b365
	for <linux-btrfs@vger.kernel.org>;
	Thu, 29 Feb 2024 19:49:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m4nAj/FuzDiyqLCRl3+cRxaoLuElWv1NB8LCOXPoAq0=; b=sLEH9zuBe8zbpaxa/0266wMcIy
	GYXDrV+e58Qg2a9daZjA3QsXsItXdAZ3EwxmpMR0uylTiNM173jDHakS1aWUpzBQRMdgLjJUcsCq6
	0nk+U9wO5PNI4Uc7yOAG5+bu6VKwPUQ7C6Rz01q6P6eMaLMh6rVhaNsRY1t7LwYhbX9eXW2SrHntm
	AK1heNxtztK1cpDSwlgQ6WVvhgiBwtBuQMnn8goLH/BAGB8D6YHOTrMQQ6wcDZNhv9Fq/oqA8gWOu
	PXYc1FxDGsqujeGeREmjybdDoPttO4JID59YeU5x4UIn3WKJnp5KzxJOwZwweKfXnSlfOA5cQH0b0
	iePovNgw==;
Received: from [159.196.20.165] (port=14920 helo=[192.168.2.80])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <default@edcint.co.nz>)
	id 1rfc6a-001riy-2s;
	Thu, 29 Feb 2024 19:49:28 +1100
Message-ID: <041f921b-bbf1-40f2-abdf-35f7d1dff723@edcint.co.nz>
Date: Thu, 29 Feb 2024 19:49:28 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
Content-Language: en-US
To: Matthew Jurgens <default@edcint.co.nz>, Qu Wenruo
 <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
 <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
 <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
 <0dd56988-e191-45c7-a3d7-60f43fc4b7fd@edcint.co.nz>
 <2b2d37d2-d618-44eb-97f8-549b99b7b4d1@edcint.co.nz>
 <4e2faa16-3021-4d53-9121-f41d86b428fd@gmx.com>
 <cf9db9ba-96cf-440c-8ce0-d1caf7afa1c9@edcint.co.nz>
 <09cfb22a-597c-4fbe-939f-aa10d8d461a6@gmx.com>
 <706e9108-fd37-497d-9638-44cfb64e0365@edcint.co.nz>
From: Matthew Jurgens <default@edcint.co.nz>
In-Reply-To: <706e9108-fd37-497d-9638-44cfb64e0365@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: default@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: default@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Repair has been going for many hours now. I take it that even though the 
repair looks like it is repeating itself a lot, that it is expected?
>
> Sample below:
>
> [2/7] checking extents
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> metadata level mismatch on [20647087931392, 16384]
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> ERROR: tree block 20647087931392 has bad backref level, has 59 expect 
> [0, 7]
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> ref mismatch on [20647087931392 16384] extent item 0, found 1
> tree extent[20647087931392, 16384] root 5 has no backref item in 
> extent tree
> backpointer mismatch on [20647087931392 16384]
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> metadata level mismatch on [20647087931392, 16384]
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> ERROR: tree block 20647087931392 has bad backref level, has 116 expect 
> [0, 7]
>
check --repair has completed 2 times now

The first time it repaired stuff and ended with

---- start snippet -----

         item 190 key (18494262345728 EXTENT_ITEM 77824) itemoff 6355 
itemsize 53
                 refs 1 gen 4412462 flags DATA
                 (178 0xdfb591f3915f431) extent data backref root 
FS_TREE objectid 957324618 offset 0 count 1
         item 191 key (18494262423552 EXTENT_ITEM 77824) itemoff 6302 
itemsize 53
                 refs 1 gen 4412800 flags DATA
                 (178 0xdfb591ff1229b81) extent data backref root 
FS_TREE objectid 957422004 offset 0 count 1
         item 192 key (18494262501376 EXTENT_ITEM 73728) itemoff 6249 
itemsize 53
                 refs 1 gen 4412869 flags DATA
                 (178 0xdfb591f6201a3d4) extent data backref root 
FS_TREE objectid 957424653 offset 0 count 1
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
cache and super generation don't match, space cache will be invalidated
found 3271103128731648 bytes used, error(s) found
total csum bytes: 3183087496736
total tree bytes: 11320535711744
total fs tree bytes: 6783274287104
total extent tree bytes: 726347776000
btree space waste bytes: 2023314930574
file data blocks allocated: 3603262077198336
  referenced 3498204970287104

---- end snippet -----

Full output at https://www.edcint.co.nz/tmp/exportshared_fsck_7.txt

The second time it just had 752 lines of "super bytes used 4971281317888 
mismatches actual used 4971281350656"

and then ended with "double free or corruption (out)"

I am now running it a 3rd time and it has already started putting out

super bytes used 4971281317888 mismatches actual used 4971281350656

Full output at https://www.edcint.co.nz/tmp/exportshared_fsck_8.txt


Is it fixed or not? Do I need to do something about this repeated message?


