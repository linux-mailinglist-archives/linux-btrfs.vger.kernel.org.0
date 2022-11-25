Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8C6381DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 01:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiKYAIR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Nov 2022 19:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYAIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Nov 2022 19:08:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392D46D4AC
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 16:08:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A23281F8D5;
        Fri, 25 Nov 2022 00:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669334892;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ahn7HmLdEj6VaiK/vjYu60j6GHd4Zap1do8b0DIZvdY=;
        b=HLtgvNcgCQMe3JgHFQVcbKfv9Kr52bRyfc7Gy11aoQCW6D2Jo23dYiDg8+PVYNDYkotD5I
        4KCFKx1TI0JoosXtHTnZ0SnxjD0jdkXqIOTPosz/eZISTwxPKDUkaBr/dmeqUU9C1lwnKR
        VhGqSv5YtLEF7wfra6GzXBDL10fyDnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669334892;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ahn7HmLdEj6VaiK/vjYu60j6GHd4Zap1do8b0DIZvdY=;
        b=4z87SgxSVpnaVfBaKoWsLgr6nwc2aphXW9kNmVqeFaIiQT9WnCRe9gqGmc7rpxez3/WVW4
        OStNS4fmBDdrARBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5274A1361C;
        Fri, 25 Nov 2022 00:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id it0aE2wHgGNmVgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 25 Nov 2022 00:08:12 +0000
Date:   Fri, 25 Nov 2022 01:07:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 12/29] btrfs-progs: sync uapi/btrfs.h into btrfs-progs
Message-ID: <20221125000740.GP5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1669242804.git.josef@toxicpanda.com>
 <80ce230bd4a20f4a5a3d62db25f86b419da44414.1669242804.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ce230bd4a20f4a5a3d62db25f86b419da44414.1669242804.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 23, 2022 at 05:37:20PM -0500, Josef Bacik wrote:
> We want to keep this file locally as we want to be uptodate with
> upstream, so we can build btrfs-progs regardless of which kernel is
> currently installed.  Sync this with the upstream version and put it in
> kernel-shared/uapi to maintain some semblance of where this file comes
> from.

I think you got too optimistic that the file can be just copied. In this
case we'll need some bidirectional sync because the kernel header has
some comments or definitions not present in user space and vice versa.
> 
>  struct btrfs_trans_handle;
> diff --git a/ioctl.h b/kernel-shared/uapi/btrfs.h
> similarity index 70%
> rename from ioctl.h
> rename to kernel-shared/uapi/btrfs.h
> index 686c1035..e694449c 100644
> --- a/ioctl.h
> +++ b/kernel-shared/uapi/btrfs.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  /*
>   * Copyright (C) 2007 Oracle.  All rights reserved.
>   *
> @@ -16,28 +17,15 @@
>   * Boston, MA 021110-1307, USA.
>   */
>  
> -#ifndef __BTRFS_IOCTL_H__
> -#define __BTRFS_IOCTL_H__
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif

Eg. the C++ protection

> -
> -#include <asm/types.h>
> +#ifndef _UAPI_LINUX_BTRFS_H
> +#define _UAPI_LINUX_BTRFS_H
> +#include <linux/types.h>
>  #include <linux/ioctl.h>
> -#include <stddef.h>
> -
> -#ifndef __user
> -#define __user
> -#endif
> -
> -/* We don't want to include entire kerncompat.h */
> -#ifndef BUILD_ASSERT
> -#define BUILD_ASSERT(x)
> -#endif

All the BUILD_ASSERT annotations

