Return-Path: <linux-btrfs+bounces-16036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F00B23C2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 01:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71262A17BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 23:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CF12DFF13;
	Tue, 12 Aug 2025 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhIsuXtt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA951ADC69
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039891; cv=none; b=kf6kck7W7E4dqocvwR64RmGjbr44YWfjmCzpmpXUA2WocmIvqWHssOmHxojQOXORrukVI+Hzgl2RlTAnatNwM0abVDlVnk/amDhgjgC56k+/83jluPM/GqdWryiEm6jstt+61zSj3OyuZYJ+t8ZJ8INRZ3RCVO38ryBJ8YZSwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039891; c=relaxed/simple;
	bh=8+iBY87sk/xJpBD8eXplTgQEgDoKnkcfGxPipDgK6Zc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qf06pdLYxG/dBdkgWKJ0sGaThbFMwnwCjpwaW8C1aCc4XWgiiST6JQ2uJe1RFLu7rWA7D6sY7LRgU+B3nziiFmNwxAPi9RDTSben8vtGJ+biL0r8rmy4WjqXXn7x6ym8GXtJ7hN3xNlE7GU/W8ni12/HW7OZHyfLPCSSisTthRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhIsuXtt; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e75668006b9so5993662276.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 16:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755039889; x=1755644689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRQALOreeUuwjA6yDPiY4mn2l2X/NkgIJmyXishejE0=;
        b=IhIsuXttdZxRgN6XN9UxYuRN27WnsJvyjd+2c+CB4Y8NumVTJ1Idjvo9fLROJklP0u
         z1OYB13+WWAAaGipARRQ/rkZX3RBeBw8X2hA6qEyXDW55VD2vgRt0c8n5L+VZwPcPlMK
         bzzxAxt+umWpQp5JHzVrxS5FTzmXNRha3gNHUf07wx7UA4J07RQyYOGtEZLI/03RIik7
         JAngeTJc7SPxt4q6R59KRp3Nx0JlPtXadFS8irh2EQCi67vYyUjgaVvrkQplsQ78WDfz
         X/eBKX2qqEcrY1YWpO7sgCMiBJNvmXsNCWo8+dTWYjoWzp+VziHuqtG5GzcQl7Rz3iwv
         m4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755039889; x=1755644689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRQALOreeUuwjA6yDPiY4mn2l2X/NkgIJmyXishejE0=;
        b=R52+YsGP6XtJTfd/QrsLxP1PrSQCen5/Ehcp+8Qvpq1zjNjOHdj1y2JOkzvbx2HcPW
         zJUt5Xu0pIYtaXb8SLhlPruFhIJQWCwJ6MOtieWAk+ahf5n9gX0W7WemDtROkelZ2M3F
         JKY1kXulzm6aS3r9Lw5YzqvxgpsLYhre5DrcR4QLCRCdo9HAcMzAhcGlqalXgEEnM9WX
         pxfalTZ/QYLTuBQyRgq/XiFY33gkE2W7A09Ti5quQdrLWIrY9UB4Io1Ot19yBmsSJKz6
         hvAGXxdxALFyeWZD+ELLaZJ7EJ74oEL3q14tB19UXdTJhIIuEaUt86g0UOIA6ubO12M5
         r/DA==
X-Gm-Message-State: AOJu0YwC0pqfLeuPNhurQwcB4V0vBsw0Nwh0bwUoOMlyjoN6NjGxTJPc
	O8yWVqzA3KKPEYoa4EVyI++1KxucIPQCKQyJogc7enVmtyJBtNqbXSMZI3AsmU1f
X-Gm-Gg: ASbGncvF4M+JTekG6Fxj3XttyLZ1QwscjWeIbkztrhomIIbGjFHQM1IYwBRRErymCQ8
	P4pXi1HKdiP8MrmZOk4G84WyVzs3suCgNXqsEgYpaXf2poU7Lup0h5tPFV/dRUsnsZVTwYL0uiR
	bJJ+rnvH7pN//l483euh9+AEFvTLXRBj7KiMXvbw8SjuifmgVjq5amp8IwOZoZ3p559VPilJsyo
	w7puvT1RRq/IGkK09SX7cq1r7PGD657O4aeoUS+xeZSGVONNiO2lpltATREGpaIuFT1HcagVkH7
	vLS9tbgCZx/TmU8QnwuFQUPTMo5TL8p7bQ6KDKIh2BWS157SdBlV2bYFaroZqJEDstP8/eOR0OB
	DCLOQtdQJbyq1PWWe9Q==
