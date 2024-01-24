Return-Path: <linux-btrfs+bounces-1723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D506C83AFE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16EEB2D9D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC1C129A60;
	Wed, 24 Jan 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jmTacTCM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA79128399
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116805; cv=none; b=WTCEXjr7jQCoGWuzk9UFd9vg7O7TH6rqC/Zp3m0K/kZ8Ni7UkUW3B10HquCnpOAlT1xj/PYVVmQUzwNqL68TqhYMQs6JPGHeg+9Ewy2iW46A9uy1zWjPChyT/YnIA7WqTND3CuLEBRk/ZMKuD4eXM2KGb4iRS+SeRi8a3Drw+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116805; c=relaxed/simple;
	bh=fonpqmZLmF4h0WfFK8NQtkdaGG4GMuivfti+cunM6fQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+IOxXF7G5q0XjoBw8f15fhwLjJPzhSOwrUAS1XTeP6vzlRlD9Vl/DSlvC/Syd4nTBwWBQHxXs2T/zvtY0vQjkZnSf5yKMSBi1CvT/mXZb207cqvt0rz5ILZYmAxwGAcc+xaFl4OYfsphnB7bmrtz66Dmc6mwdhRxCRn91ZcXW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jmTacTCM; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbed179f0faso5173029276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116802; x=1706721602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EkQomOIBdhqYXirHEDAB1AmrGwt8q/ZQPW8iaM0dwI=;
        b=jmTacTCMuwzQ9YpNFVCbiXonM7yZoLzgqPx3ltbjZzRMbmMr3Uog+PzJyS9eB/ggMb
         rWAMUFVhfJk+n10fbdOCe2UdQ5vA38g3dhz6jZc3STAvWAT/1ILm9DmaaS4HRxKeGVid
         cTrjnTwWi3hUleud9DVarFYemYgKiZ0gXmT5yq03tGVo1kVth3zpNKUVW59K5QuWNgHo
         1Zor03mDsBYCuEohbdUlhJGPPuwKKvEJe0tnrWxRBvFmm1pHO5BIko2ye634IqQ5D/0r
         8HbvU5goAZ4j1VHyb6z/+Hb/jHUgd7VhbV3Kpyz+w6ZQuLl9i2O3Ai1YU0AnJ/gXHAr7
         2Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116802; x=1706721602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EkQomOIBdhqYXirHEDAB1AmrGwt8q/ZQPW8iaM0dwI=;
        b=OX8r11dmwo/A8fKJ0tXM4g5rWT1wgBpTJnPIu8LxziKuQKbjOx3u+nUlAjkWLeY5NX
         VF5kCLHnWpvm1TD0iyOrqnu2VHA4MZISdtfBmJflHIGmQlrTG2kL5ufAQuB9yhc7CYrH
         W8jCvD6y//Xn8rvcbWcrTSzu2KN7D0KUONUap9rIAO3X+1JVgeDs3gt/hfQrzL5EhY/q
         /6WApzjN3JcSULEdgXOuAYrOBksHV/Y/hvTQODIeYdNurAtm+lYy6tRQpM2iKEYd2kxX
         AdF+FaMuzGbetB4CaJ4ikSjc/DBuYzY5FOieC7k0Uj/LowVKKakAOcS1t/+m1cR94MCa
         CAkA==
X-Gm-Message-State: AOJu0YwlOfTmMLK2sSaarehAPjo2mS5Ltdd1miTWg65wcD1Zo0Kuqb3N
	bw7PSxvM1dgMRKi5ygaSlaQO3DZ5sMJ3YinHRgxqIEdLd7HI2kYYeBr2aG7TRnFJuAXQnoKN+SN
	+
