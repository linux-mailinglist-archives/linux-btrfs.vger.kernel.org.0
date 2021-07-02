Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00AC3B9F0F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 12:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhGBK1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 06:27:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59220 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhGBK1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 06:27:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8FED120079;
        Fri,  2 Jul 2021 10:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625221513;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eObXKMArKaHNSJD2PyqWy7nPDLUv3P/3WnSz8h6j82g=;
        b=f7o+5Qzk1uGtK5FAGMPcLFg/SlPp2W1NjmZDgsQbNFNacNIk4J/BvVB4sHpKzz95syF33a
        1fbRrbK/rOJfWkhjyLA1gnxxBps8K5lpjMvLIn6BD2hmkQy03mWeqOAKEsA8fWRlOG952G
        e0MhdT/24n1/9YcwV3l5sr5vEW62798=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625221513;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eObXKMArKaHNSJD2PyqWy7nPDLUv3P/3WnSz8h6j82g=;
        b=pgRAWBwi/RNVUyJUuwrxb0FZIK9KlaBmK8OGPpuLanWpUlsVopXKRLMD3AWX7sdOeqn19K
        bFmPRO4HTlHOdNBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 86C97A3B81;
        Fri,  2 Jul 2021 10:25:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6E839DA6FD; Fri,  2 Jul 2021 12:22:42 +0200 (CEST)
Date:   Fri, 2 Jul 2021 12:22:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
Message-ID: <20210702102242.GD2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210701160039.12518-1-dsterba@suse.com>
 <20210701215740.GA12099@embeddedor>
 <fc90ec53-1632-e796-3bf0-f46c5df790bb@gmx.com>
 <dd4346f9-bc3d-b12f-3b32-1e1ecabb5b8b@embeddedor.com>
 <62ec2948-77a3-6e50-7940-8de259b8671f@gmx.com>
 <20210702003936.GA13456@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210702003936.GA13456@embeddedor>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 01, 2021 at 07:39:36PM -0500, Gustavo A. R. Silva wrote:
> On Fri, Jul 02, 2021 at 08:21:31AM +0800, Qu Wenruo wrote:
> > On 2021/7/2 上午8:09, Gustavo A. R. Silva wrote:
> > > On 7/1/21 18:59, Qu Wenruo wrote:
> > > > On 2021/7/2 上午5:57, Gustavo A. R. Silva wrote:
> > > > > On Thu, Jul 01, 2021 at 06:00:39PM +0200, David Sterba wrote:
> > > > > > On 64K pages the size of the extent_buffer::pages array is 1 and
> > > > > > compilation with -Warray-bounds warns due to
> > > > > > 
> > > > > >     kaddr = page_address(eb->pages[idx + 1]);
> > > > > > 
> > > > > > when reading byte range crossing page boundary.
> > > > > > 
> > > > > > This does never actually overflow the array because on 64K because all
> > > > > > the data fit in one page and bounds are checked by check_setget_bounds.
> > > > > > 
> > > > > > To fix the reported overflow and warning add a copy of the non-crossing
> > > > > > read/write code and put it behind a condition that's evaluated at
> > > > > > compile time. That way only one implementation remains due to dead code
> > > > > > elimination.
> > > > > 
> > > > > Any chance we can use a flexible-array in struct extent_buffer instead,
> > > > > so all the warnings are removed?
> > > > > 
> > > > > Something like this:
> > > > > 
> > > > > diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> > > > > index 62027f551b44..b82e8b694a3b 100644
> > > > > --- a/fs/btrfs/extent_io.h
> > > > > +++ b/fs/btrfs/extent_io.h
> > > > > @@ -94,11 +94,11 @@ struct extent_buffer {
> > > > > 
> > > > >           struct rw_semaphore lock;
> > > > > 
> > > > > -       struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
> > > > >           struct list_head release_list;
> > > > >    #ifdef CONFIG_BTRFS_DEBUG
> > > > >           struct list_head leak_list;
> > > > >    #endif
> > > > > +       struct page *pages[];
> > > > >    };
> > > > 
> > > > But wouldn't that make the the size of extent_buffer structure change
> > > > and affect the kmem cache for it?
> > > 
> > > Could you please point out the places in the code that would be
> > > affected?
> > 
> > Sure, the direct code get affected is here:
> > 
> > extent_io.c:
> > int __init extent_io_init(void)
> > {
> >         extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
> >                         sizeof(struct extent_buffer), 0,
> >                         SLAB_MEM_SPREAD, NULL);
> > 
> > So here we can no longer use sizeof(struct extent_buffer);
> > 
> > Furthermore, this function is called at btrfs module load time,
> > at that time we have no idea how large the extent buffer could be, thus we
> > must allocate a large enough cache for extent buffer.
> > 
> > Thus the size will be fixed to the current size, no matter if we use flex
> > array or not.
> > 
> > Though I'm not sure if using such flex array with fixed real size can silent
> > the warning though.
> 
> Yeah; I think this might be the right solution:
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9e81d25dea70..4cf0b72fdd9f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -232,8 +232,9 @@ int __init extent_state_cache_init(void)
>  int __init extent_io_init(void)
>  {
>         extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
> -                       sizeof(struct extent_buffer), 0,
> -                       SLAB_MEM_SPREAD, NULL);
> +                       struct_size((struct extent_buffer *)0, pages,
> +                                   INLINE_EXTENT_BUFFER_PAGES),
> +                       0, SLAB_MEM_SPREAD, NULL);
>         if (!extent_buffer_cache)
>                 return -ENOMEM;
> 
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 62027f551b44..b82e8b694a3b 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -94,11 +94,11 @@ struct extent_buffer {
> 
>         struct rw_semaphore lock;
> 
> -       struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
>         struct list_head release_list;
>  #ifdef CONFIG_BTRFS_DEBUG
>         struct list_head leak_list;
>  #endif
> +       struct page *pages[];

IMHO this is going the wrong way, INLINE_EXTENT_BUFFER_PAGES is a
compile time constant and the array is not variable sized at all, so
adding the end member and using struct_size is just manually coding
what would compiler do for free.
