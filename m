Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA2160134
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2020 00:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBOXtU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Feb 2020 18:49:20 -0500
Received: from gateway30.websitewelcome.com ([192.185.149.4]:44658 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgBOXtT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Feb 2020 18:49:19 -0500
X-Greylist: delayed 1429 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Feb 2020 18:49:18 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id A120D1BC36
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2020 17:25:28 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 36oSjiB3fEfyq36oSjr1LL; Sat, 15 Feb 2020 17:25:28 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bdCNfpW7t6VNwFasy7k2VvIB/wm+0mbQILc3SvG+KcA=; b=MxGIgd12ZjNojfH1YaeWuUh12w
        ByIAm3HFdZgLOn8XVhOLydaDBXG2xnkf6clnUcNRw8MZ/8ElJm40iv+NDQ2Afa0EadoUav2FXH0rQ
        l0ETpM6NTmWsgD6tk2ag1c6MHYn3UcpXgPncCBJ7wcqDL0xU5Agfjp7CeVyloRtTxfz2hHcQpQ1Xi
        66tTawkbDyFaj/WJ9wEzh+3Odjf0PuHYe4HLNOzE70OyGeyQuzJexgv+0t8Tfm67EVHJ3wWWOLDQK
        EdL9MMjqCsaZsHoxei0iJg/FsRtCWr/NtaL4vtBMma8KW/jv2kgkmw/ILEAwtaHfePR9lLsy/AzvH
        p8pwBD8w==;
Received: from [179.183.207.150] (port=37504 helo=localhost.localdomain)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j36oS-003VO6-4k; Sat, 15 Feb 2020 20:25:28 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] progs: tests: Avoid multidevice test on 32bit platforms
Date:   Sat, 15 Feb 2020 20:28:19 -0300
Message-Id: <20200215232819.30280-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.183.207.150
X-Source-L: No
X-Exim-ID: 1j36oS-003VO6-4k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [179.183.207.150]:37504
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This test uses truncate utility to create a 6E file but this fails
currently fails for PPC32[1], but it will also fail to other 32bit
platforms, so skip this test in these platforms.

[1]: https://github.com/kdave/btrfs-progs/issues/192

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

 I couldn't find a way to make truncate to use O_LARGEFILE option. I though even
 to write a helper to open the file using this flag and later on call ftruncate,
 but isn't it one more helper to maintain?

 If there are better ideas to avoid skipping this test, please let me know!

 tests/common                                      | 15 +++++++++++++++
 tests/mkfs-tests/018-multidevice-overflow/test.sh |  1 +
 2 files changed, 16 insertions(+)

diff --git a/tests/common b/tests/common
index 605cf72c..9aa69a1a 100644
--- a/tests/common
+++ b/tests/common
@@ -580,6 +580,21 @@ check_min_kernel_version()
 	return 0
 }
 
+check_32bit_machine()
+{
+	local msg
+
+	msg="$1"
+	if [ -z "$msg" ]; then
+		msg="Skipping test on 32bit machines"
+	fi
+
+	long_bit=$(getconf LONG_BIT)
+	if [ $long_bit -eq 32 ]; then
+		_not_run "$msg"
+	fi
+}
+
 # how many files to create.
 DATASET_SIZE=50
 
diff --git a/tests/mkfs-tests/018-multidevice-overflow/test.sh b/tests/mkfs-tests/018-multidevice-overflow/test.sh
index 6c2f4dba..8bb3d5a9 100755
--- a/tests/mkfs-tests/018-multidevice-overflow/test.sh
+++ b/tests/mkfs-tests/018-multidevice-overflow/test.sh
@@ -5,6 +5,7 @@ source "$TEST_TOP/common"
 
 check_prereq mkfs.btrfs
 check_prereq btrfs
+check_32bit_machine "32bit machines can't handle 6E file sizes"
 
 setup_root_helper
 prepare_test_dev
-- 
2.24.0

