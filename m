Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66CF751FB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 13:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjGMLQj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjGMLQi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 07:16:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D54211F
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hve6OzeHIkdD6xHt82S33eWJRp80zPJMC3v+8m4oMzU=; b=IJSgBUQcih5J9/NoVnDi/SLRKQ
        pEQBzUuM0/LjQsWqeYlpQHW0TKehFIUwYMoawsrzkcZgc3tGpUAWzgxasafhc8cYFikD6vIgO9jpm
        jQ+K0W9JOtzac9ZRRBqLVs2S7TJ1A0vaBWL/6l3UtABCl0zf93ZSjhZdpAwO6kuQmXfjgN6c28h2N
        Nus0X9NzFugACNIjaK2iSjRLb3dg3ncfIynmIWtsGndsHJBjRNa0VTOzCqx3XCEASGL5Gxuy/TLdR
        jZxHFgHHyUUFOJqWMMcs3oV1GGv0tyuaWj820R3GnYM8Cy64ZjPR33/2AwjDimfP71QLIq1YsKeLc
        VvCOv14Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJuJH-0033at-3D;
        Thu, 13 Jul 2023 11:16:36 +0000
Date:   Thu, 13 Jul 2023 04:16:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Message-ID: <ZK/dE1x4URVMAbBD@infradead.org>
References: <cover.1689143654.git.wqu@suse.com>
 <ZK7XwgBJZDpWFuz6@infradead.org>
 <ff78f3e8-6438-4b29-02c0-c14fb5949360@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff78f3e8-6438-4b29-02c0-c14fb5949360@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 13, 2023 at 07:58:17AM +0800, Qu Wenruo wrote:
> > Do we?  btrfs by default uses a 16k nodesize (order 2 on x86), with
> > a maximum of 64k (order 4).  IIRC we should be able to get them pretty
> > reliably.
> 
> If it can be done as reliable as order 0 with NOFAIL, I'm totally fine with
> that.

I think that is the aim.  I'm not entirely sure if we are entirely there
yes, thus the Ccs.

> > If not the best thning is to just a virtually contigous allocation as
> > fallback, i.e. use vm_map_ram.
> 
> That's also what Sweet Tea Dorminy mentioned, and I believe it's the correct
> way to go (as the fallback)
> 
> Although my concern is my lack of experience on MM code, and if those pages
> can still be attached to address space (with PagePrivate set).

At least they could back in the day when XFS did exactly that.  In fact
that was the use case why I added vmap originally back in 2002..

