Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE875EA6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGXETB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjGXETA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:19:00 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DDA12E
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690172338; x=1721708338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hTqRg0jltTk9odfMqhDrn5m6YEFqYdyAfCoYWj+cDbM=;
  b=fP00TbXRD28mKm/KGgnaZP4GkDlGwjJUOSL5b0bEYubRxKr/62DkG4uZ
   STimqrAFxcz1a+gQGbYy2opIOc9BBAUUTMARK/0TCgcS6LjCmbo9SJdiL
   ytXOKDwUE9UJFG1KH26OiH84UJ/wSD9nFb70XWm52nsmyAdV3cTfSRFEK
   vkcRMZFtsaXiQZQEpnwvKdOlNDBJQ25+zViS6PeBnlk6cpfQ9lM3qFb4r
   aSIUdGJs8vqNKHzaR2NVDYmolDNGmeh2zU6IS2ypBeWXpm0Epn2Z6zBH3
   Y+FnW1ZA3Br9SHW9IhfRDJTPbGcrefFIenPPl5ece04xLaTC6I5ZvWED0
   g==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684771200"; 
   d="scan'208";a="243524369"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2023 12:18:57 +0800
IronPort-SDR: ew+rueLyO0LNWyB67wtIt6wvD+Qs7tG36Tt/6WgZXNsFZZYof0c2xSn+haa99o+cwUUCFzkOWV
 TH0urVw4bMUQS7C7XrCj9rqLN7kXT3cqcfXn1CMdqq2r9knUO7kgk/DhK7ipycmur6YrKQ6orD
 pNAEUXfX7QxM6KnYzxNTtWjxG4RUrEcveFccbEZYzzXn52N50QF7y1d8bl/Bw4DpTlVCWT2xIW
 Zv4bXr+MM0uU0Fjq6gpxZef3G2/sRGDNQjSTPFjDWlhyBT5Ug2bT5pUOgkZRxj185VMEiY5ipn
 ALY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2023 20:27:03 -0700
IronPort-SDR: PaLYUz0WQmSAY07NruwXp8BoIB0gnOoYHs836wU6/Pw0+i1RW5KfD3Y16oPCMRqa6tKtbqDUsQ
 4yCWcBdWRBgjpJF07QYi/2UWslbG0BL67PKL4yvl/J1LZ7bjNZy4q/XkSG9GN8u7QrCnKbaqt6
 2nrGYOXjh7C184POVvdW2P0P3KDeSLzSwbfkNPQlh9OfsonLRqRlYXKHXzuN044DS2sksfPlP6
 sLLIq6H3ltQpiNHit6Q4dliwbfipeITEDgtUKnDkKxdGEwnhx5v6oPYEtUTJ6drjjYte63pJXR
 U6I=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2023 21:18:58 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/8] btrfs: zoned: write-time activation of metadata block group
Date:   Mon, 24 Jul 2023 13:18:29 +0900
Message-ID: <cover.1690171333.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the current implementation, block groups are activated at
reservation time to ensure that all reserved bytes can be written to
an active metadata block group. However, this approach has proven to
be less efficient, as it activates block groups more frequently than
necessary, putting pressure on the active zone resource and leading to
potential issues such as early ENOSPC or hung_task.

Another drawback of the current method is that it hampers metadata
over-commit, and necessitates additional flush operations and block
group allocations, resulting in decreased overall performance.

Actually, we don't need so many active metadata block groups because
there is only one sequential metadata write stream.

So, this series introduces a write-time activation of metadata and
system block group. This involves reserving at least one active block
group specifically for a metadata and system block group. When the
write goes into a new block group, it should have allocated all the
regions in the current active block group. So, we can wait for IOs to
fill the space, and then switch to a new block group.

Switching to the write-time activation solves the above issue and will
lead to better performance.

* Organization

Patches 1-3 are preparation patches involves meta_write_pointer check.

Patches 4 and 5 are the main part of this series, implementing the
write-time activation.

Patches 6-8 addresses code for reserve time activation: counting fresh
block group as zone_unusable, activating a block group on allocation,
and disabling metadata over-commit.

Naohiro Aota (8):
  btrfs: zoned: introduce block_group context for submit_eb_page()
  btrfs: zoned: defer advancing meta_write_pointer
  btrfs: zoned: update meta_write_pointer on zone finish
  btrfs: zoned: reserve zones for an active metadata/system block group
  btrfs: zoned: activate metadata block group on write time
  btrfs: zoned: no longer count fresh BG region as zone unusable
  btrfs: zoned: don't activate non-DATA BG on allocation
  btrfs: zoned: re-enable metadata over-commit for zoned mode

 fs/btrfs/block-group.c      |  13 ++-
 fs/btrfs/extent-tree.c      |   8 +-
 fs/btrfs/extent_io.c        |  28 +++---
 fs/btrfs/free-space-cache.c |   8 +-
 fs/btrfs/fs.h               |   3 +
 fs/btrfs/space-info.c       |  34 +------
 fs/btrfs/zoned.c            | 187 +++++++++++++++++++++++++++---------
 fs/btrfs/zoned.h            |   9 +-
 8 files changed, 181 insertions(+), 109 deletions(-)

-- 
2.41.0

