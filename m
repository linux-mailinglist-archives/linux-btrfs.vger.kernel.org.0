Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC63714D3FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgA2Xuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39122 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2Xue (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:34 -0500
Received: by mail-qt1-f195.google.com with SMTP id c5so1014865qtj.6
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+vJLbf5VrsQ7bsf38+Xf8ZFXT/sUQF4HOdxU5u3TxUM=;
        b=OHQzg0OJJgLYjRwMHypugEoQdcjJ8w73e8RTnFOv3BqlZh7Siftel7fjGs9zhA393m
         AEePFLdAnEogr6IJgNWmBeo0JZI8fVbu0B/oQnwgjS4E/qPyN5O1fgstG2lLltkYke9e
         HJmq9XhA4lvrcv4x7aZUcY8SE+Cy8TQxdesDCd8zA58P7wFmuSm58WT7fjXZl+drTLD5
         z7V8PYywJ/HLDNaIfBg3RhxNC7TXLH53nyv7GpU2iX6L0d8R982jAdv6VekfRbFpFGB3
         XWDz1GX96wtDexPpK+Bv0AHK4RszB4VWkew90VRKLtT67x1d8YVHOpj/+x3ReQ2Fcm3W
         +8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vJLbf5VrsQ7bsf38+Xf8ZFXT/sUQF4HOdxU5u3TxUM=;
        b=gtT4952KoBACRQycJBEWBSKcmyi0qqrTS/DzuJGPxq3rbKvr1mf3EH86j6eCRO8TQR
         uDlnHcK2DlBkIre2olJhrqtwRjpUZhaXHhcAjZlpNwr1VmYBXiv9FN34Q2dPO7xfinH6
         VEh9Txgaf1Epei81a+sFYAMI3LFPx/7AOvMpPTwczOlAROLO7rRnQdIQhHVi6LSa12Jm
         zVT12VzwOGic4ejl9SBe4518NSr3wG4yLBtU0KpcRPiQypBusEAHxI1ivqjzdZ6U395m
         LOn8omt/tAeaaXyVXGsy7m4YR2KvdheSfeSbcQHThXQnkksCRD35339C37YycmmJUkSP
         uVoA==
X-Gm-Message-State: APjAAAXKKJCcOcepvLNR/wPF4FxOaTFksfX4XDYrFT3VIoFjIRonC4vY
        GZbaP2YjdhNmr/UKHtGF+Cg2R1j/hPkJDg==
X-Google-Smtp-Source: APXvYqyAEYrKD9zo4ou1017UmvH/8Svl4P5nVouY3Mehn6bCziwRIq1yT5J0OiFiFQ72x+iV6YYMoQ==
X-Received: by 2002:aed:2a86:: with SMTP id t6mr1923951qtd.81.1580341833032;
        Wed, 29 Jan 2020 15:50:33 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 135sm1823694qkj.55.2020.01.29.15.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/20] btrfs: handle U64_MAX for shrink_delalloc
Date:   Wed, 29 Jan 2020 18:50:07 -0500
Message-Id: <20200129235024.24774-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Data allocations are going to want to pass in U64_MAX for flushing
space, adjust shrink_delalloc to handle this properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 671c3a379224..924cee245e4a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -363,8 +363,19 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
 	int loops;
 
 	/* Calc the number of the pages we need flush for space reservation */
-	items = calc_reclaim_items_nr(fs_info, to_reclaim);
-	to_reclaim = items * EXTENT_SIZE_PER_ITEM;
+	if (to_reclaim == U64_MAX) {
+		items = U64_MAX;
+	} else {
+		/*
+		 * to_reclaim is set to however much metadata we need to
+		 * reclaim, but reclaiming that much data doesn't really track
+		 * exactly, so increase the amount to reclaim by 2x in order to
+		 * make sure we're flushing enough delalloc to hopefully reclaim
+		 * some metadata reservations.
+		 */
+		items = calc_reclaim_items_nr(fs_info, to_reclaim) * 2;
+		to_reclaim = items * EXTENT_SIZE_PER_ITEM;
+	}
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
@@ -569,7 +580,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes * 2,
+		shrink_delalloc(fs_info, num_bytes,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

