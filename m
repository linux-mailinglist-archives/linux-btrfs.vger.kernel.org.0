Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FC7152051
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 19:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgBDSTH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 13:19:07 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44961 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgBDSTG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 13:19:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id w8so15054979qts.11
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 10:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JSOK0oQvlKfuvHGSH12lSJ7IXBroR8lAJW7oqX+lnDo=;
        b=mknovd7X2zgvjtpfSRxAgYB8EyKB2w3ymQyZ+SMFrWBEj+UhNMmRKjk8DmNPul6bfV
         vLt445HcK7sBKr0nN/WbjsNaYCSngoiogb6CLjAHYUJHt+pPrk5+Idx4oX3oX+ZSJGn4
         M3k/DgFR9tygKJRiqA9kE/gsYRVxiPYvnIp9q0oZzD0SSCEAYOVYlD75rVxf+2kmxZEV
         OQL0yJ3ZhnmrVQnH2IIAuHsmElVOlzKWne4iJgSbwg1R6dM04o60/ij/9EdOTJgpFZW9
         WhnCSqbNnxobKYpOBAmsvw3d6f2T9TzT+RfIE/Kgbf9vFdzYYP44wvBy5CGjO2icwiII
         AqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSOK0oQvlKfuvHGSH12lSJ7IXBroR8lAJW7oqX+lnDo=;
        b=CBD/x+ydpLuhR0BAgS+Mut91S9Yfd4xzI/oEiou4/pvBQfOZHAo28qr+2Q5hdgMN1f
         aM0cJ4fD+ZUaGNxFH0FZdedF0uwxDzPGxdDaWaOrGZckBRtB+62oSyE4fnc6X7foi/lm
         8IBHp/m7cx5XPBUW964OgMs7ran7KtpusYyL8bRxDDU8CcPyJewjSImFT/qtjIVL3CWX
         HfyMFBM1DAh9gb3JnkLip/KPlyQ06hdOpZzOf7na7JjvpvDvqVQ82rzrpj+a0YQttt8Q
         sF4SpeYg3tYoax6WPYNccgv0Zrzq/LIzpxVDEbQGRxCXDWt1jFJaRqUat7GPHLHe1cBn
         ehfQ==
X-Gm-Message-State: APjAAAUdHyJx9rKELGJ7ER69lEYPh5IlJMkz47DfJ/691G67STDOdrvw
        yX5yGkAFBakBxKKWpPv4B+SsYdvZBea8uw==
X-Google-Smtp-Source: APXvYqzI0ufBqRZaPGZMjnLf2xylXuhYkRmYhXfOP5dKxE22vm05Awu1VrpusyKjjcoJfem48sIXuw==
X-Received: by 2002:ac8:6644:: with SMTP id j4mr28585906qtp.90.1580840343893;
        Tue, 04 Feb 2020 10:19:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 11sm11284101qko.76.2020.02.04.10.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 10:19:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: describe the space reservation system in general
Date:   Tue,  4 Feb 2020 13:18:56 -0500
Message-Id: <20200204181856.765916-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204181856.765916-1-josef@toxicpanda.com>
References: <20200204181856.765916-1-josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 146 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 56425674e940..db387816455c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -10,6 +10,152 @@
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
+ *   determining if there is space to make an allocation.  There is a space_info
+ *   for METADATA, SYSTEM, and DATA areas.
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
+ *   We call into either btrfs_reserve_data_bytes() or
+ *   btrfs_reserve_metadata_bytes(), depending on which we're looking for, with
+ *   num_bytes we want to reserve.
+ *
+ *   ->reserve
+ *     space_info->bytes_may_reserve += num_bytes
+ *
+ *   ->extent allocation
+ *     Call btrfs_add_reserved_bytes() which does
+ *     space_info->bytes_may_reserve -= num_bytes
+ *     space_info->bytes_reserved += extent_bytes
+ *
+ *   ->insert reference
+ *     Call btrfs_update_block_group() which does
+ *     space_info->bytes_reserved -= extent_bytes
+ *     space_info->bytes_used += extent_bytes
+ *
+ * MAKING RESERVATIONS, FLUSHING NORMALLY (non-priority)
+ *
+ *   Assume we are unable to simply make the reservation because we do not have
+ *   enough space
+ *
+ *   -> __reserve_bytes
+ *     create a reserve_ticket with ->bytes set to our reservation, add it to
+ *     the tail of space_info->tickets, kick async flush thread
+ *
+ *   ->handle_reserve_ticket
+ *     wait on ticket->wait for ->bytes to be reduced to 0, or ->error to be set
+ *     on the ticket.
+ *
+ *   -> btrfs_async_reclaim_metadata_space/btrfs_async_reclaim_data_space
+ *     Flushes various things attempting to free up space.
+ *
+ *   -> btrfs_try_granting_tickets()
+ *     This is called by anything that either subtracts space from
+ *     space_info->bytes_may_use, ->bytes_pinned, etc, or adds to the
+ *     space_info->total_bytes.  This loops through the ->priority_tickets and
+ *     then the ->tickets list checking to see if the reservation can be
+ *     completed.  If it can the space is added to space_info->bytes_may_use and
+ *     the ticket is woken up.
+ *
+ *   -> ticket wakeup
+ *     Check if ->bytes == 0, if it does we got our reservation and we can carry
+ *     on, if not return the appropriate error (ENOSPC, but can be EINTR if we
+ *     were interrupted.)
+ *
+ * MAKING RESERVATIONS, FLUSHING HIGH PRIORITY
+ *
+ *   Same as the above, except we add ourselves to the
+ *   space_info->priority_tickets, and we do not use ticket->wait, we simply
+ *   call flush_space() ourselves for the states that are safe for us to call
+ *   without deadlocking and hope for the best.
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
+ *     may_commit_transaction() is the ultimate arbiter on whether we commit the
+ *     transaction or not.  In order to avoid constantly churning we do all the
+ *     above flushing first and then commit the transaction as the last resort.
+ *     However we need to take into account things like pinned space that would
+ *     be freed, plus any delayed work we may not have gotten rid of in the case
+ *     of metadata.
+ *
+ * OVERCOMMIT
+ *
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

