Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EDD13961E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 17:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAMQZh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 11:25:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:39328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbgAMQZg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 11:25:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2F1BAFB5;
        Mon, 13 Jan 2020 16:25:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3015BDA78B; Mon, 13 Jan 2020 17:25:22 +0100 (CET)
Date:   Mon, 13 Jan 2020 17:25:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: open code log helpers in device_list_add()
Message-ID: <20200113162521.GW3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200110090555.7049-1-anand.jain@oracle.com>
 <20200110164212.GQ3929@twin.jikos.cz>
 <ec1a6bed-ecea-c7f6-2567-9626590bc9c7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec1a6bed-ecea-c7f6-2567-9626590bc9c7@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 11, 2020 at 07:41:51AM +0800, Anand Jain wrote:
> >>   			if (device->bdev != path_bdev) {
> >>   				bdput(path_bdev);
> >>   				mutex_unlock(&fs_devices->device_list_mutex);
> >> -				btrfs_warn_in_rcu(device->fs_info,
> >> -			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
> >> +				rcu_read_lock();
> >> +				printk_ratelimited(
> > 
> > Avoiding fs_info here is correct but we don't want to use raw printk or
> > printk_ratelimited anywhere.
> > 
> 
>   I think I discussed this a long time back, that we should rather pass
>   fs_devices in btrfs_warn_in_rcu().
> 
>   I am ok to make such a change, are you ok?

No, this does not sound right at all. Why should be btrfs_warn_in_rcu
special from the other message callbacks? We need to fix one context, so
let's find something less hacky.

>   Or I wonder if there is
>   any other way?

We could add a fs_info stub that will get recognized in btrfs_printk.
Eg.

#define	NO_FS_INFO		((void*)0x1)

btrfs_printk() {

	if (fs_info == NULL)
		devname = "<unknown>";
	else if (fs_info == NO_FS_INFO)
		devname = "...";
	else
		devname = fs_info->sb->sb_id;

