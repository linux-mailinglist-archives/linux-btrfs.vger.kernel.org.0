Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556173E9392
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhHKOVf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64262 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhHKOV2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691664; x=1660227664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IXGcHTvcO8/97MMlcg6RC9p5lmMrS0EvWusxl5o2mPo=;
  b=RodUagJlVrx5D5cENy9LMEp7YcQYsAkVx6eQMN2Qq2zS7oTrUGk/q7TL
   KK3Z83V06CbaC7n4QcLyQmRKt3xFVXckSrIhJe7jcMnZAKnfgcRim9qrG
   kADk/IRR5IN+NgUJTFIUJOnJ1aAzp8jMJa1Bc5tJOfIhPuA2Nr0RjIygA
   AdUDy9YgC9Bp50ZmWN+6U7gUcTMakMiLqKngrMphSRk5VYm1JthFhLuR8
   WFj5iV/JW+9T8Gy19U/wxLWhCdAoCc2uVMn+3pWwRm+NBmpwjhCRmZCF/
   7NkULO3t9wISaY+PpTH6pHNWZdpsd3x6ocpijv8erZuZ3HXk6DmPgJ4QD
   A==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="288506686"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:21:04 +0800
IronPort-SDR: zqmdcPOKnagUIrzbkniSCvNZlmsYy4dfopJ4NR7duF50Nc+CKa9j0lP6U19p+jqsFjHXgpN3r4
 9y9+y/ujeNCtBg/hux2EVbzE9aLsHg4BZhrN7p27JqsPV21tuIQBHqkSm58iOurGbBBegSCdPT
 8iM1faf480dXc8jJBxvXNY/deiECmh9ntaKQOJxyW3x90m7Mq2mAV/y4nIDQpDV+rBm3etp4PY
 /ciG3SqAG7OFnYByH4L46naXm0zLgiIxlLGWeqwuYkGIL8/hBMwZ86qjqJEx60iHJ7ZHU2Q3Xs
 m8VuIlq7wVfm6mMMSrz0MGBl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:34 -0700
IronPort-SDR: sdwbAEqzWLXkmuiau7TrmMwCpVKn+Cjb1m+gdUymCvtVQ4XURUhIzf8rCQnbtmMjBj5u5NGNtA
 IL5svIeUsKEmABwqOh1o6ZFwXNm+VuqR/LmLcb5ZlrGBo3W1PCocgUQR3PcPWgPI6cgYt7yYNc
 RTpuxF4xtjeYUOWrlEgatE0hF5/U5v6gZyF33ndNPSVelM1+yUt4B29Eck6NPAMmucJRckFBUn
 1Ioa72zEtz2/hzmDlku1STj5coW+/+FLr+LFj7Frk/jQXvugY45slIagCDYyLwTPKzKT9cPRyO
 qy8=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:21:03 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 17/17] btrfs: zoned: finish relocating block group
Date:   Wed, 11 Aug 2021 23:16:41 +0900
Message-Id: <0abc5803aae3b4be8fdb3c74d7c4e9b4199b0257.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will no longer write to a relocating block group. So, we can finish it
now.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 914d403b4415..63d2b22cf438 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -25,6 +25,7 @@
 #include "backref.h"
 #include "misc.h"
 #include "subpage.h"
+#include "zoned.h"
 
 /*
  * Relocation overview
@@ -4063,6 +4064,9 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 				 rc->block_group->start,
 				 rc->block_group->length);
 
+	ret = btrfs_zone_finish(rc->block_group);
+	WARN_ON(ret && ret != -EAGAIN);
+
 	while (1) {
 		int finishes_stage;
 
-- 
2.32.0

