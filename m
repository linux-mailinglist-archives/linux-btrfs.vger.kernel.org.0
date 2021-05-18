Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A58387C9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350272AbhERPmO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 11:42:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32432 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350259AbhERPmN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 11:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621352455; x=1652888455;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1j1Qg68g81Fm09D/5uveImlEtXjdjJ9c73VzGDodCsc=;
  b=T+wpvnRF2X7DTAtFvfBW56WTzBkZq7zxFE+7JexdL99hO+G4njfB+/zM
   BJM1oo5YBUxQ78XA43jM1jULcN9Zy+Io0zU8n//q1/InhQWEJbCUcysyn
   58AwIGcxl5mTGa6v9V7ir/LxYJ5Y3tXnfJlhjLoPQ7eOzpsHalK447JI5
   L9/g5N52l2KM1eJwLdIgmG5DfNAqRNIoZojv+ddpIgKZofBa8I2QbZGh5
   tOLuYQN35DelN+PLo+D6AvJSxVOroqKp6PPrQfqS6MsDqzKDXMHyTYLiX
   y+AtNTyGkRK3hA9QODzDfSiYhpRzVHHXCxvxvr3HVlxxUFd+wRpEDqXbf
   w==;
IronPort-SDR: kCl//1/XsObD1bti9VVdQ2UZNRzKCcpCPCvt+nXRLvfXyKEasYNuizYpuBwbtELppaK0aDj7ue
 VNHTyCnihp+/KDuX/xuSpmtY73pE9OhGVmfXkyqsBn58sBdF+kMwYGvztu9Z5Quo/2xaV5g/Uv
 rtK5oZSUW51DDzTNPJgMxkt3Tu2lJskXq0cULSdjTGCgUhuK0BVf55lUBHEqKMUKmRc9EcEGjc
 RhRVCuZQn0LZkYVu4IX6O3UnpNRfCNtBp27VFnkdfYhPNuJVzbrUPtEonekKIWQYcYwHqQT/Zx
 UME=
X-IronPort-AV: E=Sophos;i="5.82,310,1613404800"; 
   d="scan'208";a="279802251"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 23:40:54 +0800
IronPort-SDR: TEwzXbS/pLD8w8MVCDojRvJX7mZ6Rbpv4onjRunnPLq9EUI5cjphvUU4wq3jC50rwoYh6Rh4/I
 XnzypH6oRf5uj1bLPFX8/cjXsyew+UCCJmQaTttdyNCkc5C39uOCGrLM5pQbLO+xf6O+O6giCc
 fWty3W7sHNAoKsLlxJScWD8rdyUH5g/HWmhnPGiCfJjHI4/Lnl4LRu4ma2I/Fxz2OG2YaTI0xP
 uRFpYZzciark/gEE8vXN093RBd26/GabCisRNcnrrggQrXmtSjC6jmpsgjfSuKz34ajd1JhJ1b
 nWEnhjxgtdCogfFZo4a4pt2t
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 08:20:34 -0700
IronPort-SDR: qsoqR65fxEadP/w/2fRNaUHDMn2tNarMJMesWDy2IjKSdiSK2/8JwHe6yQDKPReylzy4Mqm2bZ
 BoSmr0/IlY8agivBrvJS0oI8gYmYdjW3Y0h3mbbaBsab/3Y27qvEPQk2p5LMitPAoR2sZ/+CmX
 a3wZCU+A4aeEG0b/hdWtirmrAm1/JWG/YNmyBvU4LdfOys4ZIzPViz+tRyxlmMk6AuUFhDr1pV
 UnMWxIAh5FdBCJbLUG9fARsNl2aCcj0rwN7R8ndEBpCIdLgva/A16uDoSQLHsYhnFamcJZMzE3
 NFg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 08:40:54 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/3] btrfs: zoned: fix writes on a compressed zoned filesystem 
Date:   Wed, 19 May 2021 00:40:26 +0900
Message-Id: <cover.1621351444.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David reported that I/O errors get thrown on a zoned filesystem with
compression enabled.

This happens because we're using regular writes instead of zoned append, but
with regular writes and increased parallelism, we cannot guarantee the data
placement requirements can be met.

This series switches the compressed I/O submission path to zone append writing
on a zoned filesystem.

Changes in v2:
- Factor out zoned device lookup
- limit scope of bdev variable

Johannes Thumshirn (3):
  btrfs: zoned: pass start block to btrfs_use_zone_append
  btrfs: zoned: fix compressed writes
  btrfs: zoned: factor out zoned device lookup

 fs/btrfs/compression.c | 35 +++++++++++++++++++++++++++++++----
 fs/btrfs/extent_io.c   | 18 ++++++------------
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/zoned.c       | 25 +++++++++++++++++++++++--
 fs/btrfs/zoned.h       | 14 +++++++++++---
 5 files changed, 72 insertions(+), 22 deletions(-)

-- 
2.31.1

