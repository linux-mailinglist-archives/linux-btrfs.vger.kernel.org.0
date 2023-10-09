Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A58C7BE2D7
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376993AbjJIObf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376790AbjJIObe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 10:31:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E686F9D;
        Mon,  9 Oct 2023 07:31:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c877f27e8fso36478265ad.1;
        Mon, 09 Oct 2023 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696861893; x=1697466693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2/ZWEwN8bc+h9iXbc1/2u6d5JYzPwSCiI4r8kbqEgI=;
        b=h2RRH/wfupynHszqGgVUGe1zPykpYaMY0pn+gXa64J8j2dVy4E2xpIkByHi9tE4ERC
         Hiq4vsSSJRpmN+jMJsvbZmWA2LmnBYY76HGyfZ761fSmYP3CR3x9YkNfQlQO+MSrALF/
         PDAHktQDsif3Fp090N/qyYp9CyBX2yUpx3jCgxPIoTx2y+Fpdi71d4NxicDjP+lhkHoh
         osXUQIWv+OuOtKS2XdPd+nIlpwudr3LHDe9FcmR7gxPy4z3/eQ/fbn038HKBkeGMmtlR
         pubNB69ImaGm4wQLa3RKS6z9jffQVv06zZzQXelIPe8KHuh6npNZhnihKe2V+EiapeDv
         5nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696861893; x=1697466693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2/ZWEwN8bc+h9iXbc1/2u6d5JYzPwSCiI4r8kbqEgI=;
        b=PPAdDKaTpI7DmcgzS+aKbWfeWPZPcvxnWKG6X3hndms3i2gsRai8OIxGbVJMNtfOhF
         Zn5YLkpHHZ5SwUshqSjmadZ64hUD1mxf7Tt30qKwdJ163WAqFrk5M/volddQ7RT4ZQzZ
         ZU+69rpMmTL39N9Xa/2zy6fNEz4RbAh0LpnnSo4Q1D8p4KsA+KCutg+W2SiRnBcHuRaZ
         Wn86NaYlz2D33DaASd2d/9eF8Vt4Oob2Q4bzBWKtOQ7Xjo22uRpSdDvg3dmwtvmcqdCv
         0OEiVEbA90GNEWPxEDr4dktfMZQteoN6BbXeoWE1DFZwV4ChnjJAP4MSgMWoQ/Utx/g5
         qBAQ==
X-Gm-Message-State: AOJu0Yzp9F9zAMjUVdiE8xRc4h7AVl1QIDJca5E8PYcBXycXQn/BuYkN
        mBCClkAGHNSrxO+Y3USjCpUCN+IfgvCTog==
X-Google-Smtp-Source: AGHT+IGI85mqs3yLFD4vGAoMoHiCSuprk/1Ko4Cd5/qH4Jkuxi5W2YtVgAKlRb7s+a2qPv/9OaLRYw==
X-Received: by 2002:a17:90a:f996:b0:269:85d:2aef with SMTP id cq22-20020a17090af99600b00269085d2aefmr13961653pjb.20.1696861892925;
        Mon, 09 Oct 2023 07:31:32 -0700 (PDT)
Received: from sidong.. ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id iq21-20020a17090afb5500b0027b0bfa3be1sm10325449pjb.11.2023.10.09.07.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 07:31:32 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs/298: add test for showing qgroups include staled sorted by path
Date:   Mon,  9 Oct 2023 14:31:23 +0000
Message-Id: <20231009143123.9588-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test for showing qgroups include a staled qgroup list sorted by path.
It crashed without checking qgroup has empty path. It fixed by the
following commit in btrfs-progs:

cd7f1e48 ("btrfs-progs: qgroup: check null in comparing paths")

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 tests/btrfs/298     | 34 ++++++++++++++++++++++++++++++++++
 tests/btrfs/298.out |  2 ++
 2 files changed, 36 insertions(+)
 create mode 100755 tests/btrfs/298
 create mode 100644 tests/btrfs/298.out

diff --git a/tests/btrfs/298 b/tests/btrfs/298
new file mode 100755
index 00000000..5457423d
--- /dev/null
+++ b/tests/btrfs/298
@@ -0,0 +1,34 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Sidong Yang.  All Rights Reserved.
+#
+# FS QA Test 298
+#
+# Test that showing qgourps list includes a staled qgroup without crash.
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup
+
+ . ./common/filter
+
+_supported_fs btrfs
+_require_test
+_require_scratch
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+# Create stale qgroup with creating and deleting a subvolume.
+$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT >> $seqres.full
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
+$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/a >> $seqres.full
+
+# Show qgroups list with sorting path without crash.
+$BTRFS_UTIL_PROG qgroup show --sort path $SCRATCH_MNT >> $seqres.full
+
+_scratch_unmount
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/298.out b/tests/btrfs/298.out
new file mode 100644
index 00000000..63434267
--- /dev/null
+++ b/tests/btrfs/298.out
@@ -0,0 +1,2 @@
+QA output created by 298
+Silence is golden
-- 
2.34.1

