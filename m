Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771231431F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 20:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgATTKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 14:10:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:38524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgATTKk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 14:10:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 474EAB016;
        Mon, 20 Jan 2020 19:10:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 166C0DA7E6; Mon, 20 Jan 2020 20:10:22 +0100 (CET)
Date:   Mon, 20 Jan 2020 20:10:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update devid after replace
Message-ID: <20200120191021.GN3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200114183958.GJ3929@twin.jikos.cz>
 <20200115082250.3064-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115082250.3064-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 15, 2020 at 04:22:50PM +0800, Anand Jain wrote:
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1189,6 +1189,17 @@ int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
>  	return 0;
>  }
>  
> +void btrfs_sysfs_update_devid(struct btrfs_device *device)
> +{
> +	char tmp[64];

24 is enough

> +
> +	snprintf(tmp, sizeof(tmp), "%llu", device->devid);
> +
> +	if (kobject_rename(&device->devid_kobj, tmp))
> +		btrfs_warn(device->fs_devices->fs_info,
> +			   "sysfs: failed to update devid");

And printing for which devid the rename failed should be here

> +}
> +

Once the tests finish I'll add it to misc-next so the patchset is
complete.
