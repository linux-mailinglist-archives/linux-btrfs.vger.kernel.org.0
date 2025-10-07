Return-Path: <linux-btrfs+bounces-17487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C042BC01AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 05:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43A084E8838
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 03:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD6214A79;
	Tue,  7 Oct 2025 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGFwM1P2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463F34BA3A
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759808180; cv=none; b=P6dgPuvZMKY2JOkCWrKwyKGKb4yjNooJTAjMsmX9YRV/prKDmBYDhtdu2EK75sYo4Y9uPibx5gWjLbumAopkBoD1qRwbvbzts359NFOodPpxHqHs93YhXtqXpPqPPKS5ROejiJDSWblD3rrcmQOWQbbKi/w9Mb1Bu6azZGPWJuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759808180; c=relaxed/simple;
	bh=qtabqUbM8pd163RdFTMEmfOHp/PTs4R3PvNywD1XCmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KN77AJZpqqAAEM/xn66Lwh816YaAqjjI4fEVv4MXjfRFyfXBNKLY18//p9DXYFwqgpIKhjGWONYEfe26UnN2+FnbHp/uLHEJoQpAgTHqzkuE32HtaDK9BqYZRwk0c9DFQ3kJGT03ZDDiaf6kFnCilkaWsszrzFzP7Aa0AR4FjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGFwM1P2; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3307e8979f2so1183985a91.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Oct 2025 20:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759808178; x=1760412978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SLVwNXp5hmRDHfv3TKtAqPdbtGjykRiElnHiJaz7xSE=;
        b=XGFwM1P2Z33+1I/U9JG87MCO3bqPPHOJ54bVZWzVLto+zVGv5nWxKYwDidQJJDMTyZ
         J6Q5nX+CMLRPEa3RA/35kXpy55TxqDYmJFc4eFxuvFleUX6vo9NOgbk/oLIjPnsChz5O
         WBqvCVsG9UDACqda2hO/PMsEvw1yoGQiGit4GvsjNgtuKl8bVHj3VOdXAT7PqX7Uyi9t
         rf7uCJGevF0NNrrTNwU0c8c3/Nf2i27DRfKxn6j14dKvd9+/xV9tdOwarQRpwiM2aL5t
         4WJons4VOjuOiuWpuNtWtFEmB1kRoFtozWJNxzqsddYFDQPqMUOFKm5iEOOpDf8O0DZB
         FmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759808178; x=1760412978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLVwNXp5hmRDHfv3TKtAqPdbtGjykRiElnHiJaz7xSE=;
        b=bPWuWZ0DNVcUs4kz59s3PuXHwH8P2sCQ3QgTELLJJ1iNqMGFDtuTO/R3y+CPd3PkPb
         lokh0Ycf1ZigqbSeueYTIwIhvX/kpmCt7PbtASXpMc0rn7KfykVNpiES9UhuEtMnEXbv
         NrTlkJcLj4lQboC26xYLTA1xaoLXxpXcgOtNahnj3KdWqLD8/mKecFKaay6ySazRth7L
         tqBiOhF+EGwuiurb3MOSoGaOKe5D3OD+0mO2LXlWE2mSvYwKHZ6ZNeFu+R+423Lkvhz2
         dhOyPhQHlvIyC2TQ/A1+P12N+Dxb4gwUWFkd6Bv/VNPmZ8M3yq0s/25VfxWcLospHkAf
         VPkA==
X-Gm-Message-State: AOJu0YzaqeyiMKbBf9bGLLOWifpRkQoodDXUHW/1I49R6MFnNRGrKdaT
	fjVL0FYX4ucyPjjgk4KzyC0EFy8C+kkexVzOiGZTgtbWF5/M+ERx9xd6vrtU/w6qp6oEuA==
X-Gm-Gg: ASbGncuUG5mDbfs0UzlqIcBMPZDNcVIVjcKECCcS0mX3vb96nazuIGs1ad/aL1i3A+t
	3I9eAqFjV9Dgiao1R4fmk1fioF8sZNNFt8un6A+r+2aQY2rdWTAcMBp79e8UGxk8Weae9T90TKD
	/xLzbILy37YA4V5ozXC7EeB3xL7H+pb1haKayWbhniNY3XomDsaxHVA/LCXXFcmseIQcRQ6jQGm
	fT/1PDPUX5DroncZ0jPPNFiTsgwy+aT4qkZ/zQN3oPqbHktwKlgQ1eTkIUHudszSCfUbqJ33RYp
	/jVAZTT+elusHJMj2DRNqWU3DU1HedQ90AiLPr3to1cqrV7K6Wo2+rlsxEYXjdfQgW5x81g9wAH
	3Fvjkc1JK8dUwA6fgD/usng0tf21tS7A+pPu194Lv9fObtKpgEuf3
