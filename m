Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098C652B605
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 11:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiERJRZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbiERJRU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 05:17:20 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB37B1ADBC
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652865440; x=1684401440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kWfsqUeXQgA9OFYP4HjC42CYVf+zPjtWBeBaKJ4PK/Y=;
  b=RELoO/z21EDfzUYSRxA2l/aZ6FlGmdmgbxFIy13/24KHYmLkWtb0wLbF
   d8n8mEh6FaSzXK+tmSJYWAi8eKNzOWRwhIzuhB514Eyg7Ik+NGiJDdUBX
   APsEEE1Fl8s+R/h8312iECnmlDha7xa4FaHYf0B6g37XVIvWcJPV8foj5
   Q6zf8d6oxwKO1RCa5SBHBGT05MwTzfQAoHpwWW+Kzvnly99m3tbFXaJZG
   7kAR7RXwj+pzfh5xtp7udVKeh7549g3k/vNX8jFI3efA87LsoXrZNgRn5
   BYOw33ToZDGGfYOwpPLVlQdQFU1GLgphI4upRnplamjYgs2/d+RaTkbCl
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647273600"; 
   d="scan'208";a="201514740"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2022 17:17:19 +0800
IronPort-SDR: HMbqmBLQ0Az6r23UqLiKyJcHnJX55UEmUnVMFF4qjDNy8tMdy8OOcZq+2LGa6hKhZkl0cJzqfF
 qmFbowDr2BkHpTcVegcGEII902cmnALX0oJchG2YpSEigN9ecP1Gtex5xi7hy30/fM54n96fgp
 gsGhYl6NKH1T33Mvt1Lfjvj//c8Az8gaM2N/psm4Qewc4tdjnPGvzBUnq8BLJVLBRil1U5w2Lt
 7hX2VQ8hpXQI6EsEoW1w/U/rIyrz9penYKoLMd1BNagJdMBeA/qwsXQEmp3bGKaFaEId7Kaqvd
 UKCuQsakgt0WuqIeFpLDqDAh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 01:40:21 -0700
IronPort-SDR: iTGMZfAoPD9QaFF4p57qz1vqwlCdOpjcx/LmG8fqHS7y1Vysm9zaIhtq2eIA91MKwQ/A1NW+4E
 1tI4LxnC4Lj5cXmWvD9gb1uBPUoxBzvXaZ18Fsh3WNGbCGPOjU3bkYE2v4PgktNMH78i8l4CCR
 0te4dkMPJ+R5YggODaqF69utY1sf+8IF1I55y4cfnOT66T7uf9zQqZjmhBnxvrtZTEDZHU5H6O
 S9mBKELvzdYfTIv9LaHHJSKnndnhBhj09E4vnoU596ES2lJutQnA5ukcvoDf4pcsRB0hamyDXQ
 WtU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2022 02:17:18 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 0/6] btrfs-progs: raid-stripe-tree support for progs
Date:   Wed, 18 May 2022 02:17:10 -0700
Message-Id: <20220518091716.786452-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
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

This is the accompanying btrfs-progs support for raid-strip-tree, the kernel
part is submitted here:
https://lore.kernel.org/linux-btrfs/cover.1652711187.git.johannes.thumshirn@wdc.com/

For creating a two drive RAID1 volume with a raid-stripe-tree simply run:

mkfs.btrfs -R raid-stripe-tree -d raid1 -m raid1 /dev/disk1 /dev/disk2

Johannes Thumshirn (6):
  btrfs-progs: add raid-stripe-tree definitions
  btrfs-progs: read fs with stripe tree from disk
  btrfs-progs: add dump tree support for the raid stripe tree
  btrfs-progs: allow zoned RAID1
  btrfs-progs: add raid-stripe-tree to mkfs runtime features
  btrfs-progs: load zone info for all zoned devices

 cmds/inspect-dump-tree.c   |  5 ++++
 common/fsfeatures.c        |  8 ++++++
 common/fsfeatures.h        |  1 +
 kernel-shared/ctree.h      | 55 ++++++++++++++++++++++++++++++++++++++
 kernel-shared/disk-io.c    | 22 ++++++++++++++-
 kernel-shared/print-tree.c | 27 +++++++++++++++++++
 kernel-shared/zoned.c      | 20 ++++++++++----
 kernel-shared/zoned.h      |  4 +--
 mkfs/main.c                | 50 ++++++++++++++++++++++++++++++++--
 9 files changed, 182 insertions(+), 10 deletions(-)

-- 
2.35.3

