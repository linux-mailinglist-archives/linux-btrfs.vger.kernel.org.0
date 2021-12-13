Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4F4734E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 20:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbhLMTWi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 14:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbhLMTWg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 14:22:36 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F54FC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 11:22:36 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id f20so16295751qtb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 11:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yEt6+Pz5MH+VYQ1C7tbvdtVzSOBcFo1M/I7adkZLP+w=;
        b=7Aqs1as8JOEImLsVqVBhjZ/GvHLj/oXv/ytig/c15rBeULgJ67K6oIvh9o/2tX4VNx
         qWEBdDdyzNyrGxLHjaWJkfg/PqB5Vcebuu1n8pY7T/cMHXqTkp4Kcp6VYk2mj8NUkBjz
         E5CKccG5hMV+4el719t9gbophiSgYC7xtbstTVK1wlydS1P2MAuq9TD6mBj6IyLFvPsz
         vaxe7ryOZcSP8n97fsYzx5HXV9c46ZI/a7oK59cG7otnDlCrVqBuyEmE6Sh2egSSxYFN
         6NIsvdYJBLLffr/eeUN0vnPlhIeq7xLVlItkPXxDJzlOszFt7y7+rTLsJMpRcDg6PR1h
         cxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yEt6+Pz5MH+VYQ1C7tbvdtVzSOBcFo1M/I7adkZLP+w=;
        b=GVjXe4UQQfk1PjDjXQFwG/WZF7FqG79caVEM9wPPG/RwtO6kmSixSLvSWFTnx+7Cql
         2FhuC/FSdEOBGfasRiEZcIgxC0FEI6R8M5juSBQFcMxOqCHVg/X1v8e9zIW5x6m7atQa
         3783Oovr27R8jy/lunNbIZmTa/k1PKcJKiaAMue0xkloqbwdfc5StZn6A4J1QQpiMHcY
         Gs8eS7W1p+WFxREnN6y9D80XGVikBJdqmC0trwYOVmj1ZG5oEpYrZvlOI/5K44u3QzcI
         2gZ3opZ661tTaXWuEM64on78pzym+ozMP1uyQbI1YrRX62sdeaW7XDCJak81/U+atFPt
         eJ7A==
X-Gm-Message-State: AOAM532wubxpIt2n8s4j2MM7YlXZc0v8G0oUwjWvVyo33sQb/YiapiuW
        MXauabOKl4ilN+DnyU6Ybfi/Wl8PkEpZlQ==
X-Google-Smtp-Source: ABdhPJzSvSQxU0DS9XX6cNAKwtoqIoMVgGVgk5s9eLIo8LSHWMDJpEkMzUW3Ly7PoONHz2HfS2oSMQ==
X-Received: by 2002:a05:622a:307:: with SMTP id q7mr362300qtw.330.1639423355112;
        Mon, 13 Dec 2021 11:22:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e17sm10748199qtw.18.2021.12.13.11.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:22:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: check WRITE_ERR when trying to read an extent buffer
Date:   Mon, 13 Dec 2021 14:22:33 -0500
Message-Id: <1676bf652be3e37ef3ae55ed784c8f0ab2ff3f8f.1639423346.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe reported a hang when we have errors on btrfs.  This turned out to
be a side-effect of my fix 666cc468424b ("btrfs: clear extent buffer
uptodate when we fail to write it") which made it so we clear
EXTENT_BUFFER_UPTODATE on an eb when we fail to write it out.

Below is a paste of Filipe's analysis he got from using drgn to debug
the hang

"""
btree readahead code calls read_extent_buffer_pages(), sets ->io_pages to
a value while writeback of all pages has not yet completed:
   --> writeback for the first 3 pages finishes, we clear
       EXTENT_BUFFER_UPTODATE from eb on the first page when we get an
       error.
   --> at this point eb->io_pages is 1 and we cleared Uptodate bit from the
       first 3 pages
   --> read_extent_buffer_pages() does not see EXTENT_BUFFER_UPTODATE() so
       it continues, it's able to lock the pages since we obviously don't
       hold the pages locked during writeback
   --> read_extent_buffer_pages() then computes 'num_reads' as 3, and sets
       eb->io_pages to 3, since only the first page does not have Uptodate
       bit set at this point
   --> writeback for the remaining page completes, we ended decrementing
       eb->io_pages by 1, resulting in eb->io_pages == 2, and therefore
       never calling end_extent_buffer_writeback(), so
       EXTENT_BUFFER_WRITEBACK remains in the eb's flags
   --> of course, when the read bio completes, it doesn't and shouldn't
       call end_extent_buffer_writeback()
   --> we should clear EXTENT_BUFFER_UPTODATE only after all pages of
       the eb finished writeback?  or maybe make the read pages code
       wait for writeback of all pages of the eb to complete before
       checking which pages need to be read, touch ->io_pages, submit
       read bio, etc

writeback bit never cleared means we can hang when aborting a
transaction, at:

    btrfs_cleanup_one_transaction()
       btrfs_destroy_marked_extents()
         wait_on_extent_buffer_writeback()
"""

This is a problem because our writes are not synchronized with reads in
any way.  We clear the UPTODATE flag and then we can easily come in and
try to read the EB while we're still waiting on other bio's to
complete.

We have two options here, we could lock all the pages, and then check to
see if eb->io_pages != 0 to know if we've already got an outstanding
write on the eb.

Or we can simply check to see if we have WRITE_ERR set on this extent
buffer.  We set this bit _before_ we clear UPTODATE, so if the read gets
triggered because we aren't UPTODATE because of a write error we're
guaranteed to have WRITE_ERR set, and in this case we can simply return
-EIO.  This will fix the reported hang.

Reported-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 762100a00978..38c5e9eb9a10 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6601,6 +6601,14 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
 
+	/*
+	 * We could have had EXTENT_BUFFER_UPTODATE cleared by the write
+	 * operation, which could potentially still be in flight.  In this case
+	 * we simply want to return an error.
+	 */
+	if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
+		return -EIO;
+
 	if (eb->fs_info->sectorsize < PAGE_SIZE)
 		return read_extent_buffer_subpage(eb, wait, mirror_num);
 
-- 
2.26.3

