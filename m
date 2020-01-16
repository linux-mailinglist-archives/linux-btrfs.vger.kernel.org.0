Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1800A13D416
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 07:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgAPGE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 01:04:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:45202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729718AbgAPGE1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 01:04:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2CA6CB1A2
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 06:04:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6 5/5] btrfs: volumes: Revert device used bytes when calc_per_profile_avail() failed
Date:   Thu, 16 Jan 2020 14:04:04 +0800
Message-Id: <20200116060404.95200-6-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116060404.95200-1-wqu@suse.com>
References: <20200116060404.95200-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In __btrfs_alloc_chunk(), if calc_per_profile_avail() failed, it will
not update the per-profile available space array.
However since device used space is already updated, this would cause a
mismatch between them.

To fix this problem, this patch will revert device used bytes when
calc_per_profile_avail() failed, and remove the newly allocated chunk.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6ba66c7cff2e..749c647818aa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5173,6 +5173,15 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 				      &trans->transaction->dev_update_list);
 	}
 	ret = calc_per_profile_avail(info);
+	if (ret < 0) {
+		for (i = 0; i < map->num_stripes; i++) {
+			struct btrfs_device *dev = map->stripes[i].dev;
+
+			btrfs_device_set_bytes_used(dev,
+					dev->bytes_used - stripe_size);
+		}
+		goto error_del_extent;
+	}
 
 	atomic64_sub(stripe_size * map->num_stripes, &info->free_chunk_space);
 
-- 
2.24.1

