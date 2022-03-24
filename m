Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4154E69CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 21:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353380AbiCXU0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 16:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353376AbiCXU0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 16:26:12 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121E8B7C7E
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:24:40 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id kk12so4618354qvb.13
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=k61841+rsGfDmVsNao06UICtoAksEtwqkR900e6cGEE=;
        b=77cQ7v1RqFu0/DFodNlZXoOK61GN3xP7Fo+XTU8SJSSLNvWeTpGhcgw8nSoZSaGcKO
         dIX6DVgJbUDt9YAwJPjaO1pwYzmgS3UvjOH0anV7z3K2OWh8yc0J88ryDzhPzrRdAahY
         aVl3XVXx7AuwBngUG5X3zMHryr5Qd2Li6lnEq+eR2AQzRhVNxRR3KyQMVFBIpMxCoGIT
         rdzqCD7ei4KvC9CVEhHPZW6PeCPoHUDmIgtStDCV6e7YZa1SxYVr4R2ziK7Fwqib8YNQ
         9wyilWruW1GCMpH0f/hrA6o9gZ7T/cqoUTH8ptmw5e60DUdOeQQk4TltUCZOJMR9AEkm
         WIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k61841+rsGfDmVsNao06UICtoAksEtwqkR900e6cGEE=;
        b=fpWuIobz5pq+Csngt+LA8jTD2y0uEpf5XTSKVLFyffet4ALJIuPllGf3EQErXY/tJ6
         Byx0rk81nZlSs6vbrt8MU+CVe+MzfsdrosHDyqaXJPdLIVKSbEWdFVSLiDsogYUiUAyU
         7rlYyzvV+65fnCuZ1FQU/pAAuD/BKCa5wN02pbkrd8UWlExdwKqFp+RI0drC4C3TOHvi
         HlC6AzHRiiSzWRls9otf5VkZ9fBo5yoyRhUpN10H0ecbwdclNYa+JDCkPiuZDL1PGRgG
         PD0mDjmt3oEzs5hUJzjkhVYKUFnZrEDgKUFmr6BDml7IjrpbFpVQGonKyeLHlQ7xqQrx
         10kA==
X-Gm-Message-State: AOAM532ybr/vODzcVigPMpOAWlaZE1fnzoNTrIlAcXNvc4xbSD1d7fgb
        /qbYJ0kQTcGbac2Euelp0Yykyb6FRZS42A==
X-Google-Smtp-Source: ABdhPJwMJNFp4U3OVJEBP6kOkuHyeu+BKXVXuq5C2IEcXOosctMMQ4E252XyE/zx7tcnPpMPOhmk7Q==
X-Received: by 2002:a05:6214:21e4:b0:441:248a:9823 with SMTP id p4-20020a05621421e400b00441248a9823mr5747052qvj.35.1648153478941;
        Thu, 24 Mar 2022 13:24:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q8-20020a05622a04c800b002e06d7c1eabsm3142437qtx.16.2022.03.24.13.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:24:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 3/3] fstests: btrfs/029: change the cross vfsmount reflink test
Date:   Thu, 24 Mar 2022 16:24:34 -0400
Message-Id: <381ad867bdd09a98b5fdad0534fc5fb2b235ece7.1648153387.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1648153387.git.josef@toxicpanda.com>
References: <cover.1648153387.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We now allow cross vfsmount reflinks, change this test to make sure we pass the
cross-vfsmount reflink.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/029     | 60 ++++++++++++++++++++++++++-------------------
 tests/btrfs/029.out |  3 ++-
 2 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/tests/btrfs/029 b/tests/btrfs/029
index 1bdbc951..94886788 100755
--- a/tests/btrfs/029
+++ b/tests/btrfs/029
@@ -5,14 +5,15 @@
 # FS QA Test No. 029
 #
 # Check if creating a sparse copy ("reflink") of a file on btrfs
