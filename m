Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2665323EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 09:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiEXHTB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 03:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiEXHTA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 03:19:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA5374DDE;
        Tue, 24 May 2022 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0aoVV0asi4DwOw1QapuYxnB9jA5GIdGiFLcHRrPmYG8=; b=0XWLYThwfNnMhcVnemmgpxBDbW
        ycOHfflmSiBjP1talAzkDiF9sEriLVIik3lZxe0QTvFBZp/kk+r4wWJKCw84/YWkkl7Ljd4J1vcif
        cEwM30L98hzlAFLpfk8V4i/x9KpHWwrpFcdtodLbQHIAOxNnvtpVtRZ9T88sKv5QIipUBBxv3pLE2
        +7z/gSHbA84MJJx/Iv1XXF439Uzpn0Ol9QKhR2nEd3WP5UFon3ouz0LOkzlS8d6iWKqmrdQScy3/X
        I1fZQmsx/BC4sdRnxbRvN7pKoiNLK1ARd2/mEh5Oqn9pfNUDuF53KSrMxBeJtKhUMQrQG9dbYVNMH
        2qEMXQEg==;
Received: from [2001:4bb8:18c:7298:31fd:9579:b449:3c3a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntOol-0073Hy-1a; Tue, 24 May 2022 07:18:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/9] btrfs/143: use common read repair helpers
Date:   Tue, 24 May 2022 09:18:34 +0200
Message-Id: <20220524071838.715013-6-hch@lst.de>
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

