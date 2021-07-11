Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595C03C3B3F
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jul 2021 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhGKJFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jul 2021 05:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKJFn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jul 2021 05:05:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13355C0613DD
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jul 2021 02:02:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u14so14818424pga.11
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jul 2021 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=572mRqufv3K1BLmp84FE17BKL58cDB/Ube/l/UL65ME=;
        b=gJv+ODZpJErduhmZqE1mZhe7SZrldP4HcfjaGLYBBE3UQaaDXLbvHVZBcfPQDzHCra
         0RmjiE4J9vCdgmpdZdr1/LpR+H7SuOnlOcsKU90Qdil7j+LkMkx9Bzu+Hhm4u8tI3ELB
         7kLGTrCfMhLGXWEZ/0cj1c8vxmnv8cTy0A2krHIWHuVqD8B1Uid1skc+YSmzR1/W0NcG
         BDo8jDIBFeyaKl0/NSsy+6grpVQPxp/o9f4yw5giaZIHs0eGn/Y3GBqdFb9NYKkq3m4/
         8l1peu7n1mktjzI4f6uhmzNCEyglDvmZtL14s9VSbrxmXPvSI9mk+mUpSI9yr58Rte2a
         7NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=572mRqufv3K1BLmp84FE17BKL58cDB/Ube/l/UL65ME=;
        b=GcZo4LnN/lN20IIvTJyfD2QILB1kjCL1ISE57pXrhS2nLvtukpGai175ZOePAKSekI
         0VeAz7FuHbOWQcNsj5S5OGEQR2mZuG1JuetdLboB/bEfVU+alIbRxFDgsYobIpmuC/Eg
         YQTMsmuStdxHKGBHIkNUpDRtPYO+p7fKO2EaWekqw6kAbm0csAfWreyAI3WPxkphkp0z
         wk0ykgbL1l0f83if8bxbTEOwUvwux8+11NCeoJYL7s8kmVUwE2TzCGIoePBEO/6Wh9Fl
         H93bOi68KfvK2OTNNGgTwtsXyyZvjuOdx3dnDCe81DQOT32kbtfn+I/0ZT2jWPQA7W5v
         0h3A==
X-Gm-Message-State: AOAM532earyUwhl1RDWrBH6X1zUp+XgGJ3wHPCEIRVEgOWQeB5wiF5Gf
        +RmSlHP+Ibr//jOdqHT/+Ms=
X-Google-Smtp-Source: ABdhPJzQ9JPCkwaI759M3gqBJrEtlJcAYVXnRyHKMqMZkDLTY4lrQ3PoWr8fr7x/Be98XR9fzcsN6g==
X-Received: by 2002:a63:1e63:: with SMTP id p35mr3372170pgm.97.1625994175541;
        Sun, 11 Jul 2021 02:02:55 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id gk20sm10352996pjb.17.2021.07.11.02.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 02:02:55 -0700 (PDT)
Date:   Sun, 11 Jul 2021 09:02:47 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC] btrfs-progs: cmds: Add subcommand that dumps file extents
Message-ID: <20210711090247.GA66300@realwakka>
References: <20210710144107.65224-1-realwakka@gmail.com>
 <8f248d54-ec4d-9a53-840f-6d162de14267@gmx.com>
 <1d679d44-c608-8d51-32d9-84c15d636e33@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d679d44-c608-8d51-32d9-84c15d636e33@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 11, 2021 at 09:33:43AM +0800, Qu Wenruo wrote:

Hi, I really thank you for review.
> 
> 
> On 2021/7/11 上午6:38, Qu Wenruo wrote:
> > 
> > 
> > On 2021/7/10 下午10:41, Sidong Yang wrote:
> > > This patch adds an subcommand in inspect-internal. It dumps file
> > > extents of
> > > the file that user provided. It helps to show the internal information
> > > about file extents comprise the file.
> > 
> > So this is going to be the combined command of filemap + btrfs-map-logical.
> > 
> > But how do you handle dirty pages which hasn't yet been flushed to disk?

I have no idea about this. Is there any references to get dirty pages
information?

