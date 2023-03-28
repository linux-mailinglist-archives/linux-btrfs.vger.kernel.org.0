Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4530C6CB536
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 05:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjC1D5F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 23:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjC1D4g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 23:56:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EB92D59
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 20:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+jWizy44lHTck3Bq6e/vDbewC/XN8AyDLebobkH6lZU=; b=i6fkyD8cPI5LMYuvi+e9rVnIak
        BpUSSc5Ume8tbjUXaY+QTjBSUVQwbWLqEx+e2NgJKF6oVRpRJxLNOqMa71leqxO2/hJpKXal8MnLG
        LLiQnFASUkd9PY3nw9krECc3zhmMoQSn44yyMNG3mRSGy/Fg1YrRVqD3BLUXtJXcLO6F4JuBZKD4u
        gysYIKZSYEYDvI5g4XO/KBg4tmdw3NGerC9sQPSVcUVeRXX74AtJnEnhjpvL/hbkAMBkRQyOOPArC
        pY+dI90natPFyy69TJgidw0ucrFIDaMX13DFahCnEtrnwfFIB0AnJ/ITt8Mtq6rdNTiw51EnUvP3l
        hGpG/C/g==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph0RT-00D4Xy-1l;
        Tue, 28 Mar 2023 03:56:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: restore the thread_pool= behavior in remount for the end I/O workqueues
Date:   Tue, 28 Mar 2023 12:56:13 +0900
Message-Id: <20230328035613.1077697-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit d7b9416fe5c5 ("btrfs: remove btrfs_end_io_wq") converted the read
and I/O handling from btrfs_workqueues to Linux workqueues, and as part
of that lost the code to apply the thread_pool= based max_active limit
on remount.  Restore it.

Fixes: d7b9416fe5c5 ("btrfs: remove btrfs_end_io_wq")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d8885966e801cd..4809aa168665c7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1632,6 +1632,8 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
+	workqueue_set_max_active(fs_info->endio_workers, new_pool_size);
+	workqueue_set_max_active(fs_info->endio_meta_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
-- 
2.39.2

