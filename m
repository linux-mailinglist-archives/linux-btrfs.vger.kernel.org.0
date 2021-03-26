Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50C34A29C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 08:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhCZHi7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 03:38:59 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20597 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhCZHi6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 03:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616744338; x=1648280338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JToY7Nv0NvKoBEFe3sERPXIsv4kYueZciz46XwF7fdE=;
  b=S0VFKnHJd/JQZw3ZGdb/iJaQ1Bq9bajBFwU46DT/Q9hQcr9mwLJVuH/U
   C0LnYDGUsQhTVaCxRIoebGkFEGmFtEgbJQs9t/WUYVdVlYnRVGMew1MUD
   hfFzzvljnY38mqpoWCBpLKMdfG42GVI3gazcOoBudNlCY/fbm5ytFz1z6
   MqW6tUIjaYgzIUO2nST4Fsy4SKzMjcdUMtccPxUwH+HlUkafcdUHpaiPQ
   fNHgL1Gd4DNMVG9GTN/UjwoSO/iq9HXg4v7bpbttSamCkfnqu5F3vYX1a
   5Tuos318n3yF8K2mklgdRkVnRGLVrtoXC5JdBSXE2cdlKNf0+9dW1t4it
   w==;
IronPort-SDR: /qjy1zC0++q2KpYHyE/VFKw0zkT5fQWX/5ybF0eBG9gdGZAheFjsH/WtBru5ck/stPBSU0YkFm
 q7P/h5ANFN6jAU3tHZFEGK7IrVlQtDqlaX2jbnwshAWBx/wexYYrlV+kbIm9+1XXbtSatf8N8u
 /YZwg4JyNM/ECtHZ6wmpqifZH6BAYYba9cce9yqDXJYv0mR9KvizvZxwShTklEQA6uFa7a5sFW
 XSxKG+ms8LrYE719+Gju2c7mMs8P710qUPvspmgEL1D4SBfPJY0oJtGMT4vE2kfNY3imLaJ807
 KJI=
X-IronPort-AV: E=Sophos;i="5.81,279,1610380800"; 
   d="scan'208";a="164170003"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2021 15:38:54 +0800
IronPort-SDR: hnP6jLAQPKGYmlhX82O/TGTyPd5Fgti07YPOCfNYqvp4ROXVUsXqKCW54/dZr+xdrhKfZCekB5
 sbLyT0c/PVckdAsXDM+NCuFKrfqUy47V84C/qf2hdi7SOAFG8S0Ge06gSmAPS84LTdwqWyKqfv
 +QcDWnZarjtEY9g7c2k5OWYnVjt4KNFO3bDy0I30A8Zz4ZxsCN36X/j3TKUVC2YB225Hiv5EoC
 eiv9Au7LXjzq60XhXT4+35jm9ufux5d4CMm6DHekp2RYUoTOoJo9xgqbP3Wz81hFxJlzmvMk8B
 hESX4TN6B3G7GKK+cR2uolO+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 00:20:55 -0700
IronPort-SDR: ojn1dJBk3F+c7AdDaDDu9BMLXtaz0Ggu7oLXk4pcp2lm7uZXcVcDnb43SkzycxAxPA30M43uTi
 eth38K9hLcsNvqlRtREXEtRG05ZszYwki9Bs+t3ltdj5ZhFXGli/1PVB1RloZpH5LJ6YULv0aQ
 J19ljPdO1RGcNim1wgSQuTgkWzhWXIj7hHBssZjgVe9UElL6pnkXmfC3A3Tkbtw1bhw8gXd56O
 gWU8IUxl+sCeKkM9vTdieOrZqupHlahuc98gaDoG4ecFPz+4hxmKoKVK6+PsWfmweGhYRrVTcT
 Lto=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Mar 2021 00:38:52 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] fstests: don't relay on /proc/partitions for device size
Date:   Fri, 26 Mar 2021 16:38:46 +0900
Message-Id: <20210326073846.14520-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Non-partitionable devices, like zoned block devices, aren't showing up in in
/proc/partitions and therefore we cannot relay on it to get a device's
size.

Use blockdev --getsz to get the block device size.

Cc: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v1:
- Use blockdev --getsz instead of sysfs (Nikolay/Damien)
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 1c814b9aabf1..40a9bfac31da 100644
--- a/common/rc
+++ b/common/rc
@@ -3778,7 +3778,7 @@ _get_available_space()
 # return device size in kb
 _get_device_size()
 {
-	grep -w `_short_dev $1` /proc/partitions | awk '{print $3}'
+	blockdev --getsz $1
 }
 
 # Make sure we actually have dmesg checking set up.
-- 
2.30.0

