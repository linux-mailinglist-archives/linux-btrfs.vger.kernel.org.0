Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1636715EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jan 2023 09:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjARIQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Jan 2023 03:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjARIOp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Jan 2023 03:14:45 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2E4617C
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 23:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674027921; x=1705563921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ZcczTb9SvDtk/IvTr++eIdtO+FHPYiC6lDOjk6G/j4=;
  b=cWJ1hoHWc1uvGhO0B6bAjqxzNxOSIMTDLKWiLNFyvb+TYr86aRnFo3eK
   Z1c9mdj0ghsJ84Nbqupd7KFrg6Yg0zYxZ57LOvABoFkp13rBoDxULI17l
   a8mLpxUmkSKDkpCIxUyS4hd7RWjeahINNWltftoloXXy3f7alC9kpJgE+
   kwYAyKGsDonW4Yj5wthcZK2ynWLnIiON6hnXP8vSLU3hHB4gKnCeFCe1K
   zyhhidrhFbAsTTnLXhEgs4bDMFpFO35OrffkB/viiGiU9UFyoyab347fT
   H+RUSQAxiUGzqdhTc0UfBnUzqcllqmbnek914Takhai8pyCSU1m3ZBDlJ
   g==;
X-IronPort-AV: E=Sophos;i="5.97,224,1669046400"; 
   d="scan'208";a="333108006"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2023 15:45:13 +0800
IronPort-SDR: dnujUgabXZmwNSghG1FP++S/AvTRi88n4UqdGA/j3q9iUJyapTZY0sBiU3LlCZpKsjiPU7KaUl
 jqvSFYDZPgC5viz8FgO1VBZ9XBR6qUEGBqaX1P+Ty0j/SrpVl7i36C97lRhsPT9dLQ3yqxdLSp
 q4+YOmMrT0yYTVRlcruvL1mqYXykcAsN8r4OOKEw1xKzx4TRgzPzqNbsAjOqQzjcl0vfbW5Q4P
 clfxQm1zawPsbn7r6bBRgppZEtNgToB7IZ9tqZxLo2LVPnSRHlxUZy1q7jsu1W9OwLGnk2RtBP
 QUk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2023 23:02:54 -0800
IronPort-SDR: CeO9XqmE1mAa0WD0Mfc2m3MLkoCxJVGKw3OQcOM+h4W4lXu+alNgCtcB36Z+Xsju0Ay6qk4fbC
 WFeZncvw6ZCuOoPe6J9xW6GbV5JvJ64QfUPR4iY7pT5ztOSS6kSKm7z43KO7XWGG2QsJB8jC5U
 DWRY7nsdSIB0/x+Ru/6Gky2Ely4vXho+lkc5tHi7MQBSzFjmlccEexxGwkhtRmjwEIRR8MA56T
 UOmmlVHIfUZ+veKJn0CFWz2n7R9qz1DbrsjwW7/iMChphcVn+DgC9IqNmVdKjV/b7LalhkeOJh
 nXc=
WDCIronportException: Internal
Received: from f9rd9y2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.16])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2023 23:45:14 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/3] btrfs-progs: docs: fix nodesize typo
Date:   Wed, 18 Jan 2023 16:44:57 +0900
Message-Id: <20230118074458.2985005-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230118074458.2985005-1-naohiro.aota@wdc.com>
References: <20230118074458.2985005-1-naohiro.aota@wdc.com>
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

Fix the typo.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 Documentation/ch-sysfs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ch-sysfs.rst b/Documentation/ch-sysfs.rst
index 37fb49f945c7..569879aadf27 100644
--- a/Documentation/ch-sysfs.rst
+++ b/Documentation/ch-sysfs.rst
@@ -75,7 +75,7 @@ metadata_uuid
         Shows the metadata uuid of the mounted filesystem.
         Check `metadata_uuid` feature for more details.
 
-nodeisze
+nodesize
         (RO, since: 3.14)
 
         Show the nodesize of the mounted filesystem.
-- 
2.39.1

