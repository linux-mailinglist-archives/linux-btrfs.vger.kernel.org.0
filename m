Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B887CB258
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjJPSW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjJPSWo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:44 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9981AD
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41b406523fcso33827111cf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480555; x=1698085355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBfJ5LP4cPRaU4wHupG+Ey+k+InOBSbHn6NRjNRvG6k=;
        b=0LefpNQYHnjFEg8uVm7B5D3GK/r4mZgJb/4fmbJkVpkBA2BkdNgn8PR8+KlCjbsRwH
         2kmwfebuv1zTkqr2zyljowV9bNWaoDFjdFcZPWy78C4EGP5WM4umnhNtaxwOLM3gNfhc
         /cx0VPP0IBDODKGjwBF0OTAGidVQbaxZZx6ZphD+kA/aINRT72YYov+xgvk/VuLCVwAu
         yWjLrdx7xTaHae+efHY2hRdyKevjlCkzfQXH4edAgV8MG1n3lbVRS1m09sNgIWAqTYuL
         99UjyK57lNtpegx90jfICHAvqWuuxjn7tlRySnSvWKmDXWK3LNn6+heO3rAxNHRsp0Cl
         8JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480555; x=1698085355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBfJ5LP4cPRaU4wHupG+Ey+k+InOBSbHn6NRjNRvG6k=;
        b=DFvKz5USFDVGzHwVMyBGzzNZI4CS6wPyCN1N+8jpPLqCrMzPEpX5D3qHF5naXBqsFX
         rqy/szwIySFivwMDi+2ZAZ7MM//MjQVifMtYrhqbpgRn1je+/jES/+3Bv+O15bZWA0Ig
         dexJbZtdp1Xb1Mx5kO35dlwsZPuFOqdWXnr/VoQ1X6kr1RovCI0wRP1pNwTYJQNFyqtq
         MCYd6eEkvYSDMcFKUrcmql6gqZpX3MJBbZEv7RM2hfwtvTFWaFjLWnbx3qL+jNssQliO
         ol25wncvk33iGaXv3CnebZomUDyTW5JxtvbL3EpFwCD1zUzWxqZ8+0F5LrCCJzECSQjB
         8lPQ==
X-Gm-Message-State: AOJu0Yx3o/MK6p/QJWYuaBJsWPPjWWbz0FkNpCTW3+4uoNHpo4AwKbA/
        a9Q8l/npLjQsBrGpdBwuCe5HpmQds9QNij6stvxnLg==
X-Google-Smtp-Source: AGHT+IFOO1MyKgIAEN6jxivxkO80e9soIAi0slxn5i+x/oMOrhuT83/Eb4evxgSrVF0Y9YjGYnc33w==
X-Received: by 2002:ac8:5748:0:b0:418:1d4f:995c with SMTP id 8-20020ac85748000000b004181d4f995cmr114951qtx.55.1697480555440;
        Mon, 16 Oct 2023 11:22:35 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cp10-20020a05622a420a00b0041950c7f6d8sm3184709qtb.60.2023.10.16.11.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 33/34] btrfs: add orig_logical to btrfs_bio
Date:   Mon, 16 Oct 2023 14:21:40 -0400
Message-ID: <2de116aebcf27a38c59a7ed4da1e779853958cf9.1697480198.git.josef@toxicpanda.com>
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

When checksumming the encrypted bio on writes we need to know which
logical address this checksum is for.  At the point where we get the
encrypted bio the bi_sector is the physical location on the target disk,
so we need to save the original logical offset in the btrfs_bio.  Then
we can use this when csum'ing the bio instead of the
bio->iter.bi_sector.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c       | 10 ++++++++++
 fs/btrfs/bio.h       |  3 +++
 fs/btrfs/file-item.c |  2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 90e4d4709fa3..52f027877aaa 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -96,6 +96,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 	if (bbio_has_ordered_extent(bbio)) {
 		refcount_inc(&orig_bbio->ordered->refs);
 		bbio->ordered = orig_bbio->ordered;
+		bbio->orig_logical = orig_bbio->orig_logical;
+		orig_bbio->orig_logical += map_length;
 	}
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
@@ -674,6 +676,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		goto fail;
 	}
 
+	/*
+	 * For fscrypt writes we will get the encrypted bio after we've remapped
+	 * our bio to the physical disk location, so we need to save the
+	 * original bytenr so we know what we're checksumming.
+	 */
+	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
+		bbio->orig_logical = logical;
+
 	map_length = min(map_length, length);
 	if (use_append)
 		map_length = min(map_length, fs_info->max_zone_append_size);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index ca79decee060..5d3f53dcd6d5 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -54,11 +54,14 @@ struct btrfs_bio {
 		 * - pointer to the checksums for this bio
 		 * - original physical address from the allocator
 		 *   (for zone append only)
+		 * - original logical address, used for checksumming fscrypt
+		 *   bios.
 		 */
 		struct {
 			struct btrfs_ordered_extent *ordered;
 			struct btrfs_ordered_sum *sums;
 			u64 orig_physical;
+			u64 orig_logical;
 		};
 
 		/* For metadata reads: parentness verification. */
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d925d6d98bf4..26e3bc602655 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -756,7 +756,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio)
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 
-	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	sums->logical = bbio->orig_logical;
 	index = 0;
 
 	shash->tfm = fs_info->csum_shash;
-- 
2.41.0

