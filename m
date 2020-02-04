Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BA3152050
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 19:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBDSTF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 13:19:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40381 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgBDSTF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 13:19:05 -0500
Received: by mail-qk1-f193.google.com with SMTP id b7so3705441qkl.7
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 10:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H2sQXRMnTW9DFA5QB5mCe0NRB2ify8aDDA9ambZeoKg=;
        b=FMidWas3EwZnOBKfXbDEFVIriF6szR2euUz8pAkdUwuFYk5Lpvi9TRnl12SsEngomp
         WKAPodRfSsWmQsmjJ26kDFZ1vddDBmj1yBKF3R+uftgjUsEmHuOxlsm73i75JQb2KGmx
         kgrsg2F6VYMR1oHuWFYJpE2tog1aF+I/uQWPX2dbX86d7iAQRrwnhLFApDg240mTihYI
         tupUJD13nvCK3MABacNm/o0pToWv+GP9y7oatje7NTMo+2iXEhGwpqptXNS8blaMzg94
         WOz5o6AI9HiBLEox8b4PZeOvmg3y4zgCMlqCIKcjHVS4/lD+f5pFIG2uu7XY//6ZtHxV
         I9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2sQXRMnTW9DFA5QB5mCe0NRB2ify8aDDA9ambZeoKg=;
        b=TNHoTlbwKXsw+DN5vr9+XOiZCZlVkcTZR+NJVt3P00BCVAPvdpCmnpfr6uwbOkogrQ
         N8Ph9w+lBRyJlXEEiU6KgcDerypDi+5LNcvxb5qHJWC7lATQMst1sviunXQfaD86LiFn
         nJNYxCVWldj9zViYA6RleZFw3eyDN2iOeTTI3mabC7RVCcYPSIMgFErfoQrITeGFPPCY
         V9t+sRtxebZHkJ7oexw2+CbI0IKKYgmDgAxEBAX78QtPoM37TpBl4OMHgmwOj8erNXEZ
         S0Odot9pVcDiSwySaqVccJxFQ5B9IHhOiN2IKCCJqltrGH/R0AWB+eaQFaC89FHqo6kJ
         C/Kg==
X-Gm-Message-State: APjAAAWTdYkCyzbU5lGkCTqmJeZIinHtUW3vkdlHveeKOS8RpDWGlhN3
        mamLsU7PDffxEODxqkq6teM52nPkglAH+w==
X-Google-Smtp-Source: APXvYqzyVrn16XMWqPXFhM3RoOWgDkQ7rhlYDe0G5v6I60icqOabZQiOPxCvfkNDCRAkSifeCLpe3Q==
X-Received: by 2002:a05:620a:3de:: with SMTP id r30mr30671943qkm.189.1580840342183;
        Tue, 04 Feb 2020 10:19:02 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d25sm11324044qka.39.2020.02.04.10.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 10:19:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: add a comment describing delalloc space reservation
Date:   Tue,  4 Feb 2020 13:18:55 -0500
Message-Id: <20200204181856.765916-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204181856.765916-1-josef@toxicpanda.com>
References: <20200204181856.765916-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

delalloc space reservation is tricky because it encompasses both data
and metadata.  Make it clear what each side does, the general flow of
how space is moved throughout the lifetime of a write, and what goes
into the calculations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delalloc-space.c | 101 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index c13d8609cc99..9366509917fc 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -9,6 +9,107 @@
 #include "qgroup.h"
 #include "block-group.h"
 
