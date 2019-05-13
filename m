Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5CF1BF55
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 00:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfEMWF1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 18:05:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:50104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfEMWF0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 18:05:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B21DBAF25;
        Mon, 13 May 2019 22:05:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 98998DA853; Tue, 14 May 2019 00:06:26 +0200 (CEST)
Date:   Tue, 14 May 2019 00:06:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] Btrfs: fix race between send and deduplication that
 lead to failures and crashes
Message-ID: <20190513220626.GL3138@twin.jikos.cz>
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
 <20190513191003.GK3138@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513191003.GK3138@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 09:10:03PM +0200, David Sterba wrote:
> On Mon, May 13, 2019 at 06:05:54PM +0100, Filipe Manana wrote:
> > On Mon, May 13, 2019 at 5:57 PM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Mon, May 13, 2019 at 05:18:37PM +0100, Filipe Manana wrote:
> > > > I would leave it as it is unless users start to complain. Yes, the
> > > > test does this on purpose.
> > > > Adding such code/state seems weird to me, instead I would change the
> > > > rate limit state so that the messages would repeat much less
> > > > frequently.
> > >
> > > The difference to the state tracking is that the warning would be
> > > printed repeatedly, which I find unnecessary and based on past user
> > > feedback, there will be somebody asking about that.
> > >
> > > The rate limiting can also skip a message that can be for a different
> > > subvolume, so this makes it harder to diagnose problems.
> > >
> > > Current state is not satisfactory at least for me because it hurts
> > > testing, the test runs for about 2 hours now, besides the log bloat. The
> > 
> > You mean the test case for fstests (btrfs/187) takes 2 hours for you?
> 
> This is on a VM with file-backed devices, that I use for initial tests
> of patches before they go to other branches.

Update: it took about 6 minutes in another round, so the test does work
in that setup.
