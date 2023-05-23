Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5734470CFC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 02:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjEWAqT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 20:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbjEWApu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 20:45:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D84C29
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 17:37:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 971911FFA2
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 00:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684802253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FaTw0p2WgQol2ErKxrGbPX8MpjjJWTvifKse97Bl9hw=;
        b=j05bPmfoXh7GCi2EQdGK+9sQVwyUp1AmWMAP07U5XfmuddYwiEJ4xrXvjuoP78+mXRd/7E
        Of37dW2L+6ZJlLoLeq0zOqHWwxHVvbPf3sGgVBpSWxATLUI5ycabHyYhi0iz1Te+LQrotx
        CatPYOgbpvmOeswDd3m6no12rOCGEuQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE23413588
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 00:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oNyvLcwKbGTIIgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 00:37:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: tests/misc: add a test case for csum change
Date:   Tue, 23 May 2023 08:37:13 +0800
Message-Id: <0d8e9a8dd3b9ba9d91a9ae826565c1a324218ba0.1684802060.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684802060.git.wqu@suse.com>
References: <cover.1684802060.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The test case would:
- Populate the fs
- Run csum change for all the target csum type
- Run above csum change again

This should more or less cover the common paths, and detect any
conflicting csum change item.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../058-btrfstune-csum-change/test.sh         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 tests/misc-tests/058-btrfstune-csum-change/test.sh

diff --git a/tests/misc-tests/058-btrfstune-csum-change/test.sh b/tests/misc-tests/058-btrfstune-csum-change/test.sh
new file mode 100755
index 000000000000..925e71b86285
--- /dev/null
+++ b/tests/misc-tests/058-btrfstune-csum-change/test.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# Test btrfstune --csum option
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+check_prereq mkfs.btrfs
+check_prereq btrfstune
+check_prereq btrfs
+
+setup_root_helper
+prepare_test_dev
+
+run_check_mkfs_test_dev --csum crc32c
+run_check_mount_test_dev
+populate_fs
+run_check_umount_test_dev
+
+for hash in "blake2" "crc32c" "xxhash" "sha256"; do
+	run_check $SUDO_HELPER "$TOP/btrfstune" --csum $hash "$TEST_DEV"
+	run_check $SUDO_HELPER "$TOP/btrfs" check --check-data-csum "$TEST_DEV"
+done
+for hash in "blake2" "crc32c" "xxhash" "sha256"; do
+	run_check $SUDO_HELPER "$TOP/btrfstune" --csum $hash "$TEST_DEV"
+	run_check $SUDO_HELPER "$TOP/btrfs" check --check-data-csum "$TEST_DEV"
+done
-- 
2.40.1

