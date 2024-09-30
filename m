Return-Path: <linux-btrfs+bounces-8321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EAF9899EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 06:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630751C21022
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 04:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA39126C17;
	Mon, 30 Sep 2024 04:53:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C042AAF
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727672009; cv=none; b=RhqNfmyQSxEeVP7hwnn16zSNse1K9Ofvg0Y/+zMloyRHWrmg1TmWdwfCrRDJMWxjCgRhE21K1cCTNbK7kN+mQHuLdU9iAp4TPmn2O9HpaMXFtEV1zuJImfx2CvukX4Qu5G6aecDB4AEmdA9WRNUfzu/YRfDtMwuBkeg5Z+Zxn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727672009; c=relaxed/simple;
	bh=eWGMVz0mrftYmCUcCWsLIU86XkMeGCBNuB91Wi1YjDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Br+PD5gqai/R4cp/9kURvguOK969jkcqE38Xkm6TDI71n35lO7cXHXlf7NiwChLUYJQk9xWRdGEL2F+D61Bvz0bPn8jfb/5IIkxf8rNF2TliMOWOkPcDzcY4Z+r00zIBEjVG5uKLBKQDWyXJgNUB41crsYAaWWXKJZJmHbXmSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 5B7D2C0A752;
	Mon, 30 Sep 2024 06:53:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z3WPIWT0TNB1; Mon, 30 Sep 2024 06:53:18 +0200 (CEST)
Received: from [192.168.55.110] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 32D6FC0A753;
	Mon, 30 Sep 2024 06:53:18 +0200 (CEST)
Message-ID: <c59b8d64-e9dc-4cf5-94f4-554f9f05d797@dubiel.pl>
Date: Mon, 30 Sep 2024 06:53:16 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Bytes_scrubbed_=E2=80=94_more_than_100=25?=
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <03362532-cf30-4f02-b5fc-f1a5cc5f5a53@dubiel.pl>
 <0600035f-ef46-4b2d-af68-557541aeeb15@gmx.com>
Content-Language: en-US, pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
In-Reply-To: <0600035f-ef46-4b2d-af68-557541aeeb15@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



W dniu 29.09.2024 o 23:57, Qu Wenruo pisze:
>
>
> 在 2024/9/30 07:02, Leszek Dubiel 写道:
>>
>> Strange balance statistics — Bytes scrubbed — more than 100% — 100.06 %.
>
> Kernel version please.
>
> And it's not balance but scrub.

uname -a
Linux wawel 6.1.0-25-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.106-3 
(2024-08-26) x86_64 GNU/Linux





>> # btrfs scrub stat /
>>
>> UUID:             44803366-3981-4ebb-853b-6c991380c8a6
>> Scrub started:    Sat Sep 28 19:20:34 2024
>> Status:           running
>> Duration:         28:09:48
>> Time left:        19507110:45:51
>> ETA:              Sat Feb  9 05:16:16 4250
>> Total to scrub:   24.21TiB
>> Bytes scrubbed:   24.22TiB  (100.06%)
>> Rate:             250.51MiB/s (some device limits set)
>> Error summary:    read=1
>>    Corrected:      1
>>    Uncorrectable:  0
>>    Unverified:     0
>>
>>
>
> And output for "btrfs scrub start -BR /" please.

# btrfs scrub start -BR /
Starting scrub on devid 2
Starting scrub on devid 3
Starting scrub on devid 4
Starting scrub on devid 6
^Cscrub canceled for 44803366-3981-4ebb-853b-6c991380c8a6
Scrub started:    Mon Sep 30 06:44:44 2024
Status:           aborted
Duration:         0:00:13
     data_extents_scrubbed: 82427
     tree_extents_scrubbed: 12964
     data_bytes_scrubbed: 5232234496
     tree_bytes_scrubbed: 212402176
     read_errors: 0
     csum_errors: 0
     verify_errors: 0
     no_csum: 0
     csum_discards: 1277401
     super_errors: 0
     malloc_errors: 0
     uncorrectable_errors: 0
     unverified_errors: 0
     corrected_errors: 0
     last_physical: 2215641088


I have hit Ctrl+C, because this is production server.



Yesterday after about 10 minutes scrub was finished.



During scrub there was an error:



