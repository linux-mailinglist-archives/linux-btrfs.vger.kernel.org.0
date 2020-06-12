Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094C61F7946
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 16:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFLOGM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 10:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLOGL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 10:06:11 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCC2A2074B;
        Fri, 12 Jun 2020 14:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591970771;
        bh=JkKW22SrwBGg1YIfUL+6cuQmj0l7tbRU8LUoVMzxXo8=;
        h=From:To:Cc:Subject:Date:From;
        b=zmgVVD5hDadZ3XlphcrwdHrfLlSIIPpaK/VTz/PwpWfRobEtalZWvrRYPCSUrkZC6
         qg5jYqwWDnZcIF4Wa/laQytOedF3gYiBHDCY8m7l4F+0cgIm+kXTAbmhGmWrWop90l
         A2vlq3Azg7OAoEJyeG4axCcZbv9mgz6PZ7IAqx5g=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/471: adapt test when running on btrfs to avoid failure on RWF_NOWAIT write
Date:   Fri, 12 Jun 2020 15:06:03 +0100
Message-Id: <20200612140604.2790275-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This test currently always fails on btrfs:

generic/471 2s ... - output mismatch (see ...results//generic/471.out.bad)
    --- tests/generic/471.out   2020-06-10 19:29:03.850519863 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//generic/471.out.bad   ...
    @@ -2,12 +2,10 @@
     pwrite: Resource temporarily unavailable
     wrote 8388608/8388608 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -RWF_NOWAIT time is within limits.
    +pwrite: Resource temporarily unavailable
    +(standard_in) 1: syntax error
    +RWF_NOWAIT took  seconds

This is because btrfs is a COW filesystem and an attempt to write into a
previously written file range allocating a new extent (or multiple).
The only exceptions are when attempting to write to a file range with a
preallocated/unwritten extent or when writing to a NOCOW file that has
extents allocated in the target range already.

The test currently expects that writing into a previously written file
range succeeds, but that is not true on btrfs since we are not dealing
with a NOCOW file. So to make the test pass on btrfs, set the NOCOW bit
on the file when the filesystem is btrfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/471 | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/generic/471 b/tests/generic/471
index 7513f023..e9856b52 100755
--- a/tests/generic/471
+++ b/tests/generic/471
@@ -37,6 +37,17 @@ fi
 
 mkdir $testdir
 
+# Btrfs is a COW filesystem, so a RWF_NOWAIT write will always fail with -EAGAIN
+# when writing to a file range except if it's a NOCOW file and an extent for the
+# range already exists or if it's a COW file and preallocated/unwritten extent
+# exists in the target range. So to make sure that the last write succeeds on
+# all filesystems, use a NOCOW file on btrfs.
+if [ $FSTYP == "btrfs" ]; then
+	_require_chattr C
+	touch $testdir/f1
+	$CHATTR_PROG +C $testdir/f1
+fi
+
 # Create a file with pwrite nowait (will fail with EAGAIN)
 $XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 1M 0 1M" $testdir/f1
 
-- 
2.26.2

