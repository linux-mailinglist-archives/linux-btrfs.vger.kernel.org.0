Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9027F4CF914
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 11:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbiCGKDf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 05:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiCGKBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 05:01:09 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E633586C
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 01:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646646632; x=1678182632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HZXaSs1np+0D0yvx/YMqWdoDDkWbpc/4484h4orerts=;
  b=qnb9cTyfMgvM2IMQkTPsIsuLhkceGYvuZw9sJklYyKQpIfDHXiX0q2wr
   7TCLEDZWviL08P4+myyRLKzZDijmfEr69iHxxHvcerKfsxkdW2mnC0KhL
   0J7y6Pjk7BFbN7a/B/rtJ9gWdRSlWc41qW+F8yxQVO3b7dZwqyYH6RIL1
   0cu9P9f6Rz3Ol5USsnjLeOv3YcBXb+ofYllKDGwr+yzIRKNFrBoH/Yr0J
   hpu+1f9uFUqk4eYH7TyUEzSjd4eGk3wWwPl7a95bTv3UlTI/FUkU44Aun
   /0l1t5iIGrZHMTlz++38v9iuZnyk4GPu/MyN0d2EaRNSazPerDoR8PJC7
   g==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643644800"; 
   d="scan'208";a="195612173"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 17:50:31 +0800
IronPort-SDR: uO+hwna3kCmryA3f9dUbZ+f2KmGZYQVFxd+7CtAty8oDsP3S/I1D24IQ8Q9cBJ10N2D0MiT6Nl
 J8SqEG3fR8tagO9zmVImK2THuvgQGGUYKcoZFw1j1lNPtgI9GoJeJFyGMEhFy9ywF1o8V+ORgi
 aq/ePs9gXz2BJW5hnAdEHuBO7fECOnzphYQP0ou745Jjth5o0g+Rw3k+pxtkfme2QnxevtFOmn
 JSxUM1B8CWDm40OJEoNOFvKvx+blHzj7dY40nSnsK1Zl9cfz5Y+P/sE13i3YwOePnzfrz0rWwF
 gIh0+oMp6DAvM1bMUp1g1mAe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:21:48 -0800
IronPort-SDR: csXyvShkxg3bEvIGi7OTd0mQtNAt7mW0duwkeJmJ86fxalLVGGaEKyqVnZKiUZSSngtOUqJ4c0
 zwYfnugHB9Tnf+ynzEfDWRAP/jrAonbPL4GsJzokJoaBnmkyyNmECq958ILyw+iy1tvizZlDdA
 Zpc43V0oXvVm+zHpi54LJ5A1yKR59TWkEoJSNKIIlAhbvosNVFpaWh97WCPu5gz6fV56vxwHjW
 4rkA6jEZHmXQ4mQipYeH7nDtmZ4Z7k8KtRCxMaS6jaMCzU8BzOeMBxbRzrmXdF9E3u1jJ3gfcH
 BAg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Mar 2022 01:50:31 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: zoned: two independent fixes for zoned btrfs
Date:   Mon,  7 Mar 2022 01:50:23 -0800
Message-Id: <cover.1646646324.git.johannes.thumshirn@wdc.com>
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

Two small and independent fixes for problems found while debugging other
issues on zoned btrfs.

The first one is a possible deadlock and the second one is for removing
leftover ASSERT()s.

Johannes Thumshirn (2):
  btrfs: zoned: use rcu list in btrfs_can_activate_zone
  btrfs: zoned: remove left over ASSERT()

 fs/btrfs/zoned.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

-- 
2.35.1

