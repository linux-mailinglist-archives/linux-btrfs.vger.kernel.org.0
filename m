Return-Path: <linux-btrfs+bounces-6627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 465339381CC
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 17:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7EA1F2170B
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6978D13C80C;
	Sat, 20 Jul 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (768-bit key) header.d=casa-di-locascio.net header.i=@casa-di-locascio.net header.b="hgmKoJiW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE73209
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Jul 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721488942; cv=none; b=o1PtezfMLG3bsD+XEmzhcm+dTJkzBLyDps2sEjX9Yvfhvg0jGtmoteffbbQGbGylx7B4+x9FE0wewwybnh5HxPlf5DZDKSf4btvG5QWNJ1LBOGfXTvx4OJPVnol+Gbs6+FKhVPUApKvlIr2d4uTssWf2go+u79Ms/7xm+SpZntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721488942; c=relaxed/simple;
	bh=BAxFi3HZv2vEJVOAtuZSJyD71neUU11+2KT+hP7Hiz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cI1Z7m448LlKzkY+wkI63sXdIz/lcvMkJ1Y1CW5L+daGVB5xwbrxLpKhtV9GX6Ccwxxlxjf0KZKZabD+JR0XjSORyaWnlkgr05O65RWGBXFiz/cZf3YrJnUQfHSFHyRDKv0wxm6Hu6Gs/s313uH+Ju8mX9dY6dA+aPwCB2IrEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roosoft.ltd.uk; spf=pass smtp.mailfrom=roosoft.ltd.uk; dkim=policy (768-bit key) header.d=casa-di-locascio.net header.i=@casa-di-locascio.net header.b=hgmKoJiW reason="signing key too small"; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roosoft.ltd.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roosoft.ltd.uk
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id UuSosPNE6vH7lVBuWsiqbU; Sat, 20 Jul 2024 15:22:12 +0000
Received: from box2278.bluehost.com ([50.87.176.218])
	by cmsmtp with ESMTPS
	id VBuVsItNkeCxMVBuVsepiB; Sat, 20 Jul 2024 15:22:11 +0000
X-Authority-Analysis: v=2.4 cv=M/yGKDws c=1 sm=1 tr=0 ts=669bd623
 a=XwlUGG/Joq/Evm8SRPjtJg==:117 a=XwlUGG/Joq/Evm8SRPjtJg==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=CngwRIvfAAAA:8 a=fbCOJJXJpDEY7AB36HQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=4_miDDMz0JLoEzr4jVLQ:22
 a=mCY-HCvPnkKXJ80akIyT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=casa-di-locascio.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mDHrNmac2QE+6s7ha89UMY/8E5rcs/smYH8vA9Mvi44=; b=hgmKoJiWQ4WIAcqd6RdetJ7vau
	u92CQuWMwcahziHKdu/oMk4Xez1HSTqpLNqpbULSV44tl+E2mmlvmoO1MkjF1JKzlGo61WdvR648Q
	33pLIG9FThoFNiFYJyb+yL/fa;
Received: from [45.95.250.46] (port=11483 helo=[192.168.1.158])
	by box2278.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <devel@roosoft.ltd.uk>)
	id 1sVBuS-002cPV-1r;
	Sat, 20 Jul 2024 09:22:08 -0600
Message-ID: <e1e2de51-de74-418d-9179-cbcdb9e05ac1@roosoft.ltd.uk>
Date: Sat, 20 Jul 2024 16:22:06 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unable to mount after successful replace.
To: devel@roosoft.ltd.uk,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <98c97077-b801-46b0-9410-8cc57780a0c0@roosoft.ltd.uk>
Content-Language: en-US
From: devel@roosoft.ltd.uk
Disposition-Notification-To: devel@roosoft.ltd.uk
In-Reply-To: <98c97077-b801-46b0-9410-8cc57780a0c0@roosoft.ltd.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box2278.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roosoft.ltd.uk
X-BWhitelist: no
X-Source-IP: 45.95.250.46
X-Source-L: No
X-Exim-ID: 1sVBuS-002cPV-1r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.158]) [45.95.250.46]:11483
X-Source-Auth: fpd_eacct+casa-di-locascio.net
X-Email-Count: 1
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: Y2FzYWRpbG87Y2FzYWRpbG87Ym94MjI3OC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHPy4g/1liX7QVJWqfGxPpWd9b2ny8/21qyOsMsfhHk4vcIqXYWFMuM+dtJeeEDYBI3ibiGx6O5ziPjGP75kuf2zyrk8KOOv0xufudb0CC0o8+mztx84
 aKo73Dm39vVt1TpE2pnkazmkQZu80fqaIA1HLrc9lUdBLrjaJ9XMUUk8hZ9PkWIdu8dByHDWzNjiQY/nJ/TVIKAudTISpUZl3W8=

