Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A6A15113F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBCUoq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:44:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33433 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgBCUoq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:44:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id h4so4793856qkm.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sEoCCf8IQmAzXAJ4xe9Qj2AokNkr25o5IVXZdB1y1to=;
        b=aE6wqkLeh9ZTX0lGD6v+ZpoRWFunmPZyw3LkiWO46bo4oM+++E/IvswGV2T2GR2NVq
         V2dO+EHMjny+tue8/9MDqcqcl1mZy4OYBpAUIpZYtNUiPtKHBGeqb2P1QV8oYAg/rcS/
         sMuml2xTnqVvmbE3q3JCL+3aGjpn9yrOXVtQOTdDB/n9tLvaR/XQKIYqHbtDIKSDhL2d
         NJfXfKA/8STTZ3zT64SMbsOJVN/91HKK4huZete7CLERRTAk4vnmP3rN2oSaCbWDR6lR
         aksE7nJKu2ZF1GshaVLQDrlqAC1wj1rkp4BGWPnQWmM6zkJu6cAt74kwx1yWwSkzecPX
         8EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEoCCf8IQmAzXAJ4xe9Qj2AokNkr25o5IVXZdB1y1to=;
        b=Wg8fN3hj0T9dayeOrEYdcONLwwE8XWi/qUBwKNW8qnwoIiuddtVmW+N2WH/D/el5JW
         I1omk+LMBQkcynpv/nrkisXYEKVAJ/hEN/zF+H0n6Wgxswa7Uv21uHpNrml0QF6blTNr
         Uszcfol/vO4tDKgY3TuwMfXBVNfdLAFPlcLJOApnl4YtYWw+OnLcWORTiwG6Vfli3lUd
         CNKqSNTCc3n6rq5p8XMfIp2/VdW2o5CWKzvGzybAEQCsCFM4ed4vEACs3uB7D80YfbrQ
         DiA0Ve7YlcQ57z/JhKptSxi9bLwtFgUIPaBbZX6xHHbAC7sLsqv5dybZTvmCq3V70kf4
         YeVg==
X-Gm-Message-State: APjAAAUiOlVl5c/26y0aV5qvlKlq1z4xbnuQYkNW+PIwLDnI5uyqRvMD
        2MoyJNr5gBW5A7vDstQlh2RF7sK+uZA9yg==
X-Google-Smtp-Source: APXvYqy/ksZlDH6LGZ4VVHDUgVRuSt/ZQrXFnd8ixlxfVdrcmW7kSml82a1Gjjy2n4Z+75E3aE3oOw==
X-Received: by 2002:a37:a896:: with SMTP id r144mr3140364qke.51.1580762683661;
        Mon, 03 Feb 2020 12:44:43 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p50sm10897577qtf.5.2020.02.03.12.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:44:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: describe the space reservation system in general
Date:   Mon,  3 Feb 2020 15:44:36 -0500
Message-Id: <20200203204436.517473-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204436.517473-1-josef@toxicpanda.com>
References: <20200203204436.517473-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add another comment to cover how the space reservation system works
generally.  This covers the actual reservation flow, as well as how
flushing is handled.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 128 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d3befc536a7f..6de1fbe2835a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -10,6 +10,134 @@
 #include "transaction.h"
 #include "block-group.h"
 
