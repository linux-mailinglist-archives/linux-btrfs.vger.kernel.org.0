Return-Path: <linux-btrfs+bounces-21652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XMYxEls2jmkUBAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21652-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 21:21:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A872F130EA4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 21:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DD053036614
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23BD2FE563;
	Thu, 12 Feb 2026 20:21:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mtafr.prnet.org (mtafr.prnet.org [54.38.152.168])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6FFF9C0;
	Thu, 12 Feb 2026 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.38.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770927694; cv=none; b=ObQZLNj+Pb9jQzxjg8QXyIdE8RcTbTIgMdIoB6rOIQVRjEROh4kjF1m9V+obMhFV9svKJkQ6+yToJq/EepDnCPNJnuLj6N7cP6nGewTDjsOjLf+GhexkrdvZWoKor0muNxsYj3vPlXxggwIMtHjVww+V7UYnDj3d+3KrvB0SA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770927694; c=relaxed/simple;
	bh=owzUQvPsaTuPPQaZ1SV9Z58LRVbvhvdBvnPICHZA2Rg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XqC7x3eb4U2t3TcmxyjApWjAxQfyfsHNLCDuiFMyZmbX3iYkm2eL5j7ND5kkxrfG0cFbpAYIvz/iFBqtSZXWyqN+jZZ6vF16ybKUj+zvNNQ/Ck5qPQEuOa0r/13ux/rwUNyyfPZ0526RaYe+nzKJ23zE/b5nLrR4+L7bmN6BUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prnet.org; spf=pass smtp.mailfrom=prnet.org; arc=none smtp.client-ip=54.38.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prnet.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prnet.org
Received: from secure.prnet.org (unknown [10.1.0.1])
	by mtafr.prnet.org (Postfix) with ESMTP id 1EFF32004D;
	Thu, 12 Feb 2026 21:11:59 +0100 (CET)
Received: from [IPV6:2001:7e8:cf00:bc01:8cac:7fff:fe9e:52] (unknown [IPv6:2001:7e8:cf00:bc01:8cac:7fff:fe9e:52])
	by secure.prnet.org (Postfix) with ESMTPSA id 30D5A10003F;
	Thu, 12 Feb 2026 21:11:33 +0100 (CET)
Message-ID: <8ebe4d76-eb07-499b-b140-1f300c1b8d7e@prnet.org>
Date: Thu, 12 Feb 2026 21:11:32 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>, linux-rockchip@vger.kernel.org,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From: David Arendt <admin@prnet.org>
Subject: Orange PI 5 MAX: very unstable using kernel 6.19.0 and 6.18.10,
 6.18.9 perfectly stable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[prnet.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admin@prnet.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21652-lists,linux-btrfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,prnet.org:mid]
X-Rspamd-Queue-Id: A872F130EA4
X-Rspamd-Action: no action

Hello,

I am using a Kubernetes Cluster with 3 Orange PI5 MAX nodes. The data is 
stored using a btrfs filesystem as backend. If using kernel 6.19.0 or 
kernel 6.18.10 I have experienced many crashes during high IO load on 
all 3 nodes. Reverting back to 6.18.9 solves the problems completely. 
Unfortunately the crashes are spontaneous reboots without leaving a 
trace in any logfile, so I have no stacktrace of them. After the crashes 
I have sometimes incorrect btrfs csums for a file but these may also be 
a result of a partial write due to the crash. On one node I had a btrfs 
error logged without crashing, but I am not sure if this is the root 
cause or a result of a prior crash. A scrub after reboot returned no 
error with 6.19.0.

Here the error logged on this node using kernel 6.19.0:


