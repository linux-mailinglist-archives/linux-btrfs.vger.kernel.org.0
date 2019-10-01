Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE3C3F28
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfJAR5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 13:57:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:33246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731687AbfJAR5V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 13:57:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C11C3AF0B;
        Tue,  1 Oct 2019 17:57:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9D65FDA88C; Tue,  1 Oct 2019 19:57:37 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: add const function attribute
Date:   Tue,  1 Oct 2019 19:57:37 +0200
Message-Id: <543f96a0b47e4856e6adbf3761a56df96480f358.1569587835.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569587835.git.dsterba@suse.com>
References: <cover.1569587835.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For some reason the attribute is called __attribute_const__ and not
__const, marks functions that have no observable effects on program
state, IOW not reading pointers, just the arguments and calculating a
value. Allows the compiler to do some optimizations, based on
-Wsuggest-attribute=const . The effects are rather small, though, about
60 bytes decrese of btrfs.ko.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h   | 2 +-
 fs/btrfs/super.c   | 2 +-
 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/volumes.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4bf0433b1179..793085770c84 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3146,7 +3146,7 @@ __cold
 void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
 		     unsigned int line, int errno, const char *fmt, ...);
 
-const char *btrfs_decode_error(int errno);
+const char * __attribute_const__ btrfs_decode_error(int errno);
 
 __cold
 void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3da35d8b21a3..b3e6d7aa3402 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -66,7 +66,7 @@ static struct file_system_type btrfs_root_fs_type;
 
 static int btrfs_remount(struct super_block *sb, int *flags, char *data);
 
-const char *btrfs_decode_error(int errno)
+const char * __attribute_const__ btrfs_decode_error(int errno)
 {
 	char *errstr = "unknown";
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3fd89aee539d..c343b7cdfb53 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -297,7 +297,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 DEFINE_MUTEX(uuid_mutex);
 static LIST_HEAD(fs_uuids);
-struct list_head *btrfs_get_fs_uuids(void)
+struct list_head * __attribute_const__ btrfs_get_fs_uuids(void)
 {
 	return &fs_uuids;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a7da1f3e3627..0ae0677a8d86 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -571,7 +571,7 @@ static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
 
 void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
 
-struct list_head *btrfs_get_fs_uuids(void);
+struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
 void btrfs_set_fs_info_ptr(struct btrfs_fs_info *fs_info);
 void btrfs_reset_fs_info_ptr(struct btrfs_fs_info *fs_info);
 bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
-- 
2.23.0

