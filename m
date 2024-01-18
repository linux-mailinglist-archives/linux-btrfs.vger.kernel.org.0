Return-Path: <linux-btrfs+bounces-1548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ABB83152C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 09:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10EC2854D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42920125A7;
	Thu, 18 Jan 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YyujbJr6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B88125A2
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568128; cv=none; b=LberXtrB09LHmyxWm5T1kIu1859+Poj2HyqSS/NU/YVpUoLjsYKNhG7n+UT2mmoHnfPuIBRquagUTEzN+yQBQX+j23pDbj3C4o+yfOWrD/n3fcvjYy7+av8y1K0AdMI5ZYmex+7rG66hHkCjZx06qSFAQNsHOtzDBBE0T3MOLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568128; c=relaxed/simple;
	bh=ve3n6M6YLDZ8vWsBzpyf+yH6652fOAvGTsTg6lDm/0o=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:IronPort-SDR:Received:IronPort-SDR:WDCIronportException:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=OB8M3eNuW0pXByimW4hvix1xEHO70PlI1MiabGya0j/qhDWytZ/E+Q8IpZm7k4SaiylAiroRmmgHpLm2pRzpvZoctkSewzin8lINl1smelAJnH6UystLyY67eAye2/vDNiY0PrrGwj6DPPic9wPOa/kVw7dBh7ZkVWdg4c2+hSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YyujbJr6; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705568126; x=1737104126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ve3n6M6YLDZ8vWsBzpyf+yH6652fOAvGTsTg6lDm/0o=;
  b=YyujbJr6jL1gb6mA6Yo+v3rtLGgI6FEwC4PfagpRojRxcaBaF1iGaI0/
   YLc0myRO/0cp6HlSxhybf7Pt4HkXqfmWbkOUawYpPYN2jDSMGsTmiENuX
   71XCERNXiRb1T45+njAYwtOv7WWMDJ4G62jIP5zz9I8HO6es+ew6cnQ1d
   bWmOS5WCrPToamYDEyAd4ZO/gUtWvM4hP0OEZumfw7SbKM8rrvpwxEv2H
   EQ/Ma96NM5zo3dz2xbmelYRVTLQsW9YvYa0Vr8SAbo1u44CocnVxUR/Vs
   cLZgVqX3pebZbt2A/VuqNxGm5Nepsae5dxmgCjPuo9UthPH1cQI1jiDv/
   g==;
X-CSE-ConnectionGUID: QOBCtDiMSGulEUKRNwO2Eg==
X-CSE-MsgGUID: hGQkQ9g7R2OjfuL8gI3+cQ==
X-IronPort-AV: E=Sophos;i="6.05,201,1701100800"; 
   d="scan'208";a="7171153"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2024 16:55:18 +0800
IronPort-SDR: vSLgBcqEHxLZRbi03qiZwfbyIAC/+QnnT5KokzsrLylt2e44rS2UqiDX+XSc5syIiVZmkKOIPm
 hSqCuA7f11Vg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2024 23:59:47 -0800
IronPort-SDR: D1quaOCv4zdE3StpTsXGdzS1dcHHRn5qGSciP5IPCPpE2MAn8aIjXKGbvo+Dw8RYgWpjzDLqRx
 Tpj50GTt6wFA==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.56])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2024 00:55:18 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: wangyugui@e16-tech.com,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] btrfs: disable inline checksum for multi-dev striped FS
Date: Thu, 18 Jan 2024 17:54:49 +0900
Message-ID: <cover.1705568050.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a report of write performance regression on 6.5-rc4 on RAID0
(4 devices) btrfs [1]. Then, I reported that BTRFS_FS_CSUM_IMPL_FAST
and doing the checksum inline can be bad for performance on RAID0
setup [2]. 

[1] https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
[2] https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/

While inlining the fast checksum is good for single (or two) device,
but it is not fast enough for multi-device striped writing.

So, this series first introduces fs_devices->inline_csum_mode and its
sysfs interface to tweak the inline csum behavior (auto/on/off). Then,
it disables inline checksum when it find a block group striped writing
into multiple devices.

Naohiro Aota (2):
  btrfs: introduce inline_csum_mode to tweak inline checksum behavior
  btrfs: detect multi-dev stripe and disable automatic inline checksum

 fs/btrfs/bio.c     | 14 ++++++++++++--
 fs/btrfs/sysfs.c   | 39 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c | 20 ++++++++++++++++++++
 fs/btrfs/volumes.h | 21 +++++++++++++++++++++
 4 files changed, 92 insertions(+), 2 deletions(-)

-- 
2.43.0


