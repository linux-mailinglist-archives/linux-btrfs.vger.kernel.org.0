Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 662B7E9A88
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 11:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfJ3K46 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 06:56:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:37736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbfJ3K45 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 06:56:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55B2DAD2B;
        Wed, 30 Oct 2019 10:56:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0EF36DA783; Wed, 30 Oct 2019 11:57:06 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 5/5] btrfs: locking: add lock assertions
Date:   Wed, 30 Oct 2019 11:57:06 +0100
Message-Id: <86d6b97f9a9f09b8ac2d1773295fbb1176e5a73a.1572432768.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572432768.git.dsterba@suse.com>
References: <cover.1572432768.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add assertions to locking functions where the we expect the lock to be
held. This must also respect the nesting, so write lock checks 'write'
while read lock only if the lock is held.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/locking.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 571c4826c428..147bf5d41962 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -195,6 +195,7 @@ static void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb) { }
  */
 void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
 {
+	lockdep_assert_held(&eb->lock);
 	trace_btrfs_set_lock_blocking_read(eb);
 	/*
 	 * No lock is required.  The lock owner may change if we have a read
@@ -219,6 +220,7 @@ void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
  */
 void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
 {
+	lockdep_assert_held_write(&eb->lock);
 	trace_btrfs_set_lock_blocking_write(eb);
 	/*
 	 * No lock is required.  The lock owner may change if we have a read
@@ -358,6 +360,7 @@ int btrfs_try_tree_write_lock(struct extent_buffer *eb)
  */
 void btrfs_tree_read_unlock(struct extent_buffer *eb)
 {
+	lockdep_assert_held(&eb->lock);
 	trace_btrfs_tree_read_unlock(eb);
 	/*
 	 * if we're nested, we have the write lock.  No new locking
-- 
2.23.0

