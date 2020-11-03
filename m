Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC212A54D2
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 22:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbgKCVMn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 16:12:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:48040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389052AbgKCVMm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 16:12:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604437961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2koavdohn7pN+9F4vh3pjqh2oXrNVb07GgCvPtxhNl8=;
        b=T1G3wjVsY36Ulo2VhAOBl4sYd2rzOSKEkxIM5gZ+HBNuP8iBKVGEi0U3JAkN6MhZDSZPkd
        Pf0YZ8A4XRKgpEFOAjUotYIEzM25t8h1z+1/P6QZnHQsvieo6NPrwEL4hvBJnJ+Lxa8VHJ
        SCiXm+vHML7/zPJ8pJxX1LAu2MJ1qaA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB487ACC0;
        Tue,  3 Nov 2020 21:12:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5DE0DA7D2; Tue,  3 Nov 2020 22:11:02 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: reorder extent buffer members for better packing
Date:   Tue,  3 Nov 2020 22:11:01 +0100
Message-Id: <20201103211101.4221-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After the rwsem replaced the tree lock implementation, the extent buffer
got smaller but leaving some holes behind. By changing log_index type
and reordering, we can squeeze the size further to 240 bytes, measured on
release config on x86_64. Log_index spans only 3 values and needs to be
signed.

Before:

struct extent_buffer {
        u64                        start;                /*     0     8 */
        long unsigned int          len;                  /*     8     8 */
        long unsigned int          bflags;               /*    16     8 */
        struct btrfs_fs_info *     fs_info;              /*    24     8 */
        spinlock_t                 refs_lock;            /*    32     4 */
        atomic_t                   refs;                 /*    36     4 */
        atomic_t                   io_pages;             /*    40     4 */
        int                        read_mirror;          /*    44     4 */
        struct callback_head       callback_head __attribute__((__aligned__(8))); /*    48    16 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        pid_t                      lock_owner;           /*    64     4 */
        bool                       lock_recursed;        /*    68     1 */

        /* XXX 3 bytes hole, try to pack */

        struct rw_semaphore        lock;                 /*    72    40 */
        short int                  log_index;            /*   112     2 */

        /* XXX 6 bytes hole, try to pack */

        struct page *              pages[16];            /*   120   128 */

        /* size: 248, cachelines: 4, members: 14 */
        /* sum members: 239, holes: 2, sum holes: 9 */
        /* forced alignments: 1 */
        /* last cacheline: 56 bytes */
} __attribute__((__aligned__(8)));

After:

struct extent_buffer {
        u64                        start;                /*     0     8 */
        long unsigned int          len;                  /*     8     8 */
        long unsigned int          bflags;               /*    16     8 */
        struct btrfs_fs_info *     fs_info;              /*    24     8 */
        spinlock_t                 refs_lock;            /*    32     4 */
        atomic_t                   refs;                 /*    36     4 */
        atomic_t                   io_pages;             /*    40     4 */
        int                        read_mirror;          /*    44     4 */
        struct callback_head       callback_head __attribute__((__aligned__(8))); /*    48    16 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        pid_t                      lock_owner;           /*    64     4 */
        bool                       lock_recursed;        /*    68     1 */
        s8                         log_index;            /*    69     1 */

        /* XXX 2 bytes hole, try to pack */

        struct rw_semaphore        lock;                 /*    72    40 */
        struct page *              pages[16];            /*   112   128 */

        /* size: 240, cachelines: 4, members: 14 */
        /* sum members: 238, holes: 1, sum holes: 2 */
        /* forced alignments: 1 */
        /* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 5403354de0e1..3c2bf21c54eb 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -88,10 +88,10 @@ struct extent_buffer {
 	struct rcu_head rcu_head;
 	pid_t lock_owner;
 	bool lock_recursed;
-	struct rw_semaphore lock;
-
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
-	short log_index;
+	s8 log_index;
+
+	struct rw_semaphore lock;
 
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
 #ifdef CONFIG_BTRFS_DEBUG
-- 
2.25.0

