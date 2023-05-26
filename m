Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF49671208F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 09:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbjEZHDW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 03:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242347AbjEZHDV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 03:03:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DE4F7
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 00:03:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3FFC768D09; Fri, 26 May 2023 09:03:17 +0200 (CEST)
Date:   Fri, 26 May 2023 09:03:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 15/21] btrfs: remove the extent_buffer lookup in btree
 block checksumming
Message-ID: <20230526070316.GA11445@lst.de>
References: <20230503152441.1141019-1-hch@lst.de> <20230503152441.1141019-16-hch@lst.de> <1442e52f-9ba1-d9fa-f439-34d31b46800f@gmx.com> <20230526064123.GA10378@lst.de> <e288cd7d-2f49-f517-a406-b511cae36cb7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e288cd7d-2f49-f517-a406-b511cae36cb7@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 26, 2023 at 02:43:11PM +0800, Qu Wenruo wrote:
>>> Thus for any subpage mount, this would lead to transaction abort during
>>> metadata writeback.
>>>
>>> We have btrfs_page_clamp_test_uptodate() for this usage.
>>
>> True, this should use the sub page helper.  Or maybe just drop
>> this assert altogether?
>
> It may be better to keep it, as there is also another case related to
> subpage fs got its PageUptodate and bitmaps de-synced.
>
> Thus the assert can have a chance to catch such problem.

Ok.  I don't really think we need the clamp version here, though.
Does this work for you?

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c461a46ac6f207..36d6b8d4b2c1fa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -269,7 +269,8 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 
 	if (WARN_ON_ONCE(found_start != eb->start))
 		return BLK_STS_IOERR;
-	if (WARN_ON_ONCE(!PageUptodate(eb->pages[0])))
+	if (WARN_ON(!btrfs_page_test_uptodate(fs_info, eb->pages[0],
+					      eb->start, eb->len)))
 		return BLK_STS_IOERR;
 
 	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
