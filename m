Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D93D7923
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhG0Ozb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 10:55:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51564 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhG0Oza (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 10:55:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E394522198;
        Tue, 27 Jul 2021 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627397213;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wtXdwMjMyP4WAU9I4sJHOJCU4RjIAg+ii9xInTrnyXE=;
        b=1JIzNiiGjXWFxxIr6vgo5gzz1QYeT1xjjuHw8s8+6ubMkof0cfBQ0WKnIjF9wCUUqvT78X
        /PO3kXO2yeBdb7yOZhKgctoOfKG0PFQjLgC0htgri9+MBD5nbNR5bErug15mqndLwtqtOX
        UDzOuNm8d5Xi1TqanTsROpnIn/Colgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627397213;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wtXdwMjMyP4WAU9I4sJHOJCU4RjIAg+ii9xInTrnyXE=;
        b=hb3EzYrB+pMg3n0HghbYGMZRcUGNvvefx+yocu5nXhgkMFXD6T6ZFoj48NZWzqBjREWupK
        /0/pcwH7X5olUJAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DC466A3B85;
        Tue, 27 Jul 2021 14:46:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A8F4DA8CC; Tue, 27 Jul 2021 16:44:09 +0200 (CEST)
Date:   Tue, 27 Jul 2021 16:44:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/10] btrfs: add and use simple page/bio to
 inode/fs_info helpers
Message-ID: <20210727144409.GS5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <4d3594dcca4dd8a8e58b134409922c2787b6a757.1627300614.git.dsterba@suse.com>
 <6cac34b2-39ba-f344-d601-b78a3f0c7698@gmx.com>
 <20210726150953.GG5047@twin.jikos.cz>
 <cc110ee1-c1bf-2b83-b5db-f70468b159f7@gmx.com>
 <20210727084552.GK5047@twin.jikos.cz>
 <aee4baab-b288-0520-545e-f1c28cac3e09@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee4baab-b288-0520-545e-f1c28cac3e09@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 05:42:10PM +0800, Qu Wenruo wrote:
> >    ({ ASSERT(page); ASSERT(page->mapping); page->mapping->host; })
> 
> ASSERT(page) is not needed.
> 
> ASSERT(page->mapping) is what I think is necessary.
> 
> With something like ({ ASSERT(page); page->mapping->host; }), it still 
> looks fine to me.

Ok, let's do that.

> > Or perhaps also page with a temporary variable to avoid multiple
> > evaluations.
> > 
> > The helpers are used in a handful of places, if we really care about
> > consistency of the assertions, something like assert_page_ok(page) would
> > have to be in each function that gets the page from other subsystems.
> > 
> 
> The call site that should really be concerned is compression, which 
> utilize anonymous pages, along with cached pages.
> (Scrub is another case, but scrub never mix cached pages with anonymous, 
> thus it's less a concern)
> 
> In fact, during subpage compression development, I have already exposed 
> several locations where we are trying to pass anonymous page with 
> manually populated page->i_mapping.
> 
> Thus I'm sensitive to this problem.
> 
> So far in your code, it's not touching compression code, thus it's fine 
> for now.
> 
> But it's just a problem of time before next refactor to use this macros 
> for compression code.
> 
> Without proper ASSERT(), it's super easy to cause problems IMHO.

Ok then.
