Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE94336BAFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 23:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhDZVId (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhDZVId (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 17:08:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DE8C061574;
        Mon, 26 Apr 2021 14:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=19wB8Qe2dQhskC7FNPcGmP7e6BQaLpFsmVyER60Ukps=; b=L/M2JsMwAehKPT0APsUFQ2GrWm
        DPNdu5guEKsukAbRy2AiEOVYBlxym/CtxvJLDYIlIVUe1ydMrsxwbbEuIMykqx4p7fuVtuAX1MVhI
        2Wr59V/QLKqIR82MdobX0onak16JLkrpCkSVk8XO9kGQJrN8MAuzSXKAvDq9gLovUcD89Xqedol75
        NA9EJQmh+rw9cuW6QvLbtVf9TOuJnDO1BV4+/xMQkfxiUrkArKGPDkHhV3Km9mB2R/02OIcTxxH2J
        KbxXQOTeJD++8dduO7+Scw9pp3IUVo3x7YW0RyGC8hmNLkjPTRhiq5O7/p5w2ZNwFu3apVD1rfKlM
        UZvthX+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb8S2-0066B7-R8; Mon, 26 Apr 2021 21:07:32 +0000
Date:   Mon, 26 Apr 2021 22:07:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>, David Sterba <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Btrfs updates for 5.13
Message-ID: <20210426210730.GR235567@casper.infradead.org>
References: <cover.1619466460.git.dsterba@suse.com>
 <CAHk-=wj1KRvb=hie1VUTGo1D_ckD+Suo0-M2Nh5Kek1Wu=2Ppw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj1KRvb=hie1VUTGo1D_ckD+Suo0-M2Nh5Kek1Wu=2Ppw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 26, 2021 at 01:55:03PM -0700, Linus Torvalds wrote:
> I've pulled this, but:
> 
> On Mon, Apr 26, 2021 at 1:01 PM David Sterba <dsterba@suse.com> wrote:
> >
> > Matthew Wilcox (Oracle) (1):
> >       btrfs: add and use readahead_batch_length
> 
> This one is buggy, or at least questionable.
> 
> Yes, yes, the function looks trivial. That doesn't make it right:
> 
>   static inline loff_t readahead_batch_length(struct readahead_control *rac)
>   {
>           return rac->_batch_count * PAGE_SIZE;
>   }
> 
> the above does not get the types right, and silently does different
> typecasting than the code clearly intends from the return type of the
> function.
> 
> It may not matter much in practice, but it's still wrong.

Thanks.  You're right that it doesn't matter in practice (because a
batch length is always much, much less than 4GB), but I'll fix it to
return a size_t (which is just the obvious s/loff_t/size_t/, because
PAGE_SIZE is an unsigned long).
