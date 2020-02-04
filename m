Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80788151E20
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgBDQUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:02 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46992 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBDQUC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:02 -0500
Received: by mail-qv1-f67.google.com with SMTP id y2so8775803qvu.13
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LmtyVgpNAtmAthu9E96HIN5x5zjPs235pd/hE22wMhY=;
        b=Rqj+Knwa9FAnmMOZnYl8jSFuLoQz813pTR69R41VpymIFjbqJWm+cWV8ZTd5VHHSh2
         WCb1Un5VYETMEa+fy7C1c70Lurzl/0hXUGhrA7rNgan6pkRn1AvNQyh8t2H21G/ahMx4
         4W5mai2ShZRlvq8TzT1AFAq9abA8CBQrhThSjWqRe7wb2TCABpzcqY/cWPj2Avwuypvt
         2AaM+AKBrPKijCBqnJ/KlF7PFZ5cZwnjEFoGQwZm5Jr406glhLM94eoVrHNCigyo2aQi
         tZeicTxyCSx1kKd1rZDSp1DTMjlakp4/mNdohHu8yJz/qtpIUWaykauAE9VkUM5cpDZ+
         b2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmtyVgpNAtmAthu9E96HIN5x5zjPs235pd/hE22wMhY=;
        b=SqYnYVYR4iVrOgu4AmVSAwukbB8z4snELkTIfOaqYJYflB62oNX7n8uw5LEeKVHVMT
         JUQFwturRBbvhmKfNio5gZsGDaEF37/ta3p+GQOInM04jhy2cFv5RhOIgh7DifwjL/mK
         LCk8DmmNGUNeVF6lsEiZdSwd7uRLQQD7UrCw2xiBcyF+jnsWwSfDB+AgDPtDU9CQIFkn
         xHSJQuEqPuFpklPNcgl4QC6BP/S3XvCZA0rct5IrRpkzdpTZ0+OqjNyg+x14rqPwqEUt
         S0u7Lp5j7twa4ogdDWXqzIT+bk6alLBzPzh0wQ7duJg6o6W2AmpyxRaSTScVvB19v17y
         BXog==
X-Gm-Message-State: APjAAAUD3HX5PTZKUruSQRg/YKFeDFSasH3qFgPWFhbJjU+n9MKHXHLG
        EHzD/EFoGZ3WONRQ2tDx85kJ29mje+a/7Q==
X-Google-Smtp-Source: APXvYqw7gDEvI7V51Ed4b4FXtVSyleuQV5hsf9mOcqbFznh+7bvrSweOfPrRoh6tz+fb/TsImQ2gGw==
X-Received: by 2002:ad4:4d94:: with SMTP id cv20mr26975551qvb.99.1580833200629;
        Tue, 04 Feb 2020 08:20:00 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s42sm12042156qtk.87.2020.02.04.08.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:19:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/23] btrfs: make shrink_delalloc take space_info as an arg
Date:   Tue,  4 Feb 2020 11:19:32 -0500
Message-Id: <20200204161951.764935-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently shrink_delalloc just looks up the metadata space info, but
this won't work if we're trying to reclaim space for data chunks.  We
get the right space_info we want passed into flush_space, so simply pass
that along to shrink_delalloc.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 924cee245e4a..17e2b5a53cb5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -349,10 +349,10 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 /*
  * shrink metadata reservation for delalloc
  */
-static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
-			    bool wait_ordered)
+static void shrink_delalloc(struct btrfs_fs_info *fs_info,
+			    struct btrfs_space_info *space_info,
+			    u64 to_reclaim, bool wait_ordered)
 {
-	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
 	u64 dio_bytes;
@@ -378,7 +378,6 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
 	}
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
-	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 
 	delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
@@ -580,7 +579,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes,
+		shrink_delalloc(fs_info, space_info, num_bytes,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

