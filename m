Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5194C6A0D31
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 16:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjBWPko (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 10:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjBWPkm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 10:40:42 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A528F2682;
        Thu, 23 Feb 2023 07:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677166841; x=1708702841;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ur/MJkS7JUV50Q5xJhSxKI4nYo/2kHuoXnRIEl5eQ/o=;
  b=bOIc2mc0TJTs8g8GKhpToGklmnC5ZTWhbJ/hLOs8POTGLaREMkmWOe+k
   NyY+uvEg/TtfZLH7oktoj52Us8/k3U0iqakw/W0Oe9Bl12o4zUqVZvYPP
   QnvEUhBs6kZyn24eedCi/h/uoDI2KvZrWmi1eVF7mJ/pA2fIHh2YIKRf+
   cPkb+ddCA/WBmNjO8xH/NfMhkiPRMqPcZCtCezrIX8QOF0P02KrHiaCNg
   erNdA/7PUhYrbkJG1kmOaNi0vJ3xpg+qweR6Q5vZeMjtwXxjUZ3Xi0Zhl
   A5XcCr8zX+YaUbG1U44mVoo1vCqbdoxvw7ZCaRWxhQDmiHFbaes1GdPOP
   w==;
X-IronPort-AV: E=Sophos;i="5.97,322,1669046400"; 
   d="scan'208";a="328317303"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2023 23:40:40 +0800
IronPort-SDR: 4Mu+2sw0/3eQt61moducgNO183jD8So5xFvSU6lou/1y9oIHj0Qd7zauug2ZTuxDXhhhd+CJYO
 1LDsURaa9ML/1qcBYPHEezkczGOqLuZXExyvoUGPUB1tyYcDj9hNC7lVPT96z4OtA+5axVBf5S
 fe7Nm1JsNvFwMl1KLpYX7pQx0wAoykWa3KQ5LuYvEmE21qDSdI2Ka8QQJxSDhUhBNkdIYbStTo
 xRwez/mntmN+D6oK9IrdcN3VaTL5KJgbQdUnmPinrFePGASPVfMG2ZLEsXk+OT5jhWnpUD/f3L
 1DM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2023 06:51:52 -0800
IronPort-SDR: 5N3gMzm76ltRKzCS5Fgw8oYzezzDt9TJMgqqNlv10xcvrknTe/iwIrKhZF1edmMk2mUrCoB1+E
 q9ecjYinGP3gTwYJDGiHKb8A11zu+E7HZAwVp8/odnp62xFuERfpncs94rb69BxwTFKvGRy/W/
 98xUVLptCv1X0ffB/5C7GI7BfN0t28FUqbBQcV3NdQ/1EpGnKiQSVe23zhic/nnn4kxUV0IjRu
 f652cuqH7xXAgcly36MjYYEwNFftZeZ2ZYiyzQFgt0IvCRx9T0YgrJ/DfAtv12yGKAmiRKHGzh
 WaE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Feb 2023 07:40:39 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] common/rc: don't clear superblock for zoned scratch pools
Date:   Thu, 23 Feb 2023 07:40:35 -0800
Message-Id: <20230223154035.296702-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
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

_require_scratch_dev_pool() zeros the first 100 sectors of each device to
clear eventual remains of older filesystems.

On zoned devices this creates all sorts of problems, so just skip the
clearing there.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/rc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 654730b21ead..d763501be2b2 100644
--- a/common/rc
+++ b/common/rc
@@ -3461,7 +3461,9 @@ _require_scratch_dev_pool()
 		fi
 		# to help better debug when something fails, we remove
 		# traces of previous btrfs FS on the dev.
-		dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
+		if [ "`_zone_type "$i"`" = "none" ]; then
+			dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
+		fi
 	done
 }
 
-- 
2.39.1

