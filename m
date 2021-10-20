Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6911434591
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 08:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTG7Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 02:59:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:57554 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhJTG7Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 02:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634713030; x=1666249030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gjpoFYhyF+DpAf08gYSzlhlgxP7eYT+KAiucWBMkHMA=;
  b=MwpLeseHACbV5+qfDOdUhtDqXlPY8OY+6NoTkFDb8atLUfbuYxTWNTB3
   lm4JZ0I1QOEtNCoj+tPQ0NueOXRx3J4u1PyHR/RbbSeOKQPRgsbTJi98V
   ixpx41y4GPqMSJhGqJgBRXfCxXK3S4tbI/gQ/PNfsVRsG+Pa3v4miB6bQ
   DMrM/tJMgtq98E1SFBeVHsPXrJi3u6tPmdKz9KH/G1oeGN3UpkjFHBQRq
   vW5AQmoHjkvqdRWBnV2VHBs6HbAanTzKJbK+1cEUDQc0cavHo7eHHUFWq
   jZ4K+2GEHrRKFRrbIxn/w82Ox+hT2xar7kiihuJ83luGO2n43ZlpG1HYA
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,166,1631548800"; 
   d="scan'208";a="183385640"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2021 14:57:09 +0800
IronPort-SDR: YXLzfvZ5hX9/w4L2RU+KpEnI/zQJvHTJo0X5oBPw+TqzYHVv7tx0VDgGCOsJs5ambWyDo7pOSJ
 +Se+6q0YzZlT6op2byMcSV8VnD2Fi2mRY8+u6q0TBQbMQqLgpn/lfwtmFZYQm38jLPClpCQpTC
 JrXRvf5oSJK3uWs+JY1SknSyWZRz8utTuYxSJ5ZYaTO8HJGNPKN9TVuQ64hA8YkiArGFuqYPv1
 r7zgSol8GggivW9yXrkJ3MPjY3X8f74V8PTa643qj1hA3thiLQIpSwZBHAGottNmhJcTvaBBkC
 oqg/aIjS7du3Vas9oQ1A5oX0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 23:32:48 -0700
IronPort-SDR: FRoC8dL2T4lEYzDzNU4F4iiRjZwMUK9/PR648R99r/j7tnTtFzJiEfn3akyuie4fFrrhJWLggz
 fRcaS83jYySDGuuf6dGdWnNRGNZCR9GHysthdIdorHvtQxzutVsoaZjDYBXP/4r5ETB6wwKP6Y
 rW0vkzmFMI0c/eWzZMGzT5CO9xLap1Qflb8dp/I5xUlFw3xIzehVSKTaiGDcW5LCYUrZy/Vq8x
 sgMilP3YWvs0JfNEiRoUYhyUUk8+dyzBSSXNu9g7B3R/9Aj9hMFX6l08lR6/i2PR/obojH3oN5
 PDM=
WDCIronportException: Internal
Received: from hy7bl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.195])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Oct 2021 23:57:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs-progs: use btrfs_pwrite in place of pwrite
Date:   Wed, 20 Oct 2021 15:57:01 +0900
Message-Id: <20211020065701.375186-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to use btrfs_pwrite instead of pwrite to ensure the writing to
O_DIRECT file works.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 5c8d6ac13a3b..ca5393d56f3f 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -181,8 +181,8 @@ static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_header_nritems(buf, nritems);
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
-	ret = pwrite(fd, buf->data, cfg->nodesize,
-		     cfg->blocks[MKFS_FREE_SPACE_TREE]);
+	ret = btrfs_pwrite(fd, buf->data, cfg->nodesize,
+			   cfg->blocks[MKFS_FREE_SPACE_TREE], cfg->zone_size);
 	if (ret != cfg->nodesize)
 		return ret < 0 ? -errno : -EIO;
 	return 0;
-- 
2.33.1

