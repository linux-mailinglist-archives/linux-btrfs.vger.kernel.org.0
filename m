Return-Path: <linux-btrfs+bounces-8325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CAD989F72
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E751F234A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3223C189B98;
	Mon, 30 Sep 2024 10:33:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C85336E
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692383; cv=none; b=mtNeXOwyOTF9bzpDOdObW7rZ9X7QNQaLI0biBPYAD/1fOJbKfAhYeplfY+xGnreLhFjCnVhD0KkRRr7JO/t8BDa1HruJ2pf3F2ZfU5+Q9hoE2ONwpYRrgYIW/yVIrwCEJ5TFwQxQMOW4ZtMOHp3iMjkcWdD/K7ms+8hTBr4NUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692383; c=relaxed/simple;
	bh=hIpbctvLMApJZ1ZgnVc975/3TMNMBuW+eiLi391CzPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H5v3FhdCmTgtJZBET2r9Gxn2RR9TAi87zCmiZglYxkue4s1GlRgmdlGm7/Gcs2Ylzl/z7dxaG/i5NlloyVYq0MeOgzIIlCpmn/7KR1jzWvCfWAibi8RyBDPT93Y9ozNFE0HbhDKz0dZDlEnBHllFsNCxCX6My8LvnHebWTBc1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 3101AC0A7C8;
	Mon, 30 Sep 2024 12:32:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6NSIF8PZq-Al; Mon, 30 Sep 2024 12:32:56 +0200 (CEST)
Received: from [192.168.18.35] (unknown [157.25.148.26])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 028CCC0A7B8;
	Mon, 30 Sep 2024 12:32:55 +0200 (CEST)
Message-ID: <b7da7c14-086a-41ef-8b7a-8a1987eb96cf@dubiel.pl>
Date: Mon, 30 Sep 2024 12:32:54 +0200
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
 <c59b8d64-e9dc-4cf5-94f4-554f9f05d797@dubiel.pl>
 <34787783-dfb8-4505-848d-ed31913cc478@gmx.com>
Content-Language: en-US, pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
In-Reply-To: <34787783-dfb8-4505-848d-ed31913cc478@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> Unfortunately we need the full output without interruption.
>
> And I didn't notice there are 4 devices involved, in that case, if you
> are able to run the command again:
>
> # btrfs scrub start -BdR <mnt>
>
> Just in case, is the fs using RAID5/6?


It's Raid-1.

I will run tests on weekend and give full output.
I will run command in "screen" and "script".



Thank you. :)



=======




# btrfs scrub start -BdR /
Starting scrub on devid 2
Starting scrub on devid 3
Starting scrub on devid 4
Starting scrub on devid 6
^C
Scrub device /dev/sdc2 (id 2) canceled
Scrub started:    Mon Sep 30 12:30:28 2024
Status:           aborted
Duration:         0:00:32
     data_extents_scrubbed: 13297
     tree_extents_scrubbed: 6406
     data_bytes_scrubbed: 856694784
     tree_bytes_scrubbed: 104955904
     read_errors: 0
     csum_errors: 0
     verify_errors: 0
     no_csum: 0
     csum_discards: 209154
     super_errors: 0
     malloc_errors: 0
     uncorrectable_errors: 0
     unverified_errors: 0
     corrected_errors: 0
     last_physical: 1074790400

Scrub device /dev/sdd2 (id 3) canceled
Scrub started:    Mon Sep 30 12:30:28 2024
Status:           aborted
Duration:         0:00:32
     data_extents_scrubbed: 1662
     tree_extents_scrubbed: 12007
     data_bytes_scrubbed: 101195776
     tree_bytes_scrubbed: 196722688
     read_errors: 0
     csum_errors: 0
     verify_errors: 0
     no_csum: 0
     csum_discards: 24706
     super_errors: 0
     malloc_errors: 0
     uncorrectable_errors: 0
     unverified_errors: 0
     corrected_errors: 0
     last_physical: 0

Scrub device /dev/sdb3 (id 4) canceled
Scrub started:    Mon Sep 30 12:30:28 2024
Status:           aborted
Duration:         0:00:32
     data_extents_scrubbed: 23297
     tree_extents_scrubbed: 158
     data_bytes_scrubbed: 242241536
     tree_bytes_scrubbed: 2588672
     read_errors: 0
     csum_errors: 0
     verify_errors: 0
     no_csum: 0
     csum_discards: 59141
     super_errors: 0
     malloc_errors: 0
     uncorrectable_errors: 0
     unverified_errors: 0
     corrected_errors: 0
     last_physical: 68157440

Scrub device /dev/sda3 (id 6) canceled
Scrub started:    Mon Sep 30 12:30:28 2024
Status:           aborted
Duration:         0:00:32
     data_extents_scrubbed: 14829
     tree_extents_scrubbed: 155
     data_bytes_scrubbed: 971776000
     tree_bytes_scrubbed: 2539520
     read_errors: 0
     csum_errors: 0
     verify_errors: 0
     no_csum: 0
     csum_discards: 237250
     super_errors: 0
     malloc_errors: 0
     uncorrectable_errors: 0
     unverified_errors: 0
     corrected_errors: 0
     last_physical: 68157440





root@wawel:/etc/default# btrfs fi usa /
Overall:
     Device size:          27.22TiB
     Device allocated:          26.94TiB
     Device unallocated:         292.89GiB
     Device missing:             0.00B
     Device slack:           7.00KiB
     Used:              24.32TiB
     Free (estimated):           1.33TiB    (min: 1.33TiB)
     Free (statfs, df):           1.29TiB
     Data ratio:                  2.00
     Metadata ratio:              2.00
     Global reserve:         512.00MiB    (used: 0.00B)
     Multiple profiles:                no

Data,RAID1: Size:13.32TiB, Used:12.13TiB (91.07%)
    /dev/sdc2       5.30TiB
    /dev/sdd2       5.30TiB
    /dev/sdb3      10.64TiB
    /dev/sda3       5.39TiB

Metadata,RAID1: Size:151.00GiB, Used:27.53GiB (18.23%)
    /dev/sdc2      79.00GiB
    /dev/sdd2      77.00GiB
    /dev/sdb3     146.00GiB

System,RAID1: Size:64.00MiB, Used:2.42MiB (3.78%)
    /dev/sdc2      32.00MiB
    /dev/sdb3      64.00MiB
    /dev/sda3      32.00MiB

Unallocated:
    /dev/sdc2      72.00GiB
    /dev/sdd2      71.06GiB
    /dev/sdb3     116.00GiB
    /dev/sda3      33.83GiB
root@wawel:/etc/default# btrfs dev usa /
/dev/sdc2, ID: 2
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,RAID1:              5.30TiB
    Metadata,RAID1:         79.00GiB
    System,RAID1:           32.00MiB
    Unallocated:            72.00GiB

/dev/sdd2, ID: 3
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,RAID1:              5.30TiB
    Metadata,RAID1:         77.00GiB
    Unallocated:            71.06GiB

/dev/sdb3, ID: 4
    Device size:            10.90TiB
    Device slack:            3.50KiB
    Data,RAID1:             10.64TiB
    Metadata,RAID1:        146.00GiB
    System,RAID1:           64.00MiB
    Unallocated:           116.00GiB

/dev/sda3, ID: 6
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              5.39TiB
    System,RAID1:           32.00MiB
    Unallocated:            33.83GiB













