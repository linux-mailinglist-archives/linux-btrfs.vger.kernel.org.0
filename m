Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B1370EFA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 09:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbjEXHmA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 03:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbjEXHl6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 03:41:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1758890
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 00:41:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C002222435
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684914115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IhdbGigzGey0rT99VFdIppWATdfpzYKqxl+k/tEYVXQ=;
        b=jyWvdH73zDzbgWeMDZmwt66U9wh07gC7S/CZaoPMlHoodtz0Gc1tYCDqE93w815zCkqG1A
        ma3AOWFJR4jFIQOdLQomxoY4sv3PY04oPoJMDqBws0puR+nk1YFfa93SjinID0W3Q7ouXN
        EkBuEiJKbj32P49xCIIewUvNuTjRbtI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2351D13425
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +OfJN8K/bWSiRQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs-progs: tune: reject csum change if the fs is already using the target csum type
Date:   Wed, 24 May 2023 15:41:30 +0800
Message-Id: <9fbd94b5285d0d71fd6c092bdd06167f3482b98b.1684913599.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684913599.git.wqu@suse.com>
References: <cover.1684913599.git.wqu@suse.com>
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

Currently "btrfstune --csum" allows us to change the csum to the same
one, this is good for testing but not good for end users, as if the end
user interrupts it, they have to resume the change (even it's to the
same csum type) until it finished, or kernel would reject such fs.

Furthermore, we never change the super block csum type until we
completely changed the csum type, thus for resume cases, the fs would
still show up as using the old csum type thus won't cause any problem
resuming.

So here we just reject the csum conversion if the target csum type is
the same as the existing csum type.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index dad39c3ec854..ef3d663e038e 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -29,7 +29,7 @@
 #include "common/utils.h"
 #include "tune/tune.h"
 
-static int check_csum_change_requreiment(struct btrfs_fs_info *fs_info)
+static int check_csum_change_requreiment(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 {
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *dev_root = fs_info->dev_root;
@@ -75,6 +75,12 @@ static int check_csum_change_requreiment(struct btrfs_fs_info *fs_info)
 		error("running dev-replace detected, please finish or cancel it.");
 		return -EINVAL;
 	}
+
+	if (fs_info->csum_type == new_csum_type) {
+		error("the fs is already using csum type %s (%u)",
+		      btrfs_super_csum_name(new_csum_type), new_csum_type);
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -1001,7 +1007,7 @@ int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 	int ret;
 
 	/* Phase 0, check conflicting features. */
-	ret = check_csum_change_requreiment(fs_info);
+	ret = check_csum_change_requreiment(fs_info, new_csum_type);
 	if (ret < 0)
 		return ret;
 
-- 
2.40.1

