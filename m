Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111924ECA57
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 19:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbiC3RPL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244733AbiC3RPK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 13:15:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570E1112
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 10:13:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s11so19345850pfu.13
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XHnW0NSEnakA3BWxQmS2KHOCW1smyiv1a1icHQn2hq8=;
        b=AzzP7ZxlXlILZYL/k6HTewtbyvJIDsTf4M0RntjoI9MsvfFOfEhDQJCj6lGx1UsJPw
         P94F01IHh/6Gw+s78lr6cNIMoI/lsmRJgK00plBB32Iw6WTY47QK41/enXO/h48r6nPf
         e76ESqxHq0KGwvy55EX4oJP/67UgZOk2a2WZMv2vZjp8/jJuJ+GtrnIFi2IgA37mIY0h
         w7Np/vw9zS4Cn9qq3pLW8O4CNcR+d6lIDP0YRRb0Sh8berGn+IXCVW39JIPCT2778DQn
         zqshu7xdX/EcULODCkYBx9zU4B69fj9Fm/6GQq9MtWklAwegDD2ITTTXqSHXMpbNNyph
         f8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XHnW0NSEnakA3BWxQmS2KHOCW1smyiv1a1icHQn2hq8=;
        b=rkyDHqdrBeAGyOEAMgr0XWuaUFcoUA+g6SXqRIH3lVjtU8ut0AqNyLo/EAADdJCHy/
         twr7atQSmA6vHDtkBQyAfCcAz/7rpvKNM2lONHk90iAbRCY4CL1OMwOb5KgO4RnkUHgS
         1n7ierbVNwiDqdlIBjFBLVi5p1t0j4cVjwwNE123nno36gqNWAR3siLQy7nP9wyvXzrC
         +AW71dwKbH+scbDCHmxq1noFu8l0fn1t6rUL9723p4BufS3LxdeduqXVROxsnHOIDvsZ
         eKuWScFzt/2OYZVARISNa9w4MeOdfvcSaelpDV5MrTMXA7/MekZzKkU2k7aF5vQ/Hh4R
         SMFQ==
X-Gm-Message-State: AOAM532Ku/7P1HgYZc50uVHUohO8p7aAFrttabsEQUCWcMgT0Leybd91
        FJhQI+B9ZoGruVcQqDUDgOG8wwlDkU5JIw==
X-Google-Smtp-Source: ABdhPJw3fvWuaCOGd5se0nu9xpjzvY3gaO6ZEl3uYnUsR5ltumQ3R0ecUrS3S4zGrK190fw9OMRe3Q==
X-Received: by 2002:a63:6849:0:b0:398:a546:1c46 with SMTP id d70-20020a636849000000b00398a5461c46mr3813928pgc.100.1648660403934;
        Wed, 30 Mar 2022 10:13:23 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:7694])
        by smtp.gmail.com with ESMTPSA id j3-20020a056a00234300b004faabba358fsm24536980pfj.14.2022.03.30.10.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 10:13:23 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:13:21 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v14 5/7] btrfs: send: allocate send buffer with
 alloc_page() and vmap() for v2
Message-ID: <YkSPsV0l0JV1Lx1f@relinquished.localdomain>
References: <cover.1647537027.git.osandov@fb.com>
 <4353fe7122eb0aae24e3c9ff2399f2b58b74f79e.1647537027.git.osandov@fb.com>
 <fb73fe9a-21a4-0744-2a61-bfd3602a0f20@dorminy.me>
 <YkR/QuBrKPYTwIFt@relinquished.localdomain>
 <598151ee-7a14-0c54-34d6-4591bc19fb73@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <598151ee-7a14-0c54-34d6-4591bc19fb73@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 30, 2022 at 12:33:48PM -0400, Sweet Tea Dorminy wrote:
> 
> 
> On 3/30/22 12:03, Omar Sandoval wrote:
> > On Thu, Mar 24, 2022 at 01:53:20PM -0400, Sweet Tea Dorminy wrote:
> > > 
> > > 
> > > On 3/17/22 13:25, Omar Sandoval wrote:
> > > > From: Omar Sandoval <osandov@fb.com>
> > > > 
> > > > For encoded writes, we need the raw pages for reading compressed data
> > > > directly via a bio.
> > > Perhaps:
> > > "For encoded writes, the existing btrfs_encoded_read*() functions expect a
> > > list of raw pages."
> > > 
> > > I think it would be a better to continue just vmalloc'ing a large continuous
> > > buffer and translating each page in the buffer into its raw page with
> > > something like is_vmalloc_addr(data) ? vmalloc_to_page(data) :
> > > virt_to_page(data). Vmalloc can request a higher-order allocation, which
> > > probably doesn't matter but might slightly improve memory locality. And in
> > > terms of readability, I somewhat like the elegance of having a single
> > > identical kvmalloc call to allocate and send_buf in both cases, even if we
> > > do need to initialize the page list for some v2 commands.
> > 
> > I like this, but are we guaranteed that kvmalloc() will return a
> > page-aligned buffer? It seems reasonable to me that it would for
> > allocations of at least one page, but I can't find that written down
> > anywhere.
> 
> Since vmalloc allocates whole pages, and kmalloc guarantees alignment to the
> allocation size for powers of 2 sizes (and PAGE_SIZE is required to be a
> power of 2), I think that adds up to a guarantee of page alignment both
> ways?
> 
> https://elixir.bootlin.com/linux/v5.17.1/source/include/linux/slab.h#L522 :
> kmalloc: "For @size of power of two bytes, the alignment is also guaranteed
> to be at least to the size."

Our allocation size is ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED, PAGE_SIZE),
which is 144K for PAGE_SIZE = 4k. If I interpret the kmalloc() comment
very literally, since this isn't a power of two, it's not guaranteed to
be aligned, right?
