Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3BAE14D06F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 19:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgA2S0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 13:26:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:45962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgA2S0o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 13:26:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6F19BB1EC;
        Wed, 29 Jan 2020 18:26:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7DA90DA730; Wed, 29 Jan 2020 19:26:23 +0100 (CET)
Date:   Wed, 29 Jan 2020 19:26:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        btrfs-list@steev.me.uk
Subject: Re: [PATCH 1/2] btrfs: add read_policy framework
Message-ID: <20200129182623.GL3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        btrfs-list@steev.me.uk
References: <20200105151402.1440-1-anand.jain@oracle.com>
 <20200105151402.1440-2-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105151402.1440-2-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 05, 2020 at 11:14:01PM +0800, Anand Jain wrote:
> As of now we use %pid method to read stripped mirrored data, which means
> application's process id determines the stripe id to be read. This type
> of read IO routing typically helps in a system with many small
> independent applications tying to read random data. On the other hand
> the %pid based read IO distribution policy is inefficient because if
> there is a single application trying to read large data the overall disk
> bandwidth remains under-utilized.

AFAIK it's not always the application pid, for compression or metadata
it's the pid of btrfs worker thread. So it depends.

> So this patch introduces read policy framework so that we could add more
> read policies, such as IO routing based on device's wait-queue or manual
> when we have a read-preferred device or a policy based on the target
> storage caching.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> [Patch name changed]
> 
> v3: Declare fs_devices::readmirror as enum btrfs_readmirror_policy_type
> v2: Declare fs_devices::readmirror as u8 instead of atomic_t
>     A small change in comment and change log wordings.
> 
>  fs/btrfs/volumes.c | 16 +++++++++++++++-
>  fs/btrfs/volumes.h |  9 +++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c95e47aa84f8..2ffffdf1d314 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1162,6 +1162,8 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>  	fs_devices->opened = 1;
>  	fs_devices->latest_bdev = latest_dev->bdev;
>  	fs_devices->total_rw_bytes = 0;
> +	/* Set the default read policy */

You can drop this comment

> +	fs_devices->read_policy = BTRFS_READ_POLICY_DEFAULT;
>  out:
>  	return ret;
>  }
> @@ -5300,7 +5302,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>  	else
>  		num_stripes = map->num_stripes;
>  
> -	preferred_mirror = first + current->pid % num_stripes;
> +	switch (fs_info->fs_devices->read_policy) {
> +	case BTRFS_READ_BY_PID:
> +		preferred_mirror = first + current->pid % num_stripes;
> +		break;
> +	default:
> +		/*
> +		 * Shouln't happen, just warn and use by_pid instead of failing.
> +		 */
> +		btrfs_warn_rl(fs_info,
> +			      "unknown read_policy type %u, fallback to by_pid",
> +			      fs_info->fs_devices->read_policy);
> +		preferred_mirror = first + current->pid % num_stripes;

This is repeating the BY_PID code, please move the defaut: case above it
so the code is shared.

> +	}
>  
>  	if (dev_replace_is_ongoing &&
>  	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 68021d1ee216..3bbf0e51433f 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -209,6 +209,13 @@ BTRFS_DEVICE_GETSET_FUNCS(total_bytes);
>  BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
>  BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>  
> +/* read_policy types */

More explanation would be nice

> +#define BTRFS_READ_POLICY_DEFAULT	BTRFS_READ_BY_PID

Add this to the enums so we don't have mixed enums and defines

> +enum btrfs_read_policy_type {

I think you can drop _type here, the 'enum' must be spelled everywhere
is used so the type name can be shorter without losing descriptivity.

> +	BTRFS_READ_BY_PID,

This should share the namespace so, BTRFS_READ_POLICY_PID

> +	BTRFS_NR_READ_POLICY_TYPE,
> +};
> +
>  struct btrfs_fs_devices {
>  	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
>  	u8 metadata_uuid[BTRFS_FSID_SIZE];
> @@ -260,6 +267,8 @@ struct btrfs_fs_devices {
>  	struct kobject *devices_kobj;
>  	struct kobject *devinfo_kobj;
>  	struct completion kobj_unregister;
> +
> +	enum btrfs_read_policy_type read_policy;

What's the reason to add this to btrfs_fs_devices rather than to
btrfs_fs_info? The lifetime of the policy and the related sysfs object
is the same as of the mounted filesystem.

>  };
>  
>  #define BTRFS_BIO_INLINE_CSUM_SIZE	64
