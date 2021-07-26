Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8EB3D594A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhGZLhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:37:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58038 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbhGZLhj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:37:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 02E391FE75;
        Mon, 26 Jul 2021 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627301888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dV4F6VZThl4rL85BkJmJdny3Ry0oeoKWEi9cau2j5o=;
        b=IeO6XPxgvDhjiDCe5AQ1fuoNx88douLE89otICldFEKziDzcFwaqCZKH7M+G3Cn+YpATdG
        +kLv7DEAMbKjQaGOc3Svydx4NeEkVgQc5Kw6x7S40Tl097azeBq7C68EFoJbmQDHdnz42E
        mkCx0gUt1NPsbf8icbIE/Xi0knDjQnc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EFF00A3C1E;
        Mon, 26 Jul 2021 12:18:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4FCCCDA8D8; Mon, 26 Jul 2021 14:15:24 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 08/10] btrfs: simplify data stripe calculation helpers
Date:   Mon, 26 Jul 2021 14:15:24 +0200
Message-Id: <6e7fd9d9fe39f547eae063dac6e230f155980ba0.1627300614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627300614.git.dsterba@suse.com>
References: <cover.1627300614.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two helpers doing the same calculations based on nparity and
ncopies. calc_data_stripes can be simplified into one expression, so far
we don't have profile with both copies and parity, so there's no
effective change. calc_stripe_length should reuse the helper and not
repeat the same calculation.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d98e29556d79..78dd013d0ee3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3567,10 +3567,7 @@ static u64 calc_data_stripes(u64 type, int num_stripes)
 	const int ncopies = btrfs_raid_array[index].ncopies;
 	const int nparity = btrfs_raid_array[index].nparity;
 
-	if (nparity)
-		return num_stripes - nparity;
-	else
-		return num_stripes / ncopies;
+	return (num_stripes - nparity) / ncopies;
 }
 
 /* [pstart, pend) */
@@ -6878,15 +6875,7 @@ static void btrfs_report_missing_device(struct btrfs_fs_info *fs_info,
 
 static u64 calc_stripe_length(u64 type, u64 chunk_len, int num_stripes)
 {
-	int index = btrfs_bg_flags_to_raid_index(type);
-	int ncopies = btrfs_raid_array[index].ncopies;
-	const int nparity = btrfs_raid_array[index].nparity;
-	int data_stripes;
-
-	if (nparity)
-		data_stripes = num_stripes - nparity;
-	else
-		data_stripes = num_stripes / ncopies;
+	const int data_stripes = calc_data_stripes(type, num_stripes);
 
 	return div_u64(chunk_len, data_stripes);
 }
-- 
2.31.1