+/*
+ * HOW DOES SPACE RESERVATION WORK
+ *
+ * If you want to know about delalloc specifically, there is a separate comment
+ * for that with the delalloc code.  This comment is about how the whole system
+ * works generally.
+ *
+ * BASIC CONCEPTS
+ *
+ *   1) space_info.  This is the ultimate arbiter of how much space we can use.
+ *   There's a description of the bytes_ fields with the struct declaration,
+ *   refer to that for specifics on each field.  Suffice it to say that for
+ *   reservations we care about total_bytes - SUM(space_info->bytes_) when
+ *   determining if there is space to make an allocation.
+ *
+ *   2) block_rsv's.  These are basically buckets for every different type of
+ *   metadata reservation we have.  You can see the comment in the block_rsv
+ *   code on the rules for each type, but generally block_rsv->reserved is how
+ *   much space is accounted for in space_info->bytes_may_use.
+ *
+ *   3) btrfs_calc*_size.  These are the worst case calculations we used based
+ *   on the number of items we will want to modify.  We have one for changing
+ *   items, and one for inserting new items.  Generally we use these helpers to
+ *   determine the size of the block reserves, and then use the actual bytes
+ *   values to adjust the space_info counters.
+ *
+ * MAKING RESERVATIONS, THE NORMAL CASE
+ *
+ *   Things wanting to make reservations will calculate the size that they want
+ *   and make a reservation request.  If there is sufficient space, and there
+ *   are no current reservations pending, we will adjust
+ *   space_info->bytes_may_use by this amount.
+ *
+ *   Once we allocate an extent, we will add that size to ->bytes_reserved and
+ *   subtract the size from ->bytes_may_use.  Once that extent is written out we
+ *   subtract that value from ->bytes_reserved and add it to ->bytes_used.
+ *
+ *   If there is an error at any point the reserver is responsible for dropping
+ *   its reservation from ->bytes_may_use.
+ *
+ * MAKING RESERVATIONS, FLUSHING
+ *
+ *   If we are unable to satisfy our reservation, or if there are pending
+ *   reservations already, we will create a reserve ticket and add ourselves to
+ *   the appropriate list.  This is controlled by btrfs_reserve_flush_enum.  For
+ *   simplicity sake this boils down to two cases, priority and normal.
+ *
+ *   1) Priority.  These reservations are important and have limited ability to
+ *   flush space.  For example, the relocation code currently tries to make a
+ *   reservation under a transaction commit, thus it cannot wait on anything
+ *   that may want to commit the transaction.  These tasks will add themselves
+ *   to the priority list and thus get any new space first, and then they can
+ *   flush space directly in their own context that is safe for them to do
+ *   without causing a deadlock.
+ *
+ *   2) Normal.  These reservations can wait forever on anything, because the do
+ *   not hold resources that they would deadlock on.  These tickets simply go to
+ *   sleep and start an async thread that will flush space on their behalf.
+ *   Every time one of the ->bytes_* counters is adjusted for the space info, we
+ *   will check to see if there is enough space to satisfy the requests (in
+ *   order) on either of our lists.  If there is enough space we will set the
+ *   ticket->bytes = 0, and wake the task up.  If we flush a few times and fail
+ *   to make any progress we will wake up all of the tickets and fail them all.
+ *
+ * THE FLUSHING STATES
+ *
+ *   Generally speaking we will have two cases for each state, a "nice" state
+ *   and a "ALL THE THINGS" state.  In btrfs we delay a lot of work in order to
+ *   reduce the locking over head on the various trees, and even to keep from
+ *   doing any work at all in the case of delayed refs.  Each of these delayed
+ *   things however hold reservations, and so letting them run allows us to
+ *   reclaim space so we can make new reservations.
+ *
+ *   FLUSH_DELAYED_ITEMS
+ *     Every inode has a delayed item to update the inode.  Take a simple write
+ *     for example, we would update the inode item at write time to update the
+ *     mtime, and then again at finish_ordered_io() time in order to update the
+ *     isize or bytes.  We keep these delayed items to coalesce these operations
+ *     into a single operation done on demand.  These are an easy way to reclaim
+ *     metadata space.
+ *
+ *   FLUSH_DELALLOC
+ *     Look at the delalloc comment to get an idea of how much space is reserved
+ *     for delayed allocation.  We can reclaim some of this space simply by
+ *     running delalloc, but usually we need to wait for ordered extents to
+ *     reclaim the bulk of this space.
+ *
+ *   FLUSH_DELAYED_REFS
+ *     We have a block reserve for the outstanding delayed refs space, and every
+ *     delayed ref operation holds a reservation.  Running these is a quick way
+ *     to reclaim space, but we want to hold this until the end because COW can
+ *     churn a lot and we can avoid making some extent tree modifications if we
+ *     are able to delay for as long as possible.
+ *
+ *   ALLOC_CHUNK
+ *     We will skip this the first time through space reservation, because of
+ *     overcommit and we don't want to have a lot of useless metadata space when
+ *     our worst case reservations will likely never come true.
+ *
+ *   RUN_DELAYED_IPUTS
+ *     If we're freeing inodes we're likely freeing checksums, file extent
+ *     items, and extent tree items.  Loads of space could be freed up by these
+ *     operations, however they won't be usable until the transaction commits.
+ *
+ *   COMMIT_TRANS
+ *     may_commit_transaction() is the ultimate arbiter on wether we commit the
+ *     transaction or not.  In order to avoid constantly churning we do all the
+ *     above flushing first and then commit the transaction as the last resort.
+ *     However we need to take into account things like pinned space that would
+ *     be freed, plus any delayed work we may not have gotten rid of in the case
+ *     of metadata.
+ *
+ * OVERCOMMIT
+ *   Because we hold so many reservations for metadata we will allow you to
+ *   reserve more space than is currently free in the currently allocate
+ *   metadata space.  This only happens with metadata, data does not allow
+ *   overcommitting.
+ *
+ *   You can see the current logic for when we allow overcommit in
+ *   btrfs_can_overcommit(), but it only applies to unallocated space.  If there
+ *   is no unallocated space to be had, all reservations are kept within the
+ *   free space in the allocated metadata chunks.
+ *
+ *   Because of overcommitting, you generally want to use the
+ *   btrfs_can_overcommit() logic for metadata allocations, as it does the right
+ *   thing with or without extra unallocated space.
+ */
+
 u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
 			  bool may_use_included)
 {
-- 
2.24.1

