Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E913C626DE2
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 07:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiKMGdD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 01:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMGdB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 01:33:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6703313F36
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Nov 2022 22:33:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 280851F45B
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 06:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668321179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r2vpBHmRK0pduWFgznejKlQJxH38a2fOcy/HFmnMwL0=;
        b=Zj0EDaHkcrtKfbf0pNaA7gc6ibr+WYudkUEzvbxMlotEqPIFvBZ5d52VJsfAa3ZVEi6Z/i
        uxW8ZJ01QYIcB7i4TQJIykZoob9a6pHGJaFqek8py0X8ROLDy3bx0Sj3HLWzk2z8ur4f5G
        SV6va1+htdHXuPT7pJvyFWFWpYa1Dbs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82A00133A4
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 06:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2KnOE5qPcGNRUQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 06:32:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: fsck-tests: add test case for degraded raid5
Date:   Sun, 13 Nov 2022 14:32:39 +0800
Message-Id: <edf7c1135b640d954507854f59df20377005274c.1668320935.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668320935.git.wqu@suse.com>
References: <cover.1668320935.git.wqu@suse.com>
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

The new test case will make sure btrfs check is fine checking a degraded
raid5 filesystem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/fsck-tests/060-degraded-check/test.sh | 36 +++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100755 tests/fsck-tests/060-degraded-check/test.sh

diff --git a/tests/fsck-tests/060-degraded-check/test.sh b/tests/fsck-tests/060-degraded-check/test.sh
new file mode 100755
index 000000000000..6a1f50c816da
--- /dev/null
+++ b/tests/fsck-tests/060-degraded-check/test.sh
@@ -0,0 +1,36 @@
+#!/bin/bash
+#
+# Make sure "btrfs check" can handle degraded raid5.
+#
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+check_prereq mkfs.btrfs
+check_global_prereq losetup
+check_global_prereq wipefs
+
+setup_loopdevs 3
+prepare_loopdevs
+dev1=${loopdevs[1]}
+dev2=${loopdevs[2]}
+dev3=${loopdevs[3]}
+
+setup_root_helper
+
+# Run 1: victim is dev1
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -m raid5 -d raid5 "${loopdevs[@]}"
+run_check $SUDO_HELPER wipefs -fa $dev1
+run_check $SUDO_HELPER "$TOP/btrfs" check $dev2
+
+# Run 2: victim is dev2
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -m raid5 -d raid5 "${loopdevs[@]}"
+run_check $SUDO_HELPER wipefs -fa $dev2
+run_check $SUDO_HELPER "$TOP/btrfs" check $dev3
+
+# Run 3: victim is dev3
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -m raid5 -d raid5 "${loopdevs[@]}"
+run_check $SUDO_HELPER wipefs -fa $dev3
+run_check $SUDO_HELPER "$TOP/btrfs" check $dev1
+
+cleanup_loopdevs
-- 
2.38.1