> > 
> > Thanks,
> > Qu
> > > 
> > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > ---
> > > Hi, I'm writing an patch that adds an subcommand that dumps file
> > > extents of
> > > the file. I don't have much idea about btrfs but I referenced btrfs
> > > wiki, dev-docs, and also Zygo's bee. It's just like draft.
> > > 
> > > I have some questions below.
> > > 
> > > The command works like below,
> > > # ./btrfs inspect-internal dump-file-extents /mnt/bb/TAGS
> > > begin = 0x0, end = 0x20000, physical = 0x4fdf5000, physical_len = 0xc000
> > > begin = 0x20000, end = 0x40000, physical = 0x4fe01000, physical_len =
> > > 0xc000
> > > begin = 0x40000, end = 0x47000, physical = 0x4fe0d000, physical_len =
> > > 0x3000
> > > 
> > > What format would be better?
> > > Is it better to just use the variable name as it is? like disk_bytenr
> > > not like physical_len?
> > > 
> > > And what option do we need? like showing compression or file extent type?
> > > 
> > > Any comments will be welcome. Thanks!
> > > ---
> > >   Makefile                         |   2 +-
> > >   cmds/commands.h                  |   2 +-
> > >   cmds/inspect-dump-file-extents.c | 130 +++++++++++++++++++++++++++++++
> > >   cmds/inspect.c                   |   1 +
> > >   4 files changed, 133 insertions(+), 2 deletions(-)
> > >   create mode 100644 cmds/inspect-dump-file-extents.c
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index a1cc457b..911e16de 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -156,7 +156,7 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o
> > > cmds/device.o cmds/scrub.o \
> > >              cmds/restore.o cmds/rescue.o cmds/rescue-chunk-recover.o \
> > >              cmds/rescue-super-recover.o \
> > >              cmds/property.o cmds/filesystem-usage.o
> > > cmds/inspect-dump-tree.o \
> > > -           cmds/inspect-dump-super.o cmds/inspect-tree-stats.o
> > > cmds/filesystem-du.o \
> > > +           cmds/inspect-dump-super.o cmds/inspect-tree-stats.o
> > > cmds/inspect-dump-file-extents.o cmds/filesystem-du.o \
> > >              mkfs/common.o check/mode-common.o check/mode-lowmem.o
> > >   libbtrfs_objects = common/send-stream.o common/send-utils.o
> > > kernel-lib/rbtree.o btrfs-list.o \
> > >              kernel-lib/radix-tree.o common/extent-cache.o
> > > kernel-shared/extent_io.o \
> > > diff --git a/cmds/commands.h b/cmds/commands.h
> > > index 8fa85d6c..55de248e 100644
> > > --- a/cmds/commands.h
> > > +++ b/cmds/commands.h
> > > @@ -154,5 +154,5 @@ DECLARE_COMMAND(select_super);
> > >   DECLARE_COMMAND(dump_super);
> > >   DECLARE_COMMAND(debug_tree);
> > >   DECLARE_COMMAND(rescue);
> > > -
> > > +DECLARE_COMMAND(inspect_dump_file_extents);
> > >   #endif
> > > diff --git a/cmds/inspect-dump-file-extents.c
> > > b/cmds/inspect-dump-file-extents.c
> > > new file mode 100644
> > > index 00000000..99aec7d7
> > > --- /dev/null
> > > +++ b/cmds/inspect-dump-file-extents.c
> > > @@ -0,0 +1,130 @@
> > > +/*
> > > + * This program is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU General Public
> > > + * License v2 as published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > + * General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public
> > > + * License along with this program; if not, write to the
> > > + * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
> > > + * Boston, MA 021110-1307, USA.
> > > + */
> > > +
> > > +#include <unistd.h>
> > > +#include <stdio.h>
> > > +#include <fcntl.h>
> > > +
> > > +#include <sys/ioctl.h>
> > > +
> > > +#include "common/utils.h"
> > > +#include "cmds/commands.h"
> > > +
> > > +static const char * const cmd_inspect_dump_file_extents_usage[] = {
> > > +    "btrfs inspect-internal dump-extent path",
> > > +    "Dump file extent in a textual form",
> > > +    NULL
> > > +};
> > > +
> > > +static int cmd_inspect_dump_file_extents(const struct cmd_struct *cmd,
> > > +                                         int argc, char **argv)
> > > +{
> > > +    int fd;
> > > +    struct stat statbuf;
> > > +    struct btrfs_ioctl_ino_lookup_args lookup;
> > > +    struct btrfs_ioctl_search_args args;
> > > +    struct btrfs_ioctl_search_key *sk = &args.key;
> > > +    struct btrfs_file_extent_item *extent_item;
> > > +    struct btrfs_ioctl_search_header *header;
> > > +    u64 pos;
> > > +    u64 buf_off;
> > > +    u64 len;
> > > +    u64 begin;
> > > +    u64 physical;
> > > +    u64 offset;
> > > +    u64 physical_len;
> > > +    int ret;
> > > +    int i;
> > > +
> > > +    fd = open(argv[optind], O_RDONLY);
> > > +    if (fd < 0) {
> > > +        error("cannot open %s: %m", argv[optind]);
> > > +        ret = 1;
> > > +        goto out;
> > > +    }
> > > +
> > > +    if (fstat(fd, &statbuf) < 0) {
> > > +        error("failed to fstat %s: %m", argv[optind]);
> > > +        ret = 1;
> > > +        goto out;
> > > +    }
> > > +
> > > +    lookup.treeid = 0;
> > > +    lookup.objectid = BTRFS_FIRST_FREE_OBJECTID;
> > > +
> > > +    if (ioctl(fd, BTRFS_IOC_INO_LOOKUP, &lookup) < 0) {
> > > +        error("failed to lookup inode %s: %m", argv[optind]);
> > > +        ret = 1;
> > > +        goto out;
> > > +    }
> > > +
> > > +    pos = 0;
> > > +
> > > +    sk->tree_id = lookup.treeid;
> > > +    sk->min_objectid = statbuf.st_ino;
> > > +    sk->max_objectid = statbuf.st_ino;
> > > +
> > > +    sk->max_offset = UINT64_MAX;
> > > +    sk->min_transid = 0;
> > > +    sk->max_transid = UINT64_MAX;
> > > +    sk->min_type = sk->max_type = BTRFS_EXTENT_DATA_KEY;
> > > +    sk->nr_items = 4096;
> > > +
> > > +    while (statbuf.st_size > pos) {
> > > +        sk->min_offset = pos;
> > > +        if (ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args)) {
> > > +            error("failed to search tree ioctl %s: %m", argv[optind]);
> > > +            ret = 1;
> > > +            goto out;
> > > +        }
> > > +
> > > +        buf_off = 0;
> > > +        for(i=0; i<sk->nr_items; ++i) {
> > > +            header = (struct btrfs_ioctl_search_header *)(args.buf +
> > > buf_off);
> > > +
> > > +            if (btrfs_search_header_type(header) ==
> > > BTRFS_EXTENT_DATA_KEY) {
> > > +                extent_item = (struct btrfs_file_extent_item
> > > *)(header + 1);
> > > +                begin = btrfs_search_header_offset(header);
> > > +
> > > +                printf("begin = 0x%llx, ", begin);
> > > +                switch (extent_item->type) {
> > > +                case BTRFS_FILE_EXTENT_INLINE:
> > > +                    len = le64_to_cpu(extent_item->ram_bytes);
> > > +                    printf("end = 0x%llx\n", begin + len);
> > > +                    break;
> > > +                case BTRFS_FILE_EXTENT_REG:
> 
> 
> OK, so you're doing on-disk file extent search.
> 
> This is fine, but under most case fiemap ioctl would be enough, not to
> mention fiemap can also handle pages not yet written to disk (by writing
> them back though).

It would be better that this patch also can do it.

> 
> Although this manual search provides much better info for compressed
> extent, but unfortunately here you didn't do any extra handling for them.

It also good to show compression information.

> 
> Thus so far this is no better than fiemap to get the logical bytenr.
> 
> And I can't be more wrong, by thinking you're also doing the chunk
> lookup, which you didn't.
Sorry, I'm confused. Is it needed to do the chunk lookup?
> 
> So I don't see any benefit compared to regular fiemap.
> 
> In fact, fiemap can provide more info than your initial draft.
> Fiemap can already show if the map is compressed (but can't show the
> compressed size yet).
> 
> Your draft can be improved to:
> 
> - Show the compression algorithm
>   Which fiemap can't
> 
> - Show the compressed size
>   Which fiemap can't either.
> 
I understand that the point is that this command is nothing better than
fiemap ioctl now. but It can be improved by showing more information
that fiemap doesn't provide like compression algorithm.
> 
> > > +                case BTRFS_FILE_EXTENT_PREALLOC:
> > > +                    len = le64_to_cpu(extent_item->num_bytes);
> > > +                    physical = le64_to_cpu(extent_item->disk_bytenr);
> > > +                    physical_len =
> > > le64_to_cpu(extent_item->disk_num_bytes);
> > > +                    offset = le64_to_cpu(extent_item->offset);
> > > +                    printf("end = 0x%llx, physical = 0x%llx,
> > > physical_len = 0x%llx\n",
> 
> Currently we only use %llx for flags, for bytenr we always %llu.
> You could refer to print-tree.c to see more examples.
Thanks! I'll fix this.
> 
> And I don't really like the word "physical" here.
> 
> In fact the bytenr are all btrfs logical bytenr, which makes no direct
> sense for its physical location on disk.
Yeah, the word "physical" is not good. would It be better to write as
"disk_bytenr"?

Thanks,
Sidong
> 
> For real physical bytenr, we need something like (device id, physical
> offset), and needs to do a chunk map lookup.
> 
> Thanks,
> Qu
> 
> > > +                           begin + len, physical, physical_len);
> > > +                    break;
> > > +                }
> 
> > > +
> > > +            }
> > > +            buf_off += sizeof(*header) +
> > > btrfs_search_header_len(header);
> > > +            pos += len;
> > > +        }
> > > +
> > > +    }
> > > +    ret = 0;
> > > +out:
> > > +    close(fd);
> > > +    return ret;
> > > +}
> > > +DEFINE_SIMPLE_COMMAND(inspect_dump_file_extents, "dump-file-extents");
> > > diff --git a/cmds/inspect.c b/cmds/inspect.c
> > > index 2ef5f4b6..dfb0e27b 100644
> > > --- a/cmds/inspect.c
> > > +++ b/cmds/inspect.c
> > > @@ -696,6 +696,7 @@ static const struct cmd_group inspect_cmd_group = {
> > >           &cmd_struct_inspect_dump_tree,
> > >           &cmd_struct_inspect_dump_super,
> > >           &cmd_struct_inspect_tree_stats,
> > > +        &cmd_struct_inspect_dump_file_extents,
> > >           NULL
> > >       }
> > >   };
> > > 
