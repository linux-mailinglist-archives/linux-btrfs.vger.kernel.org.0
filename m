Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C91151E1F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgBDQUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35142 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgBDQUA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id n17so13602836qtv.2
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2t7GBB+OcIuqYG/OMGmOMCLjHIT3UbFwhBrFD3CLqf8=;
        b=L9l9M9cyGrQAErNoD3CZKkLfoLlWeyQoibyijy33h+KkCCvQHtNh9MaTwsGJgwbxB8
         /b8KtAXHpsN1oXH3/kg04fAEE7Z5iME3cgCQFFG666DZrSiqyJ7+zj8C8spGKEhZ33EQ
         gDEoAEM7paUEVYvuHxC1oi8Ekv/XQaa/1v2RfaO1b8tAogpWQ7xqDWD9NeKvLXxK41N/
         InmMLui8L8EbrH6PD9aKt+K+6wE4Er+pmd3vFc0QRThTDYhtXYFgKnfKdmhFeUZnw7hS
         xDQH1s0jdUL6PGO4Mh31ZR5WjLJv9otm58S6z4mUukjdMh6Y1Z9vMGADuhWfqRAWEZra
         4LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2t7GBB+OcIuqYG/OMGmOMCLjHIT3UbFwhBrFD3CLqf8=;
        b=Yv7yal+gkx5F3uFYy3cVdImqI864rrxr9G0sw/tZ7y8FaC+ffoi67rLY8DtEeI/N9H
         QKQtQ9FpUrMA5HtrB7J3fw9xusKMTUS72XoczDIQnOUKhWHzrQA8lr4RRBQaZxXYayiw
         MOoYdpRbQEKToMhr3bE6VzAK/LUq1q0IbeGDNmIcjcV2yjXGjm9z0H7rvpNiu728HkT8
         gz7KQr6QfIRfdZUZfcV3Ax++sjiTdiT8dN79nx0i73hjnXq/N+MUJ0xq/FRPfY2wZmIa
         eHKFpBKuThhbyE92qYHsDUiqohrUuSDiGhjQYa0P3Dz37xDpNhVWplAuZ6ZDCQlsUYCN
         aPRw==
X-Gm-Message-State: APjAAAWFI7+soWvPbQvhiaSW5BPuE5M1opez0g6ItmfAhDL+GEEt6mPn
        Qc7HVRC5AHyXCkSXnU+ZpAjT7CJTSFElXQ==
X-Google-Smtp-Source: APXvYqyVi/kJjdX9Sr1COcYYvyO0gJ4OInrG9C4pN9IfC64hcGURqIPGtBN2VKx19QTFLLp2PjdB7Q==
X-Received: by 2002:ac8:64a:: with SMTP id e10mr28623737qth.292.1580833199018;
        Tue, 04 Feb 2020 08:19:59 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b22sm11083686qka.121.2020.02.04.08.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:19:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/23] btrfs: handle U64_MAX for shrink_delalloc
Date:   Tue,  4 Feb 2020 11:19:31 -0500
Message-Id: <20200204161951.764935-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Data allocations are going to want to pass in U64_MAX for flushing
space, adjust shrink_delalloc to handle this properly.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 671c3a379224..924cee245e4a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -363,8 +363,19 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
 	int loops;
 
 	/* Calc the number of the pages we need flush for space reservation */
-	items = calc_reclaim_items_nr(fs_info, to_reclaim);
-	to_reclaim = items * EXTENT_SIZE_PER_ITEM;
+	if (to_reclaim == U64_MAX) {
+		items = U64_MAX;
+	} else {
+		/*
+		 * to_reclaim is set to however much metadata we need to
+		 * reclaim, but reclaiming that much data doesn't really track
+		 * exactly, so increase the amount to reclaim by 2x in order to
+		 * make sure we're flushing enough delalloc to hopefully reclaim
+		 * some metadata reservations.
+		 */
+		items = calc_reclaim_items_nr(fs_info, to_reclaim) * 2;
+		to_reclaim = items * EXTENT_SIZE_PER_ITEM;
+	}
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
@@ -569,7 +580,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes * 2,
+		shrink_delalloc(fs_info, num_bytes,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

