Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC4038BDA7
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 06:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhEUE77 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 00:59:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33623 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhEUE76 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 00:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621573114; x=1653109114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BMzzgh8GSxXU9CkEFRRfM/fB9xhgUx9/ipLX1hXvze8=;
  b=bNC6y8r1aVTr9Km8ms10A1CHxZqnyfP+h2QKbjOe8T8sOzphO11gMo6I
   xrbeaZ5CYYt86eURHmTp2Q6gqyu2o0ncNbaAP3dgOkx6Vwz0YFiS4f+oV
   72eNe1TUoMVjteQaduE+FU9XBSQbc2U76pCE7wH19qQA+N/StXUQS+sPR
   Du/WVOHI3UbFP0L5sCLmykn9q4zykyvVjm9Tc6E0FTyn8d+++q2HHjc0F
   6BCbxzr8gxIinzsh75MUCwaYWW9nRwN0/Q9JHOH0g+iLOhxMqa8aChEXl
   WBrXWJ1GbY4VLSU9IZRikWLjuUL+N6YvghixwGG0bi5Ub7dd7F2/iHt+6
   Q==;
IronPort-SDR: Gwd1hZ3PSXYtV/iAzvPTRPHPSfkRaxwmCSZlhoakEN/9R/7MOM138f6cLUh2t7+wu49pYUxNox
 IDM15w2ApLEoDBA4pFhuBQxVi4+lv4MopyNoAvGXNZUMhP2ath2U3/KMg++W3MskglWW6gEeWD
 Rpzp2XLeBT3b8G1M2pOJezP6yH9MQ4j9qF8LuYEEAD05hNVc4HxczYeqRh3RCnOPHW2dgL0NLP
 LlZJs7cWhTMTUTro455BOC0oFUJl9bqcHNq/zrwcoVXavS7A9bdtz0tgqKy6EXavTsMZB/S6sn
 PuM=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168955584"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 12:58:33 +0800
IronPort-SDR: uLN+NsOL48XQbXKMGzpWCeMAuwbplkAlkDYLtfU0wJ+mGkaeHcL43GnPVT1bbmOYd1+GjzqLnb
 CfV7cSBoroj1RkAMOz+U1pFl7Wc10hC66DXbMAIyFRGSqvP0actwovGrPJ23Bs6guqSHamDEk4
 O8KUrpN4hcYbvMnDtBp0370Qx498DW4X8ocuF4ZycK4uxSv96nUCcxRmw7j3JnWYue8ewMWRmd
 6zZS4gSlcHbqnz71fHAEnX4k+3ptcVKpFTjVDhQQte/JVLkLwRtvq1AOiSmobhLHrGDu9x8/Kl
 V58706cxmFGHI7aCE4KR3XyA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 21:36:58 -0700
IronPort-SDR: 5UfIgoLuc2k2TSO97MjjgAVDsEwuMm3IzfxEUJiL1BBFqSYd+RauTvIPm/t8rCNshYEE8W3TN8
 Qy80fpEWqi8yp+4WBbKtsexkKtK298Za9mYHrualSDV1HwONlYYAuclqYyXzutOd540vX9LKIS
 BFR3GXE2HOmz+/E2KFtWoDq2Me4ysuzq4q5JAN+HZIJKUR3djbtHxHskLnNR0YnI7apMDTQo/j
 toMINBNHk0lU3ybLaAQ/sp34V1/ja5kVVOnvxRWMzfx+XDQU/3rcvPTDCIyOxwg8HYglgmUpMx
 xIA=
WDCIronportException: Internal
Received: from 9rp4l33.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.75])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 21:58:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/5] fstests: add checks for testing zoned btrfs
Date:   Fri, 21 May 2021 13:58:20 +0900
Message-Id: <20210521045825.1720305-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Several tests are failing on zoned btrfs, but actually they are
invalid. There are two reasons of the failures. One is creating too
small filesystem. Since zoned btrfs needs at lease 5 zones (= 1.25 GB
if zone size = 256MB) to create a filesystem, tests creating e.g., 1
GB filesystem will fail.

The other reason is lacking of zone support of some dm targets and
loop device. So, they need to skip the test if the testing device is
zoned.

Patches 1 to 3 handle the too small file system failure.

And, patches 4 and 5 add checks for tests requiring non-zoned devices.

Naohiro Aota (5):
  common/rc: introduce minimal fs size check
  btrfs/057: use _scratch_mkfs_sized to set filesystem size
  btrfs: add minimal file system size check
  common: add zoned block device checks
  shared/032: add check for zoned block device

 README            |  4 ++++
 common/dmerror    |  3 +++
 common/dmhugedisk |  3 +++
 common/rc         | 15 +++++++++++++++
 tests/btrfs/057   |  2 +-
 tests/btrfs/141   |  1 +
 tests/btrfs/142   |  1 +
 tests/btrfs/143   |  1 +
 tests/btrfs/150   |  1 +
 tests/btrfs/151   |  1 +
 tests/btrfs/156   |  1 +
 tests/btrfs/157   |  1 +
 tests/btrfs/158   |  1 +
 tests/btrfs/175   |  1 +
 tests/shared/032  |  2 ++
 15 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.31.1