[1764229.950738] BTRFS info (device sdc2): found 2 extents, stage: move 
data extents
[1764231.573799] BTRFS info (device sdc2): found 2 extents, stage: 
update data pointers
[1764234.059672] BTRFS info (device sdc2): balance: ended with status: 0
[1765121.795098] BTRFS info (device sdc2): balance: start -dusage=0,limit=2
[1765121.842319] BTRFS info (device sdc2): balance: ended with status: 0
[1765122.036288] BTRFS info (device sdc2): balance: start -dusage=20,limit=2
[1765122.074392] BTRFS info (device sdc2): relocating block group 
43792020275200 flags data|raid1
[1765125.357367] BTRFS info (device sdc2): found 2 extents, stage: move 
data extents
[1765130.162696] BTRFS info (device sdc2): found 2 extents, stage: 
update data pointers
[1765131.161454] BTRFS info (device sdc2): relocating block group 
40262597345280 flags data|raid1
[1765131.976454] BTRFS info (device sdc2): found 1 extents, stage: move 
data extents
[1765133.180662] BTRFS info (device sdc2): found 1 extents, stage: 
update data pointers
[1765133.705422] BTRFS info (device sdc2): balance: ended with status: 0
[1824793.905634] BTRFS info (device sdc2): scrub: started on devid 2
[1824793.906309] BTRFS info (device sdc2): scrub: started on devid 3
[1824793.920337] BTRFS info (device sdc2): scrub: started on devid 4
[1824794.096698] BTRFS info (device sdc2): scrub: started on devid 6
[1826317.387741] perf: interrupt took too long (3929 > 3927), lowering 
kernel.perf_event_max_sample_rate to 50750
[1835794.061788] ata3.00: exception Emask 0x0 SAct 0x60fdf03f SErr 0x0 
action 0x0
[1835794.061815] ata3.00: irq_stat 0x40000008
[1835794.061831] ata3.00: failed command: READ FPDMA QUEUED
[1835794.061842] ata3.00: cmd 60/20:90:50:d6:40/01:00:93:00:00/40 tag 18 
ncq dma 147456 in
                           res 43/40:20:58:d7:40/00:01:93:00:00/00 Emask 
0x409 (media error) <F>
[1835794.061880] ata3.00: status: { DRDY SENSE ERR }
[1835794.061892] ata3.00: error: { UNC }
[1835794.067408] ata3.00: configured for UDMA/133
[1835794.067557] sd 2:0:0:0: [sdc] tag#18 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_OK cmd_age=0s
[1835794.067568] sd 2:0:0:0: [sdc] tag#18 Sense Key : Medium Error 
[current]
[1835794.067576] sd 2:0:0:0: [sdc] tag#18 Add. Sense: Unrecovered read 
error - auto reallocate failed
[1835794.067583] sd 2:0:0:0: [sdc] tag#18 CDB: Read(16) 88 00 00 00 00 
00 93 40 d6 50 00 00 01 20 00 00
[1835794.067588] I/O error, dev sdc, sector 2470500184 op 0x0:(READ) 
flags 0x0 phys_seg 3 prio class 3
[1835794.067635] ata3: EH complete
[1835794.603327] ata3.00: exception Emask 0x0 SAct 0x400077d0 SErr 0x0 
action 0x0
[1835794.603362] ata3.00: irq_stat 0x40000008
[1835794.603386] ata3.00: failed command: READ FPDMA QUEUED
[1835794.603401] ata3.00: cmd 60/08:f0:58:d7:40/00:00:93:00:00/40 tag 30 
ncq dma 4096 in
                           res 43/40:08:58:d7:40/00:00:93:00:00/00 Emask 
