Return-Path: <linux-btrfs+bounces-3428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DBF8802CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACF91C228B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF30421364;
	Tue, 19 Mar 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vb1X+Tg7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969EC18C05
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867373; cv=none; b=ulU5SnsYPBg3lw9qSam9KnOOeKeHP+64c1HEwhlPtWSRnddtZ6jpaxObmUycNDscogp5cXWQfDyM+tdKVkTYg1Sm2TEBS8fHEf7QmT0AobRjXoNuUMcPruW6X/oElDH+X6q4K1N3mUGoq5hCkVDDM6ONeIwrKStZtL3jC1+3clU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867373; c=relaxed/simple;
	bh=hsYvutvV8mZq4tJxDZlF8Y4bVOiUIuvjHFVje3QQG4E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGUv7GvesDfQLNd+lQ4ShBxq3IB5528HyuvqklczmIIHIRCjGls+39EdZE5Qn+9oOzDVYE6b6qfaQLuyRpRdigrycEgo2SP/qewy6prKW3+lOeJEOlZZE46SuNDN6QRUpBZ1Kjldt1oOqipshVBNgKRjuLag28O2dETXOpIlX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vb1X+Tg7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a16114b69so6242285a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710867370; x=1711472170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gDXQ3N6RtQpFHt8yWxl41S3QndLvHgv4UXULQuqMXs=;
        b=vb1X+Tg7WGH/pFXqde7NcO2rOGdRbPu4nYuMA066teC0c/iFSMFPFcTBSlQx7DkhIT
         ZAckckLQzTLsGPM72lbuA4dIiMFhJa31GlSbVYz7ia41AxjrHxcHjcpb03s1Zg0VXiuq
         CyU6AHIz1u4zAeytOpvG9qHdgussDOm3aSrzi3rEPPcniRk1Wg0Xmg0Jqn3u7atquIET
         Osar45gUGdKTtDKnZM8vaXWhf7uHAkFbI1OQeFhnTiqwfZYeiLBsYLuGfgVe4nS0rLQS
         QBTxjPj6bI+7Fd2Gsgw24pGT9fmkhopJxnj8g+hxTw8K3r8XOMHu7xEgvTnd6FM60R3r
         E8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867370; x=1711472170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gDXQ3N6RtQpFHt8yWxl41S3QndLvHgv4UXULQuqMXs=;
        b=A5cFBch5FBCUjLv2b7X70quSXml60Icj2aGrZohePqvzh78ArAe4n6px0z3QrqAbJQ
         uD/Frjk1zhJvLjvf/xycyhRW9Qb1JpB/Gk+PpxYvwktHtAF1EQHZkKLnZRPhdbo38TSf
         qrCCUYdUgRGywBSbg4FF2UV5+/cJcvvvtXtOkHCI4inQTtrHQWksCj8odmf7RBZVROwo
         cKqbQGa3Y/uMI8thjzprPTboSL8rdhVbRectDaw+acnFuKjwcNe3ptcsL4lFBFQtNG69
         CKgw9peT065Yfi9KXFeaafltKLJiPv3sKWZb6kUx+gjY95UsHqXnmLevuHhRNP5v0lKo
         yPug==
X-Forwarded-Encrypted: i=1; AJvYcCX5OBrsz86sCj9ilKcq9riA/4rk5PA7ZOj/y2fDUzQ/NMmSg5UGSTWx2AHGAMLHrHl/It//Oby0YCR0M0QYmpVBbQRRSDuVeRZdbv8=
X-Gm-Message-State: AOJu0Yyu+KZJpgKmd9POWp5J2A7ymn2cy1qpjelDMkv7ICXS7m567VJO
	W0HGDRJm1RmV+yvfmLmHxet8wK6JjumFyj5fl0z/ZIIdsVpkVoPGKyoH+LKSh6nOlKBsZHaGOTZ
	7
X-Google-Smtp-Source: AGHT+IFTbbZANqwVDpPXm0qhhIO5T/inGJXfRHNivqf/EGirubaBEluOGNsGjwc/QjeOyXLop9kSog==
X-Received: by 2002:a05:620a:4116:b0:78a:1b8d:e0e5 with SMTP id j22-20020a05620a411600b0078a1b8de0e5mr1613591qko.14.1710867370571;
        Tue, 19 Mar 2024 09:56:10 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z1-20020ae9e601000000b00788287e3430sm5547220qkf.130.2024.03.19.09.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:56:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 3/3] fstests: add _require_btrfs_fs_feature raid56 to a few tests
Date: Tue, 19 Mar 2024 12:55:58 -0400
Message-ID: <13ca87a192f4eb8a8f10415ae1ff06682c3b40a0.1710867187.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710867187.git.josef@toxicpanda.com>
References: <cover.1710867187.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few tests that don't have the required

_require_btrfs_fs_feature raid56

check in them even tho they are raid5/6 related tests.  Add this check
in order to make sure environments that don't have raid5/6 support don't
improperly fail them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/197 | 1 +
 tests/btrfs/198 | 1 +
 tests/btrfs/297 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/btrfs/197 b/tests/btrfs/197
index d259fd99..8a034fdc 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -32,6 +32,7 @@ _require_scratch
 _require_scratch_dev_pool 5
 # Zoned btrfs only supports SINGLE profile
 _require_non_zoned_device ${SCRATCH_DEV}
+_require_btrfs_fs_feature raid56
 
 workout()
 {
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index 7d23ffce..ecce81cd 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -20,6 +20,7 @@ _require_scratch
 _require_scratch_dev_pool 4
 # Zoned btrfs only supports SINGLE profile
 _require_non_zoned_device ${SCRATCH_DEV}
+_require_btrfs_fs_feature raid56
 _fixed_by_kernel_commit 96c2e067ed3e3e \
 	"btrfs: skip devices without magic signature when mounting"
 
diff --git a/tests/btrfs/297 b/tests/btrfs/297
index a0023861..990b83b1 100755
--- a/tests/btrfs/297
+++ b/tests/btrfs/297
@@ -15,6 +15,7 @@ _supported_fs btrfs
 _require_odirect
 _require_non_zoned_device "${SCRATCH_DEV}"
 _require_scratch_dev_pool 3
+_require_btrfs_fs_feature raid56
 _fixed_by_kernel_commit 486c737f7fdc \
 	"btrfs: raid56: always verify the P/Q contents for scrub"
 
-- 
2.43.0


