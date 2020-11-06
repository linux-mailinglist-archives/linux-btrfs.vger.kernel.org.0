Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24E12A9AC6
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 18:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgKFR37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 12:29:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:46272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgKFR37 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 12:29:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EA7DABCC;
        Fri,  6 Nov 2020 17:29:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0D92DA6E3; Fri,  6 Nov 2020 18:28:17 +0100 (CET)
Date:   Fri, 6 Nov 2020 18:28:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 15/32] btrfs: introduce a helper to determine if the
 sectorsize is smaller than PAGE_SIZE
Message-ID: <20201106172816.GQ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-16-wqu@suse.com>
 <0eb2c642-f0df-a899-388d-2e1d9db6e5ae@suse.com>
 <5079f2e4-10b5-4024-1dd7-d2a59cc4945f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5079f2e4-10b5-4024-1dd7-d2a59cc4945f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 06, 2020 at 06:52:42AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/11/5 下午11:01, Nikolay Borisov wrote:
> >
> >
> > On 3.11.20 г. 15:30 ч., Qu Wenruo wrote:
> >> Just to save us several letters for the incoming patches.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>  fs/btrfs/ctree.h | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> >> index b46eecf882a1..a08cf6545a82 100644
> >> --- a/fs/btrfs/ctree.h
> >> +++ b/fs/btrfs/ctree.h
> >> @@ -3607,6 +3607,11 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
> >>  	return signal_pending(current);
> >>  }
> >>
> >> +static inline bool btrfs_is_subpage(struct btrfs_fs_info *fs_info)
> >> +{
> >> +	return (fs_info->sectorsize < PAGE_SIZE);
> >> +}
> >
> > This is conceptually wrong. The filesystem shouldn't care whether we are
> > diong subpage blocksize io or not. I.e it should be implemented in such
> > a way so that everything " just works". All calculation should be
> > performed based on the fs_info::sectorsize and we shouldn't care what
> > the value of PAGE_SIZE is. The central piece becomes sectorsize.
> 
> Nope, as long as we're using things like bio, we can't avoid the
> restrictions from page.
> 
> I can't get your point at all, I see nothing wrong here, especially when
> we still need to handle page lock for a lot of things.
> 
> Furthermore, this thing is only used inside btrfs, how could this be
> *conectpionally* wrong?

As Nik said, it should be built around sectorsize (even if some other
layers work with pages or bios). Conceptually wrong is adding special
cases instead of generalizing or abstracting the code so it also
supports pagesize != sectorsize.
