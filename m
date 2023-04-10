Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9B6DCA88
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Apr 2023 20:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjDJSLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Apr 2023 14:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjDJSLn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Apr 2023 14:11:43 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07EB211D
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 11:11:42 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id ek19so3787010qvb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1681150301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDetk/ZcPa1/O+q5LxgrOvvrINk/K7rb1TrNcZk/pmw=;
        b=tX/i1r7kI36cAiF5hhpeIh4jjQr3Ii5WRsziWsbX/Q5n72M53OfE21Q4IiQhQhzjUB
         y+nzhM1ar7DhRUeDS2IWoz4d+AeOHTII1181pB7lLFtCGiVSGYJ7cSTPDAaF/ksIJ20c
         p07OSAfTv5D82bwwu9pONucsETyGfVX6V61dUovcAYlDKnQkUDAi7g/kZLaxfw+7anvh
         A52japNABybyNMkHWZVdU9gFHtzz+MuEV7AiGpgXbtSLQK15pHiXl7A+vf8ePWqNbG/A
         mxUQBjw1Gve9CAcbz5D6Be5pKBslve1aSC0qGbUSYr8Rf+gAyg0m+jlQ6y8JgXfAKGSl
         Wrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681150301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDetk/ZcPa1/O+q5LxgrOvvrINk/K7rb1TrNcZk/pmw=;
        b=NLTE7R8HeCMgJMnxkoTdfMKIbVCAylYXQJBhl7sT+hkPTiayMePxbTwc0W/kaG5219
         b6mMRIf08W23kJdlRdnqTDy/y0/TZgFQ90awy80MYgLQakwI0DSWOPjgOWymDOTlb71b
         vV25yG72M0OeNKFVGxWp71/e6uxaSSn/IIObZxoADxUP9U2hAd21YdEZwNNwWAR/dUo7
         H9v7RyytfRZBZlgmCneaKBP3TN9EnlQ5DEzY8gLc3gR3OhKqROze2T8zo5ooK67BwXlA
         YUIYkicTixwdvZh/wTdphoDwg4PuaTEt1dNTCfhhLJelOdmnz3ilyVNBpEaYkBW3emgU
         7E2Q==
X-Gm-Message-State: AAQBX9e1/P2b4WZLXbn+slVQFLuYkkxw+1+O+qMPbTwtr5skPyuDy6FS
        nZJ0dmaQUMZBz5feRosIwYH97Wt6JbkxeWfEvts3BA==
X-Google-Smtp-Source: AKy350bAe9HNV8NzVkPguRndVCf1piEsG0IZl6C1W7B4dRlhm+t7nu/EO5NS0PkY3PDo3Ck9CNFhZQ==
X-Received: by 2002:a05:6214:1d24:b0:5cc:75c7:8f19 with SMTP id f4-20020a0562141d2400b005cc75c78f19mr19329656qvd.10.1681150300212;
        Mon, 10 Apr 2023 11:11:40 -0700 (PDT)
Received: from localhost (hs-nc-a03feba254-450087-1.tingfiber.com. [64.98.124.17])
        by smtp.gmail.com with ESMTPSA id b4-20020ac84f04000000b003e6499b7d56sm3131581qte.88.2023.04.10.11.11.38
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 11:11:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs-progs: fix fsck-tests/057 to run without root
Date:   Mon, 10 Apr 2023 14:11:32 -0400
Message-Id: <2af7c2b6d02828efdb5821e1219eb34cd710e432.1681150198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681150198.git.josef@toxicpanda.com>
References: <cover.1681150198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The setup_root_helper needs to be called before messing with the loop
devices, and btrfs check needs to be run with $SUDO_HELPER.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/fsck-tests/057-seed-false-alerts/test.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/fsck-tests/057-seed-false-alerts/test.sh b/tests/fsck-tests/057-seed-false-alerts/test.sh
index 1d5ad878..4af83c92 100755
--- a/tests/fsck-tests/057-seed-false-alerts/test.sh
+++ b/tests/fsck-tests/057-seed-false-alerts/test.sh
@@ -10,14 +10,14 @@ check_prereq mkfs.btrfs
 check_prereq btrfstune
 check_global_prereq losetup
 
+setup_root_helper
+
 setup_loopdevs 2
 prepare_loopdevs
 dev1=${loopdevs[1]}
 dev2=${loopdevs[2]}
 TEST_DEV=$dev1
 
-setup_root_helper
-
 run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev1"
 run_check $SUDO_HELPER "$TOP/btrfstune" -S 1 "$dev1"
 run_check_mount_test_dev
@@ -32,8 +32,8 @@ sprouted_output=$(_mktemp btrfs-progs-sprouted-check-stdout.XXXXXX)
 
 # The false alerts are just warnings, so we need to save and filter
 # the output
-run_check_stdout "$TOP/btrfs" check "$dev1" >> "$seed_output"
-run_check_stdout "$TOP/btrfs" check "$dev2" >> "$sprouted_output"
+run_check_stdout $SUDO_HELPER "$TOP/btrfs" check "$dev1" >> "$seed_output"
+run_check_stdout $SUDO_HELPER "$TOP/btrfs" check "$dev2" >> "$sprouted_output"
 
 # There should be no warning for both seed and sprouted fs
 if grep -q "WARNING" "$seed_output"; then
-- 
2.39.2

