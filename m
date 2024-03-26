Return-Path: <linux-btrfs+bounces-3589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB5088B9D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 06:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5424B23350
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 05:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09321292FD;
	Tue, 26 Mar 2024 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZDPvZVoe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94B026AC3
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 05:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711431579; cv=none; b=uhGxmtEHjejmqBOpof9K+VgdPYdLhS63DOUtJ8qyoLiadlzBRhi/+RVr9Sa6iIEHpq2ToHzdkMfKNNnBYvRCeeLjPuiUjk02L6Ev1KrdMnCV5dyomKPxFmhifI+PBNOl/s3ip0PD1KL8w9aVYpa0V2dFVKglcH6D2IkM8vyqsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711431579; c=relaxed/simple;
	bh=v+29J+PhZhmJkPo6HgOZp02GBgaBSie1vTye+jBoxzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzyxoKAOE2+Bj5ebW6y07KDNr3ds9nii1cj6/XtJmoN1sH5ULwwDEd6acoMogrDSomMpZt0Ie/1hAJVSMM1SO4bPqTb4H/ZcK7lqM8y0LuMLEZqQctprQ0w1tuJH2EAmyot69vQKv4t6ifiXmAPNTFFWKUlAhjCC2bENkHXXGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZDPvZVoe; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711431578; x=1742967578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v+29J+PhZhmJkPo6HgOZp02GBgaBSie1vTye+jBoxzI=;
  b=ZDPvZVoeS0lVL+3ET9umkUHZ1QGOM0wsj6hx2RrmDujq5KVRFcRs2QiT
   neuG32OCSCYzsX+x4ju6KwvMIwZYmX+GutKJVTS7HNHPcxPv/bGVQ3h7F
   rcFEaeOXCuxNSYKBqGvvGpku7oPdGwc5HoY6mwhDQ6IMqoqSD4rpKiDEm
   fcY91CKOToyJtmLvOw0PY4Z3E4EC/bFixBtN1xyK+aVzyW2WeZIgrkkr5
   +RArl7lMTSL4O/FadvbeANKkNSkM/6TkFWQFY2RlO7LV/V4D7W7qf59QC
   ge3qbGqOsOLQp4Gp9Zmzk4sNjCeRxdwj6xyFffCEe4YwgfX1hqTNT/zzh
   g==;
X-CSE-ConnectionGUID: hvdIy7MNT8WMoDFeU1ax0g==
X-CSE-MsgGUID: Fs0kqeiORZ2fbC+HCs+cww==
X-IronPort-AV: E=Sophos;i="6.07,155,1708358400"; 
   d="scan'208";a="12317310"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2024 13:39:31 +0800
IronPort-SDR: 9E9YXuaiIuxAdoJzIX0NqUMbcU7/a/HuDDlkKEvJZuIMexGRQMVghzzpeVOEhuW1GzyIbH177e
 NTkbJFzHY/oA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2024 21:48:15 -0700
IronPort-SDR: HykdkF2ZW2DskT6NorrtEC5zRkoAISDSQmf/4GuXPJA71AWR1hxyCUGdRzEg0zaoRo1iOMsE7p
 FhOaZBf2rDRw==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.124])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Mar 2024 22:39:29 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/2] btrfs: zoned: fix EXTENT_BUFFER_ZONED_ZEROOUT handling
Date: Tue, 26 Mar 2024 14:39:19 +0900
Message-ID: <cover.1711416290.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Btrfs clears the content of an extent buffer marked as
EXTENT_BUFFER_ZONED_ZEROOUT before the bio submission. This mechanism is
introduced to prevent a write hole of an extent buffer, which is once
allocated, marked dirty, but turns out unnecessary and cleaned up within
one transaction operation.

Currently, btrfs_clear_buffer_dirty() marks the extent buffer as
EXTENT_BUFFER_ZONED_ZEROOUT, and skip the enteri function. If this call
happens while the buffer is under IO (with the WRITEBACK flag set, without
the DIRTY flag), we can add the ZEROOUT flag and clear the buffer's content
just before a bio submission. As a result, 1) it can lead to adding faulty
delayed reference item which leads to a FS corrupted (EUCLEAN) error, and
2) it writes out cleared tree node on disk

Fix them by skipping a non-dirty extent buffer. Also, the second patch adds
ASSERT and WARN to catch invalid EXTENT_BUFFER_ZONED_ZEROOUT state.

Naohiro Aota (2):
  btrfs: zoned: do not flag ZEROOUT on non-dirty extent bufffer
  btrfs: zoned: add ASSERT and WARN for EXTENT_BUFFER_ZONED_ZEROOUT
    handling

 fs/btrfs/extent-tree.c | 8 ++++++++
 fs/btrfs/extent_io.c   | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
Changes:
- Change the fix to address the root cause.

v1: https://lore.kernel.org/linux-btrfs/3f4f2a0ff1a6c818050434288925bdcf3cd719e5.1709124777.git.naohiro.aota@wdc.com/
--
2.44.0


