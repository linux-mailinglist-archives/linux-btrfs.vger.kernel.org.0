Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D375E2CC736
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbgLBTxg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389839AbgLBTxe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:34 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533D5C08E863
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:13 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so1996307qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OX6WrPTbzeZRdN+o3wHO9+qTtQHxTk57fWbzaJs7QH0=;
        b=Ym15HeGz8osURV7FfiqxpSaEpEbate4HMMyHMhB4HDNeOfL61uig0HQJuKCtx9fQb1
         OQMMj1G6Jj/Z8XFU8CghYF7XkOhcreN96Wc0xr+hu4McBQt3JkTSjXGpN+4EJjqqrR37
         ucNqzeUnAik3qrPIkBiL2zJZ4zkAiGx9k49Aq8ACM7uvNtzxMz1JRAG/NQ4cUcVPm0KC
         7I/MoaJHzLmikXa1EJNz0YPMPGCsMCcHlFQmELj1JQGv5Qy//ep4777ZIn4bYct0qJFA
         lfrXv2RlJKRrCT7UjoMHR/zuVeZu0zDpo633bjocLzstPGPpUqIX3KihA9fKrArb8igl
         pihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OX6WrPTbzeZRdN+o3wHO9+qTtQHxTk57fWbzaJs7QH0=;
        b=axYuwTiCPLm+Z6N9dxnRk3z1UvLkCSVzR6Jq1mGt80LtwlgPFV8q7xcstP/0pl8W2C
         3e9QHa9LdqF3OSRUcJvXS3pbSTnYUrClxhlaP6ORsXqCDI+MpAjF0k6x/cEQlZl020Jw
         GbEj8EWSlOoDQOzBGavvbweBG5AH0TqHDKi+4a/sXcjsJpdg/6EN4m7NzUZYACn6bTwT
         MkYuUkc2s6EaUaZkBMskPawJtFokjvOOstNOzPjYmNFBjJKaiH55XnY5Yy9vDpf9wmdR
         hSrG4E0iyxslT5WAa9TklZkzzDPGYfrs6YoovTgGG8MaWa/RQj2LYP4VnwzPFq1q+5aB
         dcuQ==
X-Gm-Message-State: AOAM5339xBgnEFcRv0Fht9YiK/XEixdMr5oUBvpGvQLSqLFiSdVToAI4
        d9xkJtfnUioj75J3V5J1pOI74H92WuHm/A==
X-Google-Smtp-Source: ABdhPJyvKxfSxIdP1BRYAAR2Mu90rk9g9wmfuETIEt94eXalWY0g0Sx0W5/PQ9yTHMxUiswSa/ri7Q==
X-Received: by 2002:aed:2bc3:: with SMTP id e61mr4370910qtd.276.1606938732158;
        Wed, 02 Dec 2020 11:52:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u72sm2995129qka.15.2020.12.02.11.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 32/54] btrfs: change insert_dirty_subvol to return errors
Date:   Wed,  2 Dec 2020 14:50:50 -0500
Message-Id: <da3a65166a31486f406abe32336b2fa55d19eac7.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will be able to return errors in the future, so change it to return
an error and handle the error appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c9df05f02649..6b2d7168f98e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1556,9 +1556,9 @@ static int find_next_key(struct btrfs_path *path, int level,
 /*
  * Insert current subvolume into reloc_control::dirty_subvol_roots
  */
-static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
-				struct reloc_control *rc,
-				struct btrfs_root *root)
+static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
+			       struct reloc_control *rc,
+			       struct btrfs_root *root)
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
@@ -1578,6 +1578,7 @@ static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		btrfs_grab_root(root);
 		list_add_tail(&root->reloc_dirty_list, &rc->dirty_subvol_roots);
 	}
+	return 0;
 }
 
 static int clean_dirty_subvols(struct reloc_control *rc)
@@ -1779,8 +1780,11 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 out:
 	btrfs_free_path(path);
 
-	if (ret == 0)
-		insert_dirty_subvol(trans, rc, root);
+	if (ret == 0) {
+		ret = insert_dirty_subvol(trans, rc, root);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+	}
 
 	if (trans)
 		btrfs_end_transaction_throttle(trans);
-- 
2.26.2

