Return-Path: <linux-btrfs+bounces-3591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D3D88B9D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 06:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0C22C303C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 05:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70512AACE;
	Tue, 26 Mar 2024 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TcjS25nn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36ED1292FF
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711431582; cv=none; b=SgjwOFk/BjIIETVlrH5VduDftQ0wd6knGgI5/VF64MEnQhKMptRzHPjRnwpC33ra5ED+h1E/ni55ra2i5n08vTrlEt7qO1isIyEo1y6QpQutb4XYRUPtPcEBBxg0vqcKfs11IUQA6Dc7xCbZwsseZxA0gM9iPyuE+Emc9ip8lQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711431582; c=relaxed/simple;
	bh=pyrjksPHrvqZerftNTHtsMSozo0LvG8+kj0Z46SjtbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPa/8m2niE7HR8ZLRLnNlfDf0FeOUgT2txZ0clCtmjyXnrOzaGDCKCAJKllZ1VJ9K5MjiFNroPEPsojd7IVLtFQWrkvJw8eAFRBbv/GqkvgAj4dDBJosFcY+6pRLZLQCguh6j2ZKf50VYETo/kCOERmmaENdOz6u/OD+SO7p/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TcjS25nn; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711431581; x=1742967581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pyrjksPHrvqZerftNTHtsMSozo0LvG8+kj0Z46SjtbA=;
  b=TcjS25nnx5JZcNTfmWpiz0Gon1Nd/rwnb92kovXjbQbrc5v4KwzVLISg
   C3iPlAVg3m13JxRky9wptNpmrEGrrRjIFyZogmPCuZTosLoMGEDukrArr
   Ne17029nAM4OEaj8XFJEp4vZNCNO1K6/E8bP1So5PmPMOD4S7Xzg48v3d
   esfL/1lIrdECb6GhFYFOsgtx9DdRxJByAN8fcgMcMBS+QbUvw5lyT8RPS
   KhK09LQan6/OUkoDAwIErBuToLyvyQ2B3vOMkMngwKbp5fDNKD5K4iguk
   QuR5EJTj/rE6JT5EWBfLgxCHb9/s31NFtz8Cj9c7VEdtYDiHZZwA2ni92
   Q==;
X-CSE-ConnectionGUID: TyQtmJdMROe6HUoBXrDulA==
X-CSE-MsgGUID: Oxk/VfIPQwWwI4fJycdjYQ==
X-IronPort-AV: E=Sophos;i="6.07,155,1708358400"; 
   d="scan'208";a="12317325"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2024 13:39:37 +0800
IronPort-SDR: nPfM+cohqLkrPEbQfd9tSzDoI/64KxInsh8m3TP/SHWT0B53eZumNVdC97bCibBKKE/FkQ70IM
 /lfWDqUfOoIg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2024 21:48:22 -0700
IronPort-SDR: 0HORhWoXpp6xWhQSnLyAsGvFWgDG/AYKG2ImNsrAvltKlczYp7uFs559W7C0DtKKOKZTt7H7mf
 041z0BrfZuBQ==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.124])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Mar 2024 22:39:35 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/2] btrfs: zoned: add ASSERT and WARN for EXTENT_BUFFER_ZONED_ZEROOUT handling
Date: Tue, 26 Mar 2024 14:39:21 +0900
Message-ID: <69ea90cc5f4610a85fc59181b3cd28c6fcab8bbd.1711416290.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711416290.git.naohiro.aota@wdc.com>
References: <cover.1711416290.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an ASSERT to catch a faulty delayed reference item resulting from
prematurely cleared extent buffer.

Also, add a WARN to detect if we try to dirty a ZEROOUT buffer again, which
is suspicious as its update will be lost.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 8 ++++++++
 fs/btrfs/extent_io.c   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1a1191efe59e..42525dc8a551 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3464,6 +3464,14 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
 		struct btrfs_ref generic_ref = { 0 };
 
+		/*
+		 * Assert that the extent buffer is not cleared due to
+		 * EXTENT_BUFFER_ZONED_ZEROOUT. Please refer
+		 * btrfs_clear_buffer_dirty() and btree_csum_one_bio() for
+		 * detail.
+		 */
+		ASSERT(btrfs_header_bytenr(buf) != 0);
+
 		btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
 				       buf->start, buf->len, parent,
 				       btrfs_header_owner(buf));
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bfe7814c818a..42bcbe9bd863 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4192,6 +4192,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 	num_folios = num_extent_folios(eb);
 	WARN_ON(atomic_read(&eb->refs) == 0);
 	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
+	WARN_ON(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
 
 	if (!was_dirty) {
 		bool subpage = eb->fs_info->nodesize < PAGE_SIZE;
-- 
2.44.0


