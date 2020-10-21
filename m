Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7C294839
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440781AbgJUG1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:43704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440777AbgJUG1E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZs56ZrWz1mX7a6TkMnY5loO3liu+lj87R4D6B7Q+uU=;
        b=O8D0XuSb9p/CvuXgyK1sO5zMHBVmPDhxsbCqpDtrZndfuZTlozfCVZ7GHOsoDlEtuOeI0/
        NfiTYkjPy05pN+zla1Ir2PA3Y+dbkN1QtLgA3l2o7QJGMaskaCeq0Eb8j4W3kP+He4as6n
        o7uSZer3/IX1k2brt6TT+cKlhzeTqTs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8758AC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 29/68] btrfs: extent_io: don't allow tree block to cross page boundary for subpage support
Date:   Wed, 21 Oct 2020 14:25:15 +0800
Message-Id: <20201021062554.68132-30-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As a preparation for subpage sector size support (allowing filesystem
with sector size smaller than page size to be mounted) if the sector
size is smaller than page size, we don't allow tree block to be read if
it crosses 64K(*) boundary.

The 64K is selected because:
- We are only going to support 64K page size for subpage for now
- 64K is also the max node size btrfs supports

This ensures that, tree blocks are always contained in one page for a
system with 64K page size, which can greatly simplify the handling.

Or we need to do complex multi-page handling for tree blocks.

Currently the only way to create such tree blocks crossing 64K boundary
is by btrfs-convert, which will get fixed soon and doesn't get
wide-spread usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 37c721294ffe..6f41371290e2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5298,6 +5298,13 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_err(fs_info, "bad tree block start %llu", start);
 		return ERR_PTR(-EINVAL);
 	}
+	if (btrfs_is_subpage(fs_info) && round_down(start, PAGE_SIZE) !=
+	    round_down(start + len - 1, PAGE_SIZE)) {
+		btrfs_err(fs_info,
+		"tree block crosses page boundary, start %llu nodesize %lu",
+			  start, len);
+		return ERR_PTR(-EINVAL);
+	}
 
 	eb = find_extent_buffer(fs_info, start);
 	if (eb)
-- 
2.28.0

