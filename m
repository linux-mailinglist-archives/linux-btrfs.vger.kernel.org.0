Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6626B535B4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345456AbiE0ITg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349221AbiE0ITe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:19:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39F110274F;
        Fri, 27 May 2022 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CwInLtVp+3Thz3l/OI6ZKlNkVBFXXF3UwVeNaE5cyvQ=; b=3o0t5dN5PNTq3n3Cx1Gb+vJCQE
        I4pyk3/nYpAa2GfsWhA9GbmflGT+ZX5l/LGM0LDnDXG/nomHssqJSdJjJtBRZoPM7fs4PJu+caw46
        h6TOIP70nfeNLEDRcxmbo2+7RehHRUBnXZrnWehyPCYqWi7JeM3BmssqFO2HyBzRyfUhUUv8ewbth
        GjKl+BaU9mAPLt+5T4M837NNPV4yBLvMv9Kjm4KlOQ47qNHsfBSn8RyYb8No6BCV0LgA83S6XueLt
        Eai0TX+tPev37TSMnqjxiMzLtNk/tIaX7Wx7Zpy87Sd7SeW27uB1qiKbxBwtKRF3DeZstOE9PcGiC
        VoHk5pJw==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVC1-00H00p-2O; Fri, 27 May 2022 08:19:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 06/10] btrfs/157: use _btrfs_get_first_logical
Date:   Fri, 27 May 2022 10:19:11 +0200
Message-Id: <20220527081915.2024853-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220527081915.2024853-1-hch@lst.de>
References: <20220527081915.2024853-1-hch@lst.de>
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/157 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 343178b7..022db511 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -71,7 +71,7 @@ _scratch_mount $(_btrfs_no_v1_cache_opt)
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
 	"$SCRATCH_MNT/foobar" | _filter_xfs_io
 
-logical=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
+logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
 _scratch_unmount
 
 phy0=$(get_physical 0)
-- 
2.30.2

