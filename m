Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A12E4F5BAB
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 12:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiDFJjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1583889AbiDFJfn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 05:35:43 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1DB2DD3A3
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 18:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649209429; x=1680745429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MSXj4YJFRZPfM0SZ0eQO0LtLItYtmBCZ3wYCgtJHijE=;
  b=lkqXPmTKqf7CAuGaEoGExQZgRDHfss/UTSUcHQxN+eOsIRgX9y8s3Rmv
   ZN0JlyIQ+i0m5ZWwABPlp38qhhLF8IbVuV9LIgKJ866JSggqk2a77hPy6
   w69mx7LkG7S+vdeFKQ2O+TVzjEcdfnVDxqRHS6Tu2vcJ8pMpwcbdJhF47
   kvMbyae98pHASGUvsHhGT+6D8LtklgAyj+o8FZqBJTeLbBeFH3XrqAXjW
   Nfw+kjOGbsSJGiI+zYrp0Ilo2hbobFW/ju9rblk76JmYv5g7B6fhUisj1
   xsWAB2/701ieuzemnSdYvqsFFx9zLdgfFVhGjIuqwRSk3UZ+GZjO3/q6V
   w==;
X-IronPort-AV: E=Sophos;i="5.90,238,1643644800"; 
   d="scan'208";a="309153500"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 09:43:47 +0800
IronPort-SDR: +eN9I9HKqgnWOAa/zxDB8xRtWTHd1Vp0mdOSkWQ2CV+ODQ5c6K7S/qUttDgCtLHhcOVlJxzuk0
 86l0+hIZmF8/CtWcs5TJFt4JlVSLoJtu/DGcYviScHE+TdbhTjWme/WGkWvk+uJfHQw4oHMrip
 SJUp6LBkOh7EHjGS9IJ3SWCr0nO+36tkIu6F+/PgWX7ONJh1iQzUhJCdp6+mj5YEAowuJhN+nF
 qTLImXmeT/7VI/DiJ0Kde+nb9CbQ0zCc/jqBBV+8aan1LU+9JRKce6YDJ71mGZZlIN3NuMSaNY
 gSZ8yK4WazWJjhRPypqHi09v
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:14:29 -0700
IronPort-SDR: 7v5cc+D7yQ7HrLfiamTBHm/BvHukpjGpSwkOEw+1F60RFvML6Tne+4wdgVUiEGNlvVnNk5ZVa5
 N0oKaMmYcLfzVxTANDvnCzDbc1IJqNTTs+xoHktB47Irc9XBZZbEDlydCE3pCH3anyHRYCqPey
 AI+wKUEqfuB9nk5TvpzQgtzv7B5YafpzXrq6ANyShhJ/pCyHqri2VdKGQ9xFKZxn7PtmEaZKvP
 ImYttgy/O7Wiu+9+jTEZcQnK3/YB7PRnMGhPtdTgt8jvorpddbbV5oge893GYapEZ/bDIIEpRj
 HQw=
WDCIronportException: Internal
Received: from 5cg2012qdx.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.10])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Apr 2022 18:43:47 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/4] btrfs-progs: zoned: fix mkfs failure on various zone size
Date:   Wed,  6 Apr 2022 10:43:09 +0900
Message-Id: <20220406014313.993961-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are mkfs.btrfs failures on various zone sizes. For example, with 32
MB zone size, mkfs.btrfs creates the initial system block group at 64 MB,
which collides with the regular superblock location. This series addresses
the issues.

Patches 1 and 2 fix the location of the initial system block group when the
zone size is 32 MB.

Patch 3 fixes the location of the initial data block group when the zone
size is 16 MB.

Patch 4 fixes a bug revealed by patch 3.

Naohiro Aota (4):
  btrfs-progs: zoned: export sb_zone_number() and related constants
  btrfs-progs: zoned: fix initial system BG location
  btrfs-progs: fix ordering of hole_size setting and
    dev_extent_hole_check()
  btrfs-progs: zoned: fix and simplify dev_extent_hole_check_zoned()

 kernel-shared/volumes.c | 32 ++++++++++----------------------
 kernel-shared/zoned.c   | 33 ---------------------------------
 kernel-shared/zoned.h   | 33 +++++++++++++++++++++++++++++++++
 mkfs/common.c           | 30 +++++++++++++++++++++++++++++-
 4 files changed, 72 insertions(+), 56 deletions(-)

-- 
2.35.1

