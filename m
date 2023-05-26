Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F98712059
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 08:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbjEZGlf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242230AbjEZGlc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 02:41:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7FC13A
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 23:41:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6585568D07; Fri, 26 May 2023 08:41:23 +0200 (CEST)
Date:   Fri, 26 May 2023 08:41:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 15/21] btrfs: remove the extent_buffer lookup in btree
 block checksumming
Message-ID: <20230526064123.GA10378@lst.de>
References: <20230503152441.1141019-1-hch@lst.de> <20230503152441.1141019-16-hch@lst.de> <1442e52f-9ba1-d9fa-f439-34d31b46800f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442e52f-9ba1-d9fa-f439-34d31b46800f@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 26, 2023 at 02:39:54PM +0800, Qu Wenruo wrote:
>> +	if (WARN_ON_ONCE(found_start != eb->start))
>> +		return BLK_STS_IOERR;
>> +	if (WARN_ON_ONCE(!PageUptodate(eb->pages[0])))
>> +		return BLK_STS_IOERR;
>
> Unfortunately this is screwing up subpage support.
>
> Previously subpage goes its own helper, which replaces the uptodate
> check to using the subpage helper.
>
> Since PageUptodate flag is only set when all eb in that page is uptodate.
> If we have a hole in the page range, the page will never be marked Uptodate.
>
> Thus for any subpage mount, this would lead to transaction abort during
> metadata writeback.
>
> We have btrfs_page_clamp_test_uptodate() for this usage.

True, this should use the sub page helper.  Or maybe just drop
this assert altogether?
