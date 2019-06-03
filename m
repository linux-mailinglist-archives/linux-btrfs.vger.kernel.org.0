Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A313F32B61
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 11:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfFCJFR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 05:05:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:37948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbfFCJFQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 05:05:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7878AED7
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2019 09:05:15 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Introduce struct btrfs_io_geometry
Date:   Mon,  3 Jun 2019 12:05:03 +0300
Message-Id: <20190603090505.16800-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603090505.16800-1-nborisov@suse.com>
References: <20190603090505.16800-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a7121d72388f..7c1ddf35b7d4 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -23,6 +23,15 @@ struct btrfs_pending_bios {
 	struct bio *tail;
 };
 
+struct btrfs_io_geometry {
+	u64 len; /* remaining bytes in chunk */
+	u64 offset; /* offset of logical address in chunk */
+	u64 stripe_len; /* len of single io stripe */
+	u64 stripe_nr; /* number of stripe where address falls */
+	u64 stripe_offset; /* offset of stripe in chunk */
+	u64 raid56_stripe_offset; /* offset of raid56 stripe into the chunk */
+};
+
 /*
  * Use sequence counter to get consistent device stat data on
  * 32-bit processors.
-- 
2.17.1

