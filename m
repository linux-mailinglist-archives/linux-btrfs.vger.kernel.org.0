Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4EF151150
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBCUuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:07 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35646 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgBCUuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:07 -0500
Received: by mail-qk1-f193.google.com with SMTP id q15so15722220qki.2
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CqlQ+xIK7uCjEFWEpcuz4GpwHIQIDsK61mty1vnlTY=;
        b=S61F3z6O3xdBcbo9Xn/B9J0melEvUbjF0qeG1QlzaTETNCXlh7px78TD0WJBqhTe50
         ntul38RMtz8JC1x40TEQq73zRIXD/SdnK6oNQmT47cV8Bwyi/Uyxi2DuJq+CB6YlYikP
         mVHLMfzOwblLfL+78y5bHq1DSF+p1R+8VXGK/jNLzvdRXAQX47kfXxGHKeZ8rLlIARn8
         ooD8VPwsnhs0W35l1UMo3N0TlZETwqCK2X8HoR0GXFh/qBWJO/w0/xd7Zsho9sg0yzM9
         jNk8Yh50RSpGznhAgXMgoqd2xjT8Obj3Iui53YAGo8yAod/lg71UjFEfzw+f38GhOxCL
         tFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CqlQ+xIK7uCjEFWEpcuz4GpwHIQIDsK61mty1vnlTY=;
        b=p1wuZodyjWAO30OEYciYWptFU/qGiAGnO7Xl+rPogHAVQCO58VsBgMafFXJZNN1gkT
         mlA4eFL1CAUpG3cR3AFpdMo10wJb2Fkqg1MGN5tVQou5W4kcEq8xrNMvyUhdjYuMZcqm
         rh8o9vV36x/LFeZ56cI3/aWamdn+jpT5x5ke3Y7xya+xqPYffwsqnMIBH46ZRffKuS+7
         wr/uehsFblwl5QWtCr9cDaQkNvc2ZMvqOxgskf1+Gt9Q/NJTz7SK/IWTZ1t98YNPeAmE
         DVChbOeoZufnizSYy49gulp4I9qBRUN7FNhhhtnn3Z7KPzVG4RVWFCqQSVBvs+mv0//E
         E8Iw==
X-Gm-Message-State: APjAAAV7cv1jaZKoh3fa6HtOCfN+F0vtbw2G9YdxeR2QFOAh3xtrxWkE
        2aafThbOyRqIp0IRicIR24PL1kqtp1SRQQ==
X-Google-Smtp-Source: APXvYqx/jf4yad/EBzkFpHFNYxnCoGfm22xW1ced62Pw5evNKbyXB+8HbDkPsoc7GwTQvLR5GMmX3g==
X-Received: by 2002:a05:620a:62c:: with SMTP id 12mr25158854qkv.154.1580763005904;
        Mon, 03 Feb 2020 12:50:05 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k17sm9699861qkj.71.2020.02.03.12.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/24] btrfs: call btrfs_try_granting_tickets when unpinning anything
Date:   Mon,  3 Feb 2020 15:49:34 -0500
Message-Id: <20200203204951.517751-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
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

