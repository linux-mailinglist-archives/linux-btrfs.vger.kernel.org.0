Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2970B3C4B04
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 12:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbhGLGzW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 02:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhGLGwB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 02:52:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F59C069B59
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jul 2021 23:40:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p9so9540854pjl.3
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jul 2021 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RFM3edb+2uTv+QR4X/Y/f055tR17SszBT4RoOjEYeuo=;
        b=gAgwgWD/BJH6CE35RTHbmnwqe2ABgZJsOFdzC1VFlmezCrq1TGbTT7cK76/NfKNu5g
         hANuGYMEkaaaGjxqKiFa+H9HDfsnRAkOJjPiVFDJPi7zIF1gf2pSk+gAl6k1p9tS0GNR
         uK2cGyCPgso+g3N79i8eoZE1tHKUXZENx+jHoLBvD1vqV7ZxbQb4XJbNO+QJqtyZw8ja
         5GLyBO0rfdasmbaIdIlKxg7bQ+fwj0cmtQs+4Lmt+VMNLH8/7KjP5XD86x3k641WLaTz
         OVZc2hohNxIzXX5L2moHF8R0z6BvJQujSEBZbcIhLRGuJfRlyI3lpt+N9UOavgielYmW
         16Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RFM3edb+2uTv+QR4X/Y/f055tR17SszBT4RoOjEYeuo=;
        b=taLRNq81y2wiol0JtatuSp7h1SEftHe7ThH5GY6bG4uaRaVPxU9ZwaBr2w+RYM2bHu
         yz374Lngv0RZj9AAjvXM3xGR16w9bo34G4woUjKmlHK3tprGlNH9qg3mZdRelXc8256Z
         A7lEz2DFe6boOKTLUVlFLR52z2zNvHyVTBTEDMjqJXSW+tci4vGLt2r3ydbhTfSyeKOj
         6vzXFTib5l+ECjlx9l5QMR9MsVP6eJcfQIEpMCh3ek8Pcg+DJ5/K4+aEz89LHqio/T7x
         WIyX8W/J2n/BEhmTNiXfJKVhxhrf7FYWTOFXvJobqmljhwZBGj8DkNupz0e+w50q+wYd
         T1Og==
X-Gm-Message-State: AOAM533fgaBLsSXLhC24h1sgDIwubQWUrk4Yn75/ASB7eDfRRArmEdQQ
        mb61IKjNMJelzncLjMyaz/Q=
X-Google-Smtp-Source: ABdhPJyh9dQn//3aBsuSbj+/tTzfPpHGUfRMacD8RQfgNuv/BIc3ZWwFeHoHSW9dNFhc94KUv+t+bA==
X-Received: by 2002:a17:902:bc47:b029:129:dd30:1c30 with SMTP id t7-20020a170902bc47b0290129dd301c30mr18859534plz.4.1626072013530;
        Sun, 11 Jul 2021 23:40:13 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id v5sm16238240pgi.74.2021.07.11.23.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 23:40:13 -0700 (PDT)
Date:   Mon, 12 Jul 2021 06:40:08 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Message-ID: <20210712064008.GB68357@realwakka>
References: <20210711161007.68589-1-realwakka@gmail.com>
 <20d7b0a8-8e1c-c13a-6a94-525a110a6b0e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20d7b0a8-8e1c-c13a-6a94-525a110a6b0e@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 12, 2021 at 09:16:17AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/12 上午12:10, Sidong Yang wrote:
