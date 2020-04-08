Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEBF1A2215
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 14:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgDHMeb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 08:34:31 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.119]:43876 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728207AbgDHMeb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 08:34:31 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id E1047140EA41
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Apr 2020 07:34:29 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id M9uXjj9zbAGTXM9uXj5Zpo; Wed, 08 Apr 2020 07:34:29 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EVCnFQ+tLiPpiNNY00+WS8gzMQPEMnd2klKj8+mNtNs=; b=cqUkQvpABigXXxWyy5aqitF+Bo
        hO7KC8cKulGZt1pgLRr+t1lnOvgdSKGanEe7W21gEVMP/tu41eQIPEoUXgUw41XJe/YCanpc3q4U0
        X6fZgoTnlnzPT2Xwm5Hu+2Y29FjZa8O9vRSm79luTTToxod0G5oRMKH0CCzG6lDWpjxop9rBwKzkG
        jFmvEnkvKJkB6hRYmX/Q7/XNe0PKDzF3ot3EUtZSTGsBj8EjzK7n1cq9I8y/qDigm8aDkAkGN8POT
        Rqbvy1ydsr1lI+tifR+EANl7zQb1pe67tyVfY8OYhejEU87U6yWmiNqRPCdcxLxsjjQP7TQkR5zYD
        4+vEo7zg==;
Received: from 189.26.187.141.dynamic.adsl.gvt.net.br ([189.26.187.141]:43120 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jM9uX-002ssy-2A; Wed, 08 Apr 2020 09:34:29 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        Erhard Furtner <erhard_f@mailbox.org>
Subject: [PATCH] btrfs-progs: mkfs-test: Fix check for truncate command failing
Date:   Wed,  8 Apr 2020 09:37:28 -0300
Message-Id: <20200408123728.19595-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.187.141
X-Source-L: No
X-Exim-ID: 1jM9uX-002ssy-2A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.187.141.dynamic.adsl.gvt.net.br (hephaestus.prv.suse.net) [189.26.187.141]:43120
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Commit 31f477ee ("btrfs-progs: mkfs-tests: skip test if truncate fails
with EFBIG") tried to detect a failure in truncate command by checking
the $? expecting it to be an errno, when it actually returns 0 or 1.

To fix this test just check if the command failed (returned 1) and look
for the output, skipping the test if the OS cannot create a 6E file.

Fixes: #241

Tested-by: Erhard Furtner <erhard_f@mailbox.org>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/mkfs-tests/018-multidevice-overflow/test.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/mkfs-tests/018-multidevice-overflow/test.sh b/tests/mkfs-tests/018-multidevice-overflow/test.sh
index eb5c0a43..55ec1289 100755
--- a/tests/mkfs-tests/018-multidevice-overflow/test.sh
+++ b/tests/mkfs-tests/018-multidevice-overflow/test.sh
@@ -15,14 +15,15 @@ run_check_mkfs_test_dev
 run_check_mount_test_dev
 
 # truncate can fail with EFBIG if the OS cannot create a 6EiB file
-run_mayfail $SUDO_HELPER truncate -s 6E "$TEST_MNT/img1"
+out=$(run_mayfail_stdout $SUDO_HELPER truncate -s 6E "$TEST_MNT/img1" 2>&1)
 ret=$?
-if [ $ret == 27 ]; then
-	_not_run "Current kernel could not create a 6E file"
-fi
 
-if [ $ret -gt 0 ]; then
-	_fail "truncate -s 6E failed: $ret"
+if [ $ret -ne 0 ]; then
+	run_check_umount_test_dev
+	if [[ "$out" == *"File too large"* ]]; then
+		_not_run "Current kernel could not create a 6E file"
+	fi
+	_fail "Command failed: $out"
 fi
 
 run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img2"
-- 
2.25.1

