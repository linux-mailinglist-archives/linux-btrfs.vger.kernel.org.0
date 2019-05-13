Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950E61BD98
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 21:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfEMTJD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 15:09:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728856AbfEMTJD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 15:09:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83525AF24;
        Mon, 13 May 2019 19:09:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 95CAFDA851; Mon, 13 May 2019 21:10:03 +0200 (CEST)
Date:   Mon, 13 May 2019 21:10:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] Btrfs: fix race between send and deduplication that
 lead to failures and crashes
Message-ID: <20190513191003.GK3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190415083018.2224-1-fdmanana@kernel.org>
 <20190422154342.11873-1-fdmanana@kernel.org>
 <20190513155607.GD3138@twin.jikos.cz>
 <20190513160704.GE3138@twin.jikos.cz>
 <CAL3q7H7SQEr-jm9tvM8LM_tt6xqSNUU6DLnx3Mmg7n86_y6z1A@mail.gmail.com>
 <20190513165853.GG3138@twin.jikos.cz>
 <CAL3q7H5v8+A5X4sLS_O2NGYcZxhBKauw4LgbXp+36iHkRow+cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5v8+A5X4sLS_O2NGYcZxhBKauw4LgbXp+36iHkRow+cw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 06:05:54PM +0100, Filipe Manana wrote:
> On Mon, May 13, 2019 at 5:57 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, May 13, 2019 at 05:18:37PM +0100, Filipe Manana wrote:
> > > I would leave it as it is unless users start to complain. Yes, the
> > > test does this on purpose.
> > > Adding such code/state seems weird to me, instead I would change the
> > > rate limit state so that the messages would repeat much less
> > > frequently.
> >
> > The difference to the state tracking is that the warning would be
> > printed repeatedly, which I find unnecessary and based on past user
> > feedback, there will be somebody asking about that.
> >
> > The rate limiting can also skip a message that can be for a different
> > subvolume, so this makes it harder to diagnose problems.
> >
> > Current state is not satisfactory at least for me because it hurts
> > testing, the test runs for about 2 hours now, besides the log bloat. The
> 
> You mean the test case for fstests (btrfs/187) takes 2 hours for you?

This is on a VM with file-backed devices, that I use for initial tests
of patches before they go to other branches. It's a slow setup but helps
me to identify problems early as I can run a few in parallel.  I'd still
like to have the run time below say 5 hours (currently it's 4). Though I
can skip some thests I'd rather not due to coverage, but if there's no
other way I'll have to.

> For me it takes under 8 minutes for an unpatched btrfs, while a
> patched btrfs takes somewhere between 1 minute and 3 minutes. This is
> on VMs, with a debug kernel, average/cheap host hardware, etc.

On a another host, VM with physical disks it's closer to that time, it
took about 13 minutes which is acceptable.
