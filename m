Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFDE723B6C
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 10:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjFFIYt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 04:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjFFIYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 04:24:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E502E5A;
        Tue,  6 Jun 2023 01:24:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso58688965e9.0;
        Tue, 06 Jun 2023 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686039876; x=1688631876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sC2zaZ5AH58dTh9Jtx/RuHH2964IovbhkMPo4QlS6Fo=;
        b=nDs1sWlIYHoowxg8dky0kdZsxWQABL+VLeSkHNzN3190XZsmTJGMUhstythN/o+hMk
         aTT21yXVD6oABrDzAdr9RM1ayLPeWKeA2FOPxOKhzpRySVdwwTaFd/cHDwFuj126SrXG
         Y4A8LDeG6qK1PhKSebx/xlJPNc/qDWkdB5RkBXHZru0PzmFamJwstrWOuxahyv6MyiR6
         20JIYYMTsQRAZ5Yv2bMoZklh4Ag87inm1eoiPNfiksWR8qUK2qYeyoadin39TP1Y5ELZ
         KZop/acXgjtl4qVzbWg4XeptR0sVjwSfcIsKIaUpeaDk/nubP5RxkMVMpdD0u5A5JnSq
         HJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686039876; x=1688631876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC2zaZ5AH58dTh9Jtx/RuHH2964IovbhkMPo4QlS6Fo=;
        b=bR2lJeuR7zyoXbj+q6uYlqAjqRyI1gcGq6JWzo7W7DHQ4/fxYhlpFuJ34VUGGClCMv
         +M9dhB1T86iZ29vh8BjlVdH6CMgDga9SzVd2YPDS+mXXCb7An3EnQ7a8azXdFCwJEXSH
         4DaGMyBr3ItN/aHNvweOP/OI2O4PiZE/hfU2PcaN2uRQoFf2Z/DaqZC2TdsjBvVqplvZ
         ZDbXPhsBQ7EUDjwppKb1HayqruoBg+Tb57eyvLS3HJrvJSDwihvH07RJSYlk6okuZrqc
         IDdzyxzEjUFyIKPHPacuuM7EBTPLTr4SkHIZRjvEeUMbaNaDNn8Og3cdK8In6EDA+ilD
         6Xmw==
X-Gm-Message-State: AC+VfDyZXxPqTz5jYpaU+LUGdfAv0MNhJRMJI2t1/nXwz5VnvPGnD3Ob
        nAkrsmtyCKWmmBhK6PKwepo=
X-Google-Smtp-Source: ACHHUZ4ixr2Y5nL+BNcM0DrD/x46n9rd0PmAEfUjY2luNjKX9yV/RR2dn0evXdgX17FnS7v5j0iHdg==
X-Received: by 2002:a05:600c:ac1:b0:3f7:2858:7a8b with SMTP id c1-20020a05600c0ac100b003f728587a8bmr1657511wmr.32.1686039875444;
        Tue, 06 Jun 2023 01:24:35 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b003f6f6a6e769sm13224810wmc.17.2023.06.06.01.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:24:34 -0700 (PDT)
Date:   Tue, 6 Jun 2023 09:24:33 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz,
        Forza <forza@tnonline.net>
Subject: Re: [PATCH] mm/vmalloc: do not output a spurious warning when huge
 vmalloc() fails
Message-ID: <5062a28d-3c49-4510-8e0f-32afb8436a87@lucifer.local>
References: <20230605201107.83298-1-lstoakes@gmail.com>
 <cd47d6ac-69ce-0315-dd45-2cb9dce57f36@suse.cz>
 <ZH7rfgeKzhmZzjA1@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH7rfgeKzhmZzjA1@pc638.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 06, 2023 at 10:17:02AM +0200, Uladzislau Rezki wrote:
> On Tue, Jun 06, 2023 at 09:13:24AM +0200, Vlastimil Babka wrote:
> >
> > On 6/5/23 22:11, Lorenzo Stoakes wrote:
> > > In __vmalloc_area_node() we always warn_alloc() when an allocation
> > > performed by vm_area_alloc_pages() fails unless it was due to a pending
> > > fatal signal.
> > >
> > > However, huge page allocations instigated either by vmalloc_huge() or
> > > __vmalloc_node_range() (or a caller that invokes this like kvmalloc() or
> > > kvmalloc_node()) always falls back to order-0 allocations if the huge page
> > > allocation fails.
> > >
> > > This renders the warning useless and noisy, especially as all callers
> > > appear to be aware that this may fallback. This has already resulted in at
> > > least one bug report from a user who was confused by this (see link).
> > >
> > > Therefore, simply update the code to only output this warning for order-0
> > > pages when no fatal signal is pending.
> > >
> > > Link: https://bugzilla.suse.com/show_bug.cgi?id=1211410
> > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> >
> > I think there are more reports of same thing from the btrfs context, that
> > appear to be a 6.3 regression
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=217466
> > Link: https://lore.kernel.org/all/efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com/
> >
> I had a look at that report. The btrfs complains due to the
> fact that a high-order page(1 << 9) can not be obtained. In the
> vmalloc code we do not fall to 0-order allocator if there is
> a request of getting a high-order.

This isn't true, we _do_ fallback to order-0 (this is the basis of my patch), in
__vmalloc_node_range():-

	/* Allocate physical pages and map them into vmalloc space. */
	ret = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
	if (!ret)
		goto fail;

...

fail:
	if (shift > PAGE_SHIFT) {
		shift = PAGE_SHIFT;
		align = real_align;
		size = real_size;
		goto again;
	}

With the order being derived from shift, and __vmalloc_area_node() only being
called from __vmalloc_node_range().

>
> I provided a patch to fallback if a high-order. A reproducer, after
> applying the patch, started to get oppses in another places.
>
> IMO, we should fallback even for high-order requests. Because it is
> highly likely it can not be accomplished.
>
> Any thoughts?
>
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 31ff782d368b..7a06452f7807 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2957,14 +2957,18 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                         page = alloc_pages(alloc_gfp, order);
>                 else
>                         page = alloc_pages_node(nid, alloc_gfp, order);
> +
>                 if (unlikely(!page)) {
> -                       if (!nofail)
> -                               break;
> +                       if (nofail)
> +                               alloc_gfp |= __GFP_NOFAIL;
>
> -                       /* fall back to the zero order allocations */
> -                       alloc_gfp |= __GFP_NOFAIL;
> -                       order = 0;
> -                       continue;
> +                       /* Fall back to the zero order allocations. */
> +                       if (order || nofail) {
> +                               order = 0;
> +                               continue;
> +                       }
> +
> +                       break;
>                 }
>
>                 /*
> <snip>
>
>
>
> --
> Uladzislau Rezki

I saw that, it seems to be duplicating the same thing as the original fallback
code is (which was originally designed to permit higher order non-__GFP_NOFAIL
allocations before trying order-0 __GFP_NOFAIL).

I don't think it is really useful to change this as it confuses that logic and
duplicates something we already do.

Honestly though moreover I think this whole area needs some refactoring.
