Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66956DCA8A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Apr 2023 20:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjDJSLs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Apr 2023 14:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjDJSLr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Apr 2023 14:11:47 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638C4198C
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 11:11:46 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x17so24631416qtv.7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1681150305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIkUkXhQYF2fir5Te0uHuQwCkBepWX/ri7xRzRhUbzk=;
        b=kF44Cg8Ob8+BI4S9GUPCkMM6C3vUDWZKZ2F+C2iQf93RiyzkyvfHTLaCk0+whjTpQT
         6wzBoSbACwA/2R7gxOdNl6gr4n2B83/o9Bce6/LzedYdxxeRMASYVHLtusDaUrbMZbsK
         uNke4bA8VVijSwdH49CYpFgQWFvkjACbfy98pjSsG8t0vZurcbMeOdv7BM+ocHjN1sJX
         if/OcUAgcKcsUmFjLL6VBb6f+8vHpV4+jicJHJwFkuo8ZukVLDpQ1X7wT63B7hN+Sqwv
         6QRedDCBsQDPwD7jslIThEcmOMx2Wq2/Oe//zufDaO3gEzJEyQ68+The14oOooVeVJlY
         1GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681150305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIkUkXhQYF2fir5Te0uHuQwCkBepWX/ri7xRzRhUbzk=;
        b=DMxnhus41hJWsnCBrTWBFcqen8LoRUhh53U+56mS36+rKMiThMbYuXZ0GXHxXsWkOA
         jMBOCL0LyQ5fkETCr39GQ93zzDAti1lk5S52Z03eO/tMD+ZXardVP7WfobC5HtfBGun/
         T8Yqwg+EvHedN2q0S79Ckm79wIkjJIwNvxBX9/8Fc92WetN5Qc2BC0CwanlYcXhpm+NC
         rG+EB8LoVs4fWgSfRswFovIyAUe9f9B4WvKq9hH8A5ZSC/qD8S8wUhVNt6BF2/nnMIPk
         a+60IrTwBD/0vjdnANE46NTTAwtOjzMMxqzNayJ8DpL+23GARbc0D8wsULvIvivepbl/
         9BnA==
X-Gm-Message-State: AAQBX9c/MZ0sPZn6b1OjqkTlJ1wpT5IXo+6mNqU6mdnXTiGxfb31ZTt4
        d67rN9+JnfxJYM7l+31twZwSvGQVAbOLMbfHudzKdw==
X-Google-Smtp-Source: AKy350ZSd9xGFAjlvkYe8feAUr8GyVdJFxD9eaQJvE7ScTEefpUg6HnRS6IaIgXdOECHPrxjpKT6Dw==
X-Received: by 2002:ac8:7fd4:0:b0:3e3:8427:fb51 with SMTP id b20-20020ac87fd4000000b003e38427fb51mr18427825qtk.23.1681150304824;
        Mon, 10 Apr 2023 11:11:44 -0700 (PDT)
Received: from localhost (hs-nc-a03feba254-450087-1.tingfiber.com. [64.98.124.17])
        by smtp.gmail.com with ESMTPSA id o5-20020ac872c5000000b003c033b23a9asm3119124qtp.12.2023.04.10.11.11.44
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 11:11:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: fix fsck-tests/060 to run without root
Date:   Mon, 10 Apr 2023 14:11:34 -0400
Message-Id: <9fcda5f1661f9c15fe9514f3d8aa0e34a9f9b23c.1681150198.git.josef@toxicpanda.com>
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

We need to call the setup_root_helper before we start messing with the
loop devices.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/fsck-tests/060-degraded-check/test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/fsck-tests/060-degraded-check/test.sh b/tests/fsck-tests/060-degraded-check/test.sh
index 6a1f50c8..f185a655 100755
--- a/tests/fsck-tests/060-degraded-check/test.sh
+++ b/tests/fsck-tests/060-degraded-check/test.sh
@@ -10,14 +10,14 @@ check_prereq mkfs.btrfs
 check_global_prereq losetup
 check_global_prereq wipefs
 
+setup_root_helper
+
 setup_loopdevs 3
 prepare_loopdevs
 dev1=${loopdevs[1]}
 dev2=${loopdevs[2]}
 dev3=${loopdevs[3]}
 
-setup_root_helper
-
 # Run 1: victim is dev1
 run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -m raid5 -d raid5 "${loopdevs[@]}"
 run_check $SUDO_HELPER wipefs -fa $dev1
-- 
2.39.2

