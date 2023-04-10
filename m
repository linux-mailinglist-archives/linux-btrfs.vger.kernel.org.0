Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552096DCA87
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Apr 2023 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjDJSLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Apr 2023 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjDJSLk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Apr 2023 14:11:40 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBF9CF
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 11:11:39 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a23so3003370qtj.8
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1681150298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5LOafPib8IS/uhwsznow4aO6Exeoh/RG+Zl/0GljYc=;
        b=N7JVm+5n/nGlQ9JjfPCtMan9aGVJT8O+cQ5pOX0ux8Ea6IBsOP50mh3S5PutQmAbNE
         dCAcRianoqgQwEST87pXZuCCvd3C5BUtjrcxCCIHiMP+0cE6nRH0uKCy6lIDu43/sTme
         F6/IBpA3+AHgPhr0MOlS25QG7ozMvuVoyUsxHyivJGQc95ehO5NKUnvVpLQgsusxF9E8
         Hi3XPidQkWzCbqgqXWe+8zqiquaN5VJ+NJJ1MBrAxjhExQUl6P3/YQtiNmvSlsLfeeS9
         /qKhEyeCNBIi4T+vQQna72n8vXNvPTGLZlq6FgHw9O0AL8B5xmXIKGOdUEewuaEKbkyH
         WcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681150298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5LOafPib8IS/uhwsznow4aO6Exeoh/RG+Zl/0GljYc=;
        b=qa5k0Vpvnaum55wb9fwkHdQLIZaFBqLe/s9270Q3LOur5cq4zaMzlaFoJEGdulp4eX
         pAB7KKsVX3M2LMVAHXG4g55jFp1UJ/j+pGWD9RcBH+r08N2TrltZ5ztmV8C2Z6dnVYoO
         lTeI9BA1TgQ7k+THh8axhZvbYIcvK1HAnn9gjL2b9CIN0jdkXNBh6TeOBwRxGNLDOxLZ
         ENdyB8J1NlF4YaO0sXelgqVxoJf0LPgtI7f7BkQvfCzFw9sQpzEuiWCNMEvNMR7JiwY4
         QRfC1EnxWuJiiVBGN2Nmt6ArkDH9KbKqFBhlOg//Zy3DW5LuRBHBXEj2hGmwSLumwWGH
         6P6A==
X-Gm-Message-State: AAQBX9el1h01SEyTa0CbDhNUft5ZZDZdB8kZ/fnrfP6Jy5Rcv3bQJ4tP
        rizqE70NCj2yF9wvFt/n/i+moNdckMe6M9ZBkGn7yA==
X-Google-Smtp-Source: AKy350YvDGrTgm32l5QVPNV2zpCYsdNwPer+Pcy6Ey0yVvgOWtSBVOYljg5SZmFKh2vnYvLr+t78ZA==
X-Received: by 2002:a05:622a:c5:b0:3e6:2e95:b90c with SMTP id p5-20020a05622a00c500b003e62e95b90cmr21781876qtw.8.1681150298178;
        Mon, 10 Apr 2023 11:11:38 -0700 (PDT)
Received: from localhost (hs-nc-a03feba254-450087-1.tingfiber.com. [64.98.124.17])
        by smtp.gmail.com with ESMTPSA id n9-20020a374009000000b00742bc037f29sm3420984qka.120.2023.04.10.11.11.37
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 11:11:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: fix fsck-tests/056 to run without root
Date:   Mon, 10 Apr 2023 14:11:31 -0400
Message-Id: <9c27fc4cb1f2d0bbf215afa2f1388d927cd0f239.1681150198.git.josef@toxicpanda.com>
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

We need to make sure the root helper is setup before calling the loop
helpers, and additionally we need to use $SUDO_HELPER when we run the
final btrfs check.  With this patch we can now run this test as a normal
user.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/fsck-tests/056-raid56-false-alerts/test.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/fsck-tests/056-raid56-false-alerts/test.sh b/tests/fsck-tests/056-raid56-false-alerts/test.sh
index 6efb5c00..fcd37971 100755
--- a/tests/fsck-tests/056-raid56-false-alerts/test.sh
+++ b/tests/fsck-tests/056-raid56-false-alerts/test.sh
@@ -10,13 +10,13 @@ check_prereq btrfs
 check_prereq mkfs.btrfs
 check_global_prereq losetup
 
+setup_root_helper
+
 setup_loopdevs 3
 prepare_loopdevs
 dev1=${loopdevs[1]}
 TEST_DEV=$dev1
 
-setup_root_helper
-
 run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -m raid1 -d raid5 "${loopdevs[@]}"
 run_check_mount_test_dev
 
@@ -26,6 +26,6 @@ run_check $SUDO_HELPER dd if=/dev/urandom of="$TEST_MNT/file" bs=16K count=1 \
 run_check_umount_test_dev
 
 # Check data csum should not report false alerts
-run_check "$TOP/btrfs" check --check-data-csum "$dev1"
+run_check $SUDO_HELPER "$TOP/btrfs" check --check-data-csum "$dev1"
 
 cleanup_loopdevs
-- 
2.39.2

