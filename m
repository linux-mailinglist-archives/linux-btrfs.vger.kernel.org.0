Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBB444F0EF
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Nov 2021 04:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhKMDRC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 22:17:02 -0500
Received: from out20-74.mail.aliyun.com ([115.124.20.74]:44090 "EHLO
        out20-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhKMDRC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 22:17:02 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05010938|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00178012-7.05462e-05-0.998149;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Ls4AvDG_1636773248;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Ls4AvDG_1636773248)
          by smtp.aliyun-inc.com(10.147.42.253);
          Sat, 13 Nov 2021 11:14:08 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs-progs: fix discard support check
Date:   Sat, 13 Nov 2021 11:14:08 +0800
Message-Id: <20211113031408.17521-1-wangyugui@e16-tech.com>
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

When hdd without TRIM/DISCARD support, the content of
queue/discard_granularity is '0' '\n' '\0', rather than '0' '\0'.

[FIX]
compare it against the right value.

Fixes: c50c448518bb ("btrfs-progs: do sysfs detection of device discard capability")
Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 common/device-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 74a25879..76d5c584 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -64,7 +64,7 @@ static int discard_supported(const char *device)
 		pr_verbose(3, "cannot read discard_granularity for %s\n", device);
 		return 0;
 	} else {
-		if (buf[0] == '0' && buf[1] == 0) {
+		if (buf[0] == '0' && buf[1] == '\n') {
 			pr_verbose(3, "%s: discard_granularity %s\n", device, buf);
 			return 0;
 		}
-- 
2.32.0

