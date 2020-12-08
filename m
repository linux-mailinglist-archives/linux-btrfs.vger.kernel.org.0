Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE58D2D2F88
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgLHQ0B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgLHQ0B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:01 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CF1C06138C
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:29 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z11so7254262qkj.7
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uKvPcsxjeyDkOX+k5ouYvcOYkRacPuRTIWcN48+peYU=;
        b=AUE3QbO41aKzocKM4tgbmKpioM9U7CIVy1dRMVLu1s/ApFFZKmB4Kcp0czojkY9+wQ
         PZcAvcACuqctqBnmIiQojKeuEU2CHe7QM+5mdaXN5Jr/XaJTgF5j3pRctEQKZYa9Kl3G
         FQQPMa0X4Qlzq6stXZ2+pepU5l3N7A37TU//WG0YMxChbiIEUIhVrZLEWZRrZL4FpvGS
         XnNN1Z77SLSCiVWg6mA3H/bjyeZB0fx5UQkzeWlxZhtpBI8EpLstztjbzvoFKcPO1bJe
         csC/pmh2HvhBlL5b1Wm7jqIA18NTg9gyIiwiV4o4udA+ccpvAw5KQNT2GNvr0v8oMMda
         peRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKvPcsxjeyDkOX+k5ouYvcOYkRacPuRTIWcN48+peYU=;
        b=aKYHOq3KB+qOU/IojCfwW4OQxq4dYIo1shv08V/SwrNdSzJrExDwDIpUTclYdBwWQL
         hnmLO95LTUSmh4s5FYpL51NieWZtdqrhvGACHf33aQIkQ0bkWLAlJj9yno+1pc33rUF0
         O9w/qCztGD9TalBmKD6//1xjayBUaU8gXh7RYMl1E6oDcSGW4xnNbvDKxGQbYbxYjt20
         JXSWl9zMNqU6p8Ldso+YG/NAAlSLF7tFtsUB3ZvOwIjS3fIcbXmty0pPuKA+xCGMc2iz
         Oeq7qq15dUblcxelsRPh5HJIEV+rXGapa0QS4tYWbF00tVS0rjM/2nyK4WROsYOzkO+E
         0xWg==
X-Gm-Message-State: AOAM5334Cc9addDk7frIcWXWKfi+KgXp6lxoXvprUPX+NLaSamyrDqh8
        WNVdkCm3NpIoXwrLkPqRyY8j4tAQtacyt/SI
X-Google-Smtp-Source: ABdhPJzlJpUCDdGpS5lhAjZDauGnOM4SQB6bMZC4qIdDEucyuYRZPhRmRGtek1DIJA++q0npZO1XBw==
X-Received: by 2002:a05:620a:148d:: with SMTP id w13mr29899128qkj.299.1607444727888;
        Tue, 08 Dec 2020 08:25:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k188sm14526383qkd.98.2020.12.08.08.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 39/52] btrfs: handle errors in reference count manipulation in replace_path
Date:   Tue,  8 Dec 2020 11:23:46 -0500
Message-Id: <a6f003b1fc29bbdd46b1a859efc63ed4196c9211.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If any of the reference count manipulation stuff fails in replace_path
we need to abort the transaction, as we've modified the blocks already.
We can simply break at this point and everything will be cleaned up.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 01085952059b..5ddd9e6e354c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1355,27 +1355,39 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
 				       blocksize, 0);
 		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_bytenr,
 				       blocksize, path->nodes[level]->start);
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_bytenr,
 				       blocksize, 0);
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_unlock_up_safe(path, 0);
 
-- 
2.26.2

