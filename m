Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4617F7065FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjEQLEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 07:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjEQLED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 07:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136125BA1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 04:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF68863A7C
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF277C433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684321347;
        bh=VuPzbZHi21lEp6n2RWoLNys0lYkbagfDtAW9BMG8Ui0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pyHZM72fx56hQzCDOMbqiCuUe28YJ6iCfFeZXAHwyp0shW8ESvfp96oaaJlD0iebm
         rjx5wuySotCiSVrRi6x2aNbasvFxPOdz4nU1tqblLvUCLbOWbi19d72hZttzHmz7Jp
         j7Y8MYxyHrz653gB2bFoIFs2LOAMbnuk5+vQPhOkVDbC6GOizHiPJcSqvOudqlVaPT
         Z6r1R1SAhM0rOJxTtGF5sgl9UdkgfTe9giD+JQioBBlcih6EM4ZrOuLgKowkGhipoG
         ALjQVSqsHREtM/RwuC6el/ULrIpcw1APiFC3E4zMS44SEsLiq/xESEVTUN0lhoXZKY
         dD0bJEZ2kzCRQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: use inode_logged() at need_log_inode()
Date:   Wed, 17 May 2023 12:02:12 +0100
Message-Id: <29350541f39b3bac1636b8e9772c7303923813eb.1684320689.git.fdmanana@suse.com>
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

At need_log_inode() we directly check the ->logged_trans field of the
given inode to check if it was previously logged in the transaction, with
the goal of skipping logging the inode again when it's not necessary.
The ->logged_trans field in not persisted in the inode item or elsewhere,
it's only stored in memory (struct btrfs_inode), so it's transient and
lost once the inode is evicted and then loaded again. Once an inode is
loaded, we are conservative and set ->logged_trans to 0, which may mean
that either the inode was never logged in the current transaction or it
was logged but evicted before being loaded again.

Instead of checking the inode's ->logged_trans field directly, we can
use instead the helper inode_logged(), which will really check if the
inode was logged before in the current transaction in case we have a
->logged_trans field with a value of 0. This will prevent unnecessarily
logging an inode when it's not needed, and in some cases preventing a
transaction commit, in case the logging requires a fallback to a
transaction commit. The following test script shows a scenario where
due to eviction we fallback a transaction commit when trying to fsync
a file that was renamed:

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

  # Fsync the directory first.
  xfs_io -c "fsync" $MNT/testdir

  # Rename file foo.
  mv $MNT/testdir/foo $MNT/testdir/bar

  # Now triggger eviction of the test directory's inode.
  # Once loaded again, it will have logged_trans set to 0 and
  # last_unlink_trans set to the current transaction.
  echo 2 > /proc/sys/vm/drop_caches

  # Fsync file bar (ex-foo).
  # Before the patch the fsync would result in a transaction commit
  # because the inode for file bar has last_unlink_trans set to the
  # current transaction, so it will attempt to log the parent directory
  # as well, which will fallback to a full transaction commit because
  # it also has its last_unlink_trans set to the current transaction,
  # due to the inode eviction.
  start=$(date +%s%N)
  xfs_io -c "fsync" $MNT/testdir/bar
  end=$(date +%s%N)
  dur=$(( (end - start) / 1000000 ))

  echo "file fsync took: $dur milliseconds"

  umount $MNT

Before this patch:  fsync took 22 milliseconds
After this patch:   fsync took  8 milliseconds

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9b212e8c70cc..ccdfe1d95572 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3252,7 +3252,7 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
  * Returns 1 if the inode was logged before in the transaction, 0 if it was not,
  * and < 0 on error.
  */
-static int inode_logged(struct btrfs_trans_handle *trans,
+static int inode_logged(const struct btrfs_trans_handle *trans,
 			struct btrfs_inode *inode,
 			struct btrfs_path *path_in)
 {
@@ -5303,7 +5303,7 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
  * multiple times when multiple tasks have joined the same log transaction.
  */
 static bool need_log_inode(const struct btrfs_trans_handle *trans,
-			   const struct btrfs_inode *inode)
+			   struct btrfs_inode *inode)
 {
 	/*
 	 * If a directory was not modified, no dentries added or removed, we can
@@ -5321,7 +5321,7 @@ static bool need_log_inode(const struct btrfs_trans_handle *trans,
 	 * logged_trans will be 0, in which case we have to fully log it since
 	 * logged_trans is a transient field, not persisted.
 	 */
-	if (inode->logged_trans == trans->transid &&
+	if (inode_logged(trans, inode, NULL) == 1 &&
 	    !test_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags))
 		return false;
 
-- 
2.34.1

