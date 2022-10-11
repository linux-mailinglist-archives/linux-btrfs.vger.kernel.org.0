Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BDA5FB2C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJKM7J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJKM7H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:59:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CEE923F3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:59:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E7D5122D0E;
        Tue, 11 Oct 2022 12:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665493142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xrtqFwVBrmr/GsYBKt3ysIJzyOJ6QwrijqDWHil35tk=;
        b=Qk5+llHXynRQEJWQUIrz1Q8leDU5DYN63aH03wWC1iBvtJtP1g73a+0NA9FXpwwh8nl0L7
        qoKcL5iSoqWoNQg+7PUVmVNNZ75PsrUVsSCE8VjKsMilKXCtDJrSxicE2baPHpusEAhx9T
        HoNIY0078vSrYBBdr0xinq0oNj+8byQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DFCF42C141;
        Tue, 11 Oct 2022 12:59:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9B4F7DA79D; Tue, 11 Oct 2022 14:58:58 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/6] btrfs: convert __TRANS_* defines to enum bits
Date:   Tue, 11 Oct 2022 14:58:58 +0200
Message-Id: <58ba216ab6fde7741b4fdb970f04c61b65bec918.1665492943.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665492943.git.dsterba@suse.com>
References: <cover.1665492943.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The base transaction bits can be defined as bits in a contiguous
sequence, although right now there's a hole from bit 1 to 8.

The bits are used for btrfs_trans_handle::type, and there's another set
of TRANS_STATE_* defines that are for btrfs_transaction::state. They are
mutually exclusive though the hole in the sequence looks like was made
for the states.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/transaction.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 1332f193b800..b39ebf98af60 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -10,6 +10,7 @@
 #include "btrfs_inode.h"
 #include "delayed-ref.h"
 #include "ctree.h"
+#include "misc.h"
 
 enum btrfs_trans_state {
 	TRANS_STATE_RUNNING,
@@ -98,14 +99,15 @@ struct btrfs_transaction {
 	struct list_head releasing_ebs;
 };
 
-#define __TRANS_FREEZABLE	(1U << 0)
-
-#define __TRANS_START		(1U << 9)
-#define __TRANS_ATTACH		(1U << 10)
-#define __TRANS_JOIN		(1U << 11)
-#define __TRANS_JOIN_NOLOCK	(1U << 12)
-#define __TRANS_DUMMY		(1U << 13)
-#define __TRANS_JOIN_NOSTART	(1U << 14)
+enum {
+	ENUM_BIT(__TRANS_FREEZABLE),
+	ENUM_BIT(__TRANS_START),
+	ENUM_BIT(__TRANS_ATTACH),
+	ENUM_BIT(__TRANS_JOIN),
+	ENUM_BIT(__TRANS_JOIN_NOLOCK),
+	ENUM_BIT(__TRANS_DUMMY),
+	ENUM_BIT(__TRANS_JOIN_NOSTART),
+};
 
 #define TRANS_START		(__TRANS_START | __TRANS_FREEZABLE)
 #define TRANS_ATTACH		(__TRANS_ATTACH)
-- 
2.37.3

