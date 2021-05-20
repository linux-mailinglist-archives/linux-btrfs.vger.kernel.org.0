Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F363389DAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhETGYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:24:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47818 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETGYW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621491783; x=1653027783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=37Z6JDiNyGcynyuJ/vqXi6iw1MykENFbGYfugjBIwFg=;
  b=E2/B/mW8YSEkD4HgjgiBu4z9jTWFL+GAxyoDIQcwXLPUwPm++bqATQdw
   GiHhm+6FHniB40jWGBwQjOToSt6SQL7jY8UIr8gdRZZIKFAkmhYSZVpfJ
   lzjitwzVBTAcYPzalyKawrr1j3yhVwZnj7nNqyC4K44hCzLBLTsLbnAgX
   zlP2hmGwq3UrIVYXV99HAdGkRngmlNLlTLm8ch5k1DDUex9EyiFPYa/jR
   xQSWcFmu7fZ1ZNCA4/ay5fpM5TLddJSynf9I7TxW+3C55kOpdysu+Bx/9
   FE9PUA1SPebGov5SO6bKA0BsSwFnTMoxuKMLBIKyOFGmo0cl7EOSXWAVR
   w==;
IronPort-SDR: Oh59vdB2A1qDye2bQ+d/KaBk2zGaINthe2OHn95Sgo/+wbMPAHOEA0yWKI7MR+DA5EauWmPJM2
 mfTM/NNrQi1jmph1EeyA9GhcaFflVJ9EHG2jDQl/vG34DKFud9J8QqGojtqdAssl5NorRw/Vrq
 Hf3xmhrYxmyvO7wthkk3WybdAdYzM3+UUgdop8DJBFSq0eEt8ayuiYTr4glEgrd3wOzVXogymX
 LA3pdYpdy4BzIhhC4SdeOL6Be8uWnZyYPb/vGtYVYSswOi55LCBMkdvgHxHqAr3nZtequz2gTB
 674=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="169351372"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:23:02 +0800
IronPort-SDR: 3ZYkcssBeIJ1pVfYUZ7vvrWVtntxv/T4MiEe1FN7OCT4gTFJs5gEzlyXrF4YqWD/Vwvd1s7s6r
 mR1OghWONATRp3PyPjiBm3kYC5X7JVdT22LT49u/pDjdgQWWUP/PnBmSKW0kppxYdEDI/IbVbF
 ddk7ZFKQKBMrSrmjOSZZauu64yi0m7pPvi/OKQBDPwwonUfllFLqJwGX8ieJ46Q6IC7gU+oqpt
 P0H5fEzIc3H0rNwJlvT3TbWqiLvakUOHI55C/tbCpNFxmB2eC2kT8zTU8FLWntZq56qmYBxY0e
 XcEMeJmQMQaylXGnmOQdP2WD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 23:01:24 -0700
IronPort-SDR: co3PAkGo79gyLLjO2Qy2y3B8PZr+IKND5/idvVppOQ2X1wfhsFTSek0i43T/n48qnBvZ+8OqcL
 BXbc9m4ZOcFWYrBbe5rbtWCQUa+P6g+Fg30e2Mb3ocl90yk6iSpWQsq6QuRVU1YvokpAXKsTuz
 e0mYLAcrupTog8+bBixFUT22GYkQszbSnzG2PmiITOOD3K0WDL0ISsQwFw7RHcRy6+KAWGH5D3
 82W6KxnRu+A5fRNvsuHWRfrWdHCtUeEmcbWOgFXW6dDn/044MR5Wmy5Hwua72RojDxIm2izIvJ
 9vY=
WDCIronportException: Internal
Received: from wdsc_char_051.sc.wdc.com (HELO xfs.sc.wdc.com) ([10.4.170.150])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2021 23:23:01 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     axboe@kernel.dk, mb@lightnvm.io, martin.petersen@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Date:   Wed, 19 May 2021 23:22:47 -0700
Message-Id: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,                                                                                 

The helper functions bio_add_XXX_page() returns the length which is
unsigned int but the return type of those functions is defined
as int instead of unsigned int.

This is an attempt to fix the return type of those functions
and few callers. There are many places where this fix is needed
in the callers, if this series makes it to the upstream I'll convert
those callers gradually.

Any feedback is welcome.

-ck

Chaitanya Kulkarni (8):
  block: fix return type of bio_add_hw_page()
  block: fix return type of bio_add_pc_page()
  block: fix return type of bio_add_zone_append_page
  block: fix return type of bio_add_page()
  lightnvm: fix variable type pblk-core
  pscsi: fix variable type pscsi_map_sg
  btrfs: fix variable type in btrfs_bio_add_page
  block: fix variable type for zero pages

 block/bio.c                        | 20 +++++++++++---------
 block/blk-lib.c                    |  2 +-
 block/blk.h                        |  7 ++++---
 drivers/lightnvm/pblk-core.c       |  3 ++-
 drivers/target/target_core_pscsi.c |  6 ++++--
 fs/btrfs/extent_io.c               |  2 +-
 include/linux/bio.h                | 11 ++++++-----
 7 files changed, 29 insertions(+), 22 deletions(-)

-- 
2.24.0

