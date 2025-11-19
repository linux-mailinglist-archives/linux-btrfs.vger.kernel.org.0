Return-Path: <linux-btrfs+bounces-19117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C99C7C6C6B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 03:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBF89367620
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 02:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21842BDC01;
	Wed, 19 Nov 2025 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY13bT0k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595B28BA83
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520057; cv=none; b=L0/rECmpNF6kBxDaBBG/x+ZvoeAbTW68AYC4OvOjjBaLqKLsqnPrEnR2iVKsisyjij9XYtDv3/0YaVEvkIaOldJU/DU2Lrni/LF63N+nX2GdERDjNyX270xffjVsFoVA1O/Q6YS4BxW68sCfMg7hjcXpJB6P36AAL4j15weyZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520057; c=relaxed/simple;
	bh=WcZ1SJZovo6vbYl4x5xl9cGb55bFggqGblbxVvcCB/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmdpoLczn8cB5OfdQQ+mLcjQNtvxlGn5U2C6evL9j+HnOsfEaoZnvcCeyrtNWSelTqeC0JgKRxzQYF75BopGli+7rH2uRNDz+lO2Ga0aubd2VP9AhedxGsBsItB0bGLtPu5jT6FdCsGtmH0071ahDWiyYCPwL+5LjpSDYXv4vXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY13bT0k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297d4ac44fbso3269295ad.0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 18:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763520055; x=1764124855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7fJ64B3l2aZ8gg+aOT2cGtK2HK8RXnbetEVCcCDXMm8=;
        b=cY13bT0kcvj7BwG06KxeuTfeojxyX63Aif/xm8CN4N5xx15KTmwAQCRiBoWuVR9Gko
         v4M7U8iao/hN/njIs0+eh5R/85NR4E49ElKMsJ1BXmHCxnaX8ei45e2+WmuQcNiwCHAN
         1nyp1RvcT1+I2Wq5jLvarF5VKEPZKlcm9n6eAVHWZsqezhuyJuyeMkYl7FTvxcoJgkqi
         HZdwuHlZB0sYAkFiw3T6OfwpStFvYhx5LoD7vqPyT6mqw0rDzAVP/Ut/1KsvWtvK2e75
         1LL/iobD4kSwosf+KHjqqK45mGK2cLWpRqcgI0SOeUMSDUNAAqyvw7XufFaz9rEQVsc8
         xTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520055; x=1764124855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fJ64B3l2aZ8gg+aOT2cGtK2HK8RXnbetEVCcCDXMm8=;
        b=ZLPoKeg/K+jrUiCQ3t4RC8bcNEV0E+ZQcB7IQPpFwpaQSrYoafGyQoG10lQLhMYA4A
         aY7dXtYroHe6h/ptwoYj9pZ2rotgRX8mPRQHGDauvmm3cM5+aZMFC4UI1o0IbTfJoLwr
         9YtNn5LBJY4PgGa9jInLje0ZWvMxofIQlNAoQdTq4c3vs/P+X6m3C4dB+05uO9+mJsZU
         F3MVWnDCCnMtQ1SRNYFysznfxGm20Omgvt1DWJnWk/S9hNFRtdzJVAPTFfvoVUXJY7Fv
         H2ggsWE+HHtxwIpUKavQaalLOWTrtHfywGKRuS3hVS7w+RMdqfI5dCfamuEVUZXLLSKR
         aQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCWv8dJdNjeQ5SNLWTgkLAMGatHcWlAQ5dYOfqCvmrSokrnIxhkggoiIxzyIxoZU4zcN9YrJXqsOoebEvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywis8/AaBcXtRyvOPC9PPPbGwEtAjoAoEZQtAYoBuJOJDaNN7SG
	SBJi7I+xy+1353uWWPbkZc8ZEiCx4X9fjhVyI2SpwUl7eQRIGanARX3esfbFyA==
