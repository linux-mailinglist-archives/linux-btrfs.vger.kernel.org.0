Return-Path: <linux-btrfs+bounces-18010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D438BEE3C3
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 13:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F64D4E35B8
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314662E5B27;
	Sun, 19 Oct 2025 11:37:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-61.mail.aliyun.com (out28-61.mail.aliyun.com [115.124.28.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293A165F16
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760873868; cv=none; b=XKfKpS1AiJT6hCu4N+FUg894M/MJlpPGn/aUmaprqEkF/6QNUR5Bqn5UTjcIP9tQnpe/llCaTXRpOFTax4cZK4Unb16l2GvrZ+UIonm08SwhjTGDUzSVWUKo1/Ri3Babzsh47km/YKhF1ktXQFhcLhOxZp4xVGtPMeOTR9Dz+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760873868; c=relaxed/simple;
	bh=x7koAtJV30dYGzzicZRxuddUUUfidGtVS/3RyCLDOBU=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=UHHuezXE1BeTIKGrHTdTks6xppthGz40cKAsOux49fcAbclNSYM5lp4tFmbeZsdM8dvqjcS6JzBrsM/Rru5S0SXKxIwatNVu89XLNxQZl8Ayf9g32iGxRoJ77rPLDptaYKH8ewJMZetwSArkHx5lpsunMHlItJggi9pEY57X+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.f2INpgT_1760873859 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 19 Oct 2025 19:37:40 +0800
Date: Sun, 19 Oct 2025 19:37:41 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-btrfs@vger.kernel.org
Subject: Re: btrfs error(dev extent physical offset is beyond device boundary) when mount
In-Reply-To: <20251018064727.9E9B.409509F4@e16-tech.com>
References: <20251018064727.9E9B.409509F4@e16-tech.com>
Message-Id: <20251019193740.1C00.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.82 [en]

Hi,


> Hi,
> 
> btrfs error(dev extent physical offset is beyond device boundary)  happened on 
> a brtfs file system with 3 disks when mount.
> 
> dmesg:
> dev extent devid 3 physical offset 719991138680832 len 1073741824 is beyond device boundary 719992211374080
> 
> 719991138680832+1073741824(1G)-719992211374080=1048576(1M)
> 719992211374080=670545 * 1024**3 = 670545 G 
>     This is a hardware RAID device, so the size of this disk is just SZ_1G * 670545£¬
>      not like physical disk with the size of SZ_1G * N + some small value
> 
> and this btrfs are running on  kernel version is 5.15.y and then 6.1.y.
> 
> Any advice about why this chunk was alloced beyond device boundary£¿
> - Is it BTRFS_DEVICE_RANGE_RESERVED(1M) related?
> - Is it multiple disks related?

this seems a realated bug-fix. but not sure whether it fix the root cause.

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2bec544d8ba3..a8c2389012af 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5268,8 +5268,8 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
 			continue;
 
-		if (device->total_bytes > device->bytes_used)
-			total_avail = device->total_bytes - device->bytes_used;
+		if (device->total_bytes > device->bytes_used + BTRFS_DEVICE_RANGE_RESERVED)
+			total_avail = device->total_bytes - device->bytes_used - BTRFS_DEVICE_RANGE_RESERVED;
 		else
 			total_avail = 0;


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/10/19



