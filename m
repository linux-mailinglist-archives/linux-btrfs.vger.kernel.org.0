Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECBF54C9CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 15:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352950AbiFONaC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354089AbiFON3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 09:29:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB8B340D6
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 06:29:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C140E21C63;
        Wed, 15 Jun 2022 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655299776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPyWPgthXOxwwrzpF/6JV+7QTSdY3byeyXMIysflhf4=;
        b=XXqOASuhxKF4QNyDTQY9wK63aG3mfyocrZe1rWMO74w3ktz/5PkIa1iXPdrqid51+HBGyF
        rQHx4ldWrtGE1CJCnu/FbcLlivZ2FBn0aywpVhqALz0VhIYGujjKeO8tG5GMTBXCPkp9f2
        C/8kRhs2r5qDUSYZ+w9Qe/2ib//xR6g=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BA9AF2C141;
        Wed, 15 Jun 2022 13:29:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 68606DA85E; Wed, 15 Jun 2022 15:25:04 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/6] btrfs: send: simplify includes
Date:   Wed, 15 Jun 2022 15:25:04 +0200
Message-Id: <74ddfd3cfa958a3af2f8a530ccdc92ca07582043.1655299339.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655299339.git.dsterba@suse.com>
References: <cover.1655299339.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't need the whole ctree.h in send.h, none of the data types
defined there are used.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 1 +
 fs/btrfs/send.h | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ba87e1ba1f2a..d8d4f062cd4f 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -16,6 +16,7 @@
 #include <linux/crc32c.h>
 
 #include "send.h"
+#include "ctree.h"
 #include "backref.h"
 #include "locking.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 2cce43ddcad5..4bb4e6a638cb 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -7,7 +7,7 @@
 #ifndef BTRFS_SEND_H
 #define BTRFS_SEND_H
 
-#include "ctree.h"
+#include <linux/types.h>
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
 #define BTRFS_SEND_STREAM_VERSION 2
@@ -18,6 +18,9 @@
  */
 #define BTRFS_SEND_BUF_SIZE_V1				SZ_64K
 
+struct inode;
+struct btrfs_ioctl_send_args;
+
 enum btrfs_tlv_type {
 	BTRFS_TLV_U8,
 	BTRFS_TLV_U16,
-- 
2.36.1

