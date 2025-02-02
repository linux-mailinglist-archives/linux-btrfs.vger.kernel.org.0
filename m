Return-Path: <linux-btrfs+bounces-11211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E60A25062
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2025 23:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E10163979
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2025 22:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20AB2147FA;
	Sun,  2 Feb 2025 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddall.name header.i=@siddall.name header.b="Ds0M7X5y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from pmg-pub-smtp1.teksavvy.com (pmg-pub-smtp1.teksavvy.com [76.10.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80BD1F55EB
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Feb 2025 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738536241; cv=none; b=aSrVYlwC47AjWm0hUvE2hV6qy91M2TRhvXN4HsVqihmtcdnEgdQHBfQH6b1gwB4KbSMjWx0IcC1uUqnyc/aVa1USwPra3Uh2NL0dbYnAvv1VWHAjXlnLm3CsbkIKFI6pqcuKVc15/wtUV0vmyGmeTfpeA8ONyD4gGnfWyEoi28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738536241; c=relaxed/simple;
	bh=YI0Djed2bZ0PsFINZf143f+fuXGT7nh+wiCCHRQwRSQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BihwyqYvWgKArmmqyykmk95RmfzTMeujjP1hduB7WEoE/J07d2e85yr4z1iJcKr28n3nNKeh6ahVr3/bg75SE/W0sezsKN977DYJVsU2+M/IDHSRE/TwRXv3yncoR7Vrjjg4fDlfV94m1gtPtraoOUKmPadRsCSTn7apzGRfSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siddall.name; spf=pass smtp.mailfrom=siddall.name; dkim=pass (1024-bit key) header.d=siddall.name header.i=@siddall.name header.b=Ds0M7X5y; arc=none smtp.client-ip=76.10.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siddall.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siddall.name
Received: from pmg-pub-smtp1.teksavvy.com (localhost.localdomain [127.0.0.1])
	by pmg-pub-smtp1.teksavvy.com (Proxmox) with ESMTP id 9BE8434C15CB
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Feb 2025 17:43:57 -0500 (EST)
Received: from siddall.name (206-248-137-23.dsl.teksavvy.com [206.248.137.23])
	by pmg-pub-smtp1.teksavvy.com (Proxmox) with ESMTP id 0963F34C1413
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Feb 2025 17:43:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 siddall.name CE0137200B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siddall.name;
	s=siddall; t=1738536236;
	bh=dbq2+Ly8CDh88PkNEVGKqXfZDug5Zl7cjQ6BAJ4ZuIg=;
	h=Date:To:From:Subject:From;
	b=Ds0M7X5y6kMPqfG/NoJTIdMy/5gxdodsobhagXWPDwcsf6xhfBHiZ2VSdiCAfOALy
	 qr9GF29kg8Zj2OA+rrjRHBfNHttjuhyRekxZNbbHilYupX51pz96hmA7hshhhMM2tN
	 zMF8+wrvJ+ZUXy/uNX53dq7XkvfEg2AQlh5hTvs0=
Received: from [192.168.0.2] (siddall-2.internal.siddall.name [192.168.0.2])
	by siddall.name (Postfix) with ESMTPS id CE0137200B2
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Feb 2025 17:43:56 -0500 (EST)
Message-ID: <2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name>
Date: Sun, 2 Feb 2025 17:43:56 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: en-US
From: Jeff Siddall <news@siddall.name>
Subject: Converting RAID1 to single fails if RAID1 is missing device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

After a device failed on RAID1 filesystem, an attempt to convert the 
online filesystem from RAID1 to single failed.  This isn't an uncommon 
use case if the failed device isn't readily replaceable.

The command ran was:

btrfs balance start -f -sconvert=single -mconvert=single 
-dconvert=single /mountpoint

and the kernel logs were:

kernel: BTRFS info (device nvme0n1p3): balance: start -dconvert=single 
-mconvert=dup -sconvert=dup
kernel: BTRFS info (device nvme0n1p3): relocating block group 
1222049267712 flags data|raid1
kernel: BTRFS warning (device nvme0n1p3): chunk 1223123009536 missing 1 
devices, max tolerance is 0 for writable mount
kernel: BTRFS: error (device nvme0n1p3) in write_all_supers:4370: 
errno=-5 IO failure (errors while submitting device barriers.)
kernel: BTRFS info (device nvme0n1p3: state E): forced readonly
kernel: BTRFS warning (device nvme0n1p3: state E): Skipping commit of 
aborted transaction.
kernel: BTRFS: error (device nvme0n1p3: state EA) in 
cleanup_transaction:1992: errno=-5 IO failure
kernel: BTRFS info (device nvme0n1p3: state EA): balance: ended with 
status: -5

Either it should be made possible to convert a RAID1 device with a 
missing device to a single device filesystem without errors, or the 
command should return a message stating that it is not supported to 
convert RAID1 array with missing devices to a single.  Having the 
process fail and then going forced readonly is a significant failure on 
an otherwise working system.



