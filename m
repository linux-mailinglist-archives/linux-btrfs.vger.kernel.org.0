Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284804CA744
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242690AbiCBOHQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 09:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242700AbiCBOHO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 09:07:14 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C48CC5D84;
        Wed,  2 Mar 2022 06:06:12 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c9so1675303pll.0;
        Wed, 02 Mar 2022 06:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMBKYwcYFOxymYKs0xQTitcC8DxVZm2LihisezFoVNM=;
        b=oQKHdskNHm4b8YPCP0eMlaRtu0N2BGvrp76aNy3zSpxzDTRd6oIi8HiLbDrn5L8GBs
         FFytMZr3dyd5Z26v0ksGLuDAiW+XidtxFHcmnybER615PPLaRQpIcisJ2JLsQbW4bUV3
         v1hizQMs3jy/I7MaIVJOOfzgXhBuUIn/M/E6a9qWxlh4vfH6Jhvl3CMtISEtPGip4ljr
         RUlbpeaZsbKaKCVeQ0fhH2pPlpC+bzMAudfbT3aIB6i3kYSygQwSd1Lxa+WxtmmLk1i3
         CspRbi2wojrOJaFmBo0n27Zs8WScXjSrn5gJVV6cXWKTbY9Y1QMxS5ZRQhWCDh9X171F
         iLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMBKYwcYFOxymYKs0xQTitcC8DxVZm2LihisezFoVNM=;
        b=bfPEv3C0ss+7opWz8qi6377WPFOKVSbGtxcoN+vPdyPBkKRjoiFZwwKsGG+VmLKVpx
         sS1/t+31EsqRs7uJ2AHkVEfL2IqXFw+x/RZ21t8XwM1uKnO17a31OC9Fu6MWNiyWYZdB
         SNWVqKe6URAIGQd3A1b1fuysWxtMbGyBHuXjaw1ZSGhErrrZaGgbP5pe/f3J2rr502g3
         jyjqCJUKIslQRha7WltfkBs9Dw84PYln+VrUYprjId6cflPTEj4gUw18LOEsPrveSiKS
         wUEehPRZdvP3EpGn0GAwPcnFolKgjaEs3xn6qH/ycQ2fN5VU5+hERNjRM9Uu81/D8eUe
         0z7A==
X-Gm-Message-State: AOAM532Dw75Y6kfS9TxmWayMxhzDbjj3BZ9/u/zOxJZXvTavoA9xCzY+
        sVfZ8MQCgoBU1RYnVQDFX6HDC1BkS0tiIw==
X-Google-Smtp-Source: ABdhPJy58z9+0AZWk6ta/WtRQTZIim6ToAl86cdTLMnSSw2TWg6yE39WOeTuQKuZiClNVQCRhEp2lg==
X-Received: by 2002:a17:902:6503:b0:14f:d63a:44ea with SMTP id b3-20020a170902650300b0014fd63a44eamr30273803plk.122.1646229971434;
        Wed, 02 Mar 2022 06:06:11 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id y39-20020a056a00182700b004e19980d6cbsm21980164pfa.210.2022.03.02.06.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:06:11 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: [PATCH v2] btrfs: add test for enable/disable quota and create/destroy qgroup repeatedly
Date:   Wed,  2 Mar 2022 14:05:48 +0000
Message-Id: <20220302140548.1150-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test enable/disable quota and create/destroy qgroup repeatedly in
parallel and confirm it does not cause kernel hang. It only happens
in kernel staring with kernel 5.17-rc3. This is a regression test
for the problem reported to linux-btrfs list [1].

The hang was recreated using the test case and fixed by kernel patch
titled

  btrfs: qgroup: fix deadlock between rescan worker and remove qgroup

[1] https://lore.kernel.org/linux-btrfs/20220228014340.21309-1-realwakka@gmail.com/

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2 : fix changelog, comments, no wait pids argument
---
 tests/btrfs/262     | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/262.out |  2 ++
 2 files changed, 42 insertions(+)
 create mode 100755 tests/btrfs/262
 create mode 100644 tests/btrfs/262.out

diff --git a/tests/btrfs/262 b/tests/btrfs/262
new file mode 100755
index 00000000..8953a28e
--- /dev/null
+++ b/tests/btrfs/262
@@ -0,0 +1,40 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Sidong Yang.  All Rights Reserved.
+#
+# FS QA Test 262
+#
+# Test that running qgroup enable, create, destroy, and disable commands in
+# parallel doesn't result in a deadlock, a crash or any filesystem
+# inconsistency.
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs btrfs
+
+_require_scratch
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+for ((i = 0; i < 200; i++)); do
+	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT 2>> $seqres.full &
+	$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT 2>> $seqres.full &
+	$BTRFS_UTIL_PROG qgroup destroy 1/0 $SCRATCH_MNT 2>> $seqres.full &
+	$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT 2>> $seqres.full &
+done
+
+wait
+
+_scratch_unmount
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/262.out b/tests/btrfs/262.out
new file mode 100644
index 00000000..404badc3
--- /dev/null
+++ b/tests/btrfs/262.out
@@ -0,0 +1,2 @@
+QA output created by 262
+Silence is golden
-- 
2.25.1

