Return-Path: <linux-btrfs+bounces-15916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08A3B1DFDD
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 01:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CC76279FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 23:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7FC2701DF;
	Thu,  7 Aug 2025 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZkgNkhw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2226B0B6
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754610848; cv=none; b=IBGq++ILNDFEdkeMeYZUGDvLZnv4cD5TXJdv9hvWKN88ZqMQUlXxxiykSAxNlK7qc+McYLu5aDjAmhIA3UxMgg6PxaCJ6ISSXB28f8yMaPFxBQxnx0OTvvHbn9lZdojinNvwonEobLbAyqR6X52x64wMeAyrnzMVSzjsScPGlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754610848; c=relaxed/simple;
	bh=adxsNP+HrZDYzmRYaOLKPjENeqlQ+oEgLEBZHS/e+aM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuKG4xyILBddjHtoRIelxV04fVxoBuO0dUwBD22kn4WATFOPYuPeo1fxOAagmuARTMn7pnlK1QkYA4XMoxjpwgBE/4IsX1TC5tJwJ8Qlzebpnk5svzcXjdHsPqEQlUou1+iSmgJrr7Kbr1c0M6lH0GYNIsHgE7UhR+Yq8No185g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZkgNkhw; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-71b4fc462ddso15022857b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Aug 2025 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754610845; x=1755215645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRvOOhWiY37uKJ6n2yJVpnnaVGpc2r8fH1s1Q+dOyNU=;
        b=kZkgNkhwcYlwMr66QKIvvjCLNM2kxQItBo5GbzgEarDMZgMHMIiZW3aXVNUq1cSf7K
         YLy/uXpkvieWNeUGx9c30jtxSrKRTYLpOZSbKOiTPy2PUoIjbKxpe6gjAs3wYeYnRlQ7
         uCd8/f9m0kKJG4v8spwnhCcXLjYqW3FTCoL/0mlBjVYcQvgRYg5Cjn6SahXSj0dS4ZQf
         rjUYfRzkvXmFgxCDvw8ahu2+rRNGlYg2vAxLz3CkGchhYw6OPepjEx30ciQrvre6kBfS
         WgW6n0zU1JuYqJo0KbZ9ZzfT5M+RUTJYro3OFdWiwmJfCg2NjuUWa+lUTqr9kdg1T9Do
         c0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754610845; x=1755215645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRvOOhWiY37uKJ6n2yJVpnnaVGpc2r8fH1s1Q+dOyNU=;
        b=BTGXIk/UECduD1VtoiL8uuQ+lD0W73FwHFLElF+CYgFSSo+LSVsNNIn8xefvxCkfbA
         LxEPxUUGNR+cZWAbS0/CJv+eRHPbJUGcxijQfCY86zWPkKOvT5+roJPMHaqEbdGbdBCV
         Tt47vmvQkXZJ2kmsX6JHHUaI0m7rVi0D+Njr4YngoeRy7NrRVyzweXcsqxBQ72IWAhxZ
         UJWZ+Yko+BGiDLVCWDwq1VcJCGvKQH/3/NXAmi6YJNbo63uaFUqz6H0+G6UsL1htq8pJ
         Fp6sBKGVhNpp3fzTz0QocBZKaE9R/JNckVJudIFxBLZaKAm6mrYJF85V/32c9EI+mHUU
         WEfQ==
X-Gm-Message-State: AOJu0Yw8vgyLoqj7uJY4IuW30sobmplhcyNJ9OJP3j0Wp7SHbD/PQPQc
	xc4NOHN5ALzyL0FJBckQG9LT4NMPl1ko9hFP8Eqd1bDltm36E8gIEkeSmk7sDRAJ
X-Gm-Gg: ASbGncsXojLXXcWOaEUMm6DHFMHH/b0jlcYgglHwoz7UPOBL9m1zK6m2Vmk7R93KDsc
	zuxrvfBPqbLZnezLK230/UmwFgVRLh0i/O6/XE/rrq2U7DT9fPB3Fw4U5FIfsRRTMNCMVBkBUSM
	nRsybDKE1Euhm3uRs0P9uuakBcO8noGg8VNt5nzV7DRteXXgkvlfqbcGqxQTfbe0PG+nx7y3Jo1
	UIcrreWg1U3RKPx8EuR+WGGjqQblChxjTYvAHaMF010DGpaevJXeQcYRfscqG+K+4Wg7ZlcHMmV
	Ej5ApG7oY0cAtSXapyG5iWOnOcN7hw8MS8VPGRWvUZslMhxeZIEm9fn4/BqWk21uRj5jhb1nH/B
	IpX3vUMHqEqbDGQpfIA==
X-Google-Smtp-Source: AGHT+IHUSa+TT4E8/eEbzYI/cEILEK2YYKPg+HzsWd02uuH4C5J7Ej92cXAJBnDKDiWR2vkV9EgtrA==
X-Received: by 2002:a05:690c:6a0d:b0:71b:cdf1:ee12 with SMTP id 00721157ae682-71bf0ce3093mr13315817b3.8.1754610845185;
        Thu, 07 Aug 2025 16:54:05 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3a9110sm49450037b3.4.2025.08.07.16.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 16:54:04 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 3/3] btrfs: add mount option for ref_tracker
Date: Thu,  7 Aug 2025 16:53:56 -0700
Message-ID: <1c361c4cb5db3497830185390bc12f7f27ebd216.1754609966.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1754609966.git.loemra.dev@gmail.com>
References: <cover.1754609966.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a mount option for ref_tracker, mirroring how
ref_verifier is setup.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/delayed-inode.h | 15 +++++++++++++++
 fs/btrfs/fs.h            |  1 +
 fs/btrfs/super.c         | 13 +++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index d62811db2a38..e1c44c4499b6 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -198,6 +198,9 @@ void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info);
 #ifdef CONFIG_BTRFS_FS_REF_TRACKER
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
index 466d0450269c..924a6e5e7348 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -133,6 +133,9 @@ enum {
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
+#endif
+#ifdef CONFIG_BTRFS_FS_REF_TRACKER
+	Opt_ref_tracker,
 #endif
 	Opt_err,
 };
@@ -257,6 +260,9 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	fsparam_flag("ref_verify", Opt_ref_verify),
+#endif
+#ifdef CONFIG_BTRFS_FS_REF_TRACKER
+	fsparam_flag("ref_tracker", Opt_ref_tracker),
 #endif
 	{}
 };
@@ -634,6 +640,11 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_ref_verify:
 		btrfs_set_opt(ctx->mount_opt, REF_VERIFY);
 		break;
+#endif
+#ifdef CONFIG_BTRFS_FS_REF_TRACKER
+	case Opt_ref_tracker:
+		btrfs_set_opt(ctx->mount_opt, REF_TRACKER);
+		break;
 #endif
 	default:
 		btrfs_err(NULL, "unrecognized mount option '%s'", param->key);
@@ -1140,6 +1151,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
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


