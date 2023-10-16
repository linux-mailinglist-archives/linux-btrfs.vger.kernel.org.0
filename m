Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D877CB265
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjJPSWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjJPSWd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:33 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3366E102
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77575233633so349644785a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480547; x=1698085347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDlZH9qthcW82Qll/N8PtWNZ+HAtcElgL4HleKPl0K8=;
        b=UP/Pi1JMf3YKyl+3+p5VnoE2J6/K8+r9yDOh+KTIg5IuhofkQPaDsQARvAyTIjf3NA
         7ykGioW4MxRNIaaSnaOWjBlMtms6aKky46maTqEZapIHzdi68B5elkEewmOxWZYz4Rvr
         uTsxowIoR5kTSTDGy9P0I6SFBNQlAVgr9VAVvMLAmMOUV4lLRqqAqfSJb34XuEtm3OW+
         yoQxhs55z3ywVZDucdtYnQ3VhR7nBxjSSxE9MjEXV3mwvxD1RplmbVnPAfc+svZ1LlL/
         r+cScf9kOo6omIq+PYt0qhvljaTLjUNiZZ8nZBEAiCGYE/ZJCcKjCvVNEWj+FH/VofBf
         Mf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480547; x=1698085347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDlZH9qthcW82Qll/N8PtWNZ+HAtcElgL4HleKPl0K8=;
        b=bFSK9bFO5Sgy8wtZQ0FAoDq6HmI1HJdwZ/6nXo23ZF7eVT6NMoLbUQMDqXZetcm3rt
         ei1ABWp1a+TQytcyaAgf4yHPh1cMEvVeUisX+5OLIap7f4dI8OXQ53As4mXoJIblMtm9
         /yG3AWKgBF8XzWomH3YhFqSmX6G49a6PiSq+qF1GdFs+UirYTxsimXXB47jgSB6D1/pI
         FlxGiRo+3pEHJohXLjLUKZrriOKdh1Y6eFdH6JzjmlLZ/YjySisCD1TJJ4SpP6giEkC5
         CZa07cv+Oo6yXgdR/nmzkE+tu6Ujz7m6LTZFJsp76dXO3UHfYUHwnRAzYXuwR4DsPAso
         y+2A==
X-Gm-Message-State: AOJu0YzJ1UOwnDykAlwGDW/uRQmaIk2jILFoG0ST90JH9ziVJoXncrJk
        4LiixwzA56qg0pvgV5wFsBimpshfUmGcBmGtmQswOw==
X-Google-Smtp-Source: AGHT+IGFHjijYw7w5QZSj95z9UZtzpk58tH0A9JxG581TIiFsoxqxfbtk9uAW23Zf55AOxuY5pb/XA==
X-Received: by 2002:a05:620a:280d:b0:767:c572:ab10 with SMTP id f13-20020a05620a280d00b00767c572ab10mr38660235qkp.35.1697480547147;
        Mon, 16 Oct 2023 11:22:27 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e5-20020a05620a12c500b007756c8ce8f5sm3171525qkl.59.2023.10.16.11.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 26/34] btrfs: pass through fscrypt_extent_info to the file extent helpers
Date:   Mon, 16 Oct 2023 14:21:33 -0400
Message-ID: <8d0b2bbccc509e82a4593fb80beb969c824b9b1a.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
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
index 03bc9f41bd33..87b38be47d0b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2882,7 +2882,9 @@ int btrfs_writepage_cow_fixup(struct page *page)
 }
 
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
-				       struct btrfs_inode *inode, u64 file_pos,
+				       struct btrfs_inode *inode,
+				       struct fscrypt_extent_info *fscrypt_info,
+				       u64 file_pos,
 				       struct btrfs_file_extent_item *stack_fi,
 				       const bool update_inode_bytes,
 				       u64 qgroup_reserved)
@@ -3014,8 +3016,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
-	btrfs_set_stack_file_extent_encryption(&stack_fi,
-					       BTRFS_ENCRYPTION_NONE);
+	btrfs_set_stack_file_extent_encryption(&stack_fi, oe->encryption_type);
 	/* Other encoding is reserved and always 0 */
 
 	/*
@@ -3029,8 +3030,9 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
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
index 6cdb924944d1..85267cf1f372 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4629,7 +4629,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 block_len;
 	int ret;
 	size_t fscrypt_context_size = 0;
-	u8 encryption = BTRFS_ENCRYPTION_NONE;
+	u8 encryption = em->encryption_type;
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-- 
2.41.0