X-Google-Smtp-Source: AGHT+IEysykDKlnutqNfzae4yaGy2FpjjF2FjOTkiXIu/iGm5i2YWA/VVeiETN1mi4nQVvK9KJHasw==
X-Received: by 2002:a05:690c:4b08:b0:719:feac:bb8d with SMTP id 00721157ae682-71d4e442259mr12778167b3.14.1755039888911;
        Tue, 12 Aug 2025 16:04:48 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a59a94bsm79158567b3.55.2025.08.12.16.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 16:04:48 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 3/3] btrfs: add mount option for ref_tracker
Date: Tue, 12 Aug 2025 16:04:41 -0700
Message-ID: <39849fd40008e0eb7dc295752f89a1d3080fdc65.1755035080.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1755035080.git.loemra.dev@gmail.com>
References: <cover.1755035080.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a mount option to enable ref_tracker.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/delayed-inode.h | 15 +++++++++++++++
 fs/btrfs/fs.h            |  1 +
 fs/btrfs/super.c         |  7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 651cefcc78a4..0a827701e469 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -198,6 +198,9 @@ void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info);
 #ifdef CONFIG_BTRFS_DEBUG
 static inline void btrfs_delayed_node_ref_tracker_dir_init(struct btrfs_delayed_node *node)
 {
+	if (!btrfs_test_opt(node->root->fs_info, REF_TRACKER))
+		return;
+
 	ref_tracker_dir_init(&node->ref_dir.dir, 
 			     BTRFS_DELAYED_NODE_REF_TRACKER_QUARANTINE_COUNT,
 			     "delayed_node");
@@ -205,11 +208,17 @@ static inline void btrfs_delayed_node_ref_tracker_dir_init(struct btrfs_delayed_
 
 static inline void btrfs_delayed_node_ref_tracker_dir_exit(struct btrfs_delayed_node *node)
 {
+	if (!btrfs_test_opt(node->root->fs_info, REF_TRACKER))
+		return;
+
 	ref_tracker_dir_exit(&node->ref_dir.dir);
 }
 
 static inline void btrfs_delayed_node_ref_tracker_dir_print(struct btrfs_delayed_node *node)
 {
+	if (!btrfs_test_opt(node->root->fs_info, REF_TRACKER))
+		return;
+
 	ref_tracker_dir_print(&node->ref_dir.dir,
 			      BTRFS_DELAYED_NODE_REF_TRACKER_DISPLAY_LIMIT);
 }
@@ -218,12 +227,18 @@ static inline int btrfs_delayed_node_ref_tracker_alloc(struct btrfs_delayed_node
 						       struct btrfs_ref_tracker *tracker,
 						       gfp_t gfp)
 {
+	if (!btrfs_test_opt(node->root->fs_info, REF_TRACKER))
+		return 0;
+
 	return ref_tracker_alloc(&node->ref_dir.dir, &tracker->tracker, gfp);
 }
 
 static inline int btrfs_delayed_node_ref_tracker_free(struct btrfs_delayed_node *node,
 						      struct btrfs_ref_tracker *tracker)
 {
+	if (!btrfs_test_opt(node->root->fs_info, REF_TRACKER))
+		return 0;
+
 	return ref_tracker_free(&node->ref_dir.dir, &tracker->tracker);
 }
 #else
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 8cc07cc70b12..2052b7ca86b5 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -243,6 +243,7 @@ enum {
 	BTRFS_MOUNT_NOSPACECACHE		= (1ULL << 30),
 	BTRFS_MOUNT_IGNOREMETACSUMS		= (1ULL << 31),
 	BTRFS_MOUNT_IGNORESUPERFLAGS		= (1ULL << 32),
+	BTRFS_MOUNT_REF_TRACKER			= (1ULL << 33),
 };
 
 /*
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 466d0450269c..840b1eeab993 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -130,6 +130,7 @@ enum {
 	Opt_enospc_debug,
 #ifdef CONFIG_BTRFS_DEBUG
 	Opt_fragment, Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
+	Opt_ref_tracker,
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
@@ -254,6 +255,7 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	fsparam_flag_no("enospc_debug", Opt_enospc_debug),
 #ifdef CONFIG_BTRFS_DEBUG
 	fsparam_enum("fragment", Opt_fragment, btrfs_parameter_fragment),
+	fsparam_flag("ref_tracker", Opt_ref_tracker),
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	fsparam_flag("ref_verify", Opt_ref_verify),
@@ -629,6 +631,9 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 		break;
+	case Opt_ref_tracker:
+		btrfs_set_opt(ctx->mount_opt, REF_TRACKER);
+		break;
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	case Opt_ref_verify:
@@ -1140,6 +1145,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
+	if (btrfs_test_opt(info, REF_TRACKER))
+		seq_puts(seq, ",ref_tracker");
 	seq_printf(seq, ",subvolid=%llu", btrfs_root_id(BTRFS_I(d_inode(dentry))->root));
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
 			btrfs_root_id(BTRFS_I(d_inode(dentry))->root));
-- 
2.47.3


