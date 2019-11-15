Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B50FD96F
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 10:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKOJjH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 04:39:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:55224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbfKOJjH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 04:39:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D6FEAC48;
        Fri, 15 Nov 2019 09:39:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 051B9DA783; Fri, 15 Nov 2019 10:39:08 +0100 (CET)
Date:   Fri, 15 Nov 2019 10:39:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] btrfs: handle allocation failure in strdup
Message-ID: <20191115093908.GN3001@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191113102728.8835-1-jthumshirn@suse.de>
 <20191113102728.8835-4-jthumshirn@suse.de>
 <3c492c97-0c41-a4b1-5687-6b9ccf40cf67@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c492c97-0c41-a4b1-5687-6b9ccf40cf67@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 14, 2019 at 07:00:54PM +0800, Anand Jain wrote:
> On 13/11/19 6:27 PM, Johannes Thumshirn wrote:
> > Gracefully handle allocation failures in btrfs_close_one_device()'s
> > rcu_string_strdup() instead of crashing the machine.
> > 
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > ---
> >   fs/btrfs/volumes.c | 22 ++++++++++++++--------
> >   1 file changed, 14 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 0a2a73907563..e5864ca3bb3b 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -1064,7 +1064,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
> >   static int btrfs_close_one_device(struct btrfs_device *device)
> >   {
> >   	struct btrfs_fs_devices *fs_devices = device->fs_devices;
> > -	struct btrfs_device *new_device;
> > +	struct btrfs_device *new_device = NULL;
> >   	struct rcu_string *name;
> >   
> >   	new_device = btrfs_alloc_device(NULL, &device->devid,
> > @@ -1072,6 +1072,15 @@ static int btrfs_close_one_device(struct btrfs_device *device)
> >   	if (IS_ERR(new_device))
> >   		goto err_close_device;
> >   
> > +	/* Safe because we are under uuid_mutex */
> > +	if (device->name) {
> > +		name = rcu_string_strdup(device->name->str, GFP_NOFS);
> > +		if (!name)
> > +			goto err_free_device;
> > +
> > +		rcu_assign_pointer(new_device->name, name);
> > +	}
> > +
> 
>   Any idea why do we need to strdup() at all to close a device?

It shouldn't be needed but that's how it got implemented since the
beginning in e4404d6e8da678d852. The device on close is duplicated, so
has to be the name.
