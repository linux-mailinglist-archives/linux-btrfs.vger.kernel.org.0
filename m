Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09D9389DC0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhETGZA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:25:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63125 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhETGY6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621491816; x=1653027816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z5s+Hmzhk3z6KlToDBDWKR0Qgoub7jNFJttF+UEbzfE=;
  b=Po/x96R+i0Y5SFBfpyGzUzTtYPA0r2GBcOQFShsa5ZLjWPVyh8hnNYpw
   mN+bYBywpElNCL7B/7MY2KIuey7ogxLuLzRnZAJSKWQ2ADJ0A7w8lG4Ya
   3qP9AW5uUrx4kUS2eIPNNoXUMLMvQHmQpULZddnWayuQr+jZP+JzZUvrY
   3n2pbnCMPdjUVreMIo4UTSZ3G/mzLSjrLiF2zV0HgLvZ1Pv3F5okVtWc4
   necOm+b6tzf0Vo3CT3X3bzXjNoUFY3eiH+MtAgLZAhmXxiCOxkJmF+zvC
   ACmnYezc7cO01bQQO7cC59oczfoFrDMV4NUsH4ZT406OGzzo2nSdpoC+c
   g==;
IronPort-SDR: Zyvo+li0Fd/p4wHhIT6WkIiF01TiNFqpiFTvLrDYlHU4ruBDLAHStF6lEHofkncgUxJbEMDmOE
 Gili6MG59toWMGiehiX0WWLztfpuGAgNKmACoQF1cbFfD1XJHPfp0LlQAN51+waUCL8gBMZGyr
 j+UDj5PSstj4JZmpMt0PVVvjWyRRupY9yX8miO/QLz3bn7zvAfsFvq6t5yOQw2nqRRsoFd83yY
 /luYtXpKzxUu+wMpKSZK3lBfHqiHzSta6d3IU7zWJmIlBIStxRQWJiFlN5UgnVyOVzGDP3hK2h
 giI=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168807085"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:23:35 +0800
IronPort-SDR: 0ycruDCXbFDWlsaamfEJaEUR6mmdh7MIKR4FaenQf5DzKXdIwF9aNYMnTgIY8K9xhV9rPJY7fj
 ipX/VTi11J95j3wR+j8dYLw7pZjokT0KS4GvFITVcR9MHrW1Y4Oo+MBlU6b/qBq/H4riaYb91M
 mdxmTF6pNK/lbM0Rn2MoZgvfC9/UQDwlpH0Yw/b6NSAOrLqb+QNaj80FFzXSmRHGGYKYTLF5tk
 Y/AkYr1ZPqoTpe3F0xKUHvw/+0GH6uPRPFX5A8Xs6LXg4p6Mb/WtxfgSiKXMQpmKSN78Y5a3sH
 z5bjh1RUw9S4tdiOYe32z+ud
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 23:02:01 -0700
IronPort-SDR: Vr5iW+u4XcvU/kH+bU4Cy8srqZizJ4D0AqA4oRm+Chn2jkmp11J7KZSpzJYd07W0Be74GNOKPI
 beeH8VOTwyZghuV65zQPrzC+jGK8HRapZXJnjsFR2kGpT4xR7bw5UKWjsHMii2FYQNt/l7t7cj
 DGJ4zxO2H4Z0JSxdg9Vv2rLUC/0A+q2QrloAsy6hl5+GHZm/7q0Fkf6xGNzDQYn8ox8NF/zyOj
 plZu/NrKYrC45MOh9jqtCuufWnIrUn/L5jUEL/7l4lpo2RZvpi4P/uk7/c7r9fNa6mapCQp0EW
 kXk=
WDCIronportException: Internal
Received: from wdsc_char_051.sc.wdc.com (HELO xfs.sc.wdc.com) ([10.4.170.150])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2021 23:23:37 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     axboe@kernel.dk, mb@lightnvm.io, martin.petersen@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 5/8] lightnvm: fix variable type pblk-core
Date:   Wed, 19 May 2021 23:22:52 -0700
Message-Id: <20210520062255.4908-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make variable ret unsigned int since bio_add_pc_page() now returns
unsigned int.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/lightnvm/pblk-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 33d39d3dd343..cf148cee99a1 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -341,7 +341,8 @@ int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 {
 	struct request_queue *q = pblk->dev->q;
 	struct page *page;
-	int i, ret;
+	unsigned int ret;
+	int i;
 
 	for (i = 0; i < nr_pages; i++) {
 		page = mempool_alloc(&pblk->page_bio_pool, flags);
-- 
2.24.0

