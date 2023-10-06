Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66FE7BB1D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 08:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjJFG6R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 02:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjJFG6N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 02:58:13 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CB4F0
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Oct 2023 23:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696575492; x=1728111492;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=m/Q2cSep3CDXOJ9BwJ9y3w4Upsncw3q0fFlT9JrH+JA=;
  b=WjfTKazifD++GSxVFQaG41Mpc/9CC0PNKojwDC9c5nDJkCmcYf4oMTDO
   oqNfc7MF8Ho8RtZDSB+hCrlcTNUl5GO9ZKrf8H3NBv6s71wR4/DQPtDFn
   OJD0MbagNzkWdJoaWlGHoIAoljvavjLK4VRz5nWDNmmTwjblGNLAkljTf
   XOu5KJkV5kvY0wpBDfur2eT2kci6b8/co4zaoXdFt7/sBgX/GG5fd4S+M
   YAYn9PKJLB1FiHyOX91dh1M8Z2Cbd415lTYYGwqfNbrQpZoAsCngKBUvA
   dToSkDYvraUg0Nys5rPikmLHNlztFawtRKKnXZwtA4IacxAZi3jivWCqO
   g==;
X-CSE-ConnectionGUID: GXdViT6UTNGywiJ0nTzD1Q==
X-CSE-MsgGUID: puXnHVpRSEKsvhCMsWiD5w==
X-IronPort-AV: E=Sophos;i="6.03,203,1694707200"; 
   d="scan'208";a="357918320"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2023 14:58:11 +0800
IronPort-SDR: j/qrVpeRWdogqWlDDUilEquqmWn/0EB+ZsxZ5SgJwuNGtQirvrLbWdNKn9tVlNDcYzughfgK/T
 QHfbCqiFy75ciEfFtXWp1qjTP581ZTbkv+oy/JGSBuszqyPhmDNZ9RZjUm8pTtiPS5zB3LLmO6
 Qj1YOjSzHFsLnO+z5FowKgtQItz8A6hqAABKx5E1JAeW4LmR3K7CpAZKs4QcMCYm4GWL0fAXtO
 SdkxSUPOVZpVh0C2c/IS/t2OXk7mbJt/wJMBFoVOwESAZRqHvDvqz4h+zOFfNMrmMhGyWMlYbM
 NVA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2023 23:04:46 -0700
IronPort-SDR: 44pLuc8ayBIeVMwhk0va02CdKFfrgoQ8I6SHmXQCXr+fBev03gqvAcjY1n60A5SwaUYdHclwwc
 XARcHaoy8oEHHBSlUdJ/283H+TXLMxfdHKf14DRU8Rso6BPJwUzsvVTzWFNbIo0wN3hn1RgeeH
 7Aisr6zANFv0x0y2NhPjS39HtlmWWzvi0Yudhs0uAQHaNk6TQ4kPPAgzZSuzQ3sZOxcKA/wyzT
 YWhAFgYezy3atkjx7cuSiQ/N/K25hYVLxWby1oxGy1PqUky24sUTggipZdAV7QnHsFZjzdROY+
 w28=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Oct 2023 23:58:12 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 05 Oct 2023 23:58:02 -0700
Subject: [PATCH 1/2] btrfs-progs: remove stride length from tree dump
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-rst-update-v1-1-7ea5b3c6ac61@wdc.com>
References: <20231005-rst-update-v1-0-7ea5b3c6ac61@wdc.com>
In-Reply-To: <20231005-rst-update-v1-0-7ea5b3c6ac61@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696575490; l=1131;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=m/Q2cSep3CDXOJ9BwJ9y3w4Upsncw3q0fFlT9JrH+JA=;
 b=rAC31xAW0gtJ3bNGY7MlRWXuy7M0Fhsr2bOy4V0mZGvpmaSNwlXXm4uiOMIW4BYc7IWyTze1U
 Bgf3K2jz4ECBj0uB4wXpZGpHpnyOsMZEMvATvLGtzGl3qtqSMf6hyeO
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

Fixes: ecd6fb44c172 ("btrfs-progs: add dump tree support for the raid stripe tree")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/print-tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 26524a13304c..7ec9035567f7 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -681,10 +681,9 @@ static void print_raid_stripe_key(struct extent_buffer *eb,
 
 	printf("\t\t\tencoding: %s\n", stripe_encoding_name(encoding));
 	for (int i = 0; i < num_stripes; i++)
-		printf("\t\t\tstripe %d devid %llu physical %llu length %llu\n", i,
+		printf("\t\t\tstripe %d devid %llu physical %llu\n", i,
 		       (unsigned long long)btrfs_raid_stride_devid_nr(eb, stripe, i),
-		       (unsigned long long)btrfs_raid_stride_offset_nr(eb, stripe, i),
-		       (unsigned long long)btrfs_raid_stride_length_nr(eb, stripe, i));
+		       (unsigned long long)btrfs_raid_stride_offset_nr(eb, stripe, i));
 }
 
 void print_key_type(FILE *stream, u64 objectid, u8 type)

-- 
2.41.0

