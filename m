Return-Path: <linux-btrfs+bounces-14289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10091AC75A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 04:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560AA9E46DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 02:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49111242D67;
	Thu, 29 May 2025 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="kfdM5tPt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out1.mxs.au (h1.out1.mxs.au [110.232.143.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E554241C89
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484530; cv=none; b=U9hi76VXAXqwb8YHEVhkP7kmQLHGQnwn0mjpjL9mIX+oZ3PPstgVNNYE3d0DCahRLu6msZTfQAHK6JZpY6IvMKj9bjXdHTibYFuSbCQa7TXtp15RBKXfMwSPtXam9JC1/LOAO0XNFSlyS1yk4az6U/HzMcnwoQnJ+TOeK3AzEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484530; c=relaxed/simple;
	bh=bOu6CYIKRE1VAh9KNr8R2dNtd/Jp9dIDnVC7EqAfV3g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DJzgZfqt8Vetqoiaz/Gy6dtumwyXvcED94KTVjEPa9Wfy7r2IMVxQmf0Sh6J2RALlSkucFwtmBhDVr4XdJsNze4qJbT1znS4XNTOKqpLge+UGY0ZahcXmacMeaOwF+jY/wlz1n8rgQodiP7ZEUm78pDHEu6N1xGjiuvCJ+L8yDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=kfdM5tPt; arc=none smtp.client-ip=110.232.143.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out1.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 9b43ce3f-3c31-11f0-ad0b-00163c39b365
	for <linux-btrfs@vger.kernel.org>;
	Thu, 29 May 2025 12:07:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:
	From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XslA0nqgPVqBUTns5ds97uW13C4P9730/N69fsEuX+M=; b=kfdM5tPtjctyFMqmgkfJPveD5s
	T4PS748JlBeccmxKuycGTgRbNxvrRKoRLHVJpl7JRCdHZhFC5KPaHFP6k8wT9KYSruMRwlhofTLnY
	6asHE2l00K9rfY3YpVkgG4T3K7yfv4fl8e6Br6WsdVflt8kTBipQ+4KdF9uuPlgtgyN0UjuOKS9bk
	jTmIHQkjK2t/mSCTpgI+tLzLasU9Knci6l/HRkZUUh0NOoaXNP1yGMG3S5FBCIddloUmI+ZEPi6a6
	s3kHWaR4NyiE9woE2UFxkeHZlkktvNUXI9B2oFmOHiCk/hx8ace8nswjcjafnDkIOVgdwtHt2u0PJ
	cXkSun1Q==;
Received: from [159.196.20.165] (port=32211 helo=[192.168.2.80])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <btrfs@edcint.co.nz>)
	id 1uKSgA-00000001cxk-21PA
	for linux-btrfs@vger.kernel.org;
	Thu, 29 May 2025 12:07:34 +1000
Message-ID: <83a43be7-7058-4099-80d9-07749cf77a8d@edcint.co.nz>
Date: Thu, 29 May 2025 12:07:34 +1000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Matthew Jurgens <btrfs@edcint.co.nz>
Subject: Portable HDD Keeps Going Read Only
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

I have a portable HDD that I just use for backups (so I can lose the 
data on this drive if I need to).

It keeps going read only. Sometimes at mount time and other times after 
a small amount of usage.

The dmesg and btrfs check output is large so I have made them available 
at this link https://www.edcint.co.nz/tmp/btrfs_portable_hdd/ (I tried 
to attach them to the email but it seems it never got delivered to the 
mailing list).

Steps:

1. connect drive via USB. The system tries to automatically mount it. 
The drive mounts as read only. The result of this is in dmesg1.txt

2. umount the drive. Run a btrfs check. This results of this check are 
in btrfs_check1.txt

3. mount drive manually. Drive appears to mount ok. Run a find over the 
drive. It starts listing lots of file. Cancel the find. Start a scrub. 
The scrub aborts within a few seconds. The result of this a in dmesg2.txt

This is now the 2nd portable drive that I have that has had a problem 
with data on the BTRFS file system in about a month. I just recreated 
the file system on the other drive. But this time, I'd like to see if 
anyone can help with finding out what is going wrong.

uname -a
Linux host 6.14.6-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri May 9 
20:11:19 UTC 2025 x86_64 GNU/Linux

btrfs --version
btrfs-progs v6.14
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED 
CRYPTO=libgcrypt

btrfs fi show
Label: 'PHDD_WD5TB'  uuid: 83f64b18-a2e8-443b-bfa8-78ff90dc86de
         Total devices 1 FS bytes used 3.67TiB
         devid    1 size 4.55TiB used 3.69TiB path /dev/sdb


