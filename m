Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793887AF228
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjIZSD4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjIZSDw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:52 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E06199
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:45 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77411614b57so563399585a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751424; x=1696356224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iU+yqzE93SLheknXkqHCW6CWGb25h7xURuXQP4ILGfc=;
        b=FitFNo7z0c+sdDn5Hu4ZCk76uiOYriw0lfd9CliCHSIM65Xp83asNgKnVY/2FO5Str
         yspbLHvVQ6TBYneV/9R7hpwp6EjMMPgGWf29rGlGcCQAqe2hWLy1GfDMIcvhyFlD3oYa
         E66RDPPRW4Vcq15rjRvh3G3H2BxFP8LA2idbrj3/XnMqjHQhVgfGeuFYOWkaMFt6OBqV
         oqaGALyADmfd+2VfKKI/GwBZQ1kebKMQOkKyU3tetGC4l31SfoOO0Cdy5L1YqzPIHTj+
         peKI30zxKBr9yLYvOchIwCzkxBah2wA8D7Qj52AH2TjBYQgXSZ/bwSRTmV8q4qmMzm2R
         Ly8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751424; x=1696356224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU+yqzE93SLheknXkqHCW6CWGb25h7xURuXQP4ILGfc=;
        b=X/6BzTjgMC/JOWUhdM6N8FhpYzatcuJR1l196GhUtMpB2jD2EEihoOTPOzAq9iUDym
         x0MUpFnW+ZFO7OZPdVdJAanDkjS/qCi4H29fyFdy2v3Y22LNAphnlvcgOnwHZt9bgnM1
         gWD3VIHgCq8nZ27K4+0AJGy3rG0auhYkEIQnrpskaB9O6uGpGijljXV+RB9x3y784R3S
         F1fazkyZda6HXnF9UJJZ4PDkDyKHKMyPh1qu3iZHXSWUBhO9qmwwT5qZg+8gEu3BXeqf
         4vmx7ZuttUh4v+Scsm4yNU+2eGwpZ9+Tsle2OW1MHALjG1RljVO1N3mHdigRjHWc/hHB
         5VrA==
X-Gm-Message-State: AOJu0YwwK2mBhJ5S5G1/mq4l/oJOFlM6HTWLNrTYMAuAojD9LopX6RHN
        Dp0dFqoP7ONdUioQbf4ezK1bvpzFSQ3tylTaaow6RQ==
X-Google-Smtp-Source: AGHT+IGI5tYeGzJTzE1gjCvkgwROGvRINBt7eG7oMlPlbIY45mUT3z5P+P1AsXhjzCy9duz8r7Bq7g==
X-Received: by 2002:a05:620a:4488:b0:770:ff48:e23c with SMTP id x8-20020a05620a448800b00770ff48e23cmr13366758qkp.57.1695751423938;
        Tue, 26 Sep 2023 11:03:43 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c24-20020ae9e218000000b007682af2c8aasm4899509qkc.126.2023.09.26.11.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Subject: [PATCH 27/35] btrfs: pass through fscrypt_extent_info to the file extent helpers
Date:   Tue, 26 Sep 2023 14:01:53 -0400
Message-ID: <6e5e0cd828e4756620cddd30727ceb557e6e3532.1695750478.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695750478.git.josef@toxicpanda.com>
References: <cover.1695750478.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have the fscrypt_extnet_info in all of the supporting
structures, pass this through and set the file extent encryption bit
accordingly from the supporting structures.  In subsequent patches code
will be added to populate these appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c    | 18 +++++++++++-------
 fs/btrfs/tree-log.c |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6a835967684d..fdb7c9e1c210 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2883,7 +2883,9 @@ int btrfs_writepage_cow_fixup(struct page *page)
 }
 
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
-				       struct btrfs_inode *inode, u64 file_pos,
+				       struct btrfs_inode *inode,
+				       struct fscrypt_extent_info *fscrypt_info,
+				       u64 file_pos,
 				       struct btrfs_file_extent_item *stack_fi,
 				       const bool update_inode_bytes,
 				       u64 qgroup_reserved)
@@ -3015,8 +3017,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
-	btrfs_set_stack_file_extent_encryption(&stack_fi,
-					       BTRFS_ENCRYPTION_NONE);
+	btrfs_set_stack_file_extent_encryption(&stack_fi, oe->encryption_type);
 	/* Other encoding is reserved and always 0 */
 
 	/*
@@ -3030,8 +3031,9 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 			     test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags);
 
 	return insert_reserved_file_extent(trans, BTRFS_I(oe->inode),
-					   oe->file_offset, &stack_fi,
-					   update_inode_bytes, oe->qgroup_rsv);
+					   oe->fscrypt_info, oe->file_offset,
+					   &stack_fi, update_inode_bytes,
+					   oe->qgroup_rsv);
 }
 
 /*
@@ -9662,6 +9664,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 				       struct btrfs_trans_handle *trans_in,
 				       struct btrfs_inode *inode,
 				       struct btrfs_key *ins,
+				       struct fscrypt_extent_info *fscrypt_info,
 				       u64 file_offset)
 {
 	struct btrfs_file_extent_item stack_fi;
@@ -9683,6 +9686,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, len);
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
 	btrfs_set_stack_file_extent_encryption(&stack_fi,
+					       fscrypt_info ? BTRFS_ENCRYPTION_FSCRYPT :
 					       BTRFS_ENCRYPTION_NONE);
 	/* Other encoding is reserved and always 0 */
 
@@ -9691,7 +9695,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 		return ERR_PTR(qgroup_released);
 
 	if (trans) {
-		ret = insert_reserved_file_extent(trans, inode,
+		ret = insert_reserved_file_extent(trans, inode, fscrypt_info,
 						  file_offset, &stack_fi,
 						  true, qgroup_released);
 		if (ret)
@@ -9785,7 +9789,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 
 		last_alloc = ins.offset;
 		trans = insert_prealloc_file_extent(trans, BTRFS_I(inode),
-						    &ins, cur_offset);
+						    &ins, NULL, cur_offset);
 		/*
 		 * Now that we inserted the prealloc extent we can finally
 		 * decrement the number of reservations in the block group.
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d659547c9900..40dd5c652f0e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4631,7 +4631,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 block_len;
 	int ret;
 	size_t fscrypt_context_size = 0;
-	u8 encryption = BTRFS_ENCRYPTION_NONE;
+	u8 encryption = em->encryption_type;
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-- 
2.41.0

