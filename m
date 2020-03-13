Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346BE184FC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 20:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCMT6T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 15:58:19 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46952 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMT6S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 15:58:18 -0400
Received: by mail-qk1-f194.google.com with SMTP id f28so14694241qkk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvUYYnYIAFKSs1HkIN4bV/reZc+HdHZemgJYtNoaKkg=;
        b=yzkbQe3U1uG7MO1qMloVPRMGNB9HpfnXN3KNaQeBFbJYv4zO8VpZ63gwJlwanQCOy/
         Kicuv0sywNNpFYYIi+rBDQKes3d6FwqBsYObhSW7gP3en5ytmNgKv4Mxnx63Kr74Fac6
         DQv5ullwE9WtCqrZMwlglv70Z+wbyVSqBFWArfPWvoc9L9j3Yr7XaZSinbEBxpzeg1cW
         n7LrDnOCYQBwtZ4cVPytfTAW9d3PT2VonUvdzS0LngtDd+no/NyophEuYQxkmpBwwlHj
         FDXTtVD10cKldNhJEoTgS9uXZtCGi1AXl1S2gkDLr9aKYuCBfj6WJi+CV6o74EwJ+yb+
         sHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvUYYnYIAFKSs1HkIN4bV/reZc+HdHZemgJYtNoaKkg=;
        b=an+iv7Su4a7L/283E6/zUaR+RY6XjUGbpndInPqYBfsaZ6Ub4Yjrf7h4rcDJz1DLES
         iVpc6ZH3OUFaE3P4uCJYOEpk4qbIC3UjHqry93GLw3iDXjsBwXO9iuzp9r59HROPA/+o
         RlhQxwS34UbZdv8cfMil6uNclPtNrjyANHXBrHSXszSoJV0axrPpdl7Qst/dm5hpm4Rp
         VSE0DfqhEpNGpGPr/9A6CNkFp+v2lL8D7dCEgw4dTQ/Tp46AThk/Zy6iMcsitdGtk9dN
         VYEbw+p3VCwd2ZAHfd6d2+uCuhuwr12zebif2zpMCC7poHW1eCweUTmdCFpYfRVu28B5
         5tmQ==
X-Gm-Message-State: ANhLgQ1PN3lfK/lPwLIAMBiR4Kawkyz1305Was+l2xTE0JlS0eJhHQW5
        SZHRwQzY74YBwQscoCNKhVFobZx+5Ha4Tg==
X-Google-Smtp-Source: ADFU+vvQcqKZsOIUSqjle9WwymfOg3aDQVCLuKd+A72D8dnjXbnvBHR4WEIxldH0zlYQpXmvCrF9Pw==
X-Received: by 2002:a37:6616:: with SMTP id a22mr5267465qkc.391.1584129497050;
        Fri, 13 Mar 2020 12:58:17 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f93sm15505355qtd.26.2020.03.13.12.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:58:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/5] btrfs: Account for trans_block_rsv in may_commit_transaction
Date:   Fri, 13 Mar 2020 15:58:07 -0400
Message-Id: <20200313195809.141753-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195809.141753-1-josef@toxicpanda.com>
References: <20200313195809.141753-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On ppc64le with 64k page size (respectively 64k block size) generic/320
was failing and debug output showed we were getting a premature ENOSPC
with a bunch of space in btrfs_fs_info::trans_block_rsv.

This meant there were still open transaction handles holding space, yet
the flusher didn't commit the transaction because it deemed the freed
space won't be enough to satisfy the current reserve ticket. Fix this
by accounting for space in trans_block_rsv when deciding whether the
current transaction should be committed or not.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 4759499b1b97..784a7ca4f9cb 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -575,6 +575,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	struct reserve_ticket *ticket = NULL;
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_block_rsv;
 	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
+	struct btrfs_block_rsv *trans_rsv = &fs_info->trans_block_rsv;
 	struct btrfs_trans_handle *trans;
 	u64 reclaim_bytes = 0;
 	u64 bytes_needed;
@@ -637,6 +638,11 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock(&delayed_refs_rsv->lock);
 	reclaim_bytes += delayed_refs_rsv->reserved;
 	spin_unlock(&delayed_refs_rsv->lock);
+
+	spin_lock(&trans_rsv->lock);
+	reclaim_bytes += trans_rsv->reserved;
+	spin_unlock(&trans_rsv->lock);
+
 	if (reclaim_bytes >= bytes_needed)
 		goto commit;
 	bytes_needed -= reclaim_bytes;
-- 
2.24.1

