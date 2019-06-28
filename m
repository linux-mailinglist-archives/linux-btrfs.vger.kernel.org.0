Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F915A116
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 18:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF1Qhb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 12:37:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:51236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbfF1Qhb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 12:37:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70DE0ABCD;
        Fri, 28 Jun 2019 16:37:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E3B2ADAC70; Fri, 28 Jun 2019 18:38:15 +0200 (CEST)
Date:   Fri, 28 Jun 2019 18:38:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
Message-ID: <20190628163815.GH20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
 <dafc56c9-1cd8-2727-049d-99db6504b7e2@suse.de>
 <20190628113458.GF20977@twin.jikos.cz>
 <a13ec40a-1839-aa2b-894d-4e0e3bd4d81c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a13ec40a-1839-aa2b-894d-4e0e3bd4d81c@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 28, 2019 at 08:09:46PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/6/28 下午7:34, David Sterba wrote:
> > On Fri, Jun 28, 2019 at 09:26:53AM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2019/6/27 下午10:58, David Sterba wrote:
> >>> On Tue, Jun 25, 2019 at 04:24:57PM +0800, Qu Wenruo wrote:
> >>>> Ping?
> >>>>
> >>>> This patch should fix the problem of compressed extent even when
> >>>> nodatasum is set.
> >>>>
> >>>> It has been one year but we still didn't get a conclusion on where
> >>>> force_compress should behave.
> >>>
> >>> Note that pings to patches sent year ago will get lost, I noticed only
> >>> because you resent it and I remembered that we had some discussions,
> >>> without conclusions.
> >>>
> >>>> But at least to me, NODATASUM is a strong exclusion for compress, no
> >>>> matter whatever option we use, we should NEVER compress data without
> >>>> datasum/datacow.
> >>>
> >>> That's correct, but the way you fix it is IMO not right. This was also
> >>> noticed by Nikolay, that there are 2 locations that call
> >>> inode_need_compress but with different semantics.
> >>>
> >>> One is the decision if compression applies at all,
> >>
> >>> and the second one
> >>> when that's certain it's compression, to do it or not based on the
> >>> status decision of eg. heuristics.
> >>
> >> The second call is in compress_file_extent(), with inode_need_compress()
> >> return 0 for NODATACOW/NODATASUM inodes, we will not go into
> >> cow_file_range_async() branch at all.
> >>
> >> So would you please explain how this could cause problem?
> >> To me, prevent the problem in inode_need_compress() is the safest location.
> > 
> > Let me repeat: two places with different semantics. So this means that
> > we need two functions that reflect the differences. That it's in one
> > function that works both contexts is ok from functionality point of
> > view, but if we care about clarity of design and code we want two
> > functions.
> >
> 
> OK, so in next version I'll split the inode_need_compress() into two
> functions for different semantics:
> - inode_can_compress()
>   The hard requirement for compress code. E.g. COW and checksum checks.
> - inode_need_compress()
>   The soft requirement, for things like ratio, force_compress checks.
> 
> Will this modification be fine?

Yes.
