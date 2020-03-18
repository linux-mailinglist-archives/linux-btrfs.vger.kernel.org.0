Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A791218A3A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgCRUTE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:19:04 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.62]:38613 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbgCRUTE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:19:04 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 75F4B20CADE5
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 15:19:03 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9bjBN9pLnBiEf9bjh8dr; Wed, 18 Mar 2020 15:19:03 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vv3LeU+z2MSvX2S/QqZoBMJsm3X8KHrh1/MRgo119ew=; b=fGbrZpDHivtBA+iUGu1tSkrJNt
        jDdpWv2rXHpnT++f/NTM9wUaGn7dMYFl+Cumm1i5boFh8khdp+9neo3wW+K4OaN5YDO6VZr87CJXI
        qQAA+t2R/CtuMUks65yENqPJUBQNqNIz6f+ykR8j6+Kavfxdi/wcFf5UrtKuNEoNpW5ilFCoxXTIz
        Din1kqiDC+91KjcEvpIKv3aOB4rDBVLLD65vmzFNtHdjuvxIrhmV7L2iLFpv428P28KQPZrk/yePs
        588p7PlxbW/4iqrK/hRVQcrgE4ptQJEAdZtJqiWIMNb1ZD6I321X97kW0uYuGdB1RO6uvmOTluhxV
        OkcaFLfg==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9Z-000yAj-ME; Wed, 18 Mar 2020 17:19:02 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH v4 11/11] btrfs-progs: test/mkfs: Add test case for --rootdir and --quota
Date:   Wed, 18 Mar 2020 17:21:48 -0300
Message-Id: <20200318202148.14828-12-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200318202148.14828-1-marcos@mpdesouza.com>
References: <20200318202148.14828-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.66.103
X-Source-L: No
X-Exim-ID: 1jEf9Z-000yAj-ME
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 38
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Nothing interesting, since such combination can be handled easily by
qgroup-verify.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../mkfs-tests/018-rootdir-with-quota/test.sh | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100755 tests/mkfs-tests/018-rootdir-with-quota/test.sh

diff --git a/tests/mkfs-tests/018-rootdir-with-quota/test.sh b/tests/mkfs-tests/018-rootdir-with-quota/test.sh
new file mode 100755
index 00000000..97e5f592
--- /dev/null
+++ b/tests/mkfs-tests/018-rootdir-with-quota/test.sh
@@ -0,0 +1,51 @@
+#!/bin/bash
+# Check if runtime feature quota can handle rootdir
+#
+
+source "$TOP/tests/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+setup_root_helper		# For mknod
+prepare_test_dev 1G		# make it large since we will fill the fs
+
+# mknod can create FIFO/CHAR/BLOCK file but not SOCK.
+# No neat tool to create socket file, unless using python or similar.
+# So no SOCK is tested here
+check_global_prereq mknod
+check_global_prereq dd
+
+tmp=$(mktemp -d --tmpdir btrfs-progs-mkfs.rootdirXXXXXXX)
+
+run_check mkdir "$tmp/dir"
+run_check mkdir -p "$tmp/dir/in/dir"
+
+# More dir, there is no good way to pump metadata since we have no trigger
+# to enable/disable inline extent data, so here create enough dirs to bump
+# metadata
+run_check mkdir "$tmp/a_lot_of_dirs"
+for i in $(seq -w 0 8192); do
+	run_check mkdir "$tmp/a_lot_of_dirs/dir_$i"
+done
+
+# Then some data
+run_check dd if=/dev/zero bs=1M count=1 of="$tmp/1M"
+run_check dd if=/dev/zero bs=2M count=1 of="$tmp/2M"
+run_check dd if=/dev/zero bs=4M count=1 of="$tmp/4M"
+run_check dd if=/dev/zero bs=8M count=1 of="$tmp/8M"
+
+run_check dd if=/dev/zero bs=1K count=1 of="$tmp/1K"
+run_check dd if=/dev/zero bs=2K count=1 of="$tmp/2K"
+run_check dd if=/dev/zero bs=4K count=1 of="$tmp/4K"
+run_check dd if=/dev/zero bs=8K count=1 of="$tmp/8K"
+
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -r "$tmp" -Q "$TEST_DEV"
+
+rm -rf -- "$tmp"
+
+# Normal check already includes quota check
+run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
+
+# Just in case
+run_check $SUDO_HELPER "$TOP/btrfs" check --qgroup-report "$TEST_DEV"
-- 
2.25.0

