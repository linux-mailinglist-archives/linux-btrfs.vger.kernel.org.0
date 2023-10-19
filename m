Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989237D04D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 00:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346664AbjJSWas (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 18:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346653AbjJSWan (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 18:30:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1251CA
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 15:30:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43E2321A0D
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697754639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xF8jCIr+2bikASD6zQzQRnXYXK9A3NZMpdc6Np/ogr8=;
        b=BMuITTZx4f/UplvPh9ZJ9inDG9UrtBG5tsgaWd9UP8rW2NhjY2uTg0TVAlK0NAW87kmRLr
        k7zJz0xprUkSVrqlVPXJM9UnZgjKDHZR90/ZVAY5oUC0EXQCflbAoG4IvPY0jba2e4iX7l
        9XqGd2VoieKF5lM0sHrskjyWt3Qd2UE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73EA11357F
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SIHZDA6uMWXzWgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 9/9] btrfs-progs: mkfs-tests: introduce a test case to verify --subvol option
Date:   Fri, 20 Oct 2023 09:00:08 +1030
Message-ID: <d97df89c85038dfb0393eec0a93039d64f443b40.1697754500.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697754500.git.wqu@suse.com>
References: <cover.1697754500.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.99
X-Spamd-Result: default: False [-0.99 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_ONE(0.00)[1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.89)[94.38%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test case would try the following combinations:

- Valid cases
  * subvolume directly under fs tree
  * subvolume with several parent directories
  * subvolume path with unnecessary too many duplicated '/'s

- Invalid cases
  * subvolume path without any filename, e.g. "/////"
  * subvolume path with ".."

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/031-subvol-option/test.sh | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100755 tests/mkfs-tests/031-subvol-option/test.sh

diff --git a/tests/mkfs-tests/031-subvol-option/test.sh b/tests/mkfs-tests/031-subvol-option/test.sh
new file mode 100755
index 000000000000..eedd257b746e
--- /dev/null
+++ b/tests/mkfs-tests/031-subvol-option/test.sh
@@ -0,0 +1,39 @@
+#!/bin/bash
+# Verify "mkfs.btrfs --subvol" option can handle valid and invalid subvolume
+# paths correctly
+
+source "$TEST_TOP/common" || exit
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+setup_root_helper
+prepare_test_dev
+
+# Make sure we have enabled experimental features
+output=$(run_check_stdout "$TOP/mkfs.btrfs" --help 2>&1 | grep -- --subvol)
+
+if [ -z "$output" ]; then
+	_not_run "experimental features are not enabled"
+fi
+
+# Valid case, simple subvolume directly under fs root.
+run_check_mkfs_test_dev --subvol "subv"
+run_check "$TOP/btrfs" check $TEST_DEV
+
+# Valid case, subvolume with several parent directories.
+run_check_mkfs_test_dev --subvol "dir1/dir2/dir3/subv"
+run_check "$TOP/btrfs" check $TEST_DEV
+
+# Valid case, subvolume with several parent directories, and
+# unnecessarily too many '/'s
+run_check_mkfs_test_dev --subvol "////dir1/dir2//dir3/dir4/////subv////"
+run_check "$TOP/btrfs" check $TEST_DEV
+
+# Invalid case, subvolume path contains no filename
+run_mustfail "invalid subvolume without filename should fail" \
+	"$TOP/mkfs.btrfs" -f --subvol "//////" $TEST_DEV
+
+# Invalid case, subvolume path contains ".."
+run_mustfail "invalid subvolume without filename should fail" \
+	"$TOP/mkfs.btrfs" -f --subvol "../subvol" $TEST_DEV
-- 
2.42.0

