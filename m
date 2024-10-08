Return-Path: <linux-btrfs+bounces-8631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F7C993BC8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 02:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A77F1F2390C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 00:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2BB676;
	Tue,  8 Oct 2024 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxLIFZ/Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE363214
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347324; cv=none; b=gWHm8CbQtJsPqF0jgJf0KIgdfjT53uYwl93K1W4H5YmIEE4CzTvGOgQavDLGrLO5Rv3sNJBMSN4g6VYhVOCD//18QSdus/YlU4bpaWiHUUFU09eot3hULTqfcc5kbvSiySWf5Goqu6MQxAqzguTEtV5P04u4mz5aPINbEQ48BnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347324; c=relaxed/simple;
	bh=G0D0Eix0H1+sZqZytDho2dcXOhVvAWqqjT4t9n5N3xY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZIcHk2ataSV41kUGXxNUSs7RDdMHTfhnO7hn+7O8X6oWZMTNZGHjju+vY1tHtb4F2gPXcztMQmDe7nyZz3BoEK2Yu7RpjwsYjSWpqzmZl/galw/x9Uztaxx1D9CRai8tDmvpuY0CfMz3TtaUtiUNbrKXRFfHZGoQqzljyIYymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxLIFZ/Q; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71e06ba441cso1047353b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 17:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728347322; x=1728952122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QI08yDpMes1iXwZwkZOt6HU4/wrX2VQfUF+zUPPZD5M=;
        b=KxLIFZ/Qf189+MDD5IvcCf6aA6ZW4kr7POFPVQ/xjkvGrI3cTLpKJEPqNOtahHuqZt
         wIaxqEwUYZLj3U3WaLDwpqj7Cw003KAfuX7HT8KrBkMxpTwsRpfkpbRNjqttIlRNmbpt
         UNtjzGg5LAu6xKyCQ4gPt9dFVmhPwQ0lwZBj2yKBU4k2JoWzb9dU973evr6jNGHr3nZr
         /FH2OBzfYnYB5jU4aiQby0AWznO6TOxDveZO27l9yBPqKZFIhEhgCzjcOMmg+m+Q+YiV
         21M8wlSxjVgLA1SuBavuYw//IUmCqZh1LKQ+MU5up6KofCf/yvj5p5Sl0jnuCRz8T8Fm
         gSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728347322; x=1728952122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QI08yDpMes1iXwZwkZOt6HU4/wrX2VQfUF+zUPPZD5M=;
        b=Qb6Bmsd+vKonK8wK4dX8yY8dsduMZKHoW3BLgO9KbbDaRyEyqHT57NO0RWUFbXOkuc
         K4QiQPQ/e7WRPW2GCVJT7TAxw4mazSOs56bNFj6xrjS6/RKTfKa09hHy+jyQKk1L2i0/
         jbWfqBB310stevBm6jvqs9wmOSwG5BDsOySp4DaTU0CwtTto9yQBsBCbkAFMhbnYuxao
         NpCOLBgegolUz0mA+NY2zrSt7hpfv9K7LD4cjdDanaF6lCmiezhxKL5cWj55SIUiOLT+
         +4oruCGuXfUySXO1UaPMSR7IEidyCKeAQINwMB3rBYLea0pgWRWWpwtAl8DE2YaT3f8B
         +7xg==
X-Gm-Message-State: AOJu0Yx2pzjk01aVuzhMn593Kpq01gh2bIPa07rcWoWfEYR72zNBs0g/
	qyfIq7OAtg1tLMvY8ZimXJ0JlyOlXXhjgcp9Lspj8wb7n/1jdpPA5OLKQUGA
X-Google-Smtp-Source: AGHT+IFpZPdz3X1xMbt0l/QDj+0YI6GQeSUcwyv5aA/U4pDQSUL/im1TM8Oa7QA9Idz/uId3Gd8eFw==
X-Received: by 2002:a05:6a20:c909:b0:1d2:e78a:cab with SMTP id adf61e73a8af0-1d6dfadd42dmr18944640637.35.1728347321906;
        Mon, 07 Oct 2024 17:28:41 -0700 (PDT)
Received: from localhost (fwdproxy-eag-001.fbsv.net. [2a03:2880:3ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d67c22sm5014891b3a.163.2024.10.07.17.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 17:28:41 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 1/3] btrfs-progs: remove block group free space
Date: Mon,  7 Oct 2024 17:27:46 -0700
Message-ID: <96adc196ea0a449be6299ef7d77c4b814e76af3a.1728346056.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1728346056.git.loemra.dev@gmail.com>
References: <cover.1728346056.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the upstream equivalent of btrfs_remove_block_group(), the
function remove_block_group_free_space() is called to delete free
spaces associated with the block group being freed. However, this
function is defined in btrfs-progs but not called anywhere.

To address this issue, I added a call to
remove_block_group_free_space() in btrfs_remove_block_group(). This
ensures that the free spaces are properly deleted when a block group
is removed.

I also added a check to remove_block_group_free_space to make sure that
free-space-tree is enabled.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
CHANGELOG:
v3:
- No change
v2:
- Added the check to make sure that free-space-tree is enabled
---
 kernel-shared/extent-tree.c     | 10 ++++++++++
 kernel-shared/free-space-tree.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index af04b9ea..f44126e2 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3536,6 +3536,16 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
+	/* delete free space items associated with this block group */
+	ret = remove_block_group_free_space(trans, block_group);
+	if (ret < 0) {
+		fprintf(stderr,
+			"failed to remove free space associated with block group for [%llu,%llu)\n",
+			bytenr, bytenr + len);
+		btrfs_unpin_extent(fs_info, bytenr, len);
+		return ret;
+	}
+
 	/* Now release the block_group_cache */
 	ret = free_block_group_cache(trans, fs_info, bytenr, len);
 	btrfs_unpin_extent(fs_info, bytenr, len);
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 81fd57b8..61263f94 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1171,6 +1171,9 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 	int done = 0, nr;
 	int ret;
 
+	if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+		return 0;
+
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
-- 
2.43.5


