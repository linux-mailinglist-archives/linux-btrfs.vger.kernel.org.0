Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B225B8B50
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiINPHH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiINPGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:55 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B98678218
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:53 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i3so6375412qkl.3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=i6BWu4JC1XN096ArKhIcaU5s6vdKKjahtDAjlDa2K0A=;
        b=VGJa/3G4/aJTixlxfsPj2TwSt/oLgP0m6GEtawNMGattzb27Y2ht0YTZAKYDM+0Q7B
         HlX3yZKr0+tgBZoG5/el9KHcgrFPE1+sdTFF+uzRS4l08Zuj3hExmUoWRuxgUuRWA14U
         keAIQq07OunyVie36QgqOsGZ4uEylm1ZDMnWgCeZK9fZAI0O7RkRIqidqKRnWxdTPYdt
         iEPhcbZG1zTWCv56bJDHgvwtCHeIN1RTYcntbCER/LOKJa5FjzHHYxF6hFkC/e8h59E6
         1W7A/P0HKLos6pPDZtzW0hBB0VS0H6sG0ksSqRrzKCxtOU9IKqrr7oQeeq4DX3LyKn1w
         x8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=i6BWu4JC1XN096ArKhIcaU5s6vdKKjahtDAjlDa2K0A=;
        b=Yc7tEs2RLYo/6F5SW5lM5myRiWxTcMg/rQVWE3C+iWp5xuySbDW0VMgythfX9gCQcP
         m3jd+R84iqtx+7Jry/UJgwNnZhP/TVH/tvL+bUlQcamUTHSZiShT5tOZdyCDSy+UwxqO
         IFnseYnYXtgoMbtUhiHlWajsWRgGZgPhCYobZ6IuFeIXCe0MxDCHm3ppTw8Ry0A3kOEX
         HNv+gAr84OPo/1weVsn0o41wvP1kmMkHI1ldSgcxi5u5YmCKsmjeNR8CFI5RAoP6o7hH
         qwquhfJfg+ZDbmVvDi+ZGlELwZ1r7K2DrqYKCi1MsA1bjPTkLz/kRYBtjVvmYdyAQKiP
         j0mA==
X-Gm-Message-State: ACgBeo2VT61fDmUhfulAGFdJn+Q2ysmRc4vlTlT+WzsOvZF+6K1btqEk
        cilD0tuAXwRMcW4CDdIWQTLBz3G+/RSzqw==
X-Google-Smtp-Source: AA6agR6HwN9+q27jJ9bZLFEokYaRML3nH86W0o/sB97Vm8s6zLQCe6gA63u+hWKdF3fC3a9nZ2DukA==
X-Received: by 2002:a37:b404:0:b0:6c1:a498:2f46 with SMTP id d4-20020a37b404000000b006c1a4982f46mr27520950qkf.509.1663168011756;
        Wed, 14 Sep 2022 08:06:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t16-20020a05622a01d000b0035bb6c3811asm1739897qtw.53.2022.09.14.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/17] btrfs: move maximum limits to btrfs_tree.h
Date:   Wed, 14 Sep 2022 11:06:30 -0400
Message-Id: <e0640b40762be99c72f7bfbb295431d405624f1d.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

We have maximum link and name length limits, move these to btrfs_tree.h
as they're on disk limitations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h                | 13 -------------
 include/uapi/linux/btrfs_tree.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c3a8440d3223..5e6b025c0870 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -63,19 +63,6 @@ struct btrfs_ioctl_encoded_io_args;
 
 #define BTRFS_OLDEST_GENERATION	0ULL
 
-/*
- * we can actually store much bigger names, but lets not confuse the rest
- * of linux
- */
-#define BTRFS_NAME_LEN 255
-
-/*
- * Theoretical limit is larger, but we keep this down to a sane
- * value. That should limit greatly the possibility of collisions on
- * inode ref items.
- */
-#define BTRFS_LINK_MAX 65535U
-
 #define BTRFS_EMPTY_DIR_SIZE 0
 
 #define BTRFS_DIRTY_METADATA_THRESH	SZ_32M
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index e6bf902b9c92..c85e8c44ab92 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -14,6 +14,19 @@
 
 #define BTRFS_MAX_LEVEL 8
 
+/*
+ * we can actually store much bigger names, but lets not confuse the rest
+ * of linux
+ */
+#define BTRFS_NAME_LEN 255
+
+/*
+ * Theoretical limit is larger, but we keep this down to a sane
+ * value. That should limit greatly the possibility of collisions on
+ * inode ref items.
+ */
+#define BTRFS_LINK_MAX 65535U
+
 /*
  * This header contains the structure definitions and constants used
  * by file system objects that can be retrieved using
-- 
2.26.3

