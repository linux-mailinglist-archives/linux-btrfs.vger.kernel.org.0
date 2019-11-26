Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5910A208
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 17:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfKZQ0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 11:26:06 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43780 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfKZQ0G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 11:26:06 -0500
Received: by mail-qv1-f67.google.com with SMTP id cg2so7516481qvb.10
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 08:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/v48BqSH25XHYPmF+K+A4MAsa5+VWC3bWHsnb4vttJ0=;
        b=j4RfC3F0ujoLUNKrUpKrTYppNNqFm1FEwMnW1C3gqJlpnq16s62HOU7znMj/nA49gd
         dmNum2NTAH4KUYxvASye/vnqoB4I3MSNRi5FrjHBgv5KCsSMdiemabTF5rk429OqrOI4
         j4Ec3Y5KaTWl+DVHQZBBAlgMXZFKSTJFyY5ZrcuUcipRRx68eGW775DLJ58j3HN35R7W
         OW4bp/Nc/mnGcpPBIZbmoBqcFotAqdfaNL8pEQMzjuvgPNOqbSc45AjRvdKX86TdFZ4n
         ldgSC0Mi81EZS2cZ9k7F8JrWny91uJH+WWKAg//YDJ+lXhGdY2M4ssOW60HazoP57aKz
         lSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/v48BqSH25XHYPmF+K+A4MAsa5+VWC3bWHsnb4vttJ0=;
        b=guSAjTHOGCkvTwgPyLzLHr4m0HhTOyyO6sUscbhYs2BFrhETKYrYlsSGJ5JwzKZKuR
         MBAVYIhm9vJth6oIUphYVmD61O0QnXIY+NAlQ/eDhQJsBod3c1gM1mjRxzhDzET3ocu6
         sX5F8Os3l3uTCMDlhz5xIRJDKfLY7v6AoP602YpC9Akf9n3m0ULYpp8X/FyVblATbQfE
         1YFWvifdnqercbFhuDMBK1+tfjcBGuXyF4dJNfooXpPLv1FYY8c8aeBLrOvaI7ebVg0n
         jfCmY9hBpmwAyGYHkRHkpQEaoEWhAO2TDxM1wWXnWZKEpad2nPw01/GcgkiP+I+twwvU
         gKEg==
X-Gm-Message-State: APjAAAVHAh98Gwig8rNS5LmNTIfFZcxoySoI3C2W6DJ28XGfcZUZk8HF
        jFKZUb7mqShf7B2KY9AlGriaHYJ/CyGdOw==
X-Google-Smtp-Source: APXvYqxWLcW2au9CJjJK5X1x+ZhgReHAcvYGf8chhbiCq6ry7fkivkBEiGAMZYQwVXCnzfGqWuIH6w==
X-Received: by 2002:a0c:fecc:: with SMTP id z12mr33036622qvs.189.1574785563645;
        Tue, 26 Nov 2019 08:26:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m22sm5245760qka.28.2019.11.26.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 08:26:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Subject: [PATCH 2/4] btrfs: kill min_allocable_bytes in inc_block_group_ro
Date:   Tue, 26 Nov 2019 11:25:54 -0500
Message-Id: <20191126162556.150483-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126162556.150483-1-josef@toxicpanda.com>
References: <20191126162556.150483-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a relic from a time before we had a proper reservation mechanism
and you could end up with really full chunks at chunk allocation time.
This doesn't make sense anymore, so just kill it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6934a5b8708f..66fa39632cde 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1185,21 +1185,8 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	struct btrfs_space_info *sinfo = cache->space_info;
 	u64 num_bytes;
 	u64 sinfo_used;
-	u64 min_allocable_bytes;
 	int ret = -ENOSPC;
 
-	/*
-	 * We need some metadata space and system metadata space for
-	 * allocating chunks in some corner cases until we force to set
-	 * it to be readonly.
-	 */
-	if ((sinfo->flags &
-	     (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_METADATA)) &&
-	    !force)
-		min_allocable_bytes = SZ_1M;
-	else
-		min_allocable_bytes = 0;
-
 	spin_lock(&sinfo->lock);
 	spin_lock(&cache->lock);
 
@@ -1217,10 +1204,9 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	 * sinfo_used + num_bytes should always <= sinfo->total_bytes.
 	 *
 	 * Here we make sure if we mark this bg RO, we still have enough
-	 * free space as buffer (if min_allocable_bytes is not 0).
+	 * free space as buffer.
 	 */
-	if (sinfo_used + num_bytes + min_allocable_bytes <=
-	    sinfo->total_bytes) {
+	if (sinfo_used + num_bytes <= sinfo->total_bytes) {
 		sinfo->bytes_readonly += num_bytes;
 		cache->ro++;
 		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
@@ -1233,8 +1219,8 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 		btrfs_info(cache->fs_info,
 			"unable to make block group %llu ro", cache->start);
 		btrfs_info(cache->fs_info,
-			"sinfo_used=%llu bg_num_bytes=%llu min_allocable=%llu",
-			sinfo_used, num_bytes, min_allocable_bytes);
+			"sinfo_used=%llu bg_num_bytes=%llu",
+			sinfo_used, num_bytes);
 		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
 	}
 	return ret;
-- 
2.23.0

