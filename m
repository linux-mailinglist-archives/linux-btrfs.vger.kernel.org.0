Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AAF1E3B58
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 10:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbgE0IMd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 04:12:33 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15288 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387755AbgE0IMc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 04:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590567151; x=1622103151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y2OUA/ToELx4KjI5RHDsqj6pykIMQj2HCgJTgCxU4Ao=;
  b=OBsGKvH7yGdx4Plvsbe/fwSAUkYoH0BnTwPGw624KL/aEC/4osaoblQF
   nH9Uo4zhzN5PxQCcAkjlTyQFmB16BaJ3UTTWeoubgS4CbUKZ4kqsHFPv3
   taE/++hrdSsgjfwXrHF2tRtbSovuu9ZftveeE47NltGnDlEy1yq6SaQUv
   0afIDA48D/oZxfc5/UJeb/cn2lTMRPIqGs9tSZB1OgkAhmhUSDROfgNYl
   F69pQHxBYRtAdAJTixJ6oTzt6mu0nmvVzvp6VTkQ2DLue/aYOaPVfr7J0
   GUNnOnwcy2PLP79FpuD/MWcgJUwAScH+AYlO7e998fYERYhV+XRGO6ZWu
   A==;
IronPort-SDR: ZWZKXkmDMRzap8n39OwIcktd29SdyTOEMFP1/Ye3zaCc33vt4OIWHTIvF2CMWl95TF2ho1oX4C
 1Oil4r2Z6Xlmkj7dK70TuLKM0N3gPVkBT1mFMaAu+nghc2d7a7CVeAnGNVc5+QiMN8IoeXPOVx
 1LoX4WO8X0NzPBRSGa2yVMzdqnlYGWUQIBhqWfF3cWk7G2r6INtidcYZxDCMyj+SSbCZVmHAN6
 a022u1UZ2QP5F4vbsZ8h9igdZKLXqxbwtEQvmc9BODBklFHd5fekLPv+8cYbxG8bsylibTCt7C
 +4M=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; 
   d="scan'208";a="247648697"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 16:12:31 +0800
IronPort-SDR: xZvkXhzzYo020wnKI1unLBBNscmPVkrl4/5mmguLcHiCn9lPdd/xzX5M4OI7+74ySU0K7kn+X8
 1DmpOSfLaZkkjNKXl+cOp3ZipuO6yYR7I=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 01:02:21 -0700
IronPort-SDR: OOLY2Za5HlepqqUM95osZ+ICOYtxnZl1zmNN+wntvgAzMwjvS0NnEM2dKPJf6lQgYh9FlMvVsS
 XOxdS3P4mCFw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 May 2020 01:12:30 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/3] 3 small cleanups for find_first_block_group
Date:   Wed, 27 May 2020 17:12:24 +0900
Message-Id: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While trying to learn the Block Group code I've found some cleanup
possibilities for find_first_block_group().

Here's a proposal to make $ffbg a bit more easier to read by untangling the
gotos and if statements.

The patch set is based on misc-next from May 26 morning with 
HEAD 3f4a266717ed ("btrfs: split btrfs_direct_IO to read and write part")
and xfstests showed no regressions to the base misc-next in my test setup.

Changes to v1:
- Pass btrfs_path instead of leaf & slot to read_bg_from_eb (Nikolay)
- Don't comment about the size change (Nikolay)
- Add Nikolay's Reviewed-by's

Johannes Thumshirn (3):
  btrfs: remove pointless out label in find_first_block_group
  btrfs: get mapping tree directly from fsinfo in find_first_block_group
  btrfs: factor out reading of bg from find_frist_block_group

 fs/btrfs/block-group.c | 108 ++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

-- 
2.24.1

