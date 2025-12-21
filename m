Return-Path: <linux-btrfs+bounces-19945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA03CD40F8
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 15:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CADB8300528A
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF2A208994;
	Sun, 21 Dec 2025 14:04:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-42.mail.aliyun.com (out28-42.mail.aliyun.com [115.124.28.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB117A2EA
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766325888; cv=none; b=ej/tgILbFIzEoih0khUYAH9P1Mwygc/LsUJGJVDoW04yUM7jPERGG0Grla5T7fNzAZHVIhTPQPdKjsx2PpKKvmZK4ybdrEs4ETFo1BY5yliHpgHVIs4hXJcYJeQKmPlPxyvYToRfxt5PVgKwpjMBitzwkUV1uGVuZXEDbvXHNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766325888; c=relaxed/simple;
	bh=eFL5UqS0rbd+Rlwf7b7A2Wy+Yr5P+uKyoSr2esK72QY=;
	h=Date:From:To:Subject:Message-Id:MIME-Version:Content-Type; b=SPUuTEfANr8RCGJFQlZSxMHZXQdHtIndG8jU0vPOmGCqTfL9W8GXxPq+2kvtLZwE3dHjoL0afLHkUeadzQ4vuFpMKNQxjqhpjP45FmgTOOs2QKb9wEysON0d5oZ46VnCb7ZDw4vhAE/dZJ8wQ8LUTEog8JQiJ3f17Tfrkbb4afE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.fphPZcM_1766325551 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 21 Dec 2025 21:59:12 +0800
Date: Sun, 21 Dec 2025 21:59:14 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-btrfs@vger.kernel.org
Subject: FOP_DONTCACHE when btrfs Direct IO fallback to buffered IO
Message-Id: <20251221215913.E7B2.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.82.01 [en]

Hi,

Could we add FOP_DONTCACHE support when btrfs Direct IO fallback to buffered IO?

I noticed similar logic in zfs-2.4.0 too.

https://github.com/openzfs/zfs/releases/tag/zfs-2.4.0
Uncached IO: Direct IO fallback to a light-weight uncached IO when unaligned

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/12/21



