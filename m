Return-Path: <linux-btrfs+bounces-7799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942196A663
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 20:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAEB287515
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 18:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF8B191F87;
	Tue,  3 Sep 2024 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHz3ZkFX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8719049A
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387645; cv=none; b=sp3FVFx04RtmkPHWYJmEn6bVtbHoSv8/z5lyWOc8ZJJSoqtSRE+f7w0auuyT2p4+M/NyH63wAXi+46RkavInCrB0cWIYV3XAaXPTDGDLL72P1/av410SEwbo6dC1mjsXoFdaE8UR5Gt5APBtiRNhS64qHFURvkbuxSkTUu8GlPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387645; c=relaxed/simple;
	bh=F3WcvyarbdcxXh139dJiwZQLtINRpGwpI8oJ58bsUx4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el8siDP27QRUhsHh3gsLq9cC6Mwhv++Ekul0BR2lSWuqRWjSSnAIhfHAZV+xw6k2bdQJg6VjmnTd5PCoLlkNh9BUGBz7eMmKDZdMpQ8m900rn8ffv2WlxFYPjCoi+Jy54aF4QQh240pRx6cpLLqkpPrQ0Q+4U0VNPqCAxZWgtOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHz3ZkFX; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-5dfabdbef52so3409530eaf.3
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 11:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725387643; x=1725992443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSIxUUvYsoFTAOhFnt0lkEKCTZvWjB4z75D8ZsPY+WY=;
        b=BHz3ZkFX4X0Pp6hDvMGldRVf42H6IDeoumozo8tNHLgnhboJYmiSx9Kh1gXzVUIKzl
         7meaxvAx1v9GKnH2rlKidcfWZOKIzmRitFRuSQVZXpTydBzCatg6mh0dkrv2my7cn/D0
         FH+Jrs5oOPId3AwKX5hsZmbtXzVTwdpF84qn/MQWkmS9x22z14lexl9L91YZyTUgLkxy
         fZjNoGX3ZWcCcj1peyXyCdskuyaEQORhOrKMW2VqdMvrNi2/CgR/UE+EOZPsQpBLqiK8
         7c6eQ1eFRpsgN8dBhHAG9RpKBFNhDhNPPChSPE14qVbY/ssNnXmqjtr2QJdQ8NKFtr6L
         WnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725387643; x=1725992443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSIxUUvYsoFTAOhFnt0lkEKCTZvWjB4z75D8ZsPY+WY=;
        b=EfRm28Pj/qZ5YJGEmv4cKCh92hGc90ISpbAiC0Yyby1mVZyxDy9ml/SYoiL0OCo5/Z
         vOgEnk3wOeDFnLmKzvOtufudO/AxCs1u4y8YN/vXjUJUEKUFBD3FfUlkJTGx41O8hmPD
         qv+ISM8vHJTJ/UKfyQ+EbTUQqML4FavVZKpiC+Va4N3YGn4MFsdeJqiyKu1A++LbdGHY
         YnTb4GDYbjZdJq0A8ZnCH5JlZGBHLiFvoNAitl3X83dDATL3rXMYhgLDDUKPWiPmT4lz
         dRm7dEoaLvqOymWmTO27itmXqDShuIWw8X8VGSpgM4GD2FnHk//SUI3e8FvzlqefH/zO
         gGjA==
X-Gm-Message-State: AOJu0YzURP9hndwHSwnwZ2WdoRGI6PZhzD8/xTLSv2Yny8yALLl+Qw3j
	tKFLs08ZRr1UFobacS6fs3dgtpCH3fpPnsgLpHuQ7IA9Pq/6jj9NzJeDsvCs
X-Google-Smtp-Source: AGHT+IFda48M6MjUmhcKB+3SapB1RXVpY0Pse4NVBzVD38bkHgdEpICKpN0G2G/zEzXoCymKNbkaEw==
X-Received: by 2002:a05:6870:bb0a:b0:270:129f:8e65 with SMTP id 586e51a60fabf-277ccdcfcf0mr13458955fac.34.1725387643275;
        Tue, 03 Sep 2024 11:20:43 -0700 (PDT)
Received: from localhost (fwdproxy-eag-002.fbsv.net. [2a03:2880:3ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2781de54113sm451046fac.48.2024.09.03.11.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 11:20:43 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 3/3] btrfs: BTRFS_PATH_AUTO_FREE in orphan.c
Date: Tue,  3 Sep 2024 11:19:07 -0700
Message-ID: <069451445e244bf95904afb9fdad35d9309fb55f.1725386993.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1725386993.git.loemra.dev@gmail.com>
References: <cover.1725386993.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All cleanup paths lead to btrfs_path_free so path can be defined with
the automatic freeing callback.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/orphan.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/orphan.c b/fs/btrfs/orphan.c
index 6195a2215b8fe..696dbaf26af52 100644
--- a/fs/btrfs/orphan.c
+++ b/fs/btrfs/orphan.c
@@ -9,7 +9,7 @@
 int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 offset)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int ret = 0;
 
@@ -23,14 +23,13 @@ int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
 
-	btrfs_free_path(path);
 	return ret;
 }
 
 int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, u64 offset)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int ret = 0;
 
@@ -44,15 +43,9 @@ int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret < 0)
-		goto out;
-	if (ret) { /* JDM: Really? */
-		ret = -ENOENT;
-		goto out;
-	}
+		return ret;
+	if (ret)
+		return -ENOENT;
 
-	ret = btrfs_del_item(trans, root, path);
-
-out:
-	btrfs_free_path(path);
-	return ret;
+	return btrfs_del_item(trans, root, path);
 }
-- 
2.43.5


