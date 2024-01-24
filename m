Return-Path: <linux-btrfs+bounces-1666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7E2839DAB
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 01:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BE028B994
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 00:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837F1110B;
	Wed, 24 Jan 2024 00:35:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-86.mail.aliyun.com (out28-86.mail.aliyun.com [115.124.28.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB010E3
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706056514; cv=none; b=ctOIlAz7ryRK7Mzo2c6lZKIyZGkXSaePM8/6cYNYh4iDq0xxPR2VL+Bq7DIsDQUvTM/4TCj2cSsiFTpPtVSdxu/OAu/errewG/R7xM4MMlWJW2wAtqgcxEDFjqSp1W4mFvjra2lK91wmXsSEOBk0i8GU98gC+MtjJjhGaGw9ojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706056514; c=relaxed/simple;
	bh=Vi6VImysOkiaMhfKEC3LdSmLIVGOPrh3PlDyUDPWD0s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=iJtSfAcSqH2NzJIdbuh+CLP5g9cNhn2N+OQOi+SuXaSqyZVdtpy2S7k4mlEzzWiva5dy+s3czAoq+1kYkAT0mAWELfgQ+FbKfwocst5Z6LmuNrl3pZD9QXk3izmwcTWllyFPCjIT/jtPQNjddzh9lmP0tbeASUWLA+Sq+9ZmD9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3290177|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.035754-0.00378335-0.960463;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.WDbChXF_1706055571;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.WDbChXF_1706055571)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 08:19:32 +0800
Date: Wed, 24 Jan 2024 08:19:32 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev striped FS
Cc: linux-btrfs@vger.kernel.org
In-Reply-To: <cover.1705568050.git.naohiro.aota@wdc.com>
References: <cover.1705568050.git.naohiro.aota@wdc.com>
Message-Id: <20240124081931.1DDE.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.05 [en]

Hi,

> There was a report of write performance regression on 6.5-rc4 on RAID0
> (4 devices) btrfs [1]. Then, I reported that BTRFS_FS_CSUM_IMPL_FAST
> and doing the checksum inline can be bad for performance on RAID0
> setup [2]. 
> 
> [1] https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
> [2] https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> 
> While inlining the fast checksum is good for single (or two) device,
> but it is not fast enough for multi-device striped writing.
> 
> So, this series first introduces fs_devices->inline_csum_mode and its
> sysfs interface to tweak the inline csum behavior (auto/on/off). Then,
> it disables inline checksum when it find a block group striped writing
> into multiple devices.

We have struct btrfs_inode | sync_writers in kernel 6.1.y, but dropped in recent
kernel. 

Is btrfs_inode | sync_writers not implemented very well?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/01/24



