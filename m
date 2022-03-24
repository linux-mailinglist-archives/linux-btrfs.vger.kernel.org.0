Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0C4E69C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 21:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352330AbiCXU0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 16:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiCXU0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 16:26:10 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958EBB6E4A
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:24:37 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gh15so4653532qvb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sjeEY3jU8Vd8c3eGSWQ+xXynaeCzBMPJrqgJf3Ui0uw=;
        b=XwdUfPPF7D4EilCq/hxEWlbMSlHYkJhpnl7qmWRP6lToI5fAtH1+IEOcplvRe9UnaR
         d7iHoUv9DMb0EdFsg6CGQpyFr+sqsIQZPea4EiW6wrJ8koO7mOTQkS1UHcxDAup8eptk
         ecjkqrm7Uz6nJKOKMwhtD5FC1qPr0vlQIWvXFpUz+7ZgM7mguHD9niidmCibTkeIb7/5
         SjHn3uMwUr3vOwzQJuewd/Z8oIkysGHI1zzCR7LEN+t6/WKri0LnXbTmkKcJnZbsN56E
         7QzZ3Wbn+fCN+KmO4M6kJH9WZymm92WB92y2U9lk7z8v4DPvnAHLAtJzejL7bxdO4Ah9
         ic+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjeEY3jU8Vd8c3eGSWQ+xXynaeCzBMPJrqgJf3Ui0uw=;
        b=lnibNI45PSufuvcPFKHtxHWn7k2Ygnzi0HIW4bhNWlLcjs4z7tSoZoFSjRDZVi+wwE
         JQuXym1VzKo4hSnompmQ7nDR8FSSypDdHR1+kVW2j03ZJJHOcwAwOS7bytmkjunNCdOd
         Qq4owXnKDy8ocjLJd4zeD6LWuWxJzhUutGtNkpKmlOgfDBEAJ22ConuIccS/76dVaLYz
         Pwbqf9yxmZk/miLi8jRZPGxUcvahr3j7I5lH9UAkZrOiycAXo8Ts+QHrm7+iZ65HFwSx
         k90EGpRDSm3lyOX7YauyTj33//fXVFWCfKxudGfHWOiU92PkcxLUYEtwEQOyQiiGJ6Iq
         vGsQ==
X-Gm-Message-State: AOAM533oPdGcJwd+tk0nnaod/wOTYnzfonWdOKw9nPebMWTCVDwdbFcq
        pqdCnpKIbVkvwfYsHcLiLfApatMjE4VouA==
X-Google-Smtp-Source: ABdhPJxXqUG/e8ozJuntQgLya/Sp5Np1j7ozmlfJjxOy/TAGLqCw8tW5uJavmrZZPyUe1fn47k3RNw==
X-Received: by 2002:a05:6214:20a4:b0:441:43c7:eb85 with SMTP id 4-20020a05621420a400b0044143c7eb85mr5890323qvd.5.1648153476516;
        Thu, 24 Mar 2022 13:24:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l7-20020a37f507000000b0047b528ef416sm2000486qkk.93.2022.03.24.13.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:24:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 1/3] fstests: generic/373: change test to validate cross-vfsmount reflink
Date:   Thu, 24 Mar 2022 16:24:32 -0400
Message-Id: <57a8ad46edcacf08778b16c9eadb603a1638bf17.1648153387.git.josef@toxicpanda.com>
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

We now allow cross-vfsmount reflinks so change the test to validate that
cross-vfsmount reflinks work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/373     | 8 ++++----
 tests/generic/373.out | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/generic/373 b/tests/generic/373
index 2f68b24f..e85308c7 100755
--- a/tests/generic/373
+++ b/tests/generic/373
@@ -4,7 +4,7 @@
 #
 # FS QA Test No. 373
 #
-# Check that cross-mountpoint reflink doesn't work.
+# Check that cross-mountpoint reflink works.
 #
 . ./common/preamble
 _begin_fstest auto quick clone
@@ -49,17 +49,17 @@ $MOUNT_PROG --bind $SCRATCH_MNT $otherdir
 echo "Create file"
 _pwrite_byte 0x61 0 $sz $testdir/file >> $seqres.full
 
-filter_md5()
+filter_otherdir()
 {
 	_filter_scratch | sed -e "s,$otherdir,OTHER_DIR,g"
 }
 
 echo "Reflink one file to another"
-_cp_reflink $testdir/file $othertestdir/otherfiles 2>&1 | filter_md5
+_cp_reflink $testdir/file $othertestdir/otherfile 2>&1 | filter_otherdir
 
 echo "Check output"
 md5sum $testdir/file | _filter_scratch
-test -e $othertestdir/otherfile && echo "otherfile should not exist"
+md5sum $othertestdir/otherfile | filter_otherdir
 
 echo "Unmount otherdir"
 $UMOUNT_PROG $otherdir
diff --git a/tests/generic/373.out b/tests/generic/373.out
index 60f280fc..51f5c62b 100644
--- a/tests/generic/373.out
+++ b/tests/generic/373.out
@@ -3,7 +3,7 @@ Format and mount
 Mount otherdir
 Create file
 Reflink one file to another
-cp: failed to clone 'OTHER_DIR/test-373/otherfiles' from 'SCRATCH_MNT/test-373/file': Invalid cross-device link
 Check output
 2d61aa54b58c2e94403fb092c3dbc027  SCRATCH_MNT/test-373/file
+2d61aa54b58c2e94403fb092c3dbc027  OTHER_DIR/test-373/otherfile
 Unmount otherdir
-- 
2.26.3

