Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71493C3727
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jul 2021 00:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhGJWl0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jul 2021 18:41:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:41503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhGJWl0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jul 2021 18:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625956719;
        bh=RuzBDENEqLNnFYBBuSgAaiT2RjHIMVRzOXV4oJNP9OQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Q1UsHrCRbvU2gCeXbYTo9g9FE6gpYqwDcZ1ZdC7TwvCbQ7LlQR416lMQLBcUKPQk+
         k+QBs8i4R2YEim72Wyf+pMhL2tO2kY5Oi7P6gTOEpACQnJJhtDt2/wZNqQO9skqhgo
         WX+zyji8s87pL8cywW4aSEboYauVq/WQ5yLX2yYU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatVb-1lQp4X0lS7-00cTd4; Sun, 11
 Jul 2021 00:38:38 +0200
Subject: Re: [RFC] btrfs-progs: cmds: Add subcommand that dumps file extents
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210710144107.65224-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8f248d54-ec4d-9a53-840f-6d162de14267@gmx.com>
Date:   Sun, 11 Jul 2021 06:38:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210710144107.65224-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uM4u7Cfr3mgBOZ91YL/JRWOAGDOvP7fbUtdnMntJ+VHQmPVlsJW
 c1/0+l8vxvHX+yy8ny5l9appkxW6csXKPzzLpfZB5hO9cokCfyhYMXefRWlgQmAD7iThJpp
 MrcwMDiLWPvgHylhRbVzqbS+qLT/eXAg6HqdsK5RwMiR5cFZHoOP9H+U6p7XLjS5wJyQkj2
 njUY0uAB1pO1e97Uc0B/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+D9gEEqtF9Y=:pIxjH1dwpIAQYYeDUO9Zyb
 TG2ABUb+P4+tb5f0jeTX5P5bNrcI8wMgUl/k2mobNWqG+3bRvUyPoqpV4P9zjdE1aZY9pQ5Pu
 5ccT2LltbAbslImZvY8rBJX3Tk1HqvqFWMqSugM0jUsuUB6QT2Ru52qwQPWinY7cOvy2eyqdm
 dhNXYBJ+gLh7+6At3ngsaUiNjkxzwrADG4tui6Qsr+rRTsXY1Ld7Tl0tEua3+g/NESDSXz6Lq
 z94PafQmkLW0blwLPU11US2bPMo0EYSsxH4yKKzY/ltYxkxHzeaANwy2PqEtHOWQnx44KdMT6
 fEjHAqzkSrB6zpyFwB90pbNReIhWjev2ygICNWB3eVvTF3Z75ZW9nbmnSMoUSazfIPqSfTpAh
 mxNdQBDu/s0TmJ2o26lSoQOgJJitVhwudptnXSrS+sD+BHCJdiM10/7f2gT7vxWUrzEDhtrYh
 ZoKxuKGiEJZ/iNu8rAsKW7tkA3IVDbJBuWOX6ErS/rWbxe58DJtm7cnNM3D13OuA9g/w+Q2v3
 DJmKiDGha6gMfJSjt+SlwydW/hT0tbe1J1c3ZOX3Ht9+f2/PrRo2NHaWIgciDNGA3+9r787q0
 7sUn6qZwmhKKmw5qY1kj4hLIgqd912zbqGD4fbFbtEp1Q3Cq0QmxIMb88KnSfP9GPhmRPW8mg
 dmqqqHB3pAQafKYjJMQMJk47tHf6RF88270UkKqewcaxdVFz9C6y52PouEO+1nBHpXfwyvDlQ
 rn0Pv/WW7IuHT5IHqUMgL6aVuuCyiHhWuebzga3FBcYRfJzQUJsSKRdznqgNxe5WzS4pZOYT+
 U+glgobqgteRAqpjInkOL92bT/Aw3u0UBK/p8jgPUWaBcOkH9/fIx1XnGQZIDPtkHrX9Mv4tw
 +TPcKYuSXgCzHkLrmRyJS2PazHPIzl8wRMioDRIHtMzGmmvcSU1XEyZHs9jIIVMvVUt7W3yBc
 CYzYDql4aMZbGDkhHmzENFVrsNttZayN9oy9aIsNTvbTxlE1OektZLK+oX9XhJ9p77E3/ecBD
 3mRNoqziiaI9nuIqyP+46Dz9NYjULF/6KrY/a7GNZwlDHo0vklQavXHjuEsnN0/jemtVaUDSw
 qJgs07IfE6WVnUdeIAkX+pYaty8ukJxhHmHhJdWlBXa7fWcx2C1VQ5X0A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/10 =E4=B8=8B=E5=8D=8810:41, Sidong Yang wrote:
