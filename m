Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7359329E4C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbgJ2HrC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:47:02 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:54385 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733219AbgJ2HqJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.8150549|0.07402486;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.0379604-0.00372243-0.958317;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IptkHuJ_1603949757;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.IptkHuJ_1603949757)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 29 Oct 2020 13:35:57 +0800
From:   wangyugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kreijack@libero.it, wangyugui <wangyugui@e16-tech.com>
Subject: [PATCH 0/4] btrfs: basic tier support
Date:   Thu, 29 Oct 2020 13:35:52 +0800
Message-Id: <20201029053556.10619-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Storage tier is a big feature, this is just a basic support.

1) Add tier score to device
We use a single score value to define the tier level of a device.
Different score means different tier, and bigger score is faster.
    DAX device(dax=1)
    SSD device(rotational=0)
    HDD device(rotational=1)
TODO/FIXME: FIXME: detect bus(DIMM, NVMe, SCSI, SATA, Virtio, ...)
TODO/FIXME: user-assigned property(refactoring the coming 'read_preferred' property?) to
            set to the max score for some not-well-supported case.

In most case, only 1 or 2 tiers are used at the same time, so we group them into
top tier and other tier(s).


2) tiering data and metadata
This based the patch 'btrfs: add ssd_metadata mode' from Goffredo Baroncelli <kreijack@libero.it>

We define a mount option to tiering data/metadata to slower/faster device(s)
When there is only 1 tier, tiering is auto disabled.

mount option: tier[={off|auto|data_tier_X/metadata_tier_Y}]
default is 'tier[=auto]'. 'tier' is same as 'tier=auto', 'tier=OF/TF'
the policies to use the device(s):
    Top-tier-Only(TO)       : metadata only use top-tier device.
    Top-tier-Firstly(TF)    : metadata use top-tier device firstly.
    Other-tier-First(OF)    : data use other-tier device firstly.
    Other-tier-Only(OO)     : data only use other-tier device.
data_tier_X is the policy for data, support OF, OO.
metadata_tier_Y is the policy for metadata and system, support TF.


3) tier-aware mirror path select
This feature help the read performance, so it is enabled even if tier=off.


4) tier-aware free space cacl
Detect some case of free space 0 because of tier policy of data.
Full support is yet TODO/FIXME.


5) TODO/FIXME: per-subvol tiering policy and then per-subvol profile(RAID)
	per-subvol tiering policy and then per-subvol data profile(RAID) is needed for the full tier support.
		data policy support TO, TF too, in addition to OF, OO.
	But now as a workaround, we can keep them as 2 separated btrfs file system with disk partition and
	'btrfs filesystem resize'.


wangyugui (4):
  btrfs: add tier score to device
  btrfs: tiering data and metadata
  btrfs: tier-aware mirror path select
  btrfs: tier-aware free space cacl

 fs/btrfs/ctree.h   |  17 +++++++
 fs/btrfs/super.c   |  90 ++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c | 119 +++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h |   5 ++
 4 files changed, 228 insertions(+), 3 deletions(-)

-- 
2.29.1

