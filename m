Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2F3D4036
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 20:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhGWRhK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 13:37:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47992 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhGWRhK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 13:37:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCEA91FFEA;
        Fri, 23 Jul 2021 18:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627064261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=s1T7j8FIb6Q+H+/BcThktyQbkBkucVK47GjySEZArZc=;
        b=ultZQ+1aXw1wqRIxKE8nLI9bdgQx3tsIVvT/1FqH1GnZI59YLltEzjCCV1q2BBpAU2uVDa
        FZjsGF7UIXzmXJuDyhCRRc8LO9SSoVUysj7uiQDEm3MQvQy3eKtxjGg6k7EVC7peWnM6Td
        0vEmK75zLrFpWM/EzsteDFBA+II8IG8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 33B4C13697;
        Fri, 23 Jul 2021 18:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YSWbOsMH+2CpXgAAGKfGzw
        (envelope-from <mpdesouza@suse.com>); Fri, 23 Jul 2021 18:17:39 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     dsterba@suse.com, guaneryu@gmail.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: Source common/module when requiring module reload
Date:   Fri, 23 Jul 2021 15:18:00 -0300
Message-Id: <20210723181800.26884-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Tests 163, 219, 225 and 242 require the btrfs module to be reloaded in
the middle of the test. If btrfs is compiled builtin, these tests
should be skipped, since we cannot unload it.

Today, this is what happens:

    QA output created by 242
    +./common/btrfs: line 405: _require_loadable_fs_module: command not found

Sourcing common/module in these tests fixes the issue by skipping the
test:
    btrfs/242       [not run] btrfs: must be a module.
    Ran: btrfs/242
    Not run: btrfs/242

Other tests liker btrfs/124 and btrfs/125 already source the same file
for the same reason, so follow the pattern.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/btrfs/163 | 1 +
 tests/btrfs/219 | 1 +
 tests/btrfs/225 | 1 +
 tests/btrfs/242 | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tests/btrfs/163 b/tests/btrfs/163
index 1dc081f1..76553831 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -27,6 +27,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
+. ./common/module
 
 # real QA test starts here
 
diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 528175b8..1cd5daae 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -35,6 +35,7 @@ _cleanup()
 
 # Import common functions.
 . ./common/filter
+. ./common/module
 
 # real QA test starts here
 
diff --git a/tests/btrfs/225 b/tests/btrfs/225
index 408c03d2..ce1818db 100755
--- a/tests/btrfs/225
+++ b/tests/btrfs/225
@@ -25,6 +25,7 @@ _cleanup()
 
 # Import common functions.
 . ./common/filter
+. ./common/module
 
 # real QA test starts here
 
diff --git a/tests/btrfs/242 b/tests/btrfs/242
index 6ce62081..e1c102ae 100755
--- a/tests/btrfs/242
+++ b/tests/btrfs/242
@@ -13,6 +13,7 @@ _begin_fstest auto quick volume trim
 
 # Import common functions.
 . ./common/filter
+. ./common/module
 
 # real QA test starts here
 _supported_fs btrfs
-- 
2.26.2

