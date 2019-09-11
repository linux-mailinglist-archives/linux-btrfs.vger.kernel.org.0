Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D6FB01D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfIKQmc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 12:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbfIKQmb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:42:31 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BD0820863
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568220151;
        bh=h2PPNE1MH26MNMfa4X3toj1fWjfFPuCIOtgPUcJ//Ws=;
        h=From:To:Subject:Date:From;
        b=OQZ4rpwkD2+ALDDOyYFVDbRbsn2/Q4IU4cNYt10U1wWd1VgvRVvco1MI5hQsrlQ4N
         YiDn6heJ+583vax/xcgPEOi4gUtlTUsuEpu1c7mgUj11S1AEFGrkpcS0WVGOY1a9oL
         8AxUrVnKYagZBVxh+bdmxgeGClS7Sa5ESX77mKhs=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix missing error return if writeback for extent buffer never started
Date:   Wed, 11 Sep 2019 17:42:28 +0100
Message-Id: <20190911164228.13507-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If lock_extent_buffer_for_io() fails, it returns a negative value, but its
caller btree_write_cache_pages() ignores such error. This means that a
call to flush_write_bio(), from lock_extent_buffer_for_io(), might have
failed. We should make btree_write_cache_pages() notice such error values
and stop immediatelly, making sure filemap_fdatawrite_range() returns an
error to the transaction commit path. A failure from flush_write_bio()
should also result in the endio callback end_bio_extent_buffer_writepage()
being invoked, which sets the BTRFS_FS_*_ERR bits appropriately, so that
there's no risk a transaction or log commit doesn't catch a writeback
failure.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1ff438fd5bc2..13a683da71d2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3969,6 +3969,10 @@ int btree_write_cache_pages(struct address_space *mapping,
 			if (!ret) {
 				free_extent_buffer(eb);
 				continue;
+			} else if (ret < 0) {
+				done = 1;
+				free_extent_buffer(eb);
+				break;
 			}
 
 			ret = write_one_eb(eb, wbc, &epd);
-- 
2.11.0

