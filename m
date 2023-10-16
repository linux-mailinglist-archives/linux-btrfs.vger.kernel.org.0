Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD4E7CB249
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjJPSWN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjJPSWJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:09 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0CA7
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77409065623so279802985a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480526; x=1698085326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X/0Zt7z+oOh2YdMAkIlfw4aC9CST8nDgU19CDUdTeo=;
        b=nuqWp5nRrGE6KJ8xr6jOelrA0QA1vY9LQpEvh/edKehNha8rb0q8suT5+5RxPSkTgc
         Fs7GEU0gY8AJ2B6ovN5LS5DhskXtSEaPPUAFiTpCjfOgmIiPsTK7JNPKlNFIZlLXl2bP
         5lpclLHnMQ0X1UQEGxXBjL38iuh/yaMtlhdO7QhvdaQZNYoS2oKsYPGboLC5CCx0ONZ1
         sFHd2EFl0s+Hd199fn9wJWI3S+/kdbugA9EIpnuikF63s2x0yk6UhjwMmKwg7T0eOZXg
         UAXzbiNTrQ0TQ1zkAXT/xwboInmmNi/QtSWkFBHQKnj+rjj/9EzFBIZK3psAelFt3xCG
         KjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480526; x=1698085326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X/0Zt7z+oOh2YdMAkIlfw4aC9CST8nDgU19CDUdTeo=;
        b=nZwffD1on5QyhT4D03mLAvoce3JzRxs1HJ3MTDn72shMhJBx0drd7HryQYYEjfjQn1
         5BLel5eZGvk1uJOMCWEI2Fmsv4TiF8idtS0zS3iw/PrvndS7EQ5+v4e5ZZhj720R1N/L
         THJ8Gyi2hDVV8NFO0mcnzmknhCg3zGBzieX+FQr+zSleO7mfQVSviyjFMT6SwtAHDLf9
         LFMWQUdksL9l0gnrdCnMDw1P9jhy0w4dMrHWKeMBfy0f42SV3ZpbPWUc+7K2v5l3V05c
         jGQIUDr+LYS2PtO5a/r1yr2aO71Yeux17oOio0OFHVCQlRH7/u49oT1LlFiR1wFFSmCm
         Ye1Q==
X-Gm-Message-State: AOJu0Yx5jci2Q3KdiUvWmknZobc1XO2fPdP5G+a7HK3WGBP8Omtxraby
        fZRrCV+cRIvN5iEKEei/1Ry1/SReQ5r8f+QGV5w7QA==
X-Google-Smtp-Source: AGHT+IGXH8QNompgUIey9IU0Qy2Otiiwrs7hjXFmWVxJiG7b03fcJAT9AT6c4z42jyUPCC35La4/4A==
X-Received: by 2002:a05:622a:1113:b0:418:193e:79e8 with SMTP id e19-20020a05622a111300b00418193e79e8mr102619qty.51.1697480525877;
        Mon, 16 Oct 2023 11:22:05 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id jx11-20020a05622a810b00b0041815bcea29sm3238566qtb.19.2023.10.16.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 08/34] btrfs: disable verity on encrypted inodes
Date:   Mon, 16 Oct 2023 14:21:15 -0400
Message-ID: <253895bfbf1473346cbd959349a9a4469c865b32.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
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

Right now there isn't a way to encrypt things that aren't either
filenames in directories or data on blocks on disk with extent
encryption, so for now, disable verity usage with encryption on btrfs.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/verity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 66e2270b0dae..92536913df04 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -588,6 +588,9 @@ static int btrfs_begin_enable_verity(struct file *filp)
 
 	ASSERT(inode_is_locked(file_inode(filp)));
 
+	if (IS_ENCRYPTED(&inode->vfs_inode))
+		return -EINVAL;
+
 	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags))
 		return -EBUSY;
 
-- 
2.41.0