> > This patch adds an subcommand in inspect-internal. It dumps file extents of
> > the file that user provided. It helps to show the internal information
> > about file extents comprise the file.
> 
> Despite the comments inlined below for the technical details, I'm not
> determined if we really want the tool.
> 
> On one hand, fiemap doesn't provide all detailed btrfs specific info, and
> it's common to utilize the tree search ioctl to do the work, just like
> "compsize".
> 
> But on the other hand, I'm not sure if it provides enough info compared to
> things like "btrfs ins dump-tree".
> 
> For now I don't have any objection nor preference.
> 
> Thus it's again David's call on this.
> 
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> > v2:
> >   - Prints type and compression
> >   - Use the terms from file_extents_item like disk_bytenr not like physical"
> > ---
> >   Makefile                         |   2 +-
> >   cmds/commands.h                  |   2 +-
> >   cmds/inspect-dump-file-extents.c | 165 +++++++++++++++++++++++++++++++
> >   cmds/inspect.c                   |   1 +
> >   4 files changed, 168 insertions(+), 2 deletions(-)
> >   create mode 100644 cmds/inspect-dump-file-extents.c
> > 
> > diff --git a/Makefile b/Makefile
> > index a1cc457b..911e16de 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -156,7 +156,7 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
> >   	       cmds/restore.o cmds/rescue.o cmds/rescue-chunk-recover.o \
> >   	       cmds/rescue-super-recover.o \
> >   	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o \
> > -	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
> > +	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/inspect-dump-file-extents.o cmds/filesystem-du.o \
> >   	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
> >   libbtrfs_objects = common/send-stream.o common/send-utils.o kernel-lib/rbtree.o btrfs-list.o \
> >   		   kernel-lib/radix-tree.o common/extent-cache.o kernel-shared/extent_io.o \
> > diff --git a/cmds/commands.h b/cmds/commands.h
> > index 8fa85d6c..55de248e 100644
> > --- a/cmds/commands.h
> > +++ b/cmds/commands.h
> > @@ -154,5 +154,5 @@ DECLARE_COMMAND(select_super);
> >   DECLARE_COMMAND(dump_super);
> >   DECLARE_COMMAND(debug_tree);
> 
> Off-topic here.
> 
> Those "dump_super" and "debug_tree" makes me wonder, do we need to cleanup
> them?
> 
> I mean, we have inspect_dump_super for "btrfs ins dump-super", but what's
> "dump_super" here for?
> And what's the "debug_tree" here for?
there is no command dump_super and debug_tree. And these aren't need to
compile.
> 
> >   DECLARE_COMMAND(rescue);
> > -
> > +DECLARE_COMMAND(inspect_dump_file_extents);
> 
> I would be better to put this line where the other "inpsect" subcommands
> are.

Okay, I'll do it.
> 
> >   #endif
> > diff --git a/cmds/inspect-dump-file-extents.c b/cmds/inspect-dump-file-extents.c
> > new file mode 100644
> > index 00000000..8574a1d0
> > --- /dev/null
> > +++ b/cmds/inspect-dump-file-extents.c
> > @@ -0,0 +1,165 @@
> > +/*
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public
> > + * License v2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public
> > + * License along with this program; if not, write to the
> > + * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
> > + * Boston, MA 021110-1307, USA.
> > + */
> > +
> > +#include <unistd.h>
> > +#include <stdio.h>
> > +#include <fcntl.h>
> > +
> > +#include <sys/ioctl.h>
> > +
> > +#include "common/utils.h"
> > +#include "cmds/commands.h"
> > +
> > +static const char * const cmd_inspect_dump_file_extents_usage[] = {
> > +	"btrfs inspect-internal dump-extent path",
> > +	"Dump file extent in a textual form",
> > +	NULL
> > +};
> > +
> > +static void compress_type_to_str(u8 compress_type, char *ret)
> > +{
> > +	switch (compress_type) {
> > +	case BTRFS_COMPRESS_NONE:
> > +		strcpy(ret, "none");
> > +		break;
> > +	case BTRFS_COMPRESS_ZLIB:
> > +		strcpy(ret, "zlib");
> > +		break;
> > +	case BTRFS_COMPRESS_LZO:
> > +		strcpy(ret, "lzo");
> > +		break;
> > +	case BTRFS_COMPRESS_ZSTD:
> > +		strcpy(ret, "zstd");
> > +		break;
> > +	default:
> > +		sprintf(ret, "UNKNOWN.%d", compress_type);
> > +	}
> > +}
> 
> It would be better to just export the function with the same name in
> "kernel-shared/print-tree.c" so we don't have duplicated code.

