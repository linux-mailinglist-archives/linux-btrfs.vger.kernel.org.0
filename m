Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77CC34AB96
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 16:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhCZPeu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 11:34:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30972 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhCZPen (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 11:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616772883; x=1648308883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MGFnDRRFwaRNCE8CYjYGb+Lv8XPiJeR7KxwZOlrH2M8=;
  b=BSFhSnrxm7SJw2LlBGFJ7WjSrqWDgI1/31RjygQyXQ/2qSubr/dRIZux
   leN9nle/cxLs7BQo77p82PEHi5nPZPq8ugW7+CD33gY568AvmL/VVVaVx
   Vb4x/10Ij9kQdb4V/Pfw9PhA9JvrOvbtj+ObZJ0pCq0tpGJZggSl5Ow4M
   5507c7vqTdnmqnyo/4ayVvFabvAhROMs7F1rtvjpemKtWBZZoE+hlA3pw
   ktFOSLpw59gX0OYiu8FUL+J5e4BsPSxRS+NDB5IFfQfGdI0luMg4IkX0S
   fJ2vo1PnGd5/tQV23/mbAM4vA81fbD3gW69V3UYbJy4x2vB1JPjyY4AiE
   Q==;
IronPort-SDR: LdtZwY3FFRnpnarhIPN4X4vuooTQ8xFV6+M/Aaod+abQbDiPnxRgrGZrvZy64GR8QVzvjjr0YI
 nLXfbCKWGSCAqGqhrAw9mnoJgiuLdPUeZKd69tBlwL82aZbnqqEWYSbGZE4GJHO05ghyi1O38I
 RVisuvCMsZCTQ/6ZMJbc3mf/xIhkwwwhTgv34x5dAhLqNonEUcrvSxdNTld00HoIim+4MOCKM4
 q8lN3TVj/gmtmViuCLhzC85RdpdCx39UwVUHJOXP9e/RxLE9rYYfsZ6yWy+rC8vrxKmtHQHTz6
 5tQ=
X-IronPort-AV: E=Sophos;i="5.81,280,1610380800"; 
   d="scan'208";a="273874234"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2021 23:34:43 +0800
IronPort-SDR: z9L1qUbw0npv+nNdcHph1B4OmnjT8ZaOp46uzKqIR+fqwfE0GxboZhwW2b6rhGcQQaanGrBFw8
 7bj58z3eE4dyefJKd/zmLUOYOJYEp2pTSwYIzIh0xAXURr1cx9jdz3mr2pe4lwwtBzq+J0CI8p
 SPADr0VKxauXaYFhHhf9JT+Wi3UoZypryeOWC7Hr3eupM47t1z3ek56Totl52eduq40z+RUfnt
 oYhCqFtmVlFhH1MdEnIccMLi2Xu0CM7sskdnBA5bQ/if2icWvbCE9fVHlI4w4NU6oY/1+D4+kv
 /XGa5pzukR3pMdJb2ljoJ1nh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 08:15:04 -0700
IronPort-SDR: 9YO5e3PJmZLdcSqdSCamlS3MzX4BpWAVVz+QPQJnHeZUHuLBlWJgzXZrTZ7DRhS1tPiAS3iFpx
 by2eaOFi6YvLFzpTYx2Jln86zCLO+Xz9gY8Nww5O2Yo8B08thVu1waVdgQACtDpB7hBfJlf2YI
 EFYbUJEmjSPPGYqND4G/yxaG+BbmwpypWwCcvxk1fe9iCoQ2QWpg2ut2Cty37dt9/3ayI1tpg3
 HzipUO6aQCOQqmIN+JnMpFXpTN6xUEORbysAPzroF65D5owFhtmoqdsFQwQXu0vV+Sfkk4bRbg
 pv0=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Mar 2021 08:34:42 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3] fstests: don't rely on /proc/partitions for device size
Date:   Sat, 27 Mar 2021 00:34:37 +0900
Message-Id: <20210326153437.27840-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Non-partitionable devices, like zoned block devices, aren't showing up in in
/proc/partitions and therefore we cannot rely on it to get a device's size.

Use blockdev --getsz to get the block device size.

Cc: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v2:
- Don't forget the sectors to kb conversion (Damien)

Changes to v1:
- Use blockdev --getsz instead of sysfs (Nikolay/Damien)
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 1c814b9aabf1..2f295fa05484 100644
--- a/common/rc
+++ b/common/rc
@@ -3778,7 +3778,7 @@ _get_available_space()
 # return device size in kb
 _get_device_size()
 {
-	grep -w `_short_dev $1` /proc/partitions | awk '{print $3}'
+	echo $(($(blockdev --getsz $1) >> 1))
 }
 
 # Make sure we actually have dmesg checking set up.
-- 
2.30.0

