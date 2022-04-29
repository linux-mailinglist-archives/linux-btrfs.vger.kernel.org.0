Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B28A514C98
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376611AbiD2OUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 10:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358148AbiD2OUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 10:20:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791828FFBB
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 07:17:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 36A88210DC;
        Fri, 29 Apr 2022 14:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651241855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TGTvW839WQHb6Zh1RSumUrwduxP8ImrmbERVNNx2I60=;
        b=V66ecYJEazJnqMVTs7MPgFwnJ4vR22sfkqKXhsT3EpmRJ7C3Jd8TkqrjM8Huf2K//Bl1te
        1UEARyXP1l3ks9yjUdf+JMy8Bbv5wHl2o71iAEDWdfC1Q0X5l5+v5fWdHvgoWZWp8wQDCt
        tfqASDi9yWFuN17xBQ/skWv5q7n53L0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0845613AE0;
        Fri, 29 Apr 2022 14:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YHIMO37za2LnEQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 29 Apr 2022 14:17:34 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v5] btrfs: improve error reporting in lookup_inline_extent_backref
Date:   Fri, 29 Apr 2022 17:17:34 +0300
Message-Id: <20220429141734.866132-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
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

V5:
 * Stop printing the key we are searching for as it was both wrong and redundant,
 since we have the slot number printed anyway. (Filipe)

V4:
 * Also print the value of 'parent' as it's pertinent when metadata inline backrefs
 are being searched (Filipe)
 * Print the leaf before printing the error message so that the latter is
 not lost (Filipe)

V3:
 * Fixed format for the btree slot
 * Removed redundant argument passed to format string

 fs/btrfs/extent-tree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 963160a0c393..cca89016f2b3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -895,7 +895,14 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	err = -ENOENT;
 	while (1) {
 		if (ptr >= end) {
-			WARN_ON(ptr > end);
+			if (ptr > end) {
+				err = -EUCLEAN;
+				btrfs_print_leaf(path->nodes[0]);
+				btrfs_crit(fs_info,
+"overrun extent record at slot %d while looking for inline extent for root %llu owner %llu offset %llu parent %llu",
+				path->slots[0], root_objectid, owner, offset,
+				parent);
+			}
 			break;
 		}
 		iref = (struct btrfs_extent_inline_ref *)ptr;
--
2.25.1

