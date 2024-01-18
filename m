Return-Path: <linux-btrfs+bounces-1551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2302683159E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 10:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5BF1C22971
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E61CFB7;
	Thu, 18 Jan 2024 09:19:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A91BE7F
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569594; cv=none; b=qdgEZvMQpDlxU/JTiQIw5SLsEcTTlh+hfjzW38tdoqDrVqS1im4jrncMQOtIvnA0m4mYavabLyWDCZFwwCUn5Y7UvG6cXw9b5OnACUaFPbASe/VhsLjLQKXXkyopsYXKfrwMYExZSJ1ue5dkM+zmFoQlH3IcQ9pidzcO4Ndv0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569594; c=relaxed/simple;
	bh=GMlDN52ryi+vOXYhwJLyF/W3DvectY0GSoelWcuL/tw=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=DlR9V3NClXrdtzusyv1ef35wS0LrRJhjfZoxI8tNMpITnLGBP0sopND/XluXfIRwbIaO8xiROy7ZC+4UOXC57JoQHGPCDv8Uc/t1xhYIW2+b0PqMsStz6f6MhABZXDjRajHSRAaTJsM5F/RYUNuBYnbdk35sZ0w3s/ha0UQcyPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
	by shin.romanrm.net (Postfix) with SMTP id C30EB3F6FE;
	Thu, 18 Jan 2024 09:12:31 +0000 (UTC)
Date: Thu, 18 Jan 2024 14:12:31 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, wangyugui@e16-tech.com
Subject: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev
 striped FS
Message-ID: <20240118141231.5166cdd7@nvm>
In-Reply-To: <cover.1705568050.git.naohiro.aota@wdc.com>
References: <cover.1705568050.git.naohiro.aota@wdc.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 17:54:49 +0900
Naohiro Aota <naohiro.aota@wdc.com> wrote:

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

Personal opinion, it is a very awkward criteria to enable or disable the
inline mode. There can be a RAID0 of SATA HDDs/SSDs that will be slower than a
single PCI-E 4.0 NVMe SSD. In [1] the inline mode slashes the performance from
4 GB/sec to 1.5 GB/sec. A single modern SSD is capable of up to 6 GB/sec.

Secondly, less often, there can be a hardware RAID which presents itself to the
OS as a single device, but is also very fast.

Sure, basing such decision on anything else, such as benchmark of the
actual block device may not be as feasible.

> So, this series first introduces fs_devices->inline_csum_mode and its
> sysfs interface to tweak the inline csum behavior (auto/on/off). Then,
> it disables inline checksum when it find a block group striped writing
> into multiple devices.

Has it been determined what improvement enabling the inline mode brings at all,
and in which setups? Maybe just disable it by default and provide this tweak
option?

> Naohiro Aota (2):
>   btrfs: introduce inline_csum_mode to tweak inline checksum behavior
>   btrfs: detect multi-dev stripe and disable automatic inline checksum
> 
>  fs/btrfs/bio.c     | 14 ++++++++++++--
>  fs/btrfs/sysfs.c   | 39 +++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.c | 20 ++++++++++++++++++++
>  fs/btrfs/volumes.h | 21 +++++++++++++++++++++
>  4 files changed, 92 insertions(+), 2 deletions(-)
> 


-- 
With respect,
Roman

