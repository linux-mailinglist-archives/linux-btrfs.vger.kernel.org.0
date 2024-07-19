Return-Path: <linux-btrfs+bounces-6624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EE3937DEA
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 00:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BEB282026
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 22:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C36914882E;
	Fri, 19 Jul 2024 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (768-bit key) header.d=casa-di-locascio.net header.i=@casa-di-locascio.net header.b="YkxWRSZe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17747824AE
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721429546; cv=none; b=iUWM3j3If78nPnnBbGHlw4ilpfRdwuuXrXHg01zw4XaIiw0d8zeqPMGRVFcCZvf0HBtIL4IcizNfSyFEtB/+TRBBck3qbXTQd3de76gTL8BKRsoZvjjvBGK1Q2uxKlnFOsfI49F31HeCZ/OiEXgq/mOhLS8oHg6q0QqTAI2KWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721429546; c=relaxed/simple;
	bh=uaTfItKWSfHVmsIT8FFQ9FwQJFJngrzKoV4r0iMqrGw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=oMiH53kUUKZjuGZmauPzEpofW5CjPTup17BntImOZa/Srj07CLJS9jNj6ykNcYxbs/wXtzdsDrRsM1IbPzDoX5S/6WchPimXVUDi+iy2q2iyvXoBKG0bEIhz6xbpwYuwzz9fgpN3j6runAy5y8cn2ybG1nHqsb8xcvQV5dde4OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roosoft.ltd.uk; spf=pass smtp.mailfrom=roosoft.ltd.uk; dkim=policy (768-bit key) header.d=casa-di-locascio.net header.i=@casa-di-locascio.net header.b=YkxWRSZe reason="signing key too small"; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roosoft.ltd.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roosoft.ltd.uk
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id Utlysr8oDnNFGUwSWsXrav; Fri, 19 Jul 2024 22:52:16 +0000
Received: from box2278.bluehost.com ([50.87.176.218])
	by cmsmtp with ESMTPS
	id UwSVszpByX56wUwSVsba6v; Fri, 19 Jul 2024 22:52:15 +0000
X-Authority-Analysis: v=2.4 cv=MY6nuI/f c=1 sm=1 tr=0 ts=669aee1f
 a=XwlUGG/Joq/Evm8SRPjtJg==:117 a=XwlUGG/Joq/Evm8SRPjtJg==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=BDUyQTS_maiZcYpy8NIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mCY-HCvPnkKXJ80akIyT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=casa-di-locascio.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hg43emhKpqYO2f5BgtgQRtI8I3mUhi0Ylr8Nlv/SsnY=; b=YkxWRSZes0RrdWTy/RlfA+JLd0
	5QXV7SwJg7G2t8JeljSD3fST7E8nFVa1aqcMWts0An2TXigqgFwynnurQvakWB9jF12eCoA90Xt84
	3LJqdF880DyHaLn+fj6CkpKBo;
Received: from [45.95.250.46] (port=36785 helo=[192.168.1.158])
	by box2278.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <devel@roosoft.ltd.uk>)
	id 1sUwSU-002KzJ-1e
	for linux-btrfs@vger.kernel.org;
	Fri, 19 Jul 2024 16:52:14 -0600
Message-ID: <98c97077-b801-46b0-9410-8cc57780a0c0@roosoft.ltd.uk>
Date: Fri, 19 Jul 2024 23:52:12 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: devel@roosoft.ltd.uk
Subject: RE: Unable to mount after successful replace.
Disposition-Notification-To: devel@roosoft.ltd.uk
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
X-Exim-ID: 1sUwSU-002KzJ-1e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.158]) [45.95.250.46]:36785
X-Source-Auth: fpd_eacct+casa-di-locascio.net
X-Email-Count: 1
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: Y2FzYWRpbG87Y2FzYWRpbG87Ym94MjI3OC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPM4iN0R0b6BZgoiYvpqUtIdCA7WilVTLsSnU76SzakzsAvh5xXkQ3oVNuUiXg99UfEG00AlqgziVLAHEP+Z3V3r1kcPXr4TFtcBOnuEX/68hmWV/RgI
 rnscK/9QNPUMwy3Pa0N05JSIbHhcrrxdB6qoiPIQqvfLK/4wQziAvzUx2hRGjnzgM/XeTniolTGMx3Csx2nprQXhHJTrgri5vdU=

Hi,

btrfs-progs v6.3.2

6.5.0-4-amd64


I ran a successful replace upgrading a 12 to 14Tb  disk in a 4 disk 
filesystem

 > Started on 14.Jul 08:36:44, finished on 19.Jul 13:39:31, 0 write 
errs, 0 uncorr. read errs

So I shut the machine down,  physically swapped the disks and rebooted.

But the filesystem now fails to mount even in degraded mode because it 
is missing the replaced device.

```
btrfs fi show
Label: none  uuid: 6abaa68a-2670-4d8b-8d2a-fd7321df9242
     Total devices 4 FS bytes used 23.82TiB
     devid    0 size 10.91TiB used 7.96TiB path /dev/sde
     devid    1 size 10.91TiB used 7.96TiB path /dev/sdb
     devid    2 size 10.91TiB used 7.96TiB path /dev/sdc
     devid    4 size 10.91TiB used 7.96TiB path /dev/sdd

```

```

mount -o degraded /dev/sdb /mnt/ext/
mount: /mnt/ext: mount(2) system call failed: Structure needs cleaning.
        dmesg(1) may have more information after failed mount system call.

```

```

[Fri Jul 19 23:16:28 2024] BTRFS info (device sdb): using crc32c 
(crc32c-generic) checksum algorithm
[Fri Jul 19 23:16:28 2024] BTRFS info (device sdb): allowing degraded mounts
[Fri Jul 19 23:16:28 2024] BTRFS info (device sdb): using free space tree
[Fri Jul 19 23:16:28 2024] BTRFS warning (device sdb): devid 5 uuid 
951ef490-5bfe-412d-b65e-8a6393428431 is missing
[Fri Jul 19 23:16:28 2024] BTRFS info (device sdb): bdev /dev/sde errs: 
wr 60252097, rd 0, flush 0, corrupt 0, gen 0
[Fri Jul 19 23:16:28 2024] BTRFS info (device sdb): bdev <missing disk> 
errs: wr 60254549, rd 25, flush 0, corrupt 0, gen 0
[Fri Jul 19 23:16:28 2024] BTRFS error (device sdb): replace without 
active item, run 'device scan --forget' on the target device
[Fri Jul 19 23:16:28 2024] BTRFS error (device sdb): failed to init 
dev_replace: -117
[Fri Jul 19 23:16:28 2024] BTRFS error (device sdb): open_ctree failed

```
I have tried `btrfs dev scan --forget` to no avail.

How do I remove the offending id when I am unable to mount the filesystem ?

Thanks in  advance.





Don Alexander


