Return-Path: <linux-btrfs+bounces-19691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A61EACB8152
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 08:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A1103081D45
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 07:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E830F55A;
	Fri, 12 Dec 2025 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UtFaaQO0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21B30F526
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523425; cv=none; b=ggnl7O5QPXVaqmfExxXw1qJyUHqz0lktUpoEh9rxwN8ggB0Xb1bklKCAFSN3xBFB1EpD5/BBFLC7c/7GlB5CXdue/cTprnL8wN7sCRWOO0esevfWCe+ZuFGK4qOCbCwQ+DN9osBBr9SPi2Atwz0o3cQKfUA40+DKyokIA/CQupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523425; c=relaxed/simple;
	bh=5xNrOp+BQEDGKj64kRy3iv4RyC67LQ71/CTBqrxQ44U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuP8WA0vcptS+ww88RSPUTuYC+GdNwAVWowYglP1qAkkfpPb3gdJCOnXFOkF2FVEzVCLQRf5Mig2K+LV/6yetTL7Iq0mNQwJ29IEPSEylyG0vGOgkadYnst3J5SqQ/yvOVk2GSBVpobhGL0xsb7ftExPg/CQyHTxPvmfdSbaiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UtFaaQO0; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765523423; x=1797059423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xNrOp+BQEDGKj64kRy3iv4RyC67LQ71/CTBqrxQ44U=;
  b=UtFaaQO01NMpxjbMaFDTwmqhMQeEnpslSbZ0m8zRJwoASQyWb6yiMeZO
   qPDXQsXYdGXzQ9GmWZ0p/LVMquV1ypdXToQm3U1rb7ppVyqIU7A/i4vIj
   39+Vph5NYOks3/vG0F92J9x93l4b6pl6sePLT6DbIo4myMdLJ1gpWWLXA
   aUKjwL9fDcPtW6zJBRYmYKlx9zVv/y9vqxUAB9sQIGnGDpu/6iBrMNCOm
   udvrHaKM5/zZHTMQE9u5TzFVX0WQF+blINKv16Yv74FCcjsryqwJW2h4p
   H5C/aEJGWVEEBXp5D704NJ/TWnjh4hfEuPdBmTqtBGgknzmWS5ioEXcsN
   w==;
X-CSE-ConnectionGUID: b525E2VtS8qrB7sAo7qIVQ==
X-CSE-MsgGUID: XSKfVBN8Sxy3mzNRGp3Q/A==
X-IronPort-AV: E=Sophos;i="6.21,143,1763395200"; 
   d="scan'208";a="136927266"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2025 15:10:16 +0800
IronPort-SDR: 693bbfd8_tOqqVp1kMrvGS8h2dKqujJBCXZgAzgRQwlS/MaYYKHoH3OZ
 PM+CJWKqblKj5RCa9DfkYZG7HexjjZUZCu9F4kw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2025 23:10:17 -0800
WDCIronportException: Internal
Received: from 5cg1430htq.ad.shared (HELO neo.wdc.com) ([10.224.28.119])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Dec 2025 23:10:12 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 2/4] btrfs: move space_info_flag_to_str() to space-info.h
Date: Fri, 12 Dec 2025 08:09:58 +0100
Message-ID: <20251212071000.135950-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212071000.135950-1-johannes.thumshirn@wdc.com>
References: <20251212071000.135950-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move space_info_flag_to_str() to space-info.h and as it now isn't static
to space-info.c any more prefix it with 'btrfs_'.

This way in can be re-used in other places.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 18 +-----------------
 fs/btrfs/space-info.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6babbe333741..7b7b7255f7d8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -602,22 +602,6 @@ do {									\
 	spin_unlock(&__rsv->lock);					\
 } while (0)
 
-static const char *space_info_flag_to_str(const struct btrfs_space_info *space_info)
-{
-	switch (space_info->flags) {
-	case BTRFS_BLOCK_GROUP_SYSTEM:
-		return "SYSTEM";
-	case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
-		return "DATA+METADATA";
-	case BTRFS_BLOCK_GROUP_DATA:
-		return "DATA";
-	case BTRFS_BLOCK_GROUP_METADATA:
-		return "METADATA";
-	default:
-		return "UNKNOWN";
-	}
-}
-
 static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
 {
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
@@ -630,7 +614,7 @@ static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
 static void __btrfs_dump_space_info(const struct btrfs_space_info *info)
 {
 	const struct btrfs_fs_info *fs_info = info->fs_info;
-	const char *flag_str = space_info_flag_to_str(info);
+	const char *flag_str = btrfs_space_info_type_str(info);
 	lockdep_assert_held(&info->lock);
 
 	/* The free space could be negative in case of overcommit */
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 446c0614ad4a..0703f24b23f7 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -307,4 +307,20 @@ int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
 void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
 void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
 
+static inline const char *btrfs_space_info_type_str(const struct btrfs_space_info *space_info)
+{
+	switch (space_info->flags) {
+	case BTRFS_BLOCK_GROUP_SYSTEM:
+		return "SYSTEM";
+	case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
+		return "DATA+METADATA";
+	case BTRFS_BLOCK_GROUP_DATA:
+		return "DATA";
+	case BTRFS_BLOCK_GROUP_METADATA:
+		return "METADATA";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.52.0


