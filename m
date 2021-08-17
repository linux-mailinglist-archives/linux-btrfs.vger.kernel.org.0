Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB9D3EF48B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 23:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhHQVIU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 17:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbhHQVIP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 17:08:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D0C0617AD
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 14:07:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so957942pjb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNu5mrEDkUu1+c4KpS1at46xpxHzVFJl6vbVaOyuFx8=;
        b=dLFACyM6FKZ+F7Gk22kbOIc0MWcQ/FlxCwu1Sa3Zi4O6o+65+FBNXa8irs3mvauO8e
         xn2RVBdAUx+zOGAQlZJWEeYeRAJGaLyvNCN8PhCmStgVKliSXnh9CFX/yEE5J+SGgmDY
         z1u6B4ozQsW/zabXl7q8MW+Tyx3N0IGKMp0YFNWBECPdqWuRASL0oD0Cn243ysYIeJNe
         Q3Dd0bBO0Z2HCNRZqZK8InaLY66j8w+VcqBZELa7kHIwQqCd8MJGprWHfgxKKcV5TkKH
         8h1mkmh5ps0w5+wbgWm8XVDttbyKvnpyDbOyKdu38x9XL7dALO4ADkuMosmMYQohguWb
         y+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNu5mrEDkUu1+c4KpS1at46xpxHzVFJl6vbVaOyuFx8=;
        b=qiq/rTYmdHxKyTPgzsOJ+Hl8VgjrDNJooa8vU2Zf8HFZJzOkWKoV8E4f1Ftw4a0nv+
         Xx+tufpyK4PU3pvXu0MhSMi5CtvMicaappoYfqkP8EelOrvkPqzfB88wmAvmhGWy+UvR
         P4Pr7bDxYigJYLqvnER30mH3k+IWbCEE2QuXmvxGINqxyTiIGdmccnQo7wnQyrK3BU4e
         nTOGo+JLwjE/8MMf0lEGwhM682CYe1sNJiaa/qR2ikWw9K092Zk9DU7l8wNMJHrbIZGO
         bAx7BrTcXHfrefxPC9ryslXeuyOpAAio8cHwBPos1fDtpUJaBFO6SQAsnefADMHHOSO6
         B+QQ==
X-Gm-Message-State: AOAM533FO9h90ckkuMRnawv+9uE42NsNtMOPdLxlq/+djFDJVoYNryr1
        1xpfOG/knulntWHCMNZOv4WmLP7GssjPlQ==
X-Google-Smtp-Source: ABdhPJxcnBlYV8pYhXMAi1r1Xj9MFzsQ918GGWqd2zE1cjhHMnEb724ljx3lZE/Y5HT5NzHEPxznag==
X-Received: by 2002:a63:eb06:: with SMTP id t6mr5373402pgh.235.1629234454562;
        Tue, 17 Aug 2021 14:07:34 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:34 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 14/14] btrfs: send: enable support for stream v2 and compressed writes
Date:   Tue, 17 Aug 2021 14:06:46 -0700
Message-Id: <a87f8dd5b9e777c136ab986baa9b751f9c1909a6.1629234193.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
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
index 363a69125023..5b4a73d76991 100644
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
@@ -7473,6 +7476,11 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
2.32.0

