Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF535433FDA
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhJSUjS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 16:39:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44190 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJSUjS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 16:39:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 06B2921A71;
        Tue, 19 Oct 2021 20:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634675824;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=173+Ipihclh21h5LoFXso5QRZlB+rBbQy+6jpZkKWyk=;
        b=yTGq30QPCx46OkQIUcQH512cJNXa8E9u5wyoAwo/gdPAvQVmg6nuvDL9XjFUSxYi/vtjvN
        fetL0bFL3DyPE75Mm6XiF/bKMWisxeyLlQLwyCF8Wfr9VUwssqbr6I4hyiQg0/TzM3557i
        ZL9AmQvLh3HCgsXz2McqgXUF7cUUJ6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634675824;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=173+Ipihclh21h5LoFXso5QRZlB+rBbQy+6jpZkKWyk=;
        b=fxMppqlcPAXbjxUzbI1K/PVOCZjyZuxaX2ccwYCHiuOCLaDMvGeErSFnt3dVF4ngrkAEdo
        982EVKCi5N1W/+CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F26DAA3B81;
        Tue, 19 Oct 2021 20:37:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57810DA7A3; Tue, 19 Oct 2021 22:36:36 +0200 (CEST)
Date:   Tue, 19 Oct 2021 22:36:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add stub argument to transaction API
Message-ID: <20211019203636.GX30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20211018173803.18353-1-dsterba@suse.com>
 <YW3nBs4cr99TcyRL@localhost.localdomain>
 <20211019145412.GT30611@twin.jikos.cz>
 <YW8jMqfc6sZ7y7Bj@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW8jMqfc6sZ7y7Bj@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 03:57:38PM -0400, Josef Bacik wrote:
> On Tue, Oct 19, 2021 at 04:54:12PM +0200, David Sterba wrote:
> > On Mon, Oct 18, 2021 at 05:28:38PM -0400, Josef Bacik wrote:
> > > On Mon, Oct 18, 2021 at 07:38:03PM +0200, David Sterba wrote:
> > This is what needs to be done per caller.
> > 
> 
> Ooooh so we don't want to enforce NOFS for ALL trans handles, just some of them?

Practically all callers. If a transaction is running, a GFP_KERNEL
allocation could recurse back to btrfs when allocator decides to flush
some memory. The NOFS protection at the transaction start call wold not
be needed in case it's been already set by the caller for some reason.

> If that's the case can't we just do
> 
> trans = btrfs_join_transaction_nofs()/btrfs_start_transaction_nofs()
> 
> and then handle it internally?

This could work in case btrfs_join_transaction_nofs could store the
nofs_flags in a way that btrfs_start_transaction_nofs would see. But ...

> > > So
> > > the trans should be able to hold the flags since we only care about starting it
> > > and restoring it, correct?  Or am I wrong and we do actually need to pass this
> > > thing around?  In which case can't we still just save it in the trans handle,
> > > and pass the u32 around where appropriate?  Thanks,
> > 
> > I had to dig in my memory why we can't store it in the transaction
> > handle, because this is naturally less intrusive. But it does not work.
> > 
> > There are two things:
> > 
> > 1) In a function that starts/joins a transaction, the NOFS scope is from
> >    that call until the transaction end. This is caller-specific.
> >    Like in the example above, any allocation with GFP_KERNEL happening
> >    will be safe and not recurse back to btrfs.
> > 
> > 2) Transaction handle is not caller-specific and is allocated when the
> >    transaction starts (ie. a new kmem_cache_alloc call is done). Any
> >    caller of transaction start will only increase the reference count.
> 
> Right but we only really need to do the release when we free the trans handle,
> so in fact we can just leave it for the end of btrfs_end_transaction() when we
> free the trans handle and still be good.

Filipe's response made me think again if the lifetime of the NOFS scope
does match the exact lifetime of transaction handle, meaning it could be
stored inside it and the whole point of this patch would be moot.

I don't have a clear answer right now and would like to experiment with
that before pushing even this stub, because reverting it again in the
future would not be that funny.
