Return-Path: <linux-btrfs+bounces-3981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B4289A548
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 21:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AFC2844D2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3430173353;
	Fri,  5 Apr 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gd/TQ7Yo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E717335B
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346989; cv=none; b=X46RpS3MeduUMh86QgabifUuWXDs6sapINuNF6yBHlvq4Xin7QMFG2DMii+ST0XUK6+uw1mSf4g1ly7DbE432f5YbDzDMqY6PxoCg6rs5q8toZsJaByfOLSA5yerngdC2Ec+gg7O0pUmfVnxGqe898ssL0czAmBEsgsg6g5Gj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346989; c=relaxed/simple;
	bh=HYUW+z//x5mv5zjQLHy4xGBk1J7vq2b4pb+HyyJmcIo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxadIj0NOnRdJPGLzJEGxbHUFpG5X3s1vREnoxKaGolBRBrrly7U0enJft118yXJ8Qli/givMkpmU7PL1vg/w8BrKuBeRC+gNrz+4EfYKZdLOV+E4M03R8wXJ2C2qrYiOMRpFiwD0X6qpQSxp4RTpRbojYGSisXrl4iLLhE/i4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gd/TQ7Yo; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-432bfaf533eso13075261cf.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1712346986; x=1712951786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuucR5tQ+uVPIm11Y7vgLKHErtjkCXmOFvH2OaG8/wM=;
        b=gd/TQ7YovO86gecjqQCM8nLLndKJo9f+8FSrJMskKew0GYIWltP5igHfb1olaJR9bw
         kIflbhQ/UmoX4UaUm8eEug+zkACGoHxAmTXzLWdb7oPpMl5bT6mytHsZRY7JnKtegTHt
         xVevIg4ddJJFuSZ9/QgtWh4TeYNLNISaBa3E1IUy9rnChFAdwUOm/bw2oVufCL6hh5em
         BHatAhEJ6aoyix3PEuLOKGPCvaXW1+VRF89dL5z7oSRXI/PIhRVF9b4KgZy+X/6v/PJo
         o0HlryTlY/QAtC6fPpNgDB/oj4DA84MHweSz5Dy5Gna5A8U46VenxnFKqng1Fuz1Tl5G
         Joeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712346986; x=1712951786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuucR5tQ+uVPIm11Y7vgLKHErtjkCXmOFvH2OaG8/wM=;
        b=cpK6250b7DDU/9RFfE75z7qQTCmp/i5TMs3OwNC4318ooEF/p91xuWNqksUtyXcuhN
         1QqamLDMcPz47rFIXwsMZwpaGCteUXpMibrb++HB2ScQWQjoq8/KSurZteVs7kS8Iy5i
         BX6d3lAMS1h9MyssPiqSSGbL3W17Xof3H9lalm3xR5JtQAYmRkbHWz2p1t5Gu61XYlaJ
         GmvxdNGePlEpA+vv4zNdQpfNHynIPDYDVsE48DGF3OCxwavmTDd5sin4bFEPNYA+XsF5
         apZf0e3D/A5/cwAm704uJp5jBy9LqaQV8HggEO3sh/6McpfqJQC5DY8t22ehyJFkBIVG
         kp8A==
X-Forwarded-Encrypted: i=1; AJvYcCW1uCPvl37ZZ/b2SKZmLyzFLSNncJ6sgrdzO7PlxZ4ps3mVYq4DA9QfczNyHK+qHAUGZ2rzCTLsGxaFCy1zychQWk2snHXfDQDgkLY=
X-Gm-Message-State: AOJu0Yw6pg2GaHcLtN2ha9TNbuAaQ4GhMMKVqB0IyxHLxqfRAvuzJizW
	8qSIvFmDnL2UNAgMf2abwgDhkGclnMwSS13myEdIUxXbYIx/raC+Z7njzbWceWk=
X-Google-Smtp-Source: AGHT+IEA7M+xKsCKiADYz/4Mi1mQQPa7Fbz8fuenzFobxaGYdovn4Bpb6fC2H0wihjc+UTxGuJ0HnQ==
X-Received: by 2002:ac8:574f:0:b0:434:4a16:609c with SMTP id 15-20020ac8574f000000b004344a16609cmr2324082qtx.39.1712346985929;
        Fri, 05 Apr 2024 12:56:25 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id er7-20020a05622a5e8700b004317485a4e9sm1042020qtb.66.2024.04.05.12.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:56:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 2/3] fstests: change how we test for supported raid configs
