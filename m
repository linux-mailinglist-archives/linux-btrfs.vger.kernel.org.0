Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2F838AE39
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhETMcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 08:32:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:44212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232942AbhETMcA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 08:32:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FE7EABCD;
        Thu, 20 May 2021 12:30:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 31014DA7F9; Thu, 20 May 2021 14:28:04 +0200 (CEST)
Date:   Thu, 20 May 2021 14:28:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
Message-ID: <20210520122803.GY7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210518144935.15835-1-dsterba@suse.com>
 <PH0PR04MB741663051770A577220C0C539B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210519142612.GW7604@twin.jikos.cz>
 <PH0PR04MB74165244AB3C1AC48DF8DF379B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74165244AB3C1AC48DF8DF379B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 03:32:48PM +0000, Johannes Thumshirn wrote:
> On 19/05/2021 16:28, David Sterba wrote:
> > On Wed, May 19, 2021 at 06:53:54AM +0000, Johannes Thumshirn wrote:
> >> On 18/05/2021 16:52, David Sterba wrote:
> >> I wonder if this interface would make sense for limiting balance
> >> bandwidth as well?
> > 
> > Balance is not contained to one device, so this makes the scrub case
> > easy. For balance there are data and metadata involved, both read and
> > write accross several threads so this is really something that the
> > cgroups io controler is supposed to do.
> 
> For a user initiated balance a cgroups io controller would work well, yes.
> But for having a QoS mechanism to decide when it's a good time to rebalance
> one or more block groups, i.e. with a zoned file system or when we switch
> to auto-balance in the future I'm not sure if cgroups would help us much
> in this case.

Hm right, the background jobs can't be started with the cgroup
controllers. I'm not sure if there's an internal cgroup api to do that,
also that would interfere with the system cgroup settings.

For zoned mode the bg reclaim is crucial to make it work and the
thresholds should be set to make the reclam as fast as possible.
