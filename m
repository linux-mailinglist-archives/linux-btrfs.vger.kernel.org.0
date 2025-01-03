Return-Path: <linux-btrfs+bounces-10718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398A4A01070
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 23:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBD916413D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 22:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69D1BDA91;
	Fri,  3 Jan 2025 22:58:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE71B6CE4
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945092; cv=none; b=eeeuMJraWuZ9C4i3olr8d5c0ZGVaCbhxAlluwE/reIiBQ3hZycQOG3w9aqIXnRZO4czwj96GTLpTm93ubJdncFOcq+kVBb+92/lnyRGe3Zs2HO0qp0j01R+MMy2DeJDCo7HiJqVwNo5EUkJ7v5T8Uf8rzjQ7lEt3LMBUP7s+e+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945092; c=relaxed/simple;
	bh=dfPUYR7dHf/APuMUMlSW8Z2OvHq1tTK/bkQlpuL6q1A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ijIliaZeR7GVTA3yElB9om7dkF5Jy/ukUnW7Qv2u+ZkO/pHCa9HvuL2Q+sfRuloGJHv62pG+b73Ea/ULzRXe5cP08jwJIy9tUMQgrzUOeB63IhlwVQQ2ZavNt8eN0ey0A2uV93q3+mkORPVtQUpoGcHFkyQBH6ozvQSHN4UhKvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 36B41C08E1A
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 23:52:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sqN5FfBNqNZp for <linux-btrfs@vger.kernel.org>;
	Fri,  3 Jan 2025 23:52:32 +0100 (CET)
Received: from [192.168.55.34] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 4FC7DC08D9D
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 23:52:32 +0100 (CET)
Message-ID: <000bcef0-a86e-4832-90bb-9a4a47afad6d@dubiel.pl>
Date: Fri, 3 Jan 2025 23:52:30 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leszek Dubiel <leszek@dubiel.pl>
Subject: Re: 97% full system, dusage didn't help, musage strange
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
 <8c923965-f47c-4b4c-b096-9ddc0f047385@gmail.com>
 <4144f14a-8742-4092-b558-d1a9de4d03e5@dubiel.pl>
 <8eb9e55e-7a61-4c1a-b5ab-acf35ba4396e@gmx.com>
 <ea8eb95c-e64a-4589-b302-23eb1fc6bd5c@dubiel.pl>
 <a6a641f6-b0a1-4915-912a-638cc07eba88@suse.com>
Content-Language: en-US, pl-PL
In-Reply-To: <a6a641f6-b0a1-4915-912a-638cc07eba88@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit










W dniu 16.12.2024 o 22:01, Qu Wenruo pisze:



 > If you want to be extra safe, the best solution is to use tools that 
can report the usage percentage of each block group.
 >
 > You need something procedure like this:
 >
 > start:
 >     if (unallocated space >= 8GiB)
 >         return;
 > check_usage_percentage:
 >     if (no block group has usage percentage < 30%) {
 >         delete_files;
 >         goto check_usage_percentage;
 >     }
 >     balance dusage=30
 >     goto start;
 >
 > Although there are some concerns, firstly the tool, sorry I didn't 
remember the name but there is an out-of-btrfs-progs tool can do exactly 
that.

In btrfs-progs package I didn't find any such tool.

There is "btrfs maintenance" by kdave:

                      https://github.com/kdave/btrfsmaintenance

but it starts normal balance, it doesn't analize "block usage percentage".




 >> How to improve?
 >>
 >> Tell the first procedure to keep 500GB free space? 800GB?
 >
 > Increasing the free space will definitely increase the chance of 
reclaiming space using balance.
 >
 > But that's only increasing the chance, never to ensure that.
 >
 > As you can keep 800GiB free space, but since your fs have 8TiB data 
space, for the worst case scenario where all space are freed evenly 
among all chunks, it means each 1GiB chunk will only have around 100MiB 
(10%) freed.
 >
 > That is not really going to chance the result of balance.
 > But that's for the worst case scenario.


