Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF440AC0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 12:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhINKzE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 06:55:04 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:39890 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhINKzD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 06:55:03 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id E18986C00899;
        Tue, 14 Sep 2021 13:53:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1631616824; bh=FX0U7DrwpjXVipBZs3nMuFQhx6o4xHCHUiPKWmPO5Hs=;
        h=From:To:Cc:Subject:Date;
        b=dDv7+Ig8tv1TfzwRrYpAdT7x10nOUTFDqno2R+sYrGKEWG3ev0vdFqyrrWteXuAhV
         zNYNumrWZVfHnipc1qQOvrB7GJRm+3Pk44PHrTCkixBBuHEKCY3RPmImqlf7S4VHuq
         f0qw6BVAH7wlSZwxGoWYFcxag5Yr3B53+rn/dmLU=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id D2F5F6C00894;
        Tue, 14 Sep 2021 13:53:44 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id q_EdT2icDpdj; Tue, 14 Sep 2021 13:53:44 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 8A45A6C0088F;
        Tue, 14 Sep 2021 13:53:44 +0300 (EEST)
Received: from mini.lan (unknown [117.89.173.253])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id E110C1BE00A6;
        Tue, 14 Sep 2021 13:53:42 +0300 (EEST)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH] btrfs: make btrfs_node_key static inline
Date:   Tue, 14 Sep 2021 18:53:35 +0800
Message-Id: <20210914105335.28760-1-l@damenly.su>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: +d1m5/RSeEqpi1ihQnnWBgczqTY6IuClpKemqX1UnXr9LyaNYEkKUw61mG9qLw+1vCM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It looks strange that btrfs_node_key is in struct-funcs.c.
So move it to ctree.h and make it static inline.

Signed-off-by: Su Yue <l@damenly.su>
---
 fs/btrfs/ctree.h        | 10 ++++++++--
 fs/btrfs/struct-funcs.c |  8 --------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 452e410adbf5..67340a74f9ed 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1939,8 +1939,14 @@ static inline unsigned long btrfs_node_key_ptr_offset(int nr)
 		sizeof(struct btrfs_key_ptr) * nr;
 }
 
-void btrfs_node_key(const struct extent_buffer *eb,
-		    struct btrfs_disk_key *disk_key, int nr);
+static inline void btrfs_node_key(const struct extent_buffer *eb,
+				  struct btrfs_disk_key *disk_key, int nr)
+{
+	unsigned long ptr = btrfs_node_key_ptr_offset(nr);
+	read_eb_member(eb, (struct btrfs_key_ptr *)ptr,
+		       struct btrfs_key_ptr, key, disk_key);
+
+}
 
 static inline void btrfs_set_node_key(const struct extent_buffer *eb,
 				      struct btrfs_disk_key *disk_key, int nr)
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index f429256f56db..7526005525cb 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -161,11 +161,3 @@ DEFINE_BTRFS_SETGET_BITS(8)
 DEFINE_BTRFS_SETGET_BITS(16)
 DEFINE_BTRFS_SETGET_BITS(32)
 DEFINE_BTRFS_SETGET_BITS(64)
-
-void btrfs_node_key(const struct extent_buffer *eb,
-		    struct btrfs_disk_key *disk_key, int nr)
-{
-	unsigned long ptr = btrfs_node_key_ptr_offset(nr);
-	read_eb_member(eb, (struct btrfs_key_ptr *)ptr,
-		       struct btrfs_key_ptr, key, disk_key);
-}
-- 
2.30.1

