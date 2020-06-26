Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C0620AFE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 12:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgFZKjD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 06:39:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgFZKjD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 06:39:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 25AA2AC7A;
        Fri, 26 Jun 2020 10:39:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E81C6DAA08; Fri, 26 Jun 2020 12:38:47 +0200 (CEST)
Date:   Fri, 26 Jun 2020 12:38:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Message-ID: <20200626103847.GA27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200626073019.24003-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626073019.24003-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 26, 2020 at 04:30:19PM +0900, Johannes Thumshirn wrote:
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
> To simplify further additions to the ioctl, also switch the padding to a
> u8 array. Pahole was used to verify the result of this switch:
> 
> pahole -C btrfs_ioctl_fs_info_args fs/btrfs/btrfs.ko
> struct btrfs_ioctl_fs_info_args {
>         __u64                      max_id;               /*     0     8 */
>         __u64                      num_devices;          /*     8     8 */
>         __u8                       fsid[16];             /*    16    16 */
>         __u32                      nodesize;             /*    32     4 */
>         __u32                      sectorsize;           /*    36     4 */
>         __u32                      clone_alignment;      /*    40     4 */
>         __u32                      flags;                /*    44     4 */
>         __u16                      csum_type;            /*    48     2 */
>         __u8                       reserved[974];        /*    50   974 */
> 
>         /* size: 1024, cachelines: 16, members: 9 */
> };
> 
> Fixes: 3951e7f050ac ("btrfs: add xxhash64 to checksumming algorithms")
> Fixes: 3831bf0094ab ("btrfs: add sha256 to checksumming algorithm")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes to v1:
> * add 'out' comment to be consistent (Hans)
> * remove le16_to_cpu() (kbuild robot)
> * switch padding to be all u8 (David)
> ---
>  fs/btrfs/ioctl.c           |  2 ++
>  include/uapi/linux/btrfs.h | 13 +++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index b3e4c632d80c..6c9d0c3a5e7e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3217,6 +3217,8 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
>  	fi_args->nodesize = fs_info->nodesize;
>  	fi_args->sectorsize = fs_info->sectorsize;
>  	fi_args->clone_alignment = fs_info->sectorsize;
> +	fi_args->csum_type = btrfs_super_csum_type(fs_info->super_copy);
> +	fi_args->flags |= BTRFS_FS_INFO_FLAG_CSUM_TYPE;
>  
>  	if (copy_to_user(arg, fi_args, sizeof(*fi_args)))
>  		ret = -EFAULT;
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index e6b6cb0f8bc6..ee15ece4f477 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -250,10 +250,19 @@ struct btrfs_ioctl_fs_info_args {
>  	__u32 nodesize;				/* out */
>  	__u32 sectorsize;			/* out */
>  	__u32 clone_alignment;			/* out */
> -	__u32 reserved32;
> -	__u64 reserved[122];			/* pad to 1k */
> +	__u32 flags;				/* out */
> +	__u16 csum_type;			/* out */
> +	__u8 reserved[974];			/* pad to 1k */

I think 32 bits for out flags should be enough (or at least for a long
time). I'm not sure if we should make the flags also input. Right now I
think not and if we need to pass flags to request potentially expensive
data to retrieve, we'd add another member for that. I don't have a
concrete example and the whole FS_INFO ioctl is supposed to be
lightweight so as it is now looks good to me.

Also it's pretty small patch, it should be good to go to stable so we
get the fixed interface even in 5.7.
