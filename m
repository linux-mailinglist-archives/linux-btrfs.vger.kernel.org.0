Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38CBA5E41
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 01:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfIBXqY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 19:46:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:34906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726849AbfIBXqY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Sep 2019 19:46:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F79AABD0
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2019 23:46:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tree-checker: Check item size before reading file extent type
Date:   Tue,  3 Sep 2019 07:46:19 +0800
Message-Id: <20190902234619.5888-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In check_extent_data_item(), we read file extent type without verifying
if the item size is valid.

Add such check to ensure the file extent type we read is correct.

The check is not as accurate as we need to cover both inline and regular
extents, so it only checks if the item size is larger or equal to inline
header.
So the existing size checks on inline/regular extents are still needed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 15d1aa7cef1f..22e6474f9d4e 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -143,6 +143,17 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 
+	/*
+	 * Make sure the item contains at least inline header, so the file
+	 * extent type is not some garbage.
+	 */
+	if (item_size < BTRFS_FILE_EXTENT_INLINE_DATA_START) {
+		file_extent_err(leaf, slot,
+		"invalid item size, have %u expect [%lu, %u)",
+				item_size, BTRFS_FILE_EXTENT_INLINE_DATA_START,
+				SZ_4K);
+		return -EUCLEAN;
+	}
 	if (btrfs_file_extent_type(leaf, fi) > BTRFS_FILE_EXTENT_TYPES) {
 		file_extent_err(leaf, slot,
 		"invalid type for file extent, have %u expect range [0, %u]",
-- 
2.23.0

