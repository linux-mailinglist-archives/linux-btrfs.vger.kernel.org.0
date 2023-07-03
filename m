Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E50745B85
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGCLsO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjGCLsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 07:48:12 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CD4E60
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 04:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688384890; x=1719920890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VimJY5WyZJKQ02864vxrvzHx8mKTUfAedA0XVmVGdPc=;
  b=K8hDJ+r8lBjCGFMMrXkWfohBSb572MYet1IhfvCSfFm2cejKMErCV2dJ
   vF6PdhLVLuwWoLf15dqrL5DGhCWT8Jx+11aL9xMNZ+x6z5g2mqDKC5w6E
   tNTX58gEXm3Aq9/9hJ2byV/Nq0oV0wmfOKekqgg1V6mmoqu1BooX0zOy6
   72sI+GsraCHhL4TzUnC54bLqNf0NZ94gHHcFahBKrMV4Rw+uEIXG1CRvL
   41EHDEgIx+g0vJmY3l9scPrfKbgwW8BaZLDEHVohaGsIaNPNKO9UmSmY+
   b6Nk9U8H/LBMsISRtU1aDk5h458yL1RIc57zeOHLmxtHf8OkpeM0n4Ohr
   A==;
X-IronPort-AV: E=Sophos;i="6.01,178,1684771200"; 
   d="scan'208";a="348976222"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2023 19:48:09 +0800
IronPort-SDR: dstnLybZ+rrR3wcG5WqaV567DM7eGHx12gFnD769Sto1vBfzUci5jmXfSdxKf+3yF+G8SroxoP
 1TNWgGgrqhz2UWHCsaLDBRNqj1AncVhAhIAXajAcpz0Mb1HBdZkXbXhhdzqMw0RQu2K1In0vmW
 qEVSkNf2VFlAV74gn32jgXpaAfPRUUlQDAPIElIbI3fpbS1ChCL8z03/7v/FERMGTerENLY6A0
 FiMYiqt1PoPmhpv2NP1LSPLbNWUlPofc5Hx3qekjjHUaNhEQDQN/PNnN79Yze1FrcxiRXO4MEz
 tAg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2023 04:02:22 -0700
IronPort-SDR: 7Xah3XJcdLjXFi3LDdw9CWlpV5o0N0qDFjTIvNbp6thoeHKM66UD4h0RNYHd+uZP+CFhoVZ15G
 Ltae/I7CRF60lqi8hR9vj15Xw+BdIXn3MP6PtRNbeI0jmjOaWvJiHAxdsLTJn6rPSn92aUAGx5
 Yo1eHmIZEdoM7PIBnHJRdNsUBNfU6CHzyr8pVw4u9Ppd/GXuYvz8VNfc92rP4Qtd8kIgjNL2J8
 LOXVyktey7qiSkoLIp5INMYetVLJBsCiWLOqL1qQZdz7rGznGDDDKP6wfy+q2eBqRE7jaWcVBq
 fiY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Jul 2023 04:48:09 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH] btrfs: zoned: don't read beyond write pointer for scrub
Date:   Mon,  3 Jul 2023 04:47:51 -0700
Message-ID: <51dc3cd7d8e7d77fb95277f35030165d8e12c8bd.1688384570.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.41.0
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

As an optimization scrub_simple_mirror() performs reads in 64k chunks, if
at least one block of this chunk is has an extent allocated to it.

For zoned devices, this can lead to a read beyond the zone's write
pointer. But as there can't be any data beyond the write pointer, there's
no point in reading from it.

Cc: Qu Wenruo <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
While this is only a marginal optimization for the current code, it will
become necessary for RAID on zoned drives using the RAID strip tree.
---
 fs/btrfs/scrub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 38c103f13fd5..250317da1730 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2060,13 +2060,19 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 	int ret = 0;
 
 	while (cur_logical < bg->start + bg->length) {
+		u64 length = BTRFS_STRIPE_LEN;
+
+		if (btrfs_is_zoned(bg->fs_info) &&
+		    cur_logical + BTRFS_STRIPE_LEN > bg->alloc_offset) {
+			length = bg->alloc_offset - cur_logical;
+		}
 		/*
 		 * Inside each stripe, RAID0 is just SINGLE, and RAID10 is
 		 * just RAID1, so we can reuse scrub_simple_mirror() to scrub
 		 * this stripe.
 		 */
 		ret = scrub_simple_mirror(sctx, bg, map, cur_logical,
-					  BTRFS_STRIPE_LEN, device, cur_physical,
+					  length, device, cur_physical,
 					  mirror_num);
 		if (ret)
 			return ret;
-- 
2.41.0

