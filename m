Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A31DE709
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 14:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgEVMi7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 08:38:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:59028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbgEVMi7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 08:38:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1FFE2AED9;
        Fri, 22 May 2020 12:39:00 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, dsterba@suse.cz,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/7] fs: Export generic_file_buffered_read()
Date:   Fri, 22 May 2020 07:38:31 -0500
Message-Id: <20200522123837.1196-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522123837.1196-1-rgoldwyn@suse.de>
References: <20200522123837.1196-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Export generic_file_buffered_read() to be used to
supplement incomplete direct reads.

While we are at it, correct the comments and variable names.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 13 +++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 45cc10cdf6dd..366c533d30cd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3124,6 +3124,8 @@ extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
 extern int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    size_t *count, unsigned int flags);
+extern ssize_t generic_file_buffered_read(struct kiocb *iocb,
+		struct iov_iter *to, ssize_t already_read);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
diff --git a/mm/filemap.c b/mm/filemap.c
index 23a051a7ef0f..27df1cf35eb4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1979,7 +1979,7 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
  * generic_file_buffered_read - generic file read routine
  * @iocb:	the iocb to read
  * @iter:	data destination
- * @written:	already copied
+ * @copied:	already copied
  *
  * This is a generic file read routine, and uses the
  * mapping->a_ops->readpage() function for the actual low-level stuff.
@@ -1988,11 +1988,11 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
  * of the logic when it comes to error handling etc.
  *
  * Return:
- * * total number of bytes copied, including those the were already @written
+ * * total number of bytes copied, including those that were @copied
  * * negative error code if nothing was copied
  */
-static ssize_t generic_file_buffered_read(struct kiocb *iocb,
-		struct iov_iter *iter, ssize_t written)
+ssize_t generic_file_buffered_read(struct kiocb *iocb,
+		struct iov_iter *iter, ssize_t copied)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2133,7 +2133,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		prev_offset = offset;
 
 		put_page(page);
-		written += ret;
+		copied += ret;
 		if (!iov_iter_count(iter))
 			goto out;
 		if (ret < nr) {
@@ -2241,8 +2241,9 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 	*ppos = ((loff_t)index << PAGE_SHIFT) + offset;
 	file_accessed(filp);
-	return written ? written : error;
+	return copied ? copied : error;
 }
+EXPORT_SYMBOL_GPL(generic_file_buffered_read);
 
 /**
  * generic_file_read_iter - generic filesystem read routine
-- 
2.25.0

