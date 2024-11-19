Return-Path: <linux-btrfs+bounces-9765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EA39D30DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 00:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A26B21555
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 23:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035291D357B;
	Tue, 19 Nov 2024 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="UIf6ZuOV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from m3.out1.mxs.au (m3.out1.mxs.au [110.232.143.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109915853A
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732058416; cv=none; b=PyzuuAnIPLn34+ArCsZCnb5fNNaPrNedH1cXb0x5v39JSMhQiV+Y3yjQSFlaN/7U/wu+XojfNiQefCHmREAqR0Kqpb9/eVwN0Fs3hH6gBLhOsqCdXIlGXuKYU/eySMPXaoHrRc3wzpRG9u4ivJL1EMUgagYJXVNa6n41rVDu8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732058416; c=relaxed/simple;
	bh=me7vIPOBH7YWEqdsY08avOOIJ4WRAatRT1/KiaM7PiI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dmyzFTAcLcxj6RtZ6hzktA6AF4OVt73wXwPI4CN/gVLLeoeC5hPnVjbjLZn8HTguHtraLVrBGEKz5tUwwwdFkDkFN/5yh+GJ24YMg69qfoqg7Mmoa7OiaoHb0GDt3PzaX12MRxcJ552v/oTtSF5TPSZP79NOMPOipCdIaEyj21Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=UIf6ZuOV; arc=none smtp.client-ip=110.232.143.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out1.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id a3758af2-a6cc-11ef-abc6-00163c39b365
	for <linux-btrfs@vger.kernel.org>;
	Wed, 20 Nov 2024 10:18:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:
	From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XQnJkNiENoD+qP+rXqZPwkvVd9nKxeFsFVpnqiLaGoM=; b=UIf6ZuOV3syUeget34O6aWbYq6
	LcNVyZRauyt5341qYK5+WfJ+Q02YvGEv+crAnB67qcAxcVAqXsy38xum0qUl1PaBNZotth6EXknYy
	8CMttvfQXj26E/5xCNrbvgEoYUe9+vz5KCD2IQZXlPvYl22nNqKtP0JswEOWtuTLSRrtFNpmxWTVn
	9JEsmG4oxKUKNPTiuYp5MmGyePLtBa/3u/X3mgBCNjRU9+7jdPWumwr9/s6MZxuI6n724C6TonxyK
	7lDtevCCubD1EnMnr9ndMxHB2k6xjoiRPKlp2PRjUyE8BMDyIPwvZjo7uleKWqT98Bd1mxjQGzoIX
	Gh3hJVTQ==;
Received: from [159.196.20.165] (port=39547 helo=[192.168.2.2])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <btrfs@edcint.co.nz>)
	id 1tDXUh-003Y54-1n
	for linux-btrfs@vger.kernel.org;
	Wed, 20 Nov 2024 10:18:51 +1100
Message-ID: <e011fe62-5ac4-46d5-82fc-bc9e508f546a@edcint.co.nz>
Date: Wed, 20 Nov 2024 10:18:50 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: en-US
From: Matthew Jurgens <btrfs@edcint.co.nz>
Subject: Mount forced read only
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

I just got this log entry:

Nov 19 23:18:52 gw kernel: BTRFS info (device sda state E): forced readonly

More log details at the bottom of this email.

I ran a btrfs check /dev/sda
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: 3adb6756-7cab-4a7a-a7d8-9ff119032ee5
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space tree
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 6646243958784 bytes used, no error found
total csum bytes: 6455962568
total tree bytes: 35338289152
total fs tree bytes: 27183267840
total extent tree bytes: 1067270144
btree space waste bytes: 4735375062
file data blocks allocated: 6666601234432
  referenced 6784612802560

So I don't have an error on my filesystem?

Is there a likely cause for the error?

Thanks


More Log Details
----------------------------------------------------------------------------------------------------------

