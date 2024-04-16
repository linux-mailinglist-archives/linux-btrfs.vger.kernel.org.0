Return-Path: <linux-btrfs+bounces-4292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095D48A63B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 08:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51110B24872
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 06:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671947F486;
	Tue, 16 Apr 2024 06:20:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0894F76035
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248407; cv=none; b=JIx+Ctvbkm37I7l5zrii9E+wSsYhPOluy4CgzG0nXotoyQnRFBEz91SfOl2xweL8x4Ngbmgop39ItfEPyvchaRYck2ELQHqukNS2gg2HIZowQPiwJ9b2RvsD67E36n7FSKfUTQOq5iAS6s5Tw++WH4AYVu5ZP8ZUidWyqcupMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248407; c=relaxed/simple;
	bh=UCi4rcgA5fZ3e+TSxlWrrHzMaS6Gt+EgJKBPtHwC5dI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=IFzWQ1n5I4EP3+tRCYQkGtSyCpUdqb5czaLTBYkKtwESXoRGml3zbNKldnk1nxt8iSs3/LzZb6IPtpDgElhxirc1KByP6dF2Xn8k2SeNG5tavdgNdKzHrbwX4BiFeE6gGBLZP4rG0u7l+yUKHQtiBAATfEyYorwlJAKMX+0KSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 7E10BC08101
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 08:09:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LGBGrM2U3jhQ for <linux-btrfs@vger.kernel.org>;
	Tue, 16 Apr 2024 08:09:55 +0200 (CEST)
Received: from [192.168.1.195] (unknown [81.56.116.160])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 16B6FC080FD
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 08:09:54 +0200 (CEST)
Message-ID: <47e425a3-76b9-4e51-93a0-cde31dd39003@dubiel.pl>
Date: Tue, 16 Apr 2024 08:09:50 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leszek Dubiel <leszek@dubiel.pl>
Subject: =?UTF-8?Q?enospc_errors_during_balance_=E2=80=94_how_to_prevent_out?=
 =?UTF-8?Q?_of_space?=
Content-Language: pl-PL
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Hello :) :)



My disk got full, so I have removed snapshots and
now it has plenty of free space, see:


# df -h /
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdc3       8.2T  7.2T  1.1T  88% /


# btrfs fi show /
Label: none  uuid: ec3525ef-b73a-452a-a4ee-86286252d730
     Total devices 3 FS bytes used 7.11TiB
     devid    1 size 5.43TiB used 5.42TiB path /dev/sdc3
     devid    2 size 5.43TiB used 5.42TiB path /dev/sda3
     devid    3 size 5.43TiB used 5.43TiB path /dev/sdb3


# btrfs fi df /
Data, RAID1: total=8.09TiB, used=7.07TiB
System, RAID1: total=32.00MiB, used=1.38MiB
Metadata, RAID1: total=45.04GiB, used=39.08GiB
GlobalReserve, single: total=512.00MiB, used=32.00KiB





But i got error  NO FREE SPACE.




# btrfs device usage /
/dev/sdc3, ID: 1
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.39TiB
    Metadata,RAID1:         39.04GiB
    System,RAID1:           32.00MiB
    Unallocated:             1.00MiB

/dev/sda3, ID: 2
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.39TiB
    Metadata,RAID1:         38.03GiB
    System,RAID1:           32.00MiB
    Unallocated:             1.00MiB

/dev/sdb3, ID: 3
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.41TiB
    Metadata,RAID1:         13.00GiB
    Unallocated:             1.00MiB





I noticed 1Mb for Unallocated space, so
I have run multiple times balance (data usage filter):

          btrfs balance start -dusage=XX,limit=1 /


and it didn't help.

It even got error no space when balancing:

syslog-2024-04-15T14:20:41.498301+02:00 zefir kernel: [161213.968020] 
BTRFS info (device sdc3): balance: start -dusage=70,limit=3
syslog-2024-04-15T14:20:41.510297+02:00 zefir kernel: [161213.978076] 
BTRFS info (device sdc3): relocating block group 31021491027968 flags 
data|raid1
syslog-2024-04-15T14:20:46.118283+02:00 zefir kernel: [161218.585833] 
BTRFS info (device sdc3): relocating block group 30657484161024 flags 
data|raid1
syslog-2024-04-15T14:20:50.406268+02:00 zefir kernel: [161222.874987] 
BTRFS info (device sdc3): relocating block group 30654262935552 flags 
data|raid1
syslog:2024-04-15T14:21:01.270284+02:00 zefir kernel: [161233.739112] 
BTRFS info (device sdc3): 3 enospc errors during balance
syslog-2024-04-15T14:21:01.270305+02:00 zefir kernel: [161233.739119] 
BTRFS info (device sdc3): balance: ended with status: -28





Then multiple times both for data and metadata:

             btrfs balance start -musage=XX,limit=1 /

             btrfs balance start -dusage=50,limit=1 /




Unallocated space increased:

# btrfs device usage /
/dev/sdc3, ID: 1
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.39TiB
    Metadata,RAID1:         39.04GiB
    System,RAID1:           32.00MiB
    Unallocated:             1.00MiB

/dev/sda3, ID: 2
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.39TiB
    Metadata,RAID1:         38.03GiB
    System,RAID1:           32.00MiB
    Unallocated:             1.00MiB

/dev/sdb3, ID: 3
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.41TiB
    Metadata,RAID1:         13.00GiB
    Unallocated:            21.57MiB



and now I have:

/dev/sdc3, ID: 1
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.36TiB
    Metadata,RAID1:         40.00GiB
    Unallocated:            31.06GiB

/dev/sda3, ID: 2
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.36TiB
    Metadata,RAID1:         36.00GiB
    System,RAID1:           32.00MiB
    Unallocated:            28.06GiB

/dev/sdb3, ID: 3
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.38TiB
    Metadata,RAID1:         12.00GiB
    System,RAID1:           32.00MiB
    Unallocated:            31.02GiB



Should I run balance quite often to prevent Unallocated space to go as 
low as 1.00MiB?

How to prevent "NO SPACE ERROR" when there is pleny of space left?

Run balance regularly to keep Unallocated space high?



Thank you.
I am using BTRFS in production many, many years (since 2010 maybe?).





