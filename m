Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C956A6FBC0F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjEIAnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEIAnp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:43:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5373059EE
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:43:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E35221DC0
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 00:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683593017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOTSMXjfKPEvlDc1WTvWTaeJFUEfK/HP1MvWf0gyKwU=;
        b=rmnwBFiaRIIO844LH+fPZyYxSlIUDMyv7l7MYxrLPvEjFB5cVOX7BlJxgLRBV4AhkGaUb3
        7QvDqgnz6T28aHby0FP6g8pBx1SRHR3Tx4V8MsxswqD3ktJwW36N9+REH1Q8OEp3vpYVw/
        bOJMYjNUcdG0zVqiTS12v/3OXn4X7fY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56B99134B2
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 00:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KJzbKDeXWWScDgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 May 2023 00:43:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: tests/convert: add a test case to check the csum for the image file
Date:   Tue,  9 May 2023 08:43:15 +0800
Message-Id: <624194cbbce1d068e1e2a409e5d5497eea366875.1683592875.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683592875.git.wqu@suse.com>
References: <cover.1683592875.git.wqu@suse.com>
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

The new test case would create an empty ext4 with 64K block size, which
can lead to a new data chunk which is no longer 1:1 mapped.

Then convert the fs and verify it with --check-data-csum to make sure
the image file is fine.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../023-64k-blocksize-migrated/test.sh           | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100755 tests/convert-tests/023-64k-blocksize-migrated/test.sh

diff --git a/tests/convert-tests/023-64k-blocksize-migrated/test.sh b/tests/convert-tests/023-64k-blocksize-migrated/test.sh
new file mode 100755
index 000000000000..99808a74314c
--- /dev/null
+++ b/tests/convert-tests/023-64k-blocksize-migrated/test.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# Make sure the migrated range doesn't cause csum errors
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+setup_root_helper
+prepare_test_dev 10G
+
+check_global_prereq mkfs.ext4
+check_prereq btrfs-convert
+check_prereq btrfs
+
+run_check mkfs.ext4 -b 64K -F "$TEST_DEV"
+run_check $SUDO_HELPER "$TOP/btrfs-convert" -N 64K "$TEST_DEV"
+run_check $SUDO_HELPER "$TOP/btrfs" check --check-data-csum "$TEST_DEV"
-- 
2.40.1

