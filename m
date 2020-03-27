Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A964C1952AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 09:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgC0IQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 04:16:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0IQk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 04:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cNdrpQwmyS3uQrgIgsHnJvWAJmst3fXZVtdYl7P4jb8=; b=bL2cL6AGPA7+AUNiSvlo48PBk8
        ZEdfZR8xhWlakZDaHolZymSoBEirY+b97lMVKX4vp/8/gi/M8i/qTPLZSUzgb+P9CtBOr5WY3bRa3
        JhyZw+r1evQucv3+z2eqgSI/su1VS2WmIFHtjTtZaDAWbzh+ckD7Kq4ZJmFUmewptkVr3Zk33eujh
        20+c8G9DkzaqLpwdDglJMCxrGxBAq2Lsjykk48Rizotm4sr6BWVcGNR9PryMCoCXAnCvoraqcb+1Y
        PGU2CBowmiBlsuYe1NkvufcnNyBAacmZZYLX2/X/fJ+2owVaZZflQbxrbtgHv0BLPgXolZQTRDtSb
        lcd81V3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHkAS-0001ME-6r; Fri, 27 Mar 2020 08:16:40 +0000
Date:   Fri, 27 Mar 2020 01:16:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 5/9] btrfs: Use ->iomap_end() instead of btrfs_dio_data
Message-ID: <20200327081640.GB24827@infradead.org>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
 <20200326210254.17647-6-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326210254.17647-6-rgoldwyn@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 04:02:50PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Use iomap->iomap_end() to check for failed or incomplete writes and call
> __endio_write_update_ordered(). We don't need btrfs_dio_data anymore so
> remove that. The bonus is we don't abuse current->journal_info anymore.
> 
> A new structure btrfs_iomap is used to keep a count of submitted I/O
> for writes.

I don't think you need a new structure.  As writes are limited to a
size_t (aka long) you can just case iomap->private.  That is a little
ugly, but we can just switch the private field to an union, something
like the patch below.  If I'm missing a reason why it has to be 64-bit
even on 32-bit kernels we can also grow the size a little on 32-bit
kernels, but right now I don't think that is needed unless I'm missing
something.

---
From e496cd3db3e7420050be19c5fe68e4675f5a2abc Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 27 Mar 2020 09:14:34 +0100
Subject: iomap: turn iomap->private into an union

Make using the union a little easier for scalar values.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/iomap.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..61fea687d93d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -85,7 +85,10 @@ struct iomap {
 	struct block_device	*bdev;	/* block device for I/O */
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
-	void			*private; /* filesystem private */
+	union {				/* filesystem private data */
+		void		*ptr;
+		uintptr_t	uint;
+	} private;
 	const struct iomap_page_ops *page_ops;
 };
 
-- 
2.25.1

