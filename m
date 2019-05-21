Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D1924FC7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 15:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfEUNKc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 09:10:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:59764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726995AbfEUNKc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 09:10:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1922DAE91;
        Tue, 21 May 2019 13:10:31 +0000 (UTC)
Date:   Tue, 21 May 2019 15:10:30 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 04/13] btrfs: don't assume ordered sums to be 4 bytes
Message-ID: <20190521131030.GC7200@x250>
References: <20190516084803.9774-1-jthumshirn@suse.de>
 <20190516084803.9774-5-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190516084803.9774-5-jthumshirn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 16, 2019 at 10:47:54AM +0200, Johannes Thumshirn wrote:
David can you fold this change in:


diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 7281657c859c..ba2405b4931b 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -23,9 +23,13 @@
 #define MAX_CSUM_ITEMS(r, size) (min_t(u32, __MAX_CSUM_ITEMS(r, size), \
 				       PAGE_SIZE))
 
-#define MAX_ORDERED_SUM_BYTES(fs_info, csum_size) ((PAGE_SIZE - \
-				   sizeof(struct btrfs_ordered_sum)) / \
-				   (csum_size) * (fs_info)->sectorsize)
+static inline size_t max_ordered_sum_bytes(struct btrfs_fs_info *fs_info,
+					   u16 csum_size)
+{
+	u32 ncsums = (PAGE_SIZE - sizeof(struct btrfs_ordered_sum)) / csum_size;
+
+	return ncsums * fs_info->sectorsize;
+}
 
 int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
@@ -376,7 +380,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 				      struct btrfs_csum_item);
 		while (start < csum_end) {
 			size = min_t(size_t, csum_end - start,
-				     MAX_ORDERED_SUM_BYTES(fs_info, csum_size));
+				     max_ordered_sum_bytes(fs_info, csum_size));
 			sums = kzalloc(btrfs_ordered_sum_size(fs_info, size),
 				       GFP_NOFS);
 			if (!sums) {

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
