Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2336914D40D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgA2Xu6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:58 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33360 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgA2Xu5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:57 -0500
Received: by mail-qv1-f66.google.com with SMTP id z3so636270qvn.0
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yVV1Yzsb5QJ2MiIdPvwF9GhDEbF721+Au4Sn/GkPRnY=;
        b=o3nxGcmUQZe+5xGbM+sa1zP95EEeTYno5lwc8EjFsWgBrNNZN2SmF23prBaYhHFd9H
         ka8QNenl/l7rm2TjEWRSkI9PTvxbsOgvbk5nw9/H+1iKps4X5PWoVfflyJDe03/qwn0w
         7bCIdtxF187ZhaAAdTbTYkbrjKWzNnr8ZA4pSOwI3Hj1DYJcMaxDeIse08KgYRicY04k
         aGvHkTY6URhsWiBg28YQkDcpd14s0bRPRQvAAJW61GPf/ZKHqPI36+40GFCuNH5KIbIg
         m7aR52GybTLCiXhYmVsgTPBV2QIKZ5prO9ZRRTiC7TnbPBwcE6eB6zKPAEZ/P298Z12G
         LYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVV1Yzsb5QJ2MiIdPvwF9GhDEbF721+Au4Sn/GkPRnY=;
        b=pN6nBssWLLyVsPJgDzEcfCniFnzun5J9hW+Fc+D2Mgn3PkoO0wKHBPKyy3D0O9UXa9
         IKrZiRfBKBDcH6DZGnnvK9i3NMV5hHeioLLDGxfcQcFgw2yJmj9OeCm2srhQ+OZu8jhW
         lX2Tr3xe0ACHPYP8MJ9N4kPrSAiWiHq+tKaPkKu52COToBeUDGNwCwLmFcRQBw1lyQCs
         kL5QQiKOq8k99QdOQDwj0ik+2q5R0k20NTknsuJotdqIC6613is5JcLBhkOhKGVZNn/W
         ovVCYa7a5LYOb8wrQJ66LyWFbp/ZveUuyzW2SAAEDDbuoD6bsAF2Qb2OVmuP5Z/5UnVQ
         M7bw==
X-Gm-Message-State: APjAAAX0RHZGCSV8RlYDbaP/LItyeeWbQtdCCzos+4CnBr/SX2vR5Kc+
        uqMF3V5xki3QgpvquN645zp5m1PshbB44Q==
X-Google-Smtp-Source: APXvYqxS8durVE9qgUYZqOPtCwhzzvQ5SXLsi8/WA7S8kTDSuArozb88gVNWJu8QbQ7C7+4yKlq7hg==
X-Received: by 2002:a0c:fa4b:: with SMTP id k11mr1773960qvo.55.1580341855774;
        Wed, 29 Jan 2020 15:50:55 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 63sm1837561qki.57.2020.01.29.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/20] btrfs: drop the commit_cycles stuff for data reservations
Date:   Wed, 29 Jan 2020 18:50:21 -0500
Message-Id: <20200129235024.24774-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was an old wart left over from how we previously did data
reservations.  Before we could have people race in and take a
reservation while we were flushing space, so we needed to make sure we
looped a few times before giving up.  Now that we're using the ticketing
infrastructure we don't have to worry about this and can drop the logic
altogether.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7a401f1c3724..a456139c698d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1187,16 +1187,11 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 {
 	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
 	u64 used;
-	int commit_cycles = 2;
 	int ret = -ENOSPC;
 	bool pending_tickets;
 
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
-	if (flush == BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE)
-		commit_cycles = 0;
-
-again:
 	spin_lock(&data_sinfo->lock);
 	used = btrfs_space_info_used(data_sinfo, true);
 	pending_tickets = !list_empty(&data_sinfo->tickets) ||
@@ -1214,15 +1209,12 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 
 		ret = handle_reserve_ticket(fs_info, data_sinfo, &ticket,
 					    flush);
-		if (!ret || !commit_cycles)
-			goto out;
-		commit_cycles--;
-		goto again;
+	} else {
+		btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo,
+						      bytes);
+		ret = 0;
 	}
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
-	ret = 0;
 	spin_unlock(&data_sinfo->lock);
-out:
 	if (ret)
 		trace_btrfs_space_reservation(fs_info,
 					      "space_info:enospc",
-- 
2.24.1

