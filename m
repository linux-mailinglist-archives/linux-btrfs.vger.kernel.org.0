Return-Path: <linux-btrfs+bounces-10077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4468E9E4EEF
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B3B2824FF
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6B61C8FB5;
	Thu,  5 Dec 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lmb1jlxE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55811C3F0E
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385029; cv=none; b=iIbsAycqKvqCC81SDiCvob7WCqkJpsvSxniHMoo2tKMsPaHoOqH0ylve+7PtbKUubTey7kTi07QjFi+jb5NfLPymJgH5VYUqexQy1ZBwFY5jR3IkLh8By1CGmKUcJA7NJmlHjxD/X+P1Wy3A3ZWOW1QepobtvUgV25wV288jY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385029; c=relaxed/simple;
	bh=5pIbaYCfT7dLhEaTKxPPX3lrT2IKE6rJS8dQpQ8ji3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJD0cgY6dJXn/BAfR6BEtuojJaBU0Jm/R3tquBL5qwtEJqy1o9GwCsY3AntN+rUazjReCor8/KWxnMoLiuKphMk21G4yn8ikhr5JEaRdvQcKllS+fKK8b1oE9A5X8GUvXRHO5RyPjnzlVoJY8sAxCvETWBxdGlUOElMzl/hMFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Lmb1jlxE; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733385027; x=1764921027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pIbaYCfT7dLhEaTKxPPX3lrT2IKE6rJS8dQpQ8ji3A=;
  b=Lmb1jlxEHW3X7me9CcntqT8pDhpU1FG2WFwcAT96SgUEnoQpP16IinqF
   YS+734h/eFlRhlC9KWSrie01a+QdIgrJmpfUsx68QqC5CVGzPqMLoCTag
   lEcMf0gxCTVPjRnBqPyccxNsBd5JAzjF1qTMeXg6FIX72A+6qWkdX2/eL
   NynjtQdLC6dUqq4RDBBMQ+QsyHdbEzj0F5mlJ9CWdYnrkntnJLmns27n4
   ViMYJlvVVEIBf7gRzny+Tu116W4IEqdmQZcV3ZxSs3k0c/jkBmWcglwvn
   TvYipDZq8P+IYXYj+TITHlmen6IS4VYRCSmyOYOh3Zvq/+uQLk3AUmArg
   w==;
X-CSE-ConnectionGUID: ld71wB4jSPKHzHvBCLZbhQ==
X-CSE-MsgGUID: 2LbYQrqKR9CaoIydna+WQw==
X-Ironport-Invalid-End-Of-Message: True
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="33626107"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:18 +0800
IronPort-SDR: 67514c59_ASG92JhxIOUYJb8HgXh9dNOtoDn1RU9mOc2T3O1nqI0YwRg
 sixucwD8a5lDs63wgS1+ynHUST4shSGaxj8eqQw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:46:49 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:18 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 03/11] btrfs: factor out init_space_info()
Date: Thu,  5 Dec 2024 16:48:19 +0900
Message-ID: <e59263376e8952259913e7c5e1b45356983eac78.1733384171.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733384171.git.naohiro.aota@wdc.com>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out initialization of the space_info struct, which is used in a later
patch. There is no functional change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2c07871480b6..782807c926e1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -234,19 +234,11 @@ void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 	WRITE_ONCE(space_info->chunk_size, chunk_size);
 }
 
-static int create_space_info(struct btrfs_fs_info *info, u64 flags)
+static void init_space_info(struct btrfs_fs_info *info,
+			    struct btrfs_space_info *space_info, u64 flags)
 {
-
-	struct btrfs_space_info *space_info;
-	int i;
-	int ret;
-
-	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
-	if (!space_info)
-		return -ENOMEM;
-
 	space_info->fs_info = info;
-	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
+	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++)
 		INIT_LIST_HEAD(&space_info->block_groups[i]);
 	init_rwsem(&space_info->groups_sem);
 	spin_lock_init(&space_info->lock);
@@ -260,6 +252,19 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 	if (btrfs_is_zoned(info))
 		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
+}
+
+static int create_space_info(struct btrfs_fs_info *info, u64 flags)
+{
+
+	struct btrfs_space_info *space_info;
+	int ret;
+
+	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
+	if (!space_info)
+		return -ENOMEM;
+
+	init_space_info(info, space_info, flags);
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
-- 
2.47.1


