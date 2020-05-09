Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F511CBDC0
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 07:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgEIF3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 01:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIF3w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 May 2020 01:29:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0646C061A0C;
        Fri,  8 May 2020 22:29:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v63so2082765pfb.10;
        Fri, 08 May 2020 22:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i7Pcj/pO/1wQknbrV0B7XO4re+6riEodPKqMtRylol0=;
        b=S02+alZFvBSnG4edBHgjeoKwZJcTBdf+B3xcf+hOLAicYwixLUf9C3puvplIChaff0
         /cn3sPyeu9ma57n+4aj86XcQXRbqY1gJm8SKEsWmo1mHZ6umPGR4JJrrtOqOVBkmhHFC
         ka6dL2YwKUHAmrniFlOsfGhryZunij9Wk8IwecDSSf77gF+XVavchka3kQNOpVRDktfE
         SJoX8j16dtLuUDiMn4HYbPYQry6fVFDJnAZKZF/BZNiYahGBtJ5Pk7YavyUyUhrA9pxK
         CRuigdkfpkE/7evn+iUzBnayFbJzrbmqvtD9XOwo6NVYG5Fjcg4j1Sd5nY3JBm2M/mr0
         N8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i7Pcj/pO/1wQknbrV0B7XO4re+6riEodPKqMtRylol0=;
        b=HD1Uzja2dh3WN/5gvAA66bsbGpudSSzR8/LnDog6pCPGvwH9m9S9Hx00zkMB682hy1
         kmkxXKHym1Ro6cN/lGY3wsrVQ4/YUI9h+gFBNLq9OHVOP866flFOTaC3CPqWp+Nek1De
         Wzyoib0Dta9+g8yOuGuDcisP/Qb4TOLHWye7Tv9063LF7rRZ4FfWvQnSu0fak0iP775n
         bb27SCKaVnjb4GcXRX+KSrF0fZrOLkBvAyQHKkS2+tjF5RIv6smSdWn3CWct/RMi/JQ5
         8TvZD6qnpzh2lSlhNH7QC5PSOyPIi+MoGiWkgGoAtCHoHjtkD/nqpHfXagvhExwx8hO8
         Icgw==
X-Gm-Message-State: AGi0PubvG61R2AueH4lTI6cm6xGucSQSKl/bU8kqnOt12cXLrFnxU9IQ
        kZD7L0lWZWti6XjFuAAcgZg=
X-Google-Smtp-Source: APiQypIWeshpliUO6GEvnffQhhhEJaYGENM8Z6IVHrfa/1nfD5X36WWlScsQ/zXOyS+c9ZrtkTFr+w==
X-Received: by 2002:a62:15c5:: with SMTP id 188mr6059885pfv.66.1589002190226;
        Fri, 08 May 2020 22:29:50 -0700 (PDT)
Received: from localhost.localdomain ([223.72.62.216])
        by smtp.gmail.com with ESMTPSA id w2sm3793805pja.53.2020.05.08.22.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:29:49 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 3/4] fs: btrfs: fix data races in start_transaction()
Date:   Sat,  9 May 2020 13:29:07 +0800
Message-Id: <20200509052907.3324-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The functions start_transaction() and btrfs_update_delayed_refs_rsv()
are concurrently executed at runtime in the following call contexts:

Thread 1:
  btrfs_sync_file()
    btrfs_start_transaction()
      start_transaction()

Thread 2:
  finish_ordered_fn()
    btrfs_finish_ordered_io()
      insert_reserved_file_extent()
        __btrfs_drop_extents()
          btrfs_free_extent()
            btrfs_add_delayed_data_ref()
              btrfs_update_delayed_refs_rsv()

In start_transaction():
  if (delayed_refs_rsv->full == 0)
  ...
  else if (... && !delayed_refs_rsv->full)

In btrfs_update_delayed_refs_rsv():
  spin_lock(&delayed_rsv->lock);
  delayed_rsv->size += num_bytes;
  delayed_rsv->full = 0;
  spin_unlock(&delayed_rsv->lock);

The values delayed_refs_rsv->full and delayed_rsv->full access the same
memory, and these data races can occur.
These data races were found and actually reproduced by our conccurency
fuzzer.

To fix these races, the spinlock delayed_refs_rsv->lock is used to
protect the access to delayed_refs_rsv->full in start_transaction().

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/btrfs/transaction.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8cede6eb9843..ca38d7cf665d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -524,6 +524,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	u64 qgroup_reserved = 0;
 	bool reloc_reserved = false;
 	int ret;
+	unsigned short full = 0;
 
 	/* Send isn't supposed to start transactions. */
 	ASSERT(current->journal_info != BTRFS_SEND_TRANS_STUB);
@@ -541,6 +542,10 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		goto got_it;
 	}
 
+	spin_lock(&delayed_refs_rsv->lock);
+	full = delayed_refs_rsv->full;
+	spin_unlock(&delayed_refs_rsv->lock);
+
 	/*
 	 * Do the reservation before we join the transaction so we can do all
 	 * the appropriate flushing if need be.
@@ -563,7 +568,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		 * refill that amount for whatever is missing in the reserve.
 		 */
 		num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
-		if (delayed_refs_rsv->full == 0) {
+		if (full == 0) {
 			delayed_refs_bytes = num_bytes;
 			num_bytes <<= 1;
 		}
@@ -585,7 +590,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 			num_bytes -= delayed_refs_bytes;
 		}
 	} else if (num_items == 0 && flush == BTRFS_RESERVE_FLUSH_ALL &&
-		   !delayed_refs_rsv->full) {
+		   !full) {
 		/*
 		 * Some people call with btrfs_start_transaction(root, 0)
 		 * because they can be throttled, but have some other mechanism
-- 
2.17.1

