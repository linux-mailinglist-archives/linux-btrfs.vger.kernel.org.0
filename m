Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3930236AD7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 09:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhDZHgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 03:36:45 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:57366 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhDZHgT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 03:36:19 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 9DE14471CA0;
        Mon, 26 Apr 2021 10:35:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1619422534; bh=5fxSnvAollAmzd2LMwfUPrNhwPUacCSRrKGY+C7pfzI=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=alZjZSa7nWdGb9qeZhEUD31NCP75pAGoWPIhj4/2GA+T2evXPcnaa8AjZ+uFbKH09
         PN+PZWOCHjb6NgQMjwN44BWMgPYXPCEkXYkgCOCM3XOuZQlKe+qpfUB8hm7B+/HSLW
         VamJyOmoSRSzf4aXzLfUsfBNvYRuSE8x7p3xjL3A=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 9036C471C9F;
        Mon, 26 Apr 2021 10:35:34 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 2ckZNwythQPv; Mon, 26 Apr 2021 10:35:33 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id AF088471C9E;
        Mon, 26 Apr 2021 10:35:33 +0300 (EEST)
Received: from nas (unknown [45.87.95.45])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 2AEF41BE00C3;
        Mon, 26 Apr 2021 10:35:30 +0300 (EEST)
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <0c6581b81ebb7bc573c6c6c533c134b34b294dca.1619416549.git.naohiro.aota@wdc.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 05/26] btrfs-progs: zoned: get zone information of zoned
 block devices
Date:   Mon, 26 Apr 2021 15:32:23 +0800
In-reply-to: <0c6581b81ebb7bc573c6c6c533c134b34b294dca.1619416549.git.naohiro.aota@wdc.com>
Message-ID: <bla1pkg4.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBkfEh1qkXXPZGw8ysS5MQJ6W9p3azH8tkXr8MS+GdksMVBar/x97SWA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 26 Apr 2021 at 14:27, Naohiro Aota <naohiro.aota@wdc.com> 
wrote:

