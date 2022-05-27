Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAA8535B51
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348936AbiE0IT2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbiE0IT1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:19:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11826ED8FE;
        Fri, 27 May 2022 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Zt4GUk0+M7yBUtGVMgiUd70j/wVP6RRywXvMddiZIeY=; b=0KJnP3wR9bhrUvWNuKb/P3k2/C
        YHHwIfXJKct082ikFLeIBd5UX7m+7sSNsprP9K+DtLn2kONkWn4+kzCBWdiL83zkBvff+e5xYZuFx
        cwcJyzhR/3U6CKolrf1fgZTQu1OrqbRjQRcHhJQi/Q1mqdE8FmwQobvx8q3lEgdhZr5iCKErhQy+N
        69mBASquMcQijSXkrNwUMAUWfxgu4O/XiIEzZUGoPOPclXZYRaP9QbPyj1z5UPLZQkfRELgLGQCIb
        3yFolQeN13WizL2Y4QfNLPHBf3YwvggAALi9HpPI9qKfElJxeKpuKgVqG5634NJftZoLCuOWVDxBf
        y8xgpYkQ==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVBt-00Gzws-8u; Fri, 27 May 2022 08:19:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 03/10] btrfs/141: use common read repair helpers
Date:   Fri, 27 May 2022 10:19:08 +0200
Message-Id: <20220527081915.2024853-4-hch@lst.de>
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

