Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9951C79AEA5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355923AbjIKWCZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237932AbjIKNXQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF7212A
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694438591; x=1725974591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WhnCypVXm3hTTeWXwFJqBeX0etaYVaPVcZ8O4gAV/g8=;
  b=Var3c8E3KhgjPZmyE61sjH0OH0dOWfO2yU1QAendHG4ht8W7DoK+6oJL
   6LP3bUoVDmCmsq1ChUQcwn/ZwIQ3gV/M3E8N3EWBattq51jxXCE0FvznK
   X1hj3Ck0kjv2w1wudDlvbkDUNOiftKTlpQ2USs9rW0yu1V4U6ndztbW/f
   /1EgBNoYuMcPpQ0Og8N3jSSGcyx5O+3T/dzxDI0cXpYym0Xkj2G5wo8Gd
   k0GiPApQEVnQOxBvZbIvc9e/JUSKiw+PxEGKyM6MDFv0k06x/W2yO0Zdy
   YaKN4LZ51eV4dALtcMPrKA9ugilHaSgFcq90pWzONKlVesn8gfgk4Htsb
   g==;
X-CSE-ConnectionGUID: MdZH1fOqT16dnavaxqPfQA==
X-CSE-MsgGUID: YT5FKjTMRb+p29Dq8Zqs+Q==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="248143278"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 21:23:11 +0800
IronPort-SDR: Ikvc7KT2TBBoped5JHMyPce6BzxhJvTj8t/l8w2ca59dc9iVBNRI5Cc0pI9KsdOhc8hxpYCcYY
 jT0oN0JyV9/1M1C9j81nbhulI8MIe2ozGMkXaObBykKGoVnLQKgXiuLTugH/HusTPa9nwQtO9t
 PIR02Pa7c3nYbwp/B4HOy+mXkTuR69pcBS/deeGXjeV94dnEnchUUkHn5oZOINZslgTggkITZE
 n2dEjE1Sc38qruG1/D3TIpmUSixwJACO5A5anACcWyhzM1pmmHjj+XNfxGUm63Vqgrg+jgk6aa
 qAI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:30:16 -0700
IronPort-SDR: ff03gu+HDDlkO0Qo9J787YUT2yirfW26ehbg5+M02GrQF5eZ6eI7DD49kopcHOs7MIEpW1HknD
 Pgdc64JzfipAXn+eYE3EQaYJ0+5outcbEmUkbV8VG1//8Y8zj06oEmh2X1ndhsPZY6KkfQtuZp
 QTPTWOiAcXnXfaS6MBDKVomkxb5AJgqmXyPkV41Z1rZoBouo7N5BILOE+fxu8K7NU6VLWxuACH
 o5PVfgGalMp/mDEqPSlL7VI/Oah5DGLTmW2UuTAdig5WepKHDELHFI3fdAjcrd5hOZYAbDYiEW
 VM8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2023 06:23:10 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs-progs: add support for RAID stripe tree
Date:   Mon, 11 Sep 2023 06:22:56 -0700
Message-ID: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694438542; l=1502; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=WhnCypVXm3hTTeWXwFJqBeX0etaYVaPVcZ8O4gAV/g8=; b=77GwXxidM0EZZ/BcuSzm2VvWR7Gye8PTTtG1hHdqpMIj8GtNIYq1WnsoYtC16Fp7s6A/ML3oI qwWeWqzQQPdA3OVCIFZceOg+7RA0RjgXo8BgHCP5v8RktZ9LnQl9+mk
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series adds support for the RAID stripe tree to btrfs-progs.

RST is hidden behind the --enable-experimental config option.

This series survived 'make test' with and without experimental enabled.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Johannes Thumshirn (6):
      btrfs-progs: add raid-stripe-tree definitions
      btrfs-progs: read fs with stripe tree from disk
      btrfs-progs: add dump tree support for the raid stripe tree
      btrfs-progs: allow zoned RAID
      btrfs-progs: load zone info for all zoned devices
      btrfs-progs: read stripe tree when mapping blocks

 cmds/inspect-dump-tree.c        |   5 ++
 common/fsfeatures.c             |   8 +++
 kernel-shared/accessors.h       |  37 +++++++++++++
 kernel-shared/ctree.h           |   7 ++-
 kernel-shared/disk-io.c         |  28 +++++++++-
 kernel-shared/print-tree.c      |  53 ++++++++++++++++++
 kernel-shared/uapi/btrfs.h      |   1 +
 kernel-shared/uapi/btrfs_tree.h |  28 ++++++++++
 kernel-shared/volumes.c         | 116 ++++++++++++++++++++++++++++++++++++++--
 kernel-shared/zoned.c           |  34 ++++++++++--
 kernel-shared/zoned.h           |   4 +-
 mkfs/main.c                     |  83 ++++++++++++++++++++++++++--
 12 files changed, 390 insertions(+), 14 deletions(-)
---
base-commit: aa49b7cfbbe55f9f7fd7f240bdaf960f722f0148
change-id: 20230613-raid-stripe-tree-6b64ad651c0a

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>

