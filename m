Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6E797F27
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjIGXQQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjIGXQQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:16:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAD3BD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:16:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 231931F461;
        Thu,  7 Sep 2023 23:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694128571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IuUxyw5cE8elgG6hcUpbcNT4BM053c33sUB5W56ppg4=;
        b=Njl0DHOX917LicHAVJlGFB/n2V9cK7r5VImE3IwyZ1hsqEH3mIPE9xC+QQKabDkgwvUz4Y
        4GtSLIHR/dP83JYdKGa3ZbhM9jOcct8Pmzu2DzROeHFy/efwdq6u8zurqhKYZxgm4p0OFW
        zF50cKfrXk56uX27+XuKO9XbrY+tjDU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 165EC2C142;
        Thu,  7 Sep 2023 23:16:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4EB7FDA8C5; Fri,  8 Sep 2023 01:09:40 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 09/10] btrfs: reduce size of struct btrfs_ref
Date:   Fri,  8 Sep 2023 01:09:40 +0200
Message-ID: <c9b508651bafb53e98b9f194271d4b7b2d309cba.1694126893.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694126893.git.dsterba@suse.com>
References: <cover.1694126893.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can reduce two members' size that in turn reduce size of struct
btrfs_ref from 64 to 56 bytes. As the structure is often used as a local
variable several functions reduce their stack usage.

- make enum btrfs_ref_type packed, there are only 4 values

- switch action and its values to a packed enum

Final structure layout:

struct btrfs_ref {
        enum btrfs_ref_type        type;                 /*     0     1 */
        enum btrfs_delayed_ref_action action;            /*     1     1 */
        bool                       skip_qgroup;          /*     2     1 */

        /* XXX 5 bytes hole, try to pack */

        u64                        bytenr;               /*     8     8 */
        u64                        len;                  /*    16     8 */
        u64                        parent;               /*    24     8 */
        union {
                struct btrfs_data_ref data_ref;          /*    32    24 */
                struct btrfs_tree_ref tree_ref;          /*    32    16 */
        };                                               /*    32    24 */

        /* size: 56, cachelines: 1, members: 7 */
        /* sum members: 51, holes: 1, sum holes: 5 */
        /* last cacheline: 56 bytes */
};

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-ref.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index b8e14b0ba5f1..224278d4516f 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -9,10 +9,16 @@
 #include <linux/refcount.h>
 
 /* these are the possible values of struct btrfs_delayed_ref_node->action */
-#define BTRFS_ADD_DELAYED_REF    1 /* add one backref to the tree */
-#define BTRFS_DROP_DELAYED_REF   2 /* delete one backref from the tree */
-#define BTRFS_ADD_DELAYED_EXTENT 3 /* record a full extent allocation */
-#define BTRFS_UPDATE_DELAYED_HEAD 4 /* not changing ref count on head ref */
+enum btrfs_delayed_ref_action {
+	/* Add one backref to the tree */
+	BTRFS_ADD_DELAYED_REF = 1,
+	/* Delete one backref from the tree */
+	BTRFS_DROP_DELAYED_REF,
+	/* Record a full extent allocation */
+	BTRFS_ADD_DELAYED_EXTENT,
+	/* Not changing ref count on head ref */
+	BTRFS_UPDATE_DELAYED_HEAD,
+} __packed;
 
 struct btrfs_delayed_ref_node {
 	struct rb_node ref_node;
@@ -183,7 +189,7 @@ enum btrfs_ref_type {
 	BTRFS_REF_DATA,
 	BTRFS_REF_METADATA,
 	BTRFS_REF_LAST,
-};
+} __packed;
 
 struct btrfs_data_ref {
 	/* For EXTENT_DATA_REF */
@@ -223,7 +229,7 @@ struct btrfs_tree_ref {
 
 struct btrfs_ref {
 	enum btrfs_ref_type type;
-	int action;
+	enum btrfs_delayed_ref_action action;
 
 	/*
 	 * Whether this extent should go through qgroup record.
-- 
2.41.0

