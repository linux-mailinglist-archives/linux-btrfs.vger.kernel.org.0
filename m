Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35CA60DA74
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 07:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiJZFGv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 01:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiJZFGo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 01:06:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB4368CFC
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 22:06:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C1791FD14
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666760802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Hk0MLyid46+Lr5p4xye7rgk+YLefr9ELc1sVn2KU9s=;
        b=HumuvHFWNPX6Kfj9xTvX97jurQbN/B5ee3IjQ5bxKZKM1I+HOrXCFVyAGtQg8JH4iyfhfG
        qjmork2zUALOuoXB94MEBNLae371g2TZPG67KSnXBPP9S5N8f8rZ+TBx8FfzDGAEZ9yzgZ
        NB4znQJQGmnhxHkICyUnSPNpjSumb1Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0102D13A6E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wCuPL2HAWGP7XQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: raid56: implement raid56_parity_write_v2()
Date:   Wed, 26 Oct 2022 13:06:31 +0800
Message-Id: <a22cbdab32dde8f243a1730f6f01f2077fe638f8.1666760699.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1666760699.git.wqu@suse.com>
References: <cover.1666760699.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the main entrance for raid56 writes.

The difference between this and the old one is:

- Unified queuing
  Now no matter if we're doing full stripe write, or sub-stripe write,
  we always queue the work into rmw_workers, and in that context we
  grab the full stripe lock, and call run_one_write_rbio().

- Simplified plug
  Since there is no work run at the same context of the caller, we have
  no need to delay the unplug work.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid56.h |  1 +
 2 files changed, 95 insertions(+)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4f648720b97a..96be2764433e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -3242,3 +3242,97 @@ void run_one_write_rbio(struct btrfs_raid_bio *rbio)
 	 */
 	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 }
+
+static void run_one_write_rbio_work(struct work_struct *work)
+{
+	struct btrfs_raid_bio *rbio =
+		container_of(work, struct btrfs_raid_bio, work);
+	int ret;
+
+	ret = lock_stripe_add(rbio);
+	if (ret == 0)
+		run_one_write_rbio(rbio);
+}
+
+static void queue_write_rbio(struct btrfs_raid_bio *rbio)
+{
+	INIT_WORK(&rbio->work, run_one_write_rbio_work);
+	queue_work(rbio->bioc->fs_info->rmw_workers, &rbio->work);
+}
+
+static void raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
+{
+	struct btrfs_plug_cb *plug = container_of(cb, struct btrfs_plug_cb, cb);
+	struct btrfs_raid_bio *cur;
+	struct btrfs_raid_bio *last = NULL;
+
+	list_sort(NULL, &plug->rbio_list, plug_cmp);
+
+	while (!list_empty(&plug->rbio_list)) {
+		cur = list_entry(plug->rbio_list.next,
+				 struct btrfs_raid_bio, plug_list);
+		list_del_init(&cur->plug_list);
+
+		if (rbio_is_full(cur)) {
+			/* We have a full stripe, queue it down. */
+			queue_write_rbio(cur);
+			continue;
+		}
+		if (last) {
+			if (rbio_can_merge(last, cur)) {
+				merge_rbio(last, cur);
+				free_raid_bio(cur);
+				continue;
+			}
+			queue_write_rbio(cur);
+		}
+		last = cur;
+	}
+	if (last)
+		queue_write_rbio(cur);
+	kfree(plug);
+}
+
+void raid56_parity_write_v2(struct bio *bio, struct btrfs_io_context *bioc)
+{
+	struct btrfs_fs_info *fs_info = bioc->fs_info;
+	struct btrfs_raid_bio *rbio;
+	struct btrfs_plug_cb *plug = NULL;
+	struct blk_plug_cb *cb;
+	int ret = 0;
+
+	rbio = alloc_rbio(fs_info, bioc);
+	if (IS_ERR(rbio)) {
+		ret = PTR_ERR(rbio);
+		goto fail;
+	}
+	rbio->operation = BTRFS_RBIO_WRITE;
+	rbio_add_bio(rbio, bio);
+
+	/* No need to plug on full rbios, just queue this rbio immediately. */
+	if (rbio_is_full(rbio))
+		goto queue_rbio;
+
+	/* Plug to try merge with other writes into the same full stripe. */
+	cb = blk_check_plugged(raid_unplug, fs_info, sizeof(*plug));
+	if (cb) {
+		plug = container_of(cb, struct btrfs_plug_cb, cb);
+		if (!plug->info) {
+			plug->info = fs_info;
+			INIT_LIST_HEAD(&plug->rbio_list);
+		}
+		list_add_tail(&rbio->plug_list, &plug->rbio_list);
+		return;
+	}
+queue_rbio:
+	/*
+	 * Either we don't have any existing plug, or we're doing a full stripe,
+	 * Just queue the rbio.
+	 */
+	queue_write_rbio(rbio);
+
+	return;
+fail:
+	bio->bi_status = errno_to_blk_status(ret);
+	bio_endio(bio);
+}
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 8657cafd32c0..9ae9e89190e4 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -168,6 +168,7 @@ struct btrfs_device;
 void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 			   int mirror_num);
 void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
+void raid56_parity_write_v2(struct bio *bio, struct btrfs_io_context *bioc);
 
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 			    unsigned int pgoff, u64 logical);
-- 
2.38.1

