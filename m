Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C91169A52D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 06:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBQFhl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 00:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBQFhk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 00:37:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1F05BDA8
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 21:37:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31FEC208B4;
        Fri, 17 Feb 2023 05:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676612246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r22TTCPbkXuhxgb1VGt4MQpVWEmpWeNGbSEfmDCUNAM=;
        b=ieFvwjN2QQT5dxlhGZNRGFSxIXIuNVPQSY9TcLri/dG4Og+FPFE2KyVP/tl2zS72MXqwIo
        WkP/szZ3soZiVVnAkbhmrSaUUOdJFmBtv4Lx/j0ZaHXg6rLy63h72v42i4aq8z7cj47CzD
        Q/ygRyMnGN8O8y3V3XjLzIeg0ZzOgSA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E25F51323E;
        Fri, 17 Feb 2023 05:37:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wHi1KpQS72PTSQAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 17 Feb 2023 05:37:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 3/6] btrfs: simplify the bioc argument for handle_ops_on_dev_replace()
Date:   Fri, 17 Feb 2023 13:37:00 +0800
Message-Id: <84d631e452d118087b4a3cdf9994695412c95462.1676611535.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676611535.git.wqu@suse.com>
References: <cover.1676611535.git.wqu@suse.com>
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

There is no memory re-allocation for handle_ops_on_dev_replace(), thus
we don't need to pass a btrfs_io_context pointer.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 45ac6e14d268..4408b1b0d4d1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6180,12 +6180,11 @@ static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
 }
 
 static void handle_ops_on_dev_replace(enum btrfs_map_op op,
-				      struct btrfs_io_context **bioc_ret,
+				      struct btrfs_io_context *bioc,
 				      struct btrfs_dev_replace *dev_replace,
 				      u64 logical,
 				      int *num_stripes_ret, int *max_errors_ret)
 {
-	struct btrfs_io_context *bioc = *bioc_ret;
 	u64 srcdev_devid = dev_replace->srcdev->devid;
 	int tgtdev_indexes = 0;
 	int num_stripes = *num_stripes_ret;
@@ -6274,7 +6273,6 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	*num_stripes_ret = num_stripes;
 	*max_errors_ret = max_errors;
 	bioc->num_tgtdevs = tgtdev_indexes;
-	*bioc_ret = bioc;
 }
 
 static bool need_full_stripe(enum btrfs_map_op op)
@@ -6577,7 +6575,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bioc, dev_replace, logical,
+		handle_ops_on_dev_replace(op, bioc, dev_replace, logical,
 					  &num_stripes, &max_errors);
 	}
 
-- 
2.39.1

