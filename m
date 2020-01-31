Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999E214F4D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgAaWgb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:31 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39101 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgAaWga (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:30 -0500
Received: by mail-qv1-f65.google.com with SMTP id y8so4051127qvk.6
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5ZEakxJOYOrx3rWdH/AtGjR1lP2wcMDdRkL7MIN6FI=;
        b=YPmYPC6e70U9U2uaYGqD9Y5HRDIXEfX5qi7bnSfAG/WqifbLy/F8ykwQBnqflLg8UK
         PuSgG9UaepdvTea8SNdNuGQB8K1HPfXxzo3L0ZF4xER/IbP3uHF57l486LvDKqzmSSOW
         Q868qLb6FOL7suLsVaXWFBWGm0rZ3BzBOjB6vq0PWm3FgEkgQcgecibsy6mj3quVAf/k
         aeeZBDE62/MTCV4dvCrCwTRXDX/glvIrxvSrPSY4Abs4uDBSIfig32n2n8W0Jk2ld6Dt
         pQmi3Nrovyc7GLWPdDxEz0g2l/n+Bkemp/1aDMZ5Yy++gYtBn2KvjtFZTsWbkAv7s8lJ
         uO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5ZEakxJOYOrx3rWdH/AtGjR1lP2wcMDdRkL7MIN6FI=;
        b=HQz6YCxZ0rTASAQQnIwDAe+pApmpOPWSp8MYteI4o/M9vlp4PdurXDa0FyGHyRonWv
         lLIvwMCI/p+qy8sbeZrE3/zUQnWkcYqdgBzhzFRcJ+6gmLeJK/KC1JE2GOFGt2ZMNau8
         lrOxy6NWkWpGkai6hz7Q61lN9SRkbbaX/2xDuKaDKpcVsc0x8Vu7xNTQQt9+d/g/q5YD
         pi0EsFNFqQ+/1LS7VpvvdFvdh/GnaM5PjuL6zy4U2i5RRxpO5f1I++w+HIIzbKaB7h7z
         ZGMD1pCB2mUdM/RKDU2swR5U1/2Ef1uyZYjkVbtygHw42+YCBbTD4wIvn5olRIpwqg73
         mHMg==
X-Gm-Message-State: APjAAAVLTg3R1ANneVxvRH/Fjzp5vCxxYP0LYcyFm2Flz/2gHsgV4lHV
        c4PcYw+xlo/KpmpD5ArhvH7RT7upTZY5Iw==
X-Google-Smtp-Source: APXvYqyLoa6EzEoPQLAyRnbVKswlYMQzHmo+L6jmFYhHpRRTfqxWopa3Q7u5uHWRta0DrcOXYkSXgQ==
X-Received: by 2002:a0c:e150:: with SMTP id c16mr12686850qvl.51.1580510188995;
        Fri, 31 Jan 2020 14:36:28 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g53sm5808344qtk.76.2020.01.31.14.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 07/23] btrfs: call btrfs_try_granting_tickets when unpinning anything
Date:   Fri, 31 Jan 2020 17:35:57 -0500
Message-Id: <20200131223613.490779-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
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
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0783341ef2e7..dfa810854850 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2885,11 +2885,10 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
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

