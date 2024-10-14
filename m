Return-Path: <linux-btrfs+bounces-8894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A9199CB87
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 15:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62FF1C2192A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CAD1A76C4;
	Mon, 14 Oct 2024 13:24:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BCA4A3E
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912271; cv=none; b=NJQp6cL20hEibZbsRVfw6Q/71cHSWdk3DIX4mbUG0HLJajqqWqYgdqfOMQ+R1AGhTm08rPezq8xteGrolwIZ1ktt3F2hrZVmslDLuvCbSIxF5dLrrrsVJiuOhlNmzY5w2mmyFF+GjR3bXNciV0IOb4RkrKeZHdC/FrcRrG/PGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912271; c=relaxed/simple;
	bh=9Ng8Jq9rGR+RFoCxnMFc2uSz0O4dfOH57nNd31kspek=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=TOUWWgnJ+N8kOkF7tV71aYlcb0HT/MSXwnpmDrgsITntcFtZMj+9d9nLlAfH2hzxyDwZXvoqgmkNYC3Rv6IJuBYEY+iMIewcntl+1PdqDYOtBMGNe5Tw0YJb2aMjJywFG5by9riQvtR8omp8W41Nn3Zf2vqrLJkr9eoLGm/IVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.39.romanrm.net [IPv6:fd39:a9b3:4fb1:1ccb:7900:fcd:12a3:6181])
	by shin.romanrm.net (Postfix) with SMTP id 327613F139
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 13:24:17 +0000 (UTC)
Date: Mon, 14 Oct 2024 18:24:16 +0500
From: Roman Mamedov <rm@romanrm.net>
To: linux-btrfs@vger.kernel.org
Subject: Issue remounting from compress-force to compress
Message-ID: <20241014182416.13d0f8b0@nvm>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

Just faced this when trying to change a mounted FS from compress-force to just compress.

Initial state:

  # mount | grep btrfs
  /dev/mapper/wd-p1 on /mnt/p1 type btrfs (rw,relatime,compress-force=zstd:9,discard=async,space_cache=v2,subvolid=5,subvol=/)

Remounting:

  # mount /mnt/p1 -o remount,compress=zstd:9

But no effect:

  # mount | grep btrfs
  /dev/mapper/wd-p1 on /mnt/p1 type btrfs (rw,relatime,compress-force=zstd:9,discard=async,space_cache=v2,subvolid=5,subvol=/)

OK, remounting to no compression:

  # mount /mnt/p1 -o remount,compress-force=none

Success:

  # mount | grep btrfs
  /dev/mapper/wd-p1 on /mnt/p1 type btrfs (rw,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/)

Now, I expect to enable just compress:

  # mount /mnt/p1 -o remount,compress=zstd:9

But suddenly, compress-force is enabled again instead:

  # mount | grep btrfs
  /dev/mapper/wd-p1 on /mnt/p1 type btrfs (rw,relatime,compress-force=zstd:9,discard=async,space_cache=v2,subvolid=5,subvol=/)

This is unexpected and seems like a bug.

The only way to achieve what I wanted was:

  # mount /mnt/p1 -o remount,compress-force=none,compress=zstd:9
  
  # mount | grep btrfs
  /dev/mapper/wd-p1 on /mnt/p1 type btrfs (rw,relatime,compress=zstd:9,discard=async,space_cache=v2,subvolid=5,subvol=/)

Kernel version is 6.8.12-2-pve (Proxmox).

-- 
With respect,
Roman

