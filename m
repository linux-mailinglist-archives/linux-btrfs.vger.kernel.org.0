Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEA029483A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440785AbgJUG1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:43744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440783AbgJUG1G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4NijXaoGWKrqkulDOUvaZmN5yE7iYY8ZfK84iLI580=;
        b=L8fU3tYP8AR2zB5w47fxIvU0BXQI4Hq2AG/S64OTcUlzDgJRVSFo/Zg0BjgsDRnp7Z183r
        7tLEZVmjyh5/uM5kb6r6/idWxM8Coy4JY5SEUQ16g6Heb9SjSg2wSLpKiRTV6+Kbaz8fCD
        GAEejq62btjXsuclbvhfCJKkgWLmIrA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB14CAC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 30/68] btrfs: extent_io: update num_extent_pages() to support subpage sized extent buffer
Date:   Wed, 21 Oct 2020 14:25:16 +0800
Message-Id: <20201021062554.68132-31-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
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

