Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00727DEC54
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 06:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348560AbjKBFeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 01:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348559AbjKBFeV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 01:34:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE312F
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 22:34:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64507219EC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 05:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698903253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/6I3sL4qQRxet9RVKwxSUIU1lq+8IoUhM84A9BvecU=;
        b=Rnd25G4dcDgbwjKKbSnqQ9aZM7McmKZbn31guxG0ze1toqeM3g/JaDBQ+QGrGtDBvSKOOE
        M3dBS/wcZypvktsXhPstkBeBY13UIUEZTdqPU/VjnUMcvupqUmW5u6sjpn8PoC9UqJlDlp
        WSUVF5zW2L+q8Vm86gp3IF43dCg98ak=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 962F913460
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 05:34:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OMJoFdQ0Q2U/AwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Nov 2023 05:34:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: cli-tests: add test case for subvolume create multiple arguments
Date:   Thu,  2 Nov 2023 16:03:50 +1030
Message-ID: <453c0e60ff7db7a1af06df230e2847d0f2b62692.1698903010.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698903010.git.wqu@suse.com>
References: <cover.1698903010.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The test case would verify the following behaviors:

- Partial failure
  Should return 1, but the remaining valid destinations would still be
  created.

- All success
  That's as usual.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../021-subvolume-multiple-arguments/test.sh  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 tests/cli-tests/021-subvolume-multiple-arguments/test.sh

diff --git a/tests/cli-tests/021-subvolume-multiple-arguments/test.sh b/tests/cli-tests/021-subvolume-multiple-arguments/test.sh
new file mode 100755
index 000000000000..f86763829d31
--- /dev/null
+++ b/tests/cli-tests/021-subvolume-multiple-arguments/test.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# Create subvolume with multiple destinations
+
+source "$TEST_TOP/common" || exit
+
+setup_root_helper
+prepare_test_dev
+
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+
+# Create one invalid subvolume with 2 valid ones.
+# The command should return 1 but the 2 valid ones should be created.
+run_mustfail "should report error for any failed subvolume creation" \
+	$SUDO_HELPER "$TOP/btrfs" subvolume create \
+	"$TEST_MNT/non-exist-dir/subv0" \
+	"$TEST_MNT/subv1" \
+	"$TEST_MNT/subv2"
+
+run_check $SUDO_HELPER stat "$TEST_MNT/subv1"
+run_check $SUDO_HELPER stat "$TEST_MNT/subv2"
+
+# Create multiple subvolumes with parent
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create -p \
+	"$TEST_MNT/non-exist-dir/subv0" \
+	"$TEST_MNT/subv1/subv3" \
+	"$TEST_MNT/subv4" \
+
+run_check $SUDO_HELPER stat "$TEST_MNT/non-exist-dir/subv0"
+run_check $SUDO_HELPER stat "$TEST_MNT/subv1/subv3"
+run_check $SUDO_HELPER stat "$TEST_MNT/subv4"
+
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create -p "$TEST_MNT/dir3/dir1/./..//.///subv3//////"
+run_check $SUDO_HELPER stat "$TEST_MNT/dir3/dir1"
+run_check $SUDO_HELPER stat "$TEST_MNT/dir3/subv3"
+run_check find "$TEST_MNT" -ls
+run_check_umount_test_dev
-- 
2.42.0

