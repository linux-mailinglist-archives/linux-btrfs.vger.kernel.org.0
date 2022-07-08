Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ED856AF6D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 02:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiGHAYx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 20:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiGHAYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 20:24:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E0370E55
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 17:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=81mRSSBAvSZB4P0FukUyEEdAqCn3W92aWiX0IHMuHt4=; b=YSNEiTKFrwJS/k09wn63C/f7j/
        u+Cr0PhNrhZIuZFZ79okY3UPBQLKse9cU4NHtXq6ZQEsSsbrS/vZUfVELQGvUtdBZalUg0jf61y69
        fJlJ+pWMxdTyHtTrsIpvF32Bomj0pW/hm3dc7ukhFGxOBdkwwXC/i7Mccl2cgh8TLhBYqMSkNKsFY
        AlxLzbUE0vl+onTpLPcwW0QjvkZ6EivPO15HVHkkAX0V4RaDYlsP71D46ZpGa9kshcjIpF4lJzgA5
        HD9e9oT6yu/xTq+XCDm/+5byNZkQDbAh9qxZGpauLagUDB4FuTJxdsX41aopGImeEU1OZNWhzVH54
        3aR59l0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9bnb-0032uA-5D; Fri, 08 Jul 2022 00:24:47 +0000
Date:   Fri, 8 Jul 2022 01:24:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     dsterba@suse.cz, fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fix a couple sleeps while holding a spinlock
Message-ID: <Ysd5TzHhzK2vwF0K@casper.infradead.org>
References: <cover.1657097693.git.fdmanana@suse.com>
 <20220707163144.GG15169@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707163144.GG15169@twin.jikos.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 07, 2022 at 06:31:44PM +0200, David Sterba wrote:
> Adding Matthew to CC
> 
> On Wed, Jul 06, 2022 at 10:09:44AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > After the recent conversions of a couple radix trees to XArrays, we now
> > can end up attempting to sleep while holding a spinlock.
> 
> Ouch, I worked on the asumption that the old preload API is
> transparently provided by xarray and that sleeping under spinlock won't
> happen, otherwise the conversion from radix to xarray is not just an API
> rename. Note that for some time the radix_tree structure was just an
> alias for xarray, so this is not a new behaviour.

Umm ... the *structure* is identical, but the *API* is not.  Or the
conversion would have happened long ago.  There is no preload API
for the XArray because it's one of the worst features of the radix
tree API.
