Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3447C5EB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjJKUtx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 16:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjJKUtw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 16:49:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB72290
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 13:49:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F356021862
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 20:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697057388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QGQlrVMMzwBeslkfOMHYXLguWDXwrMq0x2+Xz+fydM=;
        b=dXwxogZB5A/5NRwY+f0Aycq0HSq4L1QrBHzUDlhPr0ReqBFJXCrtuVX+c4EYab+l+faxxc
        EF4efSdH7yfOwLzGsDxjX7PuyRleQDMKnDvWplWXos1sB2lkZfm/9rclrX3MFKYhBEVCsG
        4PIodd2nusqwwS5PhdMACAgeSd6W+/Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EE4E134F5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 20:49:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cB6UN2oKJ2XCJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 20:49:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs-progs: tests/mkfs: make sure rootdir inode got its attributes copied
Date:   Thu, 12 Oct 2023 07:19:26 +1030
Message-ID: <5a903beeeba5636be0895de0ce2592c483619334.1697057301.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697057301.git.wqu@suse.com>
References: <cover.1697057301.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 3.90
X-Spamd-Result: default: False [3.90 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_ONE(0.00)[1];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new test case would:

- Prepare two loopback devices
  One is for storing the source directory (on a btrfs).
  This is to ensure we can set xattr for the directory, as filesystems
  like tmpfs (mostly utilized by mktemp) is not supporting xattr.

  The other one is the real target fs where we call "mkfs.btrfs
  --rootdir" on.

- Create the source directory with the following contents:
  * rootdir inode attributs:
    # mode (750)
    # uid (1000)
    # gid (1000)
    # xattr (user.rootdir)
  * one regular file, with attributes:
    # xattr (user.foorbar)

- Execute "mkfs.btrfs --rootdir" and mount the new fs

- Verify the above attributes
  The target fs should have the same attributes, especially for the
  rootdir inode.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/027-rootdir-inode/test.sh | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100755 tests/mkfs-tests/027-rootdir-inode/test.sh

diff --git a/tests/mkfs-tests/027-rootdir-inode/test.sh b/tests/mkfs-tests/027-rootdir-inode/test.sh
new file mode 100755
index 000000000000..e5de1485cc87
--- /dev/null
+++ b/tests/mkfs-tests/027-rootdir-inode/test.sh
@@ -0,0 +1,60 @@
+#!/bin/bash
+# Test if "mkfs.btrfs --rootdir" would properly copy all the attributes of the
+# source directory.
+
+source "$TEST_TOP/common" || exit
+
+setup_root_helper
+# Here we need two devices, one as a temporaray btrfs, storing the source
+# directory. As we want to setup xattr, which is not supported by tmpfs
+# (most modern distros go tmpfs for /tmp).
+# So we have to put the source directory on a fs that supports xattr.
+#
+# Then the second fs is the real one we mkfs on.
+setup_loopdevs 2
+prepare_loopdevs
+
+tmp_dev=${loopdevs[1]}
+real_dev=${loopdevs[2]}
+
+check_global_prereq setfattr
+check_global_prereq getfattr
+
+# Here we don't want to use /tmp, as it's pretty common /tmp is tmpfs, which
+# doesn't support xattr.
+# Instead we go $TEST_TOP/btrfs-progs-mkfs-tests-027.XXXXXX/ instead.
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$tmp_dev"
+run_check $SUDO_HELPER mount -t btrfs "$tmp_dev" "$TEST_MNT"
+
+run_check $SUDO_HELPER mkdir "$TEST_MNT/source_dir/"
+run_check $SUDO_HELPER chmod 750 "$TEST_MNT/source_dir/"
+run_check $SUDO_HELPER chown 1000:1000 "$TEST_MNT/source_dir/"
+run_check $SUDO_HELPER setfattr -n user.rootdir "$TEST_MNT/source_dir/"
+
+old_mode=$(run_check_stdout $SUDO_HELPER stat "$TEST_MNT/source_dir/" | grep "Uid:")
+run_check $SUDO_HELPER touch "$TEST_MNT/source_dir/foobar"
+run_check $SUDO_HELPER setfattr -n user.foobar "$TEST_MNT/source_dir/foobar"
+
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" --rootdir "$TEST_MNT/source_dir" -f "$real_dev"
+run_check $SUDO_HELPER umount "$TEST_MNT"
+
+run_check $SUDO_HELPER mount -t btrfs "$real_dev" "$TEST_MNT"
+
+new_mode=$(run_check_stdout $SUDO_HELPER stat "$TEST_MNT/" | grep "Uid:")
+new_rootdir_attr=$(run_check_stdout $SUDO_HELPER getfattr -n user.rootdir --absolute-names "$src_dir")
+new_foobar_attr=$(run_check_stdout getfattr -n user.foobar --absolute-names "$src_dir/foobar")
+
+run_check_umount_test_dev "$TEST_MNT"
+cleanup_loopdevs
+
+if ! echo "$new_rootdir_attr" | grep -q "user.rootdir" ; then
+	_fail "no rootdir xattr found"
+fi
+
+if ! echo "$new_foobar_attr"| grep -q "user.foobar" ; then
+	_fail "no regular file xattr found"
+fi
+
+if [ "$new_mode" != "$old_mode" ]; then
+	_fail "mode/uid/gid mismatch"
+fi
-- 
2.42.0