X-Google-Smtp-Source: AGHT+IErlHRTzAP9jeKWx3hNzqAgd7od7CR7aHrHMzwJzrvacJFPRIeTcP2Q5Y6WrFHs5NZVkNNSlg==
X-Received: by 2002:a17:90b:1e11:b0:32e:64ca:e851 with SMTP id 98e67ed59e1d1-339c265e638mr9523503a91.0.1759808177821;
        Mon, 06 Oct 2025 20:36:17 -0700 (PDT)
Received: from SaltyKitkat ([154.3.38.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339f09ae847sm208199a91.1.2025.10.06.20.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:36:17 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH] btrfs: trivial BTRFS_PATH_AUTO_FREE conversions for tests
Date: Tue,  7 Oct 2025 11:35:12 +0800
Message-ID: <20251007033603.13858-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial pattern for the auto freeing. No other function cleanup.

The following cases are considered trivial in this patch:

1. Cases where there are no operations between btrfs_free_path() and the
   function return.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/tests/qgroup-tests.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 3fc8dc3fd980..05cfda8af422 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -20,7 +20,7 @@ static int insert_normal_tree_ref(struct btrfs_root *root, u64 bytenr,
 	struct btrfs_extent_item *item;
 	struct btrfs_extent_inline_ref *iref;
 	struct btrfs_tree_block_info *block_info;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_key ins;
 	u32 size = sizeof(*item) + sizeof(*iref) + sizeof(*block_info);
@@ -41,7 +41,6 @@ static int insert_normal_tree_ref(struct btrfs_root *root, u64 bytenr,
 	ret = btrfs_insert_empty_item(&trans, root, path, &ins, size);
 	if (ret) {
 		test_err("couldn't insert ref %d", ret);
-		btrfs_free_path(path);
 		return ret;
 	}
 
@@ -61,7 +60,6 @@ static int insert_normal_tree_ref(struct btrfs_root *root, u64 bytenr,
 		btrfs_set_extent_inline_ref_type(leaf, iref, BTRFS_TREE_BLOCK_REF_KEY);
 		btrfs_set_extent_inline_ref_offset(leaf, iref, root_objectid);
 	}
-	btrfs_free_path(path);
 	return 0;
 }
 
@@ -70,7 +68,7 @@ static int add_tree_ref(struct btrfs_root *root, u64 bytenr, u64 num_bytes,
 {
 	struct btrfs_trans_handle trans;
 	struct btrfs_extent_item *item;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	u64 refs;
 	int ret;
@@ -90,7 +88,6 @@ static int add_tree_ref(struct btrfs_root *root, u64 bytenr, u64 num_bytes,
 	ret = btrfs_search_slot(&trans, root, &key, path, 0, 1);
 	if (ret) {
 		test_err("couldn't find extent ref");
-		btrfs_free_path(path);
 		return ret;
 	}
 
@@ -112,7 +109,6 @@ static int add_tree_ref(struct btrfs_root *root, u64 bytenr, u64 num_bytes,
 	ret = btrfs_insert_empty_item(&trans, root, path, &key, 0);
 	if (ret)
 		test_err("failed to insert backref");
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -121,7 +117,7 @@ static int remove_extent_item(struct btrfs_root *root, u64 bytenr,
 {
 	struct btrfs_trans_handle trans;
 	struct btrfs_key key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 
 	btrfs_init_dummy_trans(&trans, NULL);
@@ -139,11 +135,9 @@ static int remove_extent_item(struct btrfs_root *root, u64 bytenr,
 	ret = btrfs_search_slot(&trans, root, &key, path, -1, 1);
 	if (ret) {
 		test_err("didn't find our key %d", ret);
-		btrfs_free_path(path);
 		return ret;
 	}
 	btrfs_del_item(&trans, root, path);
-	btrfs_free_path(path);
 	return 0;
 }
 
@@ -152,7 +146,7 @@ static int remove_extent_ref(struct btrfs_root *root, u64 bytenr,
 {
 	struct btrfs_trans_handle trans;
 	struct btrfs_extent_item *item;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	u64 refs;
 	int ret;
@@ -172,7 +166,6 @@ static int remove_extent_ref(struct btrfs_root *root, u64 bytenr,
 	ret = btrfs_search_slot(&trans, root, &key, path, 0, 1);
 	if (ret) {
 		test_err("couldn't find extent ref");
-		btrfs_free_path(path);
 		return ret;
 	}
 
@@ -198,7 +191,6 @@ static int remove_extent_ref(struct btrfs_root *root, u64 bytenr,
 		return ret;
 	}
 	btrfs_del_item(&trans, root, path);
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.51.0


