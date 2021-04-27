Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5AE36C9BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhD0Qtc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 12:49:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:40348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237504AbhD0QtF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 12:49:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6FCFB165;
        Tue, 27 Apr 2021 16:48:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 569BBDA732; Tue, 27 Apr 2021 18:45:55 +0200 (CEST)
Date:   Tue, 27 Apr 2021 18:45:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 05/26] btrfs-progs: zoned: get zone information of zoned
 block devices
Message-ID: <20210427164555.GL7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <0c6581b81ebb7bc573c6c6c533c134b34b294dca.1619416549.git.naohiro.aota@wdc.com>
 <bla1pkg4.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bla1pkg4.fsf@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 26, 2021 at 03:32:23PM +0800, Su Yue wrote:
> 
> On Mon 26 Apr 2021 at 14:27, Naohiro Aota <naohiro.aota@wdc.com> 
> wrote:
> 
> > Get the zone information (number of zones and zone size) from 
> > all the
> > devices, if the volume contains a zoned block device. To avoid 
> > costly
> > run-time zone report commands to test the device zones type 
> > during block
> > allocation, it also records all the zone status (zone type, 
> > write pointer
> > position, etc.).
> >
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  Makefile                |   2 +-
> >  common/device-scan.c    |   2 +
> >  kerncompat.h            |   4 +
> >  kernel-shared/disk-io.c |  12 ++
> >  kernel-shared/volumes.c |   2 +
> >  kernel-shared/volumes.h |   2 +
> >  kernel-shared/zoned.c   | 242 
> >  ++++++++++++++++++++++++++++++++++++++++
> >  kernel-shared/zoned.h   |  42 +++++++
> >  8 files changed, 307 insertions(+), 1 deletion(-)
> >  create mode 100644 kernel-shared/zoned.c
> >  create mode 100644 kernel-shared/zoned.h
> >
> > diff --git a/Makefile b/Makefile
> > index e288a336c81e..3dc0543982b2 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -169,7 +169,7 @@ libbtrfs_objects = common/send-stream.o 
> > common/send-utils.o kernel-lib/rbtree.o
> >  		   kernel-shared/free-space-cache.o 
> >  kernel-shared/root-tree.o \
> >  		   kernel-shared/volumes.o kernel-shared/transaction.o \
> >  		   kernel-shared/free-space-tree.o repair.o 
> >  kernel-shared/inode-item.o \
> > -		   kernel-shared/file-item.o \
> > +		   kernel-shared/file-item.o kernel-shared/zoned.o \
> >  		   kernel-lib/raid56.o kernel-lib/tables.o \
> >  		   common/device-scan.o common/path-utils.o \
> >  		   common/utils.o libbtrfsutil/subvolume.o 
> >  libbtrfsutil/stubs.o \
> > diff --git a/common/device-scan.c b/common/device-scan.c
> > index 01d2e0656583..74d7853afccb 100644
> > --- a/common/device-scan.c
> > +++ b/common/device-scan.c
> > @@ -35,6 +35,7 @@
> >  #include "kernel-shared/ctree.h"
> >  #include "kernel-shared/volumes.h"
> >  #include "kernel-shared/disk-io.h"
> > +#include "kernel-shared/zoned.h"
> >  #include "ioctl.h"
> >
> >  static int btrfs_scan_done = 0;
> > @@ -198,6 +199,7 @@ int btrfs_add_to_fsid(struct 
> > btrfs_trans_handle *trans,
> >  	return 0;
> >
> >  out:
> > +	free(device->zone_info);
> >  	free(device);
> >  	free(buf);
> >  	return ret;
> > diff --git a/kerncompat.h b/kerncompat.h
> > index 7060326fe4f4..a39b79cba767 100644
> > --- a/kerncompat.h
> > +++ b/kerncompat.h
> > @@ -76,6 +76,10 @@
> >  #define ULONG_MAX       (~0UL)
> >  #endif
> >
> > +#ifndef SECTOR_SHIFT
> > +#define SECTOR_SHIFT 9
> > +#endif
> > +
> >  #define __token_glue(a,b,c)	___token_glue(a,b,c)
> >  #define ___token_glue(a,b,c)	a ## b ## c
> >  #ifdef DEBUG_BUILD_CHECKS
> > diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> > index a78be1e7a692..0519cb2358b5 100644
> > --- a/kernel-shared/disk-io.c
> > +++ b/kernel-shared/disk-io.c
> > @@ -29,6 +29,7 @@
> >  #include "kernel-shared/disk-io.h"
> >  #include "kernel-shared/volumes.h"
> >  #include "kernel-shared/transaction.h"
> > +#include "zoned.h"
> >  #include "crypto/crc32c.h"
> >  #include "common/utils.h"
> >  #include "kernel-shared/print-tree.h"
> > @@ -1314,6 +1315,17 @@ static struct btrfs_fs_info 
> > *__open_ctree_fd(int fp, const char *path,
> >  	if (!fs_info->chunk_root)
> >  		return fs_info;
> >
> > +	/*
> > +	 * Get zone type information of zoned block devices. This will 
> > also
> > +	 * handle emulation of a zoned filesystem if a regular device 
> > has the
> > +	 * zoned incompat feature flag set.
> > +	 */
> > +	ret = btrfs_get_dev_zone_info_all_devices(fs_info);
> > +	if (ret) {
> > +		error("zoned: failed to read device zone info: %d", ret);
> > +		goto out_chunk;
> > +	}
> > +
> >  	eb = fs_info->chunk_root->node;
> >  	read_extent_buffer(eb, fs_info->chunk_tree_uuid,
> >  			   btrfs_header_chunk_tree_uuid(eb),
> > diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
> > index cbcf7bfa371d..63530a99b41c 100644
> > --- a/kernel-shared/volumes.c
> > +++ b/kernel-shared/volumes.c
> > @@ -27,6 +27,7 @@
> >  #include "kernel-shared/transaction.h"
> >  #include "kernel-shared/print-tree.h"
> >  #include "kernel-shared/volumes.h"
> > +#include "zoned.h"
> >  #include "common/utils.h"
> >  #include "kernel-lib/raid56.h"
> >
> > @@ -357,6 +358,7 @@ again:
> >  		/* free the memory */
> >  		free(device->name);
> >  		free(device->label);
> > +		free(device->zone_info);
> >  		free(device);
> >  	}
> >
> > diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
> > index faaa285dbf11..a64288d566d8 100644
> > --- a/kernel-shared/volumes.h
> > +++ b/kernel-shared/volumes.h
> > @@ -45,6 +45,8 @@ struct btrfs_device {
> >
> >  	u64 generation;
> >
> > +	struct btrfs_zoned_device_info *zone_info;
> > +
> >  	/* the internal btrfs device id */
> >  	u64 devid;
> >
> > diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> > new file mode 100644
> > index 000000000000..370d93915c6e
> > --- /dev/null
> > +++ b/kernel-shared/zoned.c
> > @@ -0,0 +1,242 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <sys/ioctl.h>
> > +#include <linux/fs.h>
> > +
> > +#include "kernel-lib/list.h"
> > +#include "kernel-shared/volumes.h"
> > +#include "kernel-shared/zoned.h"
> > +#include "common/utils.h"
> > +#include "common/device-utils.h"
> > +#include "common/messages.h"
> > +#include "mkfs/common.h"
> > +
> > +/* Maximum number of zones to report per ioctl(BLKREPORTZONE) 
> > call */
> > +#define BTRFS_REPORT_NR_ZONES   4096
> > +
> > +static int btrfs_get_dev_zone_info(struct btrfs_device 
> > *device);
> > +
> > +enum btrfs_zoned_model zoned_model(const char *file)
> > +{
> > +	const char *host_aware = "host-aware";
> > +	const char *host_managed = "host-managed";
> > +	struct stat st;
> > +	char model[32];
> > +	int ret;
> > +
> > +	ret = stat(file, &st);
> > +	if (ret < 0) {
> > +		error("zoned: unable to stat %s", file);
> > +		return -ENOENT;
> > +	}
> > +
> > +	/* Consider a regular file as non-zoned device */
> > +	if (!S_ISBLK(st.st_mode))
> > +		return ZONED_NONE;
> > +
> > +	ret = queue_param(file, "zoned", model, sizeof(model));
> > +	if (ret <= 0)
> > +		return ZONED_NONE;
> > +
> > +	if (strncmp(model, host_aware, strlen(host_aware)) == 0)
> > +		return ZONED_HOST_AWARE;
> > +	if (strncmp(model, host_managed, strlen(host_managed)) == 0)
> > +		return ZONED_HOST_MANAGED;
> > +
> > +	return ZONED_NONE;
> > +}
> > +
> > +u64 zone_size(const char *file)
> > +{
> > +	char chunk[32];
> > +	int ret;
> > +
> > +	ret = queue_param(file, "chunk_sectors", chunk, 
> > sizeof(chunk));
> > +	if (ret <= 0)
> > +		return 0;
> > +
> > +	return strtoull((const char *)chunk, NULL, 10) << 
> > SECTOR_SHIFT;
> > +}
> > +
> > +#ifdef BTRFS_ZONED
> > +static int report_zones(int fd, const char *file,
> > +			struct btrfs_zoned_device_info *zinfo)
> > +{
> > +	u64 device_size;
> > +	u64 zone_bytes = zone_size(file);
> > +	size_t rep_size;
> > +	u64 sector = 0;
> > +	struct blk_zone_report *rep;
> > +	struct blk_zone *zone;
> > +	unsigned int i, n = 0;
> > +	int ret;
> > +
> > +	/*
> > +	 * Zones are guaranteed (by the kernel) to be a power of 2 
> > number of
> > +	 * sectors. Check this here and make sure that zones are not 
> > too
> > +	 * small.
> > +	 */
> > +	if (!zone_bytes || !is_power_of_2(zone_bytes)) {
> > +		error("zoned: illegal zone size %llu (not a power of 2)",
> > +		      zone_bytes);
> > +		exit(1);
> > +	}
> > +	/*
> > +	 * The zone size must be large enough to hold the initial 
> > system
> > +	 * block group for mkfs time.
> > +	 */
> > +	if (zone_bytes < BTRFS_MKFS_SYSTEM_GROUP_SIZE) {
> > +		error("zoned: illegal zone size %llu (smaller than %d)",
> > +		      zone_bytes, BTRFS_MKFS_SYSTEM_GROUP_SIZE);
> > +		exit(1);
> 
> I see many exit() calls in this patch and other patches.
> Any special reasion?

Yeah, it should be turned into normal error returns and handling in the
callers.
