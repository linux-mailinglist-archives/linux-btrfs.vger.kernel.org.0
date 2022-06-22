Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548B35541F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 06:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356989AbiFVE7F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 00:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356974AbiFVE7A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 00:59:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C8931500;
        Tue, 21 Jun 2022 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=96mh2sV8EWV8H1TFT3lVYjLYQMPC2oQnKMcaC3/41J0=; b=DBNMYkdi0n/4ln6nIEpBEgyLUF
        DVP1ccks0ItkMeFd4/REhRMp1fQV9yYQBA82nVUeIT+/+wUq62TFKlwdacSclfYkhqZsOjXrvYVXV
        umSvFp268ij2d45tgrpmCdFO3ctQ7uhurKUSYQszwC681UAPeUTQBIpcCcCSz4qqZRniRbhj+4ejx
        GgLHX3H3hrgzlH8brkr0iDEnGOiq9llL+PW6mrbSouzsefkTe/CAN4XhcEUwQd8QghB1mHgklTwMy
        DRFSpZ4Jxf2zH/xxMRIdO17Fzmzq/k/lIVzzNIKhrRnSI45KThlbZL/Q1/eiTWnZ00miBvxQ2HVcK
        pcO4cT2g==;
Received: from 213-225-1-25.nat.highway.a1.net ([213.225.1.25] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3sS2-008WjV-CU; Wed, 22 Jun 2022 04:58:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: fix the_btrfs_get_physical invocation in btrfs-map-logical
Date:   Wed, 22 Jun 2022 06:58:41 +0200
Message-Id: <20220622045844.3219390-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220622045844.3219390-1-hch@lst.de>
References: <20220622045844.3219390-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The -b flag without an argument is not supported, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/btrfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/btrfs b/common/btrfs
index c7058918..14ad890e 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -537,7 +537,7 @@ _btrfs_get_physical()
 
 	_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
 
-	$BTRFS_MAP_LOGICAL_PROG -b -l $logical $SCRATCH_DEV >> $seqres.full 2>&1
+	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV >> $seqres.full 2>&1
 	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
 		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$6 }"
 }
-- 
2.30.2