I think I'm hitting the worst case scenario again and again.

It looks as if my BTRFS system is always going towards that situation 
where "all space are freed evenly among all chunks".





I wrote a script that ensures:

— at least 200 GB free disk space
— at least 5% free disk space

Then another script to balance btrfs when there is low "Unallocated space".




It got stuck:

# df -h ./sdc3/

Filesystem      Size  Used Avail Use% Mounted on
/dev/sdc3       2.7T  2.5T  226G  92% /mnt/leszek/sdc3


# btrfs filesystem usage ./sdc3 -T

Overall:
     Device size:           2.70TiB
     Device allocated:           2.68TiB
     Device unallocated:          19.45GiB
     Device missing:             0.00B
     Device slack:           3.50KiB
     Used:               2.47TiB
     Free (estimated):         225.94GiB    (min: 216.21GiB)
     Free (statfs, df):         225.87GiB
     Data ratio:                  1.00
     Metadata ratio:              2.00
     Global reserve:         512.00MiB    (used: 32.00KiB)
     Multiple profiles:                no

              Data    Metadata System
Id Path      single  DUP      DUP       Unallocated Total   Slack
-- --------- ------- -------- --------- ----------- ------- -------
  1 /dev/sdc3 2.64TiB 36.00GiB  64.00MiB    19.45GiB 2.70TiB 3.50KiB
-- --------- ------- -------- --------- ----------- ------- -------
    Total     2.64TiB 18.00GiB  32.00MiB    19.45GiB 2.70TiB 3.50KiB
    Used      2.44TiB 17.08GiB 432.00KiB





I have tried different combinations of musage, dusage...



btrfs balance start -dusage=30,limit=5 ./sdc3/

btrfs balance start -dusage=50,limit=5 ./sdc3/

btrfs balance start -dusage=90,limit=5 ./sdc3/

btrfs balance start -dusage=99,limit=5 ./sdc3/

[Fri Jan  3 23:06:57 2025] BTRFS info (device sdc3): balance: start 
-dusage=99,limit=5
[Fri Jan  3 23:06:57 2025] BTRFS info (device sdc3): relocating block 
group 10938102710272 flags data
[Fri Jan  3 23:07:20 2025] BTRFS info (device sdc3): found 10 extents, 
stage: move data extents
[Fri Jan  3 23:07:22 2025] BTRFS info (device sdc3): found 10 extents, 
stage: update data pointers
[Fri Jan  3 23:07:22 2025] BTRFS info (device sdc3): relocating block 
group 10937028968448 flags data
[Fri Jan  3 23:07:43 2025] BTRFS info (device sdc3): found 11 extents, 
stage: move data extents
[Fri Jan  3 23:07:44 2025] BTRFS info (device sdc3): found 11 extents, 
stage: update data pointers
[Fri Jan  3 23:07:45 2025] BTRFS info (device sdc3): relocating block 
group 10935955226624 flags data
[Fri Jan  3 23:08:04 2025] BTRFS info (device sdc3): found 9 extents, 
stage: move data extents
[Fri Jan  3 23:08:06 2025] BTRFS info (device sdc3): found 9 extents, 
stage: update data pointers





btrfs balance start -musage=30,limit=5 ./sdc3/

btrfs balance start -musage=50,limit=5 ./sdc3/

btrfs balance start -musage=90,limit=5 ./sdc3/

btrfs balance start -musage=99,limit=5 ./sdc3/


What is strange with "musage"?

When I run with "musage" btrfs finds "24 extents" but for "system|dup".

