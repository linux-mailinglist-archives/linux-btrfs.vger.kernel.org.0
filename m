Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66FA3A110C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbhFIK1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 06:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238822AbhFIK1A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Jun 2021 06:27:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7131D611AE
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Jun 2021 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623234305;
        bh=Y6/yukhuI/BKqJsy3yEgvNcBrI/5DnUyPndrMmiKbWo=;
        h=From:To:Subject:Date:From;
        b=Va+VGhlSg5ReMwDXWT9yZJwQWeChr1Z1bbstXUpwL+p87efVdwWeJoe20BWLqaJ02
         CA4blYDMynYwwQTLPeG/rjrP86Zf54r+O7Q7RoDbuMqjIMwFk9CMQLBT5tsVjbHv6c
         EeCTj3dYYNDFTPLCxGw53hjOOKiJYTRqxEgRm51fT7sep/NlciNPYFMt38bDzspjjP
         j5vpiAng+GcNugecDkBFXE+g0ljRpkqQbgjsoTEohzAGt2o1JE5/1uh08ac6w4l/SA
         AKTHxLKT3BGlZKIcDssvAcvKbFDdXOIGuu3SnOUQB+Hl2lJBf7yv1XW6Z8OwmLFK3h
         k300w/b0/u8nQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: fix invalid path for unlink operations after parent orphanization
Date:   Wed,  9 Jun 2021 11:25:03 +0100
Message-Id: <375bc37e9eb10cef96fe9f37d89b598737943499.1623234153.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During an incremental send operation, when processing the new references
for the current inode, we might send an unlink operation for another inode
that has a conflicting path and has more than one hard link. However this
path was computed and cached before we processed previous new references
for the current inode. We may have orphanized a directory of that path
while processing a previous new reference, in which case the path will
be invalid and cause the receiver process to fail.

The following reproducer triggers the problem and explains how/why it
happens in its comments:

  $ cat test-send-unlink.sh
  #!/bin/bash

  DEV=/dev/sdi
  MNT=/mnt/sdi

  mkfs.btrfs -f $DEV >/dev/null
  mount $DEV $MNT

  # Create our test files and directory. Inode 259 (file3) has two hard
  # links.
  touch $MNT/file1
  touch $MNT/file2
  touch $MNT/file3

  mkdir $MNT/A
  ln $MNT/file3 $MNT/A/hard_link

  # Filesystem looks like:
  #
  # .                                     (ino 256)
  # |----- file1                          (ino 257)
  # |----- file2                          (ino 258)
  # |----- file3                          (ino 259)
  # |----- A/                             (ino 260)
  #        |---- hard_link                (ino 259)
  #

  # Now create the base snapshot, which is going to be the parent snapshot
  # for a later incremental send.
  btrfs subvolume snapshot -r $MNT $MNT/snap1
  btrfs send -f /tmp/snap1.send $MNT/snap1

  # Move inode 257 into directory inode 260. This results in computing the
  # path for inode 260 as "/A" and caching it.
  mv $MNT/file1 $MNT/A/file1

  # Move inode 258 (file2) into directory inode 260, with a name of
  # "hard_link", moving first inode 259 away since it currently has that
  # location and name.
  mv $MNT/A/hard_link $MNT/tmp
  mv $MNT/file2 $MNT/A/hard_link

  # Now rename inode 260 to something else (B for example) and then create
  # a hard link for inode 258 that has the old name and location of inode
  # 260 ("/A").
  mv $MNT/A $MNT/B
  ln $MNT/B/hard_link $MNT/A

  # Filesystem now looks like:
  #
  # .                                     (ino 256)
  # |----- tmp                            (ino 259)
  # |----- file3                          (ino 259)
  # |----- B/                             (ino 260)
  # |      |---- file1                    (ino 257)
  # |      |---- hard_link                (ino 258)
  # |
  # |----- A                              (ino 258)

  # Create another snapshot of our subvolume and use it for an incremental
  # send.
  btrfs subvolume snapshot -r $MNT $MNT/snap2
  btrfs send -f /tmp/snap2.send -p $MNT/snap1 $MNT/snap2

  # Now unmount the filesystem, create a new one, mount it and try to
  # apply both send streams to recreate both snapshots.
  umount $DEV

  mkfs.btrfs -f $DEV >/dev/null

  mount $DEV $MNT

  # First add the first snapshot to the new filesystem by applying the
  # first send stream.
  btrfs receive -f /tmp/snap1.send $MNT

  # The incremental receive operation below used to fail with the
  # following error:
  #
  #    ERROR: unlink A/hard_link failed: No such file or directory
  #
  # This is because when send is processing inode 257, it generates the
  # path for inode 260 as "/A", since that inode is its parent in the send
  # snapshot, and caches that path.
  #
  # Later when processing inode 258, it first processes its new reference
  # that has the path of "/A", which results in orphanizing inode 260
  # because there is a a path collision. This results in issuing a rename
  # operation from "/A" to "/o260-6-0".
  #
  # Finally when processing the new reference "B/hard_link" for inode 258,
  # it notices that it collides with inode 259 (not yet processed, because
  # it has a higher inode number), since that inode has the name
  # "hard_link" under the directory inode 260. It also checks that inode
  # 259 has two hardlinks, so it decides to issue a unlink operation for
  # the name "hard_link" for inode 259. However the path passed to the
  # unlink operation is "/A/hard_link", which is incorrect since currently
  # "/A" does not exists, due to the orphanization of inode 260 mentioned
  # before. The path is incorrect because it was computed and cached
  # before the orphanization. This results in the receiver to fail with
  # the above error.
  btrfs receive -f /tmp/snap2.send $MNT

  umount $MNT

When running the test, it fails like this:

  $ ./test-send-unlink.sh
  Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap1'
  At subvol /mnt/sdi/snap1
  Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap2'
  At subvol /mnt/sdi/snap2
  At subvol snap1
  At snapshot snap2
  ERROR: unlink A/hard_link failed: No such file or directory

Fix this by recomputing a path before issuing an unlink operation when
processing the new references for the current inode if we previously
have orphanized a directory.

A test case for fstests will follow soon.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index bd69db72acc5..a2b3c594379d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4064,6 +4064,17 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				if (ret < 0)
 					goto out;
 			} else {
+				/*
+				 * If we previously orphanized a directory that
+				 * collided with a new reference that we already
+				 * processed, recompute the current path because
+				 * that directory may be part of the path.
+				 */
+				if (orphanized_dir) {
+					ret = refresh_ref_path(sctx, cur);
+					if (ret < 0)
+						goto out;
+				}
 				ret = send_unlink(sctx, cur->full_path);
 				if (ret < 0)
 					goto out;
-- 
2.28.0

