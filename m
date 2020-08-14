Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4548F244B16
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 16:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgHNOMq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 10:12:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:56766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgHNOMp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 10:12:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBBE4B1BA;
        Fri, 14 Aug 2020 14:13:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DFB5DDA6EF; Fri, 14 Aug 2020 16:11:41 +0200 (CEST)
Date:   Fri, 14 Aug 2020 16:11:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 03/17] btrfs: do not hold device_list_mutex when closing
 devices
Message-ID: <20200814141141.GW2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200810154242.782802-1-josef@toxicpanda.com>
 <20200810154242.782802-4-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810154242.782802-4-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 10, 2020 at 11:42:28AM -0400, Josef Bacik wrote:
> not have the device_list_mutex here.  We're already holding the
> uuid_mutex which keeps us safe from any external modification of the
> fs_devices.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/volumes.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3ac44dad58bb..97ec9c0a91aa 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1155,11 +1155,8 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
>  	if (--fs_devices->opened > 0)
>  		return 0;
>  
> -	mutex_lock(&fs_devices->device_list_mutex);
> -	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) {
> +	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list)
>  		btrfs_close_one_device(device);
> -	}
> -	mutex_unlock(&fs_devices->device_list_mutex);

As Filipe pointed out, uuid mutex is not held in the dev replace
function, I suggest to add

	lockdep_assert_held(&uuid_mutex);

when locks are removed and we rely on callers to make sure the right
locks are taken.
