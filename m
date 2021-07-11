Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E799D3C39DA
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jul 2021 03:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhGKBge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jul 2021 21:36:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:44183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhGKBge (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jul 2021 21:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625967226;
        bh=b+0htkffIu4W9CxDOjRvKYQdhFim2xUD9trJW3nWykM=;
        h=X-UI-Sender-Class:From:To:References:Subject:Date:In-Reply-To;
        b=Y8Qc+Gd8KcxVA4sO0jMyAQOVdm79lkrRpCvWhGrBeMU6a4knvyeWZQv44Ctwl0FXW
         g1N/33lvkmQ1DxdergLU/sfz4YWVUdNSGhuXeBvmJv+PZU9cby/+CGLF2fArJ1PiwC
         Ska5SklvZD+OG6lvWCSWVf1Rrl7eL3FUL1Ajl0Lg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHG8g-1ly2kk048m-00DJ6r; Sun, 11
 Jul 2021 03:33:46 +0200
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210710144107.65224-1-realwakka@gmail.com>
 <8f248d54-ec4d-9a53-840f-6d162de14267@gmx.com>
Subject: Re: [RFC] btrfs-progs: cmds: Add subcommand that dumps file extents
Message-ID: <1d679d44-c608-8d51-32d9-84c15d636e33@gmx.com>
Date:   Sun, 11 Jul 2021 09:33:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8f248d54-ec4d-9a53-840f-6d162de14267@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tPruicabZ6BgvlqDM92/EJV/19Chx8JOQ1AGRHRmJBbisQhg00d
 SCCkYnbbNaDcw+RNoqyuhpOvYZ1qv8mJvhUgoMNB1/4P4aDiP4gpdMcXDeTuGaAHAQ0vqT4
 OkYeeFa0qGtjGjt9pst4GdP0O6GC3Hl0PWFmN5n0ZmXndA+HCQONpkqmGYjavC6TTD4Y76D
 Oi8lhf49mpKWhhF5zuSvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rvythSec2hc=:Ysa8g/Yd9Gn6CuQsmn0xfZ
 a5un7mH8gNZsC2NAKdtqcG/Y24rq5lTo2ooigbqWgfKCiFtU7bo4NWqc2pUkWBEBKXJI+n1//
 n+I3lPvtoSXAqZqkz7AHsmrHl/YqBE0yOF7ys7kqL5uC/9mpz+a4GYYrseoKUgExBJK3oaDob
 5j68QwMzPotNXUDxJAoahjszW07YkAg3C2Qbci9q5H2u6RveQfvFQYuDtV/Rhqgs9zERxpCfT
 ZyuZx99Ip5XziegY7G/RTGo2lBKnj5+UQGy7AyRqthwUj2hMpiIAOvG1ci7H5YJb5J7yJMAXz
 tTs3HhiSme9nYWA7OQy6b2eOpnz/wJX9GpYOPzzhpR17Q4PJh9OB0dj45x4C8K4H/d/pbj5k6
 d1gl/4IBKzfXxlRzHDVbirQp3oNsr5mfbWmMv5TnpU9n0/e2IX3f17Pz8d8kVkEBB5GpPyq8M
 2vf0fnx6V7oFEjHS8bQ/EtasSpfFKz3OlnNROsIjK4dsTuHWWike+j6lRVlgv/XiJPZqEtrjq
 UV3R67+sG/piDx5hqQtDHt7Xl5cWT9EDmLGHSbKvS4zeuhW8n/hBPSiUS4p537hkI9TzUumw/
 bdyzOKlBMZekqrwW0X+rku8Ggpv2KFrwMjpRoFtlXQ30HP/3LXHOjKB7okdkbeanNTZ3G30gI
 C/viXQmdfJUjn0OddNTnxyB9VsawyqyL11jbIu7VozB3tincFMycTJonSPZ+s2zSEsE3zSTJ3
 5Yj3Lgj7pRNbVbEuJ/MUWu+TrsZTd8Ep6aLvYajb6R+DKu7RiOT507RRHnHHc/x41VayIi1cH
 uZm/M+LtFuKZxQTfS7vnSNzQUGmPkLpfzct0ZnvoMSc+PpULBWWV9U8yyShAPfr+DWrXlFrXT
 Vxx31iMdOGkH+J6q6dqiqADxZh4n53rqYzDAPqFaEVliVhw4PRy+f9zkgOIRKGCNKfBFmRihq
 fUZQEhb1rD2EDpCfODYVCVY0MiIaS+XPJFP4Rt31T7vLvmCAakUDTS3UGhohAsIPuk0qudzaU
 dw4crySgr5chjU2qxvqnJKfZLHNXNnz5fOHcFHjuk61014blQqCDHlwjjuB9043cef1W63prV
 huyEgpwQtF1IHbesSdoAHZp5b9+5CejccKRSqf4AhrqvnSo/ZCpqraQ4A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/11 =E4=B8=8A=E5=8D=886:38, Qu Wenruo wrote:
>
>
> On 2021/7/10 =E4=B8=8B=E5=8D=8810:41, Sidong Yang wrote:
>> This patch adds an subcommand in inspect-internal. It dumps file
>> extents of
>> the file that user provided. It helps to show the internal information
>> about file extents comprise the file.
>
> So this is going to be the combined command of filemap + btrfs-map-logic=
al.
>
> But how do you handle dirty pages which hasn't yet been flushed to disk?
>
> Thanks,
> Qu
>>
>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>> ---
>> Hi, I'm writing an patch that adds an subcommand that dumps file
>> extents of
>> the file. I don't have much idea about btrfs but I referenced btrfs
>> wiki, dev-docs, and also Zygo's bee. It's just like draft.
>>
>> I have some questions below.
>>
>> The command works like below,
>> # ./btrfs inspect-internal dump-file-extents /mnt/bb/TAGS
>> begin =3D 0x0, end =3D 0x20000, physical =3D 0x4fdf5000, physical_len =
=3D 0xc000
>> begin =3D 0x20000, end =3D 0x40000, physical =3D 0x4fe01000, physical_l=
en =3D
>> 0xc000
>> begin =3D 0x40000, end =3D 0x47000, physical =3D 0x4fe0d000, physical_l=
en =3D
>> 0x3000
>>
>> What format would be better?
>> Is it better to just use the variable name as it is? like disk_bytenr
>> not like physical_len?
>>
>> And what option do we need? like showing compression or file extent typ=
e?
>>
>> Any comments will be welcome. Thanks!
>> ---
>> =C2=A0 Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 cmds/commands.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 cmds/inspect-dump-file-extents.c | 130 +++++++++++++++++++++++++=
++++++
>> =C2=A0 cmds/inspect.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 1 +
>> =C2=A0 4 files changed, 133 insertions(+), 2 deletions(-)
>> =C2=A0 create mode 100644 cmds/inspect-dump-file-extents.c
>>
>> diff --git a/Makefile b/Makefile
>> index a1cc457b..911e16de 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -156,7 +156,7 @@ cmds_objects =3D cmds/subvolume.o cmds/filesystem.o
>> cmds/device.o cmds/scrub.o \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cmds/restore.o cmds/rescue.o cmds/rescue-chunk-recover.o \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cmds/rescue-super-recover.o \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cmds/property.o cmds/filesystem-usage.o
>> cmds/inspect-dump-tree.o \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmds/insp=
ect-dump-super.o cmds/inspect-tree-stats.o
>> cmds/filesystem-du.o \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmds/insp=
ect-dump-super.o cmds/inspect-tree-stats.o
>> cmds/inspect-dump-file-extents.o cmds/filesystem-du.o \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mkfs/common.o check/mode-common.o check/mode-lowmem.o
>> =C2=A0 libbtrfs_objects =3D common/send-stream.o common/send-utils.o
>> kernel-lib/rbtree.o btrfs-list.o \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 kernel-lib/radix-tree.o common/extent-cache.o
>> kernel-shared/extent_io.o \
>> diff --git a/cmds/commands.h b/cmds/commands.h
>> index 8fa85d6c..55de248e 100644
>> --- a/cmds/commands.h
>> +++ b/cmds/commands.h
>> @@ -154,5 +154,5 @@ DECLARE_COMMAND(select_super);
>> =C2=A0 DECLARE_COMMAND(dump_super);
>> =C2=A0 DECLARE_COMMAND(debug_tree);
>> =C2=A0 DECLARE_COMMAND(rescue);
>> -
>> +DECLARE_COMMAND(inspect_dump_file_extents);
>> =C2=A0 #endif
>> diff --git a/cmds/inspect-dump-file-extents.c
>> b/cmds/inspect-dump-file-extents.c
>> new file mode 100644
>> index 00000000..99aec7d7
>> --- /dev/null
>> +++ b/cmds/inspect-dump-file-extents.c
>> @@ -0,0 +1,130 @@
>> +/*
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public
>> + * License v2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public
>> + * License along with this program; if not, write to the
>> + * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
>> + * Boston, MA 021110-1307, USA.
>> + */
>> +
>> +#include <unistd.h>
>> +#include <stdio.h>
>> +#include <fcntl.h>
>> +
>> +#include <sys/ioctl.h>
>> +
>> +#include "common/utils.h"
>> +#include "cmds/commands.h"
>> +
>> +static const char * const cmd_inspect_dump_file_extents_usage[] =3D {
>> +=C2=A0=C2=A0=C2=A0 "btrfs inspect-internal dump-extent path",
>> +=C2=A0=C2=A0=C2=A0 "Dump file extent in a textual form",
>> +=C2=A0=C2=A0=C2=A0 NULL
>> +};
>> +
>> +static int cmd_inspect_dump_file_extents(const struct cmd_struct *cmd,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 int argc, char **argv)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int fd;
>> +=C2=A0=C2=A0=C2=A0 struct stat statbuf;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_ino_lookup_args lookup;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_search_args args;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_search_key *sk =3D &args.key;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_file_extent_item *extent_item;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_search_header *header;
>> +=C2=A0=C2=A0=C2=A0 u64 pos;
>> +=C2=A0=C2=A0=C2=A0 u64 buf_off;
>> +=C2=A0=C2=A0=C2=A0 u64 len;
>> +=C2=A0=C2=A0=C2=A0 u64 begin;
>> +=C2=A0=C2=A0=C2=A0 u64 physical;
>> +=C2=A0=C2=A0=C2=A0 u64 offset;
>> +=C2=A0=C2=A0=C2=A0 u64 physical_len;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 fd =3D open(argv[optind], O_RDONLY);
>> +=C2=A0=C2=A0=C2=A0 if (fd < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("cannot open %s: %m",=
 argv[optind]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (fstat(fd, &statbuf) < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to fstat %s: =
%m", argv[optind]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 lookup.treeid =3D 0;
>> +=C2=A0=C2=A0=C2=A0 lookup.objectid =3D BTRFS_FIRST_FREE_OBJECTID;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ioctl(fd, BTRFS_IOC_INO_LOOKUP, &lookup) < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to lookup ino=
de %s: %m", argv[optind]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 pos =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 sk->tree_id =3D lookup.treeid;
>> +=C2=A0=C2=A0=C2=A0 sk->min_objectid =3D statbuf.st_ino;
>> +=C2=A0=C2=A0=C2=A0 sk->max_objectid =3D statbuf.st_ino;
>> +
>> +=C2=A0=C2=A0=C2=A0 sk->max_offset =3D UINT64_MAX;
>> +=C2=A0=C2=A0=C2=A0 sk->min_transid =3D 0;
>> +=C2=A0=C2=A0=C2=A0 sk->max_transid =3D UINT64_MAX;
>> +=C2=A0=C2=A0=C2=A0 sk->min_type =3D sk->max_type =3D BTRFS_EXTENT_DATA=
_KEY;
>> +=C2=A0=C2=A0=C2=A0 sk->nr_items =3D 4096;
>> +
>> +=C2=A0=C2=A0=C2=A0 while (statbuf.st_size > pos) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk->min_offset =3D pos;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ioctl(fd, BTRFS_IOC_TRE=
E_SEARCH, &args)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or("failed to search tree ioctl %s: %m", argv[optind]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf_off =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for(i=3D0; i<sk->nr_items; =
++i) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hea=
der =3D (struct btrfs_ioctl_search_header *)(args.buf +
>> buf_off);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(btrfs_search_header_type(header) =3D=3D
>> BTRFS_EXTENT_DATA_KEY) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 extent_item =3D (struct btrfs_file_extent_item
>> *)(header + 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 begin =3D btrfs_search_header_offset(header);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 printf("begin =3D 0x%llx, ", begin);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 switch (extent_item->type) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 case BTRFS_FILE_EXTENT_INLINE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D le64_to_cpu(extent_i=
tem->ram_bytes);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("end =3D 0x%llx\n", b=
egin + len);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 case BTRFS_FILE_EXTENT_REG:


OK, so you're doing on-disk file extent search.

This is fine, but under most case fiemap ioctl would be enough, not to
mention fiemap can also handle pages not yet written to disk (by writing
them back though).

Although this manual search provides much better info for compressed
extent, but unfortunately here you didn't do any extra handling for them.

Thus so far this is no better than fiemap to get the logical bytenr.

And I can't be more wrong, by thinking you're also doing the chunk
lookup, which you didn't.

So I don't see any benefit compared to regular fiemap.

In fact, fiemap can provide more info than your initial draft.
Fiemap can already show if the map is compressed (but can't show the
compressed size yet).

Your draft can be improved to:

- Show the compression algorithm
   Which fiemap can't

- Show the compressed size
   Which fiemap can't either.


>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 case BTRFS_FILE_EXTENT_PREALLOC:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D le64_to_cpu(extent_i=
tem->num_bytes);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 physical =3D le64_to_cpu(ext=
ent_item->disk_bytenr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 physical_len =3D
>> le64_to_cpu(extent_item->disk_num_bytes);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D le64_to_cpu(exten=
t_item->offset);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("end =3D 0x%llx, phys=
ical =3D 0x%llx,
>> physical_len =3D 0x%llx\n",

Currently we only use %llx for flags, for bytenr we always %llu.
You could refer to print-tree.c to see more examples.

And I don't really like the word "physical" here.

In fact the bytenr are all btrfs logical bytenr, which makes no direct
sense for its physical location on disk.

For real physical bytenr, we need something like (device id, physical
offset), and needs to do a chunk map lookup.

Thanks,
Qu

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 begin + len, physical, physical_len);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }

>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf=
_off +=3D sizeof(*header) +
>> btrfs_search_header_len(header);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pos=
 +=3D len;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> +out:
>> +=C2=A0=C2=A0=C2=A0 close(fd);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +DEFINE_SIMPLE_COMMAND(inspect_dump_file_extents, "dump-file-extents");
>> diff --git a/cmds/inspect.c b/cmds/inspect.c
>> index 2ef5f4b6..dfb0e27b 100644
>> --- a/cmds/inspect.c
>> +++ b/cmds/inspect.c
>> @@ -696,6 +696,7 @@ static const struct cmd_group inspect_cmd_group =3D=
 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cmd_struct_insp=
ect_dump_tree,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cmd_struct_insp=
ect_dump_super,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cmd_struct_insp=
ect_tree_stats,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cmd_struct_inspect_dump_fi=
le_extents,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 };
>>
