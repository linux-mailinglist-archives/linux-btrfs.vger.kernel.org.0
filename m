Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B70C5323E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 09:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiEXHS4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 03:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiEXHSz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 03:18:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAADE80227;
        Tue, 24 May 2022 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/EB5LG6UvTCkYfcEq/CNnza9tGVGj8cPjTcJli9orlE=; b=mjpe/u8zaPCDiMGSi+26qC16z+
        K0fUALxkGsnDgAESGoKgmeDANq7YuJXxxpQrD1uik6f/Ou3fP7iAmSJe6PuV5MJEW+bi4QfAfZknQ
        lRcUbMoG8nNuIBT51RVSjDmJBNvhrMfjnqyxE9ZE2Qno77kVb/0JLToBMqxWJK8vZVlf+yIuQvu5E
        3ur1CgwBzMrBYCkMkPKjjrXGCUqFdMGoMW/zN3VN7G6y0rIwDUykW33euONZr2k7GAYsW1CtYWKPA
        mOYwJT+3Mk4LQDMv4LJEhMm5I0qMSmRtZfnRVY80a6srSwdbYFY25VEhgqMprio1HyLU9kbN2Tr6E
        0lXqgi7Q==;
Received: from [2001:4bb8:18c:7298:31fd:9579:b449:3c3a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntOoe-0073Gr-Q5; Tue, 24 May 2022 07:18:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs/141: use common read repair helpers
Date:   Tue, 24 May 2022 09:18:32 +0200
Message-Id: <20220524071838.715013-4-hch@lst.de>
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

Use the common helpers to find the btrfs logical address and to read from
a specific mirror.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/141 | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/tests/btrfs/141 b/tests/btrfs/141
index 9fdcb2ab..90a90d00 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -25,7 +25,6 @@ _supported_fs btrfs
 _require_scratch_dev_pool 2
 
 _require_btrfs_command inspect-internal dump-tree
-_require_command "$FILEFRAG_PROG" filefrag
 
 get_physical()
 {
@@ -69,8 +68,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 # one in $SCRATCH_DEV_POOL
 echo "step 2......corrupt file extent" >>$seqres.full
 
-${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
-logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
+logical_in_btrfs=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
 physical=$(get_physical ${logical_in_btrfs} 1)
 devid=$(get_devid ${logical_in_btrfs} 1)
 devpath=$(get_device_path ${devid})
@@ -85,16 +83,7 @@ _scratch_mount
 # step 3, 128k buffered read (this read can repair bad copy)
 echo "step 3......repair the bad copy" >>$seqres.full
 
-# since raid1 consists of two copies, and the bad copy was put on stripe #1
-# while the good copy lies on stripe #0, the bad copy only gets access when the
-# reader's pid % 2 == 1 is true
-while true; do
-	echo 3 > /proc/sys/vm/drop_caches
-	$XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
-	pid=$!
-	wait
-	[ $((pid % 2)) == 1 ] && break
-done
+_btrfs_buffered_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
 
 _scratch_unmount
 
-- 
2.30.2

