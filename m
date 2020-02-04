Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2098C15204F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 19:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgBDSTC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 13:19:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44957 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgBDSTC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 13:19:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id w8so15054793qts.11
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 10:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AThYQH1oc9FV/hGd/nLbIoBnev8JkhtMp5idHf3QVyg=;
        b=hwYAeKq74Br/15Tj+NXfEQ2SJ498Tav8H4TlzLj10r12oPA9AZ71FjmdLCLPrW7t7m
         e1wCIa/AS1DKaYKnui8eWy2zgP30gAPeLKxwrRw2jCPfjRqPzJ9mil241b3hPJzpKls6
         sUoy5qApjJNWOIYFDeWGFKm4YejqFdr6mwGUmdyIblqMGDPx+B1yZwnGyEe+dC7rZ9XW
         QikObd5UjpfeyrnxqUC1aslztBmru3sCjH0HS7QAvj79MOycQBim72AWR7kLy0vA3Wxu
         wzTsvxePiLpbub0jCTOrbaHNwkwgHHR6JSgEAk865CSv4kSKqUT3WQ+zDz/p2ruSLWGm
         //ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AThYQH1oc9FV/hGd/nLbIoBnev8JkhtMp5idHf3QVyg=;
        b=LrZ5AOJBQ+0I/Sc+ZLLwgj6WwYyoGo/oCpnLjzZxK/qeZXzv5z/gC6B5T6Y+dUpEcn
         7ws4ah2b0tv/2tCOUar+H1zpzAQMHL9+7bVz3e3chl1Jpe0TU8FVXeiSyp3lgnrZVgEQ
         wB2CIChfTPr7TL2ckh0hZR8tGMpucrCLKU4rJBTft3rr8ci9q+dPsJTcLwlsTWL3HwR5
         2flrCdRfFOcoNlK3+1gCW0Zyv1Xtib2Px5WCNyyA57eFcf5r+Ymzw0dXdi0jxGvPYQkc
         F+jxEJY/X+Rdhten+AZVUTyv+GhFaJwr1Mc5izfPAXqfl813IDZ/QKJ3rh9twHqkGRaG
         PXkw==
X-Gm-Message-State: APjAAAWkrTHmuUK9YrWMd0UAZEPk5Wt/i7iWRT8f1xY5LmG/W0aHSwZy
        SpXx6IAp2E/zVpTGWLHuM+ai0rgr590vog==
X-Google-Smtp-Source: APXvYqwcjGDnYg3EOejUdaBAY9eWF589rEjgOfGWt2oiWOa+0kXQZ+AssAqoSaMKEJ96nX41Y8BfyQ==
X-Received: by 2002:aed:3109:: with SMTP id 9mr30342522qtg.166.1580840340492;
        Tue, 04 Feb 2020 10:19:00 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 135sm11675041qkl.68.2020.02.04.10.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 10:18:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: add a comment describing block-rsvs
Date:   Tue,  4 Feb 2020 13:18:54 -0500
Message-Id: <20200204181856.765916-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204181856.765916-1-josef@toxicpanda.com>
References: <20200204181856.765916-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a giant comment at the top of block-rsv.c describing generally
how block rsvs work.  It is purely about the block rsv's themselves, and
nothing to do with how the actual reservation system works.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index d07bd41a7c1e..c3843a0001cb 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -6,6 +6,97 @@
 #include "space-info.h"
 #include "transaction.h"
 
