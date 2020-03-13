Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41489184F48
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 20:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCMT2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 15:28:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38673 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMT2w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 15:28:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id e20so8575196qto.5
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoPqyA9p7bHys4OBEsx8GIWVm6trRRa/aD/T7xGCj2k=;
        b=C/FI6fNpXCr0g/rUiDeYierPV4/vRVMi7dbW2hMFRjUCACZkl7/q40Bft3gkQ9+kl5
         OOuAGxDmE2wIyWyozmY/F/AcyldbuKrvfXbK1ooxQOhmcuE/JXe0DkRkA860a7nzN7t6
         8a37fgZpmi1QC8iPO+7nEPysg7G/zHWNr9WnzNSzzWOxMTrkj3cFd+QBnEA/KagJFq2I
         smgS9a9HUi6btH5vIxuhTl8uuCHVTKRrtWwz7P+pHGhceQfIOdXusBTWYRRprrVhkSkv
         SHNDdO1UvMwQ/uk91Bb2tcWE6gB+8qTcRvW9uPJ6W2CYA/02G/9tUKij0FpNQ1dCoK4X
         nQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoPqyA9p7bHys4OBEsx8GIWVm6trRRa/aD/T7xGCj2k=;
        b=SeyNGZ0+zzWBPHWN1hIEgMXUHJUGgeKGZakJXJY6mF+Tr0GrZoOu53LAuFP1+059ed
         YXJRgo/NnTgL0E+z62vqIUnK8jTr1l7XvG3MzYoo80G7jcn0mWcVTX2JlJVeUKni0JVd
         D8OFjK4Cy/9Mrygudffy7cwGzPD265GbUOV+Rx0GbJAHvO7gy2wNljtFDroasiEGynav
         zHkLZUUSGFfkP+8bP5O8FrtJy+E4XR7A5KQLdV4SCoBFLKZYFusDH795hKC0JNioT+Po
         7MfsN7vRy5SmpA6RnOzj1iVreTqTKbYY3HU2Qe3QwD5h5Hixp2ibtij/yOU4/fPw+hSs
         NhdA==
X-Gm-Message-State: ANhLgQ3sjHt8aGFmPIHm6lQ0fv22KGZUujBmZ8cVVo6mziGrX/YbFXnP
        1lw5wB67HTdWT09tk6J9NVDBdjSw9CkpDQ==
X-Google-Smtp-Source: ADFU+vvIFucyz6JwdfAc+zPzkE/k8LCoEHCU+b/wle/mPhCeFcYLOii5eflUTH6OH1NC74A0xxdLtw==
X-Received: by 2002:ac8:6f0f:: with SMTP id g15mr14086448qtv.255.1584127730686;
        Fri, 13 Mar 2020 12:28:50 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c191sm15464760qkg.49.2020.03.13.12.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:28:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: force chunk allocation if our global rsv is larger than metadata
Date:   Fri, 13 Mar 2020 15:28:48 -0400
Message-Id: <20200313192848.140759-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nikolay noticed a bunch of test failures with my global rsv steal
patches.  At first he thought they were introduced by them, but they've
been failing for a while with 64k nodes.

The problem is with 64k nodes we have a global reserve that calculates
out to 13mib on a freshly made file system, which only has 8mib of
metadata space.  Because of changes I previously made we no longer
account for the global reserve in the overcommit logic, which means we
correctly allow overcommit to happen even though we are already
overcommitted.

However in some corner cases, for example btrfs/170, we will allocate
the entire file system up with data chunks before we have enough space
pressure to allocate a metadata chunk.  Then once the fs is full we
ENOSPC out because we cannot overcommit and the global reserve is taking
up all of the available space.

The most ideal way to deal with this is to change our space reservation
stuff to take into account the height of the tree's that we're
modifying, so that our global reserve calculation does not end up so
obscenely large.

However that is a huuuuuuge undertaking.  Instead fix this by forcing a
chunk allocation if the global reserve is larger than the total metadata
space.  This gives us essentially the same behavior that happened
before, we get a chunk allocated and these tests can pass.

This is meant to be a stop-gap measure until we can tackle the "tree
height only" project.

Fixes: 0096420adb03 ("btrfs: do not account global reserve in can_overcommit")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c   |  3 +++
 fs/btrfs/transaction.c | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index e46dc3688983..2e33a31dfc8e 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -5,6 +5,7 @@
 #include "block-rsv.h"
 #include "space-info.h"
 #include "transaction.h"
+#include "block-group.h"
 
 /*
  * HOW DO BLOCK RESERVES WORK
@@ -405,6 +406,8 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	else
 		block_rsv->full = 0;
 
+	if (block_rsv->size >= sinfo->total_bytes)
+		sinfo->force_alloc = CHUNK_ALLOC_FORCE;
 	spin_unlock(&block_rsv->lock);
 	spin_unlock(&sinfo->lock);
 }
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index d171fd52c82b..304606c911e8 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -21,6 +21,7 @@
 #include "dev-replace.h"
 #include "qgroup.h"
 #include "block-group.h"
+#include "space-info.h"
 
 #define BTRFS_ROOT_TRANS_TAG 0
 
@@ -519,6 +520,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	u64 num_bytes = 0;
 	u64 qgroup_reserved = 0;
 	bool reloc_reserved = false;
+	bool do_chunk_alloc = false;
 	int ret;
 
 	/* Send isn't supposed to start transactions. */
@@ -581,6 +583,9 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 							  delayed_refs_bytes);
 			num_bytes -= delayed_refs_bytes;
 		}
+
+		if (rsv->space_info->force_alloc)
+			do_chunk_alloc = true;
 	} else if (num_items == 0 && flush == BTRFS_RESERVE_FLUSH_ALL &&
 		   !delayed_refs_rsv->full) {
 		/*
@@ -663,6 +668,19 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 
 	if (!current->journal_info)
 		current->journal_info = h;
+
+	/*
+	 * If the space_info is marked ALLOC_FORCE then we'll get upgraded to
+	 * ALLOC_FORCE the first run through, and then we won't allocate for
+	 * anybody else who races in later.  We don't care about the return
+	 * value here.
+	 */
+	if (do_chunk_alloc && num_bytes) {
+		u64 flags = h->block_rsv->space_info->flags;
+		btrfs_chunk_alloc(h, btrfs_get_alloc_profile(fs_info, flags),
+				  CHUNK_ALLOC_NO_FORCE);
+	}
+
 	return h;
 
 join_fail:
-- 
2.24.1