[Fri Jan  3 22:30:59 2025] BTRFS info (device sdc3): balance: start 
-musage=30,limit=1 -susage=30,limit=1
[Fri Jan  3 22:30:59 2025] BTRFS info (device sdc3): relocating block 
group 10975113707520 flags system|dup
[Fri Jan  3 22:31:02 2025] BTRFS info (device sdc3): found 24 extents, 
stage: move data extents
[Fri Jan  3 22:31:14 2025] BTRFS info (device sdc3): balance: ended with 
status: 0
[Fri Jan  3 22:31:20 2025] BTRFS info (device sdc3): balance: start 
-dusage=50,limit=1
[Fri Jan  3 22:31:20 2025] BTRFS info (device sdc3): relocating block 
group 10975168233472 flags data
[Fri Jan  3 22:31:20 2025] BTRFS info (device sdc3): balance: ended with 
status: 0
[Fri Jan  3 22:31:21 2025] BTRFS info (device sdc3): balance: start 
-musage=50,limit=1 -susage=50,limit=1
[Fri Jan  3 22:31:21 2025] BTRFS info (device sdc3): relocating block 
group 10975159844864 flags system|dup
[Fri Jan  3 22:31:26 2025] BTRFS info (device sdc3): found 24 extents, 
stage: move data extents
[Fri Jan  3 22:31:28 2025] BTRFS info (device sdc3): balance: ended with 
status: 0



Only sometimes there is "metadata|dup", and there is a huge (!!!) amount 
of "found extents" — two thousand or four thousand:

[Fri Jan  3 18:09:49 2025] BTRFS info (device sdc3): balance: start 
-musage=90,limit=3 -susage=90,limit=3
[Fri Jan  3 18:09:49 2025] BTRFS info (device sdc3): relocating block 
group 10632086290432 flags metadata|dup
[Fri Jan  3 18:11:48 2025] BTRFS info (device sdc3): found 21714 
extents, stage: move data extents
^^^
[Fri Jan  3 18:11:52 2025] BTRFS info (device sdc3): relocating block 
group 2695122386944 flags metadata|dup
[Fri Jan  3 18:49:37 2025] BTRFS info (device sdc3): found 47432 
extents, stage: move data extents
[Fri Jan  3 18:51:06 2025] BTRFS info (device sdc3): balance: ended with 
status: 0





My command line is using only "musage":

             btrfs balance start -musage=99,limit=1 ./sdc3/

but it optimizes "system|dup" and "metadata|dup".

[Fri Jan  3 21:52:55 2025] BTRFS info (device sdc3): balance: start 
-musage=99,limit=1 -susage=99,limit=1
[Fri Jan  3 21:52:55 2025] BTRFS info (device sdc3): relocating block 
group 10945618903040 flags system|dup
[Fri Jan  3 21:52:59 2025] BTRFS info (device sdc3): found 24 extents, 
stage: move data extents
[Fri Jan  3 21:53:00 2025] BTRFS info (device sdc3): relocating block 
group 10939176452096 flags metadata|dup
[Fri Jan  3 21:58:04 2025] BTRFS info (device sdc3): found 22488 
extents, stage: move data extents
[Fri Jan  3 21:59:02 2025] BTRFS info (device sdc3): balance: ended with 
status: 0

22488 found extents?




With musage=30:

[Fri Jan  3 22:54:35 2025] BTRFS info (device sdc3): balance: start 
-musage=30,limit=1 -susage=30,limit=1
[Fri Jan  3 22:54:35 2025] BTRFS info (device sdc3): relocating block 
group 10977475100672 flags metadata|dup
[Fri Jan  3 22:55:09 2025] BTRFS info (device sdc3): found 11710 
extents, stage: move data extents
[Fri Jan  3 22:55:11 2025] BTRFS info (device sdc3): relocating block 
group 10975306645504 flags system|dup
[Fri Jan  3 22:55:14 2025] BTRFS info (device sdc3): found 26 extents, 
stage: move data extents
[Fri Jan  3 22:55:18 2025] BTRFS info (device sdc3): balance: ended with 
status: 0

11710 found extents for musage=30?




I know, that standard solution is to

1. free space
2. make balance



But now I have 226GB free space, 92% disk occupied only, and only 19 Gb 
of unallocated space.


How to reclaim unallocated space from that 226 GB free space?














