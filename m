Return-Path: <linux-btrfs+bounces-14964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCB0AE92A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 01:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381DB165C2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AEA202C46;
	Wed, 25 Jun 2025 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="h0ZA4aR8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out4.mxs.au (h1.out4.mxs.au [110.232.143.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5902F431D
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893686; cv=none; b=PrjpUUjZH8vwqNCr00pvrnbQXIU0owd/FKafcIe7eOTDDjlEWWkukc8lIJKhxhFhw9Gxvyy+UM+6D+i1OfHdT9Vw+lP0BXKo7HXwUuiys+DRZGTWMScCMQJPGE0i9nqhb6zLDyQ4mhNv6SBWvJnvI5TcoB5hRaCcJe3gXJtEr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893686; c=relaxed/simple;
	bh=l6gdjSsI1lcWWZhcDIAU8bL+EfcU0PB7fITZHJtO4Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FM1REcsT0MX+u3YO2OerHEa2hHuDhKWH2LUPcksalZz3/D8elcOGBIJo7q6U2PvyWEfrzD0Voqz1Oj9yD7DnOutQseB3TiFxgMXzgz0B6JGUZkBdtAPZqLEW+7o0i6pWZ/umCFnw/MoxHTvwuMYL05APOKif0Ee6qPNXl3lIIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=h0ZA4aR8; arc=none smtp.client-ip=110.232.143.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out4.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id eeb0a731-521a-11f0-8a1a-00163c87da3f
	for <linux-btrfs@vger.kernel.org>;
	Thu, 26 Jun 2025 09:20:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p/oneADWuVh9vHgobC/+U1JzGh9gN+eDZUrdKGWcYE4=; b=h0ZA4aR8SRgQHDgh0I6P4cfS2z
	8s7MNiSveDBZukXwTFr8EZ0hh1QTOSnoJ4AuthDvwAYQaa2ocDjpSG1GrvbXPDj3MhHgFvHMbcUDo
	k2dSENiHC1GyxeZbfKjrKwV/8xG2LtkoXVfv8dVc1OTe+EQ+ZbpcHY+9LE6m8V8KaRYgksDRrBcaI
	EdHlPyvkJbXnU8y3GE4jGU7NllFMzfcBedZGPWTkUGMeRwVWB7yYVjlJNin5ZRXKZalJ5+rh0rzRX
	EHrj5EHuUPbce5Cd+MmL/4BUpeNf1xrXrv7mFAa56w4S3mQw/cjUbL/VMa2WLWMDHp0a9S+CZHMSC
	9xJiNgAw==;
Received: from [159.196.20.165] (port=43543 helo=[192.168.2.80])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <btrfs@edcint.co.nz>)
	id 1uUZPT-000000018t2-1x0W;
	Thu, 26 Jun 2025 09:20:07 +1000
Message-ID: <a1494d1c-7f6f-4bc8-9f42-553e79e4335e@edcint.co.nz>
Date: Thu, 26 Jun 2025 09:20:07 +1000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Portable HDD Keeps Going Read Only
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <83a43be7-7058-4099-80d9-07749cf77a8d@edcint.co.nz>
 <CAPjX3FcqJ-cNMjVia_gYmBZwDhQVxPEOhYYQUzL31m7momByEQ@mail.gmail.com>
 <5de3840d-70c5-48cb-a7c0-7db17e789e95@edcint.co.nz>
 <ffbd0c96-313d-4524-9b6e-b24437fc0347@gmx.com>
 <b2dbfdb5-4cce-459c-8d30-01ac6124d9ad@edcint.co.nz>
 <bdfe67ea-8668-4768-8102-42d78e9537f9@edcint.co.nz>
 <08d37392-a7a5-4c43-87ce-86146e58323f@gmx.com>
Content-Language: en-US
From: Matthew Jurgens <btrfs@edcint.co.nz>
In-Reply-To: <08d37392-a7a5-4c43-87ce-86146e58323f@gmx.com>
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

Further to this.

I reformatted the drive, rewrote a backup to it and umounted it 
(software only, did not physically disconnect it). When I tried to 
remount it about 30 minutes later, it failed.

3 new files (dmesg, btrfs check and smartctl output) for 20250626 are 
available at https://edcint.co.nz/tmp/btrfs_portable_hdd/

I'll paste the check output below but adding the others will make this 
message too long

In another test I did, I reformatted the drive with xfs, but when 
writing the backup to it, the rsync hung. I reproduced this 2 or 3 times 
and gave up. Soon, I'll try ext4 on this drive.

