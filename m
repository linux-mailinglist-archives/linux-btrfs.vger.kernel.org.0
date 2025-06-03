Return-Path: <linux-btrfs+bounces-14425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B12DACCDD8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 21:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CB03A41ED
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 19:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2422129E;
	Tue,  3 Jun 2025 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="kptRMRfN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BAF21C190
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748980600; cv=none; b=ecdjdvSz1VRYSMXURvoHxO3gX3w86CrEd61DHIY3IfYo4xW6foi8Dsvvs5LDXTpIIN8+h6ONkj4gx/sKeLY/TnhpvGPIQG49hs0DvU8SO1QDDVjm3iY9xkxAYPtEZgHEfnTnBlR3lttLFrYpbx0MyD9lIzXdgD6eTNgTIO4P0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748980600; c=relaxed/simple;
	bh=NLa4XLwbKYjK+ZSJuW6jjgsd8nbBmXekpIQabzy+ZOs=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=CJY4OYTIIAO9RiJgX7Hcth7IzcQSwjX9BhmysGCy6hgEYC8nOBY9UtzsquQriia9g7lE5Cw6Me4Ohq1kTIWAIdOjIPnIVFVJ+WAZSqSovmn+gSjvlzuCgkaOJjCTvdbPouBInhhTLSBtXD1dEiHR9Wyfor/cJd8z5euk6u3dQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=kptRMRfN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1748980584; x=1749585384; i=jimis@gmx.net;
	bh=5MuNdY3Ws4AiD3I0Y+VAY4Hz9YeFysXiW/0knZ8AvC0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kptRMRfNkJIcAxNgJuX2nSiJ9mHvOHUUSQ+wHpBMvS0FRM2KCPwZcz1JIMKwm/wH
	 qs1hHObBviZi8ETlefnUO5TBbvCeS6CJJg6EfYcdcpNcmoDjigdkk3au+Bhoaa6wp
	 XBpM44OvIoqnjF0eEXphbr3XN6zPLGr+Bnq/2R13NK0X/KzDERkCydKi6nJM4tvcR
	 D0xADhlE5puaITolEj5Bu+gaJ0XO2RjoTPtGDtKAJzMLlRBRrHFmCh3HotsGCpYBk
	 IuCnv9Z20R6AMCoRHcBzAPygxcMnN5nqJ9coZogY8ogLkGexJL4CYlrjgHeyQwD34
	 rRXVoGGyZjg5ClM1tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zFj-1uzOmZ1DRz-012ZQz; Tue, 03
 Jun 2025 21:56:24 +0200
Date: Tue, 3 Jun 2025 21:56:22 +0200 (CEST)
From: Dimitrios Apostolou <jimis@gmx.net>
To: linux-btrfs@vger.kernel.org
cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Christoph Hellwig <hch@infradead.org>, 
    Anand Jain <anand.jain@oracle.com>
Subject: Sequential read(8K) from compressed files are very slow
Message-ID: <34601559-6c16-6ccc-1793-20a97ca0dbba@gmx.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Provags-ID: V03:K1:HGl5fCDkwqVZONMEqKEpBu6JvkpRQJraGnnOZfc4XbuO0oxA4mR
 RMW0bRT+5J1SOBu1whxAMmBcFlARU3Ht0lolCYvjBquanEvk/ZrxQkS+opWNHu46M6pgYxL
 4bd0qaj+hX0z0Psuef+IBvcpQg7o2kFjaUtU30ZgifVhAMzfJexzw2r64Fl4TyVxQHPmYah
 91YNCZZcykKi3MH5qAGTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pAwCyOUoIPM=;hmjd/KhjLJtxFiNnW6tk/0MP132
 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
 nb5M=
Content-Transfer-Encoding: quoted-printable

Hello list,

I notice consistently that sequential reads from compressed files are slow=
=20
when the block size is small.

It's extremely easy to reproduce, but the problem is I can't find the=20
bottleneck. I suspect it is an issue of Btrfs, not doing read-ahead like=
=20
it does with non-compressed files.

Can you reproduce it? I'd also appreciate instructions for further=20
debugging it. Or tweaking my system to improve the case.

I'm CC'ing people from previous related discussion at
https://www.spinics.net/lists/linux-btrfs/msg137840.html


** How to reproduce:

Filesystem is newly created with btrfs-progs v6.6.3, on NVMe drive with=20
1.5TB of space, mounted with compress=3Dzstd:3. Kernel version is 6.11.


1. create 10GB compressible and incompressible files

head -c 10G /dev/zero          > highly-compressible
head -c 10G <(od /dev/urandom) > compressible
head -c 10G /dev/urandom       > incompressible


2. Verify they are indeed what promised

$ sudo compsize highly-compressible
Processed 1 file, 81920 regular extents (81920 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL        3%      320M          10G          10G
$ sudo compsize compressible
Processed 1 file, 81965 regular extents (81965 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       43%      4.3G          10G          10G
zstd        43%      4.3G          10G          10G
$ sudo compsize incompressible
Processed 1 file, 80 regular extents (80 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       10G          10G          10G
none       100%       10G          10G          10G


3. Measure read() speed with 8KB block size

$ sync
$ echo 1 | sudo tee /proc/sys/vm/drop_caches

$ dd if=3Dhighly-compressible   of=3D/dev/null bs=3D8k
1310720+0 records in
1310720+0 records out
10737418240 bytes (11 GB, 10 GiB) copied, 12.9102 s, 832 MB/s

$ dd if=3Dcompressible   of=3D/dev/null bs=3D8k
1310720+0 records in
1310720+0 records out
10737418240 bytes (11 GB, 10 GiB) copied, 30.68 s, 350 MB/s

$ dd if=3Dincompressible   of=3D/dev/null bs=3D8k
1310720+0 records in
1310720+0 records out
10737418240 bytes (11 GB, 10 GiB) copied, 3.85749 s, 2.8 GB/s


The above results are repeatable. The device can give several GB/s like in=
=20
the last case, so I would expect such high numbers or up to what the CPU=
=20
can decompress. But CPU cores utilisation is low, so I have excluded that=
=20
from being the bottleneck.


What do you think?
Dimitris


