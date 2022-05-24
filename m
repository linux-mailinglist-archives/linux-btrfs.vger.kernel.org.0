Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92875323E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 09:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiEXHTH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 03:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiEXHTH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 03:19:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8264E6A078;
        Tue, 24 May 2022 00:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=o6mcFOlOHdIwq0qsYwT676kLM8c9cSlg1F6XRI0EzE0=; b=zdLijrOuriN4wTSS/n3y2w36NU
        RT0OJGnaaqweE5ZCnI+PxrM4ajYXVASYOMuzEsGC3RxpUsBk66qeEUyDhAOSWzuuQGR45FknVi2+3
        QSJdLV7USHmfT2dfE8nPTGYkwPCAgLz8Mi5LWo/nKM2kd3yQlzPrlv2CM1Ek/JBFzIS1kmapegM5t
        dYqueV8Egs17ovZwnXOyZ0NRY1jKNVyl9sJykULefxXkxI5wEQ1DGBDKHIugiBTd/c29WjkQMPAYh
        e3z8M9t0bVKaoPMaqjJKOROajuSOG2+80QvyaCj2Y6pIl0Vr5s9eWz0lvqo+8JPilc8rjAy0l8zIE
        qK6Sy1RQ==;
Received: from [2001:4bb8:18c:7298:31fd:9579:b449:3c3a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntOor-0073Ju-Mr; Tue, 24 May 2022 07:19:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] btrfs/215: use _btrfs_get_first_logical
Date:   Tue, 24 May 2022 09:18:36 +0200
Message-Id: <20220524071838.715013-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220524071838.715013-1-hch@lst.de>
References: <20220524071838.715013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the _btrfs_get_first_logical helper instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/215 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/215 b/tests/btrfs/215
index 0dcbce2a..928f365c 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -56,7 +56,7 @@ fi
 #create an 8 block file
 $XFS_IO_PROG -d -f -c "pwrite -S 0xbb -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null
 
-logical_extent=$($FILEFRAG_PROG -v "$SCRATCH_MNT/foobar" | _filter_filefrag | cut -d '#' -f 1)
+logical_extent=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
 physical_extent=$(get_physical $logical_extent)
 
 echo "logical = $logical_extent physical=$physical_extent" >> $seqres.full
-- 
2.30.2

