Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340E15B90CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiINXFL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiINXFF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:05 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6021233A1B
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:04 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id s13so12906975qvq.10
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=Rcw64DFDCoMCM3XgBo2XyHZt4i3K7pFq0lg53ulW630=;
        b=3taJUPa6OGRlFd4ryl8/oXZkLWmpu2KmyBjJVbQgVjS16noJTih++bbUGo4QYwkZ7b
         WkMC/ahN3dKKym0mMWNRxAGCAUaqHM/08R1LKEzmYD1kGVmJh9fc0rgAGqNYf8xwzSUK
         v1oEjXXAl/1y6V/rFdITKCUB249fWOFlDhm2hxohmif9n/hNfz7rzBp1E+hpWV6mkrPI
         Abk/BMvoKcKXWZ0totRtp08AKjBdZhFvDgMf6bIHhZn3kroTGrR+SJyU+5UJO5mXCRbk
         kBerJ1ggPXzNDH8CRY2P4hJxWiAYGauXkfeq7vSiz574mxLp4vNICrptQ5Sj4LoIszE1
         j3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Rcw64DFDCoMCM3XgBo2XyHZt4i3K7pFq0lg53ulW630=;
        b=0ESzP46O/BsjKKgagcE1X42gJlxv8ebdDJX1SmfYVloREQlAe3dkjq7gy20+fbZvcA
         UBjnn0tf/xRHSclpln68NrWdsE5mwjabcShQ1bDhiUaSCREE4EkTAcoCKyQsSNZIhOjk
         xMPNj91Ot3/3BkMS9UktniTcgbvrpAxfvhhFDv+YS4fYHvtehmL34CdjitKUZU7NECPO
         hEg4FTobQ6qj6D78sjR7ZvEgH7KeEQc1+sM4YD32kKf3/s+koU80dI8Bm5WzolJ8Hd8B
         5ht99YGHqV4gdewTe7rRWMes+F3uyU4HuoM1ZwLf+TLOi2DyBd6E9maYRQ+MFXKHbzQt
         CPiA==
X-Gm-Message-State: ACgBeo0r8RDpbauwWd9PwWARBkT2QsEWfrr/7gJkEi7+F5p1nBmRP5kN
        OHxoUXzgBzkBS+TOn73xhkDkt09AohRbRg==
X-Google-Smtp-Source: AA6agR6ygBCbO7iJ9HlwilzF8muq4vBxkAfs3bU3ioyBIeKmVwETTTbE4JoRI9HtZw0WNCsL4nfVVg==
X-Received: by 2002:a05:6214:23cc:b0:496:fa7b:2503 with SMTP id hr12-20020a05621423cc00b00496fa7b2503mr32980780qvb.38.1663196702939;
        Wed, 14 Sep 2022 16:05:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a430d00b006b953a7929csm2886241qko.73.2022.09.14.16.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:05:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/15] btrfs: move btrfs_swapfile_pin into volumes.h
Date:   Wed, 14 Sep 2022 19:04:43 -0400
Message-Id: <be6105cf39b5ff328622fb4b7003beac385f4f28.1663196541.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196541.git.josef@toxicpanda.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
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

This isn't a great spot for this, but one of the swapfile helper
functions is in volumes.c, so move the struct to volumes.h.  In the
future when we have better separation of code there will be a more
natural spot for this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   | 25 -------------------------
 fs/btrfs/volumes.h | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3cb4e0aca058..b9e848a22290 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -215,31 +215,6 @@ struct btrfs_fs_devices;
 struct btrfs_balance_control;
 struct btrfs_delayed_root;
 
-/*
- * Block group or device which contains an active swapfile. Used for preventing
- * unsafe operations while a swapfile is active.
- *
- * These are sorted on (ptr, inode) (note that a block group or device can
- * contain more than one swapfile). We compare the pointer values because we
- * don't actually care what the object is, we just need a quick check whether
- * the object exists in the rbtree.
- */
-struct btrfs_swapfile_pin {
-	struct rb_node node;
-	void *ptr;
-	struct inode *inode;
-	/*
-	 * If true, ptr points to a struct btrfs_block_group. Otherwise, ptr
-	 * points to a struct btrfs_device.
-	 */
-	bool is_block_group;
-	/*
-	 * Only used when 'is_block_group' is true and it is the number of
-	 * extents used by a swapfile for this block group ('ptr' field).
-	 */
-	int bg_extent_count;
-};
-
 /*
  * Exclusive operations (device replace, resize, device add/remove, balance)
  */
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index db4cf51134fd..2bf7dbe739fd 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -180,6 +180,31 @@ struct btrfs_device {
 	u64 scrub_speed_max;
 };
 
+/*
+ * Block group or device which contains an active swapfile. Used for preventing
+ * unsafe operations while a swapfile is active.
+ *
+ * These are sorted on (ptr, inode) (note that a block group or device can
+ * contain more than one swapfile). We compare the pointer values because we
+ * don't actually care what the object is, we just need a quick check whether
+ * the object exists in the rbtree.
+ */
+struct btrfs_swapfile_pin {
+	struct rb_node node;
+	void *ptr;
+	struct inode *inode;
+	/*
+	 * If true, ptr points to a struct btrfs_block_group. Otherwise, ptr
+	 * points to a struct btrfs_device.
+	 */
+	bool is_block_group;
+	/*
+	 * Only used when 'is_block_group' is true and it is the number of
+	 * extents used by a swapfile for this block group ('ptr' field).
+	 */
+	int bg_extent_count;
+};
+
 /*
  * If we read those variants at the context of their own lock, we needn't
  * use the following helpers, reading them directly is safe.
-- 
2.26.3

