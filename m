Return-Path: <linux-btrfs+bounces-19484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F29AFC9EE1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 12:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E5F334BA0D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDED82F60CA;
	Wed,  3 Dec 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcE9i+ID"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B12F5A3E
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762224; cv=none; b=sUxaV6Zly61c8Wc4Sm3eSbXF9RO4CIYz7UZYMWlWFEguRc4cjhhF+UCD1Q6Eue4jEFyu91TrY2Eu2bWpbtDYWbmdS82xmDpVurCWC0Un01qR5debK29LZHo36qyyRBw4eUyjnPxB0MwNAETmJggWkcJd4+bg7CR4C8kN/ockxhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762224; c=relaxed/simple;
	bh=oBkvuCBrbfVyaeM5v/bY5mEWKjFvn1fVUN27hwHehX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BfJFEkfO4GUaCqDG/4ggAVvJMAojy1sSfLsk6UhbM6sc/hVzuRh1zEbkdpz9JCCzMkiWSz+1V5rb40slc6aKmob0JFCgRBdnbntIXIkpmaa1o5blxipr1blGo1zeehkDyuQs2izhYwgfH8C35o9b6NtnTPWh9NR8R0HrkUZCD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcE9i+ID; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7ba55660769so5647348b3a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Dec 2025 03:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764762222; x=1765367022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmzrPAt9kb7dexvB71oGQlxWay34k4ETfXHiGvlbouI=;
        b=EcE9i+IDiqq/P/K7rUeAZEBFACjDGz+DczOxx2s53yvpZpl8Aup8ma1v7pmlJMyPpB
         UKhzumzt65BsdA9tPlSQTUEzkE8V9KeNQ0HbVSfCRTc9xgWFzKZAd3HkKDm422WAUZwH
         FZZ4EaSI64wya6LF3LJa0HOHjl+g0YvXI7E8+EATXlH/GPWEyLm29J7/Z2NnAytiN7k3
         kC4uFeCty7ECLlp9ct37P9rsiMbsKttgnVbYEBBYY7p3ARJTlZarmCNyRQcqcz8/gBmS
         HFc+bajyPQmhF5Y9V/aq4Pgqgiea6UnONs6CKDHhEVKgu5ArUoyZlEiUkn6f0L3rQM14
         REHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762222; x=1765367022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmzrPAt9kb7dexvB71oGQlxWay34k4ETfXHiGvlbouI=;
        b=LWWrjuReg/7Ru/wZcU+4GyJ8ymo7BjBYuGyX7k9sQzf7AscsaSSXJ/l2GQ3ZCdXZMn
         IzUq49Klj4s/JPM1+4IEdhwYZtQ9t6rpnDwwV0BGsd2gS4Y1OO/QlI5QUFtiQu9Yw853
         oocbgQ/Suu2g1lBoVR6dzLjUl0NZ1HBmyrzEtMmlW2/kfnBOObRlvkVyoSfPzP7GZ+ar
         SvA+c3BlyRtnj7pzgohUyBMbiOThpdFZfZv4kJr/pR+cPu5lDYUEZ9Kx4ZOGryURXpEe
         eXbFPvSlIP2iDmB2BAzUXUvTwQoFd/qmnCq+oBOvaWLMX2+QwGKo8vBLCdrP6r586Se1
         WgTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7/Zovca/F//IgussAnAKQ3mE1EyOoaexNGxRuRoQM3H8G82qiQO9mAujdKMZbP0rC99MBejvoct6qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGNGqG7fn6uL1c56xiAPd/USv0bmPRweuvP3Bs9vaeOUoBgO7
	QDY7oKTBHEvtfIPyVwsraDcHmrHPEEI8JOnOpVnPvJ03Y/ySSBkB+amf
X-Gm-Gg: ASbGnct5OiA5Ev1GmSHC1deenfqfvesljGYMUiFHsqhGXO9/mb075thJsnowfG31szI
	Bpa56ImpEyArUFvQg94OZHjNJxbNCVOezz5Z8I78DqQp8IdGazRFdwS+BxOUM8PgYMNMPgambZQ
	pLzrcYIZLTswmKV/BsqXqESvopmYTWCFQ6e75O5e+v6JUT8jRMFWAyQuHwI0GPm2j9LvmbnXQWs
	hwuteOvLXDl5NbEBhzwXuwIiHtNF34g/Z/3nKnNDhjb/woxCaro0Sg5GB+5vje3g4p9QN5CUSth
	cGC6PswBcQJNSbLCQPa4bYKmpWkXCwwnjCkU8LeC1bAcG+S5wotyByC0swmII47C+TtOyHVMtNp
	haVw8vTe+JF1dmgwDzQh2DC66WA1eHXG8fL1f8XmGJgqnwzkzgi1+NJtdtFUwzjU1pKnJkVXSgI
	uK9NCmfIo0thZQHZIoct00GKYBLgtFpHszTT46jRDjZqVM9A==
X-Google-Smtp-Source: AGHT+IHdnFsa4ffMwlnwovXZJPD+rbcRmchS4n60kAyf+dDPYEYAQF73K96zE7yxTNdTWdV8fOAbDg==
X-Received: by 2002:a05:6a20:3942:b0:2ea:41f1:d54a with SMTP id adf61e73a8af0-363f5eb6172mr2466088637.55.1764762222362;
        Wed, 03 Dec 2025 03:43:42 -0800 (PST)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4f5f3416bsm12826672a12.0.2025.12.03.03.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:43:41 -0800 (PST)
From: Sidong Yang <realwakka@gmail.com>
To: fstests@vger.kernel.org,
	Filipe Manana <fdmanana@kernel.org>
Cc: Sidong Yang <realwakka@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/1] btrfs/339: test receive dump stream for different user
Date: Wed,  3 Dec 2025 11:43:25 +0000
Message-ID: <20251203114328.10386-1-realwakka@gmail.com>
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
v2:
- forward to $seqres.full rather than -q
- use $tmp for stream file
v3:
- use _btrfs than $BTRFS_UTIL_PROG
- remove unnecessary cleanup, requirement
---
 tests/btrfs/339     | 32 ++++++++++++++++++++++++++++++++
 tests/btrfs/339.out |  2 ++
 2 files changed, 34 insertions(+)
 create mode 100755 tests/btrfs/339
 create mode 100644 tests/btrfs/339.out

diff --git a/tests/btrfs/339 b/tests/btrfs/339
new file mode 100755
index 00000000..234a9ea0
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
+stream=$tmp.fsv.ss
+
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
+_btrfs send -f $stream $SCRATCH_MNT/snap
+chmod a+r $stream
+_su $qa_user -c "$BTRFS_UTIL_PROG receive --dump -f $stream" >> $seqres.full
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


