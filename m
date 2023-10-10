Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D627C45B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 01:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344233AbjJJXuL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 19:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbjJJXuK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 19:50:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1CC93
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 16:50:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 693571F749
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696981807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QGQlrVMMzwBeslkfOMHYXLguWDXwrMq0x2+Xz+fydM=;
        b=ipj+glBZTeFmP8zHEYaqnZnCafIzlW+qBMZVr7f4j5D+pGMUiIncaiuAMaCqaEUoBAcwE7
        SI/k0unYkarD1z/n08wKniHK+cAT3AXhuU5UO6dX5cqrV8bwRaWDVBlZoQtOETfwXSzd4X
        Bo7/LqdzXzTWXImx4nwK0vv8dvOfVTY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 659681348E
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 23:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4MafBC7jJWXySwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 23:50:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs-progs: tests/mkfs: make sure rootdir inode got its attributes copied
Date:   Wed, 11 Oct 2023 10:19:44 +1030
Message-ID: <31ef017d9cc45ffe7b8c942b4e29a7dc56fc72e8.1696981203.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696981203.git.wqu@suse.com>
References: <cover.1696981203.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

