Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733BC378F9E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhEJNvG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 09:51:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:47256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237505AbhEJNmN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 09:42:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1164EB0BE;
        Mon, 10 May 2021 13:41:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39C57DB226; Mon, 10 May 2021 15:38:35 +0200 (CEST)
Date:   Mon, 10 May 2021 15:38:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Assign boolean values to a bool variable
Message-ID: <20210510133835.GU7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1614764728-14857-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <PH0PR04MB7416EC8C9020EAE3E074E21E9B549@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416EC8C9020EAE3E074E21E9B549@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 10, 2021 at 09:37:58AM +0000, Johannes Thumshirn wrote:
> On 04/03/2021 02:51, Jiapeng Chong wrote:
> > Fix the following coccicheck warnings:
> > 
> > ./fs/btrfs/volumes.c:1462:10-11: WARNING: return of 0/1 in function
> > 'dev_extent_hole_check_zoned' with return type bool.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >  fs/btrfs/volumes.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index bc3b33e..995920f 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -1458,8 +1458,8 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
> >  		/* Given hole range was invalid (outside of device) */
> >  		if (ret == -ERANGE) {
> >  			*hole_start += *hole_size;
> > -			*hole_size = 0;
> > -			return 1;
> > +			*hole_size = false;
> 
> 
> Erm, hole_size is u64 and not bool

Thanks for catching it, I should have spotted that.
