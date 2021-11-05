Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1358445CD7
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 01:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhKEADA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 20:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbhKEAC6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 20:02:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC88C061208
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Nov 2021 17:00:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m14so7323473pfc.9
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Nov 2021 17:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4ZWU2LSY/8fMe2bKv9z8A0OYdvuTTMqTMC9wGJR0D8=;
        b=QI2LroirSblq6PsN7JDDLWznLgES/yaJPVnMaZKEzEx0PYmnp6wmHWyDzoS62uKMXf
         sYxZ3QyWWg1BTD3DzaSeJrJn3g+3FDZRXCnQGvEwMHttRhrEByy82ElYBNJUegTCGhYv
         n7QOTGkhEwwT5vS9FfUyeYjIlKRtocCmO10KKPrd814ZGxWwsFtDmol5UR+p+a/56aWy
         wl/hkNLDleoFJ2jEAokQ8LBH7GHRCkRMI+IraLzmsopQCF660nBkumH+3g1/ekn/I0b+
         KqS8UhL2qpqCN4F4H+cr/RzwieoTCa6BRs2I0o3G1AzrqL1tIZ5Q/1GQNZLjmuPQPu9l
         2ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4ZWU2LSY/8fMe2bKv9z8A0OYdvuTTMqTMC9wGJR0D8=;
        b=SPYVReMeXYpsQSqeE5DHBdz6AxH+g09D6RoLqLUkrrrJHyHZ95zOOAl8nkOJzjtMN5
         Q7Lq8qqT/QIkognGlDCPhN+Qgi++8LcAsPONSKtSjP6RDjp4RE5UOATF2QeyRjJ9dOMo
         Sm7wwnZF5V4wewXKTk2Koclsn8m7+Y30hqpa75Gz3biJ1zzuQFIbw5S//O5hTVl9wiq/
         SH+vg2dZzvsdDwhzYcuOlNI1Ev4X8OZsIysX2bknz5U3O3NFkLsh5LeBumLRUJVt6OjM
         xro+jNvfQ0a3dVWSW4XGhGIcShQqyOyNCgMUq7hCEZKHO0SUVrY6p0v8dy9hNzrJMCx7
         rsEw==
X-Gm-Message-State: AOAM530lzaPn5dbefweiwT5Hz2X7H+VJJKmeFmdVxH4vgB+BqmvQH8lu
        ZMo+YHbL7z9MuU9uvROjbLkTOgEwvoG0gg==
X-Google-Smtp-Source: ABdhPJwoJlsWteIXWvTRQL4DMKUxzL1D29mbkHJereDl+Q9hQRpINe6hPVUlhkqakWoIaNSUz79RPA==
X-Received: by 2002:aa7:9212:0:b0:47b:aefd:2cc4 with SMTP id 18-20020aa79212000000b0047baefd2cc4mr55952000pfo.47.1636070419190;
        Thu, 04 Nov 2021 17:00:19 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:294c])
        by smtp.gmail.com with ESMTPSA id b28sm4620962pgn.67.2021.11.04.17.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 17:00:18 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: send: remove unused found_type parameter to lookup_dir_item_inode()
Date:   Thu,  4 Nov 2021 17:00:12 -0700
Message-Id: <9f0b80cced7d35466a9a8265e97b8749c4308764.1636070238.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1636070238.git.osandov@fb.com>
References: <cover.1636070238.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

As far as I can tell, this was never used. No functional change.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 040324d71118..9df4203edb19 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1692,8 +1692,7 @@ static int is_inode_existent(struct send_ctx *sctx, u64 ino, u64 gen)
  */
 static int lookup_dir_item_inode(struct btrfs_root *root,
 				 u64 dir, const char *name, int name_len,
-				 u64 *found_inode,
-				 u8 *found_type)
+				 u64 *found_inode)
 {
 	int ret = 0;
 	struct btrfs_dir_item *di;
@@ -1716,7 +1715,6 @@ static int lookup_dir_item_inode(struct btrfs_root *root,
 		goto out;
 	}
 	*found_inode = key.objectid;
-	*found_type = btrfs_dir_type(path->nodes[0], di);
 
 out:
 	btrfs_free_path(path);
@@ -1839,7 +1837,6 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	int ret = 0;
 	u64 gen;
 	u64 other_inode = 0;
-	u8 other_type = 0;
 
 	if (!sctx->parent_root)
 		goto out;
@@ -1867,7 +1864,7 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	}
 
 	ret = lookup_dir_item_inode(sctx->parent_root, dir, name, name_len,
-			&other_inode, &other_type);
+				    &other_inode);
 	if (ret < 0 && ret != -ENOENT)
 		goto out;
 	if (ret) {
@@ -1912,7 +1909,6 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 	int ret = 0;
 	u64 gen;
 	u64 ow_inode;
-	u8 other_type;
 
 	if (!sctx->parent_root)
 		goto out;
@@ -1936,7 +1932,7 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 
 	/* check if the ref was overwritten by another ref */
 	ret = lookup_dir_item_inode(sctx->send_root, dir, name, name_len,
-			&ow_inode, &other_type);
+				    &ow_inode);
 	if (ret < 0 && ret != -ENOENT)
 		goto out;
 	if (ret) {
-- 
2.33.1

