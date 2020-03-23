Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77BB18FDA1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 20:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgCWT3O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 15:29:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:47644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbgCWT3N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 15:29:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 903B6AA7C;
        Mon, 23 Mar 2020 19:29:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46850DA81D; Mon, 23 Mar 2020 20:28:42 +0100 (CET)
Date:   Mon, 23 Mar 2020 20:28:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix removal of raid[56|1c34} incompat flags after
 removing block group
Message-ID: <20200323192841.GM12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200320184348.845248-1-fdmanana@kernel.org>
 <8107ef53-5317-327c-674e-d5bd1b9d1e4d@gmx.com>
 <20200321174553.GK12659@twin.jikos.cz>
 <9eac14a3-b6fc-87e5-097e-b8aca1043398@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eac14a3-b6fc-87e5-097e-b8aca1043398@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 22, 2020 at 08:42:20AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/3/22 上午1:45, David Sterba wrote:
> > On Sat, Mar 21, 2020 at 09:43:21AM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2020/3/21 上午2:43, fdmanana@kernel.org wrote:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> We are incorrectly dropping the raid56 and raid1c34 incompat flags when
> >>> there are still raid56 and raid1c34 block groups, not when we do not any
> >>> of those anymore. The logic just got unintentionally broken after adding
> >>> the support for the raid1c34 modes.
> >>>
> >>> Fix this by clear the flags only if we do not have block groups with the
> >>> respective profiles.
> >>>
> >>> Fixes: 9c907446dce3 ("btrfs: drop incompat bit for raid1c34 after last block group is gone")
> >>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>
> >> The fix is OK.
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>
> >> Just interesting do we really need to remove such flags?
> >> To me, keep the flag is completely sane.
> > 
> > So you'd suggest to keep a flag for a feature that's not used on the
> > filesystem so it's not possible to mount the filesystem on an older
> > kernel?
> > 
> If user is using this feature, they aren't expecting mounting it on
> older kernel either.

Before we go in a loop throwing single statements, let me take a broader
look.

First thing, the removal of incompat bit was asked for by users, Hugo is
as reporter in the commit 6d58a55a894e863.

https://lore.kernel.org/linux-btrfs/20190610144806.GB21016@carfax.org.uk/

  "   We've had a couple of cases in the past where people have tried out
  a new feature on a new kernel, then turned it off again and not been
  able to go back to an earlier kernel. Particularly in this case, I can
  see people being surprised at the trapdoor. "I don't have any RAID13C
  on this filesystem: why can't I go back to 5.2?"

That itself is a strong sign to me that there's a need or usecase or a
good idea. Though we have a lot of them, this one was simple to
implement and made sense to me. For the raid56 it's a simple check,
unlike for other features that would need to go through significant
portion of metadata.

Booting older kernel might sound like, why would anybody want to do
that, but if the bit is there preventing boot/mount, then it's an
unnecessary complication. In rescue environmnents it's gold.

Usability improvements tend to be boring from code POV but it is
something that users can observe and make use of.
