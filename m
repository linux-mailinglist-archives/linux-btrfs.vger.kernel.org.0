Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A8244F5A9
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Nov 2021 23:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhKMWqQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Nov 2021 17:46:16 -0500
Received: from out20-38.mail.aliyun.com ([115.124.20.38]:37695 "EHLO
        out20-38.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhKMWqP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Nov 2021 17:46:15 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04864379|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00265987-0.000193958-0.997146;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.LsQUQWc_1636843400;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LsQUQWc_1636843400)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sun, 14 Nov 2021 06:43:21 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH v2] btrfs-progs: fix discard support check
Date:   Sun, 14 Nov 2021 06:43:20 +0800
Message-Id: <20211113224320.31415-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
mkfs.btrfs(v5.15) output a message even if the disk is a HDD without
TRIM/DISCARD support.
  Performing full device TRIM /dev/sdc2 (326.03GiB) ...

[CAUSE]
mkfs.btrfs check TRIM/DISCARD support through the content of
queue/discard_granularity, but compare it against a wrong value.

When HDD without TRIM/DISCARD support, the content of
queue/discard_granularity is '0' '\n' '\0', rather than '0' '\0'.

[FIX]
- compare the value based on atoi() to provide more robustness
- delete unnecessary '\n' in pr_verbose()

Fixes: c50c448518bb ("btrfs-progs: do sysfs detection of device discard capability")
Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 common/device-utils.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 74a25879..65353f28 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -64,8 +64,9 @@ static int discard_supported(const char *device)
 		pr_verbose(3, "cannot read discard_granularity for %s\n", device);
 		return 0;
 	} else {
-		if (buf[0] == '0' && buf[1] == 0) {
-			pr_verbose(3, "%s: discard_granularity %s\n", device, buf);
+		/* string(buf) end with '\n\0' */
+		if (atoi(buf) == 0) {
+			pr_verbose(3, "%s: discard_granularity %s", device, buf);
 			return 0;
 		}
 	}
-- 
2.32.0

