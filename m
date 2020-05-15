Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E781D5824
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEORll (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 13:41:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:52096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEORll (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 13:41:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9EC72B03C;
        Fri, 15 May 2020 17:41:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7738EDA732; Fri, 15 May 2020 19:40:47 +0200 (CEST)
Date:   Fri, 15 May 2020 19:40:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: fix lockdep warning chunk_mutex vs
 device_list_mutex
Message-ID: <20200515174047.GN18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <52b6ff4c2da5838393f5bd754310cfa6abcfcc7b3efb3c63c8d95824cb163d6d.dsterba@suse.com>
 <20200513194659.34493-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513194659.34493-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 14, 2020 at 03:46:59AM +0800, Anand Jain wrote:
> A full list of tests just started.
> 
>  fs/btrfs/volumes.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 60ab41c12e50..ebc8565d0f73 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -984,7 +984,6 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>  	if (IS_ERR(fs_devices))
>  		return fs_devices;
>  

So now here's the device_list_mutex taken by a caller but inside
clone_fs_devices there's

	fs_devices = alloc_fs_devices(orig->fsid, NULL);

just before this line and it does a GFP_KERNEL allocation. This could
deadlock through the allocator trying to flush data and then superblock
write locking the device_list_mutex again.

> -	mutex_lock(&orig->device_list_mutex);
>  	fs_devices->total_devices = orig->total_devices;
>  
>  	list_for_each_entry(orig_dev, &orig->devices, dev_list) {
