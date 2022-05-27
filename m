Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB432535B55
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349147AbiE0ITd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbiE0ITc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:19:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C502ED8FE;
        Fri, 27 May 2022 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rvAXoC5D7NbJKN/rkulBSzflMHUOEAI6TV/paGXXM4o=; b=RsqZr4WgmcXCfoaDd9c11Uo1X5
        7cZQOWDWrTY9V2kdbJPMWGeUpSfqJ+kGbdufskfnn7ompN8mkX7ER4G04+hbA8OpYVDKFXBKiSEMz
        zMOfu/NgR03NN8HFvtKqjkqx/htDpsTvYn+QqcuJLxRv6fYuwQj58k3eTO+SDcDwRIZIItR46K5rw
        o5qBSRrK5uzPPNZO0rvxVB4EPchKTvce4d3uPL+uv1Ex5mBB3mgTTJouUFUh6hcS8UqaJ7hYI05Be
        zxWSC0OP4bPCbuS2JvZnKjZOeLtam5uiXpifI+QvNjNQSFONlQ0+c1X/7Kz7e6VpbWNqkbbLWbUOq
        k4cAN4ew==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVBy-00GzzT-H0; Fri, 27 May 2022 08:19:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 05/10] btrfs/143: use common read repair helpers
Date:   Fri, 27 May 2022 10:19:10 +0200
Message-Id: <20220527081915.2024853-6-hch@lst.de>
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
 tests/btrfs/143 | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tests/btrfs/143 b/tests/btrfs/143
index 71db861d..b6ff2a42 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -34,7 +34,6 @@ _require_scratch_dev_pool 2
 _require_dm_target dust
 
 _require_btrfs_command inspect-internal dump-tree
-_require_command "$FILEFRAG_PROG" filefrag
 
 _scratch_dev_pool_get 2
 # step 1, create a raid1 btrfs which contains one 128k file.
@@ -53,8 +52,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 # step 2, corrupt the first 64k of stripe #1
 echo "step 2......corrupt file extent" >>$seqres.full
 
-${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
-logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
+logical_in_btrfs=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
 echo "Logical offset is $logical_in_btrfs" >>$seqres.full
 _scratch_unmount
 
@@ -74,10 +72,8 @@ echo "step 3......repair the bad copy" >>$seqres.full
 
 $DMSETUP_PROG message dust-test 0 addbadblock $((physical / 512))
 $DMSETUP_PROG message dust-test 0 enable
-while [[ -z $( (( BASHPID % 2 == stripe )) &&
-	       exec $XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar") ]]; do
-	:
-done
+
+_btrfs_buffered_read_on_mirror $stripe 2 "$SCRATCH_MNT/foobar" 0 128K
 
 _cleanup_dust
 
-- 
2.30.2

