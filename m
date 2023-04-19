Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE76E8330
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjDSVOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDSVOE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:04 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82D3AA4
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:03 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id dd8so952233qvb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938842; x=1684530842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sykxFQmUFupV7i2Su20Pk9+z0F4Z9qrvZt39lUd5Yps=;
        b=Y9Yq7uzryyPXRdtLOV4786X0oNSS/2Ha9IktvP/liuZzxzaUPrtNDdPeXvqLPE29eJ
         PADTaPMw5z7DXmK1Rk92jUJvYB5mUFarewyUopiku2iVoY36pb5I9cEMCQ6zVma/nYt1
         tWZkXC1I8oPwydZqz09ijbYaIQRvBNiuJBQir0ZllMIje/KM7Ry1G9u+pKbP2xQIbYLC
         BaBBaOlozLqpGONH+zpwEmRvohIrz3rdqISuFB4VoV7TCpxTpSvtgn74DgfZiIEHc5UY
         2K1wTwQpHrdFfIxkKvXw7DfGE5igzTML/YOHhLFH1O66fvplEJVMRMvFiALm+BD6aB/u
         Xj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938842; x=1684530842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sykxFQmUFupV7i2Su20Pk9+z0F4Z9qrvZt39lUd5Yps=;
        b=K5wp4ic5ql2HBPYkYWTvfAvHExFyIrzbTFN6Aoqt6attM2phg/NlVESZHjBJoAJ4IX
         TKKyfd339vI4ZOkX7MrDA/S2JIZtK7bYkTzYOqv5iZ+PSH/EUtkDnyhC+4s9oymMr+hu
         xAne6bTRH1s6J3mIKbZg2NCLRxNq/KM0nywusu8Ahxg1C4CFCwJQM4pZVvq4KoCjsvz+
         JudoQXp4svgF6O0FHlT5wUkjll8VmgKO0XlKGzDaTOEr0bHPT1jdiv7J324j4gusEbjh
         0zZfBm2TxLxzx142t7UHMVAqWIiErPfP3jwMA0tiYmq924BM3W4bYshcPze4MmmDCtQG
         TMOw==
X-Gm-Message-State: AAQBX9fFEND1TtWKbTteZg7kWeHs9Tuy/r/CDIQOIMzHKk9u0CsdqMo2
        lfZd0CEbWW4qLXdvNtaPEROI/snGGqIqvEVLojCdnQ==
X-Google-Smtp-Source: AKy350avdbVWsGVTJEoqwRyqNag99g5vZKmmPmU7bIaCh3BaCZvPWonwWwZTz8AQrvNBuH9U/nEhFQ==
X-Received: by 2002:a05:6214:252a:b0:5ef:8004:e0b4 with SMTP id gg10-20020a056214252a00b005ef8004e0b4mr19179092qvb.48.1681938842323;
        Wed, 19 Apr 2023 14:14:02 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i3-20020ad45383000000b005e3c45c5cbdsm3553974qvv.96.2023.04.19.14.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:14:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/11] btrfs-progs: use $SUDO_HELPER in convert tests for temp files
Date:   Wed, 19 Apr 2023 17:13:44 -0400
Message-Id: <f0a556e968d0b34b8305a6d751887d7712fc8305.1681938648.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938648.git.josef@toxicpanda.com>
References: <cover.1681938648.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running make test-convert as a normal user I ran into this problem
where we do sudo find <blah> into a mktemp file that's created as the
normal user.  This results in find getting a EPERM while trying to mess
with that temp file.  Fix this by using $SUDO_HELPER for all the
tempfile manipulations so that root is the owner of everything, which
allows the convert tests to run as a normal user.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/common.convert | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/common.convert b/tests/common.convert
index 264972fa..160909eb 100644
--- a/tests/common.convert
+++ b/tests/common.convert
@@ -113,32 +113,32 @@ convert_test_perm() {
 
 	_assert_path "$1"
 	PERMTMP="$1"
-	FILES_LIST=$(mktemp --tmpdir btrfs-progs-convert-filelist.XXXXXX)
+	FILES_LIST=$($SUDO_HELPER mktemp --tmpdir btrfs-progs-convert-filelist.XXXXXX)
 
 	run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT/test" "bs=$nodesize" \
 		count=1 status=noxfer >/dev/null 2>&1
 	run_check_stdout $SUDO_HELPER find "$TEST_MNT" -type f ! -name 'image' -fprint "$FILES_LIST"
 	# Fix directory entries order
-	sort "$FILES_LIST" -o "$FILES_LIST"
-	for file in `cat "$FILES_LIST"` ;do
+	$SUDO_HELPER sort "$FILES_LIST" -o "$FILES_LIST"
+	for file in `$SUDO_HELPER cat "$FILES_LIST"` ;do
 		run_check_stdout $SUDO_HELPER getfacl --absolute-names "$file" >> "$PERMTMP"
 	done
-	rm -- "$FILES_LIST"
+	$SUDO_HELPER rm -- "$FILES_LIST"
 }
 # list acls of files on $TEST_MNT
 # $1: path where the acls will be stored
 convert_test_acl() {
 	local ACLSTMP
 	ACLTMP="$1"
-	FILES_LIST=$(mktemp --tmpdir btrfs-progs-convert-filelist.XXXXXX)
+	FILES_LIST=$($SUDO_HELPER mktemp --tmpdir btrfs-progs-convert-filelist.XXXXXX)
 
 	run_check_stdout $SUDO_HELPER find "$TEST_MNT/acls" -type f -fprint "$FILES_LIST"
 	# Fix directory entries order
-	sort "$FILES_LIST" -o "$FILES_LIST"
-	for file in `cat "$FILES_LIST"`;do
+	$SUDO_HELPER sort "$FILES_LIST" -o "$FILES_LIST"
+	for file in `$SUDO_HELPER cat "$FILES_LIST"`;do
 		run_check_stdout $SUDO_HELPER getfattr --absolute-names -d "$file" >> "$ACLTMP"
 	done
-	rm -- "$FILES_LIST"
+	$SUDO_HELPER rm -- "$FILES_LIST"
 }
 
 # do conversion with given features and nodesize, fsck afterwards
-- 
2.39.1

