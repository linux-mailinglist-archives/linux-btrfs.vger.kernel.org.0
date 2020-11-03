Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CEC2A4691
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgKCNcJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:45012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbgKCNcH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwQuGuj1U64B+G/fFLU0un5TBjZDvgox1uEiCh9kmqA=;
        b=XRwoGpp3eSnSJw9Ps80Ess5Z71rRy4eY/Irk/9XI/4zSAStCnLFpb2IYZNTAbBZQW8rcmh
        5OWygOW7qM5w9V5CqDBtdt0DvIauaV/tCsD6rRju/WdnpM04S5s+bM5qKlBzCc11CjhPkH
        WWwselQyAgTDj7K9THSSEUiQOtB86Eg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A661DAF95
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 18/32] btrfs: extent_io: update num_extent_pages() to support subpage sized extent buffer
Date:   Tue,  3 Nov 2020 21:30:54 +0800
Message-Id: <20201103133108.148112-19-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
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
index 123c3947be49..24131478289d 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -203,8 +203,15 @@ void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
 
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
2.29.2

