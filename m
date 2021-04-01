Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82CF351ADE
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhDASDN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 14:03:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235737AbhDAR5f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 13:57:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 347D9B23F;
        Thu,  1 Apr 2021 17:57:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C975CDA790; Thu,  1 Apr 2021 19:55:25 +0200 (CEST)
Date:   Thu, 1 Apr 2021 19:55:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210401175525.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210329185338.GV7604@twin.jikos.cz>
 <dc64f94d-52ad-9c36-534e-5a84bf449448@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc64f94d-52ad-9c36-534e-5a84bf449448@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 01, 2021 at 01:36:56PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/3/30 上午2:53, David Sterba wrote:
> > On Thu, Mar 25, 2021 at 03:14:32PM +0800, Qu Wenruo wrote:
> >> v3:
> >> - Rename the sysfs to supported_sectorsizes
> >>
> >> - Rebased to latest misc-next branch
> >>    This removes 2 cleanup patches.
> >>
> >> - Add new overview comment for subpage metadata
> >
> > V3 is now in for-next, targeting merge for 5.13. Please post any fixups
> > as replies to the individual patches, I'll fold them in, rather a full
> > series resend. Thanks.
> >
> Is it possible to drop patch "[PATCH v3 04/13] btrfs: refactor how we
> iterate ordered extent in btrfs_invalidatepage()"?

Dropped, there were no conflicts in the followup patches.

> Since in the series, there are no other patches touching it, dropping it
> should not involve too much hassle.
> 
> The problem here is, how we handle ordered extent really belongs to the
> data write path.
> 
> Furthermore, after all the data RW related testing, it turns out that
> the ordered extent code has several problems:
> 
> - Separate indicators for ordered extent
>    We use PagePriavte2 to indicate whether we have pending ordered extent
>    io.
>    But it is not properly integrated into ordered extent code, nor really
>    properly documented.
> 
> - Complex call sites requirement
>    For endio we don't care whether we finished the ordered extent, while
>    for invalidatepage, we don't really need to bother if we finished all
>    the ordered extents in the range.
> 
>    Thus we really don't need to bother who finished the ordered extents,
>    but just want to mark the io finished for the range.
> 
> - Lack subpage compatibility
>    That's why I'm here complaining, especially due to the PagePrivate2
>    usage.
>    It needs to be converted to a new bitmap.
> 
> There will be a refactor on the btrfs_dec_test_*_ordered_pending()
> functions soon, and obvious the existing call sites will all be gone.
> 
> Thus that fourth patch makes no sense.

Ok, thanks for the explanation.
