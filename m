Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0533210E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 07:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBVGf6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 01:35:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:48824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhBVGft (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 01:35:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613975675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vvuUuzSKfj/jx0OJYHxsZG+rzK+hrgLUfMHDGvrqel8=;
        b=mXE7c6GxLlvPaRZCLrWPnmCeFKIpgC91I3OE9Sihv5OsMZQgfHBEkmfhXNs6kVyfZi0JIP
        HthyJInUhylfQP52cJ4ZJZFErPLe8BLn6Nl7buKYBaQTnCbSjMhEsBQpDQZUaG+XR10Xve
        Sgmi5VVAdsoU/D4KhHwey1nsp2c1X28=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 671E1B12A
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 06:34:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/12] btrfs: extent_io: make lock_extent_buffer_for_io() to support subpage metadata
Date:   Mon, 22 Feb 2021 14:33:56 +0800
Message-Id: <20210222063357.92930-12-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222063357.92930-1-wqu@suse.com>
References: <20210222063357.92930-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage metadata, we don't use page locking at all.
So just skip the page locking part for subpage.

All the remaining routine can be reused.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ea603c1f2994..edfca14a158e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3927,7 +3927,13 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 
 	btrfs_tree_unlock(eb);
 
-	if (!ret)
+	/*
+	 * Either we don't need to submit any tree block, or we're submitting
+	 * subpage.
+	 * Subpage metadata doesn't use page locking at all, so we can skip
+	 * the page locking.
+	 */
+	if (!ret || fs_info->sectorsize < PAGE_SIZE)
 		return ret;
 
 	num_pages = num_extent_pages(eb);
-- 
2.30.0

