Return-Path: <linux-btrfs+bounces-19120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA6DC6CCE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 06:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B70213598CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 05:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A1F30E0F5;
	Wed, 19 Nov 2025 05:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm70g/I2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367B30DED4
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 05:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763530133; cv=none; b=nVYqtCdSv6KwwLb/trVtGa34nz91sAy6vYbzVUx4C+syJkYx2N5mTo9+TSVSEj7lB8DIBZt3jeVTfk7x7MxjEcMkBn5eq8k4TTLKKzqADi3Ewj/rWC0Oa3ZTP73D1lUFOaZXYuAVZ/xmpQUmQPTUsTgYSjjjg2tOAIgbtPUiBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763530133; c=relaxed/simple;
	bh=9m0a8QPgpKc6HmMzT1xImeywJm0DD/RnM2OBy01xScQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+qZw7KUMQU/9dWWI1zJlom85Y6mPMYloMUMjye2Lb9RJ3BvgSyQqAnAxip03HZDPq4edfMQmZ9jtRxGXAXpO7AofeTPlCUBoGAzU+NRXViusCUMYxYcPqCLA/2KPCMo75vaBuSTMdqHO8snT/9v6PKzAYBSnUkUHGcOCzQ8v/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm70g/I2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297e264528aso62744895ad.2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 21:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763530131; x=1764134931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iR0sJvfw4uf1Jgj8AnppRzdedBXKraUW175zFR04z8Q=;
        b=Tm70g/I2cvrnpBtiQuul16CRiBZ7G36E1nFUk4EzmMllHhOkiK9DQJQyUwnZwsIPJ5
         f+Nvmzf37U8t/1fXPLVRiNkZ/57oJ+31hJpBYjfYUpMHUZ82YUK+GucZX4MYT80yVbGL
         5HznJCEKG/8wwYcJSKLE1rWgqC9KcHM1jOTJ6myyXleDjuX2L5ZoPfsDvtQN8JQkxddr
         WbrDVeiXm9+u3Se8rJgEcHJ1i7U9qDUy/vgHa9DS+Vvts7xKFFCIggJ9OYSWOVLlAdhQ
         QEiSY5BeF+mtrqTkub7QFMX/YMcWP2La3UtMmexLoMM/55QgpjB6Pk7v+6JdT+3VK19t
         xDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763530131; x=1764134931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR0sJvfw4uf1Jgj8AnppRzdedBXKraUW175zFR04z8Q=;
        b=lHUy9lnfQ5sIARpju5Y7QSZDocKz7BmQcqJL/nbQ1Dbuvo0f7JZI1KQ1SC0gwM2l1G
         D6samEje160mGpgXXVUcCtX6uVXFtP5PsW+v9uEyYbVAt0RoFYVOE8++vlBNmOz4n76u
         0aei5xDjaUj8xiWzyyV9QzpN5F5ZWVHElGOoyA45LrOjTVyx3KN8pL6XNXuvTcWZpeBg
         AcsrP2p7Ba0Hz9Unlwn05liJy5ehkDwxGVbnQjCBPrAJ7HelA1olfRrXuwD+pGYsFKDe
         gCpnngDMw7gWnKkpag97mJnr71pUyJcPknPcHM2yHbQsAFwdBM2KvesP19MAhJMV5GZy
         wpKw==
X-Forwarded-Encrypted: i=1; AJvYcCVvmyOcfTUj3oQY5x9TM12PcjKu/4c1KM6wR38kEhAu8RtTYzcocnw37ybrjH+KJ2BTDb6jFiGBylzcow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXq/J4syF5YPep4FYpziFebzGfvD9LgaRH2sRN+g+JHmOa+cMV
	wpY+4MZ/rfZ6B1FEVVea6Nvb244TdOdNVtLIJbNXJLzoC1+BxFeklofQ
X-Gm-Gg: ASbGncvt3156iNn54bofXDQOGp+dSDwQRX8kMkDIUCHjQE2+5KKQeqku/N9qXrYeUR4
	zT/CpgAoKADBb8d6Y3W/xpFIF3iiY8q6uJmcjwJMRVOmVqt+tf6Okz4o2s9KMOUIFS1QDkvxGvl
	lV2PLE3sOcagEq48YsWVy2PGclXcznd45TyLq5/zAnqX6yy5qEboxjnTLZoIZ9uWHbGifTLauxW
	0pTC3cw2Y8yi6dS61ikLdf5E7RdvmRb0pmAU6X4CoEd2WqZeEYY20ExrNK7upEEPSoHkiZ7iVUu
	Z5LpXR9iHBnBO3pMGpKfTkqXI9Li7NYplltAL89DFpup2MBevumELOs0pJRegX13TTLP+kXf7zz
	Nzv2lFgusEDBQlRaA+j7Ko9NfYsYwX4RcV5kWRgiEQtYPdDMhbsdN+/FuT5Y8ASU/NaM176UEZE
	DEFY03K4zzhPG6DAZcr5pS9GdizVWxe/HysIkVx6Ejy7d9bA==
X-Google-Smtp-Source: AGHT+IEO9jo/Iiv5ho98MxxBAyb+hrDpz0h2Pxi7Y/slQ7TRuaG2jDxOhcUGxICef4Ryke51PpYALQ==
X-Received: by 2002:a17:902:c412:b0:295:8dbb:b3cc with SMTP id d9443c01a7336-2986a74a182mr217342655ad.42.1763530131303;
        Tue, 18 Nov 2025 21:28:51 -0800 (PST)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2986e54f019sm156245215ad.15.2025.11.18.21.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 21:28:50 -0800 (PST)
From: Sidong Yang <realwakka@gmail.com>
To: fstests@vger.kernel.org
Cc: Sidong Yang <realwakka@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/1] btrfs/339: test receive dump stream for different user
Date: Wed, 19 Nov 2025 05:28:42 +0000
Message-ID: <20251119052843.35108-1-realwakka@gmail.com>
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
---
 tests/btrfs/339     | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/339.out |  2 ++
 2 files changed, 42 insertions(+)
 create mode 100755 tests/btrfs/339
 create mode 100644 tests/btrfs/339.out

diff --git a/tests/btrfs/339 b/tests/btrfs/339
new file mode 100755
index 00000000..0df24577
--- /dev/null
+++ b/tests/btrfs/339
@@ -0,0 +1,40 @@
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
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
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
+stream=$tmp.fsv.ss
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap >> $seqres.full
+$BTRFS_UTIL_PROG send -f $stream $SCRATCH_MNT/snap >> $seqres.full 2>&1 || _fail "send failed"
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