X-Google-Smtp-Source: AGHT+IHrGKYOaReNcz61RHI4RreLgS4fHbommpSq/csbJFrfvavU98WKHe3LIYbpTrRLh8AN4IYADw==
X-Received: by 2002:a25:5f41:0:b0:dc2:65ea:3fec with SMTP id h1-20020a255f41000000b00dc265ea3fecmr797365ybm.38.1706116802536;
        Wed, 24 Jan 2024 09:20:02 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j5-20020a25fb05000000b00dc23059cbfasm2860147ybe.42.2024.01.24.09.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 42/52] btrfs: move inode_to_path higher in backref.c
Date: Wed, 24 Jan 2024 12:19:04 -0500
Message-ID: <49adcdd81c9a110d03e2ab33e919e0c922c9dd09.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a prototype and then the definition lower below, we don't need
to do this, simply move the function to where the prototype is.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 69 ++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index beed7e459dab..f58fe7c745c2 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2578,8 +2578,40 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 				     build_ino_list, ctx);
 }
 
+/*
+ * returns 0 if the path could be dumped (probably truncated)
+ * returns <0 in case of an error
+ */
 static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
-			 struct extent_buffer *eb, struct inode_fs_paths *ipath);
+			 struct extent_buffer *eb, struct inode_fs_paths *ipath)
+{
+	char *fspath;
+	char *fspath_min;
+	int i = ipath->fspath->elem_cnt;
+	const int s_ptr = sizeof(char *);
+	u32 bytes_left;
+
+	bytes_left = ipath->fspath->bytes_left > s_ptr ?
+					ipath->fspath->bytes_left - s_ptr : 0;
+
+	fspath_min = (char *)ipath->fspath->val + (i + 1) * s_ptr;
+	fspath = btrfs_ref_to_path(ipath->fs_root, ipath->btrfs_path, name_len,
+				   name_off, eb, inum, fspath_min, bytes_left);
+	if (IS_ERR(fspath))
+		return PTR_ERR(fspath);
+
+	if (fspath > fspath_min) {
+		ipath->fspath->val[i] = (u64)(unsigned long)fspath;
+		++ipath->fspath->elem_cnt;
+		ipath->fspath->bytes_left = fspath - fspath_min;
+	} else {
+		++ipath->fspath->elem_missed;
+		ipath->fspath->bytes_missing += fspath_min - fspath;
+		ipath->fspath->bytes_left = 0;
+	}
+
+	return 0;
+}
 
 static int iterate_inode_refs(u64 inum, struct inode_fs_paths *ipath)
 {
@@ -2704,41 +2736,6 @@ static int iterate_inode_extrefs(u64 inum, struct inode_fs_paths *ipath)
 	return ret;
 }
 
-/*
- * returns 0 if the path could be dumped (probably truncated)
- * returns <0 in case of an error
- */
-static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
-			 struct extent_buffer *eb, struct inode_fs_paths *ipath)
-{
-	char *fspath;
-	char *fspath_min;
-	int i = ipath->fspath->elem_cnt;
-	const int s_ptr = sizeof(char *);
-	u32 bytes_left;
-
-	bytes_left = ipath->fspath->bytes_left > s_ptr ?
-					ipath->fspath->bytes_left - s_ptr : 0;
-
-	fspath_min = (char *)ipath->fspath->val + (i + 1) * s_ptr;
-	fspath = btrfs_ref_to_path(ipath->fs_root, ipath->btrfs_path, name_len,
-				   name_off, eb, inum, fspath_min, bytes_left);
-	if (IS_ERR(fspath))
-		return PTR_ERR(fspath);
-
-	if (fspath > fspath_min) {
-		ipath->fspath->val[i] = (u64)(unsigned long)fspath;
-		++ipath->fspath->elem_cnt;
-		ipath->fspath->bytes_left = fspath - fspath_min;
-	} else {
-		++ipath->fspath->elem_missed;
-		ipath->fspath->bytes_missing += fspath_min - fspath;
-		ipath->fspath->bytes_left = 0;
-	}
-
-	return 0;
-}
-
 /*
  * this dumps all file system paths to the inode into the ipath struct, provided
  * is has been created large enough. each path is zero-terminated and accessed
-- 
2.43.0


