Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8C82AD8CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 15:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgKJO3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 09:29:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:41542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgKJO3S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 09:29:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E2DEABD1;
        Tue, 10 Nov 2020 14:29:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DDF5DDA7D7; Tue, 10 Nov 2020 15:27:35 +0100 (CET)
Date:   Tue, 10 Nov 2020 15:27:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 29/32] btrfs: scrub: introduce scrub_page::page_len for
 subpage support
Message-ID: <20201110142735.GG6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-30-wqu@suse.com>
 <20201109182541.GB6756@twin.jikos.cz>
 <4164e848-bd32-644b-feb5-0bb29ab84353@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4164e848-bd32-644b-feb5-0bb29ab84353@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 10, 2020 at 08:56:21AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/11/10 上午2:25, David Sterba wrote:
> > On Tue, Nov 03, 2020 at 09:31:05PM +0800, Qu Wenruo wrote:
> >> Currently scrub_page only has one csum for each page, this is fine if
> >> page size == sector size, then each page has one csum for it.
> >>
> >> But for subpage support, we could have cases where only part of the page
> >> is utilized. E.g one 4K sector is read into a 64K page.
> >> In that case, we need a way to determine which range is really utilized.
> >>
> >> This patch will introduce scrub_page::page_len so that we can know
> >> where the utilized range ends.
> > 
> > Actually, this should be sectorsize or nodesize? Ie. is it necessary to
> > track the length inside scrub_page at all? It might make sense for
> > convenience though.
> > 
> In the end, no need to track page_len for current implement.
> It's always sector size.
> 
> But that conflicts with the name "scrub_page", making it more
> "scrub_sector".

Yeah, that's would have to be updated as well and actually 'sector' is
what we want to use.

> Anyway, I need to update the scrub support patchset to follow the one
> sector one scrub_page policy.

I've added to misc-next, the other patches depend on the ->page_len
patch.

btrfs: scrub: refactor scrub_find_csum()
btrfs: scrub: remove the force parameter of scrub_pages
btrfs: scrub: distinguish scrub page from regular page
