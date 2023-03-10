Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8356B3E56
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 12:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCJLrh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 06:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCJLrg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 06:47:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7C7110527
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 03:47:35 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4816D67373; Fri, 10 Mar 2023 12:47:32 +0100 (CET)
Date:   Fri, 10 Mar 2023 12:47:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 13/20] btrfs: simplify the extent_buffer write end_io
 handler
Message-ID: <20230310114731.GA19861@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-14-hch@lst.de> <b2f12bbc-e08a-ae91-f7b8-8cbdf9117eb8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f12bbc-e08a-ae91-f7b8-8cbdf9117eb8@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 10, 2023 at 04:44:37PM +0800, Qu Wenruo wrote:
>> -		BUG_ON(!eb);
>> -		done = atomic_dec_and_test(&eb->io_pages);
>> +		atomic_dec(&eb->io_pages);
>>   -		if (bio->bi_status ||
>> -		    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
>> +		if (!uptodate) {
>>   			ClearPageUptodate(page);
>
> There seems to be an existing bug in the endio function for subpage.
>
> We should call btrfs_page_clear_uptodate() helper.
> Or we subpage uptodate bitmap and the page uptodate flag would get out of 
> sync.

Indeed.  I'll add a patch to fix this to the beginning of the series
for the next round.

>> +		if (fs_info->nodesize < PAGE_SIZE)
>> +			btrfs_subpage_clear_writeback(fs_info, page, eb->start,
>> +						      eb->len);
>> +		else
>> +			end_page_writeback(page);
>
>
> Here we can just call btrfs_clear_writeback(), which can handle both 
> subpage and regular cases.

Ok.
