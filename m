Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21D915115E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgBCUu3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:29 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45222 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgBCUu2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so15671784qkl.12
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xdj/iyRMuDFp51iO1C9LBV1KKD2wbTpswYPrElGsPa4=;
        b=bpMsMdpZQIAOf0DXY9tsCt8JtqTD2F+CWzvU7ghOvuCUvCrWJet5TTiJWJZ/bDSpXP
         JXS5MSWti+uwX7h1lEnZt3BpseXUFARJcz6N/IFruUAS4WE2O4e3XNrlEiASNBSQuDN3
         jcJNXw+GwIrLrQgZUBbchsv3aSeqrAgFRQQGd9aqR8yE8+mKqitfac/Uncj3jNyn+2aO
         zDa3cLaQYMlgfTsA7NkueTtrNhl1ky6F92ZdmG2usZQedfzBW7qkeqEl+1zR9Us/HpMK
         vACzaW2NmZ0ewQ+9ocA9P0a2/y7ZfHaYM4QxVyXSlijFI2ANyZ5JOlffaHqDaIEVdpUe
         t55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdj/iyRMuDFp51iO1C9LBV1KKD2wbTpswYPrElGsPa4=;
        b=bS1n112bcsaGPXvW7ldHLmluhCBQ/FVyEfFfYnW1HJakxSskOHj4kc+ny7c8hbrcNp
         rHOnH7z87ajvtBFbC5xczUHxMeJ08qutebGOPDosK9yifTncS/Ofli6LXpWTSqGeSphQ
         370UlcTHOMXJDGiqWB2ogRDhbcRrAIMnYEAxO7Sf39ckv54v6NhY5VY3m9PlNRknx9p3
         GTY7PrSnIhQVZbfG/EQxjf1TP1/9LVxJzGsgxrImyE+iVp/cIViwzbh2EI05Z9TiP/1P
         5DqO41UeJ0fPWy99rj4NVMmndUg+lakiGqZYvWAujTh3Y335jKHoxOBJhrfCyAw4upoT
         HrfQ==
X-Gm-Message-State: APjAAAXxmLVnYfoCQSNf4zZArRt9q96f2boStXl/S60d3/2LgLC1qGQ/
        2bTouY+ZGOx/KwvHCgarLyb+bpHH2tKpGw==
X-Google-Smtp-Source: APXvYqwwMPVZRrJAiXAcN6thqfKTHY5xcNtyRHT3BDe/+JzYOeWykStbx6NjN5d6VbrH9ODJ8jMAZg==
X-Received: by 2002:a05:620a:a05:: with SMTP id i5mr25085913qka.24.1580763026880;
        Mon, 03 Feb 2020 12:50:26 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l6sm10640706qti.10.2020.02.03.12.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/24] btrfs: don't force commit if we are data
Date:   Mon,  3 Feb 2020 15:49:47 -0500
Message-Id: <20200203204951.517751-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We used to unconditionally commit the transaction at least 2 times and
then on the 3rd try check against pinned space to make sure committing
the transaction was worth the effort.  This is overkill, we know nobody
is going to steal our reservation, and if we can't make our reservation
with the pinned amount simply bail out.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d20c338f2780..abd6f35d8fd0 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -421,21 +421,11 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	u64 reclaim_bytes = 0;
 	u64 bytes_needed;
 	u64 cur_free_bytes = 0;
-	bool do_commit = false;
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
 	if (trans)
 		return -EAGAIN;
 
-	/*
-	 * If we are data just force the commit, we aren't likely to do this
-	 * over and over again.
-	 */
-	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA) {
-		do_commit = true;
-		goto check_pinned;
-	}
-
 	spin_lock(&space_info->lock);
 	cur_free_bytes = btrfs_space_info_used(space_info, true);
 	if (cur_free_bytes < space_info->total_bytes)
@@ -460,7 +450,6 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	if (!bytes_needed)
 		return 0;
 
-check_pinned:
 	trans = btrfs_join_transaction(fs_info->extent_root);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
@@ -470,8 +459,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	 * we have block groups that are going to be freed, allowing us to
 	 * possibly do a chunk allocation the next loop through.
 	 */
-	if (do_commit ||
-	    test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
+	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
 	    __percpu_counter_compare(&space_info->total_bytes_pinned,
 				     bytes_needed,
 				     BTRFS_TOTAL_BYTES_PINNED_BATCH) >= 0)
-- 
2.24.1

