Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D198508770
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 13:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378293AbiDTL4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 07:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378290AbiDTL4v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 07:56:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1568A3E5D8
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 04:54:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B1D2621115;
        Wed, 20 Apr 2022 11:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650455643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wWzK0Xf3Q9B/y8SU96vr/2/Kk6Fv/FEpoBzE7URTi/U=;
        b=br9nchA4aatAyvmiNDKjeaUqmQo4hrvID9nQMs16Vw07BLvwwlE1qxtxtztDqbfVIqmMDL
        ofhPOGpxD/0l8753XkJrwvG66ANHljWR6OQuN9m3ssTFsxux8rxPt2ZgDBF1lXCNHR4Iu4
        4/6BERDKcY6244uk9gT1RQ3/3LdPQHE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C49513A30;
        Wed, 20 Apr 2022 11:54:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yLF9G1v0X2LWUwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 20 Apr 2022 11:54:03 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Improve error reporting in lookup_inline_extent_backref
Date:   Wed, 20 Apr 2022 14:54:00 +0300
Message-Id: <20220420115401.186147-1-nborisov@suse.com>
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
debug such cases would be to return EUCLEAN and also print the in-memory
state of the offending leaf.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 963160a0c393..5a53bcfdca83 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -895,7 +895,10 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	err = -ENOENT;
 	while (1) {
 		if (ptr >= end) {
-			WARN_ON(ptr > end);
+			if (WARN_ON(ptr > end)) {
+				err = -EUCLEAN;
+				btrfs_print_leaf(path->slots[0]);
+			}
 			break;
 		}
 		iref = (struct btrfs_extent_inline_ref *)ptr;
-- 
2.25.1

