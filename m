Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A820382C0
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFGCec (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 22:34:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12510 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFGCec (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jun 2019 22:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559874872; x=1591410872;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zU1Vg9FswEhIYHKBWmDhuxhMbwOMOKNXM6UMRj6/5Mc=;
  b=oiy1QgTrIuqwpWxzLDLqw6Fyaar+LQfeeI+/gCWcijOuxkL60N2In2dZ
   Wiq0UtquFpz2n4Kl6+Na3Xdp3xNzRXdlMmdH7VGIoCVL/jxVO8KX+ODpu
   GE0URga624afPi33qGUirChuxgM0GdfUytIAMVGGA7DIunEpKTNieCmbX
   jgjNiGKtDZhfDXp4EJbD/0wSflFzgXJj3gEZmx7pP63SKITVk+BP3HEf2
   0qroRRJQ8Xyv7YyIeGUkZoc8ZiLiZIdFAQYrlGXtJXR7TVZPFL3o9QJqN
   BmYOcCyRi8D/t80iy9bFlFgvYXao5o3M/z5eDv0J+Uu9Wxgib9mn6IEEy
   w==;
X-IronPort-AV: E=Sophos;i="5.63,561,1557158400"; 
   d="scan'208";a="111278406"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 10:34:32 +0800
IronPort-SDR: wcRAzpGp2PcfE7/ErihxnwCzWq0Gc0mHxy/14EcnpwaRqu7chAdby4HHtpEM4Eh4xkbQkRN7Kv
 UkP3xXKt6WqdDyu5O/xgZYps7iAYQKzuemdjqOu/VPAlWOBh3hBjv8w1wUb/Iy0dMCq3wdTO/n
 8v5HkZbS/H2l8IAVwJTj7VDj9P0Vcxsmm0Vph0IhjpNOxwglZRluWL6utVM0bcAdrLT0okjuHr
 2/OdFlsQY/1B1ud/TIlBYtZMJ01d/i93C5WmOPRif2CMOUFMt8tLXJ+Xl9O34sUTKr1rAG/sM1
 x6oXRuRd5gL/MpN5Wco5Wtv+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 06 Jun 2019 19:09:25 -0700
IronPort-SDR: dUoqpwF8tEqjqTrjusbWfzOaxzbeM524CuL8SerprH8bUQYPsGZYk8cDs/b/M7sk1wN3piGWvq
 JlhSglI0cFr0n5FI9LxoW+SNpFJPEfhX061wAU34BIn3ibH1sNYZYPQdmQz+5qtEU247JC4LJ4
 hCO/VLdVVDTlkH/BF+9qxc0TjNvyy08/WSKRPxbeWg5VmJWPd26qTo7gFH08hxtcLkObEX6tyK
 FTgKkguS9szU2GAo4HxfSPcEsIjtukfpMvexhd+ugmXB3uZQKSQD+rqwfIai1hNl0oD8U0p7xd
 Cs4=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Jun 2019 19:34:31 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     fdmanana@gmail.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] fstests: btrfs/163: make readahead run on the seed device
Date:   Fri,  7 Jun 2019 11:34:22 +0900
Message-Id: <20190607023422.28928-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a long lived bug that btrfs wait for readahead to finish
indefinitely when readahead zone is inserted into seed devices.

Current write size to the file "foobar" is too small to run readahead
before the replacing on seed device. So, increase the write size to
reproduce the issue.

Following patch fixes it:

	"btrfs: start readahead also in seed devices"

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/163 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/163 b/tests/btrfs/163
index 8c93e83b970a..24c725afb6b9 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -50,7 +50,7 @@ create_seed()
 {
 	_mkfs_dev $dev_seed
 	run_check _mount $dev_seed $SCRATCH_MNT
-	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 256K" $SCRATCH_MNT/foobar >\
+	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4M" $SCRATCH_MNT/foobar >\
 		/dev/null
 	echo -- gloden --
 	od -x $SCRATCH_MNT/foobar
-- 
2.21.0

