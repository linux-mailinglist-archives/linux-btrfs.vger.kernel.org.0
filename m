Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B0B7CB26B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjJPSWz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjJPSWm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:42 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693AF12C
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:35 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d0f945893so40715396d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480554; x=1698085354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4BaCdes/ph+FBDRPrYEBu7SdLjcMrWxDC5DvBg0S2c=;
        b=FiDrOsHhsPiAAGfyvLIBX5jkk88ZfjL4sYoUj0aUNVltU89koBNoSu0dSJTXQyavIz
         NxnGTq6pX+xY7dKB8OQ3DLONNip4UH7dD6XAUACBYUM/0WWfzWXLTNV/svuMv2CpmFMg
         GMu2kRgiMiSo9b3MGrj40m6d0NAW6GPbYz/TjUH+2jorvueWXs2YcYLVK8AaWot25sP8
         ZSzFkU8oTNXyXqESdtpixyHfG2Yeab+vfR7oovSLrxC9IRUQs9nroouVLEVpUbSumQB/
         Lc+qnf7F8mSdTpW5TdMhrIHCmu+3meEJEDj5Jg/WiO0J9LAVRyaFT9wspsncK7HdqiuC
         6iVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480554; x=1698085354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4BaCdes/ph+FBDRPrYEBu7SdLjcMrWxDC5DvBg0S2c=;
        b=cceJEIfb0C0zjQ9VtAxTNeENQ713UI+PEW0U7iG/V/JgMfmX0SY3u0MjkLZMqF3m0+
         zPuRhtQNs8lOSfm+Jm/n0zCTTYmD3CoMXuCzN8rxDqUM1brfhaUUvD7Su/V+ACFZLzkf
         KpGsQxctiXtp1/eUBzBFXRf5oCQJV9hKn/ZFP0WMp5HOCLiZf11m6GcvQYhsH+JZaoVb
         x8Fg021rvYyLwI+bBTewMq8WydYrxlZ8fCTqhgw7oTosL87cViw2Tpp95y18EwW4cLvz
         AxKUqdHhMvVbcGa/Cc2oj7p2l0Rs8+31eK0SmttnSRbAUT9ZLp/fhCPn7hkR/h7jGWf7
         8UqA==
X-Gm-Message-State: AOJu0YxUVwNmwtGXKKMbuLSx0wFfjX6qoqkSltSoCC0TfPRPlVFZPOls
        Ui5TTsYxfscMehCC0D58KP3sjcMFmtESgKJF/P0cbA==
X-Google-Smtp-Source: AGHT+IFPDE2TVlypRn4CLLnuAoV6mAufreAgr6Kt6GfkV14F7eOmnLiPNxbjewGaBLtNaOsqdBBwJw==
X-Received: by 2002:a05:6214:27c7:b0:66d:2369:2c51 with SMTP id ge7-20020a05621427c700b0066d23692c51mr412087qvb.6.1697480554375;
        Mon, 16 Oct 2023 11:22:34 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l11-20020ad44bcb000000b0063d5d173a51sm3671732qvw.50.2023.10.16.11.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 32/34] btrfs: add a bio argument to btrfs_csum_one_bio
Date:   Mon, 16 Oct 2023 14:21:39 -0400
Message-ID: <67d76ef8a4b16f582c8c9b45243274462ca0ace1.1697480198.git.josef@toxicpanda.com>
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

We only ever needed the bbio in btrfs_csum_one_bio, since that has the
bio embedded in it.  However with encryption we'll have a different bio
with the encrypted data in it, and the original bbio.  Update
btrfs_csum_one_bio to take the bio we're going to csum as an argument,
which will allow us to csum the encrypted bio and stuff the csums into
the corresponding bbio to be used later when the IO completes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c       | 2 +-
 fs/btrfs/file-item.c | 3 +--
 fs/btrfs/file-item.h | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4f3b693a16b1..90e4d4709fa3 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -533,7 +533,7 @@ static blk_status_t btrfs_bio_csum(struct btrfs_bio *bbio)
 {
 	if (bbio->bio.bi_opf & REQ_META)
 		return btree_csum_one_bio(bbio);
-	return btrfs_csum_one_bio(bbio);
+	return btrfs_csum_one_bio(bbio, &bbio->bio);
 }
 
 /*
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 35036fab58c4..d925d6d98bf4 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -730,13 +730,12 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 /*
  * Calculate checksums of the data contained inside a bio.
  */
-blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
+blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio)
 {
 	struct btrfs_ordered_extent *ordered = bbio->ordered;
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	struct bio *bio = &bbio->bio;
 	struct btrfs_ordered_sum *sums;
 	char *data;
 	struct bvec_iter iter;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index bb79014024bd..e52d5d71d533 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -51,7 +51,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
-blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio);
+blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio);
 blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit,
-- 
2.41.0

