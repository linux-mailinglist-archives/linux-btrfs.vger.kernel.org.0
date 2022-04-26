Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8825B50FF74
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbiDZNur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiDZNuq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 09:50:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1BA1CB05
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 06:47:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1E39210E7;
        Tue, 26 Apr 2022 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650980856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Y+ukuQh+tAGnkmX0joJrKY/UzfmYDn7AgUeOrIvyEi0=;
        b=LuGrwGP6SSitbWkZMwKFEDNqALn0Wf/cSStAtO8hBtE0muGvqogA8xVqka+C53b5OsKGKK
        hf0pcK7ra75Ogm6HXFqof6nx1iAtmHFV2NyG1dqlEADWvca2AErddPZnjBsQJ02f80hVT9
        sgIin0tdL06pg8QO8aaYu2S4L9msyys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650980856;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Y+ukuQh+tAGnkmX0joJrKY/UzfmYDn7AgUeOrIvyEi0=;
        b=EGxk+hPDGw5O5OtKxcUQopoE2ZfL8ERPTFDh/Khm3BkN04U2UpMfI50ovd49eAUIenT0vY
        MwtQ+6aTgoPnsjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EE4313223;
        Tue, 26 Apr 2022 13:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HK/sDvj3Z2J1OAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 26 Apr 2022 13:47:36 +0000
Date:   Tue, 26 Apr 2022 08:47:34 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Dave Sterba <DSterba@suse.com>
Subject: [PATCH] btrfs: Derive compression type from extent map during reads
Message-ID: <20220426134734.dxxdrf2hutbmimtc@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Derive the compression type from extent map as opposed to the bio flags
passed. This makes it more precise and not reliant on function
parameters.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 19bf36d8ffea..f14255cb4ed7 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -803,7 +803,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
  * bio we were passed and then call the bio end_io calls
  */
 blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
-				 int mirror_num, unsigned long bio_flags)
+				 int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map_tree *em_tree;
@@ -855,14 +855,14 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	em_len = em->len;
 	em_start = em->start;
 
-	free_extent_map(em);
-	em = NULL;
-
 	cb->len = bio->bi_iter.bi_size;
 	cb->compressed_len = compressed_len;
-	cb->compress_type = extent_compress_type(bio_flags);
+	cb->compress_type = em->compress_type;
 	cb->orig_bio = bio;
 
+	free_extent_map(em);
+	em = NULL;
+
 	nr_pages = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
 	cb->compressed_pages = kcalloc(nr_pages, sizeof(struct page *),
 				       GFP_NOFS);
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index ac5b20731d2a..26d80df0b42e 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -103,7 +103,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  struct cgroup_subsys_state *blkcg_css,
 				  bool writeback);
 blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
-				 int mirror_num, unsigned long bio_flags);
+				 int mirror_num);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5082b9c70f8c..4dfc02fbbad5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2547,8 +2547,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			 * here.
 			 */
 			ret = btrfs_submit_compressed_read(inode, bio,
-							   mirror_num,
-							   bio_flags);
+							   mirror_num);
 			goto out_no_endio;
 		} else {
 			/*

-- 
Goldwyn
