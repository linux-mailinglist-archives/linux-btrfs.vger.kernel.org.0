Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F4B4DCC67
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiCQR1c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbiCQR1a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC87D114FCA
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so2275084pjb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2OFoefPGJQ+WHOMM+btFk0/kfeAvOV06RDV8glzYuA=;
        b=1gJ6IDIcG1NZ+YC5e2JtsLNGdmPKgpSyO9BZ7UIrVHH8HI4gUwoZUdoGCgx8k2a4lV
         liLVcGR/EH/B91xxwShAByPSK/RdjMX2/Qqu6IcPeQ9mDnDO0UjqT7vvNyIMLTx4YVB+
         BEPmSO1RQ9mI++mY3iW7RrOq5NQ+R+RjWsRoGyvbC4lW584EpHBnkxe7lF3tFQ7Zkg95
         LheHgOFvnE2bOgJf6INoEAlLZMVmzZDk8T/Ku+v58GqskhuKNPhbYdmt9n0/rimk/MVc
         PQryPsF8r5nv4lBxtdVmTQpI1cwifRbUG4K9fmsETu0iZH/FDBQjQNEiR0LfeogTWw4V
         TJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2OFoefPGJQ+WHOMM+btFk0/kfeAvOV06RDV8glzYuA=;
        b=gko8ttpdFOPMzwIyU3gb3fwYkzs6UdTfg8IBsade3Tl4dDL0VViLSnUpbOTWOkpwi/
         cLRuiOmaXMPImIn6TZh10awRnCCJN+ihcGmoV0PLw9QBYiOh4ZaEd74DlPiA4mv9Qplx
         /fcvY/VgJJF00hliDlC+VV0RWB0BXqv8JSM7wyc9Nxoqd2L4b3F2JV0NMViaa/NZXd1l
         9gd3mKZL2upIu8/uZ4h2Rmy5dGxq4u553HwoPhwrs/il08ye3Tk5jQnEM3vvXLlC//QX
         M9Eqt3T+q/i8rnSPdoypxnlLTbQxfgzh+71nMCAhCtxzfD9rEqrUJB4EM6mMVh36afIU
         L/hw==
X-Gm-Message-State: AOAM531/l3RQBDSFIx0LPoysedQZRRAQ1pdc2CBIDguHWsPQcNzV2/zB
        P+MnHVaSL/nO5NJwgpszXNKuIlQRE6nWuQ==
X-Google-Smtp-Source: ABdhPJwZrlS0/YmC/faPOEbDTW23MNGqcv59XtblFmAmyQOimLLnMK9JaZ/sTYeIVboa9knARMsDdQ==
X-Received: by 2002:a17:902:ecc2:b0:151:dd64:c77a with SMTP id a2-20020a170902ecc200b00151dd64c77amr5963564plh.154.1647537972913;
        Thu, 17 Mar 2022 10:26:12 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:12 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 7/7] btrfs: send: enable support for stream v2 and compressed writes
Date:   Thu, 17 Mar 2022 10:25:43 -0700
Message-Id: <9473f6be9faadaea779f76bd9ef29dc638a58f46.1647537027.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647537027.git.osandov@fb.com>
References: <cover.1647537027.git.osandov@fb.com>
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

From: Omar Sandoval <osandov@fb.com>

Now that the new support is implemented, allow the ioctl to accept v2
and the compressed flag, and update the version in sysfs.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c            | 7 +++++--
 fs/btrfs/send.h            | 2 +-
 include/uapi/linux/btrfs.h | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index b0560be3053b..4567271ce642 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -690,8 +690,7 @@ static int send_header(struct send_ctx *sctx)
 	struct btrfs_stream_header hdr;
 
 	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
-	hdr.version = cpu_to_le32(BTRFS_SEND_STREAM_VERSION);
-
+	hdr.version = cpu_to_le32(sctx->proto);
 	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
 					&sctx->send_off);
 }
@@ -7663,6 +7662,10 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	} else {
 		sctx->proto = 1;
 	}
+	if ((arg->flags & BTRFS_SEND_FLAG_COMPRESSED) && sctx->proto < 2) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	sctx->send_filp = fget(arg->send_fd);
 	if (!sctx->send_filp) {
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 805d8095209a..50a2aceae929 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -10,7 +10,7 @@
 #include "ctree.h"
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
-#define BTRFS_SEND_STREAM_VERSION 1
+#define BTRFS_SEND_STREAM_VERSION 2
 
 /*
  * In send stream v1, no command is larger than 64k. In send stream v2, no limit
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index b6f26a434b10..f54dc91e4025 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -788,7 +788,8 @@ struct btrfs_ioctl_received_subvol_args {
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
 	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
-	 BTRFS_SEND_FLAG_VERSION)
+	 BTRFS_SEND_FLAG_VERSION | \
+	 BTRFS_SEND_FLAG_COMPRESSED)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
-- 
2.35.1

