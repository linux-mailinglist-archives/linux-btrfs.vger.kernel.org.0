Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675E6213D17
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgGCP6R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 11:58:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:57576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgGCP6R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 11:58:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89AE0AD79;
        Fri,  3 Jul 2020 15:58:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54C62DA87C; Fri,  3 Jul 2020 17:57:58 +0200 (CEST)
Date:   Fri, 3 Jul 2020 17:57:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/10] btrfs: Always initialize
 btrfs_bio::tgtdev_map/raid_map pointers
Message-ID: <20200703155757.GE27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-2-nborisov@suse.com>
 <SN4PR0401MB359800E3D7D379E9161318379B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <ac973720-9d3b-1824-e7de-16e15b364c9c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac973720-9d3b-1824-e7de-16e15b364c9c@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 03, 2020 at 11:31:02AM +0300, Nikolay Borisov wrote:
> 
> 
> On 2.07.20 г. 17:04 ч., Johannes Thumshirn wrote:
> > On 02/07/2020 15:47, Nikolay Borisov wrote:
> > [...]
> >> -		bbio->raid_map = (u64 *)((void *)bbio->stripes +
> >> -				 sizeof(struct btrfs_bio_stripe) *
> >> -				 num_alloc_stripes +
> >> -				 sizeof(int) * tgtdev_indexes);
> > 
> > That one took me a while to be convinced it is correct.
> 
> There are 2 aspects to this:
> 
> 1. I think the original code is harder to grasp ...

Agreed, the rework is much better. Though understanding that's an
equivalent change is tough. I'll update the changelog with the
explanation.
