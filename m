Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC967C702E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjJLOTm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 10:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjJLOTl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 10:19:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9C391
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697120379; x=1728656379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SiTLYGODgZJjd7cC1u5TZCl3ucS5QPlYyzC5g+mCNs8=;
  b=n+YqRANX8lrzdoDCqR6GxxC2I5DVxehZkQQEVVUHil2c24YjrPmowyrB
   6pnDDt131xRXpgDJ+JZe2rVQxA6igMLYstHgfNZIU0yegg3t7GjUBPs8B
   BUuBF/D1slJSZNvBNoeN5knzdCbE67MSp0BVqmPtJddNCI0B2zjLeKMhu
   c6whNh8Bcn3hDPyRyv+RrYHvecyDUPVgNijOe4/uOOfW82bXva8LND7r4
   llzh+i0wDvz8IIeX0FSY8vQ7zvfWxlkaXkeKwjCFMpKziENH12gtXY5kn
   EVdDz9FpGj/rIlBuhqTBwpRhlLBwPVw+ofshnyj5udRB9rGwYREAYezam
   w==;
X-CSE-ConnectionGUID: OWt+l8evRcmVQ2JfDYa+pg==
X-CSE-MsgGUID: RnqlcpnHSOaS4yj6Tv5rVg==
X-IronPort-AV: E=Sophos;i="6.03,219,1694707200"; 
   d="scan'208";a="351743176"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2023 22:19:39 +0800
IronPort-SDR: Am7EgW791mf0TAxzN4eXQV0Jiud9cD2rPmUJ4sgAiN/7JE9AWYaDJ8lV/JjfxdLQLzHYoamiJf
 BHo79Muzx/ey4rVgF4MeV+z0jKocig8LeSUsrzOwbGX4EPfrhTTxVQBzc3hFOJlfDGaJ0iCGYl
 G8FRiPp7Vf9s+B5gnk2sCxmM6z/QPG+0mJasploAvr1CIB7EtUJb269eDUHU+bsmHfyScAGa11
 Lox6n/JJD+89U8sQCLCugU/gZ996OHg+VZoIuIAwxn5GDgXrh26Ish1uxRcqdSs9h07OT9uqHd
 MUc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2023 06:31:47 -0700
IronPort-SDR: ZuLFASOGZcwA113QpaTeyu+ZOUWbdKZZywgfjA2qqFo+B/JyHEB8DQHUS6atMWxO/Lvlr8EX8A
 3xvlLapOthq8YnrckDjoFwMZLbzWc2O/1RwN3FYKRSNXnjyHmTUlGiC68xVoIS3jP2Ik6a1mzv
 0TJVCjTCZaDSaZ+bflY/EAL954Q8fD4S1T9nDg0uxKAMY13TGXJTjqggsnN6+pGH9oIgD0YWOI
 tkaBJvAHrWS77QCZjzflXLXc81iowf1EJjB/PxgnRsiK04tmVWeM0VJ6rLJ0g2Hh+GrXvFPdGG
 qLw=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.25])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Oct 2023 07:19:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] btrfs-progs: zoned: check existence of SB zone, not LBA
Date:   Thu, 12 Oct 2023 23:19:28 +0900
Message-ID: <cover.1697104952.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running btrfs check can fail on a certain zoned decice setup (e.g,
zone size = 128MB, device size = 16GB):

(from generic/330)
yes|/usr/local/bin/btrfs check --repair --force /dev/nullb1
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
ERROR: zoned: failed to read zone info of 4096 and 4097: Invalid argument
ERROR: failed to write super block for devid 1: write error: Input/output error
failed to write new super block err -5
failed to repair damaged filesystem, aborting

This happens because write_dev_supers() is comparing the original
superblock location vs the device size to check if it can write out a
superblock copy or not.

For the above example, since the first copy location (64MB) < device size
(16GB), it tries to write out the copy. But, the copy must be written into
zone 4096 (512G / zone size (128M) = 4096), which is out of the device.

To address the issue, this series introduces check_sb_location() to check
if a SB copy can be written out.

The patch 1 is a preparation to factor out logic of converting the original
superblock location to SB log writing superblock zone. And, the second one
implements check_sb_location() to write_dev_supers().

Naohiro Aota (2):
  btrfs-progs: zoned: introduce sb_bytenr_to_sb_zone()
  btrfs-progs: zoned: check SB zone existence properly

 kernel-shared/disk-io.c |  9 ++++++++-
 kernel-shared/zoned.c   | 36 ++++++++++++++++++++++++------------
 kernel-shared/zoned.h   |  6 ++++++
 3 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.42.0