X-Gm-Gg: ASbGncuHj+fJ5f17OFiI0I6bfOZRLMI0jJ6QYeSNz7Whj2Cai5ohsOEU5/DxhOv4X3s
	vH0+jvYjcy5pGl+0/zyEK2pOV9diZyWvCc7sDhydUOn3BaJWL/2wibtmrJE/f0mndXBsXoq2RcG
	rTULuXvEIQgLshzRacbgIUUi8TLoKVdvPmS4Wt+SeJccX7EH55R2yPU3Zg7HTQwG4xX+2QqLxGA
	I0LQFF9w6ECaruA3hFKjZ4gTHvhjLmnqdrVzCLKtf+zOetT83jYQdkyi00yfn4qKK6hz8Ea1XtY
	pXo7zIK+GRnLCtvGyW3b19TqNW1ijCJcZQWf8DfQGoklunTrzCxfpNMINeDeahHpkCUV4il3POl
	aCzj6ggdTdmmhi+IlpdyKjDu3TFiYsPsQrjC14tR7r3oH8yWY/EaejUrfv4VqlVs0wqNS6iaMvI
	4X/K1wwHla7Mz/47XEOKPL6T6hm3h3TPaRcuuqAK+lS8B7M9ypPCoHvMvpflfCdZJ2jDI=
X-Google-Smtp-Source: AGHT+IGfBVibuqYhqYVtXIJ3JNQvz06IGlQMOVGqvS7Uxt4SrnGIovbeo5VyrSVjvp93rozUMKYM9w==
X-Received: by 2002:a17:902:da48:b0:297:e897:6f6d with SMTP id d9443c01a7336-29a05ef321bmr8996875ad.9.1763520054753;
        Tue, 18 Nov 2025 18:40:54 -0800 (PST)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c9dsm187861255ad.67.2025.11.18.18.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:40:54 -0800 (PST)
From: Sidong Yang <realwakka@gmail.com>
To: fstests@vger.kernel.org
Cc: Sidong Yang <realwakka@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/1] btrfs/339: test receive dump stream for different user
Date: Wed, 19 Nov 2025 02:40:30 +0000
Message-ID: <20251119024034.23861-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test receive to dump stream file from different user.

This is a regression test for the btrfs-progs commit cd933616d485
("btrfs-progs: receive: don't use O_NOATIME to open stream for
dumping").

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 tests/btrfs/339     | 32 ++++++++++++++++++++++++++++++++
 tests/btrfs/339.out |  2 ++
 2 files changed, 34 insertions(+)
 create mode 100755 tests/btrfs/339
 create mode 100644 tests/btrfs/339.out

diff --git a/tests/btrfs/339 b/tests/btrfs/339
new file mode 100755
index 00000000..728f3d9d
--- /dev/null
+++ b/tests/btrfs/339
@@ -0,0 +1,32 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Sidong Yang.  All Rights Reserved.
+#
+# FS QA Test 339
+#
+# Test btrfs receive dump stream from different user
+#
+. ./common/preamble
+_begin_fstest auto quick send snapshot
+
+. ./common/filter
+. ./common/quota
+
+_require_scratch
+_require_user
+
+_fixed_by_git_commit btrfs-progs cd933616d485 \
+	"btrfs-progs: receive: don't use O_NOATIME to open stream for dumping"
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+$BTRFS_UTIL_PROG -q subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+$BTRFS_UTIL_PROG -q send -f stream $SCRATCH_MNT/snap
+chmod a+r stream
+_su $qa_user -c "$BTRFS_UTIL_PROG receive --dump -f stream" >> $seqres.full
+rm stream
+
+# success, all done
+echo "Silence is golden"
+_exit 0
diff --git a/tests/btrfs/339.out b/tests/btrfs/339.out
new file mode 100644
index 00000000..293ea808
--- /dev/null
+++ b/tests/btrfs/339.out
@@ -0,0 +1,2 @@
+QA output created by 339
+Silence is golden
-- 
2.43.0


