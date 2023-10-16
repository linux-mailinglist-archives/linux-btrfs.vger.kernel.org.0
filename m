Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3C7CB26A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjJPSW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjJPSWq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:46 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA761BD
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:37 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d332f23e4so19682956d6.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480556; x=1698085356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okky8/+/ArXJ9Aw/o0iuE9eunlMqnoPCfWBe+sEmUv8=;
        b=DaCVXyFeORvXFewq3cVdw6Acb2B6Dnc8zivLe6rCj/PadViTEwmNKBeWAACYy9Kuig
         yXYCCGW8hxUijfTevU/LhG+AnURpWzkj2P0CV12bsQHO37QI2+nML3CBzUTE5DVObCiC
         TRQ7VFT9yLckx67ZEkNqrfK5mucqqkvvV7cYHllkW1+4FFLEq9lQbqAY1a+iFUCP9OeQ
         Y+nklyO+0s5it3dlyNFM48tYp1HB6y9uQ6td2+GH8tAtiAqMMHacUXzscg1N9GssP6bh
         wlasK5BpIOCPBQIumuxqE6/6duJUe7c0aOyL9/zhm79X11Pz+7FheD1SxYmEFvd4tk97
         64mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480556; x=1698085356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okky8/+/ArXJ9Aw/o0iuE9eunlMqnoPCfWBe+sEmUv8=;
        b=ccPyN6Yq/nmLkBWuA1h5vbhBOQaqCtuWGfTVvkB7H4PtGYHyoi8Ve1QtAE7tkpiKFU
         D26gKytiNOhrdG92L9Ye5pIRcGZUp5k2cPY3vMfZ3O68LCCt8FAO9Jkv3l58TX7ChaLA
         MKDAdPsXpNe9OyD7dPd3TH6ZkNa9uKSDOKaSzhnoIISlJo8PO+vddcYtoZvGlprbv3kl
         PLX1OOJ2P97U9K9Gf5yANOtADJgYvfmxWCW4SyybN4sCPKlDpPU1PYfbQrBvbjaTQa63
         VTnVpW7IhseMrNxGNeJ/PueeuO7EVe2TksYNkm0QKmh7vVusYADtVD3R5lIaWQGnUcRR
         NEZw==
X-Gm-Message-State: AOJu0YzbLrOv0e/1oNNlIL+YIbCYjl79DPMuAULlz+NUlwP+b3yf8e44
        18NWdUI5TGmNKji5uvwwi/ItR3QgiuZqKtu0N1bx2w==
X-Google-Smtp-Source: AGHT+IHX/2mEu4ItsHIoQJ71s0gCDcbjHtnIcV5xzVNNTnhclfAv/n2T2YdTeTBC1zw6sWg/34azeA==
X-Received: by 2002:a05:6214:27cf:b0:66d:18ab:b482 with SMTP id ge15-20020a05621427cf00b0066d18abb482mr165029qvb.63.1697480556568;
        Mon, 16 Oct 2023 11:22:36 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id dy18-20020ad44e92000000b0065b17ec4b49sm3625812qvb.46.2023.10.16.11.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 34/34] btrfs: implement process_bio cb for fscrypt
Date:   Mon, 16 Oct 2023 14:21:41 -0400
Message-ID: <fa56001588f3363e65d942863d1810988f08dad4.1697480198.git.josef@toxicpanda.com>
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

We are going to be checksumming the encrypted data, so we have to
implement the ->process_bio fscrypt callback.  This will provide us with
the original bio and the encrypted bio to do work on.  For WRITE's this
will happen after the encrypted bio has been encrypted.  For READ's this
will happen after the read has completed and before the decryption step
is done.

For write's this is straightforward, we can just pass in the encrypted
bio to btrfs_csum_one_bio and then the csums will be added to the bbio
as normal.

For read's this is relatively straightforward, but requires some care.
We assume (because that's how it works currently) that the encrypted bio
match the original bio, this is important because we save the iter of
the bio before we submit.  If this changes in the future we'll need a
hook to give us the bi_iter of the decryption bio before it's submitted.
We check the csums before decryption.  If it doesn't match we simply
error out and we let the normal path handle the repair work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c     | 34 +++++++++++++++++++++++++++++++++-
 fs/btrfs/bio.h     |  3 +++
 fs/btrfs/fscrypt.c | 19 +++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 52f027877aaa..43c9b46cfe9a 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -281,6 +281,34 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	return fbio;
 }
 
