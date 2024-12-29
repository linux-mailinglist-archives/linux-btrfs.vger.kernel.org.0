Return-Path: <linux-btrfs+bounces-10654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB79FE094
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2024 22:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAED16183E
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2024 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02A1990BA;
	Sun, 29 Dec 2024 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Dglwe1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569D194A67
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2024 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735508433; cv=none; b=btho4+W0SRc8IAgifxvtUMfkXsFHmH57RB6/lO8UzzOzt2szWnkcSQbc39nAOofb8REF0ZnB97c5wbLQYgjoNQyb05cELpBG/NOtXaDNOEuppKIinug4MjCt0Dr8nkW64anmZ7UM2U0mpxoCqZWy67u8OF8ycsgla3mQvl3zUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735508433; c=relaxed/simple;
	bh=Wi/6lRpnwG5Cfh+Q4X68bwBXfvOwnUYVsWrNInb4I6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8R+b8gpNAD4mjsfiIVaEt18pe6qN66bFzl8uxaNC6vHdeW6WgnfMsN9v9vxQis4QSrw2YV2fxZdjsqM7dMZyxf1pvc6CyKMJRxP3SD2BthKeEW0TNOfQjIxkbB/Sg39WCKFsK6yOQbKoYc5JixLCaUgird7G4myYkrbSM5mF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2Dglwe1; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844ce213af6so326350339f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2024 13:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735508430; x=1736113230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2yFdbgpOmKBw0Mf9T4s2havKx/dvVoz9mmGFoV8TFc=;
        b=M2Dglwe1WeIzP+eR6l4z+FLYo3bxBueGUYyQG5B84mpTRiwxfgvOeqJEHkhsfr5tK1
         e26IyFJENtxKdpiv1IlOlFMOW7AEqNIfAsmL989jPcenQx0OOgM7gGKLOJ8vRMtzpLqP
         bGd5kScHtdPWuPTbchncKL5n2y+Cb1BBdH91KWvY+Glbh+3CFcqW3SyaHioYwYL6YbAC
         WwlfEclgNaIp2fUFItkDVft3T5W6/NYLr9Avz97H3oEtb+JLBm/HuYdnZYHbV+lCubiM
         ePIE4uFhlIhPvyDp5p6dSGkZmun8BLsxj2VAxy4Bv0qmpda2v4DAopF2olNB36QXYYxB
         bggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735508430; x=1736113230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2yFdbgpOmKBw0Mf9T4s2havKx/dvVoz9mmGFoV8TFc=;
        b=WxK42VO/sI4Rbfm+XGiAL8QuPBjwYlizW63RitpLwnJOeaHyYWPsDaqo8jrtLyC9Lu
         w6U/4H7CFHaqOZFg2GO9seC3F7eNGInfQbq4lSoam1+J0gW/ibZTeTvojM/PtIMbwm1J
         2dqDXNwfFfwnm+fUIMU+wa19i0j1NKGmXfssV/DbvnbGO2jg7vxijSYkcSV13jsBV8M9
         5pVXBV+uwYtFeRIc3NdYLeNVPIVX/jGdksKze6ehXfgp5ohXLjvdIAiXlQvuQRIor1NN
         pwLxQVfraVvczg8GQ6cVAejMDKQm1DwhVcAPlKwwCeiNdqVOU8tZvlL7ajLUfFhYdJPq
         db9A==
X-Gm-Message-State: AOJu0Yx3SB7tXcBgvHHeuBRXbVGiOILMP1VoZX9mWuF8kOCa4F1p+99C
	to7p3m9P+uNlIEsxxyzbH7bvqD6eWsNAihtPf3roDZNqQozhyfXViTW7Ug==
X-Gm-Gg: ASbGncvkB1Ej3Sz0p7iTEvlF9O/ANVi7I9Heu/e3fwet6Pf87cCFYdzK8qU6XNBH3kz
	cE/b01yQxHuDf1C/nr3ruz7+TvVMG1MgqWni0lHxNN7IgvqZcQHB1pSe8ErYMPvSuAT75rgGirY
	MiQCC7ejYnsaqZ4SnrJgDs4jNpBEGcNXgrWw6TlSW6FvRZYM0TVlOB7axwCbnlIMrAzfsXERcKc
	NhupRsi7xR9FRGY9gnIrlye+nmNFqv47SDegCZMJNm6YoiCjaMz5WuFVgOwE5pL8g==
