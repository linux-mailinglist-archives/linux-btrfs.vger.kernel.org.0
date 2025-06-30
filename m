Return-Path: <linux-btrfs+bounces-15088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11E2AED894
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 11:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80423165EF8
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E656F244682;
	Mon, 30 Jun 2025 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I4cc+/vE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9A2405E4
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275380; cv=none; b=UFUEJT538zrzUVnnhAzffSFgtwO0TICgzkLtVRzlYZM4TQ+FGQ+ZLodfeQCCEu9KeHDwr4EU0c5EU8WgAQbp4y8ncYkjwg0PDcjdn7v5JNlOzM81wn5fGk0LmdvRL2mh8ZSuRnSMs3ep15cP9EB6CNcegSKQiPPmA/djKcajGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275380; c=relaxed/simple;
	bh=sj1CkK35Gr9q2Y2u/5GRgZUqEbpNpCFSopdZn6U2JgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRTkEadK8Ju23omcWRBVai0Dz756+t+3FInsgarhzjx5l0BH9Fzyz2p4xCQ61/DS3FvFVUAg6YhMtc+0kLIVmurwzN0oH4gYcd1PZBQJr71nn7dIDtclgvz+v657Nw8RuSAPSjM9jWFJSZOp0wrWkXNiRnymW28GgVt9xlJmsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I4cc+/vE; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751275379; x=1782811379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sj1CkK35Gr9q2Y2u/5GRgZUqEbpNpCFSopdZn6U2JgQ=;
  b=I4cc+/vELhS2WJ3lUtGK/iJ2ysBYSPu+OHvHggwrJiVxH+xWZABuU2B7
   rIYhhKQ3jZfDQ43xNoffSWbiFH8IjufQvgLLxFtlRtwL7sVKmYq9BlQ/S
   asX5td/JdJhHWzmfrSH4n+7V5VnGL256ahhW/oW+JDvhFFac315Przerm
   mFbe++HSAjlNQf/8OJ3vAPDWGRcuVvSeEA/RUU+5NNlniQ877wcttKNi0
   rnFB9Ub1vnfgKk1FnX2fQmtqkju32gf8Vv0i01WtR0/gBEb7BggVk0qXN
   JN/ecuL/FpTbkeGdpr1xe5BIJ7zvbhE3tW1O7VCuZLchFGn0cgHAgbZE6
   w==;
X-CSE-ConnectionGUID: BEvbO0KJSz6s/IU43kQ20A==
X-CSE-MsgGUID: xdGmRsVZQTSrEosi42250A==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="86228264"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2025 17:22:58 +0800
IronPort-SDR: 686248e9_YiQncNcGsyb/7ZeSl+DSKhU5ww9ajwh7RflXZ3J+rhv+EOU
 umeYxIQbRKd6JfPUM7mY5ie4s+09ysg5CaSyTQg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2025 01:20:58 -0700
WDCIronportException: Internal
Received: from 5cg2174243.ad.shared (HELO naota-xeon) ([10.224.163.146])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2025 02:22:56 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] btrfs: zoned: fix removing of unwritten non-data block group
Date: Mon, 30 Jun 2025 18:22:36 +0900
Message-ID: <cover.1751273376.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some reports of "unable to find chunk map for logical 2147483648
length 16384" error message appears in the dmesg. This means some IOs are
occurring after a block group is removed.

The IOs are coming from unused dirty tree nodes. When a metadata tree
node is cleaned on the zoned setup, we keep that node still dirty and
write it out not to create a write hole. When user operation e.g,
fsync() is fast enough, we can have a block grup full of "unused dirty"
tree nodes. Such block group has its used count == 0, making it "unused"
block group and candidate for removal.

Removing the block group keeps the dirty nodes unsent until next sync or
umount operation. At that time, such nodes will cause the "unable to
find chunk map" failures.

This sympton can happen relatively easy on SMR, whose zone size ==
256MB, but it is hidden coincidently hitting a check in
do_zone_finish(). Hitting the check remove the block group from the
unused list and let it never reclaimed, which itself is a problem.

Fix them adding an extra check in the BG removal process and put a block
group in the retry list when btrfs_zone_finish() returns -EAGAIN.

Naohiro Aota (2):
  btrfs: zoned: do not remove unwritten non-data block group
  btrfs: zoned: requeue to unused block group list if zone finish failed

 fs/btrfs/block-group.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
2.50.0


