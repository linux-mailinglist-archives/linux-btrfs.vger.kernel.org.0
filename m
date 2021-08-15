Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDB43EC9E3
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Aug 2021 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhHOPVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Aug 2021 11:21:53 -0400
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:47820 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhHOPVr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Aug 2021 11:21:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08590187|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0746984-0.00142545-0.923876;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.L.l6UhU_1629040875;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.L.l6UhU_1629040875)
          by smtp.aliyun-inc.com(10.147.42.198);
          Sun, 15 Aug 2021 23:21:16 +0800
Date:   Sun, 15 Aug 2021 23:21:15 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/8] fstests: add checks for testing zoned btrfs
Message-ID: <YRkw67HXU2vtOLAz@desktop>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811151232.3713733-1-naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 12, 2021 at 12:12:24AM +0900, Naohiro Aota wrote:
> This series revisit my old series to test zoned btrfs [1].
> 
> [1] https://lore.kernel.org/fstests/PH0PR04MB7416870032582BC2A8FC5AD99B299@PH0PR04MB7416.namprd04.prod.outlook.com/T/
> 
> Several tests are failing on zoned btrfs, but actually they are invalid.
> There are two reasons of the failures. One is creating too small
> filesystem. Since zoned btrfs needs at lease 5 zones (= 1.25 GB if zone
> size = 256MB) to create a filesystem, tests creating e.g., 1 GB filesystem
> will fail.
> 
> The other reason is lacking of zone support of some dm targets and loop
> device. So, they need to skip the test if the testing device is zoned.
> 
> Patches 1 to 4 handle the too small file system failure.

I've applied patch 1-4 and 6.

Thanks,
Eryu

> 
> And, patches 5 to 8 add checks for tests requiring non-zoned devices.
> 
> Naohiro Aota (8):
>   common/rc: introduce minimal fs size check
>   common/rc: fix blocksize detection for btrfs
>   btrfs/057: use _scratch_mkfs_sized to set filesystem size
>   fstests: btrfs: add minimal file system size check
>   common: add zoned block device checks
>   shared/032: add check for zoned block device
>   fstests: btrfs: add checks for zoned block device
>   fstests: generic: add checks for zoned block device
> 
>  README            |  4 ++++
>  common/btrfs      | 18 ++++++++++++++++++
>  common/dmerror    |  3 +++
>  common/dmhugedisk |  3 +++
>  common/rc         | 24 +++++++++++++++++++++++-
>  tests/btrfs/003   | 13 +++++++++----
>  tests/btrfs/011   | 21 ++++++++++++---------
>  tests/btrfs/012   |  2 ++
>  tests/btrfs/023   |  2 ++
>  tests/btrfs/049   |  2 ++
>  tests/btrfs/057   |  2 +-
>  tests/btrfs/116   |  2 ++
>  tests/btrfs/124   |  4 ++++
>  tests/btrfs/125   |  2 ++
>  tests/btrfs/131   |  2 ++
>  tests/btrfs/136   |  2 ++
>  tests/btrfs/140   |  2 ++
>  tests/btrfs/141   |  1 +
>  tests/btrfs/142   |  1 +
>  tests/btrfs/143   |  1 +
>  tests/btrfs/148   |  2 ++
>  tests/btrfs/150   |  1 +
>  tests/btrfs/151   |  1 +
>  tests/btrfs/156   |  1 +
>  tests/btrfs/157   |  3 +++
>  tests/btrfs/158   |  3 +++
>  tests/btrfs/175   |  1 +
>  tests/btrfs/194   |  2 +-
>  tests/btrfs/195   |  8 ++++++++
>  tests/btrfs/197   |  1 +
>  tests/btrfs/198   |  1 +
>  tests/btrfs/215   |  1 +
>  tests/btrfs/236   | 33 ++++++++++++++++++++-------------
>  tests/generic/108 |  1 +
>  tests/generic/471 |  1 +
>  tests/generic/570 |  1 +
>  tests/shared/032  |  2 ++
>  37 files changed, 145 insertions(+), 29 deletions(-)
> 
> -- 
> 2.32.0
