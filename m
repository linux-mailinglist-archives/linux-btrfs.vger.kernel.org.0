Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADF916AE4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 19:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgBXSCq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 13:02:46 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.202]:38308 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbgBXSCq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 13:02:46 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id A8C4281D2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2020 12:02:45 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 6I45jaE28RP4z6I45jzOcj; Mon, 24 Feb 2020 12:02:45 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MX9pudMvP4xZedQlg2/8BH0PG8pXREioC3Sawi5rXsE=; b=eVITvtv1fsr3TAu1ds8LzhdUIP
        l//SWvLOBu9qfjB4SyJJWR1+B64j1pNsMCP5yUkE+xT3l5LIgTqwgQ1d1iee3rx6XjPBPZtc1YC0S
        ALh45nBHhrUzghjAHcFzw+Id2lXs/9GmdnmKHrjyuAx5ZEK9P9kzHXKvokxj2JvLufrRIcCCTqgud
        lo8WhnylSpheMBmPSOdkFBa4oPYq9VjfVJaQMti3ApsmlT88WqEvdB/b7MpT7VqJ8DLD9rLl2dQHp
        YJfwWc5SORQzx7KMfjOiDcYc6JJXp8WeWwxXhqXIZxgHbsjicK/xyE3QYtWb+zB6PcsGy9lHdhD3j
        wRQHgmrw==;
Received: from [191.248.104.15] (port=44488 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j6I45-003X6R-1O; Mon, 24 Feb 2020 15:02:45 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv2] progs: mkfs-tests: Skip test if truncate failed with EFBIG
Date:   Mon, 24 Feb 2020 15:05:34 -0300
Message-Id: <20200224180534.15279-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.248.104.15
X-Source-L: No
X-Exim-ID: 1j6I45-003X6R-1O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [191.248.104.15]:44488
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

The truncate command can fail in some platforms like PPC32[1] because it
can't create files up to 6E in size. Skip the test if this was the
problem why truncate failed.

[1]: https://github.com/kdave/btrfs-progs/issues/192

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes from v1:
* Only check if truncate failed with EFBIG instead of skipping the test on 32bit
  platforms (Suggested by Wenruo)

 tests/mkfs-tests/018-multidevice-overflow/test.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/mkfs-tests/018-multidevice-overflow/test.sh b/tests/mkfs-tests/018-multidevice-overflow/test.sh
index 6c2f4dba..14ecbf89 100755
--- a/tests/mkfs-tests/018-multidevice-overflow/test.sh
+++ b/tests/mkfs-tests/018-multidevice-overflow/test.sh
@@ -14,7 +14,15 @@ prepare_test_dev
 run_check_mkfs_test_dev
 run_check_mount_test_dev
 
-run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img1"
+# truncate can fail with EFBIG if the OS cannot created a 6E file
+run_mayfail $SUDO_HELPER truncate -s 6E "$TEST_MNT/img1"
+ret=$?
+if [ $ret == 27 ]; then
+	_not_run "Current kernel could not create a 6E file"
+fi
+
+[ $ret -gt 0 ] && _fail "Truncate command failed: $ret"
+
 run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img2"
 run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img3"
 
-- 
2.25.0

