Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB16333863
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 10:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhCJJJ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 04:09:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:34954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232484AbhCJJJI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 04:09:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615367347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxRgcwsMK3F+Z+3D43e74I6ovMwLmD7YbuYjLdo16oQ=;
        b=cfMmjTWkfHmgdfYeAT7GfWog/8UPCNfCbyIdEKKWnodWbpu64zq9QntXF5srl38wvsXOQl
        l+sjZNtklp6TQ2aCfYYEhAKoMVywnUrrJLo9+0TQ7ZfYg43og8hya4/4biv7szDjqMUf+k
        tnUeUOgsmLvibmAJ847OfmIeXsk3z4s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B496AE1B
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:09:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 14/15] btrfs: make lock_extent_buffer_for_io() to be subpage compatible
Date:   Wed, 10 Mar 2021 17:08:32 +0800
Message-Id: <20210310090833.105015-15-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210310090833.105015-1-wqu@suse.com>
References: <20210310090833.105015-1-wqu@suse.com>
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
index 74525ebf2b83..18730d3ab50f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3937,7 +3937,13 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 
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
2.30.1

