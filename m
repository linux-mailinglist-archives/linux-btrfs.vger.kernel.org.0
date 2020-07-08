Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10992189A8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgGHOAe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgGHOAd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB38C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b185so30959003qkg.1
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eyMNWoi2hC8qlRuAY9xprTphnhdSNxjekwZC/C82Cw=;
        b=ENrQ6f5bqdC5bdr9UFbCNIUlZpnYO8mX1mkv0j8m8xLhMyZiuUKAaX8faMWYy4yYEv
         nYYxUrjbDJ0egAe+ya0nG24QBcbeCkrpbJ1yZJfFE9DMNslBGvgdOeEs40j3ET9oCVDy
         /VUknqw/BB22D988Wxzxy3ciiwnoSCaz0ZJlUAip3zVGzBeu7VJmtU8kQG8P7IV6MnVA
         kM2Gka0zfww3XJRd0DmbpVqOIDvjnMvbGAiiGEYI63O2XRoYNi59btW6L4Y7ft8SPM1p
         Gp0rC2qc/jnC00bbNOqsAFz+U4VC0uJVjd9QtUy8nGj21zZTbhAHKtQs/V69G6er6y4f
         g5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eyMNWoi2hC8qlRuAY9xprTphnhdSNxjekwZC/C82Cw=;
        b=Rw8bUeuLwpAVEL5S+ORKKkV4n90iB5yQtDVUVlukdmz94SmPOYAuL25roUDcpdBobT
         hXj6vKRkdBk7g4Dumy/FM47Wkrr8a50Z8tkRPMutHImVEEJZg1NQ9iGdEFqw6tgWspo0
         BApdqSisUa3G1pFy+EaWbq9FQwJcbYN4kRtfNU55K+IRXPyTqDU/1Tcv9dvaOCoKNCcI
         A9otQKDOe30Z8U+JyK6/s7bq9L7K6WrcTmB4C0qxrNp/f9kBo6Td+duHhjrp6+LePuXC
         6n8aVyXk0ymvwf0toAaQv/KIuCu+G1/7Kn/7KTpykw/sR401EwA7Rct5l1CXWnCa93ut
         MZwQ==
X-Gm-Message-State: AOAM531Qj/J1BwhHR+2Cu8X4Kt2nZvBmCjiAbBFu5eupzVkjp5Z+WfZI
        VLqV0LiePLmmvAiljjQD1RNHTnXKP3cWeA==
X-Google-Smtp-Source: ABdhPJz7LXd7niqIlG0WIB+4SieK+OBHw52+MivnKQvbkrvXBpG2Xoheh0pF/nBpKth9rj7t/WSjng==
X-Received: by 2002:a05:620a:4ca:: with SMTP id 10mr57955011qks.2.1594216832298;
        Wed, 08 Jul 2020 07:00:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z36sm22784847qtd.22.2020.07.08.07.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/23] btrfs: call btrfs_try_granting_tickets when unpinning anything
Date:   Wed,  8 Jul 2020 09:59:57 -0400
Message-Id: <20200708140013.56994-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When unpinning we were only calling btrfs_try_granting_tickets() if
global_rsv->space_info == space_info, which is problematic because we
use ticketing for SYSTEM chunks, and want to use it for DATA as well.
Fix this by moving this call outside of that if statement.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c0bc35f932bf..4b8c59318f6e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2844,11 +2844,10 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 				len -= to_add;
 			}
 			spin_unlock(&global_rsv->lock);
-			/* Add to any tickets we may have */
-			if (len)
-				btrfs_try_granting_tickets(fs_info,
-							   space_info);
 		}
+		/* Add to any tickets we may have */
+		if (!readonly && return_free_space && len)
+			btrfs_try_granting_tickets(fs_info, space_info);
 		spin_unlock(&space_info->lock);
 	}
 
-- 
2.24.1

