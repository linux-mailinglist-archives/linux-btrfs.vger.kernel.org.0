Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB11466547F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjAKGYK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjAKGX6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:23:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5A511146
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wPj7mJdR54dpqaQBkR5e+nW2Uv1fdwj4IDnkrjYYZBI=; b=uA5RTaZuG4BeRUxLjRCGGbhFzR
        hRMFkMhg8XPOlV3/0JyWl7nkI/GgJf25iakAuD6npaWEsLoKg8XetyC0bXoDFKtOke1fEMsQgD4Xp
        Q3rlPx928suNHSMIgNf/3ENgoYY8bnEkMFqUHVR/4KFe3a5LdwtcY/xA753F3tiq6ynnB4/BZj1pp
        b3zs6h0Emp/j+WvtiGZ4zpS9OGIvD6P7pNgtRwpjSFQlywNCt176IP05XhBAIW6Zv9nehAQApzz0Y
        lpBzNKhiwJSeI9+mFq83q0APUvohajNVCxrQajumw7lj1BrMXyRaDE89/EqfAIDMZ47AKNcT5uJKQ
        TPSbkTrA==;
Received: from [2001:4bb8:181:656b:8732:62ba:c286:a05b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFUWW-009rAm-Pw; Wed, 11 Jan 2023 06:23:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] btrfs: wait for I/O completion in submit_read_bios
Date:   Wed, 11 Jan 2023 07:23:27 +0100
Message-Id: <20230111062335.1023353-4-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111062335.1023353-1-hch@lst.de>
References: <20230111062335.1023353-1-hch@lst.de>
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

In addition to setting up the end_io handler and subitting the bios in
submit_read_bios, also wait for them to be completed instead of waiting
for the completion manually in all three callers.

Rename submit_read_bios to submit_read_wait_bio_list to make it clear
it waits for the bios as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0483f70a4fed74..e3fef81a4d96d3 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1490,7 +1490,7 @@ static void raid_wait_read_end_io(struct bio *bio)
 		wake_up(&rbio->io_wait);
 }
 
-static void submit_read_bios(struct btrfs_raid_bio *rbio,
+static void submit_read_wait_bio_list(struct btrfs_raid_bio *rbio,
 			     struct bio_list *bio_list)
 {
 	struct bio *bio;
@@ -1507,6 +1507,8 @@ static void submit_read_bios(struct btrfs_raid_bio *rbio,
 		}
 		submit_bio(bio);
 	}
+
+	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 }
 
 static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
@@ -2009,8 +2011,7 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
 	if (ret < 0)
 		goto out;
 
-	submit_read_bios(rbio, &bio_list);
-	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+	submit_read_wait_bio_list(rbio, &bio_list);
 
 	ret = recover_sectors(rbio);
 
@@ -2206,8 +2207,7 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 	if (ret < 0)
 		goto out;
 
-	submit_read_bios(rbio, &bio_list);
-	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+	submit_read_wait_bio_list(rbio, &bio_list);
 
 	/*
 	 * We may or may not have any corrupted sectors (including missing dev
@@ -2785,8 +2785,7 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 	if (ret < 0)
 		goto cleanup;
 
-	submit_read_bios(rbio, &bio_list);
-	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+	submit_read_wait_bio_list(rbio, &bio_list);
 
 	/* We may have some failures, recover the failed sectors first. */
 	ret = recover_scrub_rbio(rbio);
-- 
2.35.1

