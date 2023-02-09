Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD168FFBC
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 06:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjBIFOP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 00:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBIFOO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 00:14:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0192384B;
        Wed,  8 Feb 2023 21:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T+DMJRSJqRWU+mFSB+pOv2IHTnkAGzl4zqYt1wigDrw=; b=rLV3SB3TzTRqRR9gJEe38j8yKz
        i5VgVVGSDgjqu9w5bfz46Lcyx8LccLBjVtCDqeRShcxEPpS2hF8v5xgxQC/CiLyh1n9Q3QNTIHlgh
        ZBjXdk0w/XysEonWjiO82YgR/90fwD2lARw2AMTREC0yHHSwHbgZQRzTmflr4jFBmC06jecUuePgp
        0FXmIIvU54U00rAZDc4GPUvSWyT0fVq1w5MzAOShIDBo3Ilx0+KjrRwsn2mXc6d64hJ24G7HQLvlB
        AHNm2E0H0k0GRc3jSUjo1PglUDZaOPwmH6n6tRhbOkBWyK48eME2mBxwocT6O2qY+zhanwQzTU/ey
        Sr7riAlg==;
Received: from [2001:4bb8:182:9f5b:acdc:d3c1:a8cd:f858] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPzG9-000Bwc-16; Thu, 09 Feb 2023 05:14:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 6/7] generic: add 251 to the auto group
Date:   Thu,  9 Feb 2023 06:13:54 +0100
Message-Id: <20230209051355.358942-7-hch@lst.de>
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

generic/251 isn't dangerous, doesn't takes overly long to run and doesn't
produce spurious failures, so add it to the auto group.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/251 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/251 b/tests/generic/251
index 192ab5cc..2a271cd1 100755
--- a/tests/generic/251
+++ b/tests/generic/251
@@ -10,7 +10,7 @@
 # corrupts the filesystem (data/metadata).
 #
 . ./common/preamble
-_begin_fstest ioctl trim
+_begin_fstest ioctl trim auto
 
 tmp=`mktemp -d`
 trap "_cleanup; exit \$status" 0 1 3
-- 
2.39.1

