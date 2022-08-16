Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F1D5964D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 23:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiHPVk6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 17:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiHPVk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 17:40:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53014753A7;
        Tue, 16 Aug 2022 14:40:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD1001F385;
        Tue, 16 Aug 2022 21:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660686053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=vT5KSQeyPFq+/ZMvtSMzDrveJluLKoELYbO+MruC5QA=;
        b=QrAmCQyg/sAqn+0GtB313n4gmXQ4q30ACzWc+O6XtGtJtC40HklfL466YCbAZKw/LaSegK
        DRGxq677fKHNoVN4QXcnWI8NAMN6cOL7+JEmUMCnAnfglTSkWZ6sMp03pCL/m84HXQx/Vk
        OtbZlYMB1IYgE/hKE1yII7HgVrlAnl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660686053;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=vT5KSQeyPFq+/ZMvtSMzDrveJluLKoELYbO+MruC5QA=;
        b=8WC+/5bP+dNgkMX+3EGOJA54W6AdvoFpi7dHdwPKJwXUnhD2TlY53nNT1PSNG0SNGlp6A0
        +ChQhSrAV+MAryAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 528B21345B;
        Tue, 16 Aug 2022 21:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PinjCuUO/GK+IAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 16 Aug 2022 21:40:53 +0000
Date:   Tue, 16 Aug 2022 16:40:51 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH] btrfs: Test xattr changes for read-only btrfs property
Message-ID: <20220816214051.wsw75y3mtjdsim6w@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test creation, modification and deletion of xattr for a BTRFS filesystem
which has the read-only property set to true.

Re-test the same after BTRFS read-only property is set to false.

This tests the bug for "security.*" modifications which escape
xattr_permission(), because security parameters are let through
in xattr_permission(), without checks from
inode_permission()->btrfs_permission(). There is no restriction on
security.* from VFS and decision is left to the underlying filesystem.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/tests/btrfs/273 b/tests/btrfs/273
new file mode 100755
index 00000000..ec7d264d
--- /dev/null
+++ b/tests/btrfs/273
@@ -0,0 +1,78 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 273
+#
+# Test that no xattr can be changed once btrfs property is set to RO
+#
+. ./common/preamble
+_begin_fstest auto quick attr
+
+# Import common functions.
+#. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs btrfs
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
+	$SETFATTR_PROG -n "user.one" -v $value $FILENAME
+	$SETFATTR_PROG -n "security.one" -v $value $FILENAME
+	$SETFATTR_PROG -n "trusted.one" -v $value $FILENAME
+}
+
+get_xattr() {
+	$GETFATTR_PROG -n "user.one" $FILENAME
+	$GETFATTR_PROG -n "security.one" $FILENAME
+	$GETFATTR_PROG -n "trusted.one" $FILENAME
+}
+
+del_xattr() {
+	$SETFATTR_PROG -x "user.one" $FILENAME
+	$SETFATTR_PROG -x "security.one" $FILENAME
+	$SETFATTR_PROG -x "trusted.one" $FILENAME
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
+# Check the values of RO (property) filesystem is not changed
+get_xattr
+
+# Attempt to remove xattr from RO (property) filesystem
+del_xattr
+
+# Change filesystem property RO to false
+
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
+status=0
+exit
diff --git a/tests/btrfs/273.out b/tests/btrfs/273.out
new file mode 100644
index 00000000..f6fca029
--- /dev/null
+++ b/tests/btrfs/273.out
@@ -0,0 +1,33 @@
+QA output created by 273
+ro=true
+setfattr: /scratch/foo: Read-only file system
+setfattr: /scratch/foo: Read-only file system
+setfattr: /scratch/foo: Read-only file system
+getfattr: Removing leading '/' from absolute path names
+# file: scratch/foo
+user.one="1"
+
+getfattr: Removing leading '/' from absolute path names
+# file: scratch/foo
+security.one="1"
+
+getfattr: Removing leading '/' from absolute path names
+# file: scratch/foo
+trusted.one="1"
+
+setfattr: /scratch/foo: Read-only file system
+setfattr: /scratch/foo: Read-only file system
+setfattr: /scratch/foo: Read-only file system
+ro=false
+getfattr: Removing leading '/' from absolute path names
+# file: scratch/foo
+user.one="2"
+
+getfattr: Removing leading '/' from absolute path names
+# file: scratch/foo
+security.one="2"
+
+getfattr: Removing leading '/' from absolute path names
+# file: scratch/foo
+trusted.one="2"
+

-- 
Goldwyn
