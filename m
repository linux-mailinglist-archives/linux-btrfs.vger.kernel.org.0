Return-Path: <linux-btrfs+bounces-19707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93908CBA4E8
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 06:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47DA830A7A66
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 05:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A1A220F37;
	Sat, 13 Dec 2025 05:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h1jTlX/4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4C2AD22
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 05:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765602208; cv=none; b=rwx1tv2A4UOjEHnbo0nI3/e8Wrp+8l0WF7OWqT+o4pX0xaKzK7oerlLmfqrQlYbLlj1Kozg3CyU4PbbMiJKNp0tdS9B85p0FMP8FTiunpruDFPfn1mxbeAMhjHMi/HVGkOhskJCMQEPFVsbfMliRnHyiVt+HQ2MhE6c3/sCSYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765602208; c=relaxed/simple;
	bh=rL9kwYJpWDuW2i63rPpMQ9JC+PG36LVQb4t8LGPK00g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAO2m/z4VBhwE33NKmfpaoU3zMeCgroYcbASIZtphBnPSqMgqCxDKoooZyro+Y+kIfNcs7poVrD1bMg77MP1zV0If6ux2MKMyNM1tjh+wufbBirvK5q4FPhLP7B9CFAUHOB1oVGAxhTluQTZSULijY++mmieDYZNmcwUpx1RpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h1jTlX/4; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765602205; x=1797138205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rL9kwYJpWDuW2i63rPpMQ9JC+PG36LVQb4t8LGPK00g=;
  b=h1jTlX/4ZqbMl2nE/FMEp7sGrLEKClSB96VIg28d5+lFC1k8jp8CW9gK
   DmtPQF80nyw8VDmCjxrERerEj7ogK6qrOB8xKLxMpxhkuKIqbfHf0YcsV
   BLkbTIczIQaLwoc7HcwzCI8afUX8ZbB4HFC2TTaE+HHjRjfpEHP7nNSx7
   O2nPgwuk2kONI7fWAXEUMrAr9YC09JjASXIx+e/h9tqHbhdtZnDcw/fot
   6XG6rP5wUwER2kFF2QLzPHV8qw01EZcca5idk9k9/ZsjQrxTGFryg1UdS
   HCC99NoS4sAwJOxQde0H8zGa1LMbRMR6fP+DMzYWl4FKx0RRn+gOZWsC5
   A==;
X-CSE-ConnectionGUID: MWDxtfw7RKm8hxPYHJQ+wQ==
X-CSE-MsgGUID: lkNqGTKBST6WCIiJOTdzaw==
X-IronPort-AV: E=Sophos;i="6.21,145,1763395200"; 
   d="scan'208";a="136986293"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2025 13:03:25 +0800
IronPort-SDR: 693cf39d_jTdtFFYNE9pmhsMwb7F2gWkIjsZWvxI9ncY7dytd75ArQS3
 yFqWU1FpiDwtJ+LjE7FhwbpbyHaFq4fqXgNbr+g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2025 21:03:26 -0800
WDCIronportException: Internal
Received: from 5cg21747lt.ad.shared (HELO neo.wdc.com) ([10.224.28.121])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2025 21:03:21 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 2/4] btrfs: move space_info_flag_to_str() to space-info.h
Date: Sat, 13 Dec 2025 06:03:03 +0100
Message-ID: <20251213050305.10790-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
References: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move space_info_flag_to_str() to space-info.h and as it now isn't static
to space-info.c any more prefix it with 'btrfs_'.

This way it can be re-used in other places.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
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


