Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AF43FE0BC
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbhIARCv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345653AbhIARCr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 13:02:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F21C061764
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 10:01:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x4so84776pgh.1
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9Xpul0F6cJY0XIsCbUm0kCOBPX5Q1cbD387BDvj2T4=;
        b=NWQZAvemJ60Z5kPxFgwLMBhik0xSVGM1UiDkaLRMi3Q9yDLPJ6VxdhTujtm1/D+pOg
         CL0hKy2V9fyuyCzp4epQBcrtNLbd+3MgEsaHRN86ycMs4lcOOl/k6TqFT7VKkpMO08rn
         BrjEkrCEJSjj60Wnc+laQwArP+TE7Sfmpn1qL1UxzBWJ+STr1WTIecVwTg9J6XFpDQGt
         PPRAvMY94Jboo660MPJ/jjQfMK1mTgMTg8ZSIYXIAhef38dkBOC5/RORUN9L8AN71Rln
         JDeNnuUgG8Ad6538j1lbEYaVGzkZNEhINnjvQ52Ck88cIeUzyNZdmcEzfgNJeqMD3rVw
         NnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9Xpul0F6cJY0XIsCbUm0kCOBPX5Q1cbD387BDvj2T4=;
        b=eQ40Gy7KoLUt9/OyBmPhgiu5HwH7hWfwRd0f4dJAVHoCBCKObe27VIo8cXGqOPWMHt
         Y6Nh9zB4QGy3tEw8IaJ5El37z0IbasB7ikt2i2xb4YQFf/gBXVR3wj4E0FdYVDNtSuCv
         i4OdIGl3MWZkEwU5SdyBwsCLNEXHvray+fcfJfQU30W52VHgzHsVp7rpXHor0vP4iRSA
         8Zt1ZVxs5rnBKP8xZWFRC94OGELTHQFCF6aAlmXUicIdbhA/soMo0OPu3wl9NppdiqqL
         xd/B/qfER4Xsgr19r0hmVf9RJ3AyQjNEAhgvgA5SndZNWbV+5c6K3N1f+KLL4tbhr4ag
         fP6g==
X-Gm-Message-State: AOAM5327u8Mpo9zLKbDehpprIzf1aXtXx58BX/5EkGSMe4y6n7y2FR8b
        AArYsIPvNomIebBAvWRkdkTQFtHTJVhTEA==
X-Google-Smtp-Source: ABdhPJwISP6QGehZOK+CUjGgMS+AX1ZKFfiDkYz9GpCZroxG776sElWgAWRVuzU+qP+ijCTcvWnetA==
X-Received: by 2002:a05:6a00:a8a:b029:30c:a10b:3e3f with SMTP id b10-20020a056a000a8ab029030ca10b3e3fmr370911pfl.40.1630515706682;
        Wed, 01 Sep 2021 10:01:46 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:46 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 14/14] btrfs: send: enable support for stream v2 and compressed writes
Date:   Wed,  1 Sep 2021 10:01:09 -0700
Message-Id: <61a4a5b6bf694c7441b2ba04b724d012997fa3f7.1630514529.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now that the new support is implemented, allow the ioctl to accept the
flags and update the version in sysfs.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c            | 10 +++++++++-
 fs/btrfs/send.h            |  2 +-
 include/uapi/linux/btrfs.h |  4 +++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 0ba8dc3a9f56..90ca915fed78 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -671,7 +671,10 @@ static int send_header(struct send_ctx *sctx)
 	struct btrfs_stream_header hdr;
 
 	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
-	hdr.version = cpu_to_le32(BTRFS_SEND_STREAM_VERSION);
+	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2)
+		hdr.version = cpu_to_le32(2);
+	else
+		hdr.version = cpu_to_le32(1);
 
 	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
 					&sctx->send_off);
@@ -7466,6 +7469,11 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 		ret = -EINVAL;
 		goto out;
 	}
+	if ((arg->flags & BTRFS_SEND_FLAG_COMPRESSED) &&
+	    !(arg->flags & BTRFS_SEND_FLAG_STREAM_V2)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	sctx = kzalloc(sizeof(struct send_ctx), GFP_KERNEL);
 	if (!sctx) {
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 9f4f7b96b1eb..9c83e14a43b2 100644
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
index 4f875f355e83..5c13e407982f 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -787,7 +787,9 @@ struct btrfs_ioctl_received_subvol_args {
 #define BTRFS_SEND_FLAG_MASK \
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
-	 BTRFS_SEND_FLAG_OMIT_END_CMD)
+	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
+	 BTRFS_SEND_FLAG_STREAM_V2 | \
+	 BTRFS_SEND_FLAG_COMPRESSED)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
-- 
2.33.0

