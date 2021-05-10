Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D6E378F91
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 15:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhEJNtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 09:49:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24578 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbhEJNk5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 09:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620653994; x=1652189994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XSRhxM+G5WZK1ccouFva6ftK9cB1n/tpIByythmG9Zc=;
  b=E7d6CZr5I/CSeXf2HRQGHkIhJeaTPptwCoS0nyvdxlz6wclb467MkQ/u
   wdcKqSzXKTfrepW7m3sTBIibGOU+4un4SiiG+tXqP3FOaewYKpQQ2A98s
   aMWJGikuFTyVVYXDOGScjIFqp9uLQ7A4qFOTS0l89DqLCRBl0wllRI3s/
   1s01I2Z7gOR4afaz/Dh46gJMgQckkbt8+TcnGE132JIPo9BiV+Q4GgkNr
   iruLWOGhA+5cUpvJXNvTY/Ew69VTmqMla862TnhQJbawohzykCXddX8Rk
   ZvQcinUM9+LylCQeM1crII/2Z5Ldvy4MZzbHgZYInzZpCn+kkHmijy4Be
   A==;
IronPort-SDR: wUUA6Rno9LJqLFcOGSlrQ5QdgFX4W0vqhutDpWG2jlFb9fBOKwe4Dtsoyen6ISKXggOehtlvv1
 Bii8fdlO2y5UraKe5ooFkeSdLsdnrvnodAxrxOliWOQBI1qc3LEdf8blwRsQgWY4qagCZOA1pz
 tYQCRozKMvSNyCoxspM/lnbPdiRB/N8sjXtBIO5ViwqTZiv2a7gPVyWocp/fRSoyMXYOpWcZmZ
 Sl7jZ6jbFhcuIyThIX4RtthK6BQAWM8ebXSUXCBBbiTppZHB9m9khM6Ypxf7SM/kReP68majeD
 jD0=
X-IronPort-AV: E=Sophos;i="5.82,287,1613404800"; 
   d="scan'208";a="271624363"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2021 21:39:51 +0800
IronPort-SDR: m4haG4ARaLdrZDDT1yn01QAxHiqD8PJC2VLu53JPONg41Tz9fOTfP2fUmri0+O7qe7sCbUCByQ
 cF+ctRVS01juqNpk6jySSBsob/7PO0Mff2GR1gw0xXxN3LRZIF0/99PihIqf85nJi13yP2R7zg
 UdCwLMcgTXKNT+ZAU8e1cLtWU5bAEyp+EYbqEip4RzdJXxuIbYMpU3ai5QVWrjFCJr/7CVXHBm
 0wey+D5BClGObueooCiZS9B5RLApEOawnTe6dkKHJk1HWMJeO8waoOzqXMEdbKeu+xHDzLji+3
 ic1YXIT4GZtf5OX3/xWzAcT5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 06:18:25 -0700
IronPort-SDR: eT8smzeaUZ7g/sL0vBe2FL/bR8FwFSAF5mjHO21ykF+P92UDW7MZTX5anQhf4xRuXbbLC1twyR
 B6em7KOyl9oTFX+mqH45k9knFVuruHnJVsoFkDtkR0jLYoIysi/5uelQHImg1GjXOur6Nqtf/X
 x0O2VfsVTsJYlUw3z6Y9g8JIPFvOyjxEP3TGvfM0eQSgn5v1Ynllaz0fqAsqq44AA66thDMPg8
 OvV+7hKzmP9ZZWfWv/YNBkLw/3b8ez4d2EDqvIx2F178CwZ1wT4L/FpgT+1baOZ7kCdCmMFUeS
 OBs=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 May 2021 06:39:50 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: return 0 for dev_extent_hole_check_zoned hole_start in case of error
Date:   Mon, 10 May 2021 22:39:38 +0900
Message-Id: <145b97e8743f76c436971d3066d94d5073e7ffa0.1620653896.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 7000babddac6 ("btrfs: assign proper values to a bool variable in
dev_extent_hole_check_zoned") assigned false to the hole_start parameter
of dev_extent_hole_check_zoned().

The hole_start parameter is not boolean and returns the start location of
the found hole.

Fixes: 7000babddac6 ("btrfs: assign proper values to a bool variable in dev_extent_hole_check_zoned")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0ba7b3c5933b..e020447b25a2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1459,7 +1459,7 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 		/* Given hole range was invalid (outside of device) */
 		if (ret == -ERANGE) {
 			*hole_start += *hole_size;
-			*hole_size = false;
+			*hole_size = 0;
 			return true;
 		}
 
-- 
2.31.1

