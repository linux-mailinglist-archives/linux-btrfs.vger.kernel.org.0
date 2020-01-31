Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BA914F4DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgAaWgq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:46 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43751 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgAaWgq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id j20so8202663qka.10
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8eSIp50bber6rSeu3XOdTcZqeJcik5LQlOAfamDNLKw=;
        b=1XwkJKmIHI6aR+F3DLLdsJW114jhs2Wex2dGwN4ZqDGtdbiDpZdUaFH45Eyv2Zp9aA
         3nDg/qgKg3ibwO5xBi3uLieG+0l9t6+BfXLtGjBiUof8nyXpe46mFWT4EeKZf8CTDb2Y
         2DIOmar9KU5d0EQ+kERcgkJlJhZjPARGu1l2n9RNpmI6BcU8A0WlGNG+uYGnN8u4+Jrf
         6OhNlUOfsUh3h+u8TufK//nl3YyPNqmX9fg1bODfEdAqzoEss1/Mfvbi0r8TJX/CfgSC
         bGYPoY4GsLLBprIXPWRbj+MvkWrYMDrpEhG2fnthJp4xp5MqkifUKWtEUYPFygK0/GF7
         iL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8eSIp50bber6rSeu3XOdTcZqeJcik5LQlOAfamDNLKw=;
        b=cubs8vwQD0ouqeFgGgKo+4abp/9nMaEOrLFkRxnW3nhk1hZ9gJsDOVecsPC40Cwyww
         gan7uCE8kaN+5P743KXHNcDw2utov1YW0DUmc7ze1HP2/tG5y/AlxP+MiYFMU7AVX5R9
         SyT0G1Gcqw7CsbwqsTxpM3nD5bhzHa8MbNqzPhNhAaC9TJPCQoE2xhSkgBZOHyQiOq6p
         3WK4O1PkxcPaJt/7oP48hSUsY0k91FTQQ49CD8vt3k1PLh6DH7++lcsTAg32tdB3bf85
         C3SSYSvq5NCHSWtufY1h4bs6kQKJuA1I+SH6KGmShEX3lHvn8JLZxvg3n1mQNmw5Rlse
         OGxg==
X-Gm-Message-State: APjAAAVod9xRnXRLmRaUpeEBZStxiVMRMcFGljHtlL26MN/TAX/kPKh9
        ZcwDSpjA0ZW4q+O8JZpFpIlfXrXjp3Vqyg==
X-Google-Smtp-Source: APXvYqz2c7xKCknZI/N6vHB34y1377q8QXxSb/5TJww3NLA7h4XjvPi5dzyHNEs9zICDEgAPLfSYRg==
X-Received: by 2002:a37:9ace:: with SMTP id c197mr13300009qke.482.1580510204277;
        Fri, 31 Jan 2020 14:36:44 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k50sm5808948qtc.90.2020.01.31.14.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/23] btrfs: serialize data reservations if we are flushing
Date:   Fri, 31 Jan 2020 17:36:06 -0500
Message-Id: <20200131223613.490779-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nikolay reported a problem where generic/371 would fail sometimes with a
slow drive.  The gist of the test is that we fallocate a file in
parallel with a pwrite of a different file.  These two files combined
are smaller than the file system, but sometimes the pwrite would ENOSPC.

A fair bit of investigation uncovered the fact that the fallocate
workload was racing in and grabbing the free space that the pwrite
workload was trying to free up so it could make its own reservation.
After a few loops of this eventually the pwrite workload would error out
with an ENOSPC.

We've had the same problem with metadata as well, and we serialized all
metadata allocations to satisfy this problem.  This wasn't usually a
problem with data because data reservations are more straightforward,
but obviously could still happen.

Fix this by not allowing reservations to occur if there are any pending
tickets waiting to be satisfied on the space info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 43c5775bcbc6..97379524bac8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1154,13 +1154,17 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
 	u64 used;
 	int ret = -ENOSPC;
+	bool pending_tickets;
 
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
 	spin_lock(&data_sinfo->lock);
 	used = btrfs_space_info_used(data_sinfo, true);
+	pending_tickets = !list_empty(&data_sinfo->tickets) ||
+		!list_empty(&data_sinfo->priority_tickets);
 
-	if (used + bytes > data_sinfo->total_bytes) {
+	if (pending_tickets ||
+	    used + bytes > data_sinfo->total_bytes) {
 		struct reserve_ticket ticket;
 
 		init_waitqueue_head(&ticket.wait);
-- 
2.24.1

