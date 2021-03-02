Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5432B1C4
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbhCCB4l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:56:41 -0500
Received: from out20-25.mail.aliyun.com ([115.124.20.25]:42432 "EHLO
        out20-25.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382058AbhCBIso (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Mar 2021 03:48:44 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436387|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0684223-0.00531382-0.926264;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JfKtegF_1614674878;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JfKtegF_1614674878)
          by smtp.aliyun-inc.com(10.147.41.138);
          Tue, 02 Mar 2021 16:47:58 +0800
Date:   Tue, 02 Mar 2021 16:48:01 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 1/2] btrfs-progs: check: detect and warn about tree blocks cross 64K page boundary
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20201109053952.490678-2-wqu@suse.com>
References: <20201109053952.490678-1-wqu@suse.com> <20201109053952.490678-2-wqu@suse.com>
Message-Id: <20210302164758.28C1.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Qu Wenruo

This warning message happen even in new created filesystem on amd64
system.

Should we slicent it before mkfs.btrfs is ready for  64K page system?

The paration is aligned in 1GiB

btrfs-progs: v5.10.x branch

# mkfs.btrfs /dev/sdb1 -f

# btrfs check /dev/sdb1
Opening filesystem to check...
Checking filesystem on /dev/sdb1
UUID: b298271d-6d1d-4792-a579-fb93653aa811
[1/7] checking root items
[2/7] checking extents
WARNING: tree block [5292032, 5308416) crosses 64K page boudnary, may cause problem for 64K page system
WARNING: tree block [5357568, 5373952) crosses 64K page boudnary, may cause problem for 64K page system
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 147456 bytes used, no error found
total csum bytes: 0
total tree bytes: 147456
total fs tree bytes: 32768
total extent tree bytes: 16384
btree space waste bytes: 140356
file data blocks allocated: 0
 referenced 0

# parted /dev/sdb unit KiB print
Model: TOSHIBA PX05SMQ040 (scsi)
Disk /dev/sdb: 390711384kiB
Sector size (logical/physical): 4096B/4096B
Partition Table: gpt
Disk Flags:

Number  Start         End           Size         File system  Name     Flags
 1      1048576kiB    63963136kiB   62914560kiB  btrfs        primary


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/03/02

> For the incoming subpage support, there is a new requirement for tree
> blocks.
> Tree blocks should not cross 64K page boudnary.
> 
> For current btrfs-progs and kernel, there shouldn't be any causes to
> create such tree blocks.
> 
> But still, we want to detect such tree blocks in the wild before subpage
> support fully lands in upstream.
> 
> This patch will add such check for both lowmem and original mode.
> Currently it's just a warning, since there aren't many users using 64K
> page size yet.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  check/main.c        |  2 ++
>  check/mode-common.h | 18 ++++++++++++++++++
>  check/mode-lowmem.c |  2 ++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/check/main.c b/check/main.c
> index e7996b7c8c0e..0ce9c2f334b4 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -5375,6 +5375,8 @@ static int process_extent_item(struct btrfs_root *root,
>  		      num_bytes, gfs_info->sectorsize);
>  		return -EIO;
>  	}
> +	if (metadata)
> +		btrfs_check_subpage_eb_alignment(key.objectid, num_bytes);
>  
>  	memset(&tmpl, 0, sizeof(tmpl));
>  	tmpl.start = key.objectid;
> diff --git a/check/mode-common.h b/check/mode-common.h
> index 4efc07a4f44d..bcda0f53e2c4 100644
> --- a/check/mode-common.h
> +++ b/check/mode-common.h
> @@ -171,4 +171,22 @@ static inline u32 btrfs_type_to_imode(u8 type)
>  
>  	return imode_by_btrfs_type[(type)];
>  }
> +
> +/*
> + * Check tree block alignement for future subpage support on 64K page system.
> + *
> + * Subpage support on 64K page size require one eb to be completely contained
> + * by a page. Not allowing a tree block to cross 64K page boudanry.
> + *
> + * Since subpage support is still under development, this check only provides
> + * warning.
> + */
> +static inline void btrfs_check_subpage_eb_alignment(u64 start, u32 len)
> +{
> +	if (start / BTRFS_MAX_METADATA_BLOCKSIZE !=
> +	    (start + len) / BTRFS_MAX_METADATA_BLOCKSIZE)
> +		warning(
> +"tree block [%llu, %llu) crosses 64K page boudnary, may cause problem for 64K page system",
> +			start, start + len);
> +}
>  #endif
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index 2b689b2abf63..6dbfe829bb7c 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -4206,6 +4206,8 @@ static int check_extent_item(struct btrfs_path *path)
>  		      key.objectid, key.objectid + nodesize);
>  		err |= CROSSING_STRIPE_BOUNDARY;
>  	}
> +	if (metadata)
> +		btrfs_check_subpage_eb_alignment(key.objectid, nodesize);
>  
>  	ptr = (unsigned long)(ei + 1);
>  
> -- 
> 2.29.2


