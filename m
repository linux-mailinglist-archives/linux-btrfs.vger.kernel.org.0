Return-Path: <linux-btrfs+bounces-7574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3A09617C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326141F24F09
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF71C1D31A7;
	Tue, 27 Aug 2024 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpANlsPn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABFF1D2F59
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785794; cv=none; b=CkYMLXg3XVGgYmBAQiAVPu9YYVE6mIRIloYmzLqoMteNLrdxM6cmqQmZr7fu9/Acb/FWTB2bdtTcmmgNDjst0LK2YYPfTCfAurjC9A6UqAvFAxFrXhtJ7Dc3X/V3J0nvzTVhimoF6NXNyIa6o7mDzsBjizqCJjs5A5K4uzMGEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785794; c=relaxed/simple;
	bh=p0R3WE1n5q3lMm+T+FQKxcinl39PlriMO7ne1Qrrfjs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBdXQkdS74emuusTkvp0lC+1YRN7kIK6UmFXMOG73Nt86/TtKE6ZiwoMHJoIguzW70u4Gpu32uRYsGFjOvA94ujTd1tDmlnxmmEC1NOwrgv1/57kpX9LomrCjFti3iOCthVejeBS01uGsY4ZHkWPcvnks5s/x5QWhccjToHMsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpANlsPn; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-273cf2dbf7dso3909245fac.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 12:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724785791; x=1725390591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6s4Luh0slZ6wNtyYxvhQo3FjBvwG7y7hvkIDgghHWk=;
        b=KpANlsPnhq0zSSV6YzTkASNmNri9yp/Krqgk8ypzYhEsBjnBK27KOIn8avjphqbudx
         0TUAh30AOlL/ebZLTSZOm56dTkmI09d2y5WLoG3p7Vui0xiGXP58WUQo73/426K6OLhx
         cTX51BmA+lHwOdMnYdd1wjnwb/f7KIS0EIxHO1XI99J6V1tCPGdSsMeH7DhdSmZH+/fX
         YbWDl2WNCdSJwhp9aWbHw9AUK/RNkb8IGp6vtUcdXVo/cfCSUeAzMrKJ5bz2S+4O2AZP
         lkRRewPOMrJKUkv0ML13l85QMvBmgrglFC7phnBBAhxwJNKQmlXmKPxnA6yeQ8dtqYBd
         jwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785791; x=1725390591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6s4Luh0slZ6wNtyYxvhQo3FjBvwG7y7hvkIDgghHWk=;
        b=p6rt7HI57Yy4Su0Y/uI83SZRNZ4Co9auocqFMH+PqmusrDhiF8xHM3BRY0EwXBVWo7
         ZSTFZPYN4HgO5Dxokf3gcj+iFd13fjwMfNETdoRPsMpV9LlhvYC2q9fOSqNYBGn0EdLu
         96mQbIBtk41rImpoQunObYt1jRsXEXsfegT5G98Lq9/HtaqZjP4/3ZI5lpOQbmr/BobT
         0T5y4h9/wKOzZ5rqdMAuwJj93ATQuaXN2r+LfLlYEzdW2D2kRE6johxg5mrtgXeC7mfx
         Fz5coSsuwe+36X/7SK3KxI0pjACqxG/v/7nSiOIaanEzjHk9n3JgnWBDb5SI1VoDMU8p
         UzfA==
X-Gm-Message-State: AOJu0YxtLOqj2EwcXnZ4HbwPFSmnTt4PXwSG2MoccxNtPhPBIu8Z6QfF
	tPqmuQPxbvNBM5v2k1kJ1AbZTAaTN+WJztEKQWprvff7BjbgZZ3RO3RleNx/
X-Google-Smtp-Source: AGHT+IFs9St8I+NKSuD6cQgJQa+QMWnL5whsRNg21bPB4v/GYhbFKVIOq9NeuE5ndXgAyXMOG2vacw==
X-Received: by 2002:a05:6870:2250:b0:261:142:7b95 with SMTP id 586e51a60fabf-273e654b961mr15939154fac.25.1724785791414;
        Tue, 27 Aug 2024 12:09:51 -0700 (PDT)
Received: from localhost (fwdproxy-eag-003.fbsv.net. [2a03:2880:3ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-273ce9969besm3257884fac.7.2024.08.27.12.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:09:51 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 3/3] btrfs: BTRFS_PATH_AUTO_FREE in orphan.c
Date: Tue, 27 Aug 2024 12:08:45 -0700
Message-ID: <b5ac0f327ed18a0b6ca9f7d22f3964ff3e1480ff.1724785204.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724785204.git.loemra.dev@gmail.com>
References: <cover.1724785204.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add automatic path freeing in orphan.c. This is the original example I
sent with only one exit point that just frees the path.
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


