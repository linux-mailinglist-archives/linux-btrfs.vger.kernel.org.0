Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E2636CF25
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbhD0XFY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:37092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238340AbhD0XFY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RYKfcMEbnTIo/ahzpQ3UoteJ5fVMe11mJ4LHTr2PGIE=;
        b=ZSXazjCAT3U49s4WlwwzAUfWCYRpAhcTDWJFMxVdFL9beXnUCNg11d6PQibLxWa728QaEk
        0NhPe8TSgA131JQOGAfOWVqcwNLlZbIP8ijeokYiGUt1DuVke48JbfEwfz/CXOkML0ZQus
        svjLMVmWD/mwHw72H/Ef6dAD0dkspDg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2676ABED;
        Tue, 27 Apr 2021 23:04:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [Patch v2 20/42] btrfs: make end_bio_extent_writepage() to be subpage compatible
Date:   Wed, 28 Apr 2021 07:03:27 +0800
Message-Id: <20210427230349.369603-21-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
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
index 850b3c3dc40c..fc69ed998b9d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2811,7 +2811,8 @@ static void end_bio_extent_writepage(struct bio *bio)
 		}
 
 		end_extent_writepage(page, error, start, end);
-		end_page_writeback(page);
+
+		btrfs_page_clear_writeback(fs_info, page, start, bvec->bv_len);
 	}
 
 	bio_put(bio);
-- 
2.31.1

