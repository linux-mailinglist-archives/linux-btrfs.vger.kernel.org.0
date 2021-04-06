Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F323549B9
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 02:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbhDFAgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 20:36:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230309AbhDFAgV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Apr 2021 20:36:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617669374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nfTpzfjS8nkmMI2kJ+MPHBNeyAwPXegtCcxfPasDAQ=;
        b=JkWVvfIP2ZAU0+qUTS8HIjF4yN2is+/ZXlUli9hJvGvW9D3G0sRAQhon7Iz8czUUA2Smbg
        6HxR1QFiPdX3Q/HPuwsoWOMGB3dxBa9TzL3muIGOgQjoWGtZhRQRdim5w+dGYFcfDeNA+6
        la6/X4gFCquPWAqZJK1khf5B4ZmAyuU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3D037AF27
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Apr 2021 00:36:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: make lock_extent_buffer_for_io() to be subpage compatible
Date:   Tue,  6 Apr 2021 08:36:02 +0800
Message-Id: <20210406003603.64381-4-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210406003603.64381-1-wqu@suse.com>
References: <20210406003603.64381-1-wqu@suse.com>
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
index 9567e7b2b6cf..db40bc701a03 100644
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

