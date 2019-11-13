Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97AFBFB322
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 16:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfKMPCp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 10:02:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:38698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728004AbfKMPCo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 10:02:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42CDCB384;
        Wed, 13 Nov 2019 15:02:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 178BDDA7E8; Wed, 13 Nov 2019 16:02:47 +0100 (CET)
Date:   Wed, 13 Nov 2019 16:02:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] btrfs: remove final BUG_ON() in close_fs_devices()
Message-ID: <20191113150246.GD3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191113102728.8835-1-jthumshirn@suse.de>
 <20191113102728.8835-6-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113102728.8835-6-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 13, 2019 at 11:27:26AM +0100, Johannes Thumshirn wrote:
> Now that the preparation work is done, remove the temporary BUG_ON() in
> close_fs_devices() and return an error instead.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> ---
> Changes to v1:
> - btrfs_fs_devices::seeding is a 'boolean' flags and no counter, don't
>   decrement it (Qu)
> ---
>  fs/btrfs/volumes.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index be1fd935edf7..25e4608e20f1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1128,7 +1128,11 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
>  	mutex_lock(&fs_devices->device_list_mutex);
>  	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) {
>  		ret = btrfs_close_one_device(device);
> -		BUG_ON(ret); /* -ENOMEM */
> +		if (ret) {
> +			mutex_unlock(&fs_devices->device_list_mutex);
> +			return ret;

This can fail in the middle of the loop thus leaving some devices in the
list and keeping open_devices half-changed.

Not all callers of close_fs_devices handle the errors so this can break
invariants, where eg. fs_devices->opened is expected to be 0 after the
function call, similar for ->seeding or ->rw_devices.

> +		}
> +		fs_devices->opened--;
>  	}
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  
> -- 
> 2.16.4
