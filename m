Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B286C36910A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Apr 2021 13:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhDWL1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 07:27:17 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21581 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWL1Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 07:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619177200; x=1650713200;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PnY7VxeJzkWGSF/sas0OXVPr+eFtl33l1V8Wtrbt61s=;
  b=RY29W4HzcC/20QOOQoGiJ5VKTpettLbUJOuaDRW8dJA7locK0YJUodXr
   SxhmYNCl68nxNljG6+KmgwdMHbjN/BL4nIk+0ZydxRpm6vQ7KoxYyOGot
   XZZ5D0/lFzzB7/vx1wTVqeleITErfZuTq9zvWb0PwnGWDyAvtlKurHLtT
   LWLcN1BR6vxqGmuNYAQTLfZVk37V0wVAeBur6/STRVJ8qYkpV2YLt3uAI
   RnuVLEIk4VXIfrNJ2GYJh8VYcOhttMev684rFK/Vf373gy+8MOkTIm1Ba
   UBvbjFiReywiGnWL+0KNHsS0RDRuGZgYNxUZx46bvFvtStbvybAsxMAUC
   w==;
IronPort-SDR: ++b3V06eeldfxsI8QsrmF5CxAk6leXzBCWNrBBellwe3L+mgufopIsDXjQMg8qfDiPcqbdF/+j
 NCLwfTMDoi4l0rCyfp9LsTf6VobJypIYlzjr1F1W/7u0/+Eh9rwgceUG+wzUbJn4Ck4kGdFYH6
 53lpI23xj++su7FOCZp+de2/lkiYg3A1q3QUb7goMQOPjLibc5rG/MqMrfy/oSNvHJ+cT3hrVb
 +7a66iCXcdUbU3q32K4Tx9YEPWSQGnShkUHrS4IqyiNJv59V8o/olE/NlKDYxKq0Zs0LMSJseY
 6nw=
X-IronPort-AV: E=Sophos;i="5.82,245,1613404800"; 
   d="scan'208";a="165365021"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2021 19:26:40 +0800
IronPort-SDR: igPmVvqVlDFhiwbH4c0a8xUmfPLFCiAUjwHhIgQsNAZ5z+a6IIzVnjREs2eHYFKPLtaw748wQl
 8sUpNJIIrYCb3KSRgiYpPDTa59m+IzPnZnmKUMsxPSxA21LTMSRLdb5WWYNx3idBg6uG103YPB
 7czhZhh041vF8krOUzW15TmQnkFXn9cx88ymJKz7gcOjZHGHOux6qQTRe0DIK/2QW1lisN2yWh
 7+0RM64NNgXItPH0TahbiMUCcsDX3mZIrIxK4d7my6bbutrh0xufbxfEuzyPRzqO2Voazhx2n3
 vo/GAoMhT1Ft9h649VXmyaPZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 04:07:14 -0700
IronPort-SDR: lyp6Oiq75CJ7AsVhwVsTtXK+Gy2rI5LQPUYpx6z0jzhKCM6xyFRkhgXPxVnriX26oqwB7T/1dq
 7czE8hcvRKMSs/DwiWByWWe7NHGLz/eB1SYdCatapB3K55PM0wvkMH1NvcyqnZVUXtWnUag95w
 QbyGqbxF3+GJpeFMfIs08Ry9MIUA8s/ccCZdMUPgjQmphpCqiqU6rxdTPLr9cp3f7d50/0Jc2L
 C1qa6LZ1Bhbjgvzca/RoFAT27F0M1ZytiY91d3SgA0vagVoo1lvvpK+yCa1CbmHNQzB2xCZqHf
 wGU=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Apr 2021 04:26:39 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/4] fstests: first few support patches for zoned btrfs
Date:   Fri, 23 Apr 2021 20:26:30 +0900
Message-Id: <20210423112634.6067-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series adds 3 tests to prepare xfstests for testing on zoned block
devices and a first test for btrfs' zoned block device support.

General zoned block device support for btrfs was merged with v5.12 and the
zone auto reclaim feature is staged to be merged with v5.13.

Johannes Thumshirn (2):
  btrfs: require discard functionality from scratch device
  btrfs: add test for zone auto reclaim

Naohiro Aota (2):
  fstests: add missing checks of fallocate feature
  common/rc: introduce zone check commands

 common/config       |   1 +
 common/rc           |  52 ++++++++++++++++++++++
 tests/btrfs/013     |   1 +
 tests/btrfs/016     |   1 +
 tests/btrfs/025     |   1 +
 tests/btrfs/034     |   1 +
 tests/btrfs/037     |   1 +
 tests/btrfs/046     |   1 +
 tests/btrfs/107     |   1 +
 tests/btrfs/116     |   1 +
 tests/btrfs/156     |   1 +
 tests/btrfs/236     | 102 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/236.out |   2 +
 tests/btrfs/group   |   1 +
 tests/ext4/001      |   1 +
 tests/f2fs/001      |   1 +
 tests/generic/456   |   1 +
 tests/xfs/042       |   1 +
 tests/xfs/114       |   1 +
 tests/xfs/118       |   1 +
 tests/xfs/331       |   1 +
 tests/xfs/341       |   1 +
 tests/xfs/342       |   1 +
 tests/xfs/423       |   1 +
 24 files changed, 177 insertions(+)
 create mode 100755 tests/btrfs/236
 create mode 100644 tests/btrfs/236.out

-- 
2.30.0

