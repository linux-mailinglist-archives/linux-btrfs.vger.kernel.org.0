Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C1E174B0D
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 05:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgCAES6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Feb 2020 23:18:58 -0500
Received: from gateway20.websitewelcome.com ([192.185.63.14]:16188 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgCAES5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Feb 2020 23:18:57 -0500
X-Greylist: delayed 1497 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Feb 2020 23:18:57 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 26E3F400D4CFA
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Feb 2020 20:16:29 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 8FJjjUIlIEfyq8FJjjZEEJ; Sat, 29 Feb 2020 21:30:59 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X/bW6P3VVRT9vUyAHqL96x5K0HV6r6CvSjjaoMpJ+LQ=; b=Isn5nDXyl/9u9Lrq8kNiEsJgdb
        ta1VYCsCEtEVJZZSSnjcB6GWHwbXH7VAFbSpSnTilxVtmOY0X5knzkK7ShPz6N0V/0QF99vP5n2Fj
        DS9waz67SAOFkJKn+G32pVTciAUuPcnq0ov12ctrA7xQKdv2yE625a/OjEN2CCXFoC/FpJd7WPYOS
        WtmypmQqiQpHwZsbGcEc8w2OQfQwZeK9cFND6RIFD9YiJCevWc5maHgqH/siPut2oDUIv5EsZYidl
        kT7OdVpWkdPg9YdP6Q+BbT8gjYGYz2F3w5saiieoqCCLB/xSK+qhqNsTsDsSe6Qsz5uwcYLQksLpz
        wDsNzX1A==;
Received: from 179.187.200.220.dynamic.adsl.gvt.net.br ([179.187.200.220]:36120 helo=hephaestus.suse.cz)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j8FJi-0003yt-VU; Sun, 01 Mar 2020 00:30:59 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] progs: Include btrfs-find-root and btrfs-select-super in testsuite
Date:   Sun,  1 Mar 2020 00:33:43 -0300
Message-Id: <20200301033344.808-3-marcos@mpdesouza.com>
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
X-Exim-ID: 1j8FJi-0003yt-VU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179.187.200.220.dynamic.adsl.gvt.net.br (hephaestus.suse.cz) [179.187.200.220]:36120
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 7
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Since these two binaries are not shipped into userspace, and they are
used by the testsuite, they need to be include in the final tar.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Makefile              | 2 +-
 tests/testsuite-files | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b00eafe4..0cd7f0c1 100644
--- a/Makefile
+++ b/Makefile
@@ -424,7 +424,7 @@ test-inst: all
 
 test: test-fsck test-mkfs test-misc test-cli test-convert test-fuzz
 
-testsuite: btrfs-corrupt-block fssum
+testsuite: btrfs-corrupt-block btrfs-find-root btrfs-select-super fssum
 	@echo "Export tests as a package"
 	$(Q)cd tests && ./export-testsuite.sh
 
diff --git a/tests/testsuite-files b/tests/testsuite-files
index 09df6298..507d35fb 100644
--- a/tests/testsuite-files
+++ b/tests/testsuite-files
@@ -3,6 +3,8 @@ G Documentation/
 F testsuite-id
 F ../fssum
 F ../btrfs-corrupt-block
+F ../btrfs-find-root
+F ../btrfs-select-super
 F common
 F common.convert
 F common.local
-- 
2.25.0

