Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9977A38C5C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhEULd5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 07:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhEULdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 07:33:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320B4C061574;
        Fri, 21 May 2021 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wT/rNWb1ZnEX21noYzmavyi+57yZu096POAh4n4nYlM=; b=rK3nkNAbMDgW0B0du2kDnwsPEV
        kDyWrdRHkvge1VEflA1CL4xKCOQDu0ig7nHQClIlDYUxT9QazW8hVcTtgLzzGtyAFbf2KLhU7PDf/
        9bDASLivAeyOrGkV3uaalxTUEEdsIRUrhR2geqQjyK1i/3xOFmH+Wq7n96iLye/86dd6hS7LCXPX0
        X5G3lVHZnsQDqz+mvHDYJU/0G/78+E/OjC3pM8SMXY2tJrdanYQ2BnY575yvrqty4GyfznahvhZDU
        BRNxk5tGi9CkDDZNq2W2V3imooXhKPtzalyyiAW6m6dmS8JrB6SZe3bFWSsVT5aRsdCXjAZPhZ49U
        BMRb8tgw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lk3Mb-00GuqS-1A; Fri, 21 May 2021 11:31:24 +0000
Date:   Fri, 21 May 2021 12:30:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        axboe@kernel.dk, mb@lightnvm.io, martin.petersen@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        jefflexu@linux.alibaba.com, hch@lst.de
Subject: Re: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Message-ID: <YKeZ5dtxt3gsImsd@casper.infradead.org>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 11:22:47PM -0700, Chaitanya Kulkarni wrote:
> The helper functions bio_add_XXX_page() returns the length which is
> unsigned int but the return type of those functions is defined
> as int instead of unsigned int.

I've been thinking about this for a few weeks as part of the folio
patches:

https://lore.kernel.org/linux-fsdevel/20210505150628.111735-72-willy@infradead.org/

 - len and off are measured in bytes
 - neither are permitted to be negative
 - for efficiency we only permit them to be up to 4GB

I therefore believe the correct type for these parameters to be size_t,
and we should range-check them if they're too large.  they should
actually always fit within the page that they're associated with, but
people do allocate non-compound pages and i'm not trying to break that
today.

using size_t makes it clear that these are byte counts, not (eg) sector
counts.  i do think it's good to make the return value unsigned so we
don't have people expecting a negative errno on failure.
