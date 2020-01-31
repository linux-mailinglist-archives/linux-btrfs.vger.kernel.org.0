Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D379914F4E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgAaWgx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:53 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41230 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgAaWgw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id l19so6685292qtq.8
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=n5tXTLLcQsz2ZfJ8D+G2Vlr1YbUYyIGuXV27Rmuhx6U=;
        b=vgo82ca5VUt1Gjote4uRYkpagO0Txc5DNPmEUyDq3XaIYTY233b4o2+I7hpMIiQ917
         XS5PsBaDGWAtVzyQgDW14llzDBqWbOQzzu0t5sRAV2qiw9BSskw2Aej8HpcZVrUIesbi
         gj54QOx9thNx4DWtZgzECdIYkIsXckKKfOsrHlD2GF3BblZQHCtcQ85SGMgugLb6Qoe2
         wnmaQXO+QT/xpIWFOEOL18Oc1SwGaBo5SvVbRaP9h9/BC7oTsraEu4k/N8RZiD9F+7I/
         mKy318mp/PrRBus2cVRf2YU4knuaVLmjRxp0uAWtNqrAR2mlpvA+rStyEvhrVuIVs723
         e/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5tXTLLcQsz2ZfJ8D+G2Vlr1YbUYyIGuXV27Rmuhx6U=;
        b=NjXYp1x+tsqtiVMkSTI+3dYDhDCOFepJBiG5DL18jIK62eDbMayk4rX72nQH6NVIWq
         +KWWrENIqrZcGurMumrX/bzfkGTJJ6El4V1HJVLSIUjq40HL90xg67pDES/01GPMM4ZJ
         q7jOMZkJv8kL+zCUJm/mM8j1h/AD+iYZn6rZnUPa9oIX+LNI9ooFlIBngzP+0BDnDdid
         pR5qqYAK1TzFDtM737S3HwRnOi04DQAy096VNES2ZUfywbo4wZDdvvamqzWCvrih90h3
         5Mjtk+XgPY3syUQHGKVUGeqmJghY6jFkkU0zY6uMjDtHSIhqgyUDASezB6GhJpmF9gmq
         PwwA==
X-Gm-Message-State: APjAAAVllmOIEFDGca+bJPKhwMaUBn6wgXNhmv/XMx9JCufSlNSb+MoG
        ldFZqZqKp1z95OgZ5dlD0s+4MtmUcJpwlA==
X-Google-Smtp-Source: APXvYqwcTJtNpKFlz7U/2L3QHYScO/zwRKXJr6dCrzJJwHeZyRQnL9k4piOrembORH9gvaTcolgIhQ==
X-Received: by 2002:ac8:5548:: with SMTP id o8mr13386531qtr.338.1580510211054;
        Fri, 31 Jan 2020 14:36:51 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o55sm5899716qtf.46.2020.01.31.14.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/23] btrfs: don't force commit if we are data
Date:   Fri, 31 Jan 2020 17:36:10 -0500
Message-Id: <20200131223613.490779-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We used to unconditionally commit the transaction at least 2 times and
then on the 3rd try check against pinned space to make sure committing
the transaction was worth the effort.  This is overkill, we know nobody
is going to steal our reservation, and if we can't make our reservation
with the pinned amount simply bail out.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index cef14a4d4167..0c2d8e66cf5e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -421,21 +421,11 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	u64 reclaim_bytes = 0;
 	u64 bytes_needed;
 	u64 cur_free_bytes = 0;
-	bool do_commit = false;
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
 	if (trans)
 		return -EAGAIN;
 
-	/*
-	 * If we are data just force the commit, we aren't likely to do this
-	 * over and over again.
-	 */
-	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA) {
-		do_commit = true;
-		goto check_pinned;
-	}
-
 	spin_lock(&space_info->lock);
 	cur_free_bytes = btrfs_space_info_used(space_info, true);
 	if (cur_free_bytes < space_info->total_bytes)
@@ -460,7 +450,6 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	if (!bytes_needed)
 		return 0;
 
-check_pinned:
 	trans = btrfs_join_transaction(fs_info->extent_root);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
@@ -470,8 +459,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	 * we have block groups that are going to be freed, allowing us to
 	 * possibly do a chunk allocation the next loop through.
 	 */
-	if (do_commit ||
-	    test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
+	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
 	    __percpu_counter_compare(&space_info->total_bytes_pinned,
 				     bytes_needed,
 				     BTRFS_TOTAL_BYTES_PINNED_BATCH) >= 0)
-- 
2.24.1

