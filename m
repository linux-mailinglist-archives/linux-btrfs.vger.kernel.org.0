Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224BC2AD959
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 15:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgKJOze (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 09:55:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:36212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730981AbgKJOzd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 09:55:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FDBAABD1;
        Tue, 10 Nov 2020 14:55:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D6037DA7D7; Tue, 10 Nov 2020 15:53:49 +0100 (CET)
Date:   Tue, 10 Nov 2020 15:53:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 15/32] btrfs: introduce a helper to determine if the
 sectorsize is smaller than PAGE_SIZE
Message-ID: <20201110145348.GJ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-16-wqu@suse.com>
 <0eb2c642-f0df-a899-388d-2e1d9db6e5ae@suse.com>
 <5079f2e4-10b5-4024-1dd7-d2a59cc4945f@gmx.com>
 <20201106172816.GQ6756@twin.jikos.cz>
 <8633b9b2-42f3-4916-b252-c9f9a23382a0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8633b9b2-42f3-4916-b252-c9f9a23382a0@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 07, 2020 at 08:00:26AM +0800, Qu Wenruo wrote:
> >>>> +static inline bool btrfs_is_subpage(struct btrfs_fs_info *fs_info)
> >>>> +{
> >>>> +	return (fs_info->sectorsize < PAGE_SIZE);
> >>>> +}
> >>>
> >>> This is conceptually wrong. The filesystem shouldn't care whether we are
> >>> diong subpage blocksize io or not. I.e it should be implemented in such
> >>> a way so that everything " just works". All calculation should be
> >>> performed based on the fs_info::sectorsize and we shouldn't care what
> >>> the value of PAGE_SIZE is. The central piece becomes sectorsize.
> >>
> >> Nope, as long as we're using things like bio, we can't avoid the
> >> restrictions from page.
> >>
> >> I can't get your point at all, I see nothing wrong here, especially when
> >> we still need to handle page lock for a lot of things.
> >>
> >> Furthermore, this thing is only used inside btrfs, how could this be
> >> *conectpionally* wrong?
> >
> > As Nik said, it should be built around sectorsize (even if some other
> > layers work with pages or bios). Conceptually wrong is adding special
> > cases instead of generalizing or abstracting the code so it also
> > supports pagesize != sectorsize.
> >
> Really? For later patches you will see some unavoidable difference anyway.

Yeah some of the new sector/page combinations will need some thinking
how to handle them without sacrificing code quality.

> One example is page->private for metadata.
> For regular case, page-private is a pointer to eb, which is never
> feasible for subpage case.
> 
> It's OK to be ideal, but not OK to be too ideal.

I'm always trying to take the practical approach because with a long
development period and with many people contributing and with doing too
many compromises the code becomes way below the ideal. You may have
heared yourself or others bitching about some old code, but we have
enough group knowledge and experience not to let bad coding patterns
continue coming back once painfully cleaned up.
