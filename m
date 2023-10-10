Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B566E7C411E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjJJU0a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjJJU0Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:26:24 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4783FDB
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:26:22 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7afd45199so21189587b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969581; x=1697574381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEBkTHJ3Zcu/2KG+vVGPEkATD7sMt03VYNJu8yvTP9M=;
        b=SN3aOlddxcqgvMSGkQYM9YW3biqn9ZY2bGhhhSwZHovLYv3+H7VLvPrtEXVA+73MyZ
         j+N0RB1qVFxXODgeGnO9GoA79kWnrQqX//uc6CZ/MXuilIOVwRvVUIE6RDyzcKjN+WF6
         RyfB1SoUG6FkEPtVtSJ1cLdRpH5DoB54aNZkM82HZCvzEJoS9pvQH8jvs0DjhxZrcjvT
         xks8pRcEaIWfV9EomLx5+eSZYz13vaagV9MY4xgdvFpzCJV1ei5oL4+euF9BlacA2BFi
         qr4JyIWgEtlJ/zjB8ec9NjI8MzYQrkLQ9zRGNdYBa3g7qMWgFyqDPBnvjpojxDbcy2GT
         yqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969581; x=1697574381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEBkTHJ3Zcu/2KG+vVGPEkATD7sMt03VYNJu8yvTP9M=;
        b=Cjx+M0Voo/K4J2t1XI/oqjQt6dhp968Tkj8EFgeqFsfKnjcQLXeRpHbez02rEx9Wtn
         vIIJY//y0uQVkOG9O/imb0N81W2CYPmZhXB98ZzB/aWMYVr+fP6dekegaXmfUtol+WtV
         PfRXqkRbYjQftxHBxIDZoi7Rc5Rzn3gnAMXMxKW8jFnBfBaQIya/mQzNyaf1wI9WQVjN
         O5i3x6im4uBOB/Jmwa+whQ0JZQlttu2mt3rZMqb5WqHPg+TYEMv4ZTv0BxIMfX3Ib0Je
         gaVE49NVGd4GujRzi1yCybJDsuep9A8xJ2sGL3JDXlktEV8iCZTTcYnsydUrfw07Bjkw
         Keuw==
X-Gm-Message-State: AOJu0YwJllQAl0+X2k7lttiC4lxJNgFiVnfEfsOZSc7LEsjWRlzhdsp0
        OIMf6Aqgs2f55lV87KSk4vDA9w==
X-Google-Smtp-Source: AGHT+IEDJXaz8Iqj0J5QGmoE8YAQkrqbJnp7d+TIBuszlRdRr5jTsnA0UfmfaKbLhaXI1gnZsLNkDg==
X-Received: by 2002:a81:48cc:0:b0:5a7:baac:7b34 with SMTP id v195-20020a8148cc000000b005a7baac7b34mr3793507ywa.28.1696969581386;
        Tue, 10 Oct 2023 13:26:21 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x9-20020a814a09000000b00589b653b7adsm4691241ywa.136.2023.10.10.13.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:26:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 03/12] common/encrypt: add btrfs to get_ciphertext_filename
Date:   Tue, 10 Oct 2023 16:25:56 -0400
Message-ID: <b568ed0fa6b5a94c38dc1a08d07f4e289bf9d75f.1696969376.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696969376.git.josef@toxicpanda.com>
References: <cover.1696969376.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Add the relevant call to get an encrypted filename from btrfs.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 common/encrypt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/common/encrypt b/common/encrypt
index fc1c8cc7..2c1925da 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -618,6 +618,19 @@ _get_ciphertext_filename()
 	local dir_inode=$3
 
 	case $FSTYP in
+	btrfs)
+		# Extract the filename from the inode_ref object, similar to:
+		# item 24 key (259 INODE_REF 257) itemoff 14826 itemsize 26
+		# 	index 3 namelen 16 name: J\xf7\x15tD\x8eL\xae/\x98\x9f\x09\xc1\xb6\x09>
+		#
+		$BTRFS_UTIL_PROG inspect-internal dump-tree $device | \
+			grep -A 1 "key ($inode INODE_REF " | tail -n 1 | \
+			perl -ne '
+				s/.*?name: //;
+				chomp;
+				s/\\x([[:xdigit:]]{2})/chr hex $1/eg;
+				print;'
+		;;
 	ext4)
 		# Extract the filename from the debugfs output line like:
 		#
@@ -715,6 +728,9 @@ _require_get_ciphertext_filename_support()
 			_notrun "dump.f2fs (f2fs-tools) is too old; doesn't support showing unambiguous on-disk filenames"
 		fi
 		;;
+	btrfs)
+		_require_command "$BTRFS_UTIL_PROG" btrfs
+		;;
 	*)
 		_notrun "_get_ciphertext_filename() isn't implemented on $FSTYP"
 		;;
-- 
2.41.0