> Get the zone information (number of zones and zone size) from 
> all the
> devices, if the volume contains a zoned block device. To avoid 
> costly
> run-time zone report commands to test the device zones type 
> during block
> allocation, it also records all the zone status (zone type, 
> write pointer
> position, etc.).
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  Makefile                |   2 +-
>  common/device-scan.c    |   2 +
>  kerncompat.h            |   4 +
>  kernel-shared/disk-io.c |  12 ++
>  kernel-shared/volumes.c |   2 +
>  kernel-shared/volumes.h |   2 +
>  kernel-shared/zoned.c   | 242 
>  ++++++++++++++++++++++++++++++++++++++++
>  kernel-shared/zoned.h   |  42 +++++++
>  8 files changed, 307 insertions(+), 1 deletion(-)
>  create mode 100644 kernel-shared/zoned.c
>  create mode 100644 kernel-shared/zoned.h
>
> diff --git a/Makefile b/Makefile
> index e288a336c81e..3dc0543982b2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -169,7 +169,7 @@ libbtrfs_objects = common/send-stream.o 
> common/send-utils.o kernel-lib/rbtree.o
>  		   kernel-shared/free-space-cache.o 
>  kernel-shared/root-tree.o \
>  		   kernel-shared/volumes.o kernel-shared/transaction.o \
>  		   kernel-shared/free-space-tree.o repair.o 
>  kernel-shared/inode-item.o \
> -		   kernel-shared/file-item.o \
> +		   kernel-shared/file-item.o kernel-shared/zoned.o \
>  		   kernel-lib/raid56.o kernel-lib/tables.o \
>  		   common/device-scan.o common/path-utils.o \
>  		   common/utils.o libbtrfsutil/subvolume.o 
>  libbtrfsutil/stubs.o \
> diff --git a/common/device-scan.c b/common/device-scan.c
> index 01d2e0656583..74d7853afccb 100644
> --- a/common/device-scan.c
> +++ b/common/device-scan.c
> @@ -35,6 +35,7 @@
>  #include "kernel-shared/ctree.h"
>  #include "kernel-shared/volumes.h"
>  #include "kernel-shared/disk-io.h"
> +#include "kernel-shared/zoned.h"
>  #include "ioctl.h"
>
>  static int btrfs_scan_done = 0;
> @@ -198,6 +199,7 @@ int btrfs_add_to_fsid(struct 
> btrfs_trans_handle *trans,
>  	return 0;
>
>  out:
> +	free(device->zone_info);
>  	free(device);
>  	free(buf);
>  	return ret;
> diff --git a/kerncompat.h b/kerncompat.h
> index 7060326fe4f4..a39b79cba767 100644
> --- a/kerncompat.h
> +++ b/kerncompat.h
> @@ -76,6 +76,10 @@
>  #define ULONG_MAX       (~0UL)
>  #endif
>
> +#ifndef SECTOR_SHIFT
> +#define SECTOR_SHIFT 9
> +#endif
> +
>  #define __token_glue(a,b,c)	___token_glue(a,b,c)
>  #define ___token_glue(a,b,c)	a ## b ## c
>  #ifdef DEBUG_BUILD_CHECKS
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index a78be1e7a692..0519cb2358b5 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -29,6 +29,7 @@
>  #include "kernel-shared/disk-io.h"
>  #include "kernel-shared/volumes.h"
>  #include "kernel-shared/transaction.h"
> +#include "zoned.h"
>  #include "crypto/crc32c.h"
>  #include "common/utils.h"
>  #include "kernel-shared/print-tree.h"
> @@ -1314,6 +1315,17 @@ static struct btrfs_fs_info 
> *__open_ctree_fd(int fp, const char *path,
>  	if (!fs_info->chunk_root)
>  		return fs_info;
>
> +	/*
> +	 * Get zone type information of zoned block devices. This will 
> also
> +	 * handle emulation of a zoned filesystem if a regular device 
> has the
> +	 * zoned incompat feature flag set.
> +	 */
> +	ret = btrfs_get_dev_zone_info_all_devices(fs_info);
> +	if (ret) {
> +		error("zoned: failed to read device zone info: %d", ret);
> +		goto out_chunk;
> +	}
> +
>  	eb = fs_info->chunk_root->node;
>  	read_extent_buffer(eb, fs_info->chunk_tree_uuid,
>  			   btrfs_header_chunk_tree_uuid(eb),
> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
> index cbcf7bfa371d..63530a99b41c 100644
> --- a/kernel-shared/volumes.c
> +++ b/kernel-shared/volumes.c
> @@ -27,6 +27,7 @@
>  #include "kernel-shared/transaction.h"
>  #include "kernel-shared/print-tree.h"
>  #include "kernel-shared/volumes.h"
> +#include "zoned.h"
>  #include "common/utils.h"
>  #include "kernel-lib/raid56.h"
>
> @@ -357,6 +358,7 @@ again:
>  		/* free the memory */
>  		free(device->name);
>  		free(device->label);
> +		free(device->zone_info);
>  		free(device);
>  	}
>
> diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
> index faaa285dbf11..a64288d566d8 100644
> --- a/kernel-shared/volumes.h
> +++ b/kernel-shared/volumes.h
> @@ -45,6 +45,8 @@ struct btrfs_device {
>
>  	u64 generation;
>
> +	struct btrfs_zoned_device_info *zone_info;
> +
>  	/* the internal btrfs device id */
>  	u64 devid;
>
> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> new file mode 100644
> index 000000000000..370d93915c6e
> --- /dev/null
> +++ b/kernel-shared/zoned.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <sys/ioctl.h>
> +#include <linux/fs.h>
> +
> +#include "kernel-lib/list.h"
> +#include "kernel-shared/volumes.h"
> +#include "kernel-shared/zoned.h"
> +#include "common/utils.h"
> +#include "common/device-utils.h"
> +#include "common/messages.h"
> +#include "mkfs/common.h"
> +
> +/* Maximum number of zones to report per ioctl(BLKREPORTZONE) 
> call */
> +#define BTRFS_REPORT_NR_ZONES   4096
> +
> +static int btrfs_get_dev_zone_info(struct btrfs_device 
> *device);
> +
> +enum btrfs_zoned_model zoned_model(const char *file)
> +{
> +	const char *host_aware = "host-aware";
> +	const char *host_managed = "host-managed";
> +	struct stat st;
> +	char model[32];
> +	int ret;
> +
> +	ret = stat(file, &st);
> +	if (ret < 0) {
> +		error("zoned: unable to stat %s", file);
> +		return -ENOENT;
> +	}
> +
> +	/* Consider a regular file as non-zoned device */
> +	if (!S_ISBLK(st.st_mode))
> +		return ZONED_NONE;
> +
> +	ret = queue_param(file, "zoned", model, sizeof(model));
> +	if (ret <= 0)
> +		return ZONED_NONE;
> +
> +	if (strncmp(model, host_aware, strlen(host_aware)) == 0)
> +		return ZONED_HOST_AWARE;
> +	if (strncmp(model, host_managed, strlen(host_managed)) == 0)
> +		return ZONED_HOST_MANAGED;
> +
> +	return ZONED_NONE;
> +}
> +
> +u64 zone_size(const char *file)
> +{
> +	char chunk[32];
> +	int ret;
> +
> +	ret = queue_param(file, "chunk_sectors", chunk, 
> sizeof(chunk));
> +	if (ret <= 0)
> +		return 0;
> +
> +	return strtoull((const char *)chunk, NULL, 10) << 
> SECTOR_SHIFT;
> +}
> +
> +#ifdef BTRFS_ZONED
> +static int report_zones(int fd, const char *file,
> +			struct btrfs_zoned_device_info *zinfo)
> +{
> +	u64 device_size;
> +	u64 zone_bytes = zone_size(file);
> +	size_t rep_size;
> +	u64 sector = 0;
> +	struct blk_zone_report *rep;
> +	struct blk_zone *zone;
> +	unsigned int i, n = 0;
> +	int ret;
> +
> +	/*
> +	 * Zones are guaranteed (by the kernel) to be a power of 2 
> number of
> +	 * sectors. Check this here and make sure that zones are not 
> too
> +	 * small.
> +	 */
> +	if (!zone_bytes || !is_power_of_2(zone_bytes)) {
> +		error("zoned: illegal zone size %llu (not a power of 2)",
> +		      zone_bytes);
> +		exit(1);
> +	}
> +	/*
> +	 * The zone size must be large enough to hold the initial 
> system
> +	 * block group for mkfs time.
> +	 */
> +	if (zone_bytes < BTRFS_MKFS_SYSTEM_GROUP_SIZE) {
> +		error("zoned: illegal zone size %llu (smaller than %d)",
> +		      zone_bytes, BTRFS_MKFS_SYSTEM_GROUP_SIZE);
> +		exit(1);

I see many exit() calls in this patch and other patches.
Any special reasion?

--
Su
> +	}
> +
> +	/*
> +	 * No need to use btrfs_device_size() here, since it is 
> ensured
> +	 * that the file is block device.
> +	 */
> +	if (ioctl(fd, BLKGETSIZE64, &device_size) < 0) {
> +		error("zoned: ioctl(BLKGETSIZE64) failed on %s (%m)", 
> file);
> +		exit(1);
> +	}
> +
> +	/* Allocate the zone information array */
> +	zinfo->zone_size = zone_bytes;
> +	zinfo->nr_zones = device_size / zone_bytes;
> +	if (device_size & (zone_bytes - 1))
> +		zinfo->nr_zones++;
> +	zinfo->zones = calloc(zinfo->nr_zones, sizeof(struct 
> blk_zone));
> +	if (!zinfo->zones) {
> +		error("zoned: no memory for zone information");
> +		exit(1);
> +	}
> +
> +	/* Allocate a zone report */
> +	rep_size = sizeof(struct blk_zone_report) +
> +		sizeof(struct blk_zone) * BTRFS_REPORT_NR_ZONES;
> +	rep = malloc(rep_size);
> +	if (!rep) {
> +		error("zoned: no memory for zones report");
> +		exit(1);
> +	}
> +
> +	/* Get zone information */
> +	zone = (struct blk_zone *)(rep + 1);
> +	while (n < zinfo->nr_zones) {
> +		memset(rep, 0, rep_size);
> +		rep->sector = sector;
> +		rep->nr_zones = BTRFS_REPORT_NR_ZONES;
> +
> +		ret = ioctl(fd, BLKREPORTZONE, rep);
> +		if (ret != 0) {
> +			error("zoned: ioctl BLKREPORTZONE failed (%m)");
> +			exit(1);
> +		}
> +
> +		if (!rep->nr_zones)
> +			break;
> +
> +		for (i = 0; i < rep->nr_zones; i++) {
> +			if (n >= zinfo->nr_zones)
> +				break;
> +			memcpy(&zinfo->zones[n], &zone[i],
> +			       sizeof(struct blk_zone));
> +			n++;
> +		}
> +
> +		sector = zone[rep->nr_zones - 1].start +
> +			 zone[rep->nr_zones - 1].len;
> +	}
> +
> +	free(rep);
> +
> +	return 0;
> +}
> +
> +#endif
> +
> +int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info 
> *fs_info)
> +{
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	int ret = 0;
> +
> +	/* fs_info->zone_size might not set yet. Use the incomapt flag 
> here. */
> +	if (!btrfs_fs_incompat(fs_info, ZONED))
> +		return 0;
> +
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		/* We can skip reading of zone info for missing devices */
> +		if (device->fd == -1)
> +			continue;
> +
> +		ret = btrfs_get_dev_zone_info(device);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int btrfs_get_dev_zone_info(struct btrfs_device *device)
> +{
> +	struct btrfs_fs_info *fs_info = device->fs_info;
> +
> +	/*
> +	 * Cannot use btrfs_is_zoned here, since fs_info::zone_size 
> might not
> +	 * yet be set.
> +	 */
> +	if (!btrfs_fs_incompat(fs_info, ZONED))
> +		return 0;
> +
> +	if (device->zone_info)
> +		return 0;
> +
> +	return btrfs_get_zone_info(device->fd, device->name,
> +				   &device->zone_info);
> +}
> +
> +int btrfs_get_zone_info(int fd, const char *file,
> +			struct btrfs_zoned_device_info **zinfo_ret)
> +{
> +#ifdef BTRFS_ZONED
> +	struct btrfs_zoned_device_info *zinfo;
> +	int ret;
> +#endif
> +	enum btrfs_zoned_model model;
> +
> +	*zinfo_ret = NULL;
> +
> +	/* Check zone model */
> +	model = zoned_model(file);
> +	if (model == ZONED_NONE)
> +		return 0;
> +
> +#ifdef BTRFS_ZONED
> +	zinfo = calloc(1, sizeof(*zinfo));
> +	if (!zinfo) {
> +		error("zoned: no memory for zone information");
> +		exit(1);
> +	}
> +
> +	zinfo->model = model;
> +
> +	/* Get zone information */
> +	ret = report_zones(fd, file, zinfo);
> +	if (ret != 0) {
> +		kfree(zinfo);
> +		return ret;
> +	}
> +	*zinfo_ret = zinfo;
> +#else
> +	error("zoned: %s: Unsupported host-%s zoned block device", 
> file,
> +	      model == ZONED_HOST_MANAGED ? "managed" : "aware");
> +	if (model == ZONED_HOST_MANAGED)
> +		return -EOPNOTSUPP;
> +
> +	error("zoned: %s: handling host-aware block device as a 
> regular disk",
> +	      file);
> +#endif
> +
> +	return 0;
> +}
> diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
> new file mode 100644
> index 000000000000..461a2d624c67
> --- /dev/null
> +++ b/kernel-shared/zoned.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __BTRFS_ZONED_H__
> +#define __BTRFS_ZONED_H__
> +
> +#include <stdbool.h>
> +#include "kerncompat.h"
> +
> +#ifdef BTRFS_ZONED
> +#include <linux/blkzoned.h>
> +#else
> +struct blk_zone {
> +	int dummy;
> +};
> +#endif /* BTRFS_ZONED */
> +
> +/*
> + * Zoned block device models.
> + */
> +enum btrfs_zoned_model {
> +	ZONED_NONE = 0,
> +	ZONED_HOST_AWARE,
> +	ZONED_HOST_MANAGED,
> +};
> +
> +/*
> + * Zone information for a zoned block device.
> + */
> +struct btrfs_zoned_device_info {
> +	enum btrfs_zoned_model	model;
> +	u64			zone_size;
> +	u32			nr_zones;
> +	struct blk_zone		*zones;
> +};
> +
> +enum btrfs_zoned_model zoned_model(const char *file);
> +u64 zone_size(const char *file);
> +int btrfs_get_zone_info(int fd, const char *file,
> +			struct btrfs_zoned_device_info **zinfo);
> +int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info 
> *fs_info);
> +
> +#endif /* __BTRFS_ZONED_H__ */

