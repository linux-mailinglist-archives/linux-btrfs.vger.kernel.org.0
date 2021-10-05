Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15046421ED0
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 08:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhJEGZY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 02:25:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61147 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhJEGZU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 02:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633415010; x=1664951010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O9+wBmea7KVoNCvNn4QTRtHx3+jF1SBvnLQ97OVdusI=;
  b=PDTZxy/cAMLD1ze9Mp69rjfQW37oFafsyTVRdloH1W/VLRZx2JQLCLiw
   Sw9wPqTdovY8ZSRfIlRaKiomOdEAKrT+EneRs4ghoHRSiOGdhnsYFtyVU
   WBrA/plyc3iI3F9w8CzEsqXMdMnvAt/IiwwRGhUghkyhTYgeoDckFwlhw
   nU7WupIHdReeFuCptbTHQgltUdbcUQYu2jXCwFFigHe55/3ImjQSp0jwy
   tACqJEqP4t3R5hplSZ0dLwnjZAllgbZTCfyvSyAR3mqb1uq1AgiAFwn7L
   HPDzXOVhR2w1KIPWzJRmMXFHLKVrk0OxZWVFNOru1gPEN2ba/xwOmGDyR
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,347,1624291200"; 
   d="scan'208";a="186648914"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2021 14:23:30 +0800
IronPort-SDR: DjODtX1FDTaOSnmHrYLaXSJAzDm24TunhwQnQLHB2vwoxI0uUpaelVe7GwtGXgi+PgLM92IIYU
 FdXH5sJiu8R2ENdTsUFBOKaAYu6kSiOSZVO1muyXuivjXYvLReVwVYPsxmed2H3wS8bQbd9BBw
 n467fZhT9sFpg7xcZUeI8Sq5pvw3b9D6Iu0mV8RdBgT9kk2ceXFNxR1qJ2CcWL5V/VWwdaK7mW
 zkNWZD+wiKA9HDixDsNIn2Fxi/MoiEJtGC049JLScnnug33Qkd4jafHNOkVy9W8gLNDUAVWhSZ
 tZ/GUqg74f2zu3rwIJsRldzf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 22:57:54 -0700
IronPort-SDR: k9AwSUKoyXfKgZLQV4Zpe8husFuLdtcy3aYhjOuxLTlUZv6kyFskaLazH3hcFVFbTh1x+ROCu6
 cwKqB7ZqnxgZ4PEvoWxQSvQ+uYQBtlG2CJPsWai8nAOIVRRFsQmCDkOkFrmHggd6Ka1QHgutgb
 9pOOf7BKFh12GEzMTFaITUGDa2DQkrjIeS1KiLNLPjaZ9In188sQmIcwdObW1HMslUNG8nlu+A
 L0uW5WPexQ6qJ4qK/6a9z6PXID9YUIuB6lpybbPLq6q5kmLnZvUs8/ew6KV1+fD0eG8ekoGLmG
 Vog=
WDCIronportException: Internal
Received: from g8961f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.178])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2021 23:23:30 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/7] btrfs-progs: drop ZONED flag from BTRFS_CONVERT_ALLOWED_FEATURES
Date:   Tue,  5 Oct 2021 15:23:01 +0900
Message-Id: <20211005062305.549871-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005062305.549871-1-naohiro.aota@wdc.com>
References: <20211005062305.549871-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we cannot create ext*/reiserfs on a zoned device, it is useless to
allow ZONED feature when converting a file system. Drop ZONED flag from
BTRFS_CONVERT_ALLOWED_FEATURES.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/fsfeatures.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 163588e52933..9e39c667b900 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -39,8 +39,7 @@
 	| BTRFS_FEATURE_INCOMPAT_BIG_METADATA			\
 	| BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF			\
 	| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA		\
-	| BTRFS_FEATURE_INCOMPAT_NO_HOLES			\
-	| BTRFS_FEATURE_INCOMPAT_ZONED)
+	| BTRFS_FEATURE_INCOMPAT_NO_HOLES)
 
 #define BTRFS_FEATURE_LIST_ALL		(1ULL << 63)
 
-- 
2.33.0

