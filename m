Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BBC7A575C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 04:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjISCVz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 22:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjISCVv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 22:21:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B259112
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 19:21:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C432F22589
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 02:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695090103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzHuAqZgki4VDhLHi9HsWXI/JE3GKpKQXyFQi8wG0eo=;
        b=Rz1jpiEupU7LGClk+hMM2ownT/6GRxsJBN41rS4bLTxPxznCuOKVHZr/AmPEzP5vC3zgC4
        nXofcXU5agnF8d3KEd1YqSeCc6M6mGJXz3CDLL93gevzIK7zHXxtmGDnmzQKdWWDgo5vnP
        O0/GCwPS3NNWfK0gzz+3aCwqD2HMOIQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0377C1333E
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 02:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qHs7LbYFCWXBbQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 02:21:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: reject a superblock with over 65536 devices
Date:   Tue, 19 Sep 2023 11:51:22 +0930
Message-ID: <fb42141d2569bf25642b8e953810e590cff97e87.1695089790.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695089790.git.wqu@suse.com>
References: <cover.1695089790.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs superblock uses u64 for num_devices (including both read-write
and read-only devices).

The real-world value should be way smaller, dozens of devices would
already be a little too many, not to mention anything beyond U16_MAX
(65535).

So here we just reject any superblock with a num_devices beyond U16_MAX.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 163f37ad1b27..beb35a0187f4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2431,7 +2431,8 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 			  btrfs_super_stripesize(sb));
 		ret = -EINVAL;
 	}
-	if (btrfs_super_num_devices(sb) > (1UL << 31))
+	/* 65536 devices already doesn't sound sane. */
+	if (btrfs_super_num_devices(sb) > U16_MAX)
 		btrfs_warn(fs_info, "suspicious number of devices: %llu",
 			   btrfs_super_num_devices(sb));
 	if (btrfs_super_num_devices(sb) == 0) {
-- 
2.42.0

