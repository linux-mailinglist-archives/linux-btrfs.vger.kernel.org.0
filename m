Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D53E9A84
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 11:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfJ3K4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 06:56:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:37680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfJ3K4v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 06:56:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67CA8AD12;
        Wed, 30 Oct 2019 10:56:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 15CB4DA783; Wed, 30 Oct 2019 11:56:59 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/5] btrfs: set blocking_writers directly, no increment or decrement
Date:   Wed, 30 Oct 2019 11:56:59 +0100
Message-Id: <56aee34d4d33bde65a9bea6e6d51fc272bee6bbf.1572432768.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572432768.git.dsterba@suse.com>
References: <cover.1572432768.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The increment and decrement was inherited from previous version that
used atomics, switched in commit 06297d8cefca ("btrfs: switch
extent_buffer blocking_writers from atomic to int"). The only possible
values are 0 and 1 so we can set them directly.

The generated assembly (gcc 9.x) did the direct value assignment in
btrfs_set_lock_blocking_write (asm diff after change in 06297d8cefca):

     5d:   test   %eax,%eax
     5f:   je     62 <btrfs_set_lock_blocking_write+0x22>
     61:   retq

  -  62:   lock incl 0x44(%rdi)
  -  66:   add    $0x50,%rdi
  -  6a:   jmpq   6f <btrfs_set_lock_blocking_write+0x2f>

  +  62:   movl   $0x1,0x44(%rdi)
  +  69:   add    $0x50,%rdi
  +  6d:   jmpq   72 <btrfs_set_lock_blocking_write+0x32>

The part in btrfs_tree_unlock did a decrement because
BUG_ON(blockers > 1) is probably not a strong hint for the compiler, but
otherwise the output looks safe:

  - lock decl 0x44(%rdi)

  + sub    $0x1,%eax
  + mov    %eax,0x44(%rdi)

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/locking.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index c84c650e56c7..00edf91c3d1c 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -109,7 +109,7 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
 	if (eb->blocking_writers == 0) {
 		btrfs_assert_spinning_writers_put(eb);
 		btrfs_assert_tree_locked(eb);
-		eb->blocking_writers++;
+		eb->blocking_writers = 1;
 		write_unlock(&eb->lock);
 	}
 }
@@ -305,7 +305,7 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
 
 	if (blockers) {
 		btrfs_assert_no_spinning_writers(eb);
-		eb->blocking_writers--;
+		eb->blocking_writers = 0;
 		/*
 		 * We need to order modifying blocking_writers above with
 		 * actually waking up the sleepers to ensure they see the
-- 
2.23.0

