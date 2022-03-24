Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34304E69CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 21:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiCXU0L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353378AbiCXU0L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 16:26:11 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2762B820A
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:24:38 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d15so4908157qty.8
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0ROhuF/DBDDJeFGZ3bLA5tk3lQSNbzKO1boaIqC2drI=;
        b=abK/wTL7VA6cxfPk4bMGuN4XxMLr43lLxoM6dDw1oilQBRyk1iYTFHiV0KZuTJbhOs
         nCc0g7DxbqjlzLXt1Kcvzf3K8Tk8IkP2wMPf6VrooDkWHctvWx/++A75wB+jvKLsjdXj
         Cbbm+ejQ9SwZx6RleqEDKoWfKoV/qeSCTj11XO2mE5ZVIpiPDPr0HDH8zgbMRvU4DQ6A
         Em5arvm1NX92WqXcKUicjx1L5HYsKc2h19eAwrEQ8BTjJS4GvrO+9XAIg7eRbCFgfveo
         FNX/TCpadPovGEV2SVGW+MQ3J2aHWicNG9pt+XQkrSm+bMKsY5woVi8x/ejkBoCfwHL4
         8dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ROhuF/DBDDJeFGZ3bLA5tk3lQSNbzKO1boaIqC2drI=;
        b=Dq0D/IlX8aH+VtlWnpyh3aKZh+6tL4GSxCHVCgg1ezyaX5QGtJrXznBjp0W6APMR+H
         cZBmUKnI5iEVdnNWETMK/i2L1alaYNzGGPKqJOvMS6A5+3OmXmEsBrjpZatFSkXST+3o
         8qDOdcOQDZ1yRVBxlbYZ3i8wF8vnJICVPaSkJ9VQ6oFMjzIskQFPWFKFqH7O/d/UzDj9
         G3Dh+s04ro0VxYm6I/q31DlgXNz/pF17M8Wr9jN8YvYs3lAXk+isQguxdtrAOJqJOIoy
         0mHUArnrl33C5RPLksCDT9REvYb75i25eDM5QyG4FWJ8U8+8sit6uiiQrLFfcRWws0D8
         +Xlw==
X-Gm-Message-State: AOAM533DWlcYtu33J74+HZWtWvQYpN3BToxzpRtXuYuSNd0csv4HuNAx
        9FBwRmkTNl9pZPbkQkqEMUmQSW6E8Uyu+g==
X-Google-Smtp-Source: ABdhPJwRBt8CYjpkvIguaC47NsWis0oxOHKUBY/10fiaDu1oMmNvF8ql8ywO4MHiqYk7+j5Wsh232Q==
X-Received: by 2002:ac8:5a50:0:b0:2e2:31ab:7303 with SMTP id o16-20020ac85a50000000b002e231ab7303mr6270702qta.66.1648153477686;
        Thu, 24 Mar 2022 13:24:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bs10-20020a05620a470a00b00680ae2f3decsm569265qkb.8.2022.03.24.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:24:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 2/3] fstests: generic/374: validate cross-vfsmount dedupe
Date:   Thu, 24 Mar 2022 16:24:33 -0400
Message-Id: <bad40a464e1728309e185a031e8d3652c22b68cf.1648153387.git.josef@toxicpanda.com>
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

We allow for cross-vfsmount dedupes now, change this test to validate dedupe
works properly cross-vfsmount.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/374     | 5 +++--
 tests/generic/374.out | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/generic/374 b/tests/generic/374
index d9f33bc3..f66d1397 100755
--- a/tests/generic/374
+++ b/tests/generic/374
@@ -4,7 +4,7 @@
 #
 # FS QA Test No. 374
 #
-# Check that cross-mountpoint dedupe doesn't work.
+# Check that cross-mountpoint dedupe works
 #
 . ./common/preamble
 _begin_fstest auto quick clone dedupe
@@ -50,7 +50,8 @@ _pwrite_byte 0x61 0 $sz $testdir/file >> $seqres.full
 _pwrite_byte 0x61 0 $sz $testdir/otherfile >> $seqres.full
 
 echo "Dedupe one file to another"
-_dedupe_range $testdir/file 0 $othertestdir/otherfile 0 $sz 2>&1 | _filter_dedupe_error
+_dedupe_range $testdir/file 0 $othertestdir/otherfile 0 $sz 2>&1 \
+	| _filter_xfs_io
 
 filter_md5()
 {
diff --git a/tests/generic/374.out b/tests/generic/374.out
index 3243ad3d..b62c64b4 100644
--- a/tests/generic/374.out
+++ b/tests/generic/374.out
@@ -3,7 +3,8 @@ Format and mount
 Mount otherdir
 Create file
 Dedupe one file to another
-XFS_IOC_FILE_EXTENT_SAME: Invalid cross-device link
+deduped 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Check output
 2d61aa54b58c2e94403fb092c3dbc027  SCRATCH_MNT/test-374/file
 2d61aa54b58c2e94403fb092c3dbc027  OTHER_DIR/test-374/otherfile
-- 
2.26.3

