Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33910576FE6
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jul 2022 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiGPPeU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jul 2022 11:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPPeT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jul 2022 11:34:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1F1DA4B;
        Sat, 16 Jul 2022 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wOpN4Xcrm1wWfOr3I3YP/LITpvpz8YcLjWLbz+//1Fg=; b=tB3vlOW8KjBf1503ZZOl4AMcSm
        2zgrOZlMyXQx5taC7Z3Wn0ql7nCVlPZ0jY2c6WTrZTQnKMj9OqioZFIc+Jo8zHa/aeEB5nxEpMPka
        utB1j2CM0vclX7z7u4TBAcjMwr4tyrWn0C4K9E4flGeEVIvgVdAlnYW5jRRY+V+D0WvF8qV09OWRB
        J4QFz+ZwfJTDdZGLqdrqzbXhGPvkCwkXkpiur9TB+71DBkJLbc0vWWkJ6ofha2XfSJIAGxOj0cDj5
        vy66LNTtASl4Tcr314ty0NBQk4fkuPQaEy7OfThgMhdfYQoOdgctEJTWDJACQLKGmNVu++JrKk1if
        9abj4y1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCjo4-00BA99-Uc; Sat, 16 Jul 2022 15:34:13 +0000
Date:   Sat, 16 Jul 2022 16:34:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 5.19-rc7
Message-ID: <YtLadOkHl0lDNwbM@casper.infradead.org>
References: <cover.1657976305.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657976305.git.dsterba@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 16, 2022 at 04:06:20PM +0200, David Sterba wrote:
> Note about the xarray API:
> 
> The possible sleeping is documented next to xa_insert, however there's
> no runtime check for that, like is eg. in radix_tree_preload.  The
> context does not need to be atomic so it's not as simple as
> 
>   might_sleep_if(gfpflags_allow_blocking(gfp));
> 
> or
> 
>   WARN_ON_ONCE(gfpflags_allow_blocking(gfp));
> 
> Some kind of development time debugging/assertion aid would be nice.

Are you saying that
https://git.infradead.org/users/willy/xarray.git/commitdiff/c195d497ca1ff673c2e6935152a0a5b6be2efdc9

is wrong?  It's been in linux-next for the last week since you drew it
to my attention that this would be useful.
