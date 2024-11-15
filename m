Return-Path: <linux-btrfs+bounces-9726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1B69CF046
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086EB1F298C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319071D5AA7;
	Fri, 15 Nov 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Psh593YT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096241D5CDE
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684732; cv=none; b=V6rxNJKtCJJLLwk/aVE0tFYzDhkuZtukUytwsREGrsPQUB+hnMJVBxUWRmzB215eSjb8yX+62+j6jvfDarsAIThTW82yptimbVVWXebQ+z7JTgXBwhCBYuT3I0XPWzIwGnuVxaYqDJJInM7SZcuGMfnkL40BVWNwZuQG3ncWaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684732; c=relaxed/simple;
	bh=nFXm/L4ae8YekLwpIFurgFERbAtgq26xVgDJzO6g1yM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLVxnHmZKb88DBE8WG3kwcslZ+3dhtStFwBSgm8xHDWhyEPYBUY9ta1zCVDiDjauSyTcqK1iGJNSizFzYVlKgryfzTpxYcbMil2nuQk+qkvm3loEG/gYyIJFRuwxCVJrx3qKeaTlBKuBgj4mfmZMv1xRgl/5Vw4QD4cKKAX+uY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Psh593YT; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e333af0f528so1861286276.3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684730; x=1732289530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gek1GO8SPggpZ3MPgZMTTjA2lPqNZurY73wIWpdWbQQ=;
        b=Psh593YTSEaCvm5mP0PDI/hHqJaWvavyydhQViMNpGJflzXuWq0u4oGWsRy8EGzYd0
         usu99WzTon6qxQ2ppapBWXUMOlJqm4XFx8KWZjIS6KrJ1IfzI3b83HYIQUhjRM2v1vX0
         GLQ3X+bDXp/SsgKlsjWUqLESyI0RZo/RSyu1FbEeuU9hGBbtIAlT2qANVI1za6fWa0CR
         PWjCaJtxvmHnwezUoPTTRsd3Oui/cS/5+C3cpo4UosKtWZ47DUyt+BIZ5rx2W4d/SZFr
         j7LdDrL+rIVC7UsSLkjWPUG4qUtjo9M1aQcQp6ZH+dhDdLUDhojxYGA3raZ/zwAIt0JS
         cJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684730; x=1732289530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gek1GO8SPggpZ3MPgZMTTjA2lPqNZurY73wIWpdWbQQ=;
        b=L3aZkiT7SlU2k7V0eXqbBRxPvE/aFNzfjgVdPYlohNTijY/3xvSmZhbmxABGNdsNvf
         emi4gDGuD9wmpWcr8wxV/9jgUa+KqlPGFJepTJCQVbLKpfHlA0ktSLe/uKYBBFaE2koG
         bEFHFpvScasPBgAQox1Lw7Khq3qgunQuuqQNIKUR1DGpVLZdxe8yhqShNaP44oe7M/AF
         ZEPgHERhJG8EW5heXbxK8pKulLTMSvU001GgELa4BQKJeS7n/iHKDw12CadInGB4tnUx
         Hc4FiZKwcKESwthcjxga5wvdsg3p+sHkLPuGFuqsJL9NzgBSq4Z8qu/pqml436d1/TLC
         Vnbw==
X-Forwarded-Encrypted: i=1; AJvYcCUPFE3acPq/QYDvtrL8QhvcwRVLT7qUQGTqm+4KJE79SsndGecvxJ70rIu5ws0dquP0xSr9n+0K915gYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pyprHLL6cBAkOGRMvyYgSmNatKEY/5nILv1WPbnW5xJMs51s
	ZeTfZCS+96mPsspVghDDyb6IasQ0X5wv6+Rp3CqQ3GrWrD+I2NuLpEOzf/Qvq4c4uJp2o/MPFVj
	a
X-Google-Smtp-Source: AGHT+IEUcKBXNGC+FquadsfHiR9BI4UoMJrmZkBZaObeXyKm9EGd5wreVNWR6wH/jakvp0EFNSF0lA==
X-Received: by 2002:a05:6902:1209:b0:e30:c977:a360 with SMTP id 3f1490d57ef6-e38261291fdmr3157574276.5.1731684719039;
        Fri, 15 Nov 2024 07:31:59 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e384121a605sm296041276.52.2024.11.15.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:58 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 19/19] fs: enable pre-content events on supported file systems
Date: Fri, 15 Nov 2024 10:30:32 -0500
Message-ID: <46960dcb2725fa0317895ed66a8409ba1c306a82.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all the code has been added for pre-content events, and the
various file systems that need the page fault hooks for fsnotify have
been updated, add SB_I_ALLOW_HSM to the supported file systems.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c   | 2 +-
 fs/ext4/super.c    | 3 +++
 fs/xfs/xfs_super.c | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 97a85d180b61..fe6ecc3f1cab 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -961,7 +961,7 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
-	sb->s_iflags |= SB_I_CGROUPWB;
+	sb->s_iflags |= SB_I_CGROUPWB | SB_I_ALLOW_HSM;
 
 	err = super_setup_bdi(sb);
 	if (err) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b3512d78b55c..13b9d67a4eec 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5306,6 +5306,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	/* i_version is always enabled now */
 	sb->s_flags |= SB_I_VERSION;
 
+	/* HSM events are allowed by default. */
+	sb->s_iflags |= SB_I_ALLOW_HSM;
+
 	err = ext4_check_feature_compatibility(sb, es, silent);
 	if (err)
 		goto failed_mount;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index fda75db739b1..2d1e9db8548d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1713,7 +1713,7 @@ xfs_fs_fill_super(
 		sb->s_time_max = XFS_LEGACY_TIME_MAX;
 	}
 	trace_xfs_inode_timestamp_range(mp, sb->s_time_min, sb->s_time_max);
-	sb->s_iflags |= SB_I_CGROUPWB;
+	sb->s_iflags |= SB_I_CGROUPWB | SB_I_ALLOW_HSM;
 
 	set_posix_acl_flag(sb);
 
-- 
2.43.0