Maybe the controller on this drive has a problem. The smartctl output 
does not show any clear signs of problems.

[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
ERROR: extent[32702464 16384] backref lost (owner: 1, level: 0) root 1
ERROR: extent [603471872 16384] referencer bytenr mismatch, wanted: 
603471872, have: 32505856
ERROR: extent [876150784 16384] referencer bytenr mismatch, wanted: 
876150784, have: 32686080
ERROR: extent [565322235904 16384] referencer bytenr mismatch, wanted: 
565322235904, have: 32636928
ERROR: extent [1577378103296 16384] referencer bytenr mismatch, wanted: 
1577378103296, have: 32620544
ERROR: extent [1577378168832 16384] referencer bytenr mismatch, wanted: 
1577378168832, have: 32538624
ERROR: extent [1577493069824 16384] referencer bytenr mismatch, wanted: 
1577493069824, have: 32587776
ERROR: extent [2602211950592 16384] referencer bytenr mismatch, wanted: 
2602211950592, have: 32686080
ERROR: extent [2602616307712 16384] referencer bytenr mismatch, wanted: 
2602616307712, have: 32686080
ERROR: extent [3426921840640 16384] referencer bytenr mismatch, wanted: 
3426921840640, have: 32571392
ERROR: extent [3426922545152 16384] referencer bytenr mismatch, wanted: 
3426922545152, have: 32571392
ERROR: extent [3426922840064 16384] referencer bytenr mismatch, wanted: 
3426922840064, have: 32653312
ERROR: extent [3426922905600 16384] referencer bytenr mismatch, wanted: 
3426922905600, have: 32669696
ERROR: extent [3426923708416 16384] referencer bytenr mismatch, wanted: 
3426923708416, have: 32686080
ERROR: extent [3426924969984 16384] referencer bytenr mismatch, wanted: 
3426924969984, have: 32686080
ERROR: extent [3427015163904 16384] referencer bytenr mismatch, wanted: 
3427015163904, have: 32587776
ERROR: extent [3427101868032 16384] referencer bytenr mismatch, wanted: 
3427101868032, have: 32686080
ERROR: extent [3427101884416 16384] referencer bytenr mismatch, wanted: 
3427101884416, have: 32686080
ERROR: extent [3427102064640 16384] referencer bytenr mismatch, wanted: 
3427102064640, have: 32686080
ERROR: extent [3427120365568 16384] referencer bytenr mismatch, wanted: 
3427120365568, have: 32473088
ERROR: extent [3427120906240 16384] referencer bytenr mismatch, wanted: 
3427120906240, have: 31506432
ERROR: extent [3427124035584 16384] referencer bytenr mismatch, wanted: 
3427124035584, have: 32522240
ERROR: extent [3427125624832 16384] referencer bytenr mismatch, wanted: 
3427125624832, have: 32686080
ERROR: extent [3427126951936 16384] referencer bytenr mismatch, wanted: 
3427126951936, have: 32686080
ERROR: extent [3427127394304 16384] referencer bytenr mismatch, wanted: 
3427127394304, have: 32686080
ERROR: extent [3427128082432 16384] referencer bytenr mismatch, wanted: 
3427128082432, have: 32686080
ERROR: extent [3427128164352 16384] referencer bytenr mismatch, wanted: 
3427128164352, have: 32702464
ERROR: extent[32473088 16384] backref lost (owner: 4, level: 1) root 4
ERROR: extent[32505856 16384] backref lost (owner: 4, level: 0) root 4
ERROR: extent[32522240 16384] backref lost (owner: 10, level: 1) root 10
ERROR: extent[31506432 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32571392 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32538624 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32587776 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32620544 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32636928 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32653312 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32669696 16384] backref lost (owner: 10, level: 0) root 10
ERROR: extent[32686080 16384] backref lost (owner: 10, level: 0) root 10
ERROR: errors found in extent allocation tree or chunk allocation
[4/8] checking free space tree
could not load free space tree: No such file or directory
************ SAME LINE REPEATED 1914 OTHER TIMES *************
could not load free space tree: No such file or directory
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs done with fs roots in lowmem mode, skipping
[8/8] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/sdh
UUID: 8746a931-ff21-4a57-8bd5-4793e436629f
found 3889350197248 bytes used, error(s) found
total csum bytes: 3793435968
total tree bytes: 4871340032
total fs tree bytes: 751026176
total extent tree bytes: 155582464
btree space waste bytes: 249038677
file data blocks allocated: 3884478431232
  referenced 3928014991360


