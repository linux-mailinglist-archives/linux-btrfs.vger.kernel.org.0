Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575C0723C08
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 10:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbjFFIk6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 04:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbjFFIkz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 04:40:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3E7F4;
        Tue,  6 Jun 2023 01:40:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-973f78329e3so919035866b.3;
        Tue, 06 Jun 2023 01:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686040846; x=1688632846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cyJ5tDSZZP8etKKPv923PF92ppsCaio89dIjb2PYMe4=;
        b=rBtWPmSdoicxYr9srl8qFvlifhG4ncOpiQ0k+oysrF2gKHOlEUJImacRwNQ8KLliw+
         O2UE4hz78ZOqYrQNafFU7Cesy32D2iCONGiqqmC/kK9gTqqHrr+OI1xHhc9E0AHHGv9U
         fBVmYY732dapdOHvfPXrlbLU6AD9w5uPIY19yJ1iYkJJtQkitigUv3GfvZ7apFoEsa74
         X8TYvbVy7L7L7BVCtm2l4Oz0bt4xuQfqd9CbF5l5PlzHvToUmJcRxK4+t9nSKMW8TuZ7
         /I+ANqkGyVYBR+uPj2IhlpX0tXAdJPFDEst1U4x2d0hoQiGmM2dW+ioy4Nbo8F2XCbM9
         dOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686040846; x=1688632846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyJ5tDSZZP8etKKPv923PF92ppsCaio89dIjb2PYMe4=;
        b=Ri3eNFNnrni/kr4z8pA9LIoPkPp8FbQEU2OA8XFEbYtj5bHegf57n9mPI8qHusyk7i
         h1i1/OpgTscHkMIZeag25f+/pO3gvGmH1AbEBYojL+Z+HVaH9ulPX7xCGww58Tu5ybw2
         9z3SFKXM5fP/aPlP72NyzGZP7GfViyO6Uz6yC7yYgawIDs+toGicA+U1kDeIluMGrmsV
         h8P60fCVFXvF41yxCZoe16OlDJxLYvYCMdT1RWsI8lHbnqIK2n4aSBQWzTCpnrlzxMbu
         bOq4VqUs2ORW3fNfiHTsfRrcdUzfRmJqDiUK4J2XNbL349KKhoASy/7+ygHjE3OJUT+Z
         QdcQ==
X-Gm-Message-State: AC+VfDwtOgbdivbxgQYvD9+tHxA6BEHgT2ZFh7T2DFabAXrKdwK/38lT
        KYaQGSF4FTgQEq/1L6gPhLk=
X-Google-Smtp-Source: ACHHUZ6pFnvGHkcMvgdY6pglmR751hr8lQG7zM/2O8y9sStd9w/m4NVvvDxsA5SPNqZM+PguT3Pnuw==
X-Received: by 2002:a17:906:4fcb:b0:961:a67:28d with SMTP id i11-20020a1709064fcb00b009610a67028dmr2251830ejw.22.1686040845514;
        Tue, 06 Jun 2023 01:40:45 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id ca15-20020a170906a3cf00b00977c44188eesm4051149ejb.132.2023.06.06.01.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:40:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 6 Jun 2023 10:40:43 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
Message-ID: <ZH7xCy9QBmMLg9SQ@pc638.lan>
References: <20230605201107.83298-1-lstoakes@gmail.com>
 <cd47d6ac-69ce-0315-dd45-2cb9dce57f36@suse.cz>
 <ZH7rfgeKzhmZzjA1@pc638.lan>
 <5062a28d-3c49-4510-8e0f-32afb8436a87@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5062a28d-3c49-4510-8e0f-32afb8436a87@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 06, 2023 at 09:24:33AM +0100, Lorenzo Stoakes wrote:
> On Tue, Jun 06, 2023 at 10:17:02AM +0200, Uladzislau Rezki wrote:
> > On Tue, Jun 06, 2023 at 09:13:24AM +0200, Vlastimil Babka wrote:
> > >
> > > On 6/5/23 22:11, Lorenzo Stoakes wrote:
> > > > In __vmalloc_area_node() we always warn_alloc() when an allocation
> > > > performed by vm_area_alloc_pages() fails unless it was due to a pending
> > > > fatal signal.
> > > >
> > > > However, huge page allocations instigated either by vmalloc_huge() or
> > > > __vmalloc_node_range() (or a caller that invokes this like kvmalloc() or
> > > > kvmalloc_node()) always falls back to order-0 allocations if the huge page
> > > > allocation fails.
> > > >
> > > > This renders the warning useless and noisy, especially as all callers
> > > > appear to be aware that this may fallback. This has already resulted in at
> > > > least one bug report from a user who was confused by this (see link).
> > > >
> > > > Therefore, simply update the code to only output this warning for order-0
> > > > pages when no fatal signal is pending.
> > > >
> > > > Link: https://bugzilla.suse.com/show_bug.cgi?id=1211410
> > > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > >
> > > I think there are more reports of same thing from the btrfs context, that
> > > appear to be a 6.3 regression
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=217466
> > > Link: https://lore.kernel.org/all/efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com/
> > >
> > I had a look at that report. The btrfs complains due to the
> > fact that a high-order page(1 << 9) can not be obtained. In the
> > vmalloc code we do not fall to 0-order allocator if there is
> > a request of getting a high-order.
> 
> This isn't true, we _do_ fallback to order-0 (this is the basis of my patch), in
> __vmalloc_node_range():-
> 
> 	/* Allocate physical pages and map them into vmalloc space. */
> 	ret = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
> 	if (!ret)
> 		goto fail;
> 
> ...
> 
> fail:
> 	if (shift > PAGE_SHIFT) {
> 		shift = PAGE_SHIFT;
> 		align = real_align;
> 		size = real_size;
> 		goto again;
> 	}
> 
> With the order being derived from shift, and __vmalloc_area_node() only being
> called from __vmalloc_node_range().
> 
Correct. It is done on an upper-layer whereas i checked the vm_area_alloc_pages() function.
But as you mentioned, the refactoring has to be done as it looks a bit messy. 

--
Uladzislau Rezki
