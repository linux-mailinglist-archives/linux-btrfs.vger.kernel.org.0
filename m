Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0F364B153
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiLMIlu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiLMIls (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:41:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C94192A0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tcQr/hL7wu2/pp57R1cMki2m0KD1maEGtT8y2Pbqoo4=; b=hC7U6Hj/NVvWRucEvmAjlPAZjo
        duGgIU4KCWV+3BMcI94NbL+dQkzXU6st384bVqkkwoNCImeu2xGr2yRRSkW1MeCVvqwcKxHwFhN0p
        mXpJrDbQcIyN9YuoB2U0HjDaWlPkLCpgkvdDueyXXhZdua5eoCTMusLDweOiZWq4OrD61U363Xo+Z
        vtLubNY19HFnN2hzETXF63DlrNbSoC0wpUkRK4PZyzAkAUzjwaKrrLJqHXT2O0nGb+8nEOf9Gy8ke
        oDFNLluzRGF2upKDvtPYwn+M9WMMMFhvGGRQvKpheudv+LZntUPt/ffh6dPQzQquhyW02WALYZX4G
        rZwOg7Pw==;
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p50rB-00E0yL-EU; Tue, 13 Dec 2022 08:41:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: call rbio_orig_end_io from recover_rbio
Date:   Tue, 13 Dec 2022 09:41:22 +0100
Message-Id: <20221213084123.309790-8-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221213084123.309790-1-hch@lst.de>
References: <20221213084123.309790-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Both callers of recover_rbio call rbio_orig_end_io right after it, so
move the call into the shared function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 2432c2d7fcbed0..b2e02f02294163 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1985,7 +1985,7 @@ static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
 	return -EIO;
 }
 
-static int recover_rbio(struct btrfs_raid_bio *rbio)
+static void recover_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list = BIO_EMPTY_LIST;
 	struct bio *bio;
@@ -2000,13 +2000,13 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
 	/* For recovery, we need to read all sectors including P/Q. */
 	ret = alloc_rbio_pages(rbio);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	index_rbio_pages(rbio);
 
 	ret = recover_assemble_read_bios(rbio, &bio_list);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	submit_read_bios(rbio, &bio_list);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
@@ -2014,32 +2014,22 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
 	ret = recover_sectors(rbio);
 	while ((bio = bio_list_pop(&bio_list)))
 		bio_put(bio);
-	return ret;
+out:
+	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 }
 
 static void recover_rbio_work(struct work_struct *work)
 {
 	struct btrfs_raid_bio *rbio;
-	int ret;
 
 	rbio = container_of(work, struct btrfs_raid_bio, work);
-
-	ret = lock_stripe_add(rbio);
-	if (ret == 0) {
-		ret = recover_rbio(rbio);
-		rbio_orig_end_io(rbio, errno_to_blk_status(ret));
-	}
+	if (!lock_stripe_add(rbio))
+		recover_rbio(rbio);
 }
 
 static void recover_rbio_work_locked(struct work_struct *work)
 {
-	struct btrfs_raid_bio *rbio;
-	int ret;
-
-	rbio = container_of(work, struct btrfs_raid_bio, work);
-
-	ret = recover_rbio(rbio);
-	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
+	recover_rbio(container_of(work, struct btrfs_raid_bio, work));
 }
 
 static void set_rbio_raid6_extra_error(struct btrfs_raid_bio *rbio, int mirror_num)
-- 
2.35.1

