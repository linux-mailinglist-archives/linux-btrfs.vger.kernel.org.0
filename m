Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8968D1C0E5D
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgEAGwe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 02:52:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgEAGwc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 May 2020 02:52:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DB02AAD23
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 06:52:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs-progs: Remove the unused btrfs_block_group_cache::cache
Date:   Fri,  1 May 2020 14:52:18 +0800
Message-Id: <20200501065219.484868-4-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501065219.484868-1-wqu@suse.com>
References: <20200501065219.484868-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no user of that member.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 ctree.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ctree.h b/ctree.h
index d12ed5d8af31..6ebd4ea61ee5 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1105,7 +1105,6 @@ struct btrfs_space_info {
 };
 
 struct btrfs_block_group_cache {
-	struct cache_extent cache;
 	struct btrfs_space_info *space_info;
 	struct btrfs_free_space_ctl *free_space_ctl;
 	u64 start;
-- 
2.26.2

