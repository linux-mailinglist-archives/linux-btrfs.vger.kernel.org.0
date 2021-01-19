Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CFB2FBBBB
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391666AbhASPyb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 10:54:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:51122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391657AbhASPyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 10:54:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE6BDADD6;
        Tue, 19 Jan 2021 15:53:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 15959DA6E3; Tue, 19 Jan 2021 16:51:46 +0100 (CET)
Date:   Tue, 19 Jan 2021 16:51:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4 03/18] btrfs: introduce the skeleton of btrfs_subpage
 structure
Message-ID: <20210119155145.GO6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-4-wqu@suse.com>
 <20210118224647.GK6430@twin.jikos.cz>
 <65ab6681-f694-5cc4-1b2d-b33b70ba40a3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65ab6681-f694-5cc4-1b2d-b33b70ba40a3@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 19, 2021 at 06:54:28AM +0800, Qu Wenruo wrote:
> On 2021/1/19 上午6:46, David Sterba wrote:
> > On Sat, Jan 16, 2021 at 03:15:18PM +0800, Qu Wenruo wrote:
> >> +		return;
> >> +
> >> +	subpage = (struct btrfs_subpage *)detach_page_private(page);
> >> +	ASSERT(subpage);
> >> +	kfree(subpage);
> >> +}
> >> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> >> new file mode 100644
> >> index 000000000000..96f3b226913e
> >> --- /dev/null
> >> +++ b/fs/btrfs/subpage.h
> >> @@ -0,0 +1,31 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +
> >> +#ifndef BTRFS_SUBPAGE_H
> >> +#define BTRFS_SUBPAGE_H
> >> +
> >> +#include <linux/spinlock.h>
> >> +#include "ctree.h"
> >
> > So subpage.h would pull the whole ctree.h, that's not very nice. If
> > anything, the .c could include ctree.h because there are lots of the
> > common structure and function definitions, but not the .h. This creates
> > unnecessary include dependencies.
> >
> > Any pointer type you'd need in structures could be forward declared.
> 
> Unfortunately, the main needed pointer is fs_info, and we're accessing
> it pretty frequently (mostly for sector/node size).
> 
> I don't believe forward declaration would help in this case.

I've looked at the final subpage.h and you add way too many static
inlines that don't seem to be necessary for the reasons the static
inlines are supposed to be used.
