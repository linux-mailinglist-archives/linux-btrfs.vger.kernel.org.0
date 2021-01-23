Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4169930180E
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 20:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbhAWTkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 14:40:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:55600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbhAWTkL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 14:40:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05379AD18;
        Sat, 23 Jan 2021 19:39:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7749CDA823; Sat, 23 Jan 2021 20:37:44 +0100 (CET)
Date:   Sat, 23 Jan 2021 20:37:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4 03/18] btrfs: introduce the skeleton of btrfs_subpage
 structure
Message-ID: <20210123193744.GB1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-4-wqu@suse.com>
 <20210118224647.GK6430@twin.jikos.cz>
 <65ab6681-f694-5cc4-1b2d-b33b70ba40a3@gmx.com>
 <20210119155145.GO6430@twin.jikos.cz>
 <20210119160625.GP6430@twin.jikos.cz>
 <7a48d6b7-8620-b3ff-8bee-386da50f11bc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a48d6b7-8620-b3ff-8bee-386da50f11bc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 20, 2021 at 08:19:14AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/1/20 上午12:06, David Sterba wrote:
> > On Tue, Jan 19, 2021 at 04:51:45PM +0100, David Sterba wrote:
> >> On Tue, Jan 19, 2021 at 06:54:28AM +0800, Qu Wenruo wrote:
> >>> On 2021/1/19 上午6:46, David Sterba wrote:
> >>>> On Sat, Jan 16, 2021 at 03:15:18PM +0800, Qu Wenruo wrote:
> >>>>> +		return;
> >>>>> +
> >>>>> +	subpage = (struct btrfs_subpage *)detach_page_private(page);
> >>>>> +	ASSERT(subpage);
> >>>>> +	kfree(subpage);
> >>>>> +}
> >>>>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> >>>>> new file mode 100644
> >>>>> index 000000000000..96f3b226913e
> >>>>> --- /dev/null
> >>>>> +++ b/fs/btrfs/subpage.h
> >>>>> @@ -0,0 +1,31 @@
> >>>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>>> +
> >>>>> +#ifndef BTRFS_SUBPAGE_H
> >>>>> +#define BTRFS_SUBPAGE_H
> >>>>> +
> >>>>> +#include <linux/spinlock.h>
> >>>>> +#include "ctree.h"
> >>>>
> >>>> So subpage.h would pull the whole ctree.h, that's not very nice. If
> >>>> anything, the .c could include ctree.h because there are lots of the
> >>>> common structure and function definitions, but not the .h. This creates
> >>>> unnecessary include dependencies.
> >>>>
> >>>> Any pointer type you'd need in structures could be forward declared.
> >>>
> >>> Unfortunately, the main needed pointer is fs_info, and we're accessing
> >>> it pretty frequently (mostly for sector/node size).
> >>>
> >>> I don't believe forward declaration would help in this case.
> >>
> >> I've looked at the final subpage.h and you add way too many static
> >> inlines that don't seem to be necessary for the reasons the static
> >> inlines are supposed to be used.
> >
> > The only file that includes subpage.h is extent_io.c, so as long as it
> > stays like that it's manageable. But untangling the include hell still
> > needs to hapen some day and new code that makes it harder worries me.
> >
> If going through the github branch, you will see there are more files
> using subpage.h:
> - extent_io.c
> - disk-io.c
> - file.c
> - inode.c
> - reflink.c
> - relocation.c
> 
> And furthermore, about the static inline abuse, the part really need
> that static inline is the check against regular sector size, and
> unfortunately, most outside callers need such check.
> 
> I can put the pure subpage callers into subpage.c, but the generic
> helpers handling both cases still need that.

I had a look and this is too much. Just by counting 'static inline'
(wher it's also part of the btrfs_page_clamp_* helpers) it's 30 and not
all the functions are short enough for static inlines. Please make them
all regular functions and put them to subpage.c and don't include
ctree.h.
