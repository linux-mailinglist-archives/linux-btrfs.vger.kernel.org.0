Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E36F9009
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 13:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfKLMzW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 07:55:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:51392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfKLMzW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 07:55:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98C24B195;
        Tue, 12 Nov 2019 12:55:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D3E8ADA7AF; Tue, 12 Nov 2019 13:55:24 +0100 (CET)
Date:   Tue, 12 Nov 2019 13:55:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/5] btrfs: remove final BUG_ON() in close_fs_devices()
Message-ID: <20191112125524.GX3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191112122416.30672-1-jthumshirn@suse.de>
 <20191112122416.30672-6-jthumshirn@suse.de>
 <f474ee05-5343-3a52-5e79-d4199828a8ee@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f474ee05-5343-3a52-5e79-d4199828a8ee@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 12, 2019 at 08:41:50PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/11/12 下午8:24, Johannes Thumshirn wrote:
> > Now that the preparation work is done, remove the temporary BUG_ON() in
> > close_fs_devices() and return an error instead.
> >
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > ---
> >  fs/btrfs/volumes.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index be1fd935edf7..844333b96075 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -1128,7 +1128,12 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
> >  	mutex_lock(&fs_devices->device_list_mutex);
> >  	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) {
> >  		ret = btrfs_close_one_device(device);
> > -		BUG_ON(ret); /* -ENOMEM */
> > +		if (ret) {
> > +			mutex_unlock(&fs_devices->device_list_mutex);
> > +			return ret;
> > +		}
> > +		fs_devices->opened--;
> > +		fs_devices->seeding--;
> 
> This seeding-- doesn't look safe to me.

Yeah, same here, it could be correct in the sense that it's 1 -> 0
exactly once, but otherwise its a bool, and handled in a special way.
