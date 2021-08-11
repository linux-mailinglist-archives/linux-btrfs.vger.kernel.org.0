Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906033E9459
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 17:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhHKPOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 11:14:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39986 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhHKPNY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 11:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628694780; x=1660230780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VEO7s/cM268oJYh6wmyPOMWRjlyivUmJaG7MGhMyJ/I=;
  b=rktfW4htMPIY33TJJ3z/XS9c2IL9da3M813XpdfS5KDXh8QmmvM0nPkb
   Xn7kKOcMzhTOrgv3M0kNrIJcPdqWO574X8nAD4+kpcxARg0r+MHGYGwK1
   TaM5p4EUqPRJ4G6UCXp8opFGdHf7Dw/alv5wevEgrfSRuylgi9NDtgySV
   XVmIo06Wydh6FaN2L3knJwzz7kPC79KmCxgns1o5cCiUrkl65tnXMGW7/
   N36oh7+l/bSxV8BlmgKgRIWn4XoPza3fzompzvhneuHUFnC0po/aHmfAF
   gx+GHUum0Hhcae9kMPSVO1S9aFmMawimwEgUKArgme6k3Wbpo3wjJfCe+
   g==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176942572"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 23:12:59 +0800
IronPort-SDR: 9UhkkjTbYUJG4HgIh1RhSdU2dVhd59bV2CMVIGFfMqlvj1fJOCVRHXiit48hEo2lFRpo25dS00
 TGjP8HUvFONJuk3BPfaoDS6DG4fSROZXBuivE8dAMhXLEt43afxmko0WaT6jPWqJalqAkv6ZlY
 SZbWDABpAMESGKvMnk7Ml3ByWY/yNLgAy/mR4PiGvh+sqCyBrRMRwMS+X1b9ZCIwau8j8tNKzT
 Iz694wbtamvA9WesZBzN+O3Q293x4jBrwD306YOfKShcfUcXUUa1wkzSx2BDE1/u8VniOsXC70
 pRBBpjBNyPLWqKmo1mkqRK7Q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:48:31 -0700
IronPort-SDR: g+Y52NKrgjQHx0m/zdtI4Z1khcP9pVfR4zMKjn4VVMZ5DfI3VPgAFeDJPM257aGt76Spj+bG5X
 mxL8UC8/Kq+HwFxcR8XLnd+cMywHEamDaI+n5XsW57rq6t95AdjYEJB0jU0V6+9YWqwzLpSH+0
 usMI9wSN6FQyQ78xkXcc7r1m2q5Wn+8/4xNhOiRb30jXd+3pVWMiV/DD4wIiAgjjfmw/ecMwXm
 6Z6SZ66/vm8hAqE2riHIRr3qd0Lbb+WUHMLus8McQFMtTYUoB0mw07QpLpZBFy90HixQLbDBJl
 FAY=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 08:13:01 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 6/8] shared/032: add check for zoned block device
Date:   Thu, 12 Aug 2021 00:12:30 +0900
Message-Id: <20210811151232.3713733-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811151232.3713733-1-naohiro.aota@wdc.com>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mkfs on zoned block device won't work on most filesystem. Let's
disable the test.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/shared/032 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/shared/032 b/tests/shared/032
index a84af3a603d8..131323ab5b0f 100755
--- a/tests/shared/032
+++ b/tests/shared/032
@@ -17,6 +17,8 @@ _supported_fs xfs btrfs
 
 _require_scratch_nocheck
 _require_no_large_scratch_dev
+# not all the FS support zoned block device
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 # mkfs.btrfs did not have overwrite detection at first
 if [ "$FSTYP" == "btrfs" ]; then
-- 
2.32.0

