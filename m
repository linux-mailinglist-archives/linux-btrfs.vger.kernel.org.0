Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CB2403275
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 04:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347042AbhIHCG7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 22:06:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39898 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347039AbhIHCG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 22:06:57 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 172BF1FFE4
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 02:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631066750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9YURpuJWBSS33aO4D70cPuB3nR3NLqYzgEuWIBu6oU=;
        b=V7QKlJP8Rfu4+OmXlaVS680OqRCBcIUbKOLZyi1gbIoO3/0ajnRYzwMpy43zWXv+DnG5Sj
        xqjj5PP0jJgc495h6E89aUlXN//nNUXZLLGqCVWKd/R7y2PVc250cygyQuCtcfOabOh/2D
        4B6V2WyTUjiVxv+E8qOYk+jDrJCiQVU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4E70613721
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 02:05:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id qFIpBH0aOGHDDgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Sep 2021 02:05:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: misc-tests: add new test case to make sure btrfstune rejects corrupted fs
Date:   Wed,  8 Sep 2021 10:05:43 +0800
Message-Id: <20210908020543.54087-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908020543.54087-1-wqu@suse.com>
References: <20210908020543.54087-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although btrfstune will already warn users to make sure the fs is not
corrupted, we can never trust end users.

If the target fs has transid error, btrfstune can cause further damage,
thus we need to make sure btrfstune can safely reject fs with transid
error, other than ignoring the problem.

The image is copied from fsck-tests/002, just override check_image() to
run "btrfstune -u" instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../default_case.img                             |  1 +
 .../049-btrfstune-transid-mismatch/test.sh       | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 120000 tests/misc-tests/049-btrfstune-transid-mismatch/default_case.img
 create mode 100755 tests/misc-tests/049-btrfstune-transid-mismatch/test.sh

diff --git a/tests/misc-tests/049-btrfstune-transid-mismatch/default_case.img b/tests/misc-tests/049-btrfstune-transid-mismatch/default_case.img
new file mode 120000
index 000000000000..eb54ddcbb402
--- /dev/null
+++ b/tests/misc-tests/049-btrfstune-transid-mismatch/default_case.img
@@ -0,0 +1 @@
+../../fsck-tests/002-bad-transid/default_case.img
\ No newline at end of file
diff --git a/tests/misc-tests/049-btrfstune-transid-mismatch/test.sh b/tests/misc-tests/049-btrfstune-transid-mismatch/test.sh
new file mode 100755
index 000000000000..c6d721eaea65
--- /dev/null
+++ b/tests/misc-tests/049-btrfstune-transid-mismatch/test.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# Verify that btrfstune would reject fs with transid mismatch problems
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs-image
+check_prereq btrfs
+check_prereq btrfstune
+
+# Although we're not checking the image, here we just reuse the infrastructure
+check_image() {
+	run_mustfail "btrfstune should fail when the image has transid error" \
+		  "$TOP/btrfstune" -u "$1"
+}
+
+check_all_images
-- 
2.33.0

