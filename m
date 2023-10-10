Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37AD7C4130
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjJJU0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjJJU0g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:26:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25C3E3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:26:31 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7c08b7744so13659217b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969591; x=1697574391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYV6W3/su+yQdVC08/W92yX/IiZTkZ+W2IG1K67YFEE=;
        b=CPK4WauFk1tak6CV4zolZKCy2JoVv3UUf4yWBpQfTiBhaILnk+HeLUugwYR8nYSbVI
         7CeUnXcXyOt4UiHr9lmuNXveqR/1ixvdEdQ3cFbkkf0UuNyp/izAqT/UB/NPkFOcIguz
         8vILIO+nbjucFHTxOfZsG/25fd6saUXsSvFJck9uYp8GK4UaT6wm0XkTXIM+J38m4ViR
         Pbz4H7jfOFBQRuklnOGR7MxR9R5F031vYM1wUTPJgRETZxJHXEZ/N1kole5je1IB9mmA
         db3L87VU5hmk2mnxVBae68d1mJwCPMb73kRE76k9oJdJPZsbogxg7G90Tdssfhg+KIef
         XOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969591; x=1697574391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYV6W3/su+yQdVC08/W92yX/IiZTkZ+W2IG1K67YFEE=;
        b=F0KPgvMh2QS8yok3Tg6ElBCLg9a5ksusKdAe0YBbfymKZr6s9RnjMC/i3rQ1h5HG4z
         mz1GS+7c74NSTzeg8yoDWNfzAYCsu7mRh7Lwosmx+ZrbB2lgaWfcvEwRfyTdscANycyQ
         lztMl6ohEYlbqgqG2mkAJXONfg7eI2hhus0dmtJSWpzW9zrnsLEAJGVJD5vjA4EWvvzr
         47n55fKWd9zubhB7aO5HDZTZzRUomVdDcdQ/b7/pbb1mALE8lj66ZXRlyYFJbB29CIXW
         rCzJm487KJQaKBi3w3iPpSaSzKGOk2uNV+dL5lnclLLjK5SqPHvN+zk4CM01tlhjxqZQ
         2ybg==
X-Gm-Message-State: AOJu0YwX6bE7jKtxzw36rPZ85WsZ5m0fKVDTVTwDqFZx0rDFplApSfhX
        VxAXwSTYV6DW+CGx79b/6o7M9g==
X-Google-Smtp-Source: AGHT+IGvgRhnxM8rs8Q4ccehZoHcRELzxu4LMU2pLr32V5AjQW8wniDsc5M8y0GOBrzOZ5UXLUl+cw==
X-Received: by 2002:a0d:ea90:0:b0:5a1:db12:d782 with SMTP id t138-20020a0dea90000000b005a1db12d782mr19988174ywe.44.1696969590781;
        Tue, 10 Oct 2023 13:26:30 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c4-20020a81df04000000b0059b1e1b6e5dsm4581610ywn.91.2023.10.10.13.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:26:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 12/12] fstest: add a fsstress+fscrypt test
Date:   Tue, 10 Oct 2023 16:26:05 -0400
Message-ID: <936037a6c2bcf5553145862c5358e175621983b0.1696969376.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696969376.git.josef@toxicpanda.com>
References: <cover.1696969376.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed we don't run fsstress with fscrypt in any of our tests, and
this was helpful in uncovering a couple of symlink related corner cases
for the btrfs support work.  Add a basic test that creates a encrypted
directory and runs fsstress in that directory.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/736     | 38 ++++++++++++++++++++++++++++++++++++++
 tests/generic/736.out |  3 +++
 2 files changed, 41 insertions(+)
 create mode 100644 tests/generic/736
 create mode 100644 tests/generic/736.out

diff --git a/tests/generic/736 b/tests/generic/736
new file mode 100644
index 00000000..0ef37d7e
--- /dev/null
+++ b/tests/generic/736
@@ -0,0 +1,38 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2023 Meta
+#
+# FS QA Test No. generic/5736
+#
+# Run fscrypt on an encrypted directory
+#
+
+. ./common/preamble
+_begin_fstest auto quick encrypt
+echo
+
+# Import common functions.
+. ./common/filter
+. ./common/encrypt
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch_encryption -v 2
+
+_scratch_mkfs_encrypted &>> $seqres.full
+_scratch_mount
+
+dir=$SCRATCH_MNT/dir
+mkdir $dir
+
+_set_encpolicy $dir $TEST_KEY_IDENTIFIER
+_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY"
+
+args=$(_scale_fsstress_args -p 4 -n 10000 -p 2 $FSSTRESS_AVOID -d $dir)
+echo "Run fsstress $args" >>$seqres.full
+
+$FSSTRESS_PROG $args >> $seqres.full
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/736.out b/tests/generic/736.out
new file mode 100644
index 00000000..022754df
--- /dev/null
+++ b/tests/generic/736.out
@@ -0,0 +1,3 @@
+QA output created by 736
+
+Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-- 
2.41.0

