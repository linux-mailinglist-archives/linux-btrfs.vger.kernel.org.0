Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0366714EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfGWJUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 05:20:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59954 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfGWJUV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 05:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563873622; x=1595409622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9hG2yE9mA1V8SJQuHrGfk8aqmLgeOlG+KvqsvxJJzKU=;
  b=MO6/f+gUROKNvcjYSc3awimzifnbIgo2G98wcF9AJ2nSeTkW5Oy/jbUG
   KUujYyp5634zvf3meiKKDe7qcNFL7SFu+lP9QY+EKWqwDzIvvJdL2577k
   toDNsnPkF6IhNjxHr5TJZlop4UlBO9upEtRI6ZyVmMKz00wcPiNPX6v0Q
   3VsEgq6R5NkzuviXt5uxHZVOq86h7MCyDzd8dTCgw0SDRaD+X6+AUSj2S
   b+Cm0aNRNIqAJUAqlUjA8c2y/LS9i/8zpUjtIR0FRpXZyGcaeMZwzGaJf
   sv5IQz3r52pwl52dT7brZDp7qlUAgqEFp5KKQVORLIvUq52mi2HEFiMYn
   Q==;
IronPort-SDR: ZLJJXn1ZttgAE6Dk1vDz1JiDyVYuThZ7rjlNP1o7PH8mZlyPg/mtzZb+bBcMsYsQAlikVO0o6+
 FxB2NLkM4IOX0xLDAdzS98LgTNLEMFVZkF4+ylkPcreEuvqs6K+lijlTZydIScqiMS/ENhbsAi
 CO52uO0DsuPMIhDzJoLu96YSSH4vVtH3yE9dIIaSgBikbVIdJqZwcA3MmLmt0zm7QgM4ZX2m40
 CQ1L2jVLkACWK74yDpr+Ng/b9dguzAxiJzB46P3UQMA0XOYXkh1i4PYJ6RmSt01WtLPupBfCvA
 U8s=
X-IronPort-AV: E=Sophos;i="5.64,298,1559491200"; 
   d="scan'208";a="113777525"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2019 17:20:22 +0800
IronPort-SDR: riSNiQ+uAwi8FgjN66gcIbaAXANvhrYvMAVUnElVYNMjZxWfY3WhdqELNV6P97q/HThdgcxlFB
 WCkcMI77UCusMBRsopMvZDkK8LYWTk8LfMNBK0JfRhXmz87qSCTRownzcc6IwR/WiMNU3bSjar
 qxpmnA+dYPv99VfJaMjUBZWvnlpRDF6Fmfol02a9uxAjq3kvP4xqcWsXz1ka4Obc8Wtl7nFEkq
 VrRfmxG3sSMsu3pzM0S8diZlk0/BsxSF4vMYrlTcF9MLtQAJ2I+Aj4Q4m7cIXfzGV6CG24woZ0
 XeyWbri9+bjtLZN/NDq7zy9w
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 Jul 2019 02:18:36 -0700
IronPort-SDR: 4o5xXYoWZc1ALKa80xS42mGllZ8F/ZWjmhUMMvKvoxpYuTy0DnrBb9t/lEuV0jO/S+wcONNeLO
 GtTCRfK2Qv+8ayxVivvmmMa5suyAgj+sGY6YF9IXhy3JKG23jdR4PGNXgo8MYST9oyAn3pXEPN
 ZQv+VOrZ9QDEG6XDz/u0KYGiOyfBh+Ft4AbxhYDUA36ymkJLLhg+jLsGhqz7/io5F13i5EvNbw
 oP0+h5BngKrULNlCkY7S7/EZZuA+6G0fidaT+2UBiXcAZK7YpdRKRdOhdUHfI2qy2/e/5VgXSa
 yUI=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2019 02:20:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs-progs: check: initialize qgroup_item_count in earlier stage
Date:   Tue, 23 Jul 2019 18:19:11 +0900
Message-Id: <20190723091911.19598-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

"btrfsck -Q" segfaults because it does not call qgroup_set_item_count_ptr()
properly:

  # btrfsck -Q /dev/sdk
  Opening filesystem to check...
  Checking filesystem on /dev/sdk
  UUID: 34a35bbc-43f8-40f0-8043-65ed33f2e6c3
  Print quota groups for /dev/sdk
  UUID: 34a35bbc-43f8-40f0-8043-65ed33f2e6c3
  Segmentation fault (core dumped)

Since "struct task_ctx ctx" is global, we can just move
qgroup_set_item_count_ptr() much earlier stage in the check process to
avoid to forget initializing it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index bb57933b83fc..7248a8209532 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9965,6 +9965,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 
 	radix_tree_init();
 	cache_tree_init(&root_cache);
+	qgroup_set_item_count_ptr(&ctx.item_count);
 
 	ret = check_mounted(argv[optind]);
 	if (!force) {
@@ -10291,7 +10292,6 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	}
 
 	if (info->quota_enabled) {
-		qgroup_set_item_count_ptr(&ctx.item_count);
 		if (!ctx.progress_enabled) {
 			fprintf(stderr, "[7/7] checking quota groups\n");
 		} else {
-- 
2.22.0

