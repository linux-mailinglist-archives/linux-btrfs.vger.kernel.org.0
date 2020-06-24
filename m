Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED320776C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404137AbgFXPcC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 11:32:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:36284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404017AbgFXPcC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 11:32:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19965B06A;
        Wed, 24 Jun 2020 15:32:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87D76DA79B; Wed, 24 Jun 2020 17:31:47 +0200 (CEST)
Date:   Wed, 24 Jun 2020 17:31:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Message-ID: <20200624153147.GQ27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 24, 2020 at 07:21:36PM +0900, Johannes Thumshirn wrote:
> With the recent addition of filesystem checksum types other than CRC32c,
> it is not anymore hard-coded which checksum type a btrfs filesystem uses.
> 
> Up to now there is no good way to read the filesystem checksum, apart from
> reading the filesystem UUID and then query sysfs for the checksum type.
> 
> Add a new csum_type field to the BTRFS_IOC_FS_INFO ioctl command which
> usually is used to query filesystem features. Also add a flags member
> indicating that the kernel responded with a set csum_type field.
> 
> Fixes: 3951e7f050ac ("btrfs: add xxhash64 to checksumming algorithms")
> Fixes: 3831bf0094ab ("btrfs: add sha256 to checksumming algorithm")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/ioctl.c           |  3 +++
>  include/uapi/linux/btrfs.h | 13 ++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index b3e4c632d80c..16062720f5f3 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3217,6 +3217,9 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
>  	fi_args->nodesize = fs_info->nodesize;
>  	fi_args->sectorsize = fs_info->sectorsize;
>  	fi_args->clone_alignment = fs_info->sectorsize;
> +	fi_args->csum_type =
> +			le16_to_cpu(btrfs_super_csum_type(fs_info->super_copy));
> +	fi_args->flags |= BTRFS_FS_INFO_FLAG_CSUM_TYPE;
>  
>  	if (copy_to_user(arg, fi_args, sizeof(*fi_args)))
>  		ret = -EFAULT;
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index e6b6cb0f8bc6..161d9100c2a6 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -250,10 +250,21 @@ struct btrfs_ioctl_fs_info_args {
>  	__u32 nodesize;				/* out */
>  	__u32 sectorsize;			/* out */
>  	__u32 clone_alignment;			/* out */
> +	__u32 flags;				/* out */
> +	__u16 csum_type;
> +	__u16 reserved16;
>  	__u32 reserved32;
> -	__u64 reserved[122];			/* pad to 1k */
> +	__u64 reserved[121];			/* pad to 1k */

Maybe we should just switch to u8 for the reserved field.
