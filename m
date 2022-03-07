Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2B44D0ADB
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbiCGWTH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343728AbiCGWTF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:19:05 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1547043EE3
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:18:10 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id eq14so7280091qvb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zO8D+uznSKQF47FFyXnBpKBdi6Wj0A7XLdYdPcd1D/s=;
        b=RTu6cTMu9osN4e6VXnxcfzdAjrpJ7jDSAq4YnO68BNhMTQ2dzx30fvGxx2VMiAxpEZ
         duB57BOiPB2WbDspe2Gnr3q5lFSgFBLKqmOuV8PkjSb5Q/nME7oMzZPm5mQMwyn89wt1
         BVC7cSvnOrFjaMAXcVaLycPY15SJCR34+aHZJ44Aej4ksGTSANLVHK6W6D/WrSG+qr2L
         qWQw99GLHZqmURhDp0QZ0Sv0ONrVBTa8MXQuX2uq7aEmBAyNcX3hwWtsbCX6AFH3NtGz
         q5eMPYt9om/ZMhDnS2nYSSiQuBhdtCBGt6ZzYVuEByu8jg4Zoh0ftLYYvOi3z98chD66
         vJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zO8D+uznSKQF47FFyXnBpKBdi6Wj0A7XLdYdPcd1D/s=;
        b=osnHKQmXC861Hn2LBtgJiUZ/Deqz0XjifXFVHGtUc9lVI0lLLK9jlB1qzIiRkVJ494
         MIHCAVSZC7EEvd8mIQBYD0guHzrBKyII74wOdH0vwIQnGRvOfi1nQOzluUAktv+Fpz8L
         2hGoejOhXDOfXx60L5ELUXyODmm+Bj5gVhkNqBEvDxKRI2TmnozxtWxViWB3M0lXo7+4
         F5ftFDy1vQA9iVSdQdmsHdedsFRX8lIc9VlLczvFQN/glkFIzZwrVTxUhrQzBOUo5j03
         NjuzFpLIC3IYKwFSxOuSsBRqa/8tmOVtY9MFR4Sucn+Up8K0J/70eALTyZaWQd9NihYz
         tKAg==
X-Gm-Message-State: AOAM533eB2ahpQ5Wur1bdcR2n31atUI/WTu41+LD0V6Gl8gEh7Y5Micl
        eFw16ajlIChkM0dUrPEpcejA3LRQrNTc+zgn
X-Google-Smtp-Source: ABdhPJwNuKO+LlSkqk60sM0plGJcfSEsH91KiTpEHvMM9Dc9hZ32UH1EIHvN0HEzAYiMGjoymClZ/Q==
X-Received: by 2002:a05:6214:621:b0:432:5e0d:cb64 with SMTP id a1-20020a056214062100b004325e0dcb64mr10113949qvx.65.1646691488970;
        Mon, 07 Mar 2022 14:18:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p12-20020a05622a048c00b002de8f67b60dsm9656442qtx.58.2022.03.07.14.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:18:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/15] btrfs-progs: add a snapshot_id to the btrfs_root_item
Date:   Mon,  7 Mar 2022 17:17:47 -0500
Message-Id: <bf5b0d8b7cafc303d2687c1aa0a44708a6d0f094.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
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

This is going to be used to keep track of when a snapshot of this root
was taken last.  Any time we are snapshotted we will increase this value
and set the new extent buffers to this snapshot_id.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h   | 11 ++++++++++-
 kernel-shared/disk-io.c |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 8c4f6ed6..f5b32264 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -859,7 +859,14 @@ struct btrfs_root_item {
 	 * this root.
 	 */
 	__le64 global_tree_id;
-        __le64 reserved[7]; /* for future */
+
+	/*
+	 * Indicates the current snapshot id, every time we are snapshotted this
+	 * is increased.
+	 */
+	__le64 snapshot_id;
+
+        __le64 reserved[6]; /* for future */
 } __attribute__ ((__packed__));
 
 /*
@@ -2262,6 +2269,8 @@ BTRFS_SETGET_STACK_FUNCS(root_stransid, struct btrfs_root_item,
 			 stransid, 64);
 BTRFS_SETGET_STACK_FUNCS(root_rtransid, struct btrfs_root_item,
 			 rtransid, 64);
+BTRFS_SETGET_STACK_FUNCS(root_snapshot_id, struct btrfs_root_item,
+			 snapshot_id, 64);
 
 static inline struct btrfs_timespec* btrfs_root_ctime(
 		struct btrfs_root_item *root_item)
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 078ab0fb..58831550 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2480,6 +2480,9 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	memset(root->root_item.uuid, 0, BTRFS_UUID_SIZE);
 	root->root_item.drop_level = 0;
 
+	/* This is safe to do on both versions since we used a reserved area. */
+	btrfs_set_root_snapshot_id(&root->root_item, 0);
+
 	ret = btrfs_insert_root(trans, tree_root, &root->root_key,
 				&root->root_item);
 	if (ret)
-- 
2.26.3