Feb 10 13:31:07 opi02 kernel: page: refcount:2 mapcount:0 
mapping:00000000bc8f678b index:0x588556fc pfn:0x6f69
Feb 10 13:31:07 opi02 kernel: memcg:ffffff81005b8000
Feb 10 13:31:07 opi02 kernel: aops:0xffffffc08159f0a0 ino:1
Feb 10 13:31:07 opi02 kernel: flags: 
0x1e0000000000422e(referenced|uptodate|lru|workingset|private|writeback|zone=0)
Feb 10 13:31:07 opi02 kernel: raw: 1e0000000000422e fffffffec01bda08 
fffffffec01bda88 ffffff8103a48ec8
Feb 10 13:31:07 opi02 kernel: raw: 00000000588556fc ffffff811ae48000 
00000002ffffffff ffffff81005b8000
Feb 10 13:31:07 opi02 kernel: page dumped because: eb page dump
Feb 10 13:31:07 opi02 kernel: BTRFS critical (device nvme0n1p3): corrupt 
leaf: root=2 block=6083107078144 slot=93, bad key order, prev 
(13218356101120 168 24576) current (13216208642048 168 36864)
Feb 10 13:31:07 opi02 kernel: BTRFS info (device nvme0n1p3): leaf 
6083107078144 gen 1240050 total ptrs 176 free space 4372 owner 2
Feb 10 13:31:07 opi02 kernel: \x09item 0 key (13218352742400 EXTENT_ITEM 
32768) itemoff 16246 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601309790208 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 1 key (13218352775168 EXTENT_ITEM 
12288) itemoff 16196 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601337839616 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
2329940934656 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 2 key (13218352787456 EXTENT_ITEM 
8192) itemoff 16159 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
5397843181568 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 3 key (13218352795648 EXTENT_ITEM 
24576) itemoff 16122 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1230575 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083112271872 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 4 key (13218352820224 EXTENT_ITEM 
32768) itemoff 16085 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1230575 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083112271872 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 5 key (13218352852992 EXTENT_ITEM 
36864) itemoff 16048 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1230575 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083112271872 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 6 key (13218352889856 EXTENT_ITEM 
24576) itemoff 16011 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1230575 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083112271872 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 7 key (13218352914432 EXTENT_ITEM 
4096) itemoff 15974 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1230601 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6082996486144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 8 key (13218352918528 EXTENT_ITEM 
28672) itemoff 15937 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601309790208 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 9 key (13218352947200 EXTENT_ITEM 
32768) itemoff 15900 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083885318144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 10 key (13218352979968 
EXTENT_ITEM 32768) itemoff 15863 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1870215643136 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 11 key (13218353012736 
EXTENT_ITEM 24576) itemoff 15826 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1869710753792 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 12 key (13218353037312 
EXTENT_ITEM 32768) itemoff 15789 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 13 key (13218353070080 
EXTENT_ITEM 32768) itemoff 15752 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 14 key (13218353102848 
EXTENT_ITEM 36864) itemoff 15715 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601322930176 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 15 key (13218353139712 
EXTENT_ITEM 12288) itemoff 15678 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 16 key (13218353152000 
EXTENT_ITEM 36864) itemoff 15641 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
2329324519424 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 17 key (13218353188864 
EXTENT_ITEM 36864) itemoff 15604 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
2329324519424 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 18 key (13218353225728 
EXTENT_ITEM 28672) itemoff 15567 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
2329324519424 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 19 key (13218353254400 
EXTENT_ITEM 24576) itemoff 15530 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084916248576 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 20 key (13218353278976 
EXTENT_ITEM 32768) itemoff 15493 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 21 key (13218353311744 
EXTENT_ITEM 32768) itemoff 15456 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 22 key (13218353344512 
EXTENT_ITEM 32768) itemoff 15419 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 23 key (13218353377280 
EXTENT_ITEM 32768) itemoff 15382 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 24 key (13218353410048 
EXTENT_ITEM 16384) itemoff 15332 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601323585536 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601323569152 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 25 key (13218353426432 
EXTENT_ITEM 73728) itemoff 15295 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 26 key (13218353500160 
EXTENT_ITEM 94208) itemoff 15258 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 27 key (13218353594368 
EXTENT_ITEM 36864) itemoff 15221 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 28 key (13218353631232 
EXTENT_ITEM 24576) itemoff 15168 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1239972 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 973 offset 25776128 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 29 key (13218353659904 
EXTENT_ITEM 114688) itemoff 15131 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 30 key (13218353774592 
EXTENT_ITEM 53248) itemoff 15094 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 31 key (13218353827840 
EXTENT_ITEM 36864) itemoff 15028 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 10989568 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 32 key (13218353864704 
EXTENT_ITEM 32768) itemoff 14991 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1233577 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083964059648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 33 key (13218353897472 
EXTENT_ITEM 28672) itemoff 14954 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
3316006191104 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 34 key (13218353926144 
EXTENT_ITEM 28672) itemoff 14917 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
3316006191104 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 35 key (13218353954816 
EXTENT_ITEM 36864) itemoff 14864 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1239972 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 973 offset 26038272 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 36 key (13218353991680 
EXTENT_ITEM 28672) itemoff 14798 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239975 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4239 offset 9175040 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601626492928 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 37 key (13218354020352 
EXTENT_ITEM 32768) itemoff 14732 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239972 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 7958528 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 38 key (13218354053120 
EXTENT_ITEM 28672) itemoff 14666 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239972 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4239 offset 8003584 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601626492928 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 39 key (13218354081792 
EXTENT_ITEM 28672) itemoff 14613 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 973 offset 27795456 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 40 key (13218354110464 
EXTENT_ITEM 24576) itemoff 14547 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 8892416 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 41 key (13218354135040 
EXTENT_ITEM 40960) itemoff 14481 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 9023488 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 42 key (13218354176000 
EXTENT_ITEM 8192) itemoff 14444 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1230586 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6082958065664 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 43 key (13218354192384 
EXTENT_ITEM 40960) itemoff 14407 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
2329324519424 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 44 key (13218354233344 
EXTENT_ITEM 40960) itemoff 14370 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601323143168 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 45 key (13218354274304 
EXTENT_ITEM 28672) itemoff 14333 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1869710753792 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 46 key (13218354302976 
EXTENT_ITEM 20480) itemoff 14296 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083467198464 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 47 key (13218354327552 
EXTENT_ITEM 32768) itemoff 14246 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084844093440 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
3375270707200 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 48 key (13218354360320 
EXTENT_ITEM 32768) itemoff 14209 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601322930176 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 49 key (13218354393088 
EXTENT_ITEM 32768) itemoff 14172 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 50 key (13218354425856 
EXTENT_ITEM 16384) itemoff 14135 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601323143168 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 51 key (13218354442240 
EXTENT_ITEM 24576) itemoff 14098 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
3315953352704 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 52 key (13218354466816 
EXTENT_ITEM 32768) itemoff 14048 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084844093440 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
3375270707200 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 53 key (13218354499584 
EXTENT_ITEM 32768) itemoff 14011 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 54 key (13218354532352 
EXTENT_ITEM 28672) itemoff 13974 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1869710753792 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 55 key (13218354561024 
EXTENT_ITEM 36864) itemoff 13937 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 56 key (13218354597888 
EXTENT_ITEM 28672) itemoff 13900 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 57 key (13218354630656 
EXTENT_ITEM 36864) itemoff 13863 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084837769216 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 58 key (13218354667520 
EXTENT_ITEM 36864) itemoff 13826 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084901273600 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 59 key (13218354704384 
EXTENT_ITEM 40960) itemoff 13789 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084837769216 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 60 key (13218354745344 
EXTENT_ITEM 40960) itemoff 13752 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601323143168 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 61 key (13218354786304 
EXTENT_ITEM 28672) itemoff 13702 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083940007936 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601318735872 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 62 key (13218354814976 
EXTENT_ITEM 28672) itemoff 13652 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083940007936 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601318735872 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 63 key (13218354843648 
EXTENT_ITEM 28672) itemoff 13615 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 64 key (13218354872320 
EXTENT_ITEM 36864) itemoff 13578 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083876814848 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 65 key (13218354909184 
EXTENT_ITEM 40960) itemoff 13525 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1233577 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4517 offset 15138816 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 66 key (13218354950144 
EXTENT_ITEM 69632) itemoff 13488 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083870490624 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 67 key (13218355019776 
EXTENT_ITEM 24576) itemoff 13451 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084392681472 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 68 key (13218355044352 
EXTENT_ITEM 32768) itemoff 13414 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083885318144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 69 key (13218355077120 
EXTENT_ITEM 32768) itemoff 13377 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083885318144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 70 key (13218355109888 
EXTENT_ITEM 32768) itemoff 13340 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1870215643136 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 71 key (13218355142656 
EXTENT_ITEM 8192) itemoff 13303 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
5397843181568 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 72 key (13218355150848 
EXTENT_ITEM 40960) itemoff 13237 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 9285632 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 73 key (13218355208192 
EXTENT_ITEM 36864) itemoff 13200 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 74 key (13218355245056 
EXTENT_ITEM 36864) itemoff 13163 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 75 key (13218355281920 
EXTENT_ITEM 36864) itemoff 13126 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 76 key (13218355318784 
EXTENT_ITEM 20480) itemoff 13089 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 77 key (13218355339264 
EXTENT_ITEM 40960) itemoff 13052 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083876814848 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 78 key (13218355380224 
EXTENT_ITEM 32768) itemoff 13015 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
5397963751424 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 79 key (13218355412992 
EXTENT_ITEM 28672) itemoff 12978 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601309790208 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 80 key (13218355441664 
EXTENT_ITEM 24576) itemoff 12941 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 81 key (13218355466240 
EXTENT_ITEM 131072) itemoff 12888 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1229883 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
2751 objectid 2900 offset 7247327232 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 82 key (13218355601408 
EXTENT_ITEM 36864) itemoff 12851 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 83 key (13218355638272 
EXTENT_ITEM 24576) itemoff 12814 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
3316004470784 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 84 key (13218355662848 
EXTENT_ITEM 36864) itemoff 12777 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1870212988928 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 85 key (13218355699712 
EXTENT_ITEM 28672) itemoff 12740 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
5398079373312 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 86 key (13218355732480 
EXTENT_ITEM 114688) itemoff 12703 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 87 key (13218355847168 
EXTENT_ITEM 77824) itemoff 12666 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 88 key (13218355924992 
EXTENT_ITEM 36864) itemoff 12600 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 11120640 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 89 key (13218355961856 
EXTENT_ITEM 69632) itemoff 12563 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 90 key (13218356031488 
EXTENT_ITEM 32768) itemoff 12510 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 973 offset 27271168 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 91 key (13218356064256 
EXTENT_ITEM 36864) itemoff 12444 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 9547776 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 92 key (13218356101120 
EXTENT_ITEM 24576) itemoff 12378 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4239 offset 8572928 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601626492928 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 93 key (13216208642048 
EXTENT_ITEM 36864) itemoff 12341 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1233577 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083964059648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 94 key (13218356162560 
EXTENT_ITEM 32768) itemoff 12304 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1233577 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083964059648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 95 key (13218356195328 
EXTENT_ITEM 36864) itemoff 12251 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1233578 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4517 offset 16855040 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 96 key (13218356232192 
EXTENT_ITEM 40960) itemoff 12201 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1233589 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083991683072 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
1583866560512 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 97 key (13218356273152 
EXTENT_ITEM 32768) itemoff 12151 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1233589 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083991683072 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
1583866560512 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 98 key (13218356305920 
EXTENT_ITEM 12288) itemoff 12098 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1236769 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 1152 offset 25165824 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 99 key (13218356318208 
EXTENT_ITEM 36864) itemoff 12061 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1233579 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083964059648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 100 key (13218356355072 
EXTENT_ITEM 32768) itemoff 12024 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1233579 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083964059648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 101 key (13218356387840 
EXTENT_ITEM 32768) itemoff 11987 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1233579 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083964059648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 102 key (13218356420608 
EXTENT_ITEM 28672) itemoff 11950 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1233579 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083964059648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 103 key (13218356449280 
EXTENT_ITEM 24576) itemoff 11897 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1234066 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4537 offset 17248256 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 104 key (13218356473856 
EXTENT_ITEM 20480) itemoff 11834 itemsize 63
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 3 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6082876506112 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
3316328841216 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#2: shared data backref parent 
3315961479168 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 105 key (13218356494336 
EXTENT_ITEM 28672) itemoff 11797 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
3316006191104 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 106 key (13218356523008 
EXTENT_ITEM 40960) itemoff 11747 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1230430 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601803194368 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601266962432 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 107 key (13218356563968 
EXTENT_ITEM 40960) itemoff 11681 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 10072064 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 108 key (13218356609024 
EXTENT_ITEM 20480) itemoff 11618 itemsize 63
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 3 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6082876506112 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
3316328841216 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#2: shared data backref parent 
3315961479168 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 109 key (13218356629504 
EXTENT_ITEM 16384) itemoff 11581 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084881580032 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 110 key (13218356645888 
EXTENT_ITEM 24576) itemoff 11518 itemsize 63
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 3 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6082876506112 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
3316328841216 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#2: shared data backref parent 
3315961479168 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 111 key (13218356670464 
EXTENT_ITEM 32768) itemoff 11468 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1230430 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601803194368 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601266962432 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 112 key (13218356703232 
EXTENT_ITEM 36864) itemoff 11402 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 11251712 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 113 key (13218356740096 
EXTENT_ITEM 40960) itemoff 11349 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1235501 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4593 offset 11141120 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 114 key (13218356781056 
EXTENT_ITEM 40960) itemoff 11283 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 10203136 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 115 key (13218356834304 
EXTENT_ITEM 28672) itemoff 11230 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1235502 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4594 offset 54112256 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 116 key (13218356862976 
EXTENT_ITEM 40960) itemoff 11193 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 117 key (13218356903936 
EXTENT_ITEM 45056) itemoff 11127 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239972 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 8613888 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 118 key (13218356948992 
EXTENT_ITEM 32768) itemoff 11074 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 973 offset 28319744 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 119 key (13218356981760 
EXTENT_ITEM 40960) itemoff 11008 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 10334208 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 120 key (13218357039104 
EXTENT_ITEM 57344) itemoff 10971 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 121 key (13218357096448 
EXTENT_ITEM 28672) itemoff 10918 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1239972 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 973 offset 26169344 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 122 key (13218357125120 
EXTENT_ITEM 4096) itemoff 10865 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1240050 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
2751 objectid 3362 offset 2549063680 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 123 key (13218357129216 
EXTENT_ITEM 32768) itemoff 10828 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083554082816 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 124 key (13218357161984 
EXTENT_ITEM 32768) itemoff 10791 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083554082816 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 125 key (13218357194752 
EXTENT_ITEM 20480) itemoff 10738 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1234335 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 1007 offset 62439424 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 126 key (13218357215232 
EXTENT_ITEM 4096) itemoff 10685 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1237596 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
2751 objectid 2862 offset 1668911104 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 127 key (13218357219328 
EXTENT_ITEM 32768) itemoff 10648 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 128 key (13218357252096 
EXTENT_ITEM 28672) itemoff 10611 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 129 key (13218357280768 
EXTENT_ITEM 12288) itemoff 10574 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601318735872 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 130 key (13218357293056 
EXTENT_ITEM 40960) itemoff 10537 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 131 key (13218357334016 
EXTENT_ITEM 40960) itemoff 10500 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 132 key (13218357374976 
EXTENT_ITEM 28672) itemoff 10463 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
5397963751424 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 133 key (13218357403648 
EXTENT_ITEM 28672) itemoff 10426 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 134 key (13218357432320 
EXTENT_ITEM 32768) itemoff 10389 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 135 key (13218357465088 
EXTENT_ITEM 36864) itemoff 10352 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601322930176 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 136 key (13218357501952 
EXTENT_ITEM 32768) itemoff 10315 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084916248576 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 137 key (13218357534720 
EXTENT_ITEM 32768) itemoff 10278 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 138 key (13218357567488 
EXTENT_ITEM 32768) itemoff 10241 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083885318144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 139 key (13218357600256 
EXTENT_ITEM 20480) itemoff 10204 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083467198464 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 140 key (13218357620736 
EXTENT_ITEM 28672) itemoff 10167 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083885318144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 141 key (13218357649408 
EXTENT_ITEM 28672) itemoff 10130 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
838913851392 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 142 key (13218357678080 
EXTENT_ITEM 8192) itemoff 10080 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601337839616 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
2329940934656 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 143 key (13218357686272 
EXTENT_ITEM 36864) itemoff 10043 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 144 key (13218357723136 
EXTENT_ITEM 32768) itemoff 10006 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 145 key (13218357755904 
EXTENT_ITEM 20480) itemoff 9969 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1869710753792 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 146 key (13218357776384 
EXTENT_ITEM 40960) itemoff 9932 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601322930176 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 147 key (13218357817344 
EXTENT_ITEM 16384) itemoff 9895 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 148 key (13218357833728 
EXTENT_ITEM 20480) itemoff 9858 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083876044800 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 149 key (13218357854208 
EXTENT_ITEM 36864) itemoff 9821 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 150 key (13218357891072 
EXTENT_ITEM 24576) itemoff 9784 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 151 key (13218357915648 
EXTENT_ITEM 8192) itemoff 9734 itemsize 50
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601337839616 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
2329940934656 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 152 key (13218357923840 
EXTENT_ITEM 32768) itemoff 9697 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084924850176 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 153 key (13218357956608 
EXTENT_ITEM 32768) itemoff 9660 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 154 key (13218357989376 
EXTENT_ITEM 32768) itemoff 9623 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
5398038151168 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 155 key (13218358022144 
EXTENT_ITEM 32768) itemoff 9586 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084916248576 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 156 key (13218358054912 
EXTENT_ITEM 32768) itemoff 9549 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
4601318146048 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 157 key (13218358087680 
EXTENT_ITEM 32768) itemoff 9512 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
1584449798144 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 158 key (13218358120448 
EXTENT_ITEM 12288) itemoff 9475 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 159 key (13218358132736 
EXTENT_ITEM 12288) itemoff 9438 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1228851 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084410523648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 160 key (13218358145024 
EXTENT_ITEM 98304) itemoff 9401 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 161 key (13218358243328 
EXTENT_ITEM 77824) itemoff 9364 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 162 key (13218358321152 
EXTENT_ITEM 57344) itemoff 9327 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 163 key (13218358378496 
EXTENT_ITEM 53248) itemoff 9290 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6084834459648 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 164 key (13218358431744 
EXTENT_ITEM 24576) itemoff 9224 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4495 offset 9940992 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601603588096 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 165 key (13218358456320 
EXTENT_ITEM 28672) itemoff 9158 itemsize 66
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 2 gen 1239973 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
256 objectid 4239 offset 8441856 count 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#1: shared data backref parent 
4601626492928 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 166 key (13218358484992 
EXTENT_ITEM 4096) itemoff 9105 itemsize 53
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1240050 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: extent data backref root 
2751 objectid 3362 offset 2549006336 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 167 key (13218358489088 
EXTENT_ITEM 32768) itemoff 9068 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083535126528 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 168 key (13218358521856 
EXTENT_ITEM 32768) itemoff 9031 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083535126528 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 169 key (13218358554624 
EXTENT_ITEM 32768) itemoff 8994 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083535126528 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 170 key (13218358587392 
EXTENT_ITEM 65536) itemoff 8957 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083504668672 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 171 key (13218358652928 
EXTENT_ITEM 36864) itemoff 8920 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083504668672 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 172 key (13218358689792 
EXTENT_ITEM 77824) itemoff 8883 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083504963584 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 173 key (13218358767616 
EXTENT_ITEM 81920) itemoff 8846 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083504963584 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 174 key (13218358849536 
EXTENT_ITEM 24576) itemoff 8809 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083504963584 count 1
Feb 10 13:31:07 opi02 kernel: \x09item 175 key (13218358874112 
EXTENT_ITEM 28672) itemoff 8772 itemsize 37
Feb 10 13:31:07 opi02 kernel: \x09\x09extent refs 1 gen 1226216 flags 1
Feb 10 13:31:07 opi02 kernel: \x09\x09ref#0: shared data backref parent 
6083504963584 count 1
Feb 10 13:31:07 opi02 kernel: BTRFS error (device nvme0n1p3): 
block=6083107078144 write time tree block corruption detected
Feb 10 13:31:07 opi02 kernel: BTRFS: error (device nvme0n1p3) in 
btrfs_commit_transaction:2555: errno=-5 IO failure (Error while writing 
out transaction)
Feb 10 13:31:07 opi02 kernel: BTRFS info (device nvme0n1p3 state E): 
forced readonly
Feb 10 13:31:07 opi02 kernel: BTRFS warning (device nvme0n1p3 state E): 
Skipping commit of aborted transaction.
Feb 10 13:31:07 opi02 kernel: BTRFS error (device nvme0n1p3 state EA): 
Transaction aborted (error -5)
Feb 10 13:31:07 opi02 kernel: BTRFS: error (device nvme0n1p3 state EA) 
in cleanup_transaction:2037: errno=-5 IO failure

Unfortunately I don't have more information at the moment.

Thanks in advance,

David Arendt


