Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F5315C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 22:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfEaUAh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 16:00:37 -0400
Received: from forward104j.mail.yandex.net ([5.45.198.247]:55548 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727282AbfEaUAg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 16:00:36 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 May 2019 16:00:35 EDT
Received: from mxback16j.mail.yandex.net (mxback16j.mail.yandex.net [IPv6:2a02:6b8:0:1619::92])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 005A34A0413;
        Fri, 31 May 2019 22:53:53 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback16j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id d5NH6O2W6Q-rq10wlFj;
        Fri, 31 May 2019 22:53:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1559332432;
        bh=5LPGI2g/Pppy4VTLsIsroNZrvadc1PssQ7CE756xPVY=;
        h=Subject:To:From:Message-Id:Cc:Date;
        b=C1B4JLYGly9KmpERhIjPTdLL2l+F3MVcts0MaZ0pYdvA3YA/OCYtYtO9phRCcIBv6
         dGuWCd5QtEWAQN/P4lAfKV5SLLDgDxtSGWHE1+jCPRWWnE7/JnRRJ14EwOkoX8AJ8u
         nWtqmJ4p6YnhbbDQzVsTihsr3BTxpRYvzoqwYJLI=
Authentication-Results: mxback16j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id aBebW1wM4V-rphi5q2w;
        Fri, 31 May 2019 22:53:51 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Andrey Abramov <st5pub@yandex.ru>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        st5pub@yandex.ru
Subject: [PATCH] btrfs: Fix -Wunused-but-set-variable warnings
Date:   Fri, 31 May 2019 22:53:49 +0300
Message-Id: <20190531195349.31129-1-st5pub@yandex.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix -Wunused-but-set-variable warnings in raid56.c and sysfs.c files

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
 fs/btrfs/raid56.c | 32 +++++++++++---------------------
 fs/btrfs/sysfs.c  |  5 +----
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f3d0576dd327..4ab29eacfdf3 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1182,22 +1182,17 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	int nr_data = rbio->nr_data;
 	int stripe;
 	int pagenr;
-	int p_stripe = -1;
-	int q_stripe = -1;
+	int is_q_stripe = 0;
 	struct bio_list bio_list;
 	struct bio *bio;
 	int ret;
 
 	bio_list_init(&bio_list);
 
-	if (rbio->real_stripes - rbio->nr_data == 1) {
-		p_stripe = rbio->real_stripes - 1;
-	} else if (rbio->real_stripes - rbio->nr_data == 2) {
-		p_stripe = rbio->real_stripes - 2;
-		q_stripe = rbio->real_stripes - 1;
-	} else {
+	if (rbio->real_stripes - rbio->nr_data == 2)
+		is_q_stripe = 1;
+	else if (rbio->real_stripes - rbio->nr_data != 1)
 		BUG();
-	}
 
 	/* at this point we either have a full stripe,
 	 * or we've read the full stripe from the drive.
@@ -1241,7 +1236,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 		SetPageUptodate(p);
 		pointers[stripe++] = kmap(p);
 
-		if (q_stripe != -1) {
+		if (is_q_stripe) {
 
 			/*
 			 * raid6, add the qstripe and call the
@@ -2340,8 +2335,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	int nr_data = rbio->nr_data;
 	int stripe;
 	int pagenr;
-	int p_stripe = -1;
-	int q_stripe = -1;
+	int is_q_stripe = 0;
 	struct page *p_page = NULL;
 	struct page *q_page = NULL;
 	struct bio_list bio_list;
@@ -2351,14 +2345,10 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
 	bio_list_init(&bio_list);
 
-	if (rbio->real_stripes - rbio->nr_data == 1) {
-		p_stripe = rbio->real_stripes - 1;
-	} else if (rbio->real_stripes - rbio->nr_data == 2) {
-		p_stripe = rbio->real_stripes - 2;
-		q_stripe = rbio->real_stripes - 1;
-	} else {
+	if (rbio->real_stripes - rbio->nr_data == 2)
+		is_q_stripe = 1;
+	else if (rbio->real_stripes - rbio->nr_data != 1)
 		BUG();
-	}
 
 	if (bbio->num_tgtdevs && bbio->tgtdev_map[rbio->scrubp]) {
 		is_replace = 1;
@@ -2380,7 +2370,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		goto cleanup;
 	SetPageUptodate(p_page);
 
-	if (q_stripe != -1) {
+	if (is_q_stripe) {
 		q_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
 		if (!q_page) {
 			__free_page(p_page);
@@ -2403,7 +2393,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		/* then add the parity stripe */
 		pointers[stripe++] = kmap(p_page);
 
-		if (q_stripe != -1) {
+		if (is_q_stripe) {
 
 			/*
 			 * raid6, add the qstripe and call the
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 2f078b77fe14..514b75dec4a9 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -887,13 +887,10 @@ void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_fs_devices *fs_devs;
 	struct kobject *fsid_kobj;
-	u64 features;
-	int ret;
 
 	if (!fs_info)
 		return;
 
-	features = get_features(fs_info, set);
 	ASSERT(bit & supported_feature_masks[set]);
 
 	fs_devs = fs_info->fs_devices;
@@ -907,7 +904,7 @@ void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 	 * to use sysfs_update_group but some refactoring is needed first.
 	 */
 	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
-	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
+	sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
 }
 
 static int btrfs_init_debugfs(void)
-- 
2.20.1

