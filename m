Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D062172AD
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgGGPm5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPm5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:42:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AF1C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:42:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z63so38490435qkb.8
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8OvljpuILSWk6dPIuW+DVZm/J9jdzzmI+Wl8q8HkOY=;
        b=2BquOguNc/naZ89O+MuIPCWRDVHCi3IaABhoCdecqlCgCmdyw5tzXtB+H8JfEcJRop
         Dk9MF6P6fbiCAdCKryWj6VjjjvHk8sVVsHtgHY1urdOk1qBDIHGKD5C+hqn5o1My+PPD
         V6RjOVICpnovv8mu8+0eiIQd1guC26LL+Pm6+BPgPCsT9pqW5S+bkMv18rA+H9CbI3Pf
         u1vTm0FzmiUWoSJcwe6HqIpABjEas96qPMZcQAFEC4yq0GilqGSjzlBjZPD8rc0WraBw
         AD5MQylNMiJ6C8SPXZv9TFFhyIpP3Y7s+muWWg2h+xCsZzRGgW+PTiWQAwkxfxQSYkyf
         daOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8OvljpuILSWk6dPIuW+DVZm/J9jdzzmI+Wl8q8HkOY=;
        b=kHucHq/aXD9SFbc8FOVCG27Gum1f01krrNqzKH7OSKugJ4TQb1J6/Cs+itDoOuXWlx
         xkkM47emQTeZJaS4YiLvxSsSGbMR1PHHNzqw8qh04sb/CNfXSf1v+sHavTYsAIcU4FMY
         NprAvlYjXNzlIAtwiXZ50gFEkOAsxC9qBVujO8furUhSV47k7V6r7pV4HDs9ereIInOf
         4544yEgPF7u9SdPPBO2NrqfFXKgkuuOtIKvdVFB9Gn8NvDlFsgMU3SFf6COCpcaHzaxB
         JYC0UDfOLQHalZYXbvSQNmd5lnWJU4685WJsaY0W1hcfqcTpnsLm67h+Tf7bLkt63WTf
         68Jw==
X-Gm-Message-State: AOAM530wGYP2GIVaI2FOQD8dq2W86Xf/anmqZFMaiW0XvYMz31nONWSz
        915RgWgtpia2JUI/7nf8ZI3LNEJQJUwb2A==
X-Google-Smtp-Source: ABdhPJza1IVEMCL4ifrMS+7TQAEM4iN5ESvF0f2QkKRtWfp9XpWR9/3hJYx6zC8aYAzJpucaENjrpQ==
X-Received: by 2002:a05:620a:1282:: with SMTP id w2mr50482946qki.196.1594136575848;
        Tue, 07 Jul 2020 08:42:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u22sm27986992qtb.23.2020.07.07.08.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:42:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/23] btrfs: handle U64_MAX for shrink_delalloc
Date:   Tue,  7 Jul 2020 11:42:26 -0400
Message-Id: <20200707154246.52844-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Data allocations are going to want to pass in U64_MAX for flushing
space, adjust shrink_delalloc to handle this properly.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 266b9887fda4..c2a2326f9a79 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -530,8 +530,19 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
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
@@ -742,7 +753,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
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

