Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1397BD266
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 05:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbjJIDej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Oct 2023 23:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344903AbjJIDei (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Oct 2023 23:34:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F3DA3
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Oct 2023 20:34:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F07F51F891
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 03:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696822473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENHIiWvAJgIpJoJoQKB6rj4+tEyD7WkDTR4HHnco4DY=;
        b=P39Onn/9aaDjU4nBk/wi8t5fXfGiWp00DiQwahj50uoM1uRtKE5hyqWLHmD+pDDxJAKqP8
        ptceUdhx/fE7qH1rzY8ejmy37l7sMcM8zKcrd5j7aL5cKwNzwz3G6mYKErIaFOIkVMKUal
        gj4m4GpPVJbmh1Amei3YSiQiTPn7C54=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB353138F1
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 03:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wEV6Fsh0I2X8PQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Oct 2023 03:34:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: tests/mkfs: make sure rootdir got its xattr copied
Date:   Mon,  9 Oct 2023 14:04:09 +1030
Message-ID: <3daf7ed97305f5482800e28c960e3b5c2ed222b3.1696822345.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696822345.git.wqu@suse.com>
References: <cover.1696822345.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new test case would:

- Create a dir as source dir for --rootdir
- Add xattr for that source dir
- Create a file inside that source dir
- Add xattr for that file
- Run "mkfs.btrfs --rootdir" with that source dir
- Mount the created fs
- Make sure the following xattr exists:
  * Xattr for the rootdir
  * Xattr for that file inside the mount point

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/027-rootdir-xattr/test.sh | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 tests/mkfs-tests/027-rootdir-xattr/test.sh

diff --git a/tests/mkfs-tests/027-rootdir-xattr/test.sh b/tests/mkfs-tests/027-rootdir-xattr/test.sh
new file mode 100755
index 000000000000..bff9dc71d8e0
--- /dev/null
+++ b/tests/mkfs-tests/027-rootdir-xattr/test.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# Test if the source dir has xattr, "mkfs.btrfs --rootdir" would properly copy
+# that xattr to the rootdir inode.
+
+source "$TEST_TOP/common" || exit
+
+setup_root_helper
+prepare_test_dev
+
+check_global_prereq setfattr
+check_global_prereq getfattr
+
+# Here we don't want to use /tmp, as it's pretty common /tmp is tmpfs, which
+# doesn't support xattr.
+# Instead we go $TEST_TOP/btrfs-progs-mkfs-tests-027.XXXXXX/ instead.
+src_dir=$(mktemp -d --tmpdir=$TEST_TOP btrfs-progs-mkfs-tests-027.XXXXXX)
+run_mayfail setfattr -n user.rootdir "$src_dir"
+if [ $? -ne 0 ]; then
+	rm -rf -- "$src_dir"
+	_not_run "unable to set xattr to temporaray directory"
+fi
+run_check touch "$src_dir/foobar"
+run_check setfattr -n user.foobar "$src_dir/foobar"
+
+run_check_mkfs_test_dev --rootdir "$src_dir"
+run_check_mount_test_dev
+
+attr=$(run_check_stdout getfattr -n user.rootdir --absolute-names "$src_dir")
+if ! echo $attr | grep -q "user.rootdir" ; then
+	rm -rf -- "$src_dir"
+	_fail "no rootdir xattr found"
+fi
+
+attr=$(run_check_stdout getfattr -n user.foobar --absolute-names "$src_dir/foobar")
+if ! echo $attr | grep -q "user.foobar" ; then
+	rm -rf -- "$src_dir"
+	_fail "no regular file xattr found"
+fi
+
+rm -rf -- "$src_dir"
-- 
2.42.0

