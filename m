Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E481B6AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfEMNFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 09:05:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbfEMNFo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 09:05:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C24AAF61
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 13:05:42 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] btrfs-progs: add 'btrfs inspect-internal
 csum-dump' command
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190424144754.4612-1-jthumshirn@suse.de>
 <20190424144754.4612-3-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bc59b1f7-dc11-1c16-ea76-b99be0bd0886@suse.com>
Date:   Mon, 13 May 2019 16:05:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424144754.4612-3-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.04.19 г. 17:47 ч., Johannes Thumshirn wrote:
> Add a 'btrfs inspect-internal csum-dump' command to dump the on-disk
> checksums of a file.
> 
> The dump command first uses the FIEMAP ioctl() to get a map of the file's
> extents and then uses the BTRFS_TREE_SEARCH_V2 ioctl() to get the
> checksums for these extents.
> 
> Using FIEMAP instead of the BTRFS_TREE_SEARCH_V2 ioctl() to get the
> extents allows us to quickly filter out any holes in the file, as this is
> already done for us in the kernel.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  Makefile                 |   3 +-
>  cmds-inspect-dump-csum.c | 253 +++++++++++++++++++++++++++++++++++++++++++++++
>  cmds-inspect.c           |   2 +
>  commands.h               |   2 +
>  4 files changed, 259 insertions(+), 1 deletion(-)
>  create mode 100644 cmds-inspect-dump-csum.c
> 
> diff --git a/Makefile b/Makefile
> index e25e256f96af..f5d0c0532faf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -130,7 +130,8 @@ cmds_objects = cmds-subvolume.o cmds-filesystem.o cmds-device.o cmds-scrub.o \
>  	       cmds-restore.o cmds-rescue.o chunk-recover.o super-recover.o \
>  	       cmds-property.o cmds-fi-usage.o cmds-inspect-dump-tree.o \
>  	       cmds-inspect-dump-super.o cmds-inspect-tree-stats.o cmds-fi-du.o \
> -	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
> +	       cmds-inspect-dump-csum.o mkfs/common.o check/mode-common.o \
> +	       check/mode-lowmem.o
>  libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
>  		   kernel-lib/crc32c.o messages.o \
>  		   uuid-tree.o utils-lib.o rbtree-utils.o
> diff --git a/cmds-inspect-dump-csum.c b/cmds-inspect-dump-csum.c
> new file mode 100644
> index 000000000000..67e14fde6ec7
> --- /dev/null
> +++ b/cmds-inspect-dump-csum.c
> @@ -0,0 +1,253 @@
> +/*
> + * Copyright (C) 2019 SUSE. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public
> + * License v2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public
> + * License along with this program; if not, write to the
> + * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
> + * Boston, MA 021110-1307, USA.
> + */
> +
> +#include <linux/fiemap.h>
> +#include <linux/fs.h>
> +
> +#include <sys/types.h>
> +#include <sys/ioctl.h>
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +
> +#include "kerncompat.h"
> +#include "ctree.h"
> +#include "messages.h"
> +#include "help.h"
> +#include "ioctl.h"
> +#include "utils.h"
> +#include "disk-io.h"
> +
> +static bool debug = false;
> +
> +static int btrfs_lookup_csum_for_phys(int fd, struct btrfs_super_block *sb,
> +				      u64 phys, u64 extent_csums)

nit: This function could be renamed to btrfs_lookup_csum_for_extent.
Then instead of passing 'phys' and the calculated 'extent_csum' values
you pass directly a struct fiemap_extent so all calculation involving
the extent will be encapsulated in a single function. It's my personal
feeling this makes it a bit more cohesivr.

