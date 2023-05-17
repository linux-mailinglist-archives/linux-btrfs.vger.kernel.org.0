Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9BA70614D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 09:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjEQHgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 03:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjEQHgL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 03:36:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33111527C
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 00:36:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2D7B203B0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684308963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=shT6JAVzDIl9W31VXrwplD+sYZEFYwPLksGTz/UxirY=;
        b=XB5+UwDxscelAN+of/+wfKo2A7gD8PUaQWkCxU9qe+l53QPrHXXZV9vMh2sGgC+1ldLxHi
        EQfbw9M0M16W1fDbV9klxUmSJiocq1T73jIxqvOf8A5EkiWXXWNe7SVVWzJHwnFpJvfvRr
        NX6+wWjS6jOhiPLzfj1aTYk81yzat0M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B59113358
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OFGsM+KDZGQkEQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs-progs: tune: implement the prerequisite checks for csum change
Date:   Wed, 17 May 2023 15:35:37 +0800
Message-Id: <7e638e79f7e1d2bce75961626f3aa18ff8a5abc2.1684308139.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684308139.git.wqu@suse.com>
References: <cover.1684308139.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The overall idea is to make sure no running operations (balance,
dev-replace, dirty log) for the fs before csum change.

And also reject half converted csums for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index 7a9f6351e7fe..daab70b6eb4a 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -26,9 +26,68 @@
 #include "common/internal.h"
 #include "tune/tune.h"
 
+static int check_csum_change_requreiment(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_root *dev_root = fs_info->dev_root;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	int ret;
+
+	if (btrfs_super_log_root(fs_info->super_copy)) {
+		error("dirty log tree detected, please replay the log or zero it.");
+		return -EINVAL;
+	}
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		error("no csum change support for extent-tree-v2 feature yet.");
+		return -EOPNOTSUPP;
+	}
+	if (btrfs_super_flags(fs_info->super_copy) &
+	    (BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM |
+	     BTRFS_SUPER_FLAG_CHANGING_META_CSUM)) {
+		error("resume from half converted status is not yet supported");
+		return -EOPNOTSUPP;
+	}
+	key.objectid = BTRFS_BALANCE_OBJECTID;
+	key.type = BTRFS_TEMPORARY_ITEM_KEY;
+	key.offset = 0;
+	ret = btrfs_search_slot(NULL, tree_root, &key, &path, 0, 0);
+	btrfs_release_path(&path);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to check the balance status: %m");
+		return ret;
+	}
+	if (ret == 0) {
+		error("running balance detected, please finish or cancel it.");
+		return -EINVAL;
+	}
+
+	key.objectid = 0;
+	key.type = BTRFS_DEV_REPLACE_KEY;
+	key.offset = 0;
+	ret = btrfs_search_slot(NULL, dev_root, &key, &path, 0, 0);
+	btrfs_release_path(&path);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to check the dev-reaplce status: %m");
+		return ret;
+	}
+	if (ret == 0) {
+		error("running dev-replace detected, please finish or cancel it.");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 {
+	int ret;
+
 	/* Phase 0, check conflicting features. */
+	ret = check_csum_change_requreiment(fs_info);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * Phase 1, generate new data csums.
-- 
2.40.1