> +#include <linux/fs.h>
>  
>  #define BTRFS_IOCTL_MAGIC 0x94
>  #define BTRFS_VOL_NAME_MAX 255
> +#define BTRFS_LABEL_SIZE 256
>  
>  /* this should be 4k */
>  #define BTRFS_PATH_NAME_MAX 4087
> @@ -45,18 +33,20 @@ struct btrfs_ioctl_vol_args {
>  	__s64 fd;
>  	char name[BTRFS_PATH_NAME_MAX + 1];
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);
>  
> -#define BTRFS_DEVICE_PATH_NAME_MAX 1024
> +#define BTRFS_DEVICE_PATH_NAME_MAX	1024
> +#define BTRFS_SUBVOL_NAME_MAX 		4039
>  
> -/*
> - * Obsolete since 5.15, functionality removed in kernel 5.7:
> - * BTRFS_SUBVOL_CREATE_ASYNC		(1ULL << 0)
> - */
> +#ifndef __KERNEL__
> +/* Deprecated since 5.7 */
> +# define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)
> +#endif
>  #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
>  #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
> +
>  #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
> -#define BTRFS_SUBVOL_SPEC_BY_ID		(1ULL << 4)
> +
> +#define BTRFS_SUBVOL_SPEC_BY_ID	(1ULL << 4)
>  
>  #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
>  			(BTRFS_SUBVOL_RDONLY |		\
> @@ -66,8 +56,21 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);
>  
>  #define BTRFS_FSID_SIZE 16
>  #define BTRFS_UUID_SIZE 16
> +#define BTRFS_UUID_UNPARSED_SIZE	37
>  
> -#define BTRFS_QGROUP_INHERIT_SET_LIMITS	(1ULL << 0)
> +/*
> + * flags definition for qgroup limits
> + *
> + * Used by:
> + * struct btrfs_qgroup_limit.flags
> + * struct btrfs_qgroup_limit_item.flags
> + */
> +#define BTRFS_QGROUP_LIMIT_MAX_RFER	(1ULL << 0)
> +#define BTRFS_QGROUP_LIMIT_MAX_EXCL	(1ULL << 1)
> +#define BTRFS_QGROUP_LIMIT_RSV_RFER	(1ULL << 2)
> +#define BTRFS_QGROUP_LIMIT_RSV_EXCL	(1ULL << 3)
> +#define BTRFS_QGROUP_LIMIT_RFER_CMPR	(1ULL << 4)
> +#define BTRFS_QGROUP_LIMIT_EXCL_CMPR	(1ULL << 5)
>  
>  struct btrfs_qgroup_limit {
>  	__u64	flags;
> @@ -76,7 +79,14 @@ struct btrfs_qgroup_limit {
>  	__u64	rsv_rfer;
>  	__u64	rsv_excl;
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_qgroup_limit) == 40);
> +
> +/*
> + * flags definition for qgroup inheritance
> + *
> + * Used by:
> + * struct btrfs_qgroup_inherit.flags
> + */
> +#define BTRFS_QGROUP_INHERIT_SET_LIMITS	(1ULL << 0)
>  
>  struct btrfs_qgroup_inherit {
>  	__u64	flags;
> @@ -84,17 +94,38 @@ struct btrfs_qgroup_inherit {
>  	__u64	num_ref_copies;
>  	__u64	num_excl_copies;
>  	struct btrfs_qgroup_limit lim;
> -	__u64	qgroups[0];
> +	__u64	qgroups[];
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_qgroup_inherit) == 72);
>  
>  struct btrfs_ioctl_qgroup_limit_args {
>  	__u64	qgroupid;
>  	struct btrfs_qgroup_limit lim;
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_qgroup_limit_args) == 48);
>  
> -#define BTRFS_SUBVOL_NAME_MAX 4039
> +/*
> + * Arguments for specification of subvolumes or devices, supporting by-name or
> + * by-id and flags
> + *
> + * The set of supported flags depends on the ioctl
> + *
> + * BTRFS_SUBVOL_RDONLY is also provided/consumed by the following ioctls:
> + * - BTRFS_IOC_SUBVOL_GETFLAGS
> + * - BTRFS_IOC_SUBVOL_SETFLAGS
> + */
> +
> +/* Supported flags for BTRFS_IOC_RM_DEV_V2 */
> +#define BTRFS_DEVICE_REMOVE_ARGS_MASK					\
> +	(BTRFS_DEVICE_SPEC_BY_ID)
> +
> +/* Supported flags for BTRFS_IOC_SNAP_CREATE_V2 and BTRFS_IOC_SUBVOL_CREATE_V2 */
> +#define BTRFS_SUBVOL_CREATE_ARGS_MASK					\
> +	 (BTRFS_SUBVOL_RDONLY |						\
> +	 BTRFS_SUBVOL_QGROUP_INHERIT)
> +
> +/* Supported flags for BTRFS_IOC_SNAP_DESTROY_V2 */
> +#define BTRFS_SUBVOL_DELETE_ARGS_MASK					\
> +	(BTRFS_SUBVOL_SPEC_BY_ID)
> +
>  struct btrfs_ioctl_vol_args_v2 {
>  	__s64 fd;
>  	__u64 transid;
> @@ -102,7 +133,7 @@ struct btrfs_ioctl_vol_args_v2 {
>  	union {
>  		struct {
>  			__u64 size;
> -			struct btrfs_qgroup_inherit __user *qgroup_inherit;
> +			struct btrfs_qgroup_inherit *qgroup_inherit;

Pointer annotations

>  		};
>  		__u64 unused[4];
>  	};
> @@ -112,7 +143,6 @@ struct btrfs_ioctl_vol_args_v2 {
>  		__u64 subvolid;
>  	};
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args_v2) == 4096);
>  
>  /*
>   * structure to report errors and progress to userspace, either as a
> @@ -161,7 +191,6 @@ struct btrfs_ioctl_scrub_args {
>  	/* pad to 1k */
>  	__u64 unused[(1024-32-sizeof(struct btrfs_scrub_progress))/8];
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_scrub_args) == 1024);
>  
>  #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS	0
>  #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_AVOID	1
> @@ -172,7 +201,6 @@ struct btrfs_ioctl_dev_replace_start_params {
>  	__u8 srcdev_name[BTRFS_DEVICE_PATH_NAME_MAX + 1];	/* in */
>  	__u8 tgtdev_name[BTRFS_DEVICE_PATH_NAME_MAX + 1];	/* in */
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_replace_start_params) == 2072);
>  
>  #define BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED	0
>  #define BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED		1
> @@ -187,7 +215,6 @@ struct btrfs_ioctl_dev_replace_status_params {
>  	__u64 num_write_errors;	/* out */
>  	__u64 num_uncorrectable_read_errors;	/* out */
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_replace_status_params) == 48);
>  
>  #define BTRFS_IOCTL_DEV_REPLACE_CMD_START			0
>  #define BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS			1
> @@ -207,7 +234,6 @@ struct btrfs_ioctl_dev_replace_args {
>  
>  	__u64 spare[64];
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_replace_args) == 2600);
>  
>  struct btrfs_ioctl_dev_info_args {
>  	__u64 devid;				/* in/out */
> @@ -217,7 +243,18 @@ struct btrfs_ioctl_dev_info_args {
>  	__u64 unused[379];			/* pad to 4k */
>  	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_info_args) == 4096);
> +
> +/*
> + * Retrieve information about the filesystem
> + */
> +
> +/* Request information about checksum type and size */
> +#define BTRFS_FS_INFO_FLAG_CSUM_INFO			(1 << 0)
> +
> +/* Request information about filesystem generation */
> +#define BTRFS_FS_INFO_FLAG_GENERATION			(1 << 1)
> +/* Request information about filesystem metadata UUID */
> +#define BTRFS_FS_INFO_FLAG_METADATA_UUID		(1 << 2)
>  
>  struct btrfs_ioctl_fs_info_args {
>  	__u64 max_id;				/* out */
> @@ -226,22 +263,70 @@ struct btrfs_ioctl_fs_info_args {
>  	__u32 nodesize;				/* out */
>  	__u32 sectorsize;			/* out */
>  	__u32 clone_alignment;			/* out */
> -	__u32 reserved32;
> -	__u64 reserved[122];			/* pad to 1k */
> +	/* See BTRFS_FS_INFO_FLAG_* */
> +	__u16 csum_type;			/* out */
> +	__u16 csum_size;			/* out */
> +	__u64 flags;				/* in/out */
> +	__u64 generation;			/* out */
> +	__u8 metadata_uuid[BTRFS_FSID_SIZE];	/* out */
> +	__u8 reserved[944];			/* pad to 1k */
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
> +
> +/*
> + * feature flags
> + *
> + * Used by:
> + * struct btrfs_ioctl_feature_flags
> + */
> +#define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE		(1ULL << 0)
> +/*
> + * Older kernels (< 4.9) on big-endian systems produced broken free space tree
> + * bitmaps, and btrfs-progs also used to corrupt the free space tree (versions
> + * < 4.7.3).  If this bit is clear, then the free space tree cannot be trusted.
> + * btrfs-progs can also intentionally clear this bit to ask the kernel to
> + * rebuild the free space tree, however this might not work on older kernels
> + * that do not know about this bit. If not sure, clear the cache manually on
> + * first mount when booting older kernel versions.
> + */
> +#define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
> +#define BTRFS_FEATURE_COMPAT_RO_VERITY			(1ULL << 2)
> +
> +/*
> + * Put all block group items into a dedicated block group tree, greatly
> + * reducing mount time for large filesystem due to better locality.
> + */
> +#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 3)
> +
> +#define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
> +#define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
> +#define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
> +#define BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO	(1ULL << 3)
> +#define BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD	(1ULL << 4)
> +
> +/*
> + * older kernels tried to do bigger metadata blocks, but the
> + * code was pretty buggy.  Lets not let them try anymore.
> + */
> +#define BTRFS_FEATURE_INCOMPAT_BIG_METADATA	(1ULL << 5)
> +
> +#define BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF	(1ULL << 6)
> +#define BTRFS_FEATURE_INCOMPAT_RAID56		(1ULL << 7)
> +#define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
> +#define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
> +#define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
> +#define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
> +#define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
> +#define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
>  
>  struct btrfs_ioctl_feature_flags {
>  	__u64 compat_flags;
>  	__u64 compat_ro_flags;
>  	__u64 incompat_flags;
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_feature_flags) == 24);
>  
>  /* balance control ioctl modes */
>  #define BTRFS_BALANCE_CTL_PAUSE		1
>  #define BTRFS_BALANCE_CTL_CANCEL	2
> -#define BTRFS_BALANCE_CTL_RESUME	3
>  
>  /*
>   * this is packed, because it should be exactly the same as its disk
> @@ -249,12 +334,6 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_feature_flags) == 24);
>   */
>  struct btrfs_balance_args {
>  	__u64 profiles;
> -
> -	/*
> -	 * usage filter
> -	 * BTRFS_BALANCE_ARGS_USAGE with a single value means '0..N'
> -	 * BTRFS_BALANCE_ARGS_USAGE_RANGE - range syntax, min..max
> -	 */

Useful comments deleted

>  	union {
>  		__u64 usage;
>  		struct {
> @@ -262,7 +341,6 @@ struct btrfs_balance_args {
>  			__u32 usage_max;
>  		};
>  	};
> -
>  	__u64 devid;
>  	__u64 pstart;
>  	__u64 pend;
> @@ -285,19 +363,89 @@ struct btrfs_balance_args {
>  			__u32 limit_max;
>  		};
>  	};
> +
> +	/*
> +	 * Process chunks that cross stripes_min..stripes_max devices,
> +	 * BTRFS_BALANCE_ARGS_STRIPES_RANGE
> +	 */

But added

>  	__u32 stripes_min;
>  	__u32 stripes_max;
> +
>  	__u64 unused[6];
>  } __attribute__ ((__packed__));
>  
>  /* report balance progress to userspace */
>  struct btrfs_balance_progress {
>  	__u64 expected;		/* estimated # of chunks that will be
> -				 * relocated to fulfil the request */
> +				 * relocated to fulfill the request */

Typos

>  	__u64 considered;	/* # of chunks we have considered so far */
>  	__u64 completed;	/* # of chunks relocated so far */
>  };
>  
> +/*
> + * flags definition for balance
> + *
> + * Restriper's general type filter
> + *
> + * Used by:
> + * btrfs_ioctl_balance_args.flags
> + * btrfs_balance_control.flags (internal)
> + */
> +#define BTRFS_BALANCE_DATA		(1ULL << 0)
> +#define BTRFS_BALANCE_SYSTEM		(1ULL << 1)
> +#define BTRFS_BALANCE_METADATA		(1ULL << 2)
> +
> +#define BTRFS_BALANCE_TYPE_MASK		(BTRFS_BALANCE_DATA |	    \
> +					 BTRFS_BALANCE_SYSTEM |	    \
> +					 BTRFS_BALANCE_METADATA)
> +
> +#define BTRFS_BALANCE_FORCE		(1ULL << 3)
> +#define BTRFS_BALANCE_RESUME		(1ULL << 4)
> +
> +/*
> + * flags definitions for per-type balance args
> + *
> + * Balance filters
> + *
> + * Used by:
> + * struct btrfs_balance_args
> + */
> +#define BTRFS_BALANCE_ARGS_PROFILES	(1ULL << 0)
> +#define BTRFS_BALANCE_ARGS_USAGE	(1ULL << 1)
> +#define BTRFS_BALANCE_ARGS_DEVID	(1ULL << 2)
> +#define BTRFS_BALANCE_ARGS_DRANGE	(1ULL << 3)
> +#define BTRFS_BALANCE_ARGS_VRANGE	(1ULL << 4)
> +#define BTRFS_BALANCE_ARGS_LIMIT	(1ULL << 5)
> +#define BTRFS_BALANCE_ARGS_LIMIT_RANGE	(1ULL << 6)
> +#define BTRFS_BALANCE_ARGS_STRIPES_RANGE (1ULL << 7)
> +#define BTRFS_BALANCE_ARGS_USAGE_RANGE	(1ULL << 10)
> +
> +#define BTRFS_BALANCE_ARGS_MASK			\
> +	(BTRFS_BALANCE_ARGS_PROFILES |		\
> +	 BTRFS_BALANCE_ARGS_USAGE |		\
> +	 BTRFS_BALANCE_ARGS_DEVID | 		\
> +	 BTRFS_BALANCE_ARGS_DRANGE |		\
> +	 BTRFS_BALANCE_ARGS_VRANGE |		\
> +	 BTRFS_BALANCE_ARGS_LIMIT |		\
> +	 BTRFS_BALANCE_ARGS_LIMIT_RANGE |	\
> +	 BTRFS_BALANCE_ARGS_STRIPES_RANGE |	\
> +	 BTRFS_BALANCE_ARGS_USAGE_RANGE)
> +
> +/*
> + * Profile changing flags.  When SOFT is set we won't relocate chunk if
> + * it already has the target profile (even though it may be
> + * half-filled).
> + */
> +#define BTRFS_BALANCE_ARGS_CONVERT	(1ULL << 8)
> +#define BTRFS_BALANCE_ARGS_SOFT		(1ULL << 9)
> +
> +
> +/*
> + * flags definition for balance state
> + *
> + * Used by:
> + * struct btrfs_ioctl_balance_args.state
> + */
>  #define BTRFS_BALANCE_STATE_RUNNING	(1ULL << 0)
>  #define BTRFS_BALANCE_STATE_PAUSE_REQ	(1ULL << 1)
>  #define BTRFS_BALANCE_STATE_CANCEL_REQ	(1ULL << 2)
> @@ -314,7 +462,6 @@ struct btrfs_ioctl_balance_args {
>  
>  	__u64 unused[72];			/* pad to 1k */
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_balance_args) == 1024);
>  
>  #define BTRFS_INO_LOOKUP_PATH_MAX 4080
>  struct btrfs_ioctl_ino_lookup_args {
> @@ -322,9 +469,8 @@ struct btrfs_ioctl_ino_lookup_args {
>  	__u64 objectid;
>  	char name[BTRFS_INO_LOOKUP_PATH_MAX];
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_ino_lookup_args) == 4096);
>  
> -#define BTRFS_INO_LOOKUP_USER_PATH_MAX	(4080 - BTRFS_VOL_NAME_MAX - 1)
> +#define BTRFS_INO_LOOKUP_USER_PATH_MAX (4080 - BTRFS_VOL_NAME_MAX - 1)
>  struct btrfs_ioctl_ino_lookup_user_args {
>  	/* in, inode number containing the subvolume of 'subvolid' */
>  	__u64 dirid;
> @@ -338,33 +484,55 @@ struct btrfs_ioctl_ino_lookup_user_args {
>  	 */
>  	char path[BTRFS_INO_LOOKUP_USER_PATH_MAX];
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_ino_lookup_user_args) == 4096);
>  
> +/* Search criteria for the btrfs SEARCH ioctl family. */
>  struct btrfs_ioctl_search_key {
> -	/* which root are we searching.  0 is the tree of tree roots */
> -	__u64 tree_id;
> -
> -	/* keys returned will be >= min and <= max */
> -	__u64 min_objectid;
> -	__u64 max_objectid;
> -
> -	/* keys returned will be >= min and <= max */
> -	__u64 min_offset;
> -	__u64 max_offset;
> -
> -	/* max and min transids to search for */
> -	__u64 min_transid;
> -	__u64 max_transid;
> -
> -	/* keys returned will be >= min and <= max */
> -	__u32 min_type;
> -	__u32 max_type;
> +	/*
> +	 * The tree we're searching in. 1 is the tree of tree roots, 2 is the
> +	 * extent tree, etc...
> +	 *
> +	 * A special tree_id value of 0 will cause a search in the subvolume
> +	 * tree that the inode which is passed to the ioctl is part of.
> +	 */
> +	__u64 tree_id;		/* in */
>  
>  	/*
> -	 * how many items did userland ask for, and how many are we
> -	 * returning
> +	 * When doing a tree search, we're actually taking a slice from a
> +	 * linear search space of 136-bit keys.
> +	 *
> +	 * A full 136-bit tree key is composed as:
> +	 *   (objectid << 72) + (type << 64) + offset
> +	 *
> +	 * The individual min and max values for objectid, type and offset
> +	 * define the min_key and max_key values for the search range. All
> +	 * metadata items with a key in the interval [min_key, max_key] will be
> +	 * returned.
> +	 *
> +	 * Additionally, we can filter the items returned on transaction id of
> +	 * the metadata block they're stored in by specifying a transid range.
> +	 * Be aware that this transaction id only denotes when the metadata
> +	 * page that currently contains the item got written the last time as
> +	 * result of a COW operation.  The number does not have any meaning
> +	 * related to the transaction in which an individual item that is being
> +	 * returned was created or changed.
>  	 */
> -	__u32 nr_items;
> +	__u64 min_objectid;	/* in */
> +	__u64 max_objectid;	/* in */
> +	__u64 min_offset;	/* in */
> +	__u64 max_offset;	/* in */
> +	__u64 min_transid;	/* in */
> +	__u64 max_transid;	/* in */
> +	__u32 min_type;		/* in */
> +	__u32 max_type;		/* in */

Comments deleted

> +
> +	/*
> +	 * input: The maximum amount of results desired.
> +	 * output: The actual amount of items returned, restricted by any of:
> +	 *  - reaching the upper bound of the search range
> +	 *  - reaching the input nr_items amount of items
> +	 *  - completely filling the supplied memory buffer
> +	 */
> +	__u32 nr_items;		/* in/out */
>  
>  	/* align to 64 bits */
>  	__u32 unused;
> @@ -382,7 +550,7 @@ struct btrfs_ioctl_search_header {
>  	__u64 offset;
>  	__u32 type;
>  	__u32 len;
> -} __attribute__((may_alias));
> +};

