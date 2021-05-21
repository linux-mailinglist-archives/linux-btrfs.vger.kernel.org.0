Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEB238BFC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhEUGoU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:44:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234441AbhEUGny (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:43:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621579267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5L+CbCEacPDaeqbln1oS/6uiCaNyI132WrCSbJfyAg0=;
        b=Xe8xiv3fe/GITfXoATcRXzc3be6BK7zojcY3A0c+KxoVJO0e2XHZkLIDwB1uf94kFGyOF8
        DUoJI5kD8KgZxA7eYH71mrYeMrUzGywDd8aJ1cdXWj8sNEixrLAU4kBno5syBE1W9bFSyP
        yz/IcxGumEI6VrEg5MLBaKwqftK7XJY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFC52ACF4;
        Fri, 21 May 2021 06:41:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 07/31] btrfs: make end_bio_extent_writepage() to be subpage compatible
Date:   Fri, 21 May 2021 14:40:26 +0800
Message-Id: <20210521064050.191164-8-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521064050.191164-1-wqu@suse.com>
References: <20210521064050.191164-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now in end_bio_extent_writepage(), the only subpage incompatible code is
the end_page_writeback().

Just call the subpage helpers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 30bbd1b08c8d..d16c84430981 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2853,7 +2853,8 @@ static void end_bio_extent_writepage(struct bio *bio)
 		}
 
 		end_extent_writepage(page, error, start, end);
-		end_page_writeback(page);
+
+		btrfs_page_clear_writeback(fs_info, page, start, bvec->bv_len);
 	}
 
 	bio_put(bio);
-- 
2.31.1