+blk_status_t btrfs_check_encrypted_read_bio(struct btrfs_bio *bbio,
+					    struct bio *enc_bio)
+{
+	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u32 sectorsize = fs_info->sectorsize;
+	struct bvec_iter iter = bbio->saved_iter;
+	struct btrfs_device *dev = bbio->bio.bi_private;
+	u32 offset = 0;
+
+	/*
+	 * We have to use a copy of iter in case there's an error,
+	 * btrfs_check_read_bio will handle submitting the repair bios.
+	 */
+	while (iter.bi_size) {
+		struct bio_vec bv = bio_iter_iovec(enc_bio, iter);
+
+		bv.bv_len = min(bv.bv_len, sectorsize);
+		if (!btrfs_data_csum_ok(bbio, dev, offset, &bv))
+			return BLK_STS_IOERR;
+		bio_advance_iter_single(enc_bio, &iter, sectorsize);
+		offset += sectorsize;
+	}
+
+	bbio->csum_done = true;
+	return BLK_STS_OK;
+}
+
 static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *dev)
 {
 	struct btrfs_inode *inode = bbio->inode;
@@ -306,6 +334,10 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	/* Clear the I/O error. A failed repair will reset it. */
 	bbio->bio.bi_status = BLK_STS_OK;
 
+	/* This was an encrypted bio and we've already done the csum check. */
+	if (status == BLK_STS_OK && bbio->csum_done)
+		goto out;
+
 	while (iter->bi_size) {
 		struct bio_vec bv = bio_iter_iovec(&bbio->bio, *iter);
 
@@ -316,7 +348,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 		bio_advance_iter_single(&bbio->bio, iter, sectorsize);
 		offset += sectorsize;
 	}
-
+out:
 	if (bbio->csum != bbio->csum_inline)
 		kfree(bbio->csum);
 
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 5d3f53dcd6d5..393ef32f5321 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -45,6 +45,7 @@ struct btrfs_bio {
 		struct {
 			u8 *csum;
 			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+			bool csum_done;
 			struct bvec_iter saved_iter;
 		};
 
@@ -110,5 +111,7 @@ void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
 			    unsigned int pg_offset, int mirror_num);
+blk_status_t btrfs_check_encrypted_read_bio(struct btrfs_bio *bbio,
+					    struct bio *enc_bio);
 
 #endif
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 726cb6121934..b7e92ee5e60b 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -15,6 +15,7 @@
 #include "transaction.h"
 #include "volumes.h"
 #include "xattr.h"
+#include "file-item.h"
 
 /*
  * From a given location in a leaf, read a name into a qstr (usually a
@@ -214,6 +215,23 @@ static struct block_device **btrfs_fscrypt_get_devices(struct super_block *sb,
 	return devs;
 }
 
+static blk_status_t btrfs_process_encrypted_bio(struct bio *orig_bio,
+						struct bio *enc_bio)
+{
+	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
+
+	if (bio_op(orig_bio) == REQ_OP_READ) {
+		/*
+		 * We have ->saved_iter based on the orig_bio, so if the block
+		 * layer changes we need to notice this asap so we can update
+		 * our code to handle the new world order.
+		 */
+		ASSERT(orig_bio == enc_bio);
+		return btrfs_check_encrypted_read_bio(bbio, enc_bio);
+	}
+	return btrfs_csum_one_bio(bbio, enc_bio);
+}
+
 int btrfs_fscrypt_load_extent_info(struct btrfs_inode *inode,
 				   struct extent_map *em,
 				   struct btrfs_fscrypt_ctx *ctx)
@@ -304,4 +322,5 @@ const struct fscrypt_operations btrfs_fscrypt_ops = {
 	.set_context = btrfs_fscrypt_set_context,
 	.empty_dir = btrfs_fscrypt_empty_dir,
 	.get_devices = btrfs_fscrypt_get_devices,
+	.process_bio = btrfs_process_encrypted_bio,
 };
-- 
2.41.0

