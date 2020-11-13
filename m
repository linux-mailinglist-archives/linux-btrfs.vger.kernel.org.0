Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D22B1B67
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKMMwh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:52:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:47056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgKMMwg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:52:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hKu+2dqc3bQnd2AMdmXv5wOZhHB/RIhlVaIQREHAQ1A=;
        b=A0SFUg5Y4SKbWJPZ00gxOcLLa0M1zwFEafNdox5xIKTGbyu1vEehhKXqRwu/E5cHaxKj1j
        9DXJyC6XqiVQr3s9jAOsqRnp537qh0WzKnHWib9ZSDWUUhmokd86U6dZHZdFogl9cJFuIB
        b5e5Qhjm/SPKaYQEXc6cU2h8m8Zia8w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72ABEABD6;
        Fri, 13 Nov 2020 12:52:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 12/24] btrfs: extent_io: update num_extent_pages() to support subpage sized extent buffer
Date:   Fri, 13 Nov 2020 20:51:37 +0800
Message-Id: <20201113125149.140836-13-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage sized extent buffer, we have ensured no extent buffer will
cross page boundary, thus we would only need one page for any extent
buffer.

This patch will update the function num_extent_pages() to handle such
case.
Now num_extent_pages() would return 1 instead of for subpage sized
extent buffer.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index dfdef9c5c379..d39ebaee5ff7 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -206,8 +206,15 @@ void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
 
 static inline int num_extent_pages(const struct extent_buffer *eb)
 {
-	return (round_up(eb->start + eb->len, PAGE_SIZE) >> PAGE_SHIFT) -
-	       (eb->start >> PAGE_SHIFT);
+	/*
+	 * For sectorsize == PAGE_SIZE case, since eb is always aligned to
+	 * sectorsize, it's just (eb->len / PAGE_SIZE) >> PAGE_SHIFT.
+	 *
+	 * For sectorsize < PAGE_SIZE case, we only want to support 64K
+	 * PAGE_SIZE, and ensured all tree blocks won't cross page boundary.
+	 * So in that case we always got 1 page.
+	 */
+	return round_up(eb->len, PAGE_SIZE) >> PAGE_SHIFT;
 }
 
 static inline int extent_buffer_uptodate(const struct extent_buffer *eb)
-- 
2.29.2