> This patch adds an subcommand in inspect-internal. It dumps file extents=
 of
> the file that user provided. It helps to show the internal information
> about file extents comprise the file.

So this is going to be the combined command of filemap + btrfs-map-logical=
.

But how do you handle dirty pages which hasn't yet been flushed to disk?

Thanks,
Qu
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> Hi, I'm writing an patch that adds an subcommand that dumps file extents=
 of
> the file. I don't have much idea about btrfs but I referenced btrfs
> wiki, dev-docs, and also Zygo's bee. It's just like draft.
>
> I have some questions below.
>
> The command works like below,
> # ./btrfs inspect-internal dump-file-extents /mnt/bb/TAGS
> begin =3D 0x0, end =3D 0x20000, physical =3D 0x4fdf5000, physical_len =
=3D 0xc000
> begin =3D 0x20000, end =3D 0x40000, physical =3D 0x4fe01000, physical_le=
n =3D 0xc000
> begin =3D 0x40000, end =3D 0x47000, physical =3D 0x4fe0d000, physical_le=
n =3D 0x3000
>
> What format would be better?
> Is it better to just use the variable name as it is? like disk_bytenr
> not like physical_len?
>
> And what option do we need? like showing compression or file extent type=
?
>
> Any comments will be welcome. Thanks!
> ---
>   Makefile                         |   2 +-
>   cmds/commands.h                  |   2 +-
>   cmds/inspect-dump-file-extents.c | 130 +++++++++++++++++++++++++++++++
>   cmds/inspect.c                   |   1 +
>   4 files changed, 133 insertions(+), 2 deletions(-)
>   create mode 100644 cmds/inspect-dump-file-extents.c
>
> diff --git a/Makefile b/Makefile
> index a1cc457b..911e16de 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -156,7 +156,7 @@ cmds_objects =3D cmds/subvolume.o cmds/filesystem.o =
cmds/device.o cmds/scrub.o \
>   	       cmds/restore.o cmds/rescue.o cmds/rescue-chunk-recover.o \
>   	       cmds/rescue-super-recover.o \
>   	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree=
.o \
> -	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesy=
stem-du.o \
> +	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/inspec=
t-dump-file-extents.o cmds/filesystem-du.o \
>   	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
>   libbtrfs_objects =3D common/send-stream.o common/send-utils.o kernel-l=
ib/rbtree.o btrfs-list.o \
>   		   kernel-lib/radix-tree.o common/extent-cache.o kernel-shared/exten=
t_io.o \
> diff --git a/cmds/commands.h b/cmds/commands.h
> index 8fa85d6c..55de248e 100644
> --- a/cmds/commands.h
> +++ b/cmds/commands.h
> @@ -154,5 +154,5 @@ DECLARE_COMMAND(select_super);
>   DECLARE_COMMAND(dump_super);
>   DECLARE_COMMAND(debug_tree);
>   DECLARE_COMMAND(rescue);
> -
> +DECLARE_COMMAND(inspect_dump_file_extents);
>   #endif
> diff --git a/cmds/inspect-dump-file-extents.c b/cmds/inspect-dump-file-e=
xtents.c
> new file mode 100644
> index 00000000..99aec7d7
> --- /dev/null
> +++ b/cmds/inspect-dump-file-extents.c
> @@ -0,0 +1,130 @@
> +/*
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
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <fcntl.h>
> +
> +#include <sys/ioctl.h>
> +
> +#include "common/utils.h"
> +#include "cmds/commands.h"
> +
> +static const char * const cmd_inspect_dump_file_extents_usage[] =3D {
> +	"btrfs inspect-internal dump-extent path",
> +	"Dump file extent in a textual form",
> +	NULL
> +};
> +
> +static int cmd_inspect_dump_file_extents(const struct cmd_struct *cmd,
> +										 int argc, char **argv)
> +{
> +	int fd;
> +	struct stat statbuf;
> +	struct btrfs_ioctl_ino_lookup_args lookup;
> +	struct btrfs_ioctl_search_args args;
> +	struct btrfs_ioctl_search_key *sk =3D &args.key;
> +	struct btrfs_file_extent_item *extent_item;
> +	struct btrfs_ioctl_search_header *header;
> +	u64 pos;
> +	u64 buf_off;
> +	u64 len;
> +	u64 begin;
> +	u64 physical;
> +	u64 offset;
> +	u64 physical_len;
> +	int ret;
> +	int i;
> +
> +	fd =3D open(argv[optind], O_RDONLY);
> +	if (fd < 0) {
> +		error("cannot open %s: %m", argv[optind]);
> +		ret =3D 1;
> +		goto out;
> +	}
> +
> +	if (fstat(fd, &statbuf) < 0) {
> +		error("failed to fstat %s: %m", argv[optind]);
> +		ret =3D 1;
> +		goto out;
> +	}
> +
> +	lookup.treeid =3D 0;
> +	lookup.objectid =3D BTRFS_FIRST_FREE_OBJECTID;
> +
> +	if (ioctl(fd, BTRFS_IOC_INO_LOOKUP, &lookup) < 0) {
> +		error("failed to lookup inode %s: %m", argv[optind]);
> +		ret =3D 1;
> +		goto out;
> +	}
> +
> +	pos =3D 0;
> +
> +	sk->tree_id =3D lookup.treeid;
> +	sk->min_objectid =3D statbuf.st_ino;
> +	sk->max_objectid =3D statbuf.st_ino;
> +
> +	sk->max_offset =3D UINT64_MAX;
> +	sk->min_transid =3D 0;
> +	sk->max_transid =3D UINT64_MAX;
> +	sk->min_type =3D sk->max_type =3D BTRFS_EXTENT_DATA_KEY;
> +	sk->nr_items =3D 4096;
> +
> +	while (statbuf.st_size > pos) {
> +		sk->min_offset =3D pos;
> +		if (ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args)) {
> +			error("failed to search tree ioctl %s: %m", argv[optind]);
> +			ret =3D 1;
> +			goto out;
> +		}
> +
> +		buf_off =3D 0;
> +		for(i=3D0; i<sk->nr_items; ++i) {
> +			header =3D (struct btrfs_ioctl_search_header *)(args.buf + buf_off);
> +
> +			if (btrfs_search_header_type(header) =3D=3D BTRFS_EXTENT_DATA_KEY) {
> +				extent_item =3D (struct btrfs_file_extent_item *)(header + 1);
> +				begin =3D btrfs_search_header_offset(header);
> +
> +				printf("begin =3D 0x%llx, ", begin);
> +				switch (extent_item->type) {
> +				case BTRFS_FILE_EXTENT_INLINE:
> +					len =3D le64_to_cpu(extent_item->ram_bytes);
> +					printf("end =3D 0x%llx\n", begin + len);
> +					break;
> +				case BTRFS_FILE_EXTENT_REG:
> +				case BTRFS_FILE_EXTENT_PREALLOC:
> +					len =3D le64_to_cpu(extent_item->num_bytes);
> +					physical =3D le64_to_cpu(extent_item->disk_bytenr);
> +					physical_len =3D le64_to_cpu(extent_item->disk_num_bytes);
> +					offset =3D le64_to_cpu(extent_item->offset);
> +					printf("end =3D 0x%llx, physical =3D 0x%llx, physical_len =3D 0x%l=
lx\n",
> +						   begin + len, physical, physical_len);
> +					break;
> +				}
> +
> +			}
> +			buf_off +=3D sizeof(*header) + btrfs_search_header_len(header);
> +			pos +=3D len;
> +		}
> +
> +	}
> +	ret =3D 0;
> +out:
> +	close(fd);
> +	return ret;
> +}
> +DEFINE_SIMPLE_COMMAND(inspect_dump_file_extents, "dump-file-extents");
> diff --git a/cmds/inspect.c b/cmds/inspect.c
> index 2ef5f4b6..dfb0e27b 100644
> --- a/cmds/inspect.c
> +++ b/cmds/inspect.c
> @@ -696,6 +696,7 @@ static const struct cmd_group inspect_cmd_group =3D =
{
>   		&cmd_struct_inspect_dump_tree,
>   		&cmd_struct_inspect_dump_super,
>   		&cmd_struct_inspect_tree_stats,
> +		&cmd_struct_inspect_dump_file_extents,
>   		NULL
>   	}
>   };
>
