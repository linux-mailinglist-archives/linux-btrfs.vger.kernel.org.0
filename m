Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13514535B53
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349221AbiE0ITj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiE0ITh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:19:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BDC10274C;
        Fri, 27 May 2022 01:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=i+o277We/VFbOQbVtvZKV/B+F9wiZ0t2qsBJ6kKUBd4=; b=MhU6YwCtUzcOOKvZFMaBrhKCIp
        QipH5QeNoqwfLOn7dmo2HJdUGStybzil6Og7NAPx/E8xvLkf/cfpQ9eei1laQSoucmsK09U77eiKT
        u3ymyOx1wylnIuuXwVtWlCKlfI6yl6s5+7+VgKmXdkRMOBbYlsq/qwb2JYv14OY5hBFi5T+pY1M4b
        OQ7GLkQxAPvpR3ecL+sVtym6EkETha5Q16819cH4kNmehmdBvfVyq6iQU3GONYiiiUnOh2GRA+RtJ
        w1Uzt7JRte2PcEETZJ+5aYJ46zCoPDmdUzT+pHmzxGSCXQWEkjjjb9aT4IBGNk5q4NzAA25E9MFH1
        ZBWq/gpg==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVC3-00H023-Js; Fri, 27 May 2022 08:19:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 07/10] btrfs/215: use _btrfs_get_first_logical
Date:   Fri, 27 May 2022 10:19:12 +0200
Message-Id: <20220527081915.2024853-8-hch@lst.de>
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

