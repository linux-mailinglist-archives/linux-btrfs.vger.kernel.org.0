Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809B349D03E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 18:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbiAZRCS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 12:02:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51850 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiAZRCS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 12:02:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 53C8A218FF;
        Wed, 26 Jan 2022 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643216537;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qd76Dp85ImLuZTVKI9XQ+nMMOqg1D1JpRYe7DWFBVnY=;
        b=PFGiEN9fji2FLLB9EkR8ItJuVDwZGplcu4yecwgXF1Zl0VmyqJhjumBh4nxLdsL6edy4sF
        0YlO9Kv9m++nrLDXAjw/FXryBAN8aOYzI8EZ3E+7GBqzhArgPooE9Nntx9C/QeH9VjfxUe
        JZ8S1CIC7CBwq1W5EcG8+QCIXTDHUT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643216537;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qd76Dp85ImLuZTVKI9XQ+nMMOqg1D1JpRYe7DWFBVnY=;
        b=EYRvPMdGztNRdAv1nCEynAxCHzOBGUGyCSP8pQXmtCSlAWkYUpNc3VnmT7jTjT8PhBypmH
        ALCBEfrEpD+hi5Aw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4B403A3B89;
        Wed, 26 Jan 2022 17:02:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D3F9DA7A9; Wed, 26 Jan 2022 18:01:36 +0100 (CET)
Date:   Wed, 26 Jan 2022 18:01:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: create chunk device type aware
Message-ID: <20220126170136.GD14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1642518245.git.anand.jain@oracle.com>
 <4ac12d6661470b18e1145f98c355bc1a93ebf214.1642518245.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ac12d6661470b18e1145f98c355bc1a93ebf214.1642518245.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 18, 2022 at 11:18:02PM +0800, Anand Jain wrote:
> Mixed device types configuration exist. Most commonly, HDD mixed with
> SSD/NVME device types. This use case prefers that the data chunk
> allocates on HDD and the metadata chunk allocates on the SSD/NVME.
> 
> As of now, in the function gather_device_info() called from
> btrfs_create_chunk(), we sort the devices based on unallocated space
> only.
> 
> After this patch, this function will check for mixed device types. And
> will sort the devices based on enum btrfs_device_types. That is, sort if
> the allocation type is metadata and reverse-sort if the allocation type
> is data.
> 
> The advantage of this method is that data/metadata allocation distribution
> based on the device type happens automatically without any manual
> configuration.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index da3d6d0f5bc3..77fba78555d7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5060,6 +5060,37 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
>  	return 0;
>  }
>  
> +/*
> + * Sort the devices in its ascending order of latency value.
> + */
> +static int btrfs_cmp_device_latency(const void *a, const void *b)
> +{
> +	const struct btrfs_device_info *di_a = a;
> +	const struct btrfs_device_info *di_b = b;
> +	struct btrfs_device *dev_a = di_a->dev;
> +	struct btrfs_device *dev_b = di_b->dev;
> +
> +	if (dev_a->dev_type > dev_b->dev_type)

It's strange to see dev_type being compared while the function compares
the latency. As pointed in the first patch, this could simply refer to a
array of device types sorted by latency.

> +		return 1;
> +	if (dev_a->dev_type < dev_b->dev_type)
> +		return -1;
> +	return 0;
> +}
> +
> +static int btrfs_cmp_device_rev_latency(const void *a, const void *b)

Regarding the naming, I think we've been using _desc (descending) as
suffix for the reverse sort functions, while ascending is the default.

> +{
> +	const struct btrfs_device_info *di_a = a;
> +	const struct btrfs_device_info *di_b = b;
> +	struct btrfs_device *dev_a = di_a->dev;
> +	struct btrfs_device *dev_b = di_b->dev;
> +
> +	if (dev_a->dev_type > dev_b->dev_type)
> +		return -1;
> +	if (dev_a->dev_type < dev_b->dev_type)
> +		return 1;
> +	return 0;

To avoid code duplication this could be

	return -btrfs_cmp_device_latency(a, b);

> +}
> +
>  /*
>   * sort the devices in descending order by max_avail, total_avail
>   */
> @@ -5292,6 +5323,20 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>  	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>  	     btrfs_cmp_device_info, NULL);
>  
> +	/*
> +	 * Sort devices by their latency. Ascending order of latency for
> +	 * metadata and descending order of latency for the data chunks for
> +	 * mixed device types.
> +	 */
> +	if (fs_devices->mixed_dev_types) {
> +		if (ctl->type & BTRFS_BLOCK_GROUP_DATA)
> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +			     btrfs_cmp_device_rev_latency, NULL);
> +		else
> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +			     btrfs_cmp_device_latency, NULL);
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.33.1