Date: Fri,  5 Apr 2024 15:56:13 -0400
Message-ID: <86703e27bdb8c49950be6ea65ac228ece3ecc315.1712346845.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712346845.git.josef@toxicpanda.com>
References: <cover.1712346845.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btrfs there's a few ways we limit the RAID profiles we'll use.  We
have the raid56 feature that can be compiled out, zoned devices don't
support certain raid configurations, and you can manually set
BTRFS_PROFILE_CONFIGS to limit what you're testing.

To handle all of these different scenarios in the same way, update
_btrfs_get_profile_configs() to check for RAID56 support and remove it
if it is not there, and then add _require_btrfs_raid_type and
_check_btrfs_raid_type to get all the settings and then check if the
requested raid type is available.

From there I've updated all of the existing tests that use

_require_btrfs_fs_feature raid56

to use

_require_btrfs_raid_type <type>

where appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/btrfs    | 29 ++++++++++++++++++++++++-----
 tests/btrfs/125 |  2 +-
 tests/btrfs/148 |  3 ++-
 tests/btrfs/157 |  2 +-
 tests/btrfs/158 |  2 +-
 5 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index e1b29c61..845d01ea 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -98,11 +98,6 @@ _require_btrfs_fs_feature()
 	modprobe btrfs > /dev/null 2>&1
 	[ -e /sys/fs/btrfs/features/$feat ] || \
 		_notrun "Feature $feat not supported by the available btrfs version"
-
-	if [ $feat = "raid56" ]; then
-		# Zoned btrfs only supports SINGLE profile
-		_require_non_zoned_device "${SCRATCH_DEV}"
-	fi
 }
 
 _require_btrfs_fs_sysfs()
@@ -218,6 +213,8 @@ _btrfs_get_profile_configs()
 		return
 	fi
 
+	modprobe btrfs > /dev/null 2>&1
+
 	local unsupported=()
 	if [ "$1" == "replace" ]; then
 		# We can't do replace with these profiles because they
@@ -237,6 +234,14 @@ _btrfs_get_profile_configs()
 		)
 	fi
 
+	if [ ! -e /sys/fs/btrfs/features/raid56 ]; then
+		# We don't have raid56 compiled in, remove them
+		unsupported+=(
+			"raid5"
+			"raid6"
+		)
+	fi
+
 	if _scratch_btrfs_is_zoned; then
 		# Zoned btrfs only supports SINGLE profile
 		unsupported+=(
@@ -792,3 +797,17 @@ _has_btrfs_sysfs_feature_attr()
 
 	test -e /sys/fs/btrfs/features/$feature_attr
 }
+
+_check_btrfs_raid_type()
+{
+	_btrfs_get_profile_configs
+	if [[ ! "${_btrfs_profile_configs[@]}" =~ "$1" ]]; then
+		return 1
+	fi
+	return 0
+}
+
+_require_btrfs_raid_type()
+{
+	_check_btrfs_raid_type $1 || _notrun "$1 isn't supported by the profile config"
+}
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index 1b6e5d78..d957c139 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -41,7 +41,7 @@ _supported_fs btrfs
 _require_scratch_dev_pool 3
 _test_unmount
 _require_btrfs_forget_or_module_loadable
-_require_btrfs_fs_feature raid56
+_require_btrfs_raid_type raid5
 
 _scratch_dev_pool_get 3
 
diff --git a/tests/btrfs/148 b/tests/btrfs/148
index 65a26292..9bbcd8e9 100755
--- a/tests/btrfs/148
+++ b/tests/btrfs/148
@@ -17,7 +17,8 @@ _supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool 4
 _require_odirect
-_require_btrfs_fs_feature raid56
+_require_btrfs_raid_type raid5
+_require_btrfs_raid_type raid6
 
 _scratch_dev_pool_get 4
 
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 022db511..8441a786 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -32,7 +32,7 @@ _begin_fstest auto quick raid read_repair
 _supported_fs btrfs
 _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
-_require_btrfs_fs_feature raid56
+_require_btrfs_raid_type raid6
 
 get_physical()
 {
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index aa85835a..cd4f604c 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -24,7 +24,7 @@ _begin_fstest auto quick raid scrub
 _supported_fs btrfs
 _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
-_require_btrfs_fs_feature raid56
+_require_btrfs_raid_type raid5
 
 get_physical()
 {
-- 
2.43.0


