Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2052F418E1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 06:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhI0ERs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 00:17:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:56793 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhI0ERr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 00:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632716170; x=1664252170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rr/ZFxW8UdfuFR2wHDmbJsGZPy4mqyRLH6KaZZ0pgWg=;
  b=AycaKvBnvn7Kb/W7ru16sXXhuvVjmXkNX/RuexHWMbwPzO7erN1T5nOH
   NQ68oT577oV4+8g2SyIopJ8Wqmt+ixc99ZAAxVRQJXP7dbaz++36okA9/
   GQ8tYPHciTIW2Rysly7+ZI3SqmcFBEyeLQkmIPtT1tLQSdHUyWXsrCR3B
   wgBIm6k8K8XOj3tbYWaCdw3QBfAfUafCEre1F1QH7jJSaZR3AlV0QHzUR
   PNGylJkkbHz7r0XswLhZtXX9oAmdR5niVYQZP0IMhUu+9dHTb16WN2SMO
   4z8SBuY/iniQDV8Bch/lA+0KHQRKsv5v+CErYbAMpaAWIQshod2LS3FRJ
   w==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="180095514"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 12:16:09 +0800
IronPort-SDR: Kk9PdOx0sjpMUAm1RoX/uh/0t18Bo+r4z6eAm+S83Y+Ehva69pBclhQlh054kWI+TczTL8ewic
 Gr4fFwVrxV4SnK7eP3yuqgLBCEq/H9SRx4C6BXc76act106UdnCXSR9c5urgzgK2t5ta2Ok1JQ
 l5dph9VkBmyqCVngzXp62gddfW2tNFsMLRD0oqcm8wDXNxe/3pSdVfMWZ8IAmznS80KiVdDU/g
 hRzzkVOrTUIElwjvPC8RIvV6imzHzOO0YwzM1ZLnsnRDe4r1XXFuCxALYS6yptAAjqrAr/D9Rj
 qL2szY0MC82zIYeBTjjGehwW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 20:50:43 -0700
IronPort-SDR: VDFjTnmXBsYC6cSZE33HFGiGaQ6nk7xhseWUbzSxacuctHqQSxdLxxlPmnpVwFbEJzhUXhtGB0
 4YuPwSVbHYuPbaUS9Y+4a6lwFwMLBBjfuULBVte4CZBAuoLzBHx1ryhKNV7Cn6xhATzraeXn58
 CHZmGwr8R2w5Mb91DlJZgRJJrSsBC7GuYmdEi/Q90a+eZmk9iydqzEpXeiNVHJGQ9/mXCg6r5S
 7qf1+dlBRirI2FK5IS4bJWZQuB2OSnX5CfdA2kLrY8TMS4sXnLMoS5A9ICawlMgLhpBBDNX7CU
 Gc8=
WDCIronportException: Internal
Received: from 1r3v0f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2021 21:16:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/5] btrfs-progs: temporally set zoned flag for initial tree reading
Date:   Mon, 27 Sep 2021 13:15:53 +0900
Message-Id: <20210927041554.325884-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927041554.325884-1-naohiro.aota@wdc.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Functions to read data/metadata e.g. read_extent_from_disk() now depend on
the fs_info->zoned flag to determine if they do direct-IO or not.

The flag (and zone_size) is not known before reading the chunk tree and it
set to 0 while in the initial chunk tree setup process. That will cause
btrfs_pread() to fail because it does not align the buffer.

Use fcntl() to find out the file descriptor is opened with O_DIRECT or not,
and if it is, set the zoned flag to 1 temporally for this initial process.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/disk-io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 740500f9fdc9..dd48599a5f1f 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1302,10 +1302,22 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 	if (ret)
 		goto out_devices;
 
+	/*
+	 * fs_info->zone_size (and zoned) are not known before reading the
+	 * chunk tree, so it's 0 at this point. But, fs_info->zoned == 0
+	 * will cause btrfs_pread() not to use an aligned bounce buffer,
+	 * causing EINVAL when the file is opened with O_DIRECT. Temporally
+	 * set zoned = 1 in that case.
+	 */
+	if (fcntl(fp, F_GETFL) & O_DIRECT)
+		fs_info->zoned = 1;
+
 	ret = btrfs_setup_chunk_tree_and_device_map(fs_info, ocf->chunk_tree_bytenr);
 	if (ret)
 		goto out_chunk;
 
+	fs_info->zoned = 0;
+
 	/* Chunk tree root is unable to read, return directly */
 	if (!fs_info->chunk_root)
 		return fs_info;
-- 
2.33.0

