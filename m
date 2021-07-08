Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF22D3C13FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 15:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhGHNPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 09:15:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42289 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhGHNPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 09:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625749957; x=1657285957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K55IK1qJ90+xK8LWJZ2Gq3Z48X4FJF+uzLeS5uvkHc4=;
  b=Q7OhO6AMwtEXR95QtHl8dKCcXYFRpwpbN6suZS4Ts6ryfYzJtyz6hvuM
   Nj6BX5v03DIYBIvtwjnPWq3YteOmARI5/9F8YIp1AwsEbTMoQZl0KCNkW
   qfIMxdiZeTE7BhmEFBJRZzbjSUCH8OkijNJPc0f+Kp1qfsZTqS50ysYn3
   DOvlnWIrAFLox2tS1iHTBJ9db+I/PE6PX1WK99pjw686VQNP2zYRti0mJ
   99kjiVfV5X9x0Oq1p5sSQ2nPedeNoGA3ez8BUE2LYU4Faxw2pqoCaaJ+P
   gIuNNrQ7ngeFRetAJTIvUyhv5g2N3+c8zJqRzE5UtIyZAp1Qe94cLcXtM
   g==;
IronPort-SDR: P+I7Ql9LVLVUYHMD7Hv3TFq8Sf5Lp52XhVJ/2ZDuuzQUzB5FjWZgNRkpz9jHZVE1sEmHvMrRdU
 3pEoEuRwSTxGUbcyMfHqNHkL6XSaFz38ZxqF/daCI0/0Zkf/Ze2xwSl7M/Yva0grpzVvY6P+E/
 BEIf/6DDNx2wMd1p0EhvuE+8Q9fn41B+vq4WZqyNv8noGBqkw7X1CHc92+lv+QpkRuCw6DKfXh
 PVyrgJPDoLd1Bd4aeOF8VGk1N6plAqvAaKet9aG53EwlIxhAqyTVOmrUiyqIob7X+fy/4N8+Qj
 Ajk=
X-IronPort-AV: E=Sophos;i="5.84,222,1620662400"; 
   d="scan'208";a="285562703"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2021 21:12:33 +0800
IronPort-SDR: RpTruAzdwohSGjcBN3jaaKOfcfkOwTqWAi2GCkQl2p98KHDe5+tAhIOm5PzWr8JhqLiFODAn8T
 pHnzvZS2v9Ve3m2rodbKLUP17p/HKyM2ebVhQ5EudHFPuATpvry1IQW2I4kyLxwAiQganuyz42
 pOloyDHHJHwZa4b+0q66R+xo/5NnwmwVLZyXlThNpQMo5XPCKX+0TurGgCBooyNUl7bncdz+0M
 v9iJmlA+2FqEjdJsNSbNCYTBcmJAsxo3wn2hrjLe/8D55T5qCtMMxAhR/WHKmdPArv1MTNEV+V
 z8vntGIo5PSLVQvemr0qjTBz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 05:49:32 -0700
IronPort-SDR: SblVYdyZXkNSEnIPSrhyaPhUAe0xYsG8e0ubQsJ881zMU+/oBBveMgcM0qe7DuwesAgc2tIReh
 PkTmNtsITb85NQUzz8YD3vLHrTup1tFU/lNJlq/9qN1evf5fCXkfcy2cyWtIyCOr9dERAEJw6/
 nWSjNBnrjG312yVwQ162k9akBOe3QdVMYJISu8yKxijb0I+E29nwjvpoYs10dkZgQrfAvcu+Yt
 0WNN4xMATCv/FIkklayjX5rhNqvk2iW2uBx4KrCLZ+r2wTrxSOCdl+Zy29eWRFXi1A+QUcvDUA
 B0I=
WDCIronportException: Internal
Received: from b1j4fb3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.95])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jul 2021 06:12:33 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/3] fix argument type of bio_trim()
Date:   Thu,  8 Jul 2021 22:10:54 +0900
Message-Id: <20210708131057.259327-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function bio_trim has offset and size arguments that are declared as
int. But it actually expects sector value and the range of int is not
enough for bio->bi_iter.bi_size and bio_advance() which is/takes unsigned
int. So, let's fix the argument type of bio_trim() and its callers.

Patches 1 and 2 fix bio_trim() argument and its caller's argument.

Patch 3 is depending on patch 1 and 2 and do some cleanup for btrfs.

Chaitanya Kulkarni (2):
  block: fix arg type of bio_trim()
  btrfs: fix argument type of btrfs_bio_clone_partial()

Naohiro Aota (1):
  btrfs: drop unnecessary ASSERT from btrfs_submit_direct()

 block/bio.c          |  2 +-
 fs/btrfs/extent_io.c |  3 ++-
 fs/btrfs/extent_io.h |  3 ++-
 fs/btrfs/inode.c     | 12 ++++++++----
 include/linux/bio.h  |  2 +-
 5 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.32.0

