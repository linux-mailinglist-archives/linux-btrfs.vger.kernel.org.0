Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2D38AEE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 14:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243129AbhETMrh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 08:47:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:55016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241892AbhETMpu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 08:45:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 68E97ABE8;
        Thu, 20 May 2021 12:44:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 68FF3DA7F9; Thu, 20 May 2021 14:41:53 +0200 (CEST)
Date:   Thu, 20 May 2021 14:41:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
Message-ID: <20210520124153.GZ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Graham Cobb <g.btrfs@cobb.uk.net>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210518144935.15835-1-dsterba@suse.com>
 <PH0PR04MB741663051770A577220C0C539B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210519142612.GW7604@twin.jikos.cz>
 <PH0PR04MB74165244AB3C1AC48DF8DF379B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <29d4c680-e484-f0d0-3b25-a64b11f93230@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d4c680-e484-f0d0-3b25-a64b11f93230@cobb.uk.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 05:20:50PM +0100, Graham Cobb wrote:
> On 19/05/2021 16:32, Johannes Thumshirn wrote:
> > On 19/05/2021 16:28, David Sterba wrote:
> >> On Wed, May 19, 2021 at 06:53:54AM +0000, Johannes Thumshirn wrote:
> >>> On 18/05/2021 16:52, David Sterba wrote:
> >>> I wonder if this interface would make sense for limiting balance
> >>> bandwidth as well?
> >>
> >> Balance is not contained to one device, so this makes the scrub case
> >> easy. For balance there are data and metadata involved, both read and
> >> write accross several threads so this is really something that the
> >> cgroups io controler is supposed to do.
> >>
> > 
> > For a user initiated balance a cgroups io controller would work well, yes.
> 
> Hmmm. I might give this a try. On my main mail server balance takes a
> long time and a lot of IO, which is why I created my "balance_slowly"
> script which shuts down mail (and some other services) then runs balance
> for 20 mins, then cancels the balance and allows mail to run for 10
> minutes, then resumes the balance for 20 mins, etc. Using this each
> month, a balance takes over 24 hours but at least the only problem is
> short mail delays for 1 day a month, not timeouts, users seeing mail
> error reports, etc.
> 
> Before I did this, the impact was horrible: btrfs spent all its time
> doing backref searches and any process which touched the filesystem (for
> example to deliver a tiny email) could be stuck for over an hour.
> 
> I am wondering whether the cgroups io controller would help, or whether
> it would cause a priority inversion because the backrefs couldn't do the
> IO they needed so the delays to other processes locked out would get
> even **longer**. Any thoughts?

Do you do a full balance? On a mail server where files get created and
deleted the space could become quite fragmented so a balance from time
to time would make the space more compact. You can also start balance in
smaller batches eg. using the limit=N filter.

I haven't fully tested the cgroup io limiting, no success setting it up
with raw cgroups, but the systemd unit files have support for that so
maybe I'm doing it the wrong way.

The priority inversion could be an issue, relocation needs to commit the
changes so in general the metadata operations should not be throttled.
