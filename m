Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2312AD8AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 15:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgKJOYC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 09:24:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:37386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbgKJOYC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 09:24:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A76CABD6;
        Tue, 10 Nov 2020 14:24:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 337F0DA7D7; Tue, 10 Nov 2020 15:22:19 +0100 (CET)
Date:   Tue, 10 Nov 2020 15:22:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 27/32] btrfs: scrub: use flexible array for
 scrub_page::csums
Message-ID: <20201110142218.GF6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-28-wqu@suse.com>
 <20201109174449.GZ6756@twin.jikos.cz>
 <35ae2a3c-5c98-4f78-cc88-ad0dbea93d32@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35ae2a3c-5c98-4f78-cc88-ad0dbea93d32@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 10, 2020 at 08:53:15AM +0800, Qu Wenruo wrote:
> On 2020/11/10 上午1:44, David Sterba wrote:
> > On Tue, Nov 03, 2020 at 09:31:03PM +0800, Qu Wenruo wrote:
> >> There are several factors affecting how many checksum bytes are needed
> >> for one scrub_page:
> >>
> >> - Sector size and page size
> >>   For subpage case, one page can contain several sectors, thus the csum
> >>   size will differ.
> >>
> >> - Checksum size
> >>   Since btrfs supports different csum size now, which can vary from 4
> >>   bytes for CRC32 to 32 bytes for SHA256.
> >>
> >> So instead of using fixed BTRFS_CSUM_SIZE, now use flexible array for
> >> scrub_page::csums, and determine the size at scrub_page allocation time.
> >>
> >> This does not only provide the basis for later subpage scrub support,
> > 
> > I'd like to know more how this would help for the subpage support.
> 
> For the future, if we utilize the full page for scrub (other than
> current only use sector size of the page content), we could benefit from
> the flexible array.
> 
> E.g. 4K sector size, 64K page size, SHA256 csum.
> For one full 64K page, it can contain 16 sectors, and each sector need
> full 32 bytes for csum.
> Making it to 512 bytes, which is definitely not supported by current code.

I see, then it would make sense to adapt the structure size according to
the page/sectorsize and not waste the reserved space.
> 
> But that's in the future, as current subpage scrub still uses at most
> BTRFS_CSUM_SIZE for each scrub_page.
> 
> > 
> >> but also reduce the memory usage for default btrfs on x86_64.
> >> As the default CRC32 only uses 4 bytes, thus we can save 28 bytes for
> >> each scrub page.
> > 
> > Because even with the flexible array, the allocation is from the generic
> > slabs and scrub_page is now 128 bytes, so saving 28 bytes won't make any
> > difference.
> > 
> OK, I could discard the patch for now.

Yeah, it would be better to add this patch and also the code that makes
use of it.
