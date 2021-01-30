Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31B23094C6
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jan 2021 12:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhA3L2B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Jan 2021 06:28:01 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14341 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhA3L2A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Jan 2021 06:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612006079; x=1643542079;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z2CtjrXAAt/kqg5CWOXKUrEnARMJ+c/BYtxmOdOfZ6s=;
  b=F7f++XE/pm1064sRByVaMgBl0Yk78rc0IhJVII9lJb/rGnuVqQGhTy/f
   6R2s93FJRRNX2Go8pKsDUM6buHQrmMphfaS6dV9YiFWQNM1+W6PE0qioE
   zkzJJpcT0g218TM0i7ArnZjC1uDURge0sflmFK7xqYwLw6oxGf2nuGtW2
   6iHCZhGeFJxdxJhTP6+P/MgwmiO0Ijh/CjVPJLPiWmRxijJvILKpr+9It
   Ctg9N44PP5qeLgdrzNd2RJ9EhcrcPysdz2wM3ZNN0X2Nawa5Ys3eUK5tP
   FHUF7Ud6wqCvhZMxrndJ3vOz2ssmBmgfla7lwYFFRr1m2V3mQS8a7MWn2
   w==;
IronPort-SDR: GiRUlBXVIkRzS1AMa7r9piwotd9vQmuz2QxC6MBwoNw0FIWX50TJbx1pGylYDm2UgmOM5QnlhB
 Zluv2OCgfRD/etxi6gt3CSmDX4AJ8t6ZvkL0Y2ODmN8v0PQtmTLSaxWnLx+2fbw1swwKzjcuSS
 ckgvjcZzDeNcNhC6QOi2pBjtXMWQd6N5iMZywI5EgwpeaKx4EevTEt/TYTbz5qQvQg/y02o24q
 lzJa3vOnOad3AUUu6Owe8KQReBhCIwc3NXVIQ0D+sWcmEMbuK7NDVOVx3Xtz1Mh91Y7tLRKyTF
 JkQ=
X-IronPort-AV: E=Sophos;i="5.79,388,1602518400"; 
   d="scan'208";a="158695894"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2021 19:26:54 +0800
IronPort-SDR: BvDlaqDpnAZhtKaiGK2xxo/oVjVAMRJTJu/P17u3n16i4Fu15/xwJAVhxEui9Qzh35aJbVcYxq
 GWRMjDmxYnyiAKIFVabzCP3fktuCtt9yUWsPDIlP63XC5Dxh1cAoBicn4aRZxAflPmvV3sMTQA
 wBvgqli89ToROx+2of3WplibEnD7SRomKTSHxcnMJr//WCpNk34jUK5YTPvYDJGnvQRvBA8DNi
 cjj85uTpxYLoS3y/FCtACqu/y4KYHca4Zm56/Wk4jEBJEnuflqUc5IELFnkLpzQbAjngck4unb
 3r3soztvzVnfhF5gj+3pgiSm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 03:09:07 -0800
IronPort-SDR: JfaRVRgz6ulzOXPdfXSOLiAVOotbJq+kVT+s/PhW83PqCUTjdAG9k1l8LE2fNnh2dtNcCgiYXo
 t2aIJcrmSOktOns9p3vKnT0NaYbsR5PqhqMGgKKVMnfhq2sxtTFdQqS7kEoSq7mFDbw8IiVM7Q
 fxmy2H8FTNYT2iQiWI6lZUhkC/D620cUJniVyrzSd0nBJlccAriOfH7qB/7pSV3VF2XsPzGL5r
 9HPihhkSa6qpstpQxX5JpJtQ7jeOIwd2lkGecCO4b0BdWPjOitZoDy58SS2YBRCLyFZNEr77Xx
 tWg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2021 03:26:53 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH for-next 0/2] Fix compilation and checker errors in zoned series
Date:   Sat, 30 Jan 2021 20:26:42 +0900
Message-Id: <cover.1612005682.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

The Kbuild Robot and Julia reported two errors in the zoned series which have
slipped thorugh.

Here are the fixes.

Johannes Thumshirn (2):
  btrfs: fix compilation error for !CONFIG_BLK_DEV_ZONED
  btrfs: fix double free in btrfs_get_dev_zone_info

 fs/btrfs/zoned.c | 4 +++-
 fs/btrfs/zoned.h | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.26.2

