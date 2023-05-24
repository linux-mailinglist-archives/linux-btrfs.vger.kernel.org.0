Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150A270F9A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbjEXPDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjEXPDl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601F41A4
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xaJ6trrdV0emBXqzsFMhd4vcEU1j6SfcTyjphDpt/Lg=; b=pyBQMc8sCE2X5/m19D9tP1GZna
        BAjWzMgI6aUDH+u85O8uK2RFXjYQguqs1L6RwQM2r9rGYEKyMqwr7TFWtyETQSfxjmvnYYuHIjvil
        3cPaNoVlz10+O35udFrso9r0AIrWvbcskl2mluI+zICbzFmrBhVVZrxevBIFE64cYxCibZGcIndjr
        lpy+dhqjNfrMGGFqEqoRUTKPsM0dCOwkh9QPHtVM/zjxLMKrQDJgbAwOiKTgKohfUXatc71uPFR9N
        4NKsi0J5TNYG1z1PESil9UherFPF1J83iz00LpM1fA6yoTlLgG26gcsCTpt1rG38LxjhZ6L8tfJWK
        f4+aVYRQ==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1S-00Dmay-15;
        Wed, 24 May 2023 15:03:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 03/14] btrfs: mark the len field in struct btrfs_ordered_sum as unsigned
Date:   Wed, 24 May 2023 17:03:06 +0200
Message-Id: <20230524150317.1767981-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524150317.1767981-1-hch@lst.de>
References: <20230524150317.1767981-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

len can't ever be negative, so mark it as an u32 instead of int.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ordered-data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index f0f1138d23c331..2e54820a5e6ff7 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -20,7 +20,7 @@ struct btrfs_ordered_sum {
 	/*
 	 * this is the length in bytes covered by the sums array below.
 	 */
-	int len;
+	u32 len;
 	struct list_head list;
 	/* last field is a variable length array of csums */
 	u8 sums[];
-- 
2.39.2

