Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EEC3D5947
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhGZLhe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:37:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54746 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbhGZLhc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:37:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 11FE721F7A;
        Mon, 26 Jul 2021 12:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627301881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tr2TNMOrekdAg+TgS0iBFET3tZO0R41lQ6tDQ4PbxR8=;
        b=fgOkrtt9zSQSpSVB+zpl0t8ANKzvITweQUX67WuLWBgNV7xseYmv183SeJLvsL75vBa5SM
        MUbiii8iAxZdy4geoLmqIgQv8yOFnW61W0vzgu/AyhuIYrHt6L22OMDsaMD9SOj5R7ONP+
        oU1nd/PL2Q+qeYW/fa7HxQxqZYnJU0M=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0C2CFA3C1E;
        Mon, 26 Jul 2021 12:18:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 60CBFDA8D8; Mon, 26 Jul 2021 14:15:17 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 05/10] btrfs: tree-checker: add missing stripe checks for raid1c3/4 profiles
Date:   Mon, 26 Jul 2021 14:15:17 +0200
Message-Id: <867952ec2e4728190693011e215a81ea9a4eb73c.1627300614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627300614.git.dsterba@suse.com>
References: <cover.1627300614.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The stripe checks for raid1c3/raid1c4 are missing in the sequence in
btrfs_check_chunk_valid.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-checker.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index ac9416cb4496..7ba94b683ee3 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -877,6 +877,10 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 		      sub_stripes != btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes) ||
 		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
 		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID1C3 &&
+		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1C3].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID1C4 &&
+		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1C4].devs_min) ||
 		     (type & BTRFS_BLOCK_GROUP_RAID5 &&
 		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID5].devs_min) ||
 		     (type & BTRFS_BLOCK_GROUP_RAID6 &&
-- 
2.31.1

