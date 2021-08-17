Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47E23EF451
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 23:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhHQVAn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 17:00:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33012 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHQVAm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 17:00:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4AAFA1FF76;
        Tue, 17 Aug 2021 21:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629234008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hYYjNyJpYdVJjRypJ8b053Yh8yokZ/R9CHAHxGyrX8s=;
        b=kCR923jHjvcjUVxz1ksbx/Ny+ZQH5lGsTzkYDEF3mYSkG8knTnFlX6eDMUp3owN7gHh8xl
        uZeLmxQ5UKsvUnMmT/Pf8ETjyU008Gzq4fFxvJ3mIRjuqh42ee/2dzTtch2tFJSikdgiGL
        yjrxFK4Sl/t/9kAcogx4/V5twZMhMq8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0232F13A72;
        Tue, 17 Aug 2021 21:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j2uJL1YjHGFXKAAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Tue, 17 Aug 2021 21:00:06 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs-progs: tests: Verify block group size in mkfs
Date:   Tue, 17 Aug 2021 17:59:24 -0300
Message-Id: <20210817205924.373-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 222e622683e9 ("btrfs-progs: drop type check in¬
init_alloc_chunk_ctl_policy_regular") fixed the calculation of the
initial data block group on mkfs time, when the profile is single.

This new test ensures that the size of the initial block group is 1G, or
at least 10% of the total filesystem size.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 .../024-mkfs-single-bg-size/test.sh           | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 tests/mkfs-tests/024-mkfs-single-bg-size/test.sh

diff --git a/tests/mkfs-tests/024-mkfs-single-bg-size/test.sh b/tests/mkfs-tests/024-mkfs-single-bg-size/test.sh
new file mode 100755
index 00000000..a84cbbeb
--- /dev/null
+++ b/tests/mkfs-tests/024-mkfs-single-bg-size/test.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# Regression test for mkfs.btrfs using single data block group
+# Expected behavior: it should create a data block group of 1G, or at least up
+# to 10% of the filesystem size if it's size is < 50G.
+# Commit that fixed the issue: 222e622683e9 ("btrfs-progs: drop type check in
+# init_alloc_chunk_ctl_policy_regular")
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+verify_single_bg_size()
+{
+	local bg_size
+	local dev_size
+	local expected_bg_size
+	dev_size="$1"
+	expected_bg_size="$2"
+
+	prepare_test_dev $dev_size
+	bg_size=`$SUDO_HELPER "$TOP/mkfs.btrfs" -f "$TEST_DEV" | awk '/single/ {print $NF}'`
+
+	if [[ "$bg_size" != "$expected_bg_size" ]]; then
+		_fail "mkfs.btrfs created a data block group of size $bg_size, but expected $expected_bg_size"
+	fi
+}
+
+setup_root_helper
+
+# using 5G as disk size should create a bg with 10% of the total disk size,
+# which is 512MiB
+verify_single_bg_size "5G" "512.00MiB"
+
+# Same here, 10% of the disk size
+verify_single_bg_size "1G" "102.38MiB"
+verify_single_bg_size "1500M" "150.00MiB"
+verify_single_bg_size "7G" "716.75MiB"
+verify_single_bg_size "9G" "921.56MiB"
+
+# From 1G on, it should create a block group of 1G of size
+verify_single_bg_size "10G" "1.00GiB"
+verify_single_bg_size "11G" "1.00GiB"
+verify_single_bg_size "50G" "1.00GiB"
+verify_single_bg_size "51G" "1.00GiB"
-- 
2.31.1

