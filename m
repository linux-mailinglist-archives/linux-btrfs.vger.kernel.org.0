Return-Path: <linux-btrfs+bounces-1733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F5583AFB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87D71C2616E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF3A12A152;
	Wed, 24 Jan 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iwetN/Lo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0522312A14C
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116815; cv=none; b=dAArgtNporLMiNaQefBN/8948P5TrSLx8LLLyo9m/TnQDw7YkcVpad5whRFCSl0CB3n6UoAwfwJxjtSv1/hOgH+ndtxTGdYquLe7TV+HfzW8Wmoltl7ky7H/vxZTzxeQd7r8pMwJis846RuloFESi+l+fOgDytL/VF1rtcqkgNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116815; c=relaxed/simple;
	bh=G6HqizdyUFtdztKuZdgiAJJGKCELla28zGvdOuxl/LU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJiynFeFA9DIRwUSwZUFiEcRYrgGcy6YPNx9zSZ0dSUNDz9raf041M4wcH8Jm4p3L+X+AsZQHcISacrCE4LKeIhBa8IHJozlvg/s6YT4ZryQrXpe62U6713TwZulH2N3tfj2jzg+6qdro4UZUa3Pz+360n5r7pID2RdYjl07w/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=iwetN/Lo; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-600094c5703so31884847b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116812; x=1706721612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOZlgEC0fwmuy2NiOA6q5Nmuq+nL3flKAnL+lP01634=;
        b=iwetN/Lo4jCJ0dPinNC8wANPvsaQ/bCTCs7qI2pBV7rmcbiDudyFQ1PsuzWcDVBaYz
         vzeWNHLg+dEHxQzE9WboYUZmuKsgUULWdUtIJH3vH82bDH42WQ89+I2Mba4eq0UzAq4N
         mzcLIdqtmo0PyZm/i4o0zUBCYTXr2V54ryiy1ssZHGejPZnB6ssL4/+AoXD4aiK94c0g
         B8msz+Ojwicrr5MsQoG6X00wcMriiCH9TivypFaNRLYJlT8IB0d6spFdUSL8Lm/EiMS3
         6GY098gah9RuCOfEzxQGhyZmnoc99glAiklvn0BYHUYYa/IGC9VSJnSs7DR87zZPh9u0
         xCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116812; x=1706721612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOZlgEC0fwmuy2NiOA6q5Nmuq+nL3flKAnL+lP01634=;
        b=noNjJMnkiZ3wSyMNV4e9dU7Ah/lK/+uICn19NHUs7KkHaPpGtUSVyaa/myEL0XMIDg
         vZPh9a7PBLMMGnBHEONzsCLgsK0p3MpfFX0JHtu8dI+t/tfgG0GqhVmG83I/4sp9j/lm
         wNVt2XgUO27z+MlWAHWJIdOp0k7m4KctrXMshMm6O3PTrMYH0hIuHuWhc+Sjdjf7EmrN
         /TtXxP/BvJ84BlNAHbKuFUUdeX6gAISgg7tdPNRgS/3V52FDzOm1GpIrwXvxpcNk/bXq
         4dPhTzlnuSUZqSrKZtqRoVkQkJwRkFYEGeGD6VAwzDzLolR7uSZqX1kqBx+j5yhuM6Zw
         whdQ==
X-Gm-Message-State: AOJu0YxNWlSDJCvULMIC5Gf9AZ2luNYpxa2bysuShFNFvvWkBXo9n/eN
	ZtK9d42BAfK6rI+FevBXJQO1bqSPSZ3+Hd0fD1e2jEmZjALAi46HRSAHNEyk+4LFxSYNADxl8sR
	m
X-Google-Smtp-Source: AGHT+IHTCF/vepetqM3ga/XOrgYFiV17acShiT+2XRgDJR9YgPhFcub00hdusCoSdM0nZhKcrfmi6Q==
X-Received: by 2002:a0d:e80f:0:b0:5ff:9810:e8d5 with SMTP id r15-20020a0de80f000000b005ff9810e8d5mr1066121ywe.87.1706116812509;
        Wed, 24 Jan 2024 09:20:12 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05690c038d00b005ff864709aesm64567ywb.42.2024.01.24.09.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:11 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 51/52] btrfs: disable encryption on RAID5/6
Date: Wed, 24 Jan 2024 12:19:13 -0500
Message-ID: <941f02bb923edadae1aea4ae3e5aa6ba05d1215a.1706116485.git.josef@toxicpanda.com>
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

The RAID5/6 code will re-arrange bios and submit them through a
different mechanism.  This is problematic with inline encryption as we
have to get the bio and csum it after it's been encrypted, and the
radi5/6 bio's don't have the btrfs_bio embedded, so we have no way to
get the csums put on disk.

This isn't an unsolvable problem, but would require a bit of reworking.
Since we discourage users from using this code currently simply don't
allow encryption on RAID5/6 setups.  If there's sufficient demand in the
future we can add the support for this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 4 ++++
 fs/btrfs/super.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f5dc281121d2..4723b41d4fb9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4582,6 +4582,10 @@ long btrfs_ioctl(struct file *file, unsigned int
 			return -EOPNOTSUPP;
 		if (sb_rdonly(fs_info->sb))
 			return -EROFS;
+		if (btrfs_fs_incompat(fs_info, RAID56)) {
+			btrfs_warn(fs_info, "can't enable encryption with RAID5/6");
+			return -EINVAL;
+		}
 		/*
 		 *  If we crash before we commit, nothing encrypted could have
 		 * been written so it doesn't matter whether the encrypted
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f5bbaa70b09c..080ab285f628 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -685,6 +685,12 @@ bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
 	if (btrfs_check_mountopts_zoned(info, mount_opt))
 		ret = false;
 
+	if (btrfs_fs_incompat(info, RAID56) &&
+	    btrfs_raw_test_opt(*mount_opt, TEST_DUMMY_ENCRYPTION)) {
+		btrfs_err(info, "cannot use test_dummy_encryption with RAID5/6");
+		ret = false;
+	}
+
 	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
 		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
 			btrfs_info(info, "disk space caching is enabled");
-- 
2.43.0


