Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5C54ECBC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 20:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350010AbiC3SVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 14:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350078AbiC3SV2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 14:21:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08763BA4F
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 11:19:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0C11B2112B;
        Wed, 30 Mar 2022 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648664356;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANUMl50/AMkmspKmA3fWSIo3K2OWAs33T2jEsYB1vsI=;
        b=BRksMWDzxdlpo+uVcFuHiCDNsEVJsRvQK33Fy/7Oe/Tduv9+zzY0ELdAfKjmh8+ehVEyVJ
        DdproZu1UW3s7Ata7dtZQr53GlsFIjMgiTrBgMSHhw0LmPOCFGxcovgZ0nABl90y3yV62M
        rQYV2iGKJ7kAigrz5Gc1t4mD29RVwaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648664356;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANUMl50/AMkmspKmA3fWSIo3K2OWAs33T2jEsYB1vsI=;
        b=rJtXqkUuKDkzv2Ly79tY+xMncqpG3qbYks2o69F16nsw63hsqowKJ7ro/LFYncWVNOZLg6
        N/p4jg96YptL6+Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 02441A3B88;
        Wed, 30 Mar 2022 18:19:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E8BFFDA7F3; Wed, 30 Mar 2022 20:15:17 +0200 (CEST)
Date:   Wed, 30 Mar 2022 20:15:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/3] btrfs: make nodesize >= PAGE_SIZE case to reuse
 the non-subpage routine
Message-ID: <20220330181517.GI2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220113052210.23614-1-wqu@suse.com>
 <20220113052210.23614-3-wqu@suse.com>
 <20220310191348.GC12643@twin.jikos.cz>
 <4aa2fb3a-b200-cc6a-5aef-d263fef9f2ba@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa2fb3a-b200-cc6a-5aef-d263fef9f2ba@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 11, 2022 at 02:28:37PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/11 03:13, David Sterba wrote:
> > On Thu, Jan 13, 2022 at 01:22:09PM +0800, Qu Wenruo wrote:
> >> --- a/fs/btrfs/subpage.h
> >> +++ b/fs/btrfs/subpage.h
> >> @@ -4,6 +4,7 @@
> >>   #define BTRFS_SUBPAGE_H
> >>
> >>   #include <linux/spinlock.h>
> >> +#include "btrfs_inode.h"
> >>
> >>   /*
> >>    * Extra info for subpapge bitmap.
> >> @@ -74,6 +75,30 @@ enum btrfs_subpage_type {
> >>   	BTRFS_SUBPAGE_DATA,
> >>   };
> >>
> >> +static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
> >> +				    struct page *page)
> >
> > This is static inline and increases the size of the module by 3K, it
> > does not need to be inline as it's not in any perf critical code.
> 
> I thought the compiler is able to un-inline such functions if it doesn't
> believe the inline is useful.

Inlining of regular is a compiler decision but if you declare a function
'static inline' then it's meant to be defined in a header and it must be
inlined. Once the code is "inserted" it can be optimized further so
there may be different results of the same C code in the assembly code
but that's it. That's what we care about from the programmer's view,
there are many possibilities for compiler to reorganize the code,
parition hot/cold paths and partially/completely inline and whatnot, but
that's basically magic we can't rely on.

Anyway, as the inline was the only thing I've made it a regular
function. On release build the function is inlined anyway in all calls
in subpage.c as the function body is available. I'm tempted to make it
'noinline' but this is going against the compiler decisions described
above. Patches added to misc-next.
