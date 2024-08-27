Return-Path: <linux-btrfs+bounces-7594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CCA961A1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 00:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C296D284DA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 22:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB21D45E9;
	Tue, 27 Aug 2024 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOfoAFqj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82B1D4176
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798531; cv=none; b=ECOpl06nGTIHSVafmmWVAjeO1Kn6b42zALDHFEwRAZ3veYACpxwBurH8u3g/HzcrBeQkqnGabQ3Xw/GhU2yg8T5iwFoA0igRRY+wxN8EgEQ6HoL1db2nzkW0revi0eopQAffk9JVRdGBJGZB1yQ9TLCnRGkgA5OsSuWZOc+izPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798531; c=relaxed/simple;
	bh=6NTy+cJ+N43dWLYCSyY6RnjCrKuROVBm/lXfHsAcK3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkzWFQrT/ZmmniNkAYwRLV9Xp5eQfs3K0r5EeptAstkRBkjlCvXOBEEEmqTWeMtFVRXcw/xB0tLvLFxJRUhbM3zr/87X13L6jX6BeSKm/Pm7PRsJ7ib0WUVcpYIhMtk9wBP8usG9Vnn0HCUHGXcGLiKkRgYyEePHb1i+hs3/t2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOfoAFqj; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-709345dd01dso18374a34.0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724798529; x=1725403329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Np7nLR6uDtfwcAnCN5f5QshCByGw+rq1Q6DA5mSgak=;
        b=iOfoAFqj1iLuau4aPMT7TjXyUCj3PUo61kAAq7e2rFE5DPTcNNBQSfu8i15ZdCSyUV
         aDglb6uIzTqZqoivlrgr9minnQdzZeO0Dfbt+4J8E+Qlaua5KaNYaJQRI3dG9zQUxw63
         QmgXHb11N+H8NGeg/C6tbt/Dvj/Ajtb/yY199K3WV4akN4JCXGoVDRH+gwyFmZoDWCPI
         iZNzxuTj583fpzivNkjuKxw55QCEvxWZjzdxoP2qJaL9lh1Y+U6JM1FmardUwij5NjV6
         43c7A2FqAPoonNwTUfxrUUmx7CPQyHwc7Q4doY20RkIrdEMLVSoTTaTTOs8ghLSmqACH
         ss9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724798529; x=1725403329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Np7nLR6uDtfwcAnCN5f5QshCByGw+rq1Q6DA5mSgak=;
        b=icBI8BS6m/FQ+zy//wdT/gMKw1cMjw0tHLIU/W+8OZfqxSYO3IMEbDn0N21p+IJpff
         IYHns1HV9BG19T8O1yCoQkSYRgcUdiMrDQ9P1FQ05b3ZT8+NpP5Zo/TnLYB0vcbXhquW
         ocwZZtB8qe0Ipl8yYGsbLmqdRs+hlktCDXJfmvRIzApylwyVnFep9TgFca1GK9N99O+6
         AvKOXdyftcn1EVqVJIdwY1RrFBl5Q5BmfBm2XdWBsXB0PDP+ydyg0RXZyNNzclKLQJQr
         cLRPIPg8k1zyrBQxhFuspHOHWVzMZwFTTo5/LeMKxdOAz73ZmZLWNOZOMqCccZDJzOV2
         IFMw==
X-Gm-Message-State: AOJu0YxvZZaN1LKGhA5Xjkjk0HuYJrI8W6xTcyjuAijcP4jjGhvCQ/62
	ESDcguqjJ0dd9IKpEbJ1ugUFYPI7fhQFtLUwy054DddbB/AktS85TdLAksGh
X-Google-Smtp-Source: AGHT+IETUMiFDVnWgma/Bjtw5dI7d9HxTOPcg5cd/iGBN3sUhzwvkrNeKNtSauFpIXNx30qkywBdRQ==
X-Received: by 2002:a05:6830:720d:b0:704:4bb7:c99a with SMTP id 46e09a7af769-70f530fd386mr136936a34.0.1724798529343;
        Tue, 27 Aug 2024 15:42:09 -0700 (PDT)
Received: from localhost (fwdproxy-eag-003.fbsv.net. [2a03:2880:3ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03ab2a50sm2597017a34.35.2024.08.27.15.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:42:09 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 3/3] btrfs: BTRFS_PATH_AUTO_FREE in orphan.c
Date: Tue, 27 Aug 2024 15:41:33 -0700
Message-ID: <e6c1661801a41ffca7e229510b4b53b55042c741.1724792563.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724792563.git.loemra.dev@gmail.com>
References: <cover.1724792563.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add automatic path freeing in orphan.c, the examples here are both fairly
trivial with one exit path and only btrfs_free_path cleanup.

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


