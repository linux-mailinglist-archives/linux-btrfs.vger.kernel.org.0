Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C15BB922
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388270AbfIWQJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 12:09:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:48144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387893AbfIWQJf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 12:09:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01AF1B66F;
        Mon, 23 Sep 2019 16:09:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3783EDA871; Mon, 23 Sep 2019 18:09:55 +0200 (CEST)
Date:   Mon, 23 Sep 2019 18:09:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: ctree: Reduce one indent level for
 btrfs_search_slot()
Message-ID: <20190923160955.GJ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190910074019.23158-1-wqu@suse.com>
 <20190910074019.23158-2-wqu@suse.com>
 <c5db2dfd-19df-685c-71fb-e7e0e59a0b85@suse.com>
 <cd8d32b6-77fa-6d7c-c610-00e126904375@gmx.com>
 <04fc077c-3184-0ba8-9a12-c7b1fd08df7c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04fc077c-3184-0ba8-9a12-c7b1fd08df7c@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 10, 2019 at 11:42:47AM +0300, Nikolay Borisov wrote:
> 
> 
> On 10.09.19 г. 11:31 ч., Qu Wenruo wrote:
> > 
> > 
> > On 2019/9/10 下午4:24, Nikolay Borisov wrote:
> >>
> >>
> >> On 10.09.19 г. 10:40 ч., Qu Wenruo wrote:
> >>> In btrfs_search_slot(), we something like:
> >>>
> >>> 	if (level != 0) {
> >>> 		/* Do search inside tree nodes*/
> >>> 	} else {
> >>> 		/* Do search inside tree leaves */
> >>> 		goto done;
> >>> 	}
> >>>
> >>> This caused extra indent for tree node search code.
> >>> Change it to something like:
> >>>
> >>> 	if (level == 0) {
> >>> 		/* Do search inside tree leaves */
> >>> 		goto done'
> >>> 	}
> >>> 	/* Do search inside tree nodes */
> >>>
> >>> So we have more space to maneuver our code, this is especially useful as
> >>> the tree nodes search code is more complex than the leaves search code.
> >>>
> >>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>
> >> I actually thing this patch makes comprehending the function worse.
> > 
> > If the level == 0 lines is over 50 lines, maybe.
> > 
> > But it's just 22 lines.
> >> Because the else is now somewhat implicit. E.g. one has to pay careful
> >> attention to the contents inside the first if and especially the
> >> unconditional 'goto done' to be able to understand the code after the
> >> 'if' construct.
> > 
> > That's the same for the original code, you need to go a level upper to
> > see we're in level > 0 branch.
> 
> But that's explicit with the 'if'

Well, I don't see a strong reason for one or another. I see your point
about the explicit 'if/else' for a condition that has two exclusive
options.

I looked at the code with the patch applied and regarding readability,
the if (level == 0) block is short enough to be seen at once and is an
'take a shortcut here'. The indentation level reduction improvement
seems justified to me.
