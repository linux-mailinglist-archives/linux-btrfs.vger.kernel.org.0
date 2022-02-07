Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF34AB416
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 07:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiBGFus (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 00:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350022AbiBGDLG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 22:11:06 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59FEC043181;
        Sun,  6 Feb 2022 19:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644203465; x=1675739465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgEGgT9hg08/vaCtBuyGS4ntdQzvuj9kMy+3OGsW+xU=;
  b=S810yoD3N+bsH3zKwnhqmUrmWH++R9UupVaFQwv81ZX5HmhYOhravRNg
   DEW7209MTe4rL5MASoz+7PYuDI5a5K1FlNTXyImCpcgWo7bpay2Jh9H/Y
   StkVGGljZiTowFxVOiX4mJj7lc+x8yBabHxKAN+Zg4D/5qwi66i4nai64
   YlC8Wvg2tQgvIbidfFq2KqafQBESctHzPmaqbR4LyL658SqjrrXG4kUrV
   CJGFb/dg3uvMoL9hhcvxDW0l9vwgd8BBQHW5uhzjxhty63fV28cfTajw3
   1g+95r/ld0tDSzR/i8FW2+rjWSd4e9A9lrlMKhzv7eYexhAjvMnNPAkGV
   w==;
X-IronPort-AV: E=Sophos;i="5.88,348,1635177600"; 
   d="scan'208";a="304195999"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 11:10:03 +0800
IronPort-SDR: kRcMPuqXnSOKJcyE0LeXgcC8Ac2ZeCYg2/+SAyJlqesVPEwJtGwKk+qT75+Q4HiXdIoa0sn0is
 fxjSaRNWBWwtjXHlgagL7R4GWijgcELGHpCj8JUESIdg2qy50q5zfLsS+GUJ1z91hrPswUOLWU
 dn0b0WlGHYOcsdM/as4n6MEsPuXScLXi02tebh6b1TTAmmZj7s0y4OQ0duUxlPeqHLSb30FakM
 VoFLxrpaeGjBRwEXCnC8nVBiUvMny8z6Dc1mH01oOIcyfoScvglvvQXNJ6cmIoplX1NJZy868L
 JEhw813yHNJJTffNwVdqO260
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 18:41:55 -0800
IronPort-SDR: 5Ee+xOSvnhEzGBNBQ1/NLUpdCiE2eTBv90O1aeLNAvuTzq/dzZBia/Q7exeM+PrquFe++abj+s
 ddna2nAYJxmvJks0W5gH1vht2V1V4HbTdZsuSR1BG7oT3vD217SLtYL3HvzyjI2WVAHQqGvi32
 UuZhfVZ6VBZA7s5Ec0IVC/eKGpy4djN+QxSAP0EAUMydS0wuLh1hfMiK7zX57wk3ldrgo3Nhc7
 LkBQgqR1VRBA/2hU/8TCCnObGn+U4lb0EuvtsZsIv0xM38roQYKZt3YkGsGYas4HGdvER1zLjm
 PJQ=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 19:10:03 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 4/7] xfs/015: check _scratch_mkfs_sized return code
Date:   Mon,  7 Feb 2022 12:09:55 +0900
Message-Id: <20220207030958.230618-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207030958.230618-1-shinichiro.kawasaki@wdc.com>
References: <20220207030958.230618-1-shinichiro.kawasaki@wdc.com>
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

The test cases xfs/015 calls _scratch_mkfs before _scratch_mkfs_sized,
and does not check return code of _scratch_mkfs_sized. Even if
_scratch_mkfs_sized failed, _scratch_mount after it cannot detect the
sized mkfs failure because _scratch_mkfs already created a file system
on the device. This results in unexpected test condition.

To avoid the unexpected test condition, check return code of
_scratch_mkfs_sized.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/xfs/015 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/015 b/tests/xfs/015
index 86fa6336..2bb7b8d5 100755
--- a/tests/xfs/015
+++ b/tests/xfs/015
@@ -43,7 +43,7 @@ _scratch_mount
 _require_fs_space $SCRATCH_MNT 131072
 _scratch_unmount
 
-_scratch_mkfs_sized $((32 * 1024 * 1024)) > $tmp.mkfs.raw
+_scratch_mkfs_sized $((32 * 1024 * 1024)) > $tmp.mkfs.raw || _fail "mkfs failed"
 cat $tmp.mkfs.raw | _filter_mkfs >$seqres.full 2>$tmp.mkfs
 # get original data blocks number and agcount
 . $tmp.mkfs
-- 
2.34.1

