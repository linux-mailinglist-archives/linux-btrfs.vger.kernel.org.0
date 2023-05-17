Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F15706601
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 13:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjEQLEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 07:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEQLEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 07:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525154EDB
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 04:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A123C63B0C
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976C4C4339B
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684321348;
        bh=S3yK+ALhR8eFWZ39I6B/SF1N9a+mamT9WB2ZBgF3WBU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o/88mspHxVglrYqoy7+MfCLU500McVmCUzb6IUo2MDisobvY0pG+jj09zRQhtpINU
         aMJ+FoL72HvUFE2txsX7C8RcJVHwMEF5zf+Flp7Q3v9EApaw/rVI8mYqzzcsmwOoqe
         fAYeO037JqtetETlHPKpdxW7lUrkApRHBG+QDzBbagOa+XftIW2zcTKt9dHEciw++a
         fCvJ3iBcdL32xmlySU+mg91u1woUJQTj9egLPl1BZgzcJUYysVW1mIyPEv+I64ojDL
         OfD/pmvIkADJ413OxwZPr4i+TDgyuW/pK0E+uopEiM5GLKj348SG1zUQykiA3sX/j6
         07cldm7fgQOEg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: use inode_logged() at btrfs_record_unlink_dir()
Date:   Wed, 17 May 2023 12:02:13 +0100
Message-Id: <f0833d43a2c7c4e29a54dd1dc48719537965e273.1684320689.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684320689.git.fdmanana@suse.com>
References: <cover.1684320689.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_record_unlink_dir() we directly check the logged_trans field of
the given inodes to check if they were previously logged in the current
transaction, and if any of them were, then we can avoid setting the field
last_unlink_trans of the directory to the id of the current transaction if
we are in a rename path. Avoiding that can later prevent falling back to
a transaction commit if anyone attempts to log the directory.

However the logged_trans field, store in struct btrfs_inode, is transient,
not persisted in the inode item on its subvolume b+tree, so that means
that if an inode is evicted and then loaded again, its original value is
lost and it's reset to 0. So directly checking the logged_trans field can
lead to some false negative, and that only results in a performance impact
as mentioned before.

Intead of directly checking the logged_trans field of the inodes, use the
inode_logged() helper, which will check in the log tree if an inode was
logged before in case its logged_trans field has a value of 0. This way
we can avoid setting the directory inode's last_unlink_trans and cause
future logging attempts of it to fallback to transaction commits. The
following test script shows one example where this happens without this
patch:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/nullb0
  MNT=/mnt/nullb0

  num_init_files=10000
  num_new_files=10000

  mkfs.btrfs -f $DEV
  mount -o ssd $DEV $MNT

  mkdir $MNT/testdir
  for ((i = 1; i <= $num_init_files; i++)); do
      echo -n > $MNT/testdir/file_$i
   done

  echo -n > $MNT/testdir/foo

  sync

  # Add some files so that there's more work in the transaction other
  # than just renaming file foo.
  for ((i = 1; i <= $num_new_files; i++)); do
      echo -n > $MNT/testdir/new_file_$i
  done

  # Change the file, fsync it.
  setfattr -n user.x1 -v 123 $MNT/testdir/foo
  xfs_io -c "fsync" $MNT/testdir/foo

  # Now triggger eviction of file foo but no eviction for our test
  # directory, since it is being used by the process below. This will
  # set logged_trans of the file's inode to 0 once it is loaded again.
  (
      cd $MNT/testdir
      while true; do
          :
      done
  ) &
  pid=$!

  echo 2 > /proc/sys/vm/drop_caches

  kill $pid
  wait $pid

  # Move foo out of our testdir. This will set last_unlink_trans
  # of the directory inode to the current transaction, because
  # logged_trans of both the directory and the file are set to 0.
  mv $MNT/testdir/foo $MNT/foo

  # Change file foo again and fsync it.
  # This fsync will result in a transaction commit because the rename
  # above has set last_unlink_trans of the parent directory to the id
  # of the current transaction and because our inode for file foo has
  # last_unlink_trans set to the current transaction, since it was
  # evicted and reloaded and it was previously modified in the current
  # transaction (the xattr addition).
  xfs_io -c "pwrite 0 64K" $MNT/foo
  start=$(date +%s%N)
  xfs_io -c "fsync" $MNT/foo
  end=$(date +%s%N)
  dur=$(( (end - start) / 1000000 ))

  echo "file fsync took: $dur milliseconds"

  umount $MNT

Before this patch:   fsync took 19 milliseconds
After this patch:    fsync took  5 milliseconds

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ccdfe1d95572..42fe2d0b29e0 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7329,14 +7329,14 @@ void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
 	 * if this directory was already logged any new
 	 * names for this file/dir will get recorded
 	 */
-	if (dir->logged_trans == trans->transid)
+	if (inode_logged(trans, dir, NULL) == 1)
 		return;
 
 	/*
 	 * if the inode we're about to unlink was logged,
 	 * the log will be properly updated for any new names
 	 */
-	if (inode->logged_trans == trans->transid)
+	if (inode_logged(trans, inode, NULL) == 1)
 		return;
 
 	/*
-- 
2.34.1

