Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDB961485C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiKALQe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiKALQ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1421900F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1A651F92D
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2AiU0LUcpoOSfOJRVq4JJBH2CPfoHPhFaF3wqpw/c7o=;
        b=C36Z/wSi5K8RToRhifGwwKs8qNLKuA9KUzGZRxrwzLcbjmQUObWgbyIOjQ4L8+8UpMYGsr
        CEmt8ZL4RGjrRpjJvcX7Zo3giZuXNy4FpO1+H10KI+IX6K2UtQxFc0W7wkgGay3P6uDD8N
        N2Kf+vjHJig+emg4GR4M8BWaJlGWaUY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 597E11346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oJ1NCwkAYWMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 12/12] btrfs: remove the unused btrfs_fs_info::endio_raid56_workers and btrfs_raid_bio::end_io_work
Date:   Tue,  1 Nov 2022 19:16:12 +0800
Message-Id: <7b029dd3a9209ba740a30114068489d1697dab43.1667300355.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667300355.git.wqu@suse.com>
References: <cover.1667300355.git.wqu@suse.com>
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

Since we have switch all raid56 workload to submit-and-wait method,
there is no use for btrfs_fs_info::endio_raid56_workers workqueue and
btrfs_raid_bio::end_io_work.

Remove them to save some memory.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 6 +-----
 fs/btrfs/fs.h      | 1 -
 fs/btrfs/raid56.h  | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7fefd5baa86b..05385ecd8314 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2092,8 +2092,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_workqueue(fs_info->workers);
 	if (fs_info->endio_workers)
 		destroy_workqueue(fs_info->endio_workers);
-	if (fs_info->endio_raid56_workers)
-		destroy_workqueue(fs_info->endio_raid56_workers);
 	if (fs_info->rmw_workers)
 		destroy_workqueue(fs_info->rmw_workers);
 	if (fs_info->compressed_write_workers)
@@ -2299,8 +2297,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 		alloc_workqueue("btrfs-endio", flags, max_active);
 	fs_info->endio_meta_workers =
 		alloc_workqueue("btrfs-endio-meta", flags, max_active);
-	fs_info->endio_raid56_workers =
-		alloc_workqueue("btrfs-endio-raid56", flags, max_active);
 	fs_info->rmw_workers = alloc_workqueue("btrfs-rmw", flags, max_active);
 	fs_info->endio_write_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-write", flags,
@@ -2322,7 +2318,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
 	      fs_info->compressed_write_workers &&
-	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &&
+	      fs_info->endio_write_workers &&
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
 	      fs_info->caching_workers && fs_info->fixup_workers &&
 	      fs_info->delayed_workers && fs_info->qgroup_rescan_workers &&
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index becb164d8a5d..c771b284eea7 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -524,7 +524,6 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *flush_workers;
 	struct workqueue_struct *endio_workers;
 	struct workqueue_struct *endio_meta_workers;
-	struct workqueue_struct *endio_raid56_workers;
 	struct workqueue_struct *rmw_workers;
 	struct workqueue_struct *compressed_write_workers;
 	struct btrfs_workqueue *endio_write_workers;
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 445e833fcfcf..9fae97b7a2a5 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -97,8 +97,6 @@ struct btrfs_raid_bio {
 
 	wait_queue_head_t io_wait;
 
-	struct work_struct end_io_work;
-
 	/* Bitmap to record which horizontal stripe has data */
 	unsigned long dbitmap;
 
-- 
2.38.1

