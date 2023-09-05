Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132C679267C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjIEQCh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353752AbjIEHwW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 03:52:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2519ACCF
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 00:52:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF994211B7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693900337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KCSLvN+tcKkTygFHC960HQbHr/tqA0kfYKDMQ2ZqvOM=;
        b=qFt0HiMGikaHKWj8/4y4aV/KK1Pe1b5caE5LlroIKqq9X7KSuBgUdtnj3mH46ghlYm1w3w
        bHsGYrVc8fgrtberBt7peL/A9rn/OiqSg7CP8q1CJEhqaiou4vNoFEoo+CPWRumS5woEhZ
        ZvIHo1lAePUGh0ZvHy+XYbkikWc7iHA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3294913911
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aJyJOjDe9mTFeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 07:52:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs-progs: tests/cli: add a test case for "btrfs tune" subcommand
Date:   Tue,  5 Sep 2023 15:51:49 +0800
Message-ID: <a6b13566318a0d002ca98e90b5494d22ecea4811.1693900169.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693900169.git.wqu@suse.com>
References: <cover.1693900169.git.wqu@suse.com>
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

The new test case would test all supported features of both set and
clear subcommands.

Also test the error handling of unknown features.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/cli-tests/018-btrfs-tune/test.sh | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 tests/cli-tests/018-btrfs-tune/test.sh

diff --git a/tests/cli-tests/018-btrfs-tune/test.sh b/tests/cli-tests/018-btrfs-tune/test.sh
new file mode 100755
index 000000000000..3b2d1ebb3e59
--- /dev/null
+++ b/tests/cli-tests/018-btrfs-tune/test.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# test all command line options of btrfstune
+
+source "$TEST_TOP/common" || exit
+
+check_prereq btrfstune
+
+setup_root_helper
+prepare_test_dev
+
+run_mayfail "$TOP/btrfstune" || true
+run_check "$TOP/btrfstune" --help
+
+run_mustfail "must not work on non-existent device" \
+	"$TOP/btrfstune" -r file-does-not-exist
+
+run_check_mkfs_test_dev -O ^extref
+run_check "$TOP/btrfs" tune set extref "$TEST_DEV"
+run_check "$TOP/btrfs" check "$TEST_DEV"
+
+run_check_mkfs_test_dev -O ^skinny-metadata
+run_check "$TOP/btrfs" tune set skinny-metadata "$TEST_DEV"
+run_check "$TOP/btrfs" check "$TEST_DEV"
+
+run_check_mkfs_test_dev -O ^no-holes
+run_check "$TOP/btrfs" tune set no-holes "$TEST_DEV"
+run_check "$TOP/btrfs" check "$TEST_DEV"
+
+run_check_mkfs_test_dev -O ^block-group-tree
+run_check "$TOP/btrfs" tune set block-group-tree "$TEST_DEV"
+run_check "$TOP/btrfs" check "$TEST_DEV"
+run_check "$TOP/btrfs" tune clear block-group-tree "$TEST_DEV"
+run_check "$TOP/btrfs" check "$TEST_DEV"
+
+run_check_mkfs_test_dev
+run_check "$TOP/btrfs" tune set -f seed "$TEST_DEV"
+run_check "$TOP/btrfs" tune clear seed "$TEST_DEV"
+
+run_mustfail "Unknown features" "$TOP/btrfs" tune set unknown-feature "$TEST_DEV"
+run_mustfail "Unknown features" "$TOP/btrfs" tune clear unknown-feature "$TEST_DEV"
-- 
2.42.0