-# expectedly fails when it's done between different filesystems or
-# different mount points of the same filesystem.
+# expectedly fails when it's done between different filesystems but
+# not for different mount points of the same filesystem.
 #
 # For both situations, these actions are executed:
 #    - Copy a file with the reflink=auto option.
 #      A normal copy should be created.
 #    - Copy a file with the reflink=always option. Should result in
-#      error.
+#      error for different file systems, but succeed for the same fs
+#      but different mount points.
 #
 . ./common/preamble
 _begin_fstest auto quick clone
@@ -31,38 +32,47 @@ _require_cp_reflink
 reflink_test_dir=$TEST_DIR/test-$seq
 rm -rf $reflink_test_dir
 mkdir $reflink_test_dir
+orig_file=$SCRATCH_MNT/original
+copy_file=$reflink_test_dir/copy
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
-$XFS_IO_PROG -f -c 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/original >> $seqres.full
+$XFS_IO_PROG -f -c 'pwrite -S 0x61 0 9000' $orig_file >> $seqres.full
 
-_create_reflinks()
-{
-    # auto reflink, should fall back to non-reflink
-    rm -rf $2
-    echo "reflink=auto:"
-    cp --reflink=auto $1 $2
-    md5sum $1 | _filter_testdir_and_scratch
-    md5sum $2 | _filter_testdir_and_scratch
-
-    # always reflink, should fail outright
-    rm -rf $2
-    echo "reflink=always:"
-    cp --reflink=always $1 $2 >> $seqres.full 2>&1 || echo "cp reflink failed"
+echo "test reflinks across different devices"
+# auto reflink, should fall back to non-reflink
+rm -rf $copy_file
+echo "reflink=auto:"
+cp --reflink=auto $orig_file $copy_file
+md5sum $orig_file | _filter_testdir_and_scratch
+md5sum $copy_file | _filter_testdir_and_scratch
 
-    # The failed target gets created with zero sizes by cp(1) version 8.32. But
-    # in older cp(1) version 8.30 target file is not created when the
-    # cp --reflink=always fails.
-    ls $2 >> $seqres.full 2>&1
-}
+# always reflink, should fail outright
+rm -rf $copy_file
+echo "reflink=always:"
+cp --reflink=always $orig_file $copy_file >> $seqres.full 2>&1 || echo "cp reflink failed"
 
-echo "test reflinks across different devices"
-_create_reflinks $SCRATCH_MNT/original $reflink_test_dir/copy
+# The failed target gets created with zero sizes by cp(1) version 8.32. But in
+# older cp(1) version 8.30 target file is not created when the cp
+# --reflink=always fails.
+ls $copy_file >> $seqres.full 2>&1
 
 echo "test reflinks across different mountpoints of same device"
 rm -rf $reflink_test_dir/*
 _mount $SCRATCH_DEV $reflink_test_dir
-_create_reflinks $SCRATCH_MNT/original $reflink_test_dir/copy
+
+echo "reflink=auto:"
+cp --reflink=auto $orig_file $copy_file
+md5sum $orig_file | _filter_testdir_and_scratch
+md5sum $copy_file | _filter_testdir_and_scratch
+
+# always reflink, should fail outright
+rm -rf $copy_file
+echo "reflink=always:"
+cp --reflink=always $orig_file $copy_file >> $seqres.full 2>&1 || echo "cp reflink failed"
+md5sum $orig_file | _filter_testdir_and_scratch
+md5sum $copy_file | _filter_testdir_and_scratch
+
 $UMOUNT_PROG $reflink_test_dir
 
 # success, all done
diff --git a/tests/btrfs/029.out b/tests/btrfs/029.out
index f1c88780..c4971fcb 100644
--- a/tests/btrfs/029.out
+++ b/tests/btrfs/029.out
@@ -10,4 +10,5 @@ reflink=auto:
 42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/original
 42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/test-029/copy
 reflink=always:
-cp reflink failed
+42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/original
+42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/test-029/copy
-- 
2.26.3

