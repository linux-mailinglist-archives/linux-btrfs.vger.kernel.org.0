Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8917239D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 09:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjFFHmg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 03:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjFFHlp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 03:41:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0723D1733;
        Tue,  6 Jun 2023 00:41:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30ae967ef74so4526826f8f.0;
        Tue, 06 Jun 2023 00:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686037260; x=1688629260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q02VMVV6a5mqDYOgkecqdsRCWj1sQmCKyjrDOCTCTiA=;
        b=Z8IPTJ6St8ijvSNbBViuSpCfeNj53xQBDuBOgwpJuU8+5bnHJZmHlEAZG6zOuZz/2u
         03GtHPrAAyFBwSz+5AhUJkDlVBOU2AcYwczAYYXBvFZzxg+b7+Ln3NRSb4r20lw8QvEM
         XtAjTioyZi6P1r/df3OYe/XGNbRB0MvbU9JGjceTRcL/w3acNKJtKUhQGg8n7J7RdoJx
         MgSfeW/r0VNzl1W9ike6GjPVa61025sbq1/IuRB59hS9LErPI6nBK7MDjqllBOrMa8/2
         hSGmFrDfLBMxOorsTsG2LYIvz996R6euVWwwdU29Aoc4ohdomK+1c1GEChkqMKhmGzOT
         bUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686037260; x=1688629260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q02VMVV6a5mqDYOgkecqdsRCWj1sQmCKyjrDOCTCTiA=;
        b=g7/Z4cCy8ygDBueLJ96BV27ZGrqAmpFYDi3rVXuyuIyBEdrxS5WoEfkherQM6pDruU
         YNb59JifEryXSbhA1HCBtoLU+FxSP05kBWR35O+BQnQp7NgqaLAwYMqtySPGKVta7ZJV
         vtc8yFCimBSXs51h0RZbLfORtbpzgoaSxnQxC9fc/iwIqwOhkg81jzsuUikrmaVa68Gt
         RinpEgrNg9fTcnHfOm8zylGIQdbj49pbMAQZgcGdl00HWEGv6rF+a+HtC4AfBmOHbmxa
         UDFdYbLPHplkVakUc6aYtV7hvDvLR1nOCkZtTwWc9ge3zYz3EflNn4z9g5YWouxGTwFg
         Wuzw==
X-Gm-Message-State: AC+VfDz78LGG9SJWWSMVqFGeDW5TT59bhdyWHB7wrxOGdtmdHVnmRfxX
        ncrjylR2eAHpb7eJR1FnErxM3ZM68H4=
X-Google-Smtp-Source: ACHHUZ6TLYFd4Dxobh0/0obSA2bWZtpVg2zb8zP5vwIxG/Okp2U6Rt65IWyqlcXtEQyNVSpO9vmOdA==
X-Received: by 2002:a05:6000:1287:b0:30d:e113:2dd6 with SMTP id f7-20020a056000128700b0030de1132dd6mr1193262wrx.62.1686037260159;
        Tue, 06 Jun 2023 00:41:00 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id z6-20020a1c4c06000000b003f42ceb3bf4sm13107348wmf.32.2023.06.06.00.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 00:40:59 -0700 (PDT)
Date:   Tue, 6 Jun 2023 08:40:58 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz,
        Forza <forza@tnonline.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <song@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/vmalloc: do not output a spurious warning when huge
 vmalloc() fails
Message-ID: <f6b42d95-09f1-48d6-8274-e6145febb31d@lucifer.local>
References: <20230605201107.83298-1-lstoakes@gmail.com>
 <cd47d6ac-69ce-0315-dd45-2cb9dce57f36@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd47d6ac-69ce-0315-dd45-2cb9dce57f36@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 06, 2023 at 09:13:24AM +0200, Vlastimil Babka wrote:
>
> On 6/5/23 22:11, Lorenzo Stoakes wrote:
> > In __vmalloc_area_node() we always warn_alloc() when an allocation
> > performed by vm_area_alloc_pages() fails unless it was due to a pending
> > fatal signal.
> >
> > However, huge page allocations instigated either by vmalloc_huge() or
> > __vmalloc_node_range() (or a caller that invokes this like kvmalloc() or
> > kvmalloc_node()) always falls back to order-0 allocations if the huge page
> > allocation fails.
> >
> > This renders the warning useless and noisy, especially as all callers
> > appear to be aware that this may fallback. This has already resulted in at
> > least one bug report from a user who was confused by this (see link).
> >
> > Therefore, simply update the code to only output this warning for order-0
> > pages when no fatal signal is pending.
> >
> > Link: https://bugzilla.suse.com/show_bug.cgi?id=1211410
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> I think there are more reports of same thing from the btrfs context, that
> appear to be a 6.3 regression
>
> https://bugzilla.kernel.org/show_bug.cgi?id=217466
> Link: https://lore.kernel.org/all/efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com/
>
> If this indeed helps, it would make sense to Cc: stable here. Although I
> don't see what caused the regression, the warning itself is not new, so is
> it new source of order-9 attempts in vmalloc() or new reasons why order-9
> pages would not be possible to allocate?

Linus updated kvmalloc() to use huge vmalloc() allocations in 9becb6889130
("kvmalloc: use vmalloc_huge for vmalloc allocations") and Song update
alloc_large_system_hash() to as well in f2edd118d02d ("page_alloc: use
vmalloc_huge for large system hash") both of which are ~1y old, however
these would impact ~5.18, so it's weird to see reports citing 6.2 -> 6.3.

Will dig to see if something else changed that would increase the
prevalence of this.

Also while we're here, ugh at us immediately splitting the non-compound
(also ugh) huge page. Nicholas explains why in the patch that introduces it
- 3b8000ae185c ("mm/vmalloc: huge vmalloc backing pages should be split
rather than compound") - but it'd be nice if we could find a way to avoid
this.

If only there were a data type (perhaps beginning with 'f') that abstracted
the order of the page entirely and could be guaranteed to always be the one
with which you manipulated ref count, etc... ;)

>
> > ---
> >  mm/vmalloc.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index ab606a80f475..e563f40ad379 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3149,11 +3149,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  	 * allocation request, free them via vfree() if any.
> >  	 */
> >  	if (area->nr_pages != nr_small_pages) {
> > -		/* vm_area_alloc_pages() can also fail due to a fatal signal */
> > -		if (!fatal_signal_pending(current))
> > +		/*
> > +		 * vm_area_alloc_pages() can fail due to insufficient memory but
> > +		 * also:-
> > +		 *
> > +		 * - a pending fatal signal
> > +		 * - insufficient huge page-order pages
> > +		 *
> > +		 * Since we always retry allocations at order-0 in the huge page
> > +		 * case a warning for either is spurious.
> > +		 */
> > +		if (!fatal_signal_pending(current) && page_order == 0)
> >  			warn_alloc(gfp_mask, NULL,
> > -				"vmalloc error: size %lu, page order %u, failed to allocate pages",
> > -				area->nr_pages * PAGE_SIZE, page_order);
> > +				"vmalloc error: size %lu, failed to allocate pages",
> > +				area->nr_pages * PAGE_SIZE);
> >  		goto fail;
> >  	}
> >
>
