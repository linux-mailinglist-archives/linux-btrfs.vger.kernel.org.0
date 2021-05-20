Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F93C389DC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhETGZG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:25:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49767 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhETGZF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621491823; x=1653027823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nunN5GuIXk2/nPGEVYLemF8EPjrWl2/O0LwMGNtljJw=;
  b=rEc9Li+VgELl96EI5reW0hHGroT/VS7veo1ijXxqO6ggrkFFMmvleXI8
   s4nM5A46I/L9BV3fGMTrd4dvNHDBoNAs0BXJMTCZe5Q6wQX/QpSear6/V
   4v+qq4DlLBjYOszMJotesUX6Qh0hE6Umc++Qh6PD6rUUydi6MyLALXOkj
   R1vZc0bPAcUTANt6CHGXtnWK4UCYUTl69E7/gaBgN1ls2g76m3uS+cZne
   5/ShZxWg+6d6qZjyyznaMrX9LCXlFyOcdSzi01YdOLhSEOdBaFeLvkstA
   Dyw8Rt4grdUDfaI0h5/BtnVhM+Ff+bmYaAKrnxQ/97AjKd6+QTA0T79e6
   g==;
IronPort-SDR: ct989G6QH2C5mnGGK5U5eMYjbXwpBuLvnuFy/OgBvz/0un9BaaOOuOsEavssSKR2jwk0uasxHQ
 KdSwlYIhy66SvB833KpY7RGT4sXHRHzs7wRTAjTbP0CxFPuGefgjQ/Vobl783VhomdggEZ9l8b
 xxQUgnOu2ABqND7gE/SuuFuBbOfP3MkKKZr7qE8W3ULztxNws2UxedOuukK6woeANDwuCbrCpp
 bmkC6HqifRZzYwCpTTgJ9RXdwF1Hlzu36WZj2q7/q8mO/y/q+XnXnCeO3kBD3xmPgxsMVbm8UB
 6w0=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="173440022"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:23:43 +0800
IronPort-SDR: LZPRcBGMSn7/kqP4TXPZv3IIDtRx74xKRNzCY10hdQp04TAudw207Cj/AgrfQC6iC9aei6Tq3E
 jgrrQ1gDq/GM/lhWjQkI5Y376LBuzpGzwCNOWzbR+3kMDE9mrvEemks5V9o5HgwWsJ3vYlTYfu
 FgSAQHfx7EucIXmFm3lbsNAY/MtsYE7RncPu4crvX8TGAaBfrHRIGKKpqKPuYr8gqHZzfj5dLo
 AS88r6B4LVl1AwpHFEDvHhzHl5xmiXmimRVKWs80umYwh9Fiucwyg1w1PFkRrbWVzLP8mnqkE0
 Gzy/jA8LXlC+zykicH8inway
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 23:02:07 -0700
IronPort-SDR: 39eVPLeTzO7M1jRrv2fjtvBFbFInN87TrFZNaIgYYBQoB9QFQDDBNMUve37lroxhpPmmn1P8nS
 Nzs6OuQHq28fFMYnm7jkFT138naHWeBXJDLQtKC4DL6DqW3Gyl7A6ec6/2ykRlIejJn5mD96R0
 h+MkqQxY817SwkanlHxWCT458/UYXXBHr8uVBiCZ9N+m95hAFC+j49dEg0PgLU6J4b3pjGbCcq
 ViAOBc0H5D0mdL3O9VUpmgGuvUKEJ6XQ4wRao+9SzTPe8pfKEzw0F9f95W8/1fa4onJbQmtXZ5
 Frc=
WDCIronportException: Internal
Received: from wdsc_char_051.sc.wdc.com (HELO xfs.sc.wdc.com) ([10.4.170.150])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2021 23:23:44 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     axboe@kernel.dk, mb@lightnvm.io, martin.petersen@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 6/8] pscsi: fix variable type pscsi_map_sg
Date:   Wed, 19 May 2021 23:22:53 -0700
Message-Id: <20210520062255.4908-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use ret variable of type unsigned int since bio_add_pc_page() now
returns unsigned int.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/target/target_core_pscsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index f2a11414366d..6087661a482a 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -875,6 +875,8 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 			goto fail;
 
 		if (len > 0 && data_len > 0) {
+			unsigned int ret;
+
 			bytes = min_t(unsigned int, len, PAGE_SIZE - off);
 			bytes = min(bytes, data_len);
 
@@ -900,11 +902,11 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 				" bio: %p page: %p len: %d off: %d\n", i, bio,
 				page, len, off);
 
-			rc = bio_add_pc_page(pdv->pdv_sd->request_queue,
+			ret = bio_add_pc_page(pdv->pdv_sd->request_queue,
 					bio, page, bytes, off);
 			pr_debug("PSCSI: bio->bi_vcnt: %d nr_vecs: %d\n",
 				bio_segments(bio), nr_vecs);
-			if (rc != bytes) {
+			if (ret != bytes) {
 				pr_debug("PSCSI: Reached bio->bi_vcnt max:"
 					" %d i: %d bio: %p, allocating another"
 					" bio\n", bio->bi_vcnt, i, bio);
-- 
2.24.0