Yes, I would be better.
> 
> > +
> > +static const char* file_extent_type_to_str(u8 type)
> > +{
> > +	switch (type) {
> > +	case BTRFS_FILE_EXTENT_INLINE: return "inline";
> > +	case BTRFS_FILE_EXTENT_PREALLOC: return "prealloc";
> > +	case BTRFS_FILE_EXTENT_REG: return "regular";
> > +	default: return "unknown";
> > +	}
> > +}
> 
> The same here.
Okay.
> 
> > +
> > +static int cmd_inspect_dump_file_extents(const struct cmd_struct *cmd,
> > +										 int argc, char **argv)
> > +{
> > +	int fd;
> > +	struct stat statbuf;
> > +	struct btrfs_ioctl_ino_lookup_args lookup;
> > +	struct btrfs_ioctl_search_args args;
> > +	struct btrfs_ioctl_search_key *sk = &args.key;
> > +	struct btrfs_file_extent_item *extent_item;
> > +	struct btrfs_ioctl_search_header *header;
> > +	u64 pos;
> > +	u64 buf_off;
> > +	u64 len;
> > +	u64 begin;
> > +	u64 disk_bytenr;
> > +	u64 disk_num_bytes;
> > +	u64 offset;
> > +	int ret;
> > +	int i;
> > +	char compress_str[16];
> > +
> > +	fd = open(argv[optind], O_RDONLY);
> > +	if (fd < 0) {
> > +		error("cannot open %s: %m", argv[optind]);
> > +		ret = 1;
> > +		goto out;
> > +	}
> > +
> > +	if (fstat(fd, &statbuf) < 0) {
> > +		error("failed to fstat %s: %m", argv[optind]);
> > +		ret = 1;
> > +		goto out;
> > +	}
> > +
> > +	lookup.treeid = 0;
> > +	lookup.objectid = BTRFS_FIRST_FREE_OBJECTID;
> > +
> > +	if (ioctl(fd, BTRFS_IOC_INO_LOOKUP, &lookup) < 0) {
> > +		error("failed to lookup inode %s: %m", argv[optind]);
> > +		ret = 1;
> > +		goto out;
> > +	}
> > +
> > +	pos = 0;
> > +
> > +	sk->tree_id = lookup.treeid;
> > +	sk->min_objectid = statbuf.st_ino;
> > +	sk->max_objectid = statbuf.st_ino;
> > +
> > +	sk->max_offset = UINT64_MAX;
> > +	sk->min_transid = 0;
> > +	sk->max_transid = UINT64_MAX;
> > +	sk->min_type = sk->max_type = BTRFS_EXTENT_DATA_KEY;
> > +	sk->nr_items = 4096;
> 
> You may want to do the tree search ioctl in a loop, as it's pretty common
> for super large or heavily fragmented inode to have way more items than one
> ioctl can return.

I don't think much about this. I wonder if it's proper way to search
tree. is there any better way than this code?

> 
> > +
> > +	while (statbuf.st_size > pos) {
> > +		sk->min_offset = pos;
> > +		if (ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args)) {
> > +			error("failed to search tree ioctl %s: %m", argv[optind]);
> > +			ret = 1;
> > +			goto out;
> > +		}
> > +
> > +		buf_off = 0;
> > +		for(i=0; i<sk->nr_items; ++i) {
> > +			header = (struct btrfs_ioctl_search_header *)(args.buf + buf_off);
> > +
> > +			if (btrfs_search_header_type(header) == BTRFS_EXTENT_DATA_KEY) {
> > +				extent_item = (struct btrfs_file_extent_item *)(header + 1);
> > +				begin = btrfs_search_header_offset(header);
> > +
> > +				printf("type = %s, begin = %llu, ",
> > +					   file_extent_type_to_str(extent_item->type), begin);
> > +				switch (extent_item->type) {
> > +				case BTRFS_FILE_EXTENT_INLINE:
> > +					len = le64_to_cpu(extent_item->ram_bytes);
> > +					printf("end = %llu\n", begin + len);
> > +					break;
> > +				case BTRFS_FILE_EXTENT_REG:
> > +				case BTRFS_FILE_EXTENT_PREALLOC:
> > +					len = le64_to_cpu(extent_item->num_bytes);
> > +					disk_bytenr = le64_to_cpu(extent_item->disk_bytenr);
> > +					disk_num_bytes = le64_to_cpu(extent_item->disk_num_bytes);
> > +					offset = le64_to_cpu(extent_item->offset);
> > +					compress_type_to_str(extent_item->compression, compress_str);
> > +					printf("end = %llu, disk_bytenr = %llu, disk_num_bytes = %llu,"
> 
> For "end" we normally mean inclusive end.
> E.g, for @start = 1M, @len = 4K, then the @end should be 1M + 4K - 1.
> 
> Thus it would be better to just output the length, not the end.

Okay, Printing output as start and len would be more explicit.

Thanks,
Sidong
> 
> (I know this sounds a little nitpicking, but trust me, when you have seen
> too many bugs caused by such offset-by-one behavior, you will be as
> sensitive as me on this)
> 
> Thanks,
> Qu
> 
> > +						   " offset = %llu, compression = %s\n",
> > +						   begin + len, disk_bytenr, disk_num_bytes, offset, compress_str); > +
> > +					break;
> > +				}
> > +
> > +			}
> > +			buf_off += sizeof(*header) + btrfs_search_header_len(header);
> > +			pos += len;
> > +		}
> > +
> > +	}
> > +	ret = 0;
> > +out:
> > +	close(fd);
> > +	return ret;
> > +}
> > +DEFINE_SIMPLE_COMMAND(inspect_dump_file_extents, "dump-file-extents");
> > diff --git a/cmds/inspect.c b/cmds/inspect.c
> > index 2ef5f4b6..dfb0e27b 100644
> > --- a/cmds/inspect.c
> > +++ b/cmds/inspect.c
> > @@ -696,6 +696,7 @@ static const struct cmd_group inspect_cmd_group = {
> >   		&cmd_struct_inspect_dump_tree,
> >   		&cmd_struct_inspect_dump_super,
> >   		&cmd_struct_inspect_tree_stats,
> > +		&cmd_struct_inspect_dump_file_extents,
> >   		NULL
> >   	}
> >   };
> > 
> 
