Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3C3CC935
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jul 2021 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhGRM5x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Jul 2021 08:57:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48382 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhGRM5x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Jul 2021 08:57:53 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DAD120155
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jul 2021 12:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626612894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LfuWYXU3TGUkX1vsiSFM7sVo8fDj+HubHN1ck7lWX9c=;
        b=GnX37443gwsmqm4OKGTIu4r1dSUnimEvQu4qBAru8iodeTwrdz3Xzc0IJw2qj0rdRLRnY0
        /mWTVgsmgWM7HGCo84LI7EvnH4lBh6vKK3WCOXJDEqNXwSI1/dP3NDeFWl6cZo9PtqgaWi
        yLnUjfUuOdOXmHeSeeuGv48F/oF4n8s=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6A5271332A
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jul 2021 12:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kJCcC50k9GA2QAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jul 2021 12:54:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: fsck-test: add test case where one dir has two links
Date:   Sun, 18 Jul 2021 20:54:49 +0800
Message-Id: <20210718125449.311815-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210718125449.311815-1-wqu@suse.com>
References: <20210718125449.311815-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make sure btrfs check can detect such problem.

Right now we have no way to fix it yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../049-dir-hard-link/default.img.xz          | Bin 0 -> 1712 bytes
 tests/fsck-tests/049-dir-hard-link/test.sh    |  19 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tests/fsck-tests/049-dir-hard-link/default.img.xz
 create mode 100755 tests/fsck-tests/049-dir-hard-link/test.sh

diff --git a/tests/fsck-tests/049-dir-hard-link/default.img.xz b/tests/fsck-tests/049-dir-hard-link/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..fd9971acae78975f5263da022feea39e34b45139
GIT binary patch
literal 1712
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
G1X)_MbXXt&

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/049-dir-hard-link/test.sh b/tests/fsck-tests/049-dir-hard-link/test.sh
new file mode 100755
index 000000000000..992ad638bd47
--- /dev/null
+++ b/tests/fsck-tests/049-dir-hard-link/test.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+#
+# Verify that check can detect overlapped dir with 2 links
+#
+# There is a report that btrfs-check doesn't report dir with 2 links as
+# error, and only get caught by tree-checker.
+#
+# Make sure btrfs check can at least detect such error
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+
+check_image() {
+	run_mustfail "dir with 2 links not detected" \
+		"$TOP/btrfs" check "$1"
+}
+
+check_all_images
-- 
2.32.0

