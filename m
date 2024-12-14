Return-Path: <linux-btrfs+bounces-10378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E279F20A9
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 21:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59932166CAE
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E2A1AD3F5;
	Sat, 14 Dec 2024 20:13:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8618BC1D
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734207204; cv=none; b=ddcy1+T+F/maW/p3Tb5El0W/FtLZvzX/CYvNs05Qw5XSGWKYpuvgE33C0rE5bpaSoUGeD7AicpCRBFla3zfP2JmjGsT3tJfrQRrPpA3x6UT9/vwpRfTxD+/VlOSI+IbCboQU3MDql5o7U9eCth1NdivDUGm254WtbLY/cxj9Lxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734207204; c=relaxed/simple;
	bh=v2ek37cJuB27DTCcxqlt4kfUNCM3/l3t1lvwNlNnBJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YarkhJ8l9BmzSWm2w392KoIAXDGGNjc78DYOZnFy9s95L+58qPdV6W+/GXmeG9UZyVEXhBqVsMM0C4fq6ytjls5MmwDhmfrXc4EHibgknZVxYNIBwUpKYJSPUERWsQqvParyF9Wwp4mSmkFC8/XeachjpmYK9KeJIY/e73VKNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id C527DC0EE6C;
	Sat, 14 Dec 2024 21:13:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id r_uNH0j4Jx-N; Sat, 14 Dec 2024 21:13:14 +0100 (CET)
Received: from [192.168.1.29] (aadu23.neoplus.adsl.tpnet.pl [83.4.98.23])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id A4E34C0A7D9;
	Sat, 14 Dec 2024 21:13:14 +0100 (CET)
Message-ID: <4144f14a-8742-4092-b558-d1a9de4d03e5@dubiel.pl>
Date: Sat, 14 Dec 2024 21:13:12 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 97% full system, dusage didn't help, musage strange
To: Andrei Borzenkov <arvidjaar@gmail.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0a837cc1-81d4-4c51-9097-1b996a64516e@dubiel.pl>
 <8c923965-f47c-4b4c-b096-9ddc0f047385@gmail.com>
Content-Language: en-US, pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
In-Reply-To: <8c923965-f47c-4b4c-b096-9ddc0f047385@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>
>
> btrfs filesystem usage -T
>

Overall:
     Device size:          16.28TiB
     Device allocated:          16.24TiB
     Device unallocated:          38.02GiB
     Device missing:             0.00B
     Device slack:             0.00B
     Used:              15.75TiB
     Free (estimated):         264.00GiB    (min: 264.00GiB)
     Free (statfs, df):         257.98GiB
     Data ratio:                  2.00
     Metadata ratio:              2.00
     Global reserve:         512.00MiB    (used: 160.00KiB)
     Multiple profiles:                no

              Data    Metadata System
Id Path      RAID1   RAID1    RAID1    Unallocated Total    Slack
-- --------- ------- -------- -------- ----------- -------- -----
  1 /dev/sdb2 5.39TiB 28.00GiB 32.00MiB    13.00GiB  5.43TiB     -
  2 /dev/sdc2 5.39TiB 20.00GiB        -    13.03GiB  5.43TiB     -
  3 /dev/sda3 5.38TiB 34.00GiB 32.00MiB    12.00GiB  5.43TiB     -
-- --------- ------- -------- -------- ----------- -------- -----
    Total     8.08TiB 41.00GiB 32.00MiB    38.02GiB 16.28TiB 0.00B
    Used      7.84TiB 37.67GiB  1.47MiB



>>
>> But unallocated space didn't increase.
>>
>>
>
> Why did you expect it to increase? To free space balance need to pack 
> more extents into less chunks. In your case chunks are near to full 
> and extents are relatively large, so chunks simply may not have enough 
> free space to accommodate more extents. You just move extents around.
>

Ok. I didn't exactly know what chunks are compared to extents.





> Relocating one chunk simply moves extents from this chunk to another 
> location. It does not free any chunk. You can only get more 
> unallocated space when you are able to pack extents from two (or more) 
> chunks into one chunk. Which is only possible if chunks are filled to 
> 50%.
>

Thank you for explanation.




>> What should i do next?
>
> It looks like your filesystem is simply full. Do you have reasons to 
> believe that it is not true?


It is backup server. It should be almost full.
I have a procedure that:

— removes old snapshots if free space is less then 250 GB
— starts balancing if there is less then 8GB of unallocated space on any 
disk


It failed now — there is 258 GB free, but balancing didn't help to 
restore unallocated space.
















