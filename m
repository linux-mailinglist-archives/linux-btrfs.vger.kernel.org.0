Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3D2360163
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhDOFFz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:37624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhDOFFx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=os9jyHCHUeko5F8xNeVFj1K43y+9eJnMflYLrOLcLps=;
        b=ZnXASakTi7Mrg2+s3W48okKj65fxaSUfL6T74IRywngENHqufpAjV3ojIduPAsWMDV+bP1
        dabSpBdf+ADwMJhjCiprpKFjVyzv8/KHZPcBFW/21PlqS/CVjnLoj10/jAYtwtgcvXWjs1
        i0sVfqO6jfLIH3GgQ9GSyBxuYiCxFlI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F4DAAF03
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 20/42] btrfs: make end_bio_extent_writepage() to be subpage compatible
Date:   Thu, 15 Apr 2021 13:04:26 +0800
Message-Id: <20210415050448.267306-21-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now in end_bio_extent_writepage(), the only subpage incompatible code is
the end_page_writeback().

Just call the subpage helpers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f40e229960d7..da2d4494c5c1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2808,7 +2808,8 @@ static void end_bio_extent_writepage(struct bio *bio)
 		}
 
 		end_extent_writepage(page, error, start, end);
-		end_page_writeback(page);
+
+		btrfs_page_clear_writeback(fs_info, page, start, bvec->bv_len);
 	}
 
 	bio_put(bio);
-- 
2.31.1

