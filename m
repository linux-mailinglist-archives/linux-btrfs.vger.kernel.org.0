Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B455E5F20
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 11:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIVJ5u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 05:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiIVJ5b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 05:57:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EE2D588B;
        Thu, 22 Sep 2022 02:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D03A62A76;
        Thu, 22 Sep 2022 09:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427DFC433C1;
        Thu, 22 Sep 2022 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663840608;
        bh=VtYkk0Ypp5yIicNdyTKDZkygxgNf34JOHxEO/4r84rY=;
        h=From:To:Cc:Subject:Date:From;
        b=D8b8wolEJGmktXKNN/DnqGcK9+iC67LETzmm5IqEorkjd9uYjz3cFLWVVUZns+Evz
         10qi1EuqVKsgwlX84hlLPJ/dYf76/oovV4bVSG/Afzl7XtKiiTK9YsoY1v0c1q8sWq
         xFAOXO2UJfC4JVOVieF/mMOTqRDR4znnCbCG5BmS9PLF/3pMS76kPdDzleFfK7BRB5
         2dE6g2f0j70euF0f1VVbwSMfV4ns0EKkbBslp55qik+20lE4930QGWIN7GDBxwPkOg
         cjLqrQfPPc4aP5Cb7MORH03/bZpKzE1/vdf2JbUESg8I3b9TO+4rBgJ8OsQyhuciGV
         kuxfEbKtiIx+g==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Filipe Manana <fdmanana@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v3] btrfs: test xattr changes for RO btrfs property
Date:   Thu, 22 Sep 2022 10:56:39 +0100
Message-Id: <f72207b27052afc7dcbdf4fb7cf956fc37105724.1663840534.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.de>

Test creation, modification and deletion of xattr for a BTRFS filesystem
which has the read-only property set to true.

Re-test the same after read-only property is set to false.

This tests the bug for "security.*" modifications which escape
xattr_permission(), because security parameters are usually let through
in xattr_permission, without checking
inode_permission()->btrfs_permission().

This resulted in being able to change a security xattr on a RO subvolume
until it got fixed by kernel commit b51111271b03 ("btrfs: check if root
is readonly while setting security xattr").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---

V3: Use the _getfattr() helper.
    Redirect mkfs output to the .full file and remove the _fail call,
    which is an antipattern.

    Change the subject from:

    "btrfs: test security xattr changes for RO btrfs property"

    to:

    "btrfs: test xattr changes for RO btrfs property"

    Since it does not test only security xattrs.

 tests/btrfs/275     | 88 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/275.out | 39 ++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100755 tests/btrfs/275
 create mode 100644 tests/btrfs/275.out

diff --git a/tests/btrfs/275 b/tests/btrfs/275
new file mode 100755
index 00000000..b34fbda0
--- /dev/null
+++ b/tests/btrfs/275
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 275
+#
+# Test that no xattr can be changed once btrfs property is set to RO.
+#
+. ./common/preamble
+_begin_fstest auto quick attr
+
+# Import common functions.
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs btrfs
+_fixed_by_kernel_commit b51111271b03 \
+	"btrfs: check if root is readonly while setting security xattr"
+_require_attrs
+_require_btrfs_command "property"
+_require_scratch
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+FILENAME=$SCRATCH_MNT/foo
+
+set_xattr()
+{
+	local value=$1
+	$SETFATTR_PROG -n "user.one" -v $value $FILENAME 2>&1 | _filter_scratch
+	$SETFATTR_PROG -n "security.one" -v $value $FILENAME 2>&1 | _filter_scratch
+	$SETFATTR_PROG -n "trusted.one" -v $value $FILENAME 2>&1 | _filter_scratch
+}
+
+get_xattr()
+{
+	_getfattr --absolute-names -n "user.one" $FILENAME 2>&1 | _filter_scratch
+	_getfattr --absolute-names -n "security.one" $FILENAME 2>&1 | _filter_scratch
+	_getfattr --absolute-names -n "trusted.one" $FILENAME 2>&1 | _filter_scratch
+}
+
+del_xattr()
+{
+	$SETFATTR_PROG -x "user.one" $FILENAME 2>&1 | _filter_scratch
+	$SETFATTR_PROG -x "security.one" $FILENAME 2>&1 | _filter_scratch
+	$SETFATTR_PROG -x "trusted.one" $FILENAME 2>&1 | _filter_scratch
+}
+
+# Create a test file.
+echo "hello world" > $FILENAME
+
+set_xattr 1
+
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro true
+$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
+
+# Attempt to change values of RO (property) filesystem.
+set_xattr 2
+
+# Check the values of RO (property) filesystem are not changed.
+get_xattr
+
+# Attempt to remove xattr from RO (property) filesystem.
+del_xattr
+
+# Check if xattr still exist.
+get_xattr
+
+# Change filesystem property RO to false
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro false
+$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
+
+# Change the xattrs after RO is false.
+set_xattr 2
+
+# Get the changed values.
+get_xattr
+
+# Remove xattr.
+del_xattr
+
+# check if the xattrs are really deleted.
+get_xattr
+
+status=0
+exit
diff --git a/tests/btrfs/275.out b/tests/btrfs/275.out
new file mode 100644
index 00000000..fb8f02f8
--- /dev/null
+++ b/tests/btrfs/275.out
@@ -0,0 +1,39 @@
+QA output created by 275
+ro=true
+setfattr: SCRATCH_MNT/foo: Read-only file system
+setfattr: SCRATCH_MNT/foo: Read-only file system
+setfattr: SCRATCH_MNT/foo: Read-only file system
+# file: SCRATCH_MNT/foo
+user.one="1"
+
+# file: SCRATCH_MNT/foo
+security.one="1"
+
+# file: SCRATCH_MNT/foo
+trusted.one="1"
+
+setfattr: SCRATCH_MNT/foo: Read-only file system
+setfattr: SCRATCH_MNT/foo: Read-only file system
+setfattr: SCRATCH_MNT/foo: Read-only file system
+# file: SCRATCH_MNT/foo
+user.one="1"
+
+# file: SCRATCH_MNT/foo
+security.one="1"
+
+# file: SCRATCH_MNT/foo
+trusted.one="1"
+
+ro=false
+# file: SCRATCH_MNT/foo
+user.one="2"
+
+# file: SCRATCH_MNT/foo
+security.one="2"
+
+# file: SCRATCH_MNT/foo
+trusted.one="2"
+
+SCRATCH_MNT/foo: user.one: No such attribute
+SCRATCH_MNT/foo: security.one: No such attribute
+SCRATCH_MNT/foo: trusted.one: No such attribute
-- 
2.35.1

