Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462447823C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 08:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjHUGhN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 02:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjHUGhM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 02:37:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27674A9;
        Sun, 20 Aug 2023 23:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692599829; x=1724135829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GYzwbOjfiF39TZRz9eZIrZNRhFVh+tsx/joWx5dA5oY=;
  b=Jl5bb4nga9D8NNEPFJ3KrPiQ7g8Doizw9a9IQ9rqtgirFv46Si/c3wv1
   bxLjAKbvMatB/Xg8Vjz/xrxNDFdGEM1+c6TcSj9Eh3U/L5vKOgWFehdQa
   5tOUPxa0nX6MUnPyoChVDElBIICkQfPyIa7B4Bd75l3YMOkCZC7KhFVV3
   cj+FZ6Vaje0lC2OketO6YwFsVVxP06jsFmFx/gE19LHWFo0uja+5nnqrv
   TVT0miLHhezkDD2PBPk1SBN3oqyR6AJg8n/W0HCWCbtVSkhszw+fTW04Q
   6+isnsd5XGi6hk3UH4S+Tz/BVMCn2oILpO2vqHDTHupoMcCAiTQpiY2HI
   A==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="241991949"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 14:37:09 +0800
IronPort-SDR: jK5Ob05L1l73OZgucDvviFVLi4tQ2PaNj0fUr7PJV1ddNnYe/8xWCU8fTzfiCuoV1XZBoLyU++
 sCtmg/+Z5QVOigmPHsUi2H1R5NJLXo8LRqzXo47uhd2lflaMPZv8Ec0MTRjnsxvPoZuu4A+p6B
 2vCGRLOeFvYh75F4bgX/0ccJ9u3EqQwro54b5+4r9tlXOSL99PvGIEZcqp211V5DDBXvHAK71o
 d9b49iksQnQwDzakfvu49D69CIFQcYhQrNKKhffGr2Hdhidde2e2EOB8G0w2JhF0daBN5q2iZK
 dWs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2023 22:44:41 -0700
IronPort-SDR: 3I8MO5SdFljMYY1HPFbC3YHfZhN9TG1TE3VdbU14Igzs/yk5L2tsqi1fhXJK5RcTIm2YyjaVKF
 1wF3/XiUZVh28Zerc01/OeW4I8LSyIYTTxM6vsyxhtYyJVlMvvyjIiMixW02aPJ+EDkXoGntMp
 6WBVhI5L/6cSOl1V+ynsc/gruuS7JghbJ/z2HWVpd9BVIvABYurMHUCn/JddEvuahiQzDBeZkP
 y9RUON6tHvU2gAALTFMch8nHbx4/nZFIz1uUR4eXtTNCI4CAB2SQKTxfdUVn/z6xEFI4RUV0XB
 jts=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.96])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Aug 2023 23:37:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/3] use shuf to choose a random file
Date:   Mon, 21 Aug 2023 15:37:01 +0900
Message-ID: <cover.1692599767.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, we use "ls ... | sort -R | head -n1" (or tail) to choose a
random file in a directory.It sorts the files with "ls", sort it randomly
and pick the first line, which wastes the "ls" sort.

Also, using "sort -R | head -n1" is inefficient. Furthermore, even without
"head" or "tail", "shuf" is faster than "sort -R".

This series introduces a new helper _random_file() to choose a file in a
directory randomly. Also, replace "sort -R" with _random_file() or "shuf".

Naohiro Aota (3):
  common/rc: introduce _random_file() helper
  fstests/btrfs: use _random_file() helper
  btrfs/004: use shuf to shuffle the file lines

 common/rc       |  7 +++++++
 tests/btrfs/004 |  2 +-
 tests/btrfs/179 |  4 ++--
 tests/btrfs/192 | 14 ++++----------
 4 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.41.0

