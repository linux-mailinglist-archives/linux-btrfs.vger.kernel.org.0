Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F87E5FB2C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJKM7D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJKM67 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:58:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0303E9259A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:58:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7237C22CED;
        Tue, 11 Oct 2022 12:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665493136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVhQlmVa1aSeCUPF1zoigN9SdnzeB/92oXRy9E9f2eA=;
        b=I0Ll4jn9+ilMb3BxuDron+9V8UJNat+7crPu1d0eMdDZYCeGGW0fubRnhEeKNSquZMlyb7
        b2VEEAV6B8GRspR6xVtskWooXw12btoICEkYLh6eE1SAGwlNzPbEAf/ME/8Pe32MpbK98R
        l70J+uFe/osRrL71W77VSaljQSw3vgw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6A7192C141;
        Tue, 11 Oct 2022 12:58:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A0C2DA79D; Tue, 11 Oct 2022 14:58:52 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/6] btrfs: convert extent_io page op defines to enum bits
Date:   Tue, 11 Oct 2022 14:58:52 +0200
Message-Id: <711685ccf495c8d04e1b0414bc660368fd4208a9.1665492943.git.dsterba@suse.com>
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

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 7929f054dda3..a5ec1475988f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -9,6 +9,7 @@
 #include <linux/btrfs_tree.h>
 #include "compression.h"
 #include "ulist.h"
+#include "misc.h"
 
 enum {
 	EXTENT_BUFFER_UPTODATE,
@@ -29,13 +30,15 @@ enum {
 };
 
 /* these are flags for __process_pages_contig */
-#define PAGE_UNLOCK		(1 << 0)
-/* Page starts writeback, clear dirty bit and set writeback bit */
-#define PAGE_START_WRITEBACK	(1 << 1)
-#define PAGE_END_WRITEBACK	(1 << 2)
-#define PAGE_SET_ORDERED	(1 << 3)
-#define PAGE_SET_ERROR		(1 << 4)
-#define PAGE_LOCK		(1 << 5)
+enum {
+	ENUM_BIT(PAGE_UNLOCK),
+	/* Page starts writeback, clear dirty bit and set writeback bit */
+	ENUM_BIT(PAGE_START_WRITEBACK),
+	ENUM_BIT(PAGE_END_WRITEBACK),
+	ENUM_BIT(PAGE_SET_ORDERED),
+	ENUM_BIT(PAGE_SET_ERROR),
+	ENUM_BIT(PAGE_LOCK),
+};
 
 /*
  * page->private values.  Every page that is controlled by the extent
-- 
2.37.3

