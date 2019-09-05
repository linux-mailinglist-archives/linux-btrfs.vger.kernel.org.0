Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39092AA76B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 17:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390477AbfIEPhI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 11:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388335AbfIEPhI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Sep 2019 11:37:08 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9823E20828;
        Thu,  5 Sep 2019 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567697828;
        bh=+W1BY/EtR8a9G4Jb7Qnox9TwmniLLAShERHFTDWN7T4=;
        h=From:To:Cc:Subject:Date:From;
        b=s5bXNhvBzsvWzxj/knlY8QXtsh6cIGCBaGouow4o76RQBSmYE0FJ+QEL8AeDkPrNB
         iavJk045DLQ9Kv6fsN3FVe6r7tyrO63F99VBZoX+oNMRNpE5bUx+tUYxfrWE0w1zK3
         iJ123w1D/o/ZMw5YoCDqFQrgm2IuSAChVLRkxnag=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/048: fix test failure when fs mounted with v2 space cache option
Date:   Thu,  5 Sep 2019 16:37:00 +0100
Message-Id: <20190905153700.21284-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In order to check that the filesystem generation does not change after
failure to set a property, the test expects a specific generation number
of 7 in its golden output. That currently works except when using the
v2 space cache mount option (MOUNT_OPTIONS="-o space_cache=v2"), since
the filesystem generation is 8 because creating a v2 space cache adds
an additional transaction commit. So update the test to not hardcode
specific generation numbers in its golden output and just output an
unexpected message if the generation number changes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/048     | 5 +++--
 tests/btrfs/048.out | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/048 b/tests/btrfs/048
index 7294f231..7c9eaa05 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -221,10 +221,11 @@ $BTRFS_UTIL_PROG property get $SCRATCH_MNT compression
 
 echo -e "\nTesting generation is unchanged after failed validation"
 $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
-$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^generation'
+gen_before=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^generation')
 $BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' 2>&1 | _filter_scratch
 $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
-$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^generation'
+gen_after=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^generation')
+[ "$gen_after" == "$gen_before" ] || echo "filesystem generation changed"
 
 echo -e "\nTesting argument validation with options"
 $BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zlib:3'
diff --git a/tests/btrfs/048.out b/tests/btrfs/048.out
index 0923b00c..cc12e329 100644
--- a/tests/btrfs/048.out
+++ b/tests/btrfs/048.out
@@ -89,9 +89,7 @@ ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
 compression=lzo
 
 Testing generation is unchanged after failed validation
-generation		7
 ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
-generation		7
 
 Testing argument validation with options
 ***
-- 
2.11.0

