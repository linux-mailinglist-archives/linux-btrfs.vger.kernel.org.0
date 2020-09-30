Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723CF27DE15
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgI3B4q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:50580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbgI3B4p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4NijXaoGWKrqkulDOUvaZmN5yE7iYY8ZfK84iLI580=;
        b=qHhxDkFlJmYg5TJikDn6ypwHNVd8l0udkhWYIjRaN/fkQONZ9lE4JhP+o8WLe4JLCglWTu
        gfHBMLMWHhh69CKjPfGNWnwFddfll+VD+SZhKe0DxC49NZRFVYAHUrPP87aRioxc4J9WIp
        oooF+CIvnbIF5Y2SerPX5+wIp/mZYT4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4893AF95
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:56:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 28/49] btrfs: extent_io: update num_extent_pages() to support subpage sized extent buffer
Date:   Wed, 30 Sep 2020 09:55:18 +0800
Message-Id: <20200930015539.48867-29-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e588b3100ede..552afc1c0bbc 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -229,8 +229,15 @@ void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
 
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
+	return (round_up(eb->len, PAGE_SIZE) >> PAGE_SHIFT);
 }
 
 static inline int extent_buffer_uptodate(const struct extent_buffer *eb)
-- 
2.28.0

