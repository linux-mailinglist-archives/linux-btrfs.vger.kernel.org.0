Return-Path: <linux-btrfs+bounces-17996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD50BECFF7
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853485E82D7
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519D62773F9;
	Sat, 18 Oct 2025 13:02:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-61.mail.aliyun.com (out28-61.mail.aliyun.com [115.124.28.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D11F4161
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760792534; cv=none; b=ndKNISpBmB5QCN/zuUXH77oRp2HzNp+VbCfVm5wb6r2iLw5Hj8rXkIQsmsQ71Bjld84AIF+jMvw3YTeeXbyJI3MAn+ArcN2k4J4YKALjbVfg9DrobOsJBFZFRT0P4tJXY+s/CRjM2wUa+STmN8iP3Opp+CpyAYmcVKm1YXurH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760792534; c=relaxed/simple;
	bh=94jxZmCuOjI5UtoYFpPoVIpPrk0p8F9WSPt/v+oWFcY=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=uUlNGkZhFwk/GWp3109oKWOcuhULPzdYol5sJb+kQbo/dA1gYnOgTd61eog2YgcxdSJo4ICyAtYjsY6bjuKkztxNlvWGjRX1bKIfO1WmwgPFz5+POEqwM627lyODIT14fqugNrZg5fWqN8O76uJ9s8omoS4yUGYID1NMs2paeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.f1jC60j_1760792517 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 18 Oct 2025 21:01:58 +0800
Date: Sat, 18 Oct 2025 21:01:58 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-btrfs@vger.kernel.org
Subject: Re: btrfs error(dev extent physical offset is beyond device boundary) when mount
In-Reply-To: <20251018064727.9E9B.409509F4@e16-tech.com>
References: <20251018064727.9E9B.409509F4@e16-tech.com>
Message-Id: <20251018210157.268D.409509F4@e16-tech.com>
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

although the following fix will make code more easy to read, 
but it is not a real BUG.
# no result change in 'rounddown(avail_space, BTRFS_STRIPE_LEN);'

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 91b19d6..c8c6a3d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2273,6 +2273,8 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 			break;
 
 		avail_space = device->total_bytes - device->bytes_used;
+		ASSERT(avail_space >= BTRFS_DEVICE_RANGE_RESERVED);
+		avail_space -= BTRFS_DEVICE_RANGE_RESERVED;
 
 		/* align with stripe_len */
 		avail_space = rounddown(avail_space, BTRFS_STRIPE_LEN);
@@ -2281,11 +2283,9 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
 		 * Ensure we have at least min_stripe_size on top of the
 		 * reserved space on the device.
 		 */
-		if (avail_space <= BTRFS_DEVICE_RANGE_RESERVED + min_stripe_size)
+		if (avail_space <= min_stripe_size)
 			continue;
 
-		avail_space -= BTRFS_DEVICE_RANGE_RESERVED;
-
 		devices_info[i].dev = device;
 		devices_info[i].max_avail = avail_space;


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/10/18


