Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8855389DBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhETGY5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:24:57 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61859 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhETGYu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621491810; x=1653027810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ugKcJvlfNiqoUdI+/DlV4MQi8pgvztPAB+J3qsQV8IE=;
  b=bYoYFRMVzStz3JxMmjz3JCGlJ0a4be5DXcEfnUu4BPRVKxUU852lpWIA
   YX36jg2Hv6k2MCrwbytA5h01/od+KCsFzKGgGjyflkjdGCVObOZxn24ex
   P76wo7iatlqW+U7u5Q6e69Tzdvg2H3bLQSiRqTmbpjpjvvhJKYeWEwBfZ
   Iv2lcfTJKuiQ55ETUKNmgfzIte2L97DeGgkekasRdOzA7ZcAJzac9NAg4
   GJEfoJ2IFTFDLLmS9LkZ5KIuawyJqz6PWOz3PQSKnw+6Po9MZ6VM60cFt
   +2cyFDBUYU/ppgJK25lfnVPMQkOsNR+2HDOxfta/NJvJ3Pgc7XLLkcSTb
   Q==;
IronPort-SDR: GsQ79uH2FwISeAGlmjikuJ5iAFJqU/nDm/g8DqL5sG8qRQUgVt3udhcx0ojjLtOU2A7sUMilV9
 1iBTIipxxuQfvISWTB8lsk2M7n9fSCTzhTtZkqDM9ENXSpL6VPZu7O5PDjheZAkdtNepluf6hP
 ssUvfcsc2sSsDBTqoVeDj1d7MBzuWaygaIf7ItYnRsu8CenTYIwoAjjHvFf9T4LdjrHJx0H/X2
 sIAqBpxKnYCUoAUz9bPbX2s8nk4FGzQE4Eyo/BYSsoKfdoB/B4Nge1slvfZ1Z23HO5mj9U5Bhb
 QF4=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="169351397"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:23:30 +0800
IronPort-SDR: 5rCQrQzRWjLV2aMvc8MkVkPTdTBer0KuxbCuiUQUoVLlIZ8voOuxyF9OJ6XJcCknuPwQzRuzNx
 YWEtciAXioFPfmuOgWiy7JL8kLRih1MgMPCtYAA2YvCDzxRNmA43Os8jmPaMri6YsER7sVNEwu
 /6mtrImf2lCXGZkKrIQXDyu4LQWSPMTiSJZKeSe5rYytZnDhMw1hCMldeiyTC5Urn0zO6gcFsL
 6yPHGj1TYja6Pv84SiBSIGKp+mIL8L5JJhrrIAEAynoF2ddx8rL482fNeZNmbHGh+ip3Bcs3Jz
 TMqIATCTcXLaBEzjrgX49Rx6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 23:01:53 -0700
IronPort-SDR: 2gpASq6aHVKtr34lYD39+FFamrfboRcYTtQ3+kOl3I++pUeKUc5dqm8Gr1iFHF/Eus+ba62pKn
 QetlT1G6mzLK+9/yZZmg0TETJPsLNDaF/NvDTwlp2jTDu54ApDUxvdbhbdebgsQj5Zl8M4cP8u
 leQAMrqZx+JcjUWceXNnhX48s7Busnyv2pUlEZbZklvv6e4P4VYdKYegaINJC74rhI0O3HM1Y3
 XbjEOn55WG2WQ6wPeLGcl+yN6OGQZTUSf9s8RL0fiu82gIiII3AeYGTe+dSUPrMJE8aJ4sg6NT
 ZKw=
WDCIronportException: Internal
Received: from wdsc_char_051.sc.wdc.com (HELO xfs.sc.wdc.com) ([10.4.170.150])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2021 23:23:30 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     axboe@kernel.dk, mb@lightnvm.io, martin.petersen@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 4/8] block: fix return type of bio_add_page()
Date:   Wed, 19 May 2021 23:22:51 -0700
Message-Id: <20210520062255.4908-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix bio_add_page() return type to unsigned int as it returns the
length which is of type unsigned int and not int.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c         | 4 ++--
 include/linux/bio.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index bc0e6e93ed58..346909d35bd1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -921,8 +921,8 @@ EXPORT_SYMBOL_GPL(__bio_add_page);
  *	Attempt to add page(s) to the bio_vec maplist. This will only fail
  *	if either bio->bi_vcnt == bio->bi_max_vecs or it's a cloned bio.
  */
-int bio_add_page(struct bio *bio, struct page *page,
-		 unsigned int len, unsigned int offset)
+unsigned int bio_add_page(struct bio *bio, struct page *page,
+			  unsigned int len, unsigned int offset)
 {
 	bool same_page = false;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 548d6a3342c3..f4f0b19b2ef3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -466,7 +466,8 @@ extern void bio_uninit(struct bio *);
 extern void bio_reset(struct bio *);
 void bio_chain(struct bio *, struct bio *);
 
-extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
+unsigned int bio_add_page(struct bio *, struct page *, unsigned int,
+			   unsigned int);
 unsigned int bio_add_pc_page(struct request_queue *, struct bio *,
 			     struct page *, unsigned int, unsigned int);
 unsigned int bio_add_zone_append_page(struct bio *bio, struct page *page,
-- 
2.24.0

