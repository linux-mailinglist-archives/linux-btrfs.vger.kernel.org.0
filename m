Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45390365F18
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhDTSRM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 14:17:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233381AbhDTSRL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 14:17:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92906B30C;
        Tue, 20 Apr 2021 18:16:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 99394DA83A; Tue, 20 Apr 2021 20:14:19 +0200 (CEST)
Date:   Tue, 20 Apr 2021 20:14:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v5 1/3] btrfs: zoned: reset zones of relocated block
 groups
Message-ID: <20210420181419.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
References: <cover.1618817864.git.johannes.thumshirn@wdc.com>
 <accfdd59409776466cacb8b5bf67db7e346f6435.1618817864.git.johannes.thumshirn@wdc.com>
 <20210419171038.GP7604@twin.jikos.cz>
 <PH0PR04MB7416A7E77F4B13420AE65E139B489@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416A7E77F4B13420AE65E139B489@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 20, 2021 at 07:40:37AM +0000, Johannes Thumshirn wrote:
> On 19/04/2021 19:13, David Sterba wrote:
> > On Mon, Apr 19, 2021 at 04:41:00PM +0900, Johannes Thumshirn wrote:
> >> When relocating a block group the freed up space is not discarded in one
> >> big block, but each extent is discarded on it's own with -odisard=sync.
> >>
> >> For a zoned filesystem we need to discard the whole block group at once,
> >> so btrfs_discard_extent() will translate the discard into a
> >> REQ_OP_ZONE_RESET operation, which then resets the device's zone.
> >>
> >> Link: https://lore.kernel.org/linux-btrfs/459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com
> > 
> > The link points to the same patch in v3, is there something missing in
> > this patch that should be added to the changelog?
> > 
> 
> I included this link so one can look up the discussion between Filipe and
> me that lead to this decision. But I guess this is not really relevant. 

So what'd recommend and expect is to put a summary of the discussion to
the changelog, because the discussions can take many mails and the
contents is scattered, and link the first relevant mail in case the full
story could be interesting. Eventually the link could be in text with
some hint what to look for in the mail.
