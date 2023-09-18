Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9A7A4CD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 17:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjIRPll (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 11:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIRPlk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 11:41:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49964269D;
        Mon, 18 Sep 2023 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695051608; x=1726587608;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Gb3QQBzMBiObq3pWF0MZ3u5WRq0kgtMrO/CJeEitfbc=;
  b=ai0Ah2uj8C1LqjhZHxqMb4mim359Ngwbd/T69/QxJcloq8br+M3w5kZH
   rg8uuXpZI2K7v4LQEvcOyhyyU6I/pRB/3qEBYiuD7eGnCClvAhOQVM+Cl
   QQGLkWQe2hmBtWtxhbGX8rVCCkOy4KnxY797pgeAF73ZfvTVoaPUePUpB
   vuZMYQMsb1DStTPeO+UtUjMQE9G+NzkCTnAnaKRdwifBlExIPiWRbfBfz
   JsndGFY5RqGxfM+CXtLCq3X+ygAc9cNGi/1zBRCZO9su6wE0P9hCkCIsJ
   nTF7CKhWBFyRaZIJbDwEJEmGGcss0o43OjumI+q1qL7DqgpKb8tWzMd04
   g==;
X-CSE-ConnectionGUID: KobyPEvQTiixAta2TB6YkQ==
X-CSE-MsgGUID: eIe+alLqSz28ltt9e7WfOw==
X-IronPort-AV: E=Sophos;i="6.02,156,1688400000"; 
   d="scan'208";a="242446869"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2023 22:14:37 +0800
IronPort-SDR: EiCmSBrvT2nlBJaZ5YvL1/4X9Byg52z1XjHJ01coujlfRFTqtXY8onli81JkRVfj7qs5ND2WDr
 Yad0R013jahiuXkzH1lch2CEtaw5JjWox+KdHZU96PObvqJ6qgI60qRTWHnA+D1DVY5qTQHwgt
 2l8S6UKnvGce0hKwepl8SA8e3KtuRItu/0hnRr2PNoce/ph7WttYP6UYj2cq6LsMIC2SRZc+pH
 qCCBh5bLS8ZwsU6BsK61+SfBBhY6ShzeSb9g9r9WUO8UINCVzXCvx1Lexo9HQCLocNzG4upo0E
 +xw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 06:21:34 -0700
IronPort-SDR: qNZK8+cjeT1FJmcv94VLBQ0oo+RD1uFBjcspI4VqGE6hA/M9yzsejKS9NOE+Ieg6306kFkiCSe
 ZKv5zKstcLvLR+1e0jPH42sWMGwMVTHVAaoI0934RS7/CEPHdUdzY8VOCgz7BIOr4du4ANHZuj
 +kq2KnP/PVqEN4sOEyMOop7XSjDH5qeye6ts/1IOe0lStXSs0v0GTs/71fyYqJVA2iiBboe5zK
 GeGfrHOLRHjrlcuGll7o/5trQshNul9wmMQ7II4lIGFY8zHOE9zSKP2A0UUIu1SlNCZZIF89Wh
 YHA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Sep 2023 07:14:36 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/4] btrfs: RAID stripe tree updates
Date:   Mon, 18 Sep 2023 07:14:29 -0700
Message-Id: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEVbCGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0NT3aLiEt3SgpTEktRiXYtkU1NzC5PkRJPUNCWgjoKi1LTMCrBp0bG
 1tQDriSSsXQAAAA==
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695046476; l=889;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=Gb3QQBzMBiObq3pWF0MZ3u5WRq0kgtMrO/CJeEitfbc=;
 b=3HeUMrs2SzL/OfJpICl9vyoCQ7rkR45o7HwrXp9EqLg/9yJfeQPBmDnML+bAfEM02TSXOBCt9
 Yk3OMP48IqvADu99/Gdbs3rTCX9wccokXBn89vp8r2TtVs//iiPv7HZ
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is a first batch of updates for the RAID stripe tree patchset in
for-next which address some of the review comments.

---
Johannes Thumshirn (4):
      btrfs: fix 64bit division in btrfs_insert_striped_mirrored_raid_extents
      btrfs: break loop in case set_io_stripe fails
      btrfs: rename ordered_enmtry in btrfs_io_context
      btrfs: add tree-checker for RAID-stripe-tree

 fs/btrfs/bio.c              |  3 ++-
 fs/btrfs/raid-stripe-tree.c | 26 +++++++++++++-------------
 fs/btrfs/tree-checker.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c          |  8 +++++++-
 fs/btrfs/volumes.h          |  2 +-
 5 files changed, 65 insertions(+), 16 deletions(-)
---
base-commit: 7368638e1a1f30dbf34c141dc2355a96ca2a2932
change-id: 20230915-rst-updates-8c55784ca4ef

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>