Attribute deleted and for search tree ioctl header quite important one.

>  
>  #define BTRFS_SEARCH_ARGS_BUFSIZE (4096 - sizeof(struct btrfs_ioctl_search_key))
>  /*
> @@ -395,57 +563,28 @@ struct btrfs_ioctl_search_args {
>  	char buf[BTRFS_SEARCH_ARGS_BUFSIZE];
>  };
>  
> -/*
> - * Extended version of TREE_SEARCH ioctl that can return more than 4k of bytes.
> - * The allocated size of the buffer is set in buf_size.
> - */
>  struct btrfs_ioctl_search_args_v2 {
> -        struct btrfs_ioctl_search_key key; /* in/out - search parameters */
> -        __u64 buf_size;			   /* in - size of buffer
> -                                            * out - on EOVERFLOW: needed size
> -                                            *       to store item */
> -        __u64 buf[0];                      /* out - found items */
> +	struct btrfs_ioctl_search_key key; /* in/out - search parameters */
> +	__u64 buf_size;		   /* in - size of buffer
> +					    * out - on EOVERFLOW: needed size
> +					    *       to store item */
> +	__u64 buf[];                       /* out - found items */
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_search_args_v2) == 112);
>  
> -/* With a @src_length of zero, the range from @src_offset->EOF is cloned! */
>  struct btrfs_ioctl_clone_range_args {
> -	__s64 src_fd;
> -	__u64 src_offset, src_length;
> -	__u64 dest_offset;
> +  __s64 src_fd;
> +  __u64 src_offset, src_length;
> +  __u64 dest_offset;

Bad whitespace introduced

>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_clone_range_args) == 32);
>  
> -/* flags for the defrag range ioctl */
> +/*
> + * flags definition for the defrag range ioctl
> + *
> + * Used by:
> + * struct btrfs_ioctl_defrag_range_args.flags
> + */
>  #define BTRFS_DEFRAG_RANGE_COMPRESS 1
>  #define BTRFS_DEFRAG_RANGE_START_IO 2
> -
> -#define BTRFS_SAME_DATA_DIFFERS	1
> -/* For extent-same ioctl */
> -struct btrfs_ioctl_same_extent_info {
> -	__s64 fd;		/* in - destination file */
> -	__u64 logical_offset;	/* in - start of extent in destination */
> -	__u64 bytes_deduped;	/* out - total # of bytes we were able
> -				 * to dedupe from this file */
> -	/* status of this dedupe operation:
> -	 * 0 if dedup succeeds
> -	 * < 0 for error
> -	 * == BTRFS_SAME_DATA_DIFFERS if data differs
> -	 */
> -	__s32 status;		/* out - see above description */
> -	__u32 reserved;
> -};
> -
> -struct btrfs_ioctl_same_args {
> -	__u64 logical_offset;	/* in - start of extent in source */
> -	__u64 length;		/* in - length of extent */
> -	__u16 dest_count;	/* in - total elements in info array */
> -	__u16 reserved1;
> -	__u32 reserved2;
> -	struct btrfs_ioctl_same_extent_info info[0];
> -};
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_same_args) == 24);
> -
>  struct btrfs_ioctl_defrag_range_args {
>  	/* start of the defrag operation */
>  	__u64 start;
> @@ -476,7 +615,32 @@ struct btrfs_ioctl_defrag_range_args {
>  	/* spare for later */
>  	__u32 unused[4];
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_defrag_range_args) == 48);
> +
> +
> +#define BTRFS_SAME_DATA_DIFFERS	1
> +/* For extent-same ioctl */
> +struct btrfs_ioctl_same_extent_info {
> +	__s64 fd;		/* in - destination file */
> +	__u64 logical_offset;	/* in - start of extent in destination */
> +	__u64 bytes_deduped;	/* out - total # of bytes we were able
> +				 * to dedupe from this file */
> +	/* status of this dedupe operation:
> +	 * 0 if dedup succeeds
> +	 * < 0 for error
> +	 * == BTRFS_SAME_DATA_DIFFERS if data differs
> +	 */
> +	__s32 status;		/* out - see above description */
> +	__u32 reserved;
> +};
> +
> +struct btrfs_ioctl_same_args {
> +	__u64 logical_offset;	/* in - start of extent in source */
> +	__u64 length;		/* in - length of extent */
> +	__u16 dest_count;	/* in - total elements in info array */
> +	__u16 reserved1;
> +	__u32 reserved2;
> +	struct btrfs_ioctl_same_extent_info info[];
> +};
>  
>  struct btrfs_ioctl_space_info {
>  	__u64 flags;
> @@ -487,16 +651,15 @@ struct btrfs_ioctl_space_info {
>  struct btrfs_ioctl_space_args {
>  	__u64 space_slots;
>  	__u64 total_spaces;
> -	struct btrfs_ioctl_space_info spaces[0];
> +	struct btrfs_ioctl_space_info spaces[];
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_space_args) == 16);
>  
>  struct btrfs_data_container {
>  	__u32	bytes_left;	/* out -- bytes not needed to deliver output */
>  	__u32	bytes_missing;	/* out -- additional bytes needed for result */
>  	__u32	elem_cnt;	/* out */
>  	__u32	elem_missed;	/* out */
> -	__u64	val[0];		/* out */
> +	__u64	val[];		/* out */
>  };
>  
>  struct btrfs_ioctl_ino_path_args {
> @@ -506,22 +669,18 @@ struct btrfs_ioctl_ino_path_args {
>  	/* struct btrfs_data_container	*fspath;	   out */
>  	__u64				fspath;		/* out */
>  };
> -BUILD_ASSERT(sizeof(struct btrfs_ioctl_ino_path_args) == 56);
>  
>  struct btrfs_ioctl_logical_ino_args {
>  	__u64				logical;	/* in */
>  	__u64				size;		/* in */
> -	__u64				reserved[3];
> -	__u64				flags;		/* in */
> +	__u64				reserved[3];	/* must be 0 for now */
> +	__u64				flags;		/* in, v2 only */
>  	/* struct btrfs_data_container	*inodes;	out   */
>  	__u64				inodes;
>  };
> -
> -/*
> - * Return every ref to the extent, not just those containing logical block.
> - * Requires logical == extent bytenr.
> - */
> -#define BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET    (1ULL << 0)
> +/* Return every ref to the extent, not just those containing logical block.
> + * Requires logical == extent bytenr. */

Comment formatting the wrong way

So, I'll stop merging the series before this patch because it's not
something easily fixed. I maybe pick other independet patches, I haven't
looked yet but 1-11 is OK.1
