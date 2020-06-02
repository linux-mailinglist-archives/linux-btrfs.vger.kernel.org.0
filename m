Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A501EB914
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 12:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgFBKGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 06:06:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65297 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgFBKGS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jun 2020 06:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591092378; x=1622628378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BhftQe4ReLWw3weaBnmVTQxurhFzusmAktCpCb5mE5o=;
  b=SRPr0N3j8oflOtE/twQoqZLoggJhLaDJn0Wb2DmQ+5rmueWi03bY9Cij
   EyHM/iHrMI7VZaprWizwgckQDWEmwkPeEqCsny3gikxOqloG7MP4Izcnt
   IpPehg/yJAvB3kaxZxJSiVAlsMwNeGdguKu5FUO77X8X9HJ8cTgorF+JV
   zrClRlg+X+60eWhTWkgS2n3sBDWjq+/EGXxYZG3R9Fok3o13gS4Fqqdzk
   JQsIoIrtDJ3KyCafV6JPqwFwT6TdbMq2QDokcl7VEK92mkxRqS2x5wZv1
   j8iyZ7DzHCqTV8ZGOIVluLgNl5TTmkxETB3dpjwjg196hTFDSR1g89zys
   Q==;
IronPort-SDR: Sj39UgB6F2EumTaJyi9wHzaqnCnOoJmyzTLZMB6+SQSoOgJr1PQUvY2WV1gDoxvHWX+F8U1QCp
 ZCBdqrcmaYKt7saT00WkO8Ub1J8OQX6LkdvjLTAktCVrqKAbd/Q7OvDSU1AUYBje7gDaJqVeR0
 WM1uQfiAMK+SIzEGJ6c34pqszVHJzNX2PYiC57AKJptMGCGnhhOXVjOd7HKFlVX/d39bdpkLNa
 ErhPd0MHDI64kiWkzFDU0rqa0whPgwhp2wPP6wJYzHu+G9glLjK6kYXMRRq/8yIpq/qBcs0Zej
 WKk=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="248104351"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 18:06:02 +0800
IronPort-SDR: k0UhFbWip10drkCaCS4wpub5oKo5vOAXcj3y59sTzvXz5GUreG0KLGn5oU77CFHFWE0od0CFUN
 3wMYLC8ilqek27czw0jrx5WUSb4bRod8M=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:55:09 -0700
IronPort-SDR: baLqM5OSUbRdbPneGlWXH2ZkmQoRgAQGYQ0qR+cHtBhvU0XTyJSBwadFuUPnn1h4HvQMMCRmQs
 LkKwXkLj+e6w==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Jun 2020 03:06:02 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/2] small cleanups for find_first_block_group
Date:   Tue,  2 Jun 2020 19:05:55 +0900
Message-Id: <20200602100557.6938-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While trying to learn the Block Group code I've found some cleanup
possibilities for find_first_block_group().

Here's a proposal to make $ffbg a bit more easier to read by untangling the
gotos and if statements.

The patch set is based on misc-next from May 26 morning with 
HEAD 3f4a266717ed ("btrfs: split btrfs_direct_IO to read and write part")
and xfstests showed no regressions to the base misc-next in my test setup.

Changes to v2:
- Dropped label removal patch (David)
- Don't return early inside the loop (David)

Changes to v1:
- Pass btrfs_path instead of leaf & slot to read_bg_from_eb (Nikolay)
- Don't comment about the size change (Nikolay)
- Add Nikolay's Reviewed-by's

Johannes Thumshirn (2):
  btrfs: get mapping tree directly from fsinfo in find_first_block_group
  btrfs: factor out reading of bg from find_frist_block_group

 fs/btrfs/block-group.c | 102 ++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 46 deletions(-)

-- 
2.26.2

