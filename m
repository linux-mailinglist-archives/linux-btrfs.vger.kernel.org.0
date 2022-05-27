Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73A535B4D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349048AbiE0ITa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbiE0IT3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:19:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF277F1373;
        Fri, 27 May 2022 01:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+hiFrIsAM9uZ02jYOz3NSMxqE01U6htfJ3t3La+ffc4=; b=RBSbWtXNqlkkxd/Ne2zrCQF/pq
        LZpmwQajN7na4wOv0tuE7Avg8abdHGpYq9wxfXSmTFg3rMulaPro4BUu/wldqNO1m+StGmrVOYHK4
        nntKDOlCvFrNjRHYUAD0lo9/9c4VFDO1P9yL+Pb1mczyiYeZpTy2Qi26JNMNbsIDJvSE4CYqVgYDK
        umLG3SMLX04QOTzC+KVPa2pLrfL0yqrVZPgS6T0YrpTDGi68Ytc50g1k5u/VDmJTvBsJ7G6AejmFY
        bZMWDiQdOOhMDmigj+Q9BvUrQLUVyFpCj60P2pZiRdrIuOHDC+8UTRujKfBYKkIAQvECmBFndf2mU
        IpdlnnbQ==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVBv-00GzyG-Tn; Fri, 27 May 2022 08:19:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 04/10] btrfs/142: use common read repair helpers
Date:   Fri, 27 May 2022 10:19:09 +0200
Message-Id: <20220527081915.2024853-5-hch@lst.de>
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

Use the common helpers to find the btrfs logical address and to read from
a specific mirror.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/142 | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tests/btrfs/142 b/tests/btrfs/142
index 58d01add..7a63fb83 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -27,7 +27,6 @@ _require_scratch_dev_pool 2
 _require_dm_target dust
 
 _require_btrfs_command inspect-internal dump-tree
-_require_command "$FILEFRAG_PROG" filefrag
 
 _scratch_dev_pool_get 2
 # step 1, create a raid1 btrfs which contains one 128k file.
@@ -46,8 +45,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 # step 2, corrupt the first 64k of stripe #1
 echo "step 2......corrupt file extent" >>$seqres.full
 
-${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
-logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
+logical_in_btrfs=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
 echo "Logical offset is $logical_in_btrfs" >>$seqres.full
 _scratch_unmount
 
@@ -67,10 +65,8 @@ echo "step 3......repair the bad copy" >>$seqres.full
 
 $DMSETUP_PROG message dust-test 0 addbadblock $((physical / 512))
 $DMSETUP_PROG message dust-test 0 enable
-while [[ -z $( (( BASHPID % 2 == stripe )) &&
-	       exec $XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar") ]]; do
-	:
-done
+
+_btrfs_direct_read_on_mirror $stripe 2 "$SCRATCH_MNT/foobar" 0 128K
 
 _cleanup_dust
 
-- 
2.30.2