> +{
> +	struct btrfs_ioctl_search_args_v2 *search;
> +	struct btrfs_ioctl_search_key *sk;
> +	int bufsz = 1024;

nit: I'd rather have this value be a #defined CONSTANT 1024. At the very
least it should have const qualifier.

> +	char buf[bufsz], *bp;
> +	unsigned int off = 0;
> +	const int csum_size = btrfs_super_csum_size(sb);
> +	const int sector_size = btrfs_super_sectorsize(sb);
> +	int ret, i, j;
> +	u64 needle = phys;
> +	u64 pending_csum_count = extent_csums;
> +
> +	memset(buf, 0, sizeof(buf));
> +	search = (struct btrfs_ioctl_search_args_v2 *)buf;
> +	sk = &search->key;
> +
> +again:
> +	if (debug)
> +		printf(
> +"Looking up checksums for extent at physial offset: %llu (searching at %llu), looking for %llu csums\n",
> +		       phys, needle, pending_csum_count);
> +
> +	sk->tree_id = BTRFS_CSUM_TREE_OBJECTID;
> +	sk->min_objectid = BTRFS_EXTENT_CSUM_OBJECTID;
> +	sk->max_objectid = BTRFS_EXTENT_CSUM_OBJECTID;
> +	sk->max_type = BTRFS_EXTENT_CSUM_KEY;
> +	sk->min_type = BTRFS_EXTENT_CSUM_KEY;
> +	sk->min_offset = needle;
> +	sk->max_offset = (u64)-1;
> +	sk->max_transid = (u64)-1;
> +	sk->nr_items = 1;
> +	search->buf_size = bufsz - sizeof(*search);
> +
> +	ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH_V2, search);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * If we don't find the csum item at @needle go back by @sector_size and
> +	 * retry until we've found it.
> +	 */
> +	if (sk->nr_items == 0) {
> +		needle -= sector_size;
> +		goto again;
> +	}
> +
> +
> +	bp = (char *) search->buf;
> +
> +	for (i = 0; i < sk->nr_items; i++) {
> +		struct btrfs_ioctl_search_header *sh;
> +		u64 csums_in_item;
> +
> +		sh = (struct btrfs_ioctl_search_header *) (bp + off);
> +		off += sizeof(*sh);
> +
> +		csums_in_item = btrfs_search_header_len(sh) / csum_size;
> +		csums_in_item = min(csums_in_item, pending_csum_count);
> +
> +		for (j = 0; j < csums_in_item; j++) {
> +			struct btrfs_csum_item *csum_item;
> +
> +			csum_item = (struct btrfs_csum_item *)
> +						(bp + off + j * csum_size);
> +
> +			printf("Offset: %llu, checksum: 0x%08x\n",
> +			       phys + j * sector_size, *(u32 *)csum_item);
> +		}
> +
> +		off += btrfs_search_header_len(sh);
> +		pending_csum_count -= csums_in_item;
> +
> +	}
> +
> +	return ret;
> +}
> +
> +static int btrfs_get_extent_csum(int fd, struct btrfs_super_block *sb)
> +{
> +	struct fiemap *fiemap, *tmp;
> +	struct fiemap_extent *fe;
> +	size_t ext_size;
> +	int ret, i;
> +
> +	fiemap = calloc(1, sizeof(*fiemap));
> +	if (!fiemap)
> +		return -ENOMEM;
> +
> +	fiemap->fm_length = ~0;
> +
> +	ret = ioctl(fd, FS_IOC_FIEMAP, fiemap);
> +	if (ret)
> +		goto free_fiemap;
> +
> +	ext_size = fiemap->fm_mapped_extents * sizeof(struct fiemap_extent);
> +
> +	tmp = realloc(fiemap, sizeof(*fiemap) + ext_size);
> +	if (!tmp) {
> +		ret = -ENOMEM;
> +		goto free_fiemap;
> +	}
> +
> +	fiemap = tmp;
> +	fiemap->fm_extent_count = fiemap->fm_mapped_extents;
> +	fiemap->fm_mapped_extents = 0;
> +
> +	ret = ioctl(fd, FS_IOC_FIEMAP, fiemap);
> +	if (ret)
> +		goto free_fiemap;
> +
> +	for (i = 0; i < fiemap->fm_mapped_extents; i++) {
> +		u64 extent_csums;
> +
> +		fe = &fiemap->fm_extents[i];
> +		extent_csums = fe->fe_length / btrfs_super_sectorsize(sb);
> +
> +		if (debug)
> +			printf(
> +"Found extent at physial offset: %llu, length %llu, looking for %llu csums\n",
> +			       fe->fe_physical, fe->fe_length, extent_csums);
> +
> +		ret = btrfs_lookup_csum_for_phys(fd, sb, fe->fe_physical,
> +						 extent_csums);
> +		if (ret)
> +			break;
> +
> +		if(fe->fe_flags & FIEMAP_EXTENT_LAST)
> +			break;

Does this add any value, given fm_mapped_extents contains the exact
number of extents so after the last one is processed i will be ==
fm_mapped_extents hence the loop will terminate as expected?

> +	}
> +
> +
> +free_fiemap:
> +	free(fiemap);
> +	return ret;
> +}
> +
> +const char * const cmd_inspect_dump_csum_usage[] = {
> +	"btrfs inspect-internal dump-csum <path> <device>",
> +	"Get Checksums for a given file",
> +	"-d|--debug    Be more verbose",
> +	NULL
> +};
> +
> +int cmd_inspect_dump_csum(int argc, char **argv)
> +{
> +	struct btrfs_super_block *sb;
> +	u8 super_block_data[BTRFS_SUPER_INFO_SIZE] = { 0 };

Any particular reason why you've defined the storage for sb this way?
Why not simply struct btrfs_super_block sb;

> +	char *filename;
> +	char *device;
> +	int fd;
> +	int devfd;
> +	int ret;
> +
> +	optind = 0;
> +
> +	sb = (struct btrfs_super_block *)super_block_data;

Then you could remove this.

> +
> +	while (1) {
> +		static const struct option longopts[] = {
> +			{ "debug", no_argument, NULL, 'd' },
> +			{ NULL, 0, NULL, 0 }
> +		};
> +
> +		int opt = getopt_long(argc, argv, "d", longopts, NULL);
> +		if (opt < 0)
> +			break;
> +
> +		switch (opt) {
> +		case 'd':
> +			debug = true;
> +			break;
> +		default:
> +			usage(cmd_inspect_dump_csum_usage);
> +		}
> +	}
> +
> +	if (check_argc_exact(argc - optind, 2))
> +		usage(cmd_inspect_dump_csum_usage);
> +
> +	filename = argv[optind];
> +	device = argv[optind + 1];
> +
> +	fd = open(filename, O_RDONLY);
> +	if (fd < 0) {
> +		error("cannot open file %s:%m", filename);
> +		return -errno;
> +	}
> +
> +	devfd = open(device, O_RDONLY);
> +	if (devfd < 0) {
> +		ret = -errno;
> +		goto out_close;
> +	}
> +	load_sb(devfd, btrfs_sb_offset(0), sb, BTRFS_SUPER_INFO_SIZE);

then just pass &sb here

> +	close(devfd);
> +
> +	if (btrfs_super_magic(sb) != BTRFS_MAGIC) {
> +		ret = -EINVAL;
> +		error("bad magic on superblock on %s", device);
> +		goto out_close;
> +	}
> +
> +	ret = btrfs_get_extent_csum(fd,sb);

And here: &sb

> +	if (ret)
> +		error("checsum lookup for file %s failed", filename);
> +out_close:
> +	close(fd);
> +	return ret;
> +}
> diff --git a/cmds-inspect.c b/cmds-inspect.c
> index efea0331b7aa..c20decbf6fac 100644
> --- a/cmds-inspect.c
> +++ b/cmds-inspect.c
> @@ -654,6 +654,8 @@ const struct cmd_group inspect_cmd_group = {
>  				cmd_inspect_dump_super_usage, NULL, 0 },
>  		{ "tree-stats", cmd_inspect_tree_stats,
>  				cmd_inspect_tree_stats_usage, NULL, 0 },
> +		{ "dump-csum",  cmd_inspect_dump_csum,
> +				cmd_inspect_dump_csum_usage, NULL, 0 },
>  		NULL_CMD_STRUCT
>  	}
>  };
> diff --git a/commands.h b/commands.h
> index 76991f2b28d5..698ae532b2b8 100644
> --- a/commands.h
> +++ b/commands.h
> @@ -92,6 +92,7 @@ extern const char * const cmd_rescue_usage[];
>  extern const char * const cmd_inspect_dump_super_usage[];
>  extern const char * const cmd_inspect_dump_tree_usage[];
>  extern const char * const cmd_inspect_tree_stats_usage[];
> +extern const char * const cmd_inspect_dump_csum_usage[];
>  extern const char * const cmd_filesystem_du_usage[];
>  extern const char * const cmd_filesystem_usage_usage[];
>  
> @@ -108,6 +109,7 @@ int cmd_super_recover(int argc, char **argv);
>  int cmd_inspect(int argc, char **argv);
>  int cmd_inspect_dump_super(int argc, char **argv);
>  int cmd_inspect_dump_tree(int argc, char **argv);
> +int cmd_inspect_dump_csum(int argc, char **argv);
>  int cmd_inspect_tree_stats(int argc, char **argv);
>  int cmd_property(int argc, char **argv);
>  int cmd_send(int argc, char **argv);
> 
