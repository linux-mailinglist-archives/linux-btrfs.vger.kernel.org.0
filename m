Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD5F6DCA89
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Apr 2023 20:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjDJSLr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Apr 2023 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjDJSLq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Apr 2023 14:11:46 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800A61BD8
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 11:11:44 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id kj14so3843807qvb.12
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1681150303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+OF44Gq7CfmQwYIXdNAKIqSd5uMmG9ie4pLfwuYJZ8=;
        b=owrx3fdv+RMFWcLRXrEiYX34EgYidZ+iLlu3937ix5+B98NQydics24tzecA4uJ2Nt
         9R66Lk0C6ujfVlXt7DinhcSSBfDO06Wtz4OL+L/51mWURiwkK77IqR6cmH9m0G4fTN8U
         UgnmNooYO7Pnj4o/7pibpcHTnd9FoT/9DrU8lo+PYUibeJcYJz3pirHbhNihDX83Amgw
         ame7jKNhMaMHVIYMsBcp9/pNR0CNKdROZ7dLwKlopobgTb7+325VAYjfBc2e/Xc6MJCW
         kL1e9wcI1OekNUsyeZFqRJ33JzeIwUfOUmeA7ZjmcXIhD9LImUKHtahfbuL6qFzr6McV
         qv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681150303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+OF44Gq7CfmQwYIXdNAKIqSd5uMmG9ie4pLfwuYJZ8=;
        b=VVQJ5w3LnXiLzjqlrA5YYmJ08iD/HcDYgNHaV4eUIqpGEN9Z4BLqQOe9qjn3+ZkuZM
         a/5SkZW5qoXmiS6t4VZw813LhxLWG9v/ZnHOw6u8tKhJ9WXmh7F09KdHOT3Ec2gObNbB
         frC6RUT0uOFxwREdJzGAp8+YHTn4twZUmpgKKlypANF5CF9I2FG/TzkdZTzJU6eh6lY4
         oocCh3B9WbApBBO+8z5n3NUFutae9zxYpUUFx2NMLoKE6BKWYheIwp81AD9WdGbppu4/
         urXSEg7aoJXqTnfN8y9eipehknpRs+Qi7F1/N2JKjphsAcJV4a87l/StFkPXt9XGWR45
         oqXA==
X-Gm-Message-State: AAQBX9cb1iHGrxyjOOWIRMBRVodXhrOnY2YTnF4PIdqi5zxqLNRe26ki
        jX2xVbFyZnk6a+B/4mPwQR7NuHTAgEQ+7nGeLb08sg==
X-Google-Smtp-Source: AKy350a5xLveGnRPV0oar6evEhfx4lu7fNYcDZN/Kw5lhd5rucBIuGyYhQmVWc8KGQPfH3zNcbvY0w==
X-Received: by 2002:ad4:5ccf:0:b0:5a9:d6dd:271f with SMTP id iu15-20020ad45ccf000000b005a9d6dd271fmr16509197qvb.23.1681150303090;
        Mon, 10 Apr 2023 11:11:43 -0700 (PDT)
Received: from localhost (hs-nc-a03feba254-450087-1.tingfiber.com. [64.98.124.17])
        by smtp.gmail.com with ESMTPSA id da7-20020a05621408c700b005dd8b9345fasm3503581qvb.146.2023.04.10.11.11.42
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 11:11:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: fix fsck-tests/059 to run without root
Date:   Mon, 10 Apr 2023 14:11:33 -0400
Message-Id: <bd2af0ac1f8723ffa81dad28b56f138fd24cd2f6.1681150198.git.josef@toxicpanda.com>
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

We missed a couple of $SUDO_HELPER uses in this test that made it
impossible to run without root.  Add them in so we can run as a normal
user.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/fsck-tests/059-shrunk-device/test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/fsck-tests/059-shrunk-device/test.sh b/tests/fsck-tests/059-shrunk-device/test.sh
index 140ee3a4..3ac2640f 100755
--- a/tests/fsck-tests/059-shrunk-device/test.sh
+++ b/tests/fsck-tests/059-shrunk-device/test.sh
@@ -14,7 +14,7 @@ _mktemp_local "$file" 1g
 
 dev=$(run_check_stdout $SUDO_HELPER losetup --find --show "$file")
 
-run_check "$TOP/mkfs.btrfs" -f "$dev"
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev"
 
 # The original device size from prepare_loopdevs is 2G.
 # Since the fs is empty, shrinking it to 996m will not cause any
@@ -26,5 +26,5 @@ dev=$(run_check_stdout $SUDO_HELPER losetup --find --show "$file")
 run_mustfail "btrfs check should detect errors in device size" \
 	"$TOP/btrfs" check "$dev"
 
-losetup -d "$dev"
+$SUDO_HELPER losetup -d "$dev"
 rm -- "$file"
-- 
2.39.2

