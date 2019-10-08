Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912F5CF1EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 06:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfJHEtR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 00:49:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbfJHEtR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 00:49:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED83FAF61
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2019 04:49:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: disk-io: Remove unnecessary check before freeing chunk root
Date:   Tue,  8 Oct 2019 12:49:08 +0800
Message-Id: <20191008044909.157750-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008044909.157750-1-wqu@suse.com>
References: <20191008044909.157750-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In free_root_pointers(), free_root_extent_buffers() has checked if the
@root parameter is NULL.
So there is no need checking chunk_root before freeing it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 044981cf6df9..bfeeac83b952 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2038,8 +2038,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, int chunk_root)
 	free_root_extent_buffers(info->csum_root);
 	free_root_extent_buffers(info->quota_root);
 	free_root_extent_buffers(info->uuid_root);
-	if (chunk_root)
-		free_root_extent_buffers(info->chunk_root);
+	free_root_extent_buffers(info->chunk_root);
 	free_root_extent_buffers(info->free_space_root);
 }
 
-- 
2.23.0

