Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AE864C21C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 03:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiLNCGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 21:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiLNCGW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 21:06:22 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0912229E
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 18:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670983581; x=1702519581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=og561ILO1CYtC88j2tZXoOLmJvIAYLyIVyCko41dHFQ=;
  b=N5Dqm5kzd1jeBiVJpDcPaeAS1aLcAOiSkBDuSC07+Tcy3N8tRzWnWgpC
   PIp0lkH7/SU7JfHhExfSCRS9Lcfq0f/ddqXLSFIBqBuqjASEWEOVpKXKa
   ThpWXN1Gx8FxJh9zGI6bCWRZXozL5Tp6Z1/Plh/D3DjC/4/orbSqk/gXW
   0FojDd5+ScqLPNpipEaFYUKh1meY+EAT1ghgmUeQwJUTilNx35/YXP8RB
   6LGxB1386OiEm0C5AmWN6+2nxD6SCD71RI5phtrwJea8QewNssTBqYzoS
   HZqzD6W1r48c+YSHtlPe9qzJ0R7QFRx1xy85DT4F3tgqr9M8gxMDF5CfZ
   w==;
X-IronPort-AV: E=Sophos;i="5.96,243,1665417600"; 
   d="scan'208";a="322955340"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2022 10:06:20 +0800
IronPort-SDR: yxCFWf02CWo0e9t7Ua2gBT71QfSepSuKAa0xr7sxoLWwDvz8TCRp2kTLXpvokZL1MLBwMfIREc
 HBQNNI37LCZ+ddQDfr+JFj3XwgJeMjWjUKpIg4+MmqDMiiHZWij+loy6mAo1YfHGoJWZ32Nt0l
 3J/c2Uzq3gzesOGe4DRNL62jG3BHWABvVl/DJfE5xsn7B2+ZBUjNHbl+truZyR3KA3mgduSbat
 h8sxcEK0W5FW1Xlrab3snY5xs1j7GocvjtMqx002fjpXMNF65wjyd0um2pcqq0J0T+QD2KrnH8
 MGg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2022 17:24:43 -0800
IronPort-SDR: Kt/b3sKEfc3JMu71wv5ZsjVdYLGLTojF/mwH2eZdj9GRz49Dko0MV09wrVwgY/ytjSVnujeYG0
 c9DtpBfGThRmWFVRI2TZfTfTxD55oxe01U61Ok5tma5nVLdp2RKmMJFpzeuTVYwcP1iQT7ewzy
 lvWtp4uFcVLZSgEn6ytxiuNao41ViE7CrrQMeolpSNcYQPKS8L+egCKiNGfRDKGxT/O0T8SgCT
 xbkLyUhwUDTZaXInhobJxd3ZsRFRjQg00rFSrMS+FKXAOGYvc1YV3mWYE8QOtjlQC9pfBX0XGu
 2gQ=
WDCIronportException: Internal
Received: from 8cn0l72.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.156])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2022 18:06:21 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: fix event name typo for FLUSH_DELAYED_REFS
Date:   Wed, 14 Dec 2022 11:06:07 +0900
Message-Id: <3e38a3af59c41e8533803e5a4baba5eef3028da3.1670983501.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.38.2
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

Fix a typo of printing FLUSH_DELAYED_REFS event in flush_space() as
FLUSH_ELAYED_REFS.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 include/trace/events/btrfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 0bce0b4ff2fa..6548b5b5aa60 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -98,7 +98,7 @@ struct raid56_bio_trace_info;
 	EM( FLUSH_DELALLOC_WAIT,	"FLUSH_DELALLOC_WAIT")		\
 	EM( FLUSH_DELALLOC_FULL,	"FLUSH_DELALLOC_FULL")		\
 	EM( FLUSH_DELAYED_REFS_NR,	"FLUSH_DELAYED_REFS_NR")	\
-	EM( FLUSH_DELAYED_REFS,		"FLUSH_ELAYED_REFS")		\
+	EM( FLUSH_DELAYED_REFS,		"FLUSH_DELAYED_REFS")		\
 	EM( ALLOC_CHUNK,		"ALLOC_CHUNK")			\
 	EM( ALLOC_CHUNK_FORCE,		"ALLOC_CHUNK_FORCE")		\
 	EM( RUN_DELAYED_IPUTS,		"RUN_DELAYED_IPUTS")		\
-- 
2.38.2