X-Google-Smtp-Source: AGHT+IG1xj7TbakVHKkHYupkEhDA+YPEI1FHX+zq/2AhFa6aYbicv2mtW282VcBAMj7hqcS6S6btug==
X-Received: by 2002:a05:6602:3fcf:b0:835:4d27:edf6 with SMTP id ca18e2360f4ac-8499e4ef6f0mr2779702739f.7.1735508430564;
        Sun, 29 Dec 2024 13:40:30 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d8f138bsm510899039f.48.2024.12.29.13.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2024 13:40:29 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH] btrfs: implement percpu_counter for ENOSPC rework
Date: Sun, 29 Dec 2024 15:40:20 -0600
Message-ID: <55bd9fed5b767365c633bf9aeaed49d335c9498e.1735508254.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

implements percpu_counter bytes_may_use_percpu in btrfs_space_info. Adds
2 functions to DECLARE_SPACE_INFO_UPDATE as well as some logic, enabling
the percpu counter to keep track of all bytes added to "bytes_may_use".
Also catching any errors as they may occur.

This commit is the first for this rework:
https://github.com/btrfs/btrfs-todo/issues/53

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/space-info.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a96efdb5e681..47e74db045d1 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -11,6 +11,7 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 #include "volumes.h"
+#include <linux/percpu_counter.h>
 
 struct btrfs_fs_info;
 struct btrfs_block_group;
@@ -112,6 +113,7 @@ struct btrfs_space_info {
 				   current allocations */
 	u64 bytes_may_use;	/* number of bytes that may be used for
 				   delalloc/allocations */
+	struct percpu_counter bytes_may_use_percpu;
 	u64 bytes_readonly;	/* total bytes that are read only */
 	u64 bytes_zone_unusable;	/* total bytes that are unusable until
 					   resetting the device zone */
@@ -228,6 +230,21 @@ static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_i
 		(space_info->flags & BTRFS_BLOCK_GROUP_DATA));
 }
 
+static inline void bmu_counter_increment(struct btrfs_space_info *sinfo, s64 bytes)
+{
+	u64 percpu_sum;
+
+	if (percpu_counter_initialized(&sinfo->bytes_may_use_percpu))
+		percpu_counter_init(&sinfo->bytes_may_use_percpu, 0, GFP_KERNEL);
+	percpu_counter_add(&sinfo->bytes_may_use_percpu, bytes);
+	percpu_sum = percpu_counter_sum(&sinfo->bytes_may_use_percpu);
+	if (percpu_sum != sinfo->bytes_may_use) {
+		btrfs_err(sinfo->fs_info,
+		       "btrfs: bytes_may_use counter not equal percpu_counter_sum: %llu regular_sum: %llu",
+		       percpu_sum, sinfo->bytes_may_use);
+	}
+}
+
 /*
  *
  * Declare a helper function to detect underflow of various space info members
@@ -239,6 +256,8 @@ btrfs_space_info_update_##name(struct btrfs_space_info *sinfo,		\
 {									\
 	struct btrfs_fs_info *fs_info = sinfo->fs_info;			\
 	const u64 abs_bytes = (bytes < 0) ? -bytes : bytes;		\
+	char *name = #name;						\
+	char *name2 = "bytes_may_use";					\
 	lockdep_assert_held(&sinfo->lock);				\
 	trace_update_##name(fs_info, sinfo, sinfo->name, bytes);	\
 	trace_btrfs_space_reservation(fs_info, trace_name,		\
@@ -247,10 +266,16 @@ btrfs_space_info_update_##name(struct btrfs_space_info *sinfo,		\
 	if (bytes < 0 && sinfo->name < -bytes) {			\
 		WARN_ON(1);						\
 		sinfo->name = 0;					\
+		if (name == name2) {					\
+			percpu_counter_init(				\
+			&sinfo->bytes_may_use_percpu, 0, GFP_KERNEL);   \
+		}							\
 		return;							\
 	}								\
 	sinfo->name += bytes;						\
-}
+	if (name == name2)						\
+		bmu_counter_increment(sinfo, bytes);			\
+}									\
 
 DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
-- 
2.45.2


