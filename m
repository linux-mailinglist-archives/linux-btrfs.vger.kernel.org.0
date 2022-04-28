Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD795134AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 15:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiD1NSI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiD1NSH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 09:18:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBF317E01
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 06:14:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8B83210EB;
        Thu, 28 Apr 2022 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651151690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RDpYYM83rWQgvucIVsjjgaLZO927q3vmfuDdWhXH5hg=;
        b=oyFiY0xvy3N32e5rNSVnCr+5UGb3MDgPSUK2yInDOxOcLnyiDWRRh5Md/QRCO5I0AKJ43J
        M94p1gOo1o9Xyb5IT5NvNdXV0hT9FLhk42Hox9ejhDzvWayNjZAlfbqYaxnB6+oSR2d7qm
        5LzJuahJgfVeSO0fCXTI2JdeHImZWtU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85C2513491;
        Thu, 28 Apr 2022 13:14:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q9TWHUqTamKTQgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 28 Apr 2022 13:14:50 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4] btrfs: improve error reporting in lookup_inline_extent_backref
Date:   Thu, 28 Apr 2022 16:14:49 +0300
Message-Id: <20220428131449.792353-1-nborisov@suse.com>
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
index 963160a0c393..cae2ef560f3f 100644
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
+"overrun extent record at slot %d [%llu BTRFS_EXTENT_ITEM_KEY %llu] while looking for inline extent for root %llu owner %llu offset %llu parent %llu",
+				path->slots[0], bytenr, num_bytes,
+				root_objectid, owner, offset, parent);
+			}
 			break;
 		}
 		iref = (struct btrfs_extent_inline_ref *)ptr;
--
2.25.1

