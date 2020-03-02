Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D645C1764DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 21:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCBU0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 15:26:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:55964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCBU0q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 15:26:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C1740AC2C;
        Mon,  2 Mar 2020 20:26:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32C2EDA7AA; Mon,  2 Mar 2020 21:26:23 +0100 (CET)
Date:   Mon, 2 Mar 2020 21:26:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/10] btrfs: relocation: Refactor build_backref_tree()
Message-ID: <20200302202622.GY2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200226055652.24857-1-wqu@suse.com>
 <20200228154555.GN2902@twin.jikos.cz>
 <99a7a002-65bb-6077-7303-c4076c34e05e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99a7a002-65bb-6077-7303-c4076c34e05e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 29, 2020 at 09:00:43AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/2/28 下午11:45, David Sterba wrote:
> > On Wed, Feb 26, 2020 at 01:56:42PM +0800, Qu Wenruo wrote:
> >> This branch can be fetched from github:
> >> https://github.com/adam900710/linux/tree/backref_cache_new
> > 
> > This is based on v5.6-rc1, you should base on something more recent.
> > There are many non-trivial conflicts at patch 5 so I stopped there but
> > if you and I like to get the pathes merged, the branch needs to be in a
> > state where it's not that hard to apply the patches.
> 
> Because it looks like current misc-next is not a good place to do proper
> testing, and it's undergoing frequent updates.

Well yes, that's the point and has been like that for a long time. It's
a development base that should be reasonably stable, IOW I add patches
there when the branch itself passes fstests and the to-be merged patches
pass as well.

For the 'reasonably stable' part, fixups and additional functional
updates should be minimal but they happen as this is branch that more
people start to test, unlike some random patchsets.

> Thus I choose the latest rc when I started the development.

Yes but you should also have rebased each week so the latest rc is
still the latest one.

> Currently the branch is only for review and my local testing, I just
> want to make sure that everything works fine before rebasing them to
> misc-next.

Maybe I have missed you saying it's for review and independent testing,
for cleanups this should make no difference once the branch is ported on
top of current devel queue (misc-next).

I still think that rebasing once a week on top of current rc+misc-next
is feasible and should save time to all of us in the future.

> Anyway, next time I'll mention the basis, and explicitly shows that I'll
> do the rebase (and retest) if you want to try merge.

Yes mentioning the patch base helps in case it's not something that
others would expect, which in most cases is misc-next.
