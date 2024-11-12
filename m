Return-Path: <linux-btrfs+bounces-9550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A19C5FC8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 19:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E6E1F25A3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D36821A711;
	Tue, 12 Nov 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="f332KYpY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240721A6E0
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434219; cv=none; b=P+7n+BT9JR+ru11GzxnYkgehMJVLXEjvcapKNDAQYoXAqTokpjqp02r+dZLUri1uK0Nm7nHzLrI9gu9xzBbbDpziMMyuEYXgWCzLgFANCQNClwezbF6mJMs+YOLFoB0c8OtO1wJwQP0d7IcY1YgNrnpLuvE9A2mCwMaaRR9+1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434219; c=relaxed/simple;
	bh=nFXm/L4ae8YekLwpIFurgFERbAtgq26xVgDJzO6g1yM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUnbf+kxst1LhlYbKHTkKeTjcpclEQuhXU7rR0qP0b+jfGCCpAILWnUQYnj/mKKKieHNWioTr4Ur1J6EcHd4WlkT2uq2q+IozwfAkvbx3YP/tsayq2y0A6yXorpc13ha2FGBongtp7gr+EIFI800TlL7feI5vi2sPHk2sBWZW4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=f332KYpY; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e30d1d97d20so5291679276.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 09:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434217; x=1732039017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gek1GO8SPggpZ3MPgZMTTjA2lPqNZurY73wIWpdWbQQ=;
        b=f332KYpYpBj1sNEzbQQiUwIsoXIXb740XNNn6oYti/tlb0A5yFHmlUM+Xz2fVgC3qb
         G2cOovDqa0D+gIg+M1jcuXvddsZM8+q+9+7YiIEa5bfwu9SOlpcsK/SR8Mb1CPdbeqiv
         oJvXFVWvnoxMLM+hbLDaDQoEOz/pKwJ0oLGAuAewzusuFzb7i5wvX1Bth1C7NzNjn2Ju
         RvC0tKgwPSglViSeJe1lkf+Gnxz1a/+vM5yNW74bpV0OEhxcFom4VA6pbkQOig5ExYMI
         IqRa0BafjNl5x7ificOp7pj/f5X8YnhKLAl+wMZ9X1M0LVFC9VSswIBCFh5/r31jqrwS
         RwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434217; x=1732039017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gek1GO8SPggpZ3MPgZMTTjA2lPqNZurY73wIWpdWbQQ=;
        b=i4Lpp7f0JYpSAi5rCKUHsIHRHAquYHBAwro+TQSbcRiw4mjho8w/T+3PWcei5iYV1n
         432B7rRYBsDPdl1JZGyddBJ8siJ018w3J42hFeiSIaLz+G2xGHw7q8kARcEY2enBkOaW
         n7m/pBMvwY9AP6Uz7UY0lI+5tT80oWMovAOzSfXkTAl0WoWCJBtrILUWAXWeXIIa5OT/
         D3x9+brnGaXg01z5Zlhy+g6/VJY6nf6Y9XJb45GzKxGX/V51Xrq+w33jowmqgblsDEuJ
         1hEKa7EG5RzdGcQsoVlBQ6AuEUOoEXogEO7Z79HY6f2D5CCucDZYt6eAYPduYcbbsFmi
         PNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRhJtP+kB5qBnez2pF2VUs0vbZoVngILYb3PISipRSXxhqn7KuJrMACR/jnV++8PV3C+sUDACCQrFYLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUH1IKVDrtoiveIJmHmhSenKugkdU/VWo82DOhyLO5PvvCEew
	c4tCSIIrYHCOYlueoJbddVgmJZwhu0De3dI5V7XlvD73i+leL4mFxQdyJi5CyBU=
X-Google-Smtp-Source: AGHT+IEseNU1fU18+Eb5Xypvfn1vm8TMH1JcpZ3Hifh4Ob7CJlLkVA7fH8jLCYaFBtppEHVnywJ7Bw==
X-Received: by 2002:a05:6902:1ac1:b0:e30:e59b:4a40 with SMTP id 3f1490d57ef6-e337f8822d4mr14895613276.28.1731434217050;
        Tue, 12 Nov 2024 09:56:57 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ba498sm2747524276.46.2024.11.12.09.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:56 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v7 18/18] fs: enable pre-content events on supported file systems
Date: Tue, 12 Nov 2024 12:55:33 -0500
Message-ID: <476c173aa514c889cfb3d9a1dcf3bb333a223ef7.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
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


