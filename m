Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E86A75E9F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 05:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjGXDEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jul 2023 23:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGXDEr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jul 2023 23:04:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAA518C;
        Sun, 23 Jul 2023 20:04:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3A4D2038A;
        Mon, 24 Jul 2023 03:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690167881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WJlOpu0zE4Gkx2JpzrwDb8l5puDG5U7KnAzYg/9Q5t0=;
        b=mo2OFfDm/uZ0vqB2kyRrZQHXP0mAAjyxZU7oRN7znjnv31PTkfTU05s9kG2rkpXoi/QqgD
        SkemQnfPQTAtr3rMtoOp6p1JHCx9mNTIPbQp6UmLfy9+8h0wFV8EJzfn9KCOEIBlJeMuTo
        N7FfLfbPd3YmdLyK2fw4kPrKdbDeAuE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8886139D3;
        Mon, 24 Jul 2023 03:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DLRDJEjqvWQNcQAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 24 Jul 2023 03:04:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs/294: reject zoned devices for now
Date:   Mon, 24 Jul 2023 11:04:23 +0800
Message-ID: <20230724030423.92390-1-wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The test case itself is utilizing RAID5/6, which is not yet supported on
zoned device.

In the future we would use raid-stripe-tree (RST) feature, but for now
just reject zoned devices completely.

And since we're here, also update the _fixed_by_kernel_commit lines, as
the proper fix is already merged upstream.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/294 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/294 b/tests/btrfs/294
index 61ce7d97..d7d13646 100755
--- a/tests/btrfs/294
+++ b/tests/btrfs/294
@@ -16,11 +16,15 @@ _begin_fstest auto raid volume
 
 # Modify as appropriate.
 _supported_fs btrfs
+
+# No zoned support for RAID56 yet.
+_require_non_zoned_device "${SCRATCH_DEV}"
+
 _require_scratch_dev_pool 8
 _fixed_by_kernel_commit a7299a18a179 \
 	"btrfs: fix u32 overflows when left shifting @stripe_nr"
-_fixed_by_kernel_commit xxxxxxxxxxxx \
-	"btrfs: use a dedicated helper to convert stripe_nr to offset"
+_fixed_by_kernel_commit cb091225a538 \
+	"btrfs: fix remaining u32 overflows when left shifting stripe_nr"
 
 _scratch_dev_pool_get 8
 
-- 
2.41.0

