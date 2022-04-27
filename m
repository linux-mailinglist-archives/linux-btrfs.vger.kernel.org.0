Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C1E5117E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiD0MAs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 08:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiD0MAq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 08:00:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3921340EA
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 04:57:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B04131F749;
        Wed, 27 Apr 2022 11:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651060653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZlC9Gw3X8QTVjPkjSW5ft4oW8NNE+wsXXvvblfwXBU=;
        b=aKZvfurEIGqJDDR9ToCWYOnrLroUd0k5mIk3RBcDcAvKG+pdFtD94ip1/tW908v1ZruyTE
        j5hv9gmKs1AuAjJKdU1s4xSb4tFy/GbdZu16S/RzDCsT1OeT2sOAGrTwnPx3h8CZX1nG5p
        OuIqwERv3MJDvtBSw+Fx9g0xkpuvPPI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78B3B13A39;
        Wed, 27 Apr 2022 11:57:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pn+KGq0vaWJpLAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 27 Apr 2022 11:57:33 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3] btrfs: improve error reporting in lookup_inline_extent_backref
Date:   Wed, 27 Apr 2022 14:57:32 +0300
Message-Id: <20220427115732.719350-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427100344.700330-1-nborisov@suse.com>
References: <20220427100344.700330-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When iterating the backrefs in an extent item if the ptr to the
'current' backref record goes beyond the extent item a warning is
generated and -ENOENT is returned. However what's more appropriate to
debug such cases would be to return EUCLEAN and also print identifying
information about the performed search as well as the current content of
the leaf containing the possibly corrupted extent item.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V3:
 * Fixed format for the btree slot
 * Removed redundant argument passed to format string

 fs/btrfs/extent-tree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 963160a0c393..eaac79d8c0e9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -895,7 +895,14 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	err = -ENOENT;
 	while (1) {
 		if (ptr >= end) {
-			WARN_ON(ptr > end);
+			if (ptr > end) {
+				err = -EUCLEAN;
+				btrfs_crit(fs_info,
+"overrun extent record at slot %d [%llu BTRFS_EXTENT_ITEM_KEY %llu] while looking for inline extent for root %llu owner %llu offset %llu",
+				path->slots[0], bytenr, num_bytes,
+				root_objectid, owner, offset);
+				btrfs_print_leaf(path->nodes[0]);
+			}
 			break;
 		}
 		iref = (struct btrfs_extent_inline_ref *)ptr;
--
2.25.1

