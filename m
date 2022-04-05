Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63C44F4786
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242542AbiDEVMg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445308AbiDEPms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 11:42:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA51925AF
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 07:08:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F229210EA;
        Tue,  5 Apr 2022 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649167705;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ut7C1JA9XhnnDGNCGdt7Qud6lr0KhM8xbdax0haJK+M=;
        b=GO7xXu5+oPmciQmmFMbdeKHEx9MuVZTHKM2FK5UWwYlmueF6Q3E5h+ToZPqyG3JgrIuGOJ
        rU9/jGZx7LjKmEGx2UkEdq51t9ZXApvfP51HxorgoTYTb2gjs0xnezoZB53XzPCkAj1AU/
        vYk+C/43aTpfriSJZcDpQr6/cnyDE/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649167705;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ut7C1JA9XhnnDGNCGdt7Qud6lr0KhM8xbdax0haJK+M=;
        b=x7tnDJvR94Bdfpl2+E8huURikqC9gSRdaTd53iFyrK8nSbE/v3+yzvTMP/3hWFf0a9Dx1j
        9bbp44qsntT9CBBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 65456A3B96;
        Tue,  5 Apr 2022 14:08:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 24436DA80E; Tue,  5 Apr 2022 16:04:23 +0200 (CEST)
Date:   Tue, 5 Apr 2022 16:04:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Message-ID: <20220405140423.GX15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <Yj3v+MnFOXeeAU9d@infradead.org>
 <YkvMcoK5m7tZ3GUM@infradead.org>
 <aee87ae7-bcf0-726e-b943-3499d4b142e8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee87ae7-bcf0-726e-b943-3499d4b142e8@gmx.com>
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

On Tue, Apr 05, 2022 at 01:08:41PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/4/5 12:58, Christoph Hellwig wrote:
> > On Fri, Mar 25, 2022 at 09:38:16AM -0700, Christoph Hellwig wrote:
> >>> -	memset(kaddr + pgoff, 1, len);
> >>> +	memzero_page(page, pgoff, len);
> >>>   	flush_dcache_page(page);
> >>
> >> memzero_page already takes care of the flush_dcache_page.
> >
> > David, you've picked this up with the stay flush_dcache_page left in
> > place.  Plase try to fix it up instead of spreading the weird cargo cult
> > flush_dcache_page calls.
> 
> Please drop this patch, as discussed with Filipe, the memset() value
> 0x01 could be a poison value to distinguish from plain 0x00.

> Furthermore, we are not sure if we even want to zeroing out/poison the
> content.

I've read the discussion and have been thinking what should we do here,
I'd be for doing memset to 0 because 0x1 is quite arbitrary and does not
follow any established pattern for poison values, if there's anything
like that when returning data from kernel to userspace. I find zeros
OK here. Arguably "It's been 0x1 forever so we should not change it" for
backward compatibility reasons could apply, but this is not an interface
that applications use, the error code is the interface.
