Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854E767DD2C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 06:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjA0Flp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 00:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjA0Flm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 00:41:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340EE73768
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 21:41:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2C5E21C4F
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674798097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBGUgPq/VXnm7K9YDvLRdAUvJHyDk96V34+sbzGSpw4=;
        b=XoPlu/izNTQqANr3fGS0q1dIOhAc+Tqdi07WUwkF79X3FSo9XfAiLIkLzloKBHSYhVVwHH
        YBrxud8sKwD9suFJF5TpVdjSorqUwNu+wrwWgcMXtuvAWlzrTE2ZA22Tg+xDyCaMB94zfp
        PxtnSffLViDcm/QEcQPZRUyu7bGlDa8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24391134F5
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2M7VNxBk02OnLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs-progs: remove an unnecessary branch to silent the clang warning
Date:   Fri, 27 Jan 2023 13:41:14 +0800
Message-Id: <0268c78594151742044d27b6e1dce877c63ef5fb.1674797823.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674797823.git.wqu@suse.com>
References: <cover.1674797823.git.wqu@suse.com>
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

[FALSE ALERT]
With clang 15.0.7, there is a false alert on uninitialized value in
ctree.c:

  kernel-shared/ctree.c:3418:13: warning: variable 'offset' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
          } else if (ret < 0) {
                     ^~~~~~~
  kernel-shared/ctree.c:3428:41: note: uninitialized use occurs here
          write_extent_buffer(eb, &subvol_id_le, offset, sizeof(subvol_id_le));
                                                 ^~~~~~
  kernel-shared/ctree.c:3418:9: note: remove the 'if' if its condition is always true
          } else if (ret < 0) {
                 ^~~~~~~~~~~~~
  kernel-shared/ctree.c:3380:22: note: initialize the variable 'offset' to silence this warning
          unsigned long offset;
                              ^
                               = 0
  kernel-shared/ctree.c:3418:13: warning: variable 'eb' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
          } else if (ret < 0) {
                     ^~~~~~~
  kernel-shared/ctree.c:3429:26: note: uninitialized use occurs here
          btrfs_mark_buffer_dirty(eb);
                                  ^~
  kernel-shared/ctree.c:3418:9: note: remove the 'if' if its condition is always true
          } else if (ret < 0) {
                 ^~~~~~~~~~~~~
  kernel-shared/ctree.c:3378:26: note: initialize the variable 'eb' to silence this warning
          struct extent_buffer *eb;
                                  ^
                                   = NULL

[CAUSE]
The original code is handling the return value from
btrfs_insert_empty_item() like this:

	ret = btrfs_insert_empty_item();
	if (ret >= 0) {
		/* Do something for it. */
	} else if (ret == -EEXIST) {
		/* Do something else. */
	} else if (ret < 0) {
		/* Error handling. */
	}

But the problem is, the last one check is always true if we can reach
there.

Thus clang is providing the hint to remove the if () chekc.

[FIX]
Normally we prefer to do error handling first, so move the error
handling first so we don't need the if () else if () chain.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 9f8bc9a5904c..759ee47aaadd 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -3400,14 +3400,22 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 
 	ret = btrfs_insert_empty_item(trans, uuid_root, path, &key,
 				      sizeof(subvol_id_le));
+	if (ret < 0 && ret != -EEXIST) {
+		warning(
+		"inserting uuid item failed (0x%016llx, 0x%016llx) type %u: %d",
+			(unsigned long long)key.objectid,
+			(unsigned long long)key.offset, type, ret);
+		goto out;
+	}
+
 	if (ret >= 0) {
 		/* Add an item for the type for the first time */
 		eb = path->nodes[0];
 		slot = path->slots[0];
 		offset = btrfs_item_ptr_offset(eb, slot);
-	} else if (ret == -EEXIST) {
+	} else {
 		/*
-		 * An item with that type already exists.
+		 * ret == -EEXIST case, An item with that type already exists.
 		 * Extend the item and store the new subvol_id at the end.
 		 */
 		btrfs_extend_item(uuid_root, path, sizeof(subvol_id_le));
@@ -3415,12 +3423,6 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 		slot = path->slots[0];
 		offset = btrfs_item_ptr_offset(eb, slot);
 		offset += btrfs_item_size(eb, slot) - sizeof(subvol_id_le);
-	} else if (ret < 0) {
-		warning(
-		"inserting uuid item failed (0x%016llx, 0x%016llx) type %u: %d",
-			(unsigned long long)key.objectid,
-			(unsigned long long)key.offset, type, ret);
-		goto out;
 	}
 
 	ret = 0;
-- 
2.39.1

