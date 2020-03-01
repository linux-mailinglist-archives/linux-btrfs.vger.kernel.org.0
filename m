Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7E9174AE9
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 04:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgCADbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Feb 2020 22:31:05 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.38]:17699 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727242AbgCADbF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Feb 2020 22:31:05 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 9A41140190A3F
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Feb 2020 21:31:03 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 8FJnjyJaAvBMd8FJnjtSMW; Sat, 29 Feb 2020 21:31:03 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WZVDCopJ5K/YjtaXUIYj2umLkfZdFI6OZACX9SWXTDg=; b=scGBz+OSJxZ7mUN62U4IVGmNYb
        HmJxeMNiV4Fkk1fL8LVlccjIVwuKsgaRYF6BF13Buex+OuH1CL0HdoTEKRVU3hM0uYVcgUaqoz2WH
        KjqnxFKiq83964erlXlONiZJyq4ItNLBOKcgDDsZt2bqAADEVDqF6RHaEnK/pGrPaF4oirFrNGh5D
        GhLOiCRWXbtaF5NBI90OKyeZFuCbu5H0p9O5aw+j/pABGSfwzuCttrUwNkXY2ZIkDaaoZXvkhOAJN
        xUM28HxFkX/5yBvf+yZ5VnqD2cY2br+DL/u+hRVXp3idlRC1svrjqMhA2Kf2ZFOFqieVzvPTBX9/y
        CQlH8BcA==;
Received: from 179.187.200.220.dynamic.adsl.gvt.net.br ([179.187.200.220]:36120 helo=hephaestus.suse.cz)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j8FJk-0003yt-Kp; Sun, 01 Mar 2020 00:31:01 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] progs: tests: misc: btrfs-{find-root,select-super} are internal commands
Date:   Sun,  1 Mar 2020 00:33:44 -0300
Message-Id: <20200301033344.808-4-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200301033344.808-1-marcos@mpdesouza.com>
References: <20200301033344.808-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.187.200.220
X-Source-L: No
X-Exim-ID: 1j8FJk-0003yt-Kp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179.187.200.220.dynamic.adsl.gvt.net.br (hephaestus.suse.cz) [179.187.200.220]:36120
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 10
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

With this commit, testsuite works as expected.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/common                                        | 13 +++++++++----
 tests/misc-tests/012-find-root-no-result/test.sh    |  2 +-
 .../020-fix-superblock-corruption/test.sh           |  2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tests/common b/tests/common
index 605cf72c..26190d85 100644
--- a/tests/common
+++ b/tests/common
@@ -305,13 +305,18 @@ run_mustfail_stdout()
 
 check_prereq()
 {
-	if [ "$1" = "btrfs-corrupt-block" -o "$1" = "fssum" ]; then
+	case "$1" in
+	btrfs-corrupt-block|btrfs-find-root|btrfs-select-super|fssum)
 		if ! [ -f "$INTERNAL_BIN/$1" ]; then
 			_fail "Failed prerequisites: $INTERNAL_BIN/$1";
 		fi
-	elif ! [ -f "$TOP/$1" ]; then
-		_fail "Failed prerequisites: $TOP/$1";
-	fi
+		;;
+	*)
+		if ! [ -f "$TOP/$1" ]; then
+			_fail "Failed prerequisites: $TOP/$1";
+		fi
+		;;
+	esac
 }
 
 check_global_prereq()
diff --git a/tests/misc-tests/012-find-root-no-result/test.sh b/tests/misc-tests/012-find-root-no-result/test.sh
index 6dd447f3..edfdfd38 100755
--- a/tests/misc-tests/012-find-root-no-result/test.sh
+++ b/tests/misc-tests/012-find-root-no-result/test.sh
@@ -11,7 +11,7 @@ check_prereq btrfs-image
 run_check "$TOP/btrfs-image" -r first_meta_chunk.btrfs-image test.img || \
 	_fail "failed to extract first_meta_chunk.btrfs-image"
 
-result=$(run_check_stdout "$TOP/btrfs-find-root" test.img | sed '/^Superblock/d')
+result=$(run_check_stdout "$INTERNAL_BIN/btrfs-find-root" test.img | sed '/^Superblock/d')
 
 if [ -z "$result" ]; then
 	_fail "btrfs-find-root failed to find tree root"
diff --git a/tests/misc-tests/020-fix-superblock-corruption/test.sh b/tests/misc-tests/020-fix-superblock-corruption/test.sh
index 404d416b..d67a87c3 100755
--- a/tests/misc-tests/020-fix-superblock-corruption/test.sh
+++ b/tests/misc-tests/020-fix-superblock-corruption/test.sh
@@ -25,7 +25,7 @@ test_superblock_restore()
 		_fail "btrfs check should detect corruption"
 
 	# Copy backup superblock to primary
-	run_check "$TOP/btrfs-select-super" -s 1 "$TEST_DEV"
+	run_check "$INTERNAL_BIN/btrfs-select-super" -s 1 "$TEST_DEV"
 
 	# Perform btrfs check
 	run_check "$TOP/btrfs" check "$TEST_DEV"
-- 
2.25.0