So I ran btrfs check and this was the result:

```
btrfs check -p /dev/sdb

Opening filesystem to check...
warning, device 5 is missing
warning, device 5 is missing
Checking filesystem on /dev/sdb
UUID: 6abaa68a-2670-4d8b-8d2a-fd7321df9242
[1/7] checking root items                      (0:01:36 elapsed, 3161640 
items checked)
[2/7] checking extents                         (0:10:08 elapsed, 1911321 
items checked)
ERROR: super total bytes 48000554500096 smaller than real device(s) size 
60000693125120
ERROR: mounting this fs may fail for newer kernels
ERROR: this can be fixed by 'btrfs rescue fix-device-size'
[3/7] checking free space tree                 (0:00:37 elapsed, 8170 
items checked)
[4/7] checking fs roots                        (1:22:23 elapsed, 67109 
items checked)
[5/7] checking csums (without verifying data)  (0:58:05 elapsed, 6127677 
items checked)
[6/7] checking root refs                       (0:00:00 elapsed, 72 
items checked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 26187700850688 bytes used, error(s) found
total csum bytes: 25543346724
total tree bytes: 31313805312
total fs tree bytes: 1104560128
total extent tree bytes: 280035328
btree space waste bytes: 4225057421
file data blocks allocated: 27050290237440
  referenced 26216212553728

```

But then when I run 'btrfs rescue fix-device-size' it fails because the 
device is missing.

```
btrfs rescue fix-device-size 
/dev/disk/by-uuid/6abaa68a-2670-4d8b-8d2a-fd7321df9242
warning, device 5 is missing
warning, device 5 is missing
ERROR: devid 5 is missing or not writeable
ERROR: fixing device size needs all device(s) to be present and writeable

```


How am I supposed to rectify this?



On 19/07/2024 23:52, devel@roosoft.ltd.uk wrote:
> Hi,
>
> btrfs-progs v6.3.2
>
> 6.5.0-4-amd64
>
>
> I ran a successful replace upgrading a 12 to 14Tb  disk in a 4 disk 
> filesystem
>
> > Started on 14.Jul 08:36:44, finished on 19.Jul 13:39:31, 0 write 
> errs, 0 uncorr. read errs
>
> So I shut the machine down,  physically swapped the disks and rebooted.
>
> But the filesystem now fails to mount even in degraded mode because it 
> is missing the replaced device.
>
> ```
> btrfs fi show
> Label: none  uuid: 6abaa68a-2670-4d8b-8d2a-fd7321df9242
>     Total devices 4 FS bytes used 23.82TiB
>     devid    0 size 10.91TiB used 7.96TiB path /dev/sde
>     devid    1 size 10.91TiB used 7.96TiB path /dev/sdb
>     devid    2 size 10.91TiB used 7.96TiB path /dev/sdc
>     devid    4 size 10.91TiB used 7.96TiB path /dev/sdd
>
> ```
>
> ```
>
> mount -o degraded /dev/sdb /mnt/ext/
> mount: /mnt/ext: mount(2) system call failed: Structure needs cleaning.
>        dmesg(1) may have more information after failed mount system call.
>
> ```
>
> ```
>
> [Fri Jul 19 23:16:28 2024] BTRFS info (device sdb): using crc32c 
> (crc32c-generic) checksum algorithm
> [Fri Jul 19 23:16:28 2024] BTRFS info (device sdb): allowing degraded 
> mounts
> [Fri Jul 19 23:16:28 2024] BTRFS info (device sdb): using free space tree
> [Fri Jul 19 23:16:28 2024] BTRFS warning (device sdb): devid 5 uuid 
> 951ef490-5bfe-412d-b65e-8a6393428431 is missing
> [Fri Jul 19 23:16:28 2024] BTRFS info (device sdb): bdev /dev/sde 
> errs: wr 60252097, rd 0, flush 0, corrupt 0, gen 0
> [Fri Jul 19 23:16:28 2024] BTRFS info (device sdb): bdev <missing 
> disk> errs: wr 60254549, rd 25, flush 0, corrupt 0, gen 0
> [Fri Jul 19 23:16:28 2024] BTRFS error (device sdb): replace without 
> active item, run 'device scan --forget' on the target device
> [Fri Jul 19 23:16:28 2024] BTRFS error (device sdb): failed to init 
> dev_replace: -117
> [Fri Jul 19 23:16:28 2024] BTRFS error (device sdb): open_ctree failed
>
> ```
> I have tried `btrfs dev scan --forget` to no avail.
>
> How do I remove the offending id when I am unable to mount the 
> filesystem ?
>
> Thanks in  advance.
>
>
>
>
>
> Don Alexander
>
>

-- 
==

D LoCascio

Director

RooSoft Ltd


