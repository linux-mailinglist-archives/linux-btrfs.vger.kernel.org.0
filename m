Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8768FFBA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 06:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjBIFOM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 00:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBIFOL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 00:14:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA12CFD4;
        Wed,  8 Feb 2023 21:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dBvaZymIZHZRKLxpxoYo8nJy6O1xQIuHk4F/AhpKofE=; b=QnBbvD+3CDnXo3bFbuKay/lH/c
        Qo9KLY0KV5l8/UXiD+mCtA17noM+R9Y5DgXpM6JGnsRyrfBxC7jDxMi9Ktiv8ZC7Tj8ZWz/CEe3bW
        UGu8gxUkyoy7CbKUUJsqHzrONAfJNOvO2DiAmf0AZLCsZfQ31hFoGSMpSwRY32KOmbFxV/UVDgAMO
        Vwzh95JYIpjiBNOQWpfB9rMaY5ruqjWAEebjWr9bsA2n+DVbI5jgLvb1TBQRFzz+ji8uRav0djqym
        PlsBIdaBaP7ghHY/7PWMoyswRx4bctQwtPWfK0YRlAD1nJ+4lRZQoRaciEBbX5sgvYBDjWDjZhE0N
        c228cvqQ==;
Received: from [2001:4bb8:182:9f5b:acdc:d3c1:a8cd:f858] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPzG6-000Bw0-2f; Thu, 09 Feb 2023 05:14:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 5/7] generic: add 125 to the auto group
Date:   Thu,  9 Feb 2023 06:13:53 +0100
Message-Id: <20230209051355.358942-6-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209051355.358942-1-hch@lst.de>
References: <20230209051355.358942-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test is not dangerous and passes reliably.  Add it to the auto
group.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/125 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/125 b/tests/generic/125
index 077895d4..0d8e61a1 100755
--- a/tests/generic/125
+++ b/tests/generic/125
@@ -7,7 +7,7 @@
 # ftruncate test, modified from CXFSQA tests cxfs_ftrunc and cxfs_trunc
 #
 . ./common/preamble
-_begin_fstest other pnfs
+_begin_fstest other pnfs auto
 
 # Import common functions.
 . ./common/filter
-- 
2.39.1

