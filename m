Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9068A38E7AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 15:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhEXNcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 09:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhEXNcL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 09:32:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076D0C061574;
        Mon, 24 May 2021 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bv35H6FG196dYh7WLuhEfA04iL61RBNtMxr8gq5fspQ=; b=mEir/8DR4LgDF/OtHjpfBjqgM7
        rq9D9dyybSBOJ3HzV5qk/zzVhuxz6gZI/pkMDJ29YeHGLml9/+rPY/g9gQVcBl/hKIeNAw+AyA7Wv
        ht1nh854pe8p9jkNL0lncGKqTeydLa0vwpX2GYAg98fyT9a1o3MVG4q1HiI4O8qfD05x44DFCB5zi
        rrLwmqzFDZjNYC4xKqUmCbqKZid8O+MkYe+gD9dXlhq2hbkM5JbeBq7I2Dt41w+OgTDtFPcz4+cKM
        uxvnmKzwjtN4rnr6o35Qtj5FbS8bzU7xAY+Ow5qxuw8rNYRoKDTO7VJcVfFVe6en3ruTEkIcu/5H0
        j7s/mXLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1llAeX-002PBR-4K; Mon, 24 May 2021 13:29:59 +0000
Date:   Mon, 24 May 2021 14:29:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        axboe@kernel.dk, mb@lightnvm.io, martin.petersen@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        jefflexu@linux.alibaba.com
Subject: Re: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Message-ID: <YKuqUeCBSdezBMMd@casper.infradead.org>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
 <YKeZ5dtxt3gsImsd@casper.infradead.org>
 <20210524073527.GA24302@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524073527.GA24302@lst.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 24, 2021 at 09:35:27AM +0200, Christoph Hellwig wrote:
> > using size_t makes it clear that these are byte counts, not (eg) sector
> > counts.  i do think it's good to make the return value unsigned so we
> > don't have people expecting a negative errno on failure.
> 
> I think the right type is bool.  We always return either 0 or the full
> length we tried to add.  Instead of optimizing for a partial add (which
> only makes sense for bio_add_hw_page anyway), I'd rather make the
> interface as simple as possible.

Sounds good to me.
