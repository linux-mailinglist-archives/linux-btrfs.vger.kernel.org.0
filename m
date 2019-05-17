Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77CE021675
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfEQJmq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729019AbfEQJmo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E895BAECD
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 961ADDA871; Fri, 17 May 2019 11:43:43 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 14/15] btrfs: constify map parameter for nr_parity_stripes and nr_data_stripes
Date:   Fri, 17 May 2019 11:43:43 +0200
Message-Id: <8abf633d99f23e3facac6a75b7ef38d7d87544c8.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/raid56.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index f5d4c13a8dbc..2503485db859 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -7,7 +7,7 @@
 #ifndef BTRFS_RAID56_H
 #define BTRFS_RAID56_H
 
-static inline int nr_parity_stripes(struct map_lookup *map)
+static inline int nr_parity_stripes(const struct map_lookup *map)
 {
 	if (map->type & BTRFS_BLOCK_GROUP_RAID5)
 		return 1;
@@ -17,7 +17,7 @@ static inline int nr_parity_stripes(struct map_lookup *map)
 		return 0;
 }
 
-static inline int nr_data_stripes(struct map_lookup *map)
+static inline int nr_data_stripes(const struct map_lookup *map)
 {
 	return map->num_stripes - nr_parity_stripes(map);
 }
-- 
2.21.0

