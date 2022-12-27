Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816C365676C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Dec 2022 06:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiL0Fzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Dec 2022 00:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiL0Fza (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Dec 2022 00:55:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FED5FCB
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 21:55:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 523105FE4D
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Dec 2022 05:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672120528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2gNyMjFYBxP2ubq4bugStueaD9klIpECbWiDJBw6lSo=;
        b=GXtDFnlrJed2boT5ndRx17OF5an5YXUma/0eZnrkDiDdHBwunCDXHyM0g5knvu4TQLxD1G
        OFzV/pP5MfDZ00PL8qPbWBgnTQtaFW+xXnpVK+0q1e0Lqi03F6l84VjcZX593WEfqq9Ece
        njWGIwC2yADcBBSsXoe0EnPAYh6KbMA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6A2E133F5
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Dec 2022 05:55:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qEYYHM+IqmMBRgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Dec 2022 05:55:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: misc-tests: add a test case to make sure uuid is correctly  reported
Date:   Tue, 27 Dec 2022 13:55:08 +0800
Message-Id: <6b439939b69d08debf357e7b9d7a5b3ef8ae6b4b.1672120480.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672120480.git.wqu@suse.com>
References: <cover.1672120480.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new test case will execute "btrfs subvolume list -u" on the newly
create btrfs.

Since the v0 root item is already deprecated for a long time, newly
created btrfs should be already using the new root item, thus "btrfs
subvolume list -u" should always report the correct uuid.

The test case relies on external program "uuidparse" which should be
provided by util-linux.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../056-subvolume-list-uuid/test.sh           | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100755 tests/misc-tests/056-subvolume-list-uuid/test.sh

diff --git a/tests/misc-tests/056-subvolume-list-uuid/test.sh b/tests/misc-tests/056-subvolume-list-uuid/test.sh
new file mode 100755
index 000000000000..45f4f956c25f
--- /dev/null
+++ b/tests/misc-tests/056-subvolume-list-uuid/test.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+#
+# Make sure "btrfs subvolume list -u" shows uuid correctly
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+check_global_prereq uuidparse
+
+setup_root_helper
+prepare_test_dev
+
+tmp=$(_mktemp_dir list_uuid)
+
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
+run_check_stdout $SUDO_HELPER "$TOP/btrfs" subvolume list -u "$TEST_MNT" |\
+	cut -d\  -f9 > "$tmp/output"
+
+result=$(cat "$tmp/output" | uuidparse -o TYPE -n)
+rm -rf -- "$tmp"
+
+if [ "$result" == "invalid" ]; then
+	_fail "subvolume list failed to report uuid"
+fi
+run_check_umount_test_dev
-- 
2.39.0

