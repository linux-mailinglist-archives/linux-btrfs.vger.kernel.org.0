Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE61552B5F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 08:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbiFUG7O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 02:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346330AbiFUG7N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 02:59:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CD81E3ED
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 23:59:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8F5EE68AA6; Tue, 21 Jun 2022 08:59:09 +0200 (CEST)
Date:   Tue, 21 Jun 2022 08:59:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: don't limit direct reads to a single sector
Message-ID: <20220621065909.GA1186@lst.de>
References: <20220621062627.2637632-1-hch@lst.de> <221407c5-0aec-6ab0-4f7f-e74a5873e4e0@gmx.com> <20220621064010.GA893@lst.de> <2bb7e620-fb2c-52d3-0ecf-87c2f75a1305@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb7e620-fb2c-52d3-0ecf-87c2f75a1305@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 21, 2022 at 02:55:06PM +0800, Qu Wenruo wrote:
> A little off-topic here, what did the extra XFS/iomap do here?
>
> IIRC the multi-page bio vector is already there for years.

Yes.

> As long as the pages in page cache are contiguous, bio_add_page() will 
> create such multi-page vector, without any extra support from fs.

Yes.  Every file system supports that case right now, but that only
covers the case where pages are contiguous by luck because the
allocations worked that way.  The iomap THP support is all about
having I/O map (and to a small extent the file system, which for now
is just xfs) to be able to deal with large folios, that is > PAGE_SIZE
compound allocations.

>>  At which point
>> allocating the larger csums array is also not a problem as we can
>> find contigous memory for that easily as well.  For direct I/O on the
>> other hand the destination could be THPs or hugetlbs even when memory
>> is badly fragmented.
>
> My point here is just no need to align any limit.
>
> Smash a good enough value here is enough, or we need to dig way deeper to 
> see if the MAX_SECTORS based one is really correct or not.

So my plan here was to also enforce the limit for buffered I/O and
provide a mempool for the maximum allocation size instead of just
failing on memory presure right now.  But there is another series
or two I need to finish first to have the buffered I/O code in the
shape where this can be easily added.

