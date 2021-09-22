Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B94142EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 09:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhIVHzS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 03:55:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54798 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhIVHzS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 03:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632297228; x=1663833228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uvZ5+SZIHqdtVNd1PE02pnVtk4kGejQWMAR8WV+W0TI=;
  b=ipzsuQOklKezjbhVrCPD80D4vDRtW3KPrfw5p7ciKTqtmqRcnJdKtDPL
   g30bzzCvov/bpRUJofr7uXvvZt6tmQJ/jduFVz4PXeDoLf0mH0LKEx2MB
   RCbtwz74Ph87/ni54kn4FYv6uX5QtJ3h2j1xVfbrGJVvGyoVlsTYu0bUn
   EsOt0zESHeVGpGp3X2ySV3I686KQH650cudu9gWKlSlX95yt3xFkd3bkm
   EWWFHhsvjpl3R20vqhxZGeIXDd/jHputHCNQiynvLrZDcyrqiZ26qYZBU
   /Dweg9Ii2+ZXDtJjeRmiUZZkmDeAVBDVjqXvyA3LmsTnRM3UU5qZ0HELN
   g==;
X-IronPort-AV: E=Sophos;i="5.85,313,1624291200"; 
   d="scan'208";a="284429248"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2021 15:53:48 +0800
IronPort-SDR: i53ArRLM8/1efb7DSQy13lIiDqiwOudqTmPdErrNS86hb1UsZHZTgqjicsOU+7WYEdMcauB3pZ
 dS+5xeluAsAC9YgG2UJ+BE/4S0zuQquXTTV+2as2ymc8ZiwHw1kJZJ73Cq+OIMNBhEcCNXb5zN
 DYdEoo3TcIVDaG+DZ9lCAmUceA8rb63GLHw+1uPhSzx2Zt4c1jIaYzzAJqkbBhj0+0gesdVL/X
 Rcdc/kONSliydqdOM/i6LrCGpwSRbcTrnmoahYTLA3pG6VzsdHsR6HQvKwIpIu4CeTGKNian1w
 NBTi/IKXvPg0ZST5HtwBzJb4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 00:30:01 -0700
IronPort-SDR: Av5PI8w0YXC1i/Vayw0kiHJY5cA2ScM5fPWxTBetxcHt/3DWlTYyuOqPASa/zktYEdRWpE3MG/
 76kSOzrk9Y9Aaa9yYwSMUG4hpfvXz+v39Zpxt0eSb/Gr+9zBPSLewkNpgAtLRAAfhuaJVWuOEm
 IzjWj9FsEJcPs0cTgZ+wGPqSgyuts68oI5UgS31I0EhNW49qGRtsM5lLq7RXsjS6cIV38ChVEp
 g8iTB33M4vQmZ3w/Z8PkAhKicmWNN2vfypoqvFqCfEwR4nKP+m2iKQNPb+GYmN4KOotnY5tfIH
 Npk=
WDCIronportException: Internal
Received: from wdmnc1780.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.67])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Sep 2021 00:53:48 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] btrfs-progs: fixes for mkfs.btrfs on file with emulated zones
Date:   Wed, 22 Sep 2021 16:53:41 +0900
Message-Id: <20210922075343.1160788-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following two errors occur when mkfs.btrfs is called on a regular file
with emulated zones. These patches address the errors.

ERROR: zoned: failed to read size of /home/naota/tmp/btrfs.img: Inappropriate ioctl for device

ERROR: zoned: failed to reset device '/home/naota/tmp/btrfs.img' zones: Inappropriate ioctl for device

Naohiro Aota (2):
  btrfs-progs: use btrfs_device_size() instead of
    device_get_partition_size_fd()
  btrfs-progs: do not zone reset on emulated zoned mode

 common/device-utils.c | 27 +++++++++++++++------------
 kernel-shared/zoned.c | 15 ++++++++++-----
 kernel-shared/zoned.h |  1 +
 3 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.33.0

