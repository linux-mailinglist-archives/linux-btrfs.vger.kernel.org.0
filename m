Return-Path: <linux-btrfs+bounces-1034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF38176D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 17:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FF11F2612C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B157072074;
	Mon, 18 Dec 2023 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LWVt8cIc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC65D742
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702915356; x=1734451356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ng52X/ouutLoop3mLhEk3FTCGxR3Fc63aEDZEFuqMNk=;
  b=LWVt8cIcQfPYv9bwCc4gQcIlLo2ql1+gMXFP+4CdHIxunvBpOTe5TqCj
   vSFx1R99ltu9HkC5bDtYbCh5ke7p430N9CaaUupb8a2v357gu1f7gktSF
   LOXW4Y5366ONGtFBhEEPXStbpenACQ8pcFw81+uWwo+Ty880ennnbopaJ
   HOcHZl/qn4C3h2XCt4LVywSb7Jpce2/9TchatNyjK1CmVHDk8ENcdhMpz
   eT9X7ve0E60/SyVfD9SE4MV12KZ9JVRk8kgQDCbTxED8OyZ6bjbzkIRX7
   0QyLErMK6nE2hLvIcm1UQEYNyhoCSJhdkYMJrfleY0indiILIrOvX6UgZ
   A==;
X-CSE-ConnectionGUID: LEf6xMHkQ9anmSSNRf8Ogw==
X-CSE-MsgGUID: EkvckzeJRfKj4IMKmGFSlA==
X-IronPort-AV: E=Sophos;i="6.04,286,1695657600"; 
   d="scan'208";a="4945730"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2023 00:02:35 +0800
IronPort-SDR: 6MGphk7sEUYbjnVDAv09mf5+RxW6lzEtbs3O6hy7G1Z5iDA0U5l/PnwZOMXMpTaEmD/MqI/Zpz
 gdffF0FEi5Ig==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Dec 2023 07:13:21 -0800
IronPort-SDR: o9D72XUOToCBqX5Vc8FL9M/YRmexMPAmfPa9o8eeXHjzlpg37hAkXte3JkRVQ0nZ46NAUIbNvB
 y6JtrVBlzlNw==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.88])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Dec 2023 08:02:35 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] btrfs: zoned: split out prepare_allocation_zoned()
Date: Tue, 19 Dec 2023 01:02:28 +0900
Message-ID: <274542c69aa580a163b5e995afb8c19fe494318b.1702913643.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702913643.git.naohiro.aota@wdc.com>
References: <cover.1702913643.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split out prepare_allocation_zoned() for further extension. While at it,
optimize the if-branch a bit.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f396aba92c57..d260b970bec7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4298,6 +4298,24 @@ static int prepare_allocation_clustered(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
+				    struct find_free_extent_ctl *ffe_ctl)
+{
+	if (ffe_ctl->for_treelog) {
+		spin_lock(&fs_info->treelog_bg_lock);
+		if (fs_info->treelog_bg)
+			ffe_ctl->hint_byte = fs_info->treelog_bg;
+		spin_unlock(&fs_info->treelog_bg_lock);
+	} else if (ffe_ctl->for_data_reloc) {
+		spin_lock(&fs_info->relocation_bg_lock);
+		if (fs_info->data_reloc_bg)
+			ffe_ctl->hint_byte = fs_info->data_reloc_bg;
+		spin_unlock(&fs_info->relocation_bg_lock);
+	}
+
+	return 0;
+}
+
 static int prepare_allocation(struct btrfs_fs_info *fs_info,
 			      struct find_free_extent_ctl *ffe_ctl,
 			      struct btrfs_space_info *space_info,
@@ -4308,19 +4326,7 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
 	case BTRFS_EXTENT_ALLOC_ZONED:
-		if (ffe_ctl->for_treelog) {
-			spin_lock(&fs_info->treelog_bg_lock);
-			if (fs_info->treelog_bg)
-				ffe_ctl->hint_byte = fs_info->treelog_bg;
-			spin_unlock(&fs_info->treelog_bg_lock);
-		}
-		if (ffe_ctl->for_data_reloc) {
-			spin_lock(&fs_info->relocation_bg_lock);
-			if (fs_info->data_reloc_bg)
-				ffe_ctl->hint_byte = fs_info->data_reloc_bg;
-			spin_unlock(&fs_info->relocation_bg_lock);
-		}
-		return 0;
+		return prepare_allocation_zoned(fs_info, ffe_ctl);
 	default:
 		BUG();
 	}
-- 
2.43.0


