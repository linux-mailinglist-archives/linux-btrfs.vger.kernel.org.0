Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE01DF373
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfJUQpH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 12:45:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:52918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbfJUQpG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 12:45:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3659BABC7;
        Mon, 21 Oct 2019 16:45:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7CB24DA733; Mon, 21 Oct 2019 18:45:18 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: add blake2b to checksumming algorithms
Date:   Mon, 21 Oct 2019 18:45:18 +0200
Message-Id: <cd90e217fee62e488c655004f83acaa6d8ab398c.1571674940.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571674940.git.dsterba@suse.com>
References: <cover.1571674940.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add blake2b (with 256 bit digest) to the list of possible checksumming
algorithms used by BTRFS.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c                | 2 ++
 fs/btrfs/disk-io.c              | 1 +
 fs/btrfs/super.c                | 1 +
 include/uapi/linux/btrfs_tree.h | 1 +
 4 files changed, 5 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c211216b4524..5b6e86aaf2e1 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -37,6 +37,8 @@ static const struct btrfs_csums {
 	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
 	[BTRFS_CSUM_TYPE_XXHASH] = { .size = 8, .name = "xxhash64" },
 	[BTRFS_CSUM_TYPE_SHA256] = { .size = 32, .name = "sha256" },
+	[BTRFS_CSUM_TYPE_BLAKE2] = { .size = 32, .name = "blake2b",
+				     .driver = "blake2b-256" },
 };
 
 int btrfs_super_csum_size(const struct btrfs_super_block *s)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 948ed5ac0794..7c345c4bc817 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -354,6 +354,7 @@ static bool btrfs_supported_super_csum(u16 csum_type)
 	case BTRFS_CSUM_TYPE_CRC32:
 	case BTRFS_CSUM_TYPE_XXHASH:
 	case BTRFS_CSUM_TYPE_SHA256:
+	case BTRFS_CSUM_TYPE_BLAKE2:
 		return true;
 	default:
 		return false;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 36440336c08b..5c6796caebb5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2464,3 +2464,4 @@ MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: crc32c");
 MODULE_SOFTDEP("pre: xxhash64");
 MODULE_SOFTDEP("pre: sha256");
+MODULE_SOFTDEP("pre: blake2b");
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index e2823c9b2061..5160be1d7332 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -304,6 +304,7 @@ enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_CRC32	= 0,
 	BTRFS_CSUM_TYPE_XXHASH	= 1,
 	BTRFS_CSUM_TYPE_SHA256	= 2,
+	BTRFS_CSUM_TYPE_BLAKE2	= 3,
 };
 
 /*
-- 
2.23.0

