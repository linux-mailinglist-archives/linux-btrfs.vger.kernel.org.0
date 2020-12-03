Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7210F2CDD72
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502003AbgLCSY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501981AbgLCSY5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:57 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363D0C061A4F
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:51 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id b9so2072941qtr.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWlZsEARxMqv1Xgx8gX5c3Cln+ZPxSohBZjzdTTjAUQ=;
        b=y8yJi5Mzff9hMBpmaa4OvuvU3Jzt09UXQSnuGfCtjY7P2/i/1WAirSvOM7VgVnHM94
         RX6vlG78fj8uIsXjmm0EXfGx8CziSVsYDtuRcZdSVg/ze75WCco/Tw5mCKLIhPrgHhUk
         AHo9uk7NuMgjyCPXRt+lc/A+6miERgZuOQJfAyx9VJYCh9VxGI9hURh6/HahKTEhDU7q
         rHj6i3mWiPuUuEMEk6BaXBSf3dgGMifmUKKLB/vgDQ9VDHTABA8ZiG4RoJgkrGAeTH8+
         PXuzHqcUSpm64ywMIUQ7dg2yUFXtk78PXgWBavYslqA3Ylop60HdMwy0GRiBiS2BhoPY
         9pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWlZsEARxMqv1Xgx8gX5c3Cln+ZPxSohBZjzdTTjAUQ=;
        b=HSdSZlUAbOq2VixCSKln5HLYAq8Pt7+cGUTBSWSPMX9ND6fm4xxfuOhytyAAgaMqDL
         uoytMp7aVy+BRdWQ9CAJ5vjOCk+ZSTl/TvxFNddvnxQy7PsDINvS75EpQVgR69zMg3gS
         BIaTfW+DIbbg/SGLwKMgQIxMzEpAAHiDycvxsGR21Nq/3lV3F5wL5VhpJuRUJVR9I9sL
         X0+M8RhB0P4AwtZbSyn8BVg42EaT1eHRKi7YhyHHLQIUQ7mbgrlKI0HCahyYTOxayKgQ
         6UnfW1mJ+PluPRLO6YIczhAvvyQglynYgZ2a12KzqZe4xZV6CPLRwXElvB0uzp0X/XWq
         XhZA==
X-Gm-Message-State: AOAM531fNZncHLLRLd3F/bttQ6lkBWDe6FYU2fk4g+8iAOGOr2gJFJlC
        +G9ecj3rtgedgyoZlcnHEk+3238daKK78GVJ
X-Google-Smtp-Source: ABdhPJy/1C3bLS+WItZ/+jSYZa8Jil/70Py/pTMUS4qOr/3SdmhB3EsnYZXQ5WNCN2Svw3xeJ1eeiA==
X-Received: by 2002:ac8:710c:: with SMTP id z12mr4578643qto.38.1607019830166;
        Thu, 03 Dec 2020 10:23:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n21sm2235540qke.21.2020.12.03.10.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 28/53] btrfs: do not panic in __add_reloc_root
Date:   Thu,  3 Dec 2020 13:22:34 -0500
Message-Id: <7426d987d831d4a6a95510c9f94f2bbbf633e14a.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have a duplicate entry for a reloc root then we could have fs
corruption that resulted in a double allocation.  This shouldn't happen
generally so leave an ASSERT() for this case, but return an error
instead of panicing in the normal user case.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4356af112025..a68ae34596d2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -638,9 +638,11 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 				   node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node) {
-		btrfs_panic(fs_info, -EEXIST,
+		ASSERT(0);
+		btrfs_err(fs_info,
 			    "Duplicate root found for start=%llu while inserting into relocation tree",
 			    node->bytenr);
+		return -EEXIST;
 	}
 
 	list_add_tail(&root->root_list, &rc->reloc_roots);
-- 
2.26.2

