Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF7D272384
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgIUMPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 08:15:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIUMPt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 08:15:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0AFEACAF;
        Mon, 21 Sep 2020 12:16:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 88AEDDA6E0; Mon, 21 Sep 2020 14:14:33 +0200 (CEST)
Date:   Mon, 21 Sep 2020 14:14:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Eryu Guan <guan@eryu.me>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove stale test for alien devices
Message-ID: <20200921121432.GI6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Eryu Guan <guan@eryu.me>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <20200917141353.28566-1-johannes.thumshirn@wdc.com>
 <f4606506-78a1-4771-96cd-6bc28e6a7074@oracle.com>
 <SN4PR0401MB35987D9F6868271DAD0A05009B3F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200920161532.GP3853@desktop>
 <0763fac7-d9a8-e486-ef20-670e139deb14@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0763fac7-d9a8-e486-ef20-670e139deb14@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 21, 2020 at 10:37:49AM +0800, Anand Jain wrote:
> 
> 
> On 21/9/20 12:15 am, Eryu Guan wrote:
> > On Fri, Sep 18, 2020 at 07:06:42AM +0000, Johannes Thumshirn wrote:
> >> On 18/09/2020 02:15, Anand Jain wrote:
> >>> The fix is not too far. It got stuck whether to use EUCLEAN or not.
> >>> Its better to fix the fix rather than killing the messenger in this case.
> >>
> >> OK how about removing the test from the auto group then until the fix is merged?
> >> It's a constant failure and hiding real regressions. And having to maintain an
> >> expunge list doesn't scale either.
> >>
> >> Thoughts?
> > 
> 
> The patch is in the ML for review.
> 
>   [PATCH] btrfs: free device without BTRFS_MAGIC
> 
>   https://patchwork.kernel.org/patch/11786607/
> 
> I am OK if you still think it has to be removed from the auto.
> But I don't think it is required now.

The patch needs some discussion so the ETA when it'll land in some
branch is unclear, removing it from auto still makes sense.
