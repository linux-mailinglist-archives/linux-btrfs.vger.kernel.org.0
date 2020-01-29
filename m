Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7BB14D406
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgA2Xur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33831 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA2Xuq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id d10so1233612qke.1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Hl2l0+VoHss/h2G5FXNggnkvQknISVejfVvgKx0Oxbs=;
        b=N+nzprePnONFhtqtqx3FNrgrpqR+kyvrelvrVsm3z5QCy5gTppaNsAQKyiwy23Rbp5
         iCP6S9Boc1MCPtr2BPvmeHYo25FvC/0hMXnKvB6EmhKqGb7+OFIbrA6gfY7wPQ5+nl/t
         WCpOduOKLnsTiLWx5kKnBX4J3Hrn9L+Ucoc7gHvZmXO7wI3oGdurkmx+zHcOVeoT0/yb
         /4Gf0Hx7gnXQBGvsKHzQJTUHQiV9/uldZjzmVaqbhL1q1tPNUCa8PIimX3j1VkNiYOx/
         adLpww/pM+Yp20qtMlJkPytgN7ZrlN8vuxqDhEA6O/DjxgArdp+21Jgd1ILUPsg5HPnl
         CaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hl2l0+VoHss/h2G5FXNggnkvQknISVejfVvgKx0Oxbs=;
        b=QeUBGP5Dod6gArgX0RmFGwi/YFaLrspdrOyLJULP7UTT8q4C0el7l+mRQaqGwrxQRU
         6W4fVfxDOy85L4E72DiKXg1dZ2PuRnLU3WXt55KrbMUxsjjnxZymuDssdnIfPxXDNdQ4
         45SjKVtJOdK6D9M3TTrw29i1UYOoMDETfJB1nUja5oDVySVbcD00W/MUHjsHwazXzLlc
         QHDwDGLni58Pv5WO7us3JgxVrdJkX1wgsyLCXXzcL27hEfCs3gJOOTPxOEs247b+Lgje
         m3A0JykoXaA7rjQYKn8xv7Nw60nTo5cpk9yjWBdHZ/0+5a1Lnasq+9cmF6BUJpNqYLRG
         nbiQ==
X-Gm-Message-State: APjAAAX1d9iaHEPjZPP0LHyIB9f/BrLf3DszTWveBbpzKjddjT9mJ8eM
        Y1LfuVEsHK+/zIqTZIEkG6LD6qUso+v2NA==
X-Google-Smtp-Source: APXvYqzPiXgXCr4tHN2S2lVxIYwX0UpGFh2YwazodajessAezZxXwV0wxyA1Juhei4CjxlHXN5b+Lg==
X-Received: by 2002:a05:620a:791:: with SMTP id 17mr2486845qka.31.1580341844747;
        Wed, 29 Jan 2020 15:50:44 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l49sm1967426qtk.7.2020.01.29.15.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/20] btrfs: add flushing states for handling data reservations
Date:   Wed, 29 Jan 2020 18:50:14 -0500
Message-Id: <20200129235024.24774-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the way we do data reservations is by seeing if we have enough
space in our space_info.  If we do not and we're a normal inode we'll

1) Attempt to force a chunk allocation.
2) If that fails we'll flush delalloc, then commit the transaction, then
   run the delayed iputs.

If we are a free space inode we're only allowed to force a chunk
allocation.  In order to use the normal flushing mechanism we need to
encode this into a flush state array for each flush type, so add the two
different flush types we'll need and add their respective states that
are valid for trying to make a data reservation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      |  2 ++
 fs/btrfs/space-info.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6afa0885a9bb..865b24a1759e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2526,6 +2526,8 @@ enum btrfs_reserve_flush_enum {
 	 */
 	BTRFS_RESERVE_FLUSH_LIMIT,
 	BTRFS_RESERVE_FLUSH_EVICT,
+	BTRFS_RESERVE_FLUSH_DATA,
+	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
 	BTRFS_RESERVE_FLUSH_ALL,
 };
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5a92851af2b3..066471c0f47c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -854,6 +854,17 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	COMMIT_TRANS,
 };
 
+static const enum btrfs_flush_state data_flush_states[] = {
+	ALLOC_CHUNK_FORCE,
+	FLUSH_DELALLOC_WAIT,
+	COMMIT_TRANS,
+	RUN_DELAYED_IPUTS,
+};
+
+static const enum btrfs_flush_state free_space_inode_flush_states[] = {
+	ALLOC_CHUNK_FORCE,
+};
+
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket,
-- 
2.24.1

