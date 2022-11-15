Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3896629D8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiKOPcV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbiKOPbs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:48 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE4A6558
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:47 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id l15so8901249qtv.4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEzT4z3jmt1nwFr/0QrNIzrkbNngQ1VNHZYJqlsVF6E=;
        b=Ut3kRUyKrWH0WLaBB0XDOuEB+TJi570u5yNFqXjpSFlYTPYMcXEtoPW0hBYsnxN1fS
         4wNXkPBwhTIWmEbDvAgnGabtiOQcfPlriidn5wT5YM2D3kWmOgmLrwHGvHrLKA+dtl3r
         D7pQFRP5cbkloooMPnivL2PbfsI8LUt00Qqxi3C57fehO3bDqf3REgbSorx4p7/XTel2
         wUhtAhJEawMvthNkhL1LE2PYYdDhL8c1cka5+jkxm/DTTT4m7fy+fzo7AWQZ2zil/5ju
         b4Kx3Tgnp7syTz6cyXjrw+s6+lBxpjAuMXWq82BXVjJuCG6WzkHDSNWACB89gD+/AqPx
         FcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEzT4z3jmt1nwFr/0QrNIzrkbNngQ1VNHZYJqlsVF6E=;
        b=TnvPdi+4BUFaomWSlGRyLTMVjAdzI6tFbbF9GX/jroJdeRqFxeSN3wZ8J3yHYsFoRt
         s7WL8nTY/bQuo6ulCwOEugaN6PP961q/4r9r++5qoUZ5msxDpCeaRDB0Gw4HuCls5rqR
         sgycgcGAY8te+N2q92Y+14ZPSCr18z4SCTtCEDw+PIqRGtk6lBA8970EyIXzEzek2fd4
         9AZepr9RZ50AepK3HB24XDsA+NiwVlty+daHBw4U8oDgStodivK4mhFKUP7I3R3v/nlt
         C41nMWrvm3zw6qWeiOFF0vXTeFxOP7rTJlF8Ktn8OznZtt7AqlxvoyUrm2BCG6Cnfgoh
         pOlQ==
X-Gm-Message-State: ANoB5plGdCsszhXOn3IjLE2hJy257GbP4kjS5Jj9LP0bB5i9aZvJRfp+
        EUCsZBxdw3bjz/jVqpFSy8cveFApDCcoqA==
X-Google-Smtp-Source: AA0mqf426mJoJ9+EhYGa/fhyauF0cMNcPsKXWegObx6pwLxU4S3BJFuLttlmJ23HWKe8qmAMNG4o5A==
X-Received: by 2002:ac8:4656:0:b0:3a4:fe7e:8c06 with SMTP id f22-20020ac84656000000b003a4fe7e8c06mr17345801qto.465.1668526300829;
        Tue, 15 Nov 2022 07:31:40 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w9-20020ac86b09000000b003988b3d5280sm7332412qts.70.2022.11.15.07.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/18] btrfs-progs: move NO_RESULT definition into replace.c
Date:   Tue, 15 Nov 2022 10:31:16 -0500
Message-Id: <d824104c85705d25129a15a44cdeb54424da8275.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT is defined to make sure we
differentiate internal errors from actual error codes that come back
from the device replace ioctl.  Take this out of ioctl.c and move it
into replace.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/replace.c | 2 ++
 ioctl.h        | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/replace.c b/cmds/replace.c
index 28e70b04..bdb74dff 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -45,6 +45,8 @@ static int print_replace_status(int fd, const char *path, int once);
 static char *time2string(char *buf, size_t s, __u64 t);
 static char *progress2string(char *buf, size_t s, int progress_1000);
 
+/* Used to separate internal errors from actual dev replace ioctl results. */
+#define BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT		-1
 
 static const char *replace_dev_result2string(__u64 result)
 {
diff --git a/ioctl.h b/ioctl.h
index 21aaedde..686c1035 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -192,7 +192,6 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_replace_status_params) == 48);
 #define BTRFS_IOCTL_DEV_REPLACE_CMD_START			0
 #define BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS			1
 #define BTRFS_IOCTL_DEV_REPLACE_CMD_CANCEL			2
-#define BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT		-1
 #define BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_ERROR			0
 #define BTRFS_IOCTL_DEV_REPLACE_RESULT_NOT_STARTED		1
 #define BTRFS_IOCTL_DEV_REPLACE_RESULT_ALREADY_STARTED		2
-- 
2.26.3