Nov 19 23:18:50 gw kernel: page: refcount:4 mapcount:0 
mapping:0000000010f3e149 index:0x1386bc414 pfn:0xd6a020
Nov 19 23:18:50 gw kernel: memcg:ffff8b4a32568000
Nov 19 23:18:50 gw kernel: aops:btree_aops ino:1
Nov 19 23:18:50 gw kernel: flags: 
0x17ffffd000402e(referenced|uptodate|lru|private|writeback|node=0|zone=2|lastcpupid=0x1fffff)
Nov 19 23:18:50 gw kernel: raw: 0017ffffd000402e ffffe380f5a80708 
ffffe380f5a7f508 ffff8b48393b2338
Nov 19 23:18:50 gw kernel: raw: 00000001386bc414 ffff8b5406396b40 
00000004ffffffff ffff8b4a32568000
Nov 19 23:18:50 gw kernel: page dumped because: eb page dump
Nov 19 23:18:50 gw kernel: BTRFS critical (device sda): corrupt leaf: 
block=21469404938240 slot=85 extent bytenr=23657765560320 len=36864 
invalid data ref offset, have 48914611 expect aligned to 4096
Nov 19 23:18:50 gw kernel: BTRFS info (device sda): leaf 21469404938240 
gen 1596849 total ptrs 176 free space 2555 owner 2
Nov 19 23:18:50 gw kernel: #011item 0 key (23657762000896 168 12288) 
itemoff 16230 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1574104 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 276935019 offset 267468800 count 1
Nov 19 23:18:50 gw kernel: #011item 1 key (23657762013184 168 32768) 
itemoff 16177 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 272764156 offset 16515072 count 1
Nov 19 23:18:50 gw kernel: #011item 2 key (23657762045952 168 36864) 
itemoff 16124 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 272764156 offset 16646144 count 1
Nov 19 23:18:50 gw kernel: #011item 3 key (23657762082816 168 32768) 
itemoff 16071 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 272764156 offset 18481152 count 1
Nov 19 23:18:50 gw kernel: #011item 4 key (23657762115584 168 36864) 
itemoff 16018 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 272764156 offset 18612224 count 1
Nov 19 23:18:50 gw kernel: #011item 5 key (23657762152448 168 36864) 
itemoff 15965 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 272764156 offset 18743296 count 1
Nov 19 23:18:50 gw kernel: #011item 6 key (23657762189312 168 32768) 
itemoff 15912 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 272764156 offset 19529728 count 1
Nov 19 23:18:50 gw kernel: #011item 7 key (23657762222080 168 77824) 
itemoff 15859 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287782138 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 8 key (23657762299904 168 77824) 
itemoff 15806 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287782201 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 9 key (23657762377728 168 73728) 
itemoff 15753 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287782327 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 10 key (23657762451456 168 77824) 
itemoff 15700 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287782390 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 11 key (23657762529280 168 77824) 
itemoff 15647 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287782451 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 12 key (23657762607104 168 73728) 
itemoff 15594 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287782609 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 13 key (23657762680832 168 90112) 
itemoff 15541 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287782808 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 14 key (23657762770944 168 94208) 
itemoff 15488 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287783009 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 15 key (23657762865152 168 45056) 
itemoff 15435 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287783334 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 16 key (23657762910208 168 36864) 
itemoff 15382 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287783539 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 17 key (23657762947072 168 65536) 
itemoff 15329 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287783750 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 18 key (23657763012608 168 53248) 
itemoff 15276 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287783969 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 19 key (23657763065856 168 49152) 
itemoff 15223 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287784082 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 20 key (23657763115008 168 45056) 
itemoff 15170 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287784280 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 21 key (23657763160064 168 65536) 
itemoff 15117 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287784434 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 22 key (23657763225600 168 32768) 
itemoff 15064 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287784749 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 23 key (23657763258368 168 69632) 
itemoff 15011 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287784890 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 24 key (23657763328000 168 32768) 
itemoff 14958 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287785098 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 25 key (23657763360768 168 28672) 
itemoff 14905 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287785208 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 26 key (23657763389440 168 90112) 
itemoff 14852 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287785291 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 27 key (23657763479552 168 81920) 
itemoff 14799 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287785512 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 28 key (23657763561472 168 86016) 
itemoff 14746 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287785726 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 29 key (23657763647488 168 32768) 
itemoff 14693 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287785973 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 30 key (23657763680256 168 28672) 
itemoff 14640 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287786085 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 31 key (23657763708928 168 32768) 
itemoff 14587 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287786140 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 32 key (23657763741696 168 86016) 
itemoff 14534 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287786250 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 33 key (23657763827712 168 94208) 
itemoff 14481 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287786487 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 34 key (23657763921920 168 90112) 
itemoff 14428 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287786752 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 35 key (23657764012032 168 77824) 
itemoff 14375 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287787031 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 36 key (23657764089856 168 32768) 
itemoff 14322 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287787557 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 37 key (23657764122624 168 28672) 
itemoff 14269 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 287789874 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 38 key (23657764151296 168 4096) 
itemoff 14216 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1574563 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 277549110 offset 19316736 count 1
Nov 19 23:18:50 gw kernel: #011item 39 key (23657764155392 168 8192) 
itemoff 14163 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1570122 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 273112727 offset 182415360 count 1
Nov 19 23:18:50 gw kernel: #011item 40 key (23657764163584 168 32768) 
itemoff 14110 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 272764156 offset 19660800 count 1
Nov 19 23:18:50 gw kernel: #011item 41 key (23657764196352 168 4096) 
itemoff 14057 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1574563 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 277549110 offset 20819968 count 1
Nov 19 23:18:50 gw kernel: #011item 42 key (23657764200448 168 4096) 
itemoff 14004 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567638 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271044871 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 43 key (23657764204544 168 4096) 
itemoff 13951 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567638 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271044887 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 44 key (23657764208640 168 4096) 
itemoff 13898 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567638 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271044907 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 45 key (23657764212736 168 20480) 
itemoff 13845 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567638 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271045046 offset 131072 count 1
Nov 19 23:18:50 gw kernel: #011item 46 key (23657764233216 168 4096) 
itemoff 13792 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568067 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271899587 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 47 key (23657764237312 168 36864) 
itemoff 13739 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271904370 offset 524288 count 1
Nov 19 23:18:50 gw kernel: #011item 48 key (23657764274176 168 36864) 
itemoff 13686 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271904370 offset 655360 count 1
Nov 19 23:18:50 gw kernel: #011item 49 key (23657764311040 168 36864) 
itemoff 13633 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271904370 offset 786432 count 1
Nov 19 23:18:50 gw kernel: #011item 50 key (23657764347904 168 36864) 
itemoff 13580 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271904370 offset 917504 count 1
Nov 19 23:18:50 gw kernel: #011item 51 key (23657764384768 168 36864) 
itemoff 13527 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271904370 offset 6422528 count 1
Nov 19 23:18:50 gw kernel: #011item 52 key (23657764421632 168 36864) 
itemoff 13474 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271904370 offset 6553600 count 1
Nov 19 23:18:50 gw kernel: #011item 53 key (23657764458496 168 36864) 
itemoff 13421 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271904370 offset 6684672 count 1
Nov 19 23:18:50 gw kernel: #011item 54 key (23657764495360 168 36864) 
itemoff 13368 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271904370 offset 9043968 count 1
Nov 19 23:18:50 gw kernel: #011item 55 key (23657764532224 168 28672) 
itemoff 13315 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271904370 offset 75894784 count 1
Nov 19 23:18:50 gw kernel: #011item 56 key (23657764560896 168 36864) 
itemoff 13262 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 9043968 count 1
Nov 19 23:18:50 gw kernel: #011item 57 key (23657764597760 168 32768) 
itemoff 13209 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 9175040 count 1
Nov 19 23:18:50 gw kernel: #011item 58 key (23657764630528 168 32768) 
itemoff 13156 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 9306112 count 1
Nov 19 23:18:50 gw kernel: #011item 59 key (23657764663296 168 32768) 
itemoff 13103 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 12271616 count 1
Nov 19 23:18:50 gw kernel: #011item 60 key (23657764696064 168 36864) 
itemoff 13050 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 12402688 count 1
Nov 19 23:18:50 gw kernel: #011item 61 key (23657764732928 168 36864) 
itemoff 12997 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 12533760 count 1
Nov 19 23:18:50 gw kernel: #011item 62 key (23657764769792 168 36864) 
itemoff 12944 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 15417344 count 1
Nov 19 23:18:50 gw kernel: #011item 63 key (23657764806656 168 36864) 
itemoff 12891 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 15548416 count 1
Nov 19 23:18:50 gw kernel: #011item 64 key (23657764843520 168 32768) 
itemoff 12838 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 15679488 count 1
Nov 19 23:18:50 gw kernel: #011item 65 key (23657764876288 168 32768) 
itemoff 12785 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 20135936 count 1
Nov 19 23:18:50 gw kernel: #011item 66 key (23657764909056 168 36864) 
itemoff 12732 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 20267008 count 1
Nov 19 23:18:50 gw kernel: #011item 67 key (23657764945920 168 36864) 
itemoff 12679 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 20398080 count 1
Nov 19 23:18:50 gw kernel: #011item 68 key (23657764982784 168 36864) 
itemoff 12626 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 23547904 count 1
Nov 19 23:18:50 gw kernel: #011item 69 key (23657765019648 168 32768) 
itemoff 12573 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 23678976 count 1
Nov 19 23:18:50 gw kernel: #011item 70 key (23657765052416 168 32768) 
itemoff 12520 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 23810048 count 1
Nov 19 23:18:50 gw kernel: #011item 71 key (23657765085184 168 36864) 
itemoff 12467 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 26693632 count 1
Nov 19 23:18:50 gw kernel: #011item 72 key (23657765122048 168 32768) 
itemoff 12414 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 26824704 count 1
Nov 19 23:18:50 gw kernel: #011item 73 key (23657765154816 168 32768) 
itemoff 12361 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 26955776 count 1
Nov 19 23:18:50 gw kernel: #011item 74 key (23657765187584 168 36864) 
itemoff 12308 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 30363648 count 1
Nov 19 23:18:50 gw kernel: #011item 75 key (23657765224448 168 32768) 
itemoff 12255 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 30494720 count 1
Nov 19 23:18:50 gw kernel: #011item 76 key (23657765257216 168 32768) 
itemoff 12202 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 30625792 count 1
Nov 19 23:18:50 gw kernel: #011item 77 key (23657765289984 168 32768) 
itemoff 12149 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 34557952 count 1
Nov 19 23:18:50 gw kernel: #011item 78 key (23657765322752 168 36864) 
itemoff 12096 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 34689024 count 1
Nov 19 23:18:50 gw kernel: #011item 79 key (23657765359616 168 32768) 
itemoff 12043 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 34820096 count 1
Nov 19 23:18:50 gw kernel: #011item 80 key (23657765392384 168 36864) 
itemoff 11990 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 37703680 count 1
Nov 19 23:18:50 gw kernel: #011item 81 key (23657765429248 168 32768) 
itemoff 11937 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 37834752 count 1
Nov 19 23:18:50 gw kernel: #011item 82 key (23657765462016 168 32768) 
itemoff 11884 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 37965824 count 1
Nov 19 23:18:50 gw kernel: #011item 83 key (23657765494784 168 32768) 
itemoff 11831 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 44589056 count 1
Nov 19 23:18:50 gw kernel: #011item 84 key (23657765527552 168 32768) 
itemoff 11778 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 48783360 count 1
Nov 19 23:18:50 gw kernel: #011item 85 key (23657765560320 168 36864) 
itemoff 11725 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 2017612633333049730 offset 48914611 count 1
Nov 19 23:18:50 gw kernel: #011item 86 key (23657765597184 168 32768) 
itemoff 11672 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 49045504 count 1
Nov 19 23:18:50 gw kernel: #011item 87 key (23657765629952 168 36864) 
itemoff 11619 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 53501952 count 1
Nov 19 23:18:50 gw kernel: #011item 88 key (23657765666816 168 36864) 
itemoff 11566 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 53633024 count 1
Nov 19 23:18:50 gw kernel: #011item 89 key (23657765703680 168 36864) 
itemoff 11513 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 53764096 count 1
Nov 19 23:18:50 gw kernel: #011item 90 key (23657765740544 168 32768) 
itemoff 11460 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 55599104 count 1
Nov 19 23:18:50 gw kernel: #011item 91 key (23657765773312 168 36864) 
itemoff 11407 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 55730176 count 1
Nov 19 23:18:50 gw kernel: #011item 92 key (23657765810176 168 32768) 
itemoff 11354 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 55861248 count 1
Nov 19 23:18:50 gw kernel: #011item 93 key (23657765842944 168 32768) 
itemoff 11301 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 61366272 count 1
Nov 19 23:18:50 gw kernel: #011item 94 key (23657765875712 168 32768) 
itemoff 11248 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 61497344 count 1
Nov 19 23:18:50 gw kernel: #011item 95 key (23657765908480 168 32768) 
itemoff 11195 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 61628416 count 1
Nov 19 23:18:50 gw kernel: #011item 96 key (23657765941248 168 36864) 
itemoff 11142 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 62939136 count 1
Nov 19 23:18:50 gw kernel: #011item 97 key (23657765978112 168 36864) 
itemoff 11089 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 63070208 count 1
Nov 19 23:18:50 gw kernel: #011item 98 key (23657766014976 168 32768) 
itemoff 11036 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 63201280 count 1
Nov 19 23:18:50 gw kernel: #011item 99 key (23657766047744 168 36864) 
itemoff 10983 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 66084864 count 1
Nov 19 23:18:50 gw kernel: #011item 100 key (23657766084608 168 32768) 
itemoff 10930 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 66215936 count 1
Nov 19 23:18:50 gw kernel: #011item 101 key (23657766117376 168 32768) 
itemoff 10877 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 66347008 count 1
Nov 19 23:18:50 gw kernel: #011item 102 key (23657766150144 168 36864) 
itemoff 10824 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 66609152 count 1
Nov 19 23:18:50 gw kernel: #011item 103 key (23657766187008 168 36864) 
itemoff 10771 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 66740224 count 1
Nov 19 23:18:50 gw kernel: #011item 104 key (23657766223872 168 36864) 
itemoff 10718 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 66871296 count 1
Nov 19 23:18:50 gw kernel: #011item 105 key (23657766260736 168 32768) 
itemoff 10665 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 71327744 count 1
Nov 19 23:18:50 gw kernel: #011item 106 key (23657766293504 168 16384) 
itemoff 10612 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1572905 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 275602442 offset 413810688 count 1
Nov 19 23:18:50 gw kernel: #011item 107 key (23657766309888 168 4096) 
itemoff 10559 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567388 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 270616726 offset 262144 count 1
Nov 19 23:18:50 gw kernel: #011item 108 key (23657766313984 168 4096) 
itemoff 10506 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567647 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271070477 offset 262144 count 1
Nov 19 23:18:50 gw kernel: #011item 109 key (23657766318080 168 4096) 
itemoff 10453 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568023 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271815445 offset 330997760 count 1
Nov 19 23:18:50 gw kernel: #011item 110 key (23657766322176 168 8192) 
itemoff 10400 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1547971 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 146278533 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 111 key (23657766330368 168 4096) 
itemoff 10347 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1593476 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 296707259 offset 455995392 count 1
Nov 19 23:18:50 gw kernel: #011item 112 key (23657766334464 168 81920) 
itemoff 10294 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596830 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299591016 offset 459485184 count 1
Nov 19 23:18:50 gw kernel: #011item 113 key (23657766416384 168 20480) 
itemoff 10241 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596840 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299624447 offset 349970432 count 1
Nov 19 23:18:50 gw kernel: #011item 114 key (23657766436864 168 114688) 
itemoff 10188 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596840 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299624447 offset 440721408 count 1
Nov 19 23:18:50 gw kernel: #011item 115 key (23657766551552 168 32768) 
itemoff 10135 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596848 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299650019 offset 67694592 count 1
Nov 19 23:18:50 gw kernel: #011item 116 key (23657766584320 168 24576) 
itemoff 10082 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567360 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 270525303 offset 94339072 count 1
Nov 19 23:18:50 gw kernel: #011item 117 key (23657766608896 168 24576) 
itemoff 10029 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567360 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 270525303 offset 98496512 count 1
Nov 19 23:18:50 gw kernel: #011item 118 key (23657766633472 168 24576) 
itemoff 9976 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1555654 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 257540560 offset 210825216 count 1
Nov 19 23:18:50 gw kernel: #011item 119 key (23657766658048 168 4096) 
itemoff 9923 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567360 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 270525303 offset 391159808 count 1
Nov 19 23:18:50 gw kernel: #011item 120 key (23657766662144 168 20480) 
itemoff 9870 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1594380 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 298125811 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 121 key (23657766682624 168 20480) 
itemoff 9817 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596840 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299624447 offset 327667712 count 1
Nov 19 23:18:50 gw kernel: #011item 122 key (23657766703104 168 45056) 
itemoff 9764 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596840 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299624447 offset 433295360 count 1
Nov 19 23:18:50 gw kernel: #011item 123 key (23657766748160 168 53248) 
itemoff 9711 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596840 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299624447 offset 459300864 count 1
Nov 19 23:18:50 gw kernel: #011item 124 key (23657766801408 168 36864) 
itemoff 9658 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596848 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299650019 offset 62976000 count 1
Nov 19 23:18:50 gw kernel: #011item 125 key (23657766838272 168 16384) 
itemoff 9605 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596849 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299657884 offset 230117376 count 1
Nov 19 23:18:50 gw kernel: #011item 126 key (23657766854656 168 12288) 
itemoff 9552 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1584000 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 285217161 offset 135933952 count 1
Nov 19 23:18:50 gw kernel: #011item 127 key (23657766866944 168 12288) 
itemoff 9499 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567360 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 270525303 offset 172036096 count 1
Nov 19 23:18:50 gw kernel: #011item 128 key (23657766879232 168 36864) 
itemoff 9446 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1547971 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 146328123 offset 393216 count 1
Nov 19 23:18:50 gw kernel: #011item 129 key (23657766916096 168 12288) 
itemoff 9393 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1547971 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 146290459 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 130 key (23657766928384 168 16384) 
itemoff 9340 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1593476 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 296707259 offset 337027072 count 1
Nov 19 23:18:50 gw kernel: #011item 131 key (23657766944768 168 24576) 
itemoff 9287 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596840 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299624447 offset 327757824 count 1
Nov 19 23:18:50 gw kernel: #011item 132 key (23657766969344 168 28672) 
itemoff 9234 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596840 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299624447 offset 439398400 count 1
Nov 19 23:18:50 gw kernel: #011item 133 key (23657766998016 168 16384) 
itemoff 9181 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596840 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299624447 offset 455356416 count 1
Nov 19 23:18:50 gw kernel: #011item 134 key (23657767014400 168 20480) 
itemoff 9128 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596840 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299624447 offset 460431360 count 1
Nov 19 23:18:50 gw kernel: #011item 135 key (23657767034880 168 32768) 
itemoff 9075 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596848 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299650019 offset 56098816 count 1
Nov 19 23:18:50 gw kernel: #011item 136 key (23657767067648 168 36864) 
itemoff 9022 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596848 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299650019 offset 63107072 count 1
Nov 19 23:18:50 gw kernel: #011item 137 key (23657767104512 168 12288) 
itemoff 8969 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1596849 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299657884 offset 295538688 count 1
Nov 19 23:18:50 gw kernel: #011item 138 key (23657767116800 168 12288) 
itemoff 8916 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1584000 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 285217161 offset 135995392 count 1
Nov 19 23:18:50 gw kernel: #011item 139 key (23657767129088 168 12288) 
itemoff 8863 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567360 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 270525303 offset 175931392 count 1
Nov 19 23:18:50 gw kernel: #011item 140 key (23657767141376 168 61440) 
itemoff 8810 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1547971 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 146326981 offset 197754880 count 1
Nov 19 23:18:50 gw kernel: #011item 141 key (23657767202816 168 4096) 
itemoff 8757 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1547971 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 146280003 offset 0 count 1
Nov 19 23:18:50 gw kernel: #011item 142 key (23657767206912 168 24576) 
itemoff 8704 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567360 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 270525303 offset 99840000 count 1
Nov 19 23:18:50 gw kernel: #011item 143 key (23657767231488 168 8192) 
itemoff 8651 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567360 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 270525303 offset 277815296 count 1
Nov 19 23:18:50 gw kernel: #011item 144 key (23657767239680 168 4096) 
itemoff 8598 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1595244 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 299078090 offset 369303552 count 1
Nov 19 23:18:50 gw kernel: #011item 145 key (23657767243776 168 32768) 
itemoff 8545 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 65953792 count 1
Nov 19 23:18:50 gw kernel: #011item 146 key (23657767276544 168 32768) 
itemoff 8492 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 71458816 count 1
Nov 19 23:18:50 gw kernel: #011item 147 key (23657767309312 168 32768) 
itemoff 8439 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 71589888 count 1
Nov 19 23:18:50 gw kernel: #011item 148 key (23657767342080 168 32768) 
itemoff 8386 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 83386368 count 1
Nov 19 23:18:50 gw kernel: #011item 149 key (23657767374848 168 36864) 
itemoff 8333 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 83517440 count 1
Nov 19 23:18:50 gw kernel: #011item 150 key (23657767411712 168 32768) 
itemoff 8280 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 83648512 count 1
Nov 19 23:18:50 gw kernel: #011item 151 key (23657767444480 168 36864) 
itemoff 8227 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 84434944 count 1
Nov 19 23:18:50 gw kernel: #011item 152 key (23657767481344 168 32768) 
itemoff 8174 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 84566016 count 1
Nov 19 23:18:50 gw kernel: #011item 153 key (23657767514112 168 36864) 
itemoff 8121 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 84697088 count 1
Nov 19 23:18:50 gw kernel: #011item 154 key (23657767550976 168 36864) 
itemoff 8068 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 85483520 count 1
Nov 19 23:18:50 gw kernel: #011item 155 key (23657767587840 168 36864) 
itemoff 8015 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 85614592 count 1
Nov 19 23:18:50 gw kernel: #011item 156 key (23657767624704 168 36864) 
itemoff 7962 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 85745664 count 1
Nov 19 23:18:50 gw kernel: #011item 157 key (23657767661568 168 36864) 
itemoff 7909 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 86532096 count 1
Nov 19 23:18:50 gw kernel: #011item 158 key (23657767698432 168 32768) 
itemoff 7856 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 86663168 count 1
Nov 19 23:18:50 gw kernel: #011item 159 key (23657767731200 168 36864) 
itemoff 7803 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 86794240 count 1
Nov 19 23:18:50 gw kernel: #011item 160 key (23657767768064 168 32768) 
itemoff 7750 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 87056384 count 1
Nov 19 23:18:50 gw kernel: #011item 161 key (23657767800832 168 36864) 
itemoff 7697 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 87187456 count 1
Nov 19 23:18:50 gw kernel: #011item 162 key (23657767837696 168 36864) 
itemoff 7644 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 87318528 count 1
Nov 19 23:18:50 gw kernel: #011item 163 key (23657767874560 168 36864) 
itemoff 7591 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 90202112 count 1
Nov 19 23:18:50 gw kernel: #011item 164 key (23657767911424 168 36864) 
itemoff 7538 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 90333184 count 1
Nov 19 23:18:50 gw kernel: #011item 165 key (23657767948288 168 36864) 
itemoff 7485 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 90464256 count 1
Nov 19 23:18:50 gw kernel: #011item 166 key (23657767985152 168 32768) 
itemoff 7432 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 95969280 count 1
Nov 19 23:18:50 gw kernel: #011item 167 key (23657768017920 168 36864) 
itemoff 7379 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 96100352 count 1
Nov 19 23:18:50 gw kernel: #011item 168 key (23657768054784 168 36864) 
itemoff 7326 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 96231424 count 1
Nov 19 23:18:50 gw kernel: #011item 169 key (23657768091648 168 36864) 
itemoff 7273 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 103591936 count 1
Nov 19 23:18:50 gw kernel: #011item 170 key (23657768128512 168 32768) 
itemoff 7220 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 103723008 count 1
Nov 19 23:18:50 gw kernel: #011item 171 key (23657768161280 168 32768) 
itemoff 7167 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 103854080 count 1
Nov 19 23:18:50 gw kernel: #011item 172 key (23657768194048 168 36864) 
itemoff 7114 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 104640512 count 1
Nov 19 23:18:50 gw kernel: #011item 173 key (23657768230912 168 32768) 
itemoff 7061 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 104771584 count 1
Nov 19 23:18:50 gw kernel: #011item 174 key (23657768263680 168 32768) 
itemoff 7008 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 104902656 count 1
Nov 19 23:18:50 gw kernel: #011item 175 key (23657768296448 168 32768) 
itemoff 6955 itemsize 53
Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5 
objectid 271067522 offset 106737664 count 1
Nov 19 23:18:50 gw kernel: BTRFS error (device sda): 
block=21469404938240 write time tree block corruption detected
Nov 19 23:18:52 gw kernel: BTRFS: error (device sda) in 
btrfs_commit_transaction:2524: errno=-5 IO failure (Error while writing 
out transaction)
Nov 19 23:18:52 gw kernel: BTRFS info (device sda state E): forced readonly
Nov 19 23:18:52 gw kernel: BTRFS warning (device sda state E): Skipping 
commit of aborted transaction.
Nov 19 23:18:52 gw kernel: BTRFS error (device sda state EA): 
Transaction aborted (error -5)
Nov 19 23:18:52 gw kernel: BTRFS: error (device sda state EA) in 
cleanup_transaction:2018: errno=-5 IO failure


