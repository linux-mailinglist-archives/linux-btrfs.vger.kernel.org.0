Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFBD151162
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgBCUug (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:36 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36259 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgBCUuf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id w25so15706221qki.3
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O55hemAnFvSr6eUz3Nywbnvil8ZeELvinokrtnNZaa0=;
        b=rUw9ZUCaoQRh8mLLR9hRuFrSbBem/iV6qrqJyHXSTTrSBGSm4NuovoZwV6Htf0HvPS
         eALcOqhwxE5jbXzP+ruFz99Gm1XikWYA+kMw0cVL452g3HrQYrmkeVrZuegeZr5AEWsF
         Im4iOWOBt4soehc0JSgJbBApE+iwycSL+6apaM3VcAgbmepS80QAfppjN8vUdjOAtrDy
         +waojjZwEzC/5ar6zIovRcaeLbQ6rZ80MdW61HTKpIk1kNqDXe7nulF08TYU7z5oogu2
         EKkWFXy7FJA+b3qE0+4Jh6/iCszpzI/+IhKzR/+v0OmBmfavbLJKUH5iyoXufXqua1qn
         HVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O55hemAnFvSr6eUz3Nywbnvil8ZeELvinokrtnNZaa0=;
        b=HXF6ydFawmVp0dj6IfmxBhdA+ukl7rqaLFKaDCBaAK8IL2115W/Z2pVvCvWpx2nmyX
         f/mAK0Q7qdPN/PEg+lCY0q5F14lI05nswddh5QfA6z/297u0oEVm9f5ZHZjFOjeylCn9
         qIdPHY/LmdhtbJq0qjIMZRAxKagn4mjER0Gpxa3VuzQYPsLcTUEg0PDVP5w9AdhEbZUc
         E0SA8mxFTNlYXVhjzDccj+rAF49e4qDIFcK4DJB7Nl7u8Zj/Zs6pIEp4H7jfJlnGLRTD
         EVZwbRQrFeIXdykHPqch64WC6+aEgPtHFoA7u8XzbIfTppT0cBQbnHJzYX4pgaypTJFF
         Qi5g==
X-Gm-Message-State: APjAAAWhLQikj9McxYP70AtTIyYEUfUOLNsgVuuu/G/QRYkuscUqNHoy
        RS7wJ7w/jtuWoYF3IG00NkKBnRmQLGRzdQ==
X-Google-Smtp-Source: APXvYqwRCAPSsZQGW1prEK7IEkEOHvfrqebknPSPukiIV+PC7lueuIywdouAVWV161RyxlMM/Ii89Q==
X-Received: by 2002:a05:620a:ce5:: with SMTP id c5mr24592542qkj.49.1580763033697;
        Mon, 03 Feb 2020 12:50:33 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s1sm9576181qkm.84.2020.02.03.12.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 24/24] btrfs: add a comment explaining the data flush steps
Date:   Mon,  3 Feb 2020 15:49:51 -0500
Message-Id: <20200203204951.517751-25-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The data flushing steps are not obvious to people other than myself and
Chris.  Write a giant comment explaining the reasoning behind each flush
step for data as well as why it is in that particular order.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 18a31d96bbbd..d3befc536a7f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -780,6 +780,52 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	} while (flush_state <= COMMIT_TRANS);
 }
 
+/*
+ * FLUSH_DELALLOC_WAIT:
+ *   Space is free'd from flushing delalloc in one of two ways.
+ *
+ *   1) compression is on and we allocate less space than we reserved.
+ *   2) We are overwriting existing space.
+ *
+ *   For #1 that extra space is reclaimed as soon as the delalloc pages are
+ *   cow'ed, by way of btrfs_add_reserved_bytes() which adds the actual extent
+ *   length to ->bytes_reserved, and subtracts the reserved space from
+ *   ->bytes_may_use.
+ *
+ *   For #2 this is trickier.  Once the ordered extent runs we will drop the
+ *   extent in the range we are overwriting, which creates a delayed ref for
+ *   that freed extent.  This however is not reclaimed until the transaction
+ *   commits, thus the next stages.
+ *
+ * RUN_DELAYED_IPUTS
+ *   If we are freeing inodes, we want to make sure all delayed iputs have
+ *   completed, because they could have been on an inode with i_nlink == 0, and
+ *   thus have been trunated and free'd up space.  But again this space is not
+ *   immediately re-usable, it comes in the form of a delayed ref, which must be
+ *   run and then the transaction must be committed.
+ *
+ * FLUSH_DELAYED_REFS
+ *   The above two cases generate delayed refs that will affect
+ *   ->total_bytes_pinned.  However this counter can be inconsistent with
+ *   reality if there are outstanding delayed refs.  This is because we adjust
+ *   the counter based on the other delayed refs that exist.  So for example, if
+ *   we have an extent with 2 references, but we only drop 1, we'll see that
+ *   there is a negative delayed ref count for the extent and assume that the
+ *   space will be free'd, and thus increase ->total_bytes_pinned.
+ *
+ *   Running the delayed refs gives us the actual real view of what will be
+ *   freed at the transaction commit time.  This stage will not actually free
+ *   space for us, it just makes sure that may_commit_transaction() has all of
+ *   the information it needs to make the right decision.
+ *
+ * COMMIT_TRANS
+ *   This is where we reclaim all of the pinned space generated by the previous
+ *   two stages.  We will not commit the transaction if we don't think we're
+ *   likely to satisfy our request, which means if our current free space +
+ *   total_bytes_pinned < reservation we will not commit.  This is why the
+ *   previous states are actually important, to make sure we know for sure
+ *   wether committing the transaction will allow us to make progress.
+ */
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
 	RUN_DELAYED_IPUTS,
-- 
2.24.1

