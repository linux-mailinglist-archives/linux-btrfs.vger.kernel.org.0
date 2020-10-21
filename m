Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D8C294820
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440711AbgJUG0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:42526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440710AbgJUG0K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ubi6dxuYF1ruxqVWZUNpXQle0M+Nuln4OPBkB7debVE=;
        b=If+RLOlWSlk9dT88xR0DBliVfzuP7hlMXRj2MHxFqcAKfC8lSM9u/KzPylnxR9xCsf8qtw
        vXUe2G5PyMPKEzurHsRwr2SKhfejt0EPEfSpF0rNO5c6/OFWJx3VS7fbA0eZVksuANXTzw
        gUkpLNdclkTI9Z1TTeugDIvYL/qJL2w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F894AC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 04/68] btrfs: extent_io: update the comment for find_first_extent_bit()
Date:   Wed, 21 Oct 2020 14:24:50 +0800
Message-Id: <20201021062554.68132-5-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pitfall here is, if the parameter @bits has multiple bits set, we
will return the first range which just has one of the specified bits
set.

This is a little tricky if we want an exact match.

Anyway, update the comment to inform the callers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a64d88163f3b..2980e8384e74 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1554,11 +1554,12 @@ find_first_extent_bit_state(struct extent_io_tree *tree,
 }
 
 /*
- * find the first offset in the io tree with 'bits' set. zero is
- * returned if we find something, and *start_ret and *end_ret are
- * set to reflect the state struct that was found.
+ * Find the first offset in the io tree with one or more @bits set.
  *
- * If nothing was found, 1 is returned. If found something, return 0.
+ * NOTE: If @bits are multiple bits, any bit of @bits will meet the match.
+ *
+ * Return 0 if we find something, and update @start_ret and @end_ret.
+ * Return 1 if we found nothing.
  */
 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 			  u64 *start_ret, u64 *end_ret, unsigned bits,
-- 
2.28.0

