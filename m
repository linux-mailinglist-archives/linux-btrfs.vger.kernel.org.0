Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ADD5E5B05
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 07:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIVFzl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 01:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIVFzj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 01:55:39 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F1DB441E;
        Wed, 21 Sep 2022 22:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663826138; x=1695362138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QszZM+R0h9OQZSqqeOlCUY8D078QycRJ1m1XM+0Eb1Y=;
  b=ETu7AZzSmV8pDXmjTjgS0hlj+aMgSz47rgTv+ju+gjqnHQWraJLbHxwP
   4Uc/hBRJjOSAHWD+DtgLTJYCLqUmFgDloq+mwKOSPbkxnDDYqiGCvzmgA
   dL3NaKEA5XcVNzdaNdzDPdSjvSdZjC5sYyZNT+VUlybSlEkh+At6uvbDM
   OtX+U++Mxh1fUeCryMuGvcKG01sQkyIOIUKDgambSfFEaX0lbwGoz0LR4
   Kjps9bWnHtDjlviMsTRI2A+Rkmb1OhS/sRQ3fY0jyR497lAGuLHQO9lsy
   MRJKnUNF6vk1mBDBSJ0Q8giw1+X2T5tWRApyypMm8bP42nnQk+lR2E+u9
   g==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654531200"; 
   d="scan'208";a="324089194"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2022 13:55:37 +0800
IronPort-SDR: W7556YijtxRzNg/3uv/oAR1fR9l79+ObWnmWpAd62uGRJu1H/btXMN4GZ3cm71fImS+74tKwAF
 tP390F5P/6niJT+0000e6L8t4EdFyb/UdK1h8erU8cnGsONO5E6cpFj8VANTVwPevSKtMat4KJ
 dn3frrzUTenmY5CBqrHN5DXdsXGKITPVowZadeByexEpcoHYuHg5lL6RjGimi/lfiw8lrpdKao
 vSlz2dA9Sh4l/JaPjqEh9LRxoFMNw+HOexNJgQ4zmnkDyanDF+lHDs6BMSDngzXqW8JfeyD7LO
 QTMTo+KeTapOpVghnAcZ4EN0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2022 22:10:11 -0700
IronPort-SDR: K5wQlR8Q1hlrgrvxesr6qBWC/g4j8DskMnjAzIdeMAM+Fmr2Nzxi+fd20aHmiU9kdlWp8Ekji0
 oxdeBgxt0Ke7+x/ivAjPXiWoIpaMbYCQ2s6vXvh9hdRydKwcNm4C58C1m/PV2WGLB2SLRrNgDE
 1ii5Xtzg52kQVvBKtVh4L4b6glPoyZf9w7K8Qdy1/0H3gm1amI8Lxfv3lJzo9GoM8Rep5coEhr
 CuiuJjr7YU7fXGQRi3lE8uAc+1/OzuAwz2WsiRth31dfhIHiyWg+sH2BleHkvtNjzE02Zc7Mhm
 ljI=
WDCIronportException: Internal
Received: from ghkxqv2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.86])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Sep 2022 22:55:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] btrfs: test active zone tracking
Date:   Thu, 22 Sep 2022 14:54:57 +0900
Message-Id: <cover.1663825728.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series adds a test for checking if an active zone tracking feature of
btrfs's zoned mode. The first patch introduces _zone_capacity() helper to
get the zone capacity of a specified zone. It rewrites btrfs/237 with the
helper and use the helper in a newly added test btrfs/292.

Naohiro Aota (2):
  common: introduce zone_capacity() to return a zone capacity
  btrfs: test active zone tracking

 common/zbd          |  29 ++++++++++
 tests/btrfs/237     |   8 +--
 tests/btrfs/292     | 137 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/292.out |   2 +
 4 files changed, 170 insertions(+), 6 deletions(-)
 create mode 100644 common/zbd
 create mode 100755 tests/btrfs/292
 create mode 100644 tests/btrfs/292.out

-- 
2.37.3

