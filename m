Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1377E360152
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhDOFFV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:36826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhDOFFV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZrmMAYrf1U/Utp97PJEzrw25aOlnfZvLWrJ1thAp8K0=;
        b=Vf8JlMw1ffprL0EXQlR6KqInP0EjfqiUDQOLJpEMnHnpsX/2VGVwgOEjX3DBXt0KEZc/aJ
        D/saCYIDuNN2KTW2JopW4Bu3oglqoStAmo9LiSLsutF7YCFQYRuzwIRA967rxaIEk3TCfv
        mTLffLuwONKAxQQpIj/ouK4eYdCXCdc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28439AFC9
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:04:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/42] btrfs: make lock_extent_buffer_for_io() to be subpage compatible
Date:   Thu, 15 Apr 2021 13:04:09 +0800
Message-Id: <20210415050448.267306-4-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
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
index f32163a465ec..c068c2fcba09 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3967,7 +3967,13 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 
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
2.31.1

