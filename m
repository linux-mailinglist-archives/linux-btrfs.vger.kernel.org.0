Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A60E49C5BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 10:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbiAZJEI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 04:04:08 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42199 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiAZJEI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 04:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643187847; x=1674723847;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+nuJug7S6EZ5SVyB+McW2hLpGgtFb8iyBrquktOqFYY=;
  b=ljR3GQ5K1sL/t0XDkbqEk7OMi9wOpKlVPeAZ2jLJWmUEBiuwOjaHepQJ
   0vxbvZBK3q6NAmp+KEGYeDxZiCwyb37nYp/DTEX81T2C2BhnPC16q33xI
   DgR82NQSzFGYD+szbPW+zkKsgH+ZPYefJs6yuRVy/ZzjUHNZVAXEbWItb
   eepGE/jETmvOJ2SOUXk6pDbTnghd4xrYvBM+Ou4hgI8V76//phqWd/8vo
   OYcMW44FhEY0rE815EUqJ8jmYy2idpJRMzfE/H9Yj3GN3f4i+JVSjLJe4
   P2yaJs2WpIx8DCbOuOl438fsohqZYcxcRyvzeY8qQcH/LW4KAAPAhLqsI
   w==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635177600"; 
   d="scan'208";a="190359864"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 17:04:07 +0800
IronPort-SDR: Ts4ij40QvhpfScttI5o5/MEUKnMGB7O6nTUqijbe63k2CKTqh3QgYmdjUzlcKO1DSt/zRYaJcE
 KKW772z7Egi87LIambdBRvXLYbn40569TGztJp+iCqCYbAZNgv2mhCGcRhCw/BmixzHfhxf0Y+
 P8NwuE1Z0de6y9Ye5HFYfP+VncxFXHG5F6lQgHtWibolVcwvucfwKtp08KWTp/mIkretzvg54X
 p3fJnv0djv3k7NVHz2Kyk1RjVo6/FzFbbA0BkgjMppMvb1vyGnzdnEn1lyFduC0Z2nrrIWsg3W
 ctpO6W4ikbauvxN9IfqdAjyU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 00:36:12 -0800
IronPort-SDR: muXNy99ZXZ2xtJmgUjTEujNv8Mhai/MWNQgmqAvajb5lQ4jWpJh27xNzI3sMonbho/gQ8RiE28
 LIVTSFdOLJRb6jSSgpiPROpbryLIeZeH5WwDBm5gCd1EOvxvhcfvf8igFNbD1FIQv2YTnbX5Hv
 Tv93k/15LTCQdCaSW1lpNviVOqvTFWO5n/AIpKcxAsNqX3buMQWbUH7KuCy5vKjIdXDJ+KVM5D
 gGXv81CGE0jMEh7ovmW6kk9+39wgpJRbMvIt5mXLmpsnc5kq/wfNsVwqPLYi89mvRtdifjhlEU
 bRM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 01:04:07 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: support DUP on metadata for zoned 
Date:   Wed, 26 Jan 2022 01:04:01 -0800
Message-Id: <20220126090403.57672-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the userspace part for supporting BTRFS_BLOCK_GROUP_DUP on zoned
devices for metadata block groups.

Johannes Thumshirn (2):
  btrfs-progs: use profile_supported in mkfs as well
  btrfs-progs: zoned support DUP on metadata block groups

 kernel-shared/zoned.c | 12 +++++++++---
 kernel-shared/zoned.h |  1 +
 mkfs/main.c           |  4 ++--
 3 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.31.1