+/*
+ * HOW DOES THIS WORK
+ *
+ * There are two stages to data reservations, one for data and one for metadata
+ * to handle the new extents and checksums generated by writing data.
+ *
+ *
+ * DATA RESERVATION
+ *   The general flow of the data reservation is as follows
+ *
+ *   -> Reserve
+ *     We call into btrfs_reserve_data_bytes() for the user request bytes that
+ *     they wish to write.  We make this reservation and add it to
+ *     space_info->bytes_may_use.  We set EXTENT_DELALLOC on the inode io_tree
+ *     for the range and carry on if this is buffered, or follow up trying to
+ *     make a real allocation if we are pre-allocating or doing O_DIRECT.
+ *
+ *   -> Use
+ *     At writepages()/prealloc/O_DIRECT time we will call into
+ *     btrfs_reserve_extent() for some part or all of this range of bytes.  We
+ *     will make the allocation and subtract space_info->bytes_may_use by the
+ *     original requested length and increase the space_info->bytes_reserved by
+ *     the allocated length.  This distinction is important because compression
+ *     may allocate a smaller on disk extent than we previously reserved.
+ *
+ *   -> Allocation
+ *     finish_ordered_io() will insert the new file extent item for this range,
+ *     and then add a delayed ref update for the extent tree.  Once that delayed
+ *     ref is written the extent size is subtracted from
+ *     space_info->bytes_reserved and added to space_info->bytes_used.
+ *
+ *   Error handling
+ *
+ *   -> By the reservation maker
+ *     This is the simplest case, we haven't completed our operation and we know
+ *     how much we reserved, we can simply call
+ *     btrfs_free_reserved_data_space*() and it will be removed from
+ *     space_info->bytes_may_use.
+ *
+ *   -> After the reservation has been made, but before cow_file_range()
+ *     This is specifically for the delalloc case.  You must clear
+ *     EXTENT_DELALLOC with the EXTENT_CLEAR_DATA_RESV bit, and the range will
+ *     be subtracted from space_info->bytes_may_use.
+ *
+ * METADATA RESERVATION
+ *   The general metadata reservation lifetimes are discussed elsewhere, this
+ *   will just focus on how it is used for delalloc space.
+ *
+ *   We keep track of two things on a per inode bases
+ *
+ *   ->outstanding_extents
+ *     This is the number of file extent items we'll need to handle all of the
+ *     outstanding DELALLOC space we have in this inode.  We limit the maximum
+ *     size of an extent, so a large contiguous dirty area may require more than
+ *     one outstanding_extent, which is why count_max_extents() is used to
+ *     determine how many outstanding_extents get added.
+ *
+ *   ->csum_bytes
+ *     This is essentially how many dirty bytes we have for this inode, so we
+ *     can calculate the number of checksum items we would have to add in order
+ *     to checksum our outstanding data.
+ *
+ *   We keep a per-inode block_rsv in order to make it easier to keep track of
+ *   our reservation.  We use btrfs_calculate_inode_block_rsv_size() to
+ *   calculate the current theoretical maximum reservation we would need for the
+ *   metadata for this inode.  We call this and then adjust our reservation as
+ *   necessary, either by attempting to reserve more space, or freeing up excess
+ *   space.
+ *
+ * OUTSTANDING_EXTENTS HANDLING
+ *  ->outstanding_extents is used for keeping track of how many extents we will
+ *  need to use for this inode, and it will fluctuate depending on where you are
+ *  in the life cycle of the dirty data.  Consider the following normal case for
+ *  a completely clean inode, with a num_bytes < our maximum allowed extent size
+ *
+ *  -> reserve
+ *    ->outstanding_extents += 1 (current value is 1)
+ *
+ *  -> set_delalloc
+ *    ->outstanding_extents += 1 (currrent value is 2)
+ *
+ *  -> btrfs_delalloc_release_extents()
+ *    ->outstanding_extents -= 1 (current value is 1)
+ *
+ *    We must call this once we are done, as we hold our reservation for the
+ *    duration of our operation, and then assume set_delalloc will update the
+ *    counter appropriately.
+ *
+ *  -> add ordered extent
+ *    ->outstanding_extents += 1 (current value is 2)
+ *
+ *  -> btrfs_clear_delalloc_extent
+ *    ->outstanding_extents -= 1 (current value is 1)
+ *
+ *  -> finish_ordered_io/btrfs_remove_ordered_extent
+ *    ->outstanding_extents -= 1 (current value is 0)
+ *
+ *  Each stage is responsible for their own accounting of the extent, thus
+ *  making error handling and cleanup easier.
+ */
+
 int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 {
 	struct btrfs_root *root = inode->root;
-- 
2.24.1

