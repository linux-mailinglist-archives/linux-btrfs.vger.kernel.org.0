Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B451EB80C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 11:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgFBJJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 05:09:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:43094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgFBJJX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jun 2020 05:09:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4B68CAB64
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Jun 2020 09:09:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v9 5/5] btrfs: volumes: Revert device used bytes when calc_per_profile_avail() failed
Date:   Tue,  2 Jun 2020 17:09:05 +0800
Message-Id: <20200602090905.63899-6-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602090905.63899-1-wqu@suse.com>
References: <20200602090905.63899-1-wqu@suse.com>
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
index fec2a62cbcf9..6a0850ce5f37 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5282,6 +5282,15 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 				      &trans->transaction->dev_update_list);
 	}
 	ret = calc_per_profile_avail(info);
+	if (ret < 0) {
+		for (i = 0; i < map->num_stripes; i++) {
+			struct btrfs_device *dev = map->stripes[i].dev;
+
+			btrfs_device_set_bytes_used(dev,
+					dev->bytes_used - ctl->stripe_size);
+		}
+		goto error_del_extent;
+	}
 
 	atomic64_sub(ctl->stripe_size * map->num_stripes,
 		     &info->free_chunk_space);
-- 
2.26.2

