Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39345FB2C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJKM7H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJKM7F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:59:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34801923F5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:59:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BEF0A22D01;
        Tue, 11 Oct 2022 12:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665493140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=doVTMliFDmWrSVTs3ddemsq9ccwK7qNO3cvrUQdyCRU=;
        b=XnyWkv8e6J9bvGMacGHZ9bvY2PJDoRD6gBCO9iX4R4fiO8LE4c6hyT2vOmsrq097rlnDPT
        vRikxgESBsu0WOwkx5McdnUz8GgcdXmHmHFX8fL/21/p3j/1hv+ZEBjXrIOVF/sMUWDRtL
        t/C+nYwcgwHAXGRANrQrWIOT7qGKW3w=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B73352C141;
        Tue, 11 Oct 2022 12:59:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 72D78DA79D; Tue, 11 Oct 2022 14:58:56 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/6] btrfs: convert QGROUP_* defines to enum bits
Date:   Tue, 11 Oct 2022 14:58:56 +0200
Message-Id: <2bd0d78d5dcdb94ce6df35ecf70d1586febcb1f5.1665492943.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665492943.git.dsterba@suse.com>
References: <cover.1665492943.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The defines/enums are used only for tracepoints and are not part of the
on-disk format.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/qgroup.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 578c77e94200..3fb5459c9309 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -11,6 +11,7 @@
 #include <linux/kobject.h>
 #include "ulist.h"
 #include "delayed-ref.h"
+#include "misc.h"
 
 /*
  * Btrfs qgroup overview
@@ -242,9 +243,11 @@ static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
 /*
  * For qgroup event trace points only
  */
-#define QGROUP_RESERVE		(1<<0)
-#define QGROUP_RELEASE		(1<<1)
-#define QGROUP_FREE		(1<<2)
+enum {
+	ENUM_BIT(QGROUP_RESERVE),
+	ENUM_BIT(QGROUP_RELEASE),
+	ENUM_BIT(QGROUP_FREE),
+};
 
 int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
-- 
2.37.3

