Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E897C4121
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjJJU0d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjJJU0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:26:25 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5F2E1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:26:23 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7afd45199so21189847b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969582; x=1697574382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmh9xGr/as1MpprJlAG4JgvOSIGD6BUQHl774+RzFu4=;
        b=bqjaX0mDqOCfQ1W1b3N+mkOPqhm8/pBhtr9xLJyNucFnGT2tG7iTjcf5kSupZXDamu
         vw3hESjVK7NQH1jE1NnFNDRdhPG2iegWL0bJD/oWL5Wq/VCXjPQdPqLl5JGm5mPvv2og
         fDV7wDVYzH/Ddd9XfsKp1OmbI861xO0ehO0X5V9Br39P759MDZoKZuREBTYuJ2MifcsZ
         OwjnkC4XA/aCLnWc4NJdRCWk01WqugNsuU8T/R7s6tf0fMS1ry360bwP6IIF2IJu/N3o
         UmzVv39xEl9Tu7RhaHnDC3iecFtW5kYrtxNoBnEUQjheuiOPI9F1aCnZzHJEB/b0gm1M
         qZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969582; x=1697574382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dmh9xGr/as1MpprJlAG4JgvOSIGD6BUQHl774+RzFu4=;
        b=T5gV3kzwforrOtIZ3vEzJXVbtXUuQTcsOohYqeqrlX0rj4p63Ym3Ff7VMjeMJX0JMh
         TiAUPzqXOUA1GMrAN7WYL/w9ytOrN6McYvaSWbL+ncILcSDc9fGSeGV1yzT+gxgPWdXt
         oXuc97JbNJqtbR5Kqpec7451jwApuQ82nmljKDOZve3oeAn9OHAmNF44oIgkKcRT2Oq8
         5AUYulJbHamwLJvTY4yAYEE/1NBBxRrM7w0V0i3M9WHu67dAswNHpVEx3UgVoVdTus1E
         IMh30yiw1G/LJImgSZpX76HxdIwv7Qc8JxKpPFHST4J0FoLilh6mVwbMKJ43V3lmFQuB
         ifTQ==
X-Gm-Message-State: AOJu0YzAcXllsNpVX1EyFPpVL74s2MWsFOZUn5kc/A7HlhzgbtH3mFbb
        /CdWh6iQUNLn8Hua7c3+sY5VVw==
X-Google-Smtp-Source: AGHT+IHHPc4cVCv0X5UjY6ZEhh73TopZ6jV5VXaR1PRAmJHmMIp+SqJlnKd+kKUVvokDPp15rDCEYQ==
X-Received: by 2002:a0d:e841:0:b0:5a7:d986:a9bb with SMTP id r62-20020a0de841000000b005a7d986a9bbmr873545ywe.3.1696969582283;
        Tue, 10 Oct 2023 13:26:22 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d187-20020a0df4c4000000b0059af121d0b8sm4694342ywf.52.2023.10.10.13.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:26:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 04/12] common/encrypt: enable making a encrypted btrfs filesystem
Date:   Tue, 10 Oct 2023 16:25:57 -0400
Message-ID: <905514b9fa178c51afde27c4eff456079e010750.1696969376.git.josef@toxicpanda.com>
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

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 common/encrypt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/encrypt b/common/encrypt
index 2c1925da..1372af66 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -153,6 +153,9 @@ _scratch_mkfs_encrypted()
 		# erase the UBI volume; reformated automatically on next mount
 		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
 		;;
+	btrfs)
+		_scratch_mkfs
+		;;
 	ceph)
 		_scratch_cleanup_files
 		;;
@@ -168,6 +171,9 @@ _scratch_mkfs_sized_encrypted()
 	ext4|f2fs)
 		MKFS_OPTIONS="$MKFS_OPTIONS -O encrypt" _scratch_mkfs_sized $*
 		;;
+	btrfs)
+		_scratch_mkfs_sized $*
+		;;
 	*)
 		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized_encrypted"
 		;;
-- 
2.41.0