+/*
+ * HOW DO BLOCK RSVS WORK
+ *
+ *   Think of block_rsv's as buckets for logically grouped metadata
+ *   reservations.  Each block_rsv has a ->size and a ->reserved.  ->size is how
+ *   large we want our block rsv to be, ->reserved is how much space is
+ *   currently reserved for this block reserve.
+ *
+ *   ->failfast exists for the truncate case, and is described below.
+ *
+ * NORMAL OPERATION
+ *
+ *   -> Reserve
+ *     Entrance: btrfs_block_rsv_add, btrfs_block_rsv_refill
+ *
+ *     We call into btrfs_reserve_metadata_bytes() with our bytes, which is
+ *     accounted for in space_info->bytes_may_use, and then add the bytes to
+ *     ->reserved, and ->size in the case of btrfs_block_rsv_add.
+ *
+ *     ->size is an over-estimation of how much we may use for a particular
+ *     operation.
+ *
+ *   -> Use
+ *     Entrance: btrfs_use_block_rsv
+ *
+ *     When we do a btrfs_alloc_tree_block() we call into btrfs_use_block_rsv()
+ *     to determine the appropriate block_rsv to use, and then verify that
+ *     ->reserved has enough space for our tree block allocation.  Once
+ *     successful we subtract fs_info->nodesize from ->reserved.
+ *
+ *   -> Finish
+ *     Entrance: btrfs_block_rsv_release
+ *
+ *     We are finished with our operation, subtract our individual reservation
+ *     from ->size, and then subtract ->size from ->reserved and free up the
+ *     excess if there is any.
+ *
+ *     There is some logic here to refill the delayed refs rsv or the global rsv
+ *     as needed, otherwise the excess is subtracted from
+ *     space_info->bytes_may_use.
+ *
+ * TYPES OF BLOCK RSVS
+ *
+ * BLOCK_RSV_TRANS, BLOCK_RSV_DELOPS, BLOCK_RSV_CHUNK
+ *   These behave normally, as described above, just within the confines of the
+ *   lifetime of their particular operation (transaction for the whole trans
+ *   handle lifetime, for example).
+ *
+ * BLOCK_RSV_GLOBAL
+ *   It is impossible to properly account for all the space that may be required
+ *   to make our extent tree updates.  This block reserve acts as an overflow
+ *   buffer in case our delayed refs rsv does not reserve enough space to update
+ *   the extent tree.
+ *
+ *   We can steal from this in some cases as well, notably on evict() or
+ *   truncate() in order to help users recover from ENOSPC conditions.
+ *
+ * BLOCK_RSV_DELALLOC
+ *   The individual item sizes are determined by the per-inode size
+ *   calculations, which are described with the delalloc code.  This is pretty
+ *   straightforward, it's just the calculation of ->size encodes a lot of
+ *   different items, and thus it gets used when updating inodes, inserting file
+ *   extents, and inserting checksums.
+ *
+ * BLOCK_RSV_DELREFS
+ *   We keep a running tally of how many delayed refs we have on the system.
+ *   We assume each one of these delayed refs are going to use a full
+ *   reservation.  We use the transaction items and pre-reserve space for every
+ *   operation, and use this reservation to refill any gap between ->size and
+ *   ->reserved that may exist.
+ *
+ *   From there it's straightforward, removing a delayed ref means we remove its
+ *   count from ->size and free up reservations as necessary.  Since this is the
+ *   most dynamic block rsv in the system, we will try to refill this block rsv
+ *   first with any excess returned by any other block reserve.
+ *
+ * BLOCK_RSV_EMPTY
+ *   This is the fallback block rsv to make us try to reserve space if we don't
+ *   have a specific bucket for this allocation.  It is mostly used for updating
+ *   the device tree and such, since that is a separate pool we're content to
+ *   just reserve space from the space_info on demand.
+ *
+ * BLOCK_RSV_TEMP
+ *   This is used by things like truncate and iput.  We will temporarily
+ *   allocate a block rsv, set it to some size, and then truncate bytes until we
+ *   have no space left.  With ->failfast set we'll simply return ENOSPC from
+ *   btrfs_use_block_rsv() to signal that we need to unwind and try to make a
+ *   new reservation.  This is because these operations are unbounded, so we
+ *   want to do as much work as we can, and then back off and re-reserve.
+ */
+
 static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_rsv *block_rsv,
 				    struct btrfs_block_rsv *dest, u64 num_bytes,
-- 
2.24.1

