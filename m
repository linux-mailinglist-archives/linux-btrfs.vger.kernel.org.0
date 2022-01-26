Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9D049CB38
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 14:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiAZNq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 08:46:28 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46304 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiAZNq1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 08:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643204787; x=1674740787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mKyFQXOkv2I2VI9AZrULT3JTWcEaLHOxY9FmPkFNglM=;
  b=EgYf1QflpTsOQngHmY2d5BLT8o8bASqMCSisBdfJRpG3EIxmYErF/vqU
   WV7itY6L/cYL8+fJXasZyJmVN/rjyNHLTjhGI4dDvY3Ejs6YSKiz6GWnv
   kedyxkzJ88xFwpbFHeAKR+6XHiUs0vOaIZQ4liElgBDBzDQCErlOzOZvg
   5Na6Qxlqgd0/eDZ8Gn1MLu8uX2rsMVHRUcRmiYj13CC7BRchk5qUd5i+P
   cgXLbdnGIxhubRWp2/3WyyKza9/HCt96H6NcO/tIUCE7ebGZUF9vakpVw
   GsifUK3kiaBN4AT7ya1juGOvdym4Oh2VnRlwtNrE4wWB8j9vL8fYs1v25
   w==;
X-IronPort-AV: E=Sophos;i="5.88,318,1635177600"; 
   d="scan'208";a="190373104"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 21:46:27 +0800
IronPort-SDR: EJNLIVWlxKnhVL1kH4jsnrkoXsWppojKuvF2bzBTMGvqp8qoBVWn5fwoOCOnEJ62BZLYT/bM3q
 kcGsZ343KYT+qjUzTCvQOoc0NMZG0aWx/JreiqSWIRg35SneUxjhdwFK9uwsrZaKOvW1tXgMCC
 L0AfWAVAByVCQbqg1fY945lcytioUfGiD8WdIb/oMPnDIDfyIHoEoT5JnNkZ2GSL7QXzpDntDO
 nU7usrUyk9gQGo7zYZiQXR9HSteFwPc5afY6d4Fh1N18rGKnuNT6MbwICpkH0WpnHPCsQL0wHs
 bonei8Chsvf1jl0mw8rKVxzQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:19:46 -0800
IronPort-SDR: NwK83LFlqW3odcSMsAsp/rIQJeXUx+Au5bpIw9R8kSM0IUlbupq9M+0Kr/+OscPNPhRkVJ37Bq
 UrJQ7qrQ9/XTCQoHkMtvVKVCfXoRvuK19YIc11h97lKv/zAdfMEtRl58nwRoDMJX/gsJFxFo1X
 jskkEqKyaeqvIZBsXPMun44Drf5L7adZ0fm5FDjlgotOikhDSkikDWh7uFKfR75qRk67ikz2YV
 Ba+HgUK5DR4dBCFhZ3MPBpjHPC62xYLxg47xcILXlhUuKTH3cRzR6BXLo8SDTs2Kr1Wf9g4tCS
 7nI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 05:46:26 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: implement metadata DUP for zoned mode
Date:   Wed, 26 Jan 2022 05:46:19 -0800
Message-Id: <cover.1643204608.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs' default block-group profile for metadata on rotating devices has been
DUP for a long time. Recently the default also changed for non-rotating
devices.

Technically, there is no reason why btrfs on zoned devices can't use DUP for
metadata as well. All I/O to metadata block-groups is serialized via the
zoned_meta_io_lock and written with regular REQ_OP_WRITE operations. Therefore
reordering due to REQ_OP_ZONE_APPEND cannot happen on metadata (as opposed to
data).

The first three patches lay the groundwork by making sure zoned btrfs can work
with more than one stripe and the last patch then implements DUP on metadata
block groups in zoned btrfs.

Changes to v1:
* if only one zone is active, activate the other one as well

Johannes Thumshirn (4):
  btrfs: zoned: make zone activation multi stripe capable
  btrfs: zoned: make zone finishing multi stripe capable
  btrfs: zoned: prepare for allowing DUP on zoned
  btrfs: zoned: allow DUP on meta-data block groups

 fs/btrfs/zoned.c | 164 +++++++++++++++++++++++++++++++----------------
 1 file changed, 107 insertions(+), 57 deletions(-)

-- 
2.31.1

