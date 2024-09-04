Return-Path: <linux-btrfs+bounces-7831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF3A96C87C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 22:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1664B2494F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 20:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C57D1E6DEB;
	Wed,  4 Sep 2024 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="W7+VAd2z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E57A17A938
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481773; cv=none; b=VUBgS40g5PfdVsCrDSRO1fv5VVigqeO5gweaJFN0B9u/vl+uy5EkFT+q8hB4WW3EKR78V4JUnDbMCJqEG7AecAeVa9S8fwr5M3FCK6h8QihPnL/bUWICJWUaifNhSAGWtdJi/yFoUtj3nIejMEfs/qPMD2SyX083uyg3QEDx4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481773; c=relaxed/simple;
	bh=QlPOWd3iqjsIDqhqpz2rf1gaW/Uhb/TerJwERWAiY3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcoy649qxkGcdViV+uINPpD6XFSQwfN2HBsiy6OCMYEHsYU+15e+yHiq7pHDtiQf6XFgCcTJDATADsRZJXksxckg5TQ7uFpLN80ToQRyxk5oKJForCgBKexvVkDIiej2RDB16aYJXN2+X92k/QiLmhKjyXR2Q/Zhj3H2v+YSyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=W7+VAd2z; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-456930b923fso262831cf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2024 13:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481771; x=1726086571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLbVQD1uWq7E7syR9oa0FyZv5hSgj9K2/YM9COMKj/I=;
        b=W7+VAd2zhTuaLEIoKFKndej1xjJTTgW/Viom1qgzEn3LuV1J5W+b5lGcmDrmfoTaVi
         Laa8iWBCAA3WfOtrWB/ioQtBCDCchs0jpIzpfxLE9AvwM/SeNisfVLWK0AeDBTgV/8p0
         seZ71gsj1HJ5VH8+iMX/BUjKLkW9M7Hd0L2ntjTuucRkN3/HZgujSjfLmALIUsNeoSWU
         RnrDfA7Vg0qq3HtiQGvEFarppxzSscN3njQmY0CzicN2T1txJELsKETvAowsiwsa2TY4
         0xChFONx/kuecJTuEFgzg5iSZ3yyB6eDLLTDpOq6qE+sxkbUbO5Q9vedbr90yNyNZWlO
         tbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481771; x=1726086571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLbVQD1uWq7E7syR9oa0FyZv5hSgj9K2/YM9COMKj/I=;
        b=cCP1XL4JIsNyJKXWlYT2RXu/ucViMZy2CC0rfKE6UirTDDcq0sCaWbKcYNwmk6hLYG
         5lxLIK7gzqxzjkqYLR5B+gxLreiNQ0NA0P9JFSbRxx64/pGHRFoZBco/EFduHj/x+FVo
         JIUjiUlW3VFVPZkiWXMTpUSx9WDrg7EG7faHAJvtD0dofuGRB4QkPWPr8yDsLjOf52mY
         Xvquw0+3s9Ls8qP4FxffmWvq/jACRVC5jpGK0CjAeuUb8M8J+0fr9QYlm8Oz/Oigj87P
         GtLPFGZw8nVZTlw5DpTCuuy+dEFPCWGCN2RDF4WAtt7XS7qVAkg1ZdiuqjuP5UdINGlm
         /hHw==
X-Forwarded-Encrypted: i=1; AJvYcCVHl6nkJ29qDG5UjKbvWEdZWsf3/ON6GiaIZxjRed3nXHmKSdiMT3oAtMy78mOd5kPgBSS6r8CAJG2G9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzArP6gHyB9MiVLJmYevY8aAEPPaO4IQXF1Voa4ZjEMh74m1Nxh
	BEMsWDMYgz2uwD22S+6BHJK2dSdi6kxd6FLxyfrEkaJY7YkiQZJWX8TqfaTrBWw=
X-Google-Smtp-Source: AGHT+IGdJ5rFqIo2R8SFFCo2OiCjnf+nE2kM7AO4Z/b+MhtME6M5x1ovZdZNYRb7zGAzpKTv2dvAYA==
X-Received: by 2002:a05:622a:6209:b0:44f:ed41:6a02 with SMTP id d75a77b69052e-45705429a88mr138893691cf.57.1725481771257;
        Wed, 04 Sep 2024 13:29:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b5f7aasm1500371cf.52.2024.09.04.13.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:30 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 10/18] fs: add a flag to indicate the fs supports pre-content events
Date: Wed,  4 Sep 2024 16:28:00 -0400
Message-ID: <f5dd14c65fe3911706be652833f179465188fe08.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pre-content events require some extra thinking, especially around
page faults.  In order to make sure we don't advertise a feature working
that doesn't actually work, add a flag to allow file systems to opt-in
to this behavior.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fanotify/fanotify_user.c | 2 ++
 include/linux/fs.h                 | 1 +
 include/linux/fsnotify.h           | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 53eee8af34a0..936e9f9e0cbc 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1736,6 +1736,8 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 
 	/* Pre-content events are only supported on regular files and dirs */
 	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
+		if (!(path->mnt->mnt_sb->s_type->fs_flags & FS_ALLOW_HSM))
+			return -EINVAL;
 		if (!is_dir && !d_is_reg(path->dentry))
 			return -EINVAL;
 		if (is_dir && mask & FAN_PRE_MODIFY)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..5708e91d3625 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2494,6 +2494,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_ALLOW_HSM		64	/* FS can handle fanotify pre-content events. */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 9d001d328619..27992b548f0c 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -179,6 +179,10 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode))
 		return 0;
 
+	/* The fs doesn't support pre-content events. */
+	if (!(inode->i_sb->s_type->fs_flags & FS_ALLOW_HSM))
+		return 0;
+
 	if (perm_mask & MAY_WRITE)
 		fsnotify_mask = FS_PRE_MODIFY;
 	else if (perm_mask & (MAY_READ | MAY_ACCESS))
-- 
2.43.0


