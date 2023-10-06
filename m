Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B707BB1D2
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjJFG6O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 02:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjJFG6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 02:58:12 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE5F4
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Oct 2023 23:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696575491; x=1728111491;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=RuGxYs7N37nfVkF0bzVPcYwWcqTxWXLFalHfpyqNz1A=;
  b=j6e/yjOvVwtigLZykr3dntJiU6owEuWK0rUjvhdzKy/HDpoWhmNNT8lK
   Pa/QLEHdRURu1nOtxphhtwFxS5f/Aja+losw+A9jy0aKnKYBzxyYyams2
   I3BZKHX1ZxKc50uczMtSxUL2elvg2D7mH5Mcw2NlCbIJNHJOeCrgBVqtP
   ybjKIF/TYaDD+0/twDzXm/onc6NY2Qpe9PTDYUxSnXosGQMbI3Yq/hG1G
   a/abxUhHHNdzIwSiEcqb353oqkdLnSVen6C2etlPE6JIkXZ6ZE1wfxGq5
   Ybmn3/Sw7lKogH1eb5DitASwOkVSmxaFy8XbjKbijR8uyet14GjSntBhp
   A==;
X-CSE-ConnectionGUID: aiJ3UjMtSVSwXxXM044igw==
X-CSE-MsgGUID: MGmTfFCkRzuZ8epmcuRbGg==
X-IronPort-AV: E=Sophos;i="6.03,203,1694707200"; 
   d="scan'208";a="357918319"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2023 14:58:10 +0800
IronPort-SDR: pt0hZFHb8p4nn+DloZOeB7Ese1cAy0dpuwwAoKB2cwzqYmiLcThV5UIpY3DHxpwrK3dxotEIAc
 gW+ni4k7L+VwwSIqvZnj/Zs5P4BODJknFe51KqD7ksfDyOXMkhe0iRT2V8t0h0R1nF14BT7+oW
 jtc/koIZc/ShtVVVymnBcsQFDKkxKTtXClU5rst0vLhIeNh1gtRM/nFxGwtqZiaSO6MwiMYCOz
 m1Nv+FUjOOTZLFpbQIjtFb+uxwkuOkBRsTqRyOc85wciJWGFBDrzIYX4h500dtCF/isslsPpFm
 rfA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2023 23:04:45 -0700
IronPort-SDR: /mYfvJ/o4KGD5oQhDBoWtNb7i/iS9N6nEJTCaa+koQYdg+I3ePOxjjUNclaaTjyNc+mwJYylyP
 nsTgBr1O+FkskcfghiGV+WXG0qptuVYr6Ro98+49eJXroVvyUN0ld+VAMhmEwpEc0nHVIdlTpq
 o5yLEtMLR2Yzql+ODYvHpbE4RCvv51BS5+GcL323DAodf0rDRF0ALLimBCvmwXJu2BbOVjcFqi
 apY44J0VpYgdxvJZ1ekXRjG3VaStSh/SgCF99cz3tS/oQOCD3mfO1efwfK/0/lmLLne/51aDl2
 etM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Oct 2023 23:58:11 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] btrfs-progs: update on-disk format for
 raid-stripe-tree
Date:   Thu, 05 Oct 2023 23:58:01 -0700
Message-Id: <20231005-rst-update-v1-0-7ea5b3c6ac61@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPmvH2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwNT3aLiEt3SgpTEklRdc+MkQzNLQ7PE5GQLJaCGgqLUtMwKsGHRsbW
 1AIPZDs1cAAAA
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696575490; l=616;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=RuGxYs7N37nfVkF0bzVPcYwWcqTxWXLFalHfpyqNz1A=;
 b=KUNwdgh6n5bNKs5szVErhBrfzr7wmB9km4y6GJDM8ktGfx4suMuxt5Iza3pSJOPLlM4bci5N6
 PG3MklDYg3SCYr3h4xx6slizil0pLPj9UbFwykqQnZW7oWZINtrcEAn
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series brings the RAID stripe tree on-disk format in btrfs-progs to
the same level as the kernel.

---
Johannes Thumshirn (2):
      btrfs-progs: remove stride length from tree dump
      btrfs-progs: remove stride length from on-disk format

 kernel-shared/accessors.h       | 8 --------
 kernel-shared/print-tree.c      | 5 ++---
 kernel-shared/uapi/btrfs_tree.h | 2 --
 3 files changed, 2 insertions(+), 13 deletions(-)
---
base-commit: da936ca80c5e46a671f513017808395223c12cea
change-id: 20231005-rst-update-73b16916acc8

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>

