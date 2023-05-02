Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEEC6F3B94
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 03:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjEBBCQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 May 2023 21:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjEBBCP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 May 2023 21:02:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67C30F6
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 18:02:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 727111F854
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 01:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682989328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m40easRD3g+cccI1U1Ub9+cOATt2e81kaIk0ouUp6fY=;
        b=qVqV2tyFI9WaTus1rj4AZrxMcsIg025CXYADuEsiCQc7j36wVbdPT4jwrK4QQoETe40k+H
        V0VJ7jQzxLPLLmN1gnq8GTHzJIiqx5g6VrM1P82qHe1sgiKlHWIz5EFCSd2Tu+oY4I2nYy
        SIDBLGS9A0mlhsMltQHg70Vf8HTU/0k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD5D913580
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 01:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kJnYIA9hUGTldQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 May 2023 01:02:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: misc-tests: add test case to verify btrfstune --convert-to-free-space-tree option
Date:   Tue,  2 May 2023 09:01:46 +0800
Message-Id: <b97e23c9f3e40480e48d3547fd3d365d43f81208.1682988988.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682988988.git.wqu@suse.com>
References: <cover.1682988988.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new test case would create a fs without free space tree, then
popluate it, convert to free-space-tree feature, and make sure
everything is fine.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../057-btrfstune-free-space-tree/test.sh     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 tests/misc-tests/057-btrfstune-free-space-tree/test.sh

diff --git a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
new file mode 100755
index 000000000000..c69f99cfbd38
--- /dev/null
+++ b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# test btrfstune --convert-to-free-space-tree option
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
+run_check_mkfs_test_dev -O ^free-space-tree
+run_check_mount_test_dev
+populate_fs
+run_check_umount_test_dev
+
+run_check $SUDO_HELPER "$TOP/btrfstune" --convert-to-free-space-tree $TEST_DEV
+
+run_check "$TOP/btrfs" check "$TEST_DEV"
-- 
2.39.2

