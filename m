Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047A15323FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 09:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiEXHZF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 03:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiEXHZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 03:25:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB779548D
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 00:25:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D2FB68AFE; Tue, 24 May 2022 09:24:58 +0200 (CEST)
Date:   Tue, 24 May 2022 09:24:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 2/8] btrfs: introduce a pure data checksum checking
 helper
Message-ID: <20220524072458.GA26145@lst.de>
References: <20220522114754.173685-1-hch@lst.de> <20220522114754.173685-3-hch@lst.de> <d459113f-7325-ebe9-77de-6639c646f0df@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d459113f-7325-ebe9-77de-6639c646f0df@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 23, 2022 at 08:38:13AM +0800, Qu Wenruo wrote:
>
>
> On 2022/5/22 19:47, Christoph Hellwig wrote:
>> From: Qu Wenruo <wqu@suse.com>
>>
>> Although we have several data csum verification code, we never have a
>> function really just to verify checksum for one sector.
>>
>> Function check_data_csum() do extra work for error reporting, thus it
>> requires a lot of extra things like file offset, bio_offset etc.
>>
>> Function btrfs_verify_data_csum() is even worse, it will utizlie page
>> checked flag, which means it can not be utilized for direct IO pages.
>>
>> Here we introduce a new helper, btrfs_check_sector_csum(), which really
>> only accept a sector in page, and expected checksum pointer.
>>
>> We use this function to implement check_data_csum(), and export it for
>> incoming patch.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> [hch: keep passing the csum array as an arguments, as the callers want
>>        to print it, rename per request]
>
> Mind to constify the @csum_expected parameter?

This would be the incremental diff, if Dave cares deeply he can fold
it in:

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d982ea62c521b..f01ce82af8ca9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3262,7 +3262,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			   int mirror_num, enum btrfs_compression_type compress_type);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
-			    u32 pgoff, u8 *csum, u8 *csum_expected);
+			    u32 pgoff, u8 *csum, u8 * const csum_expected);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bfc0b0035b03c..c344ed0e057ac 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3330,7 +3330,7 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
  * depend on the type of I/O.
  */
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
-			    u32 pgoff, u8 *csum, u8 *csum_expected)
+			    u32 pgoff, u8 *csum, u8 * const csum_expected)
 {
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