0x409 (media error) <F>
[1835794.603456] ata3.00: status: { DRDY SENSE ERR }
[1835794.603472] ata3.00: error: { UNC }
[1835794.609200] ata3.00: configured for UDMA/133
[1835794.609286] sd 2:0:0:0: [sdc] tag#30 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_OK cmd_age=0s
[1835794.609296] sd 2:0:0:0: [sdc] tag#30 Sense Key : Medium Error 
[current]
[1835794.609303] sd 2:0:0:0: [sdc] tag#30 Add. Sense: Unrecovered read 
error - auto reallocate failed
[1835794.609311] sd 2:0:0:0: [sdc] tag#30 CDB: Read(16) 88 00 00 00 00 
00 93 40 d7 58 00 00 00 08 00 00
[1835794.609316] I/O error, dev sdc, sector 2470500184 op 0x0:(READ) 
flags 0x800 phys_seg 1 prio class 2
[1835794.609349] ata3: EH complete
[1835795.360727] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510580, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.360982] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 260, inode 
36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.361150] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510575, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.361269] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510579, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.361364] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510576, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.391274] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510574, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.468634] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510573, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.476320] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510570, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.479512] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510569, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.479684] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510568, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.487264] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510563, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.500093] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510566, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.500278] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510567, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.508469] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510556, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.518921] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510552, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.527371] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510555, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.537808] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510554, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.541458] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510553, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.553123] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510546, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.562765] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510543, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.581281] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510538, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.586417] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510530, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.594729] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510533, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.598533] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510527, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.610179] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510521, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.618452] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510497, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.740108] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 474794, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.740278] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 474591, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.797381] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 485871, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.797529] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 485699, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.850217] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 480591, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.850363] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 480374, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.896064] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 491658, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.896208] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 491457, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.911429] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510462, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.943464] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510160, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.968486] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510359, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.992121] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510305, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835795.999645] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510270, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.010103] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510422, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.102149] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 502757, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.240543] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 501010, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.240680] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 500861, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.283617] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 503824, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.323145] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 501777, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.350275] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 499694, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.461669] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 506156, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.461812] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 505947, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.510217] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509475, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.560508] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 504761, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.599381] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 508858, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.621902] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 506961, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.643107] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510010, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.662458] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510392, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.703427] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 496448, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.703579] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 496328, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.725346] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509682, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.766586] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509152, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.811192] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509306, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.837058] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 507981, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.907900] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509003, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.954076] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510241, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835796.979035] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509838, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.035297] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 461329, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.035490] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 461179, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.117058] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510200, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.165032] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 471435, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.165200] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 471331, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.269686] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 467223, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.269876] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 467010, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.419407] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 456630, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.419548] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 456436, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.454144] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 439388, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.465529] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 482984, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.475238] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 482983, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.482156] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 451534, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.504520] BTRFS warning (device sdc2): i/o error at logical 
18020330024960 on dev /dev/sdc2, physical 1264358174720, root 445892, 
inode 36773998, offset 4096, length 4096, links 1 (path: 
home/maciol/Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
[1835797.504560] BTRFS error (device sdc2): bdev /dev/sdc2 errs: wr 0, 
rd 1, flush 0, corrupt 6513, gen 0
[1835797.516654] BTRFS error (device sdc2): fixed up error at logical 
18020330024960 on dev /dev/sdc2
[1839683.067841] perf: interrupt took too long (4917 > 4911), lowering 
kernel.perf_event_max_sample_rate to 40500
[1858484.849762] BTRFS info (device sdc2): scrub: finished on devid 6 
with status: 0
[1861863.999660] BTRFS info (device sdc2): scrub: finished on devid 3 
with status: 0
[1881501.412639] BTRFS info (device sdc2): scrub: finished on devid 2 
with status: 0
[1909672.849628] BTRFS info (device sdf3): scrub: started on devid 1
[1926492.714806] BTRFS info (device sdc2): scrub: finished on devid 4 
with status: 0
[1943962.429562] BTRFS info (device sdf3): scrub: finished on devid 1 
with status: 0
[1952243.542008] BTRFS info (device sdc2): scrub: started on devid 2
[1952243.542552] BTRFS info (device sdc2): scrub: started on devid 3
[1952243.543065] BTRFS info (device sdc2): scrub: started on devid 4
[1952243.577412] BTRFS info (device sdc2): scrub: started on devid 6
[1952256.723006] BTRFS info (device sdc2): scrub: not finished on devid 
6 with status: -125
[1952256.737537] BTRFS info (device sdc2): scrub: not finished on devid 
2 with status: -125
[1952256.738013] BTRFS info (device sdc2): scrub: not finished on devid 
3 with status: -125
[1952256.778698] BTRFS info (device sdc2): scrub: not finished on devid 
4 with status: -125














