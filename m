Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF22D6897
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 21:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390014AbgLJUWj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 15:22:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:37692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgLJUWi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 15:22:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ACAE9AC6A;
        Thu, 10 Dec 2020 20:21:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DE15EDA842; Thu, 10 Dec 2020 21:20:20 +0100 (CET)
Date:   Thu, 10 Dec 2020 21:20:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: scrub: warn if scrub started on a device
 has mq-deadline
Message-ID: <20201210202020.GH6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Sidong Yang <realwakka@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20201205184929.22412-1-realwakka@gmail.com>
 <SN4PR0401MB35981F791C9508429506EDA09BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35981F791C9508429506EDA09BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 07, 2020 at 07:23:03AM +0000, Johannes Thumshirn wrote:
> On 05/12/2020 19:51, Sidong Yang wrote:
> > Warn if scurb stared on a device that has mq-deadline as io-scheduler
> > and point documentation. mq-deadline doesn't work with ionice value and
> > it results performance loss. This warning helps users figure out the
> > situation. This patch implements the function that gets io-scheduler
> > from sysfs and check when scrub stars with the function.
> 
> From a quick grep it seems to me that only bfq is supporting ioprio settings.

Yeah it's only BFQ.

> Also there's some features like write ordering guarantees that currently 
> only mq-deadline provides.
> 
> This warning will trigger a lot once the zoned patchset for btrfs is merged,
> as for example SMR drives need this ordering guarantees and therefore select
> mq-deadline (via the ELEVATOR_F_ZBD_SEQ_WRITE elevator feature).

This won't affect the default case and for zoned fs we can't simply use
BFQ and thus the ionice interface. Which should be IMHO acceptable.
