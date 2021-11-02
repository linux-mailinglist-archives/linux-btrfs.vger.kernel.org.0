Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A6C443074
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 15:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhKBOfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 10:35:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46948 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhKBOfV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 10:35:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F31731FD4E;
        Tue,  2 Nov 2021 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635863566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+qNI0dR+OZ/wPXWLBQ/kyHxs+TPGWGI7fLFcR5zxiy0=;
        b=eYZ2yf6sZNew9ZNffej8H9W/hFZ7vYQATm0exgQFZ04fh0n1b/fVMtCLtLO0reIf6eRGYD
        Ft4SHumtmGcSyaDSG6mGeQlsY5WSfvfyOCt7WYe68XC9sOUYt+LIalZF1Dt99uFkhA3HES
        Ie7IdE4kUEjG8zFrJcAQVQojitNUIQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635863566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+qNI0dR+OZ/wPXWLBQ/kyHxs+TPGWGI7fLFcR5zxiy0=;
        b=py42Z4qIynLrPxHml1rXEUXjQurTDvnj1e1UOO/Rg2rseUuLIQpn6MvtO/7hjHMn3TefLh
        pGtKemDe15mJtUDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E577FA3B88;
        Tue,  2 Nov 2021 14:32:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A049BDA7A9; Tue,  2 Nov 2021 15:32:10 +0100 (CET)
Date:   Tue, 2 Nov 2021 15:32:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Btrfs updates for 5.16
Message-ID: <20211102143210.GJ20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1635773880.git.dsterba@suse.com>
 <CAHk-=wjowO+mmVBoiWkCk6LeqVTYVBp0ruSUPN2z0_ObKisPYw@mail.gmail.com>
 <351dac77-310c-40f5-b9c0-ce7f03f723f9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <351dac77-310c-40f5-b9c0-ce7f03f723f9@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 02, 2021 at 08:08:22AM +0800, Qu Wenruo wrote:
> On 2021/11/2 04:03, Linus Torvalds wrote:
> > On Mon, Nov 1, 2021 at 9:46 AM David Sterba <dsterba@suse.com> wrote:
> > it's correct.
> >
> > Or maybe I messed up entirely.
> >
> > I did end up comparing it to your other branch too, but that was
> > equally as messy, apart from the "ok, I can mindlessly just take your
> > side".
> >
> > And it was fairly different from what I had done in my merge
> > resolution, so who knows.
> >
> > ANYWAY. What I'm trying to say is that you should look very very
> > carefully at commits
> >
> >    2cf3f8133bda ("btrfs: fix lzo_decompress_bio() kmap leakage")
> 
> Since I'm doing the revert manually for lzo part, I double checked the code.
> 
> It turns out, your fix is the same as the original version I sent to
> David (although not through the mail list).
> Full patch attached.
> 
> @@ -345,8 +358,9 @@ int lzo_decompress_bio(struct list_head *ws, struct
> compressed_bio *cb)
>   		       (cur_in + LZO_LEN - 1) / sectorsize);
>   		cur_page = cb->compressed_pages[cur_in / PAGE_SIZE];
>   		ASSERT(cur_page);
> -		seg_len = read_compress_length(page_address(cur_page) +
> -					       offset_in_page(cur_in));
> +		kaddr = kmap(cur_page);
> +		seg_len = read_compress_length(kaddr + offset_in_page(cur_in));
> +		kunmap(cur_page);
>   		cur_in += LZO_LEN;
> 
> Thus it looks like by somehow my version is not applied?

Yeah, I had a look what you sent me, that version was correct. The
mistake was on my side, a copy&paste error, sorry.
