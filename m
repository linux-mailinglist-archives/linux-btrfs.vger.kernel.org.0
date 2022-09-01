Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0A5A9FA3
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiIATLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 15:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiIATLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 15:11:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D6417E03;
        Thu,  1 Sep 2022 12:11:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B77F20485;
        Thu,  1 Sep 2022 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662059464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=ogKYoxob8wRiQa/UCeHnxAd7biELnk2bNLuKhEBTl8A=;
        b=kU1QLQ7WXZB3+fXpLeEURm54Vm5IdtOhrr2sOqnKwpa3oGt6gN9OVtWBDlacNfU8f49SJK
        GdIuhyWNBz/Oqb/rR5ThB7GBnV6xZofIZout/Cj7fI6ibeW3HMjA2xNis2ARgABlTq7Nk8
        2LBBzfXbTSqGHS12Y8Tx9kEUXI6WWp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662059464;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=ogKYoxob8wRiQa/UCeHnxAd7biELnk2bNLuKhEBTl8A=;
        b=kZar/ODc2A5Jt8chfX15GQ0T3aRcpiGh3Whfw1HnvORDn+b5iG2goizve39b56XctkKSgJ
        QUlmRLK2yrZ18jAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 420AD13A79;
        Thu,  1 Sep 2022 19:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dLE5CMgDEWO+VQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 01 Sep 2022 19:11:04 +0000
Date:   Thu, 1 Sep 2022 14:11:02 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>
Subject: [PATCH v2] btrfs: test security xattr changes for RO btrfs property
Message-ID: <20220901191102.zryecg6n635z6p5o@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test creation, modification and deletion of xattr for a BTRFS filesystem
which has the read-only property set to true.

Re-test the same after read-only property is set to false.

This tests the bug for "security.*" modifications which escape
xattr_permission(), because security parameters are usually let through
in xattr_permission, without checking
inode_permission()->btrfs_permission().

Signed-off-by: Filipe Manana <fdmanana@kernel.org>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/tests/btrfs/275 b/tests/btrfs/275
new file mode 100755
index 00000000..f7b10b18
--- /dev/null
+++ b/tests/btrfs/275
@@ -0,0 +1,85 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 275
+#
+# Test that no xattr can be changed once btrfs property is set to RO
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
+_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+FILENAME=$SCRATCH_MNT/foo
+
+set_xattr() {
+	local value=$1
+	$SETFATTR_PROG -n "user.one" -v $value $FILENAME 2>&1 | _filter_scratch
+	$SETFATTR_PROG -n "security.one" -v $value $FILENAME 2>&1 | _filter_scratch
+	$SETFATTR_PROG -n "trusted.one" -v $value $FILENAME 2>&1 | _filter_scratch
+}
+
+get_xattr() {
+	$GETFATTR_PROG --absolute-names -n "user.one" $FILENAME 2>&1 | _filter_scratch
+	$GETFATTR_PROG --absolute-names -n "security.one" $FILENAME 2>&1 | _filter_scratch
+	$GETFATTR_PROG --absolute-names -n "trusted.one" $FILENAME 2>&1 | _filter_scratch
+}
+
+del_xattr() {
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
+# Attempt to change values of RO (property) filesystem
+set_xattr 2
+
+# Check the values of RO (property) filesystem are not changed
+get_xattr
+
+# Attempt to remove xattr from RO (property) filesystem
+del_xattr
+
+# Check if xattr still exist
+get_xattr
+
+# Change filesystem property RO to false
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro false
+$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
+
+# Change the xattrs after RO is false
+set_xattr 2
+
+# Get the changed values
+get_xattr
+
+# Remove xattr
+del_xattr
+
+# check if the xattrs are really deleted
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
Goldwyn
