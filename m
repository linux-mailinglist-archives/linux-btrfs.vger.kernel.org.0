Return-Path: <linux-btrfs+bounces-17237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B8CBA6FAA
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 13:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6317A17BD5D
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BB52DAFAE;
	Sun, 28 Sep 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVRsVYVU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CA92D594A
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Sep 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759058034; cv=none; b=uJevQfTFuuAhY2D6I2aFM1NJ7ee59wrnvDPLV9lYOJzipPiy1BIX9mjV6Xl8j00KwXs1Cs/v3OvErHlmxDW9hYEBGb2IddsdCCQmpI9n6bawhdXgIW5h1hnvtq685muNk4JOsr44CDgUWo3/VpHMGsjf7FJlU31/y64kDJTaFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759058034; c=relaxed/simple;
	bh=RBMKpJ7TzUpGR7QlqVgDsRDXp2raGKvuq2F177MgEzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMPa9L0zbcgFpPEAHeSRgZsVuTwGuMk5JqB3qE0oKqa8mpGs2XFOK6OnQuO4P9bVj1GLb3L12hFQ1Z6M4dPU233bjmrxpofAw1HkU1qGeVWz7pSDFkwzGkk1+Fhe2TgEwI4VvAGYaqqJeG9BFTrel3W20R3s+MrZERCfR3LMxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVRsVYVU; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7ae21804971so802291a34.0
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Sep 2025 04:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759058031; x=1759662831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgRS423VXsLSVR2zRQ5Z4S6murZuVLHxgTPnqkFCRzY=;
        b=CVRsVYVUw4tx4GXFs+T4qdmTJyHBT+pa8Yn4r3xtCf76CIorWMytHJEELrcczknYN8
         CNQycxnarIqTgG7Bx1A6nhQZmx2vCJtp7MBZ2yXFYGXiQDFW7dDIvruij4KG4JyofVzU
         3bbSKLsv+/E7+2VUNEAtxqdx7tNY5XUdX15+yMAlRAC2Rkjtl3/kTOuHoG4nSrHx75+d
         iH0pfMcIdy+ofga2/wyJwsR6ZzYld+Pz39upvoZDUp6hrU4GaZEDyhSYtaWC2L40/5QM
         7bZCw/ejEk1NGOIyrWqghbnErlgp4qGnbjaSDa94dT0cO/XKCiGrEY2s2D/UsgRE9PHX
         yrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759058031; x=1759662831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgRS423VXsLSVR2zRQ5Z4S6murZuVLHxgTPnqkFCRzY=;
        b=qBgBGG16E9IClBu4a+mVqXdHCDfUGZvWuYla2Wu1J4oBGLghfJaKwKtLUUX3NUV6TU
         ye6hrRy7L00vBFe06SFCnBzWhtMaZVrULfl/Q9b0S3L4L6MNYcNJ0HLf36YjBfV+D5Df
         jr9Vs7soN1ODX0Pf82IKVonAGzsftUCQxlvsUNtmlgB/yN64SXFjtqVzGASGkbkQN6I/
         UKevOQkXQo9IgB7bOCJu9OhYPtgdwDbInX23rQ++Ki6Heuhm0EH8Q3WUSKzMd3wL3uDV
         TI+z+Ta0zmgWsgN6/JZVuH+b9NifImtGjC//QvAgPpboUkTOhGL7WxPkXdC4Ic4mFHW4
         Wk3A==
X-Gm-Message-State: AOJu0Yx+yvkFGq1PUxGvPmYWwrufeYqf+pLMLGVEi/VouQy0WrHluhRN
	29CIeDcI4ElQ48VjaWFSpRVWbDzlBnq/kf4VeCsRaJKIsF55zxpuZy9h/NgUmvf2zqIzmhALlx9
	JKUxIe2EPAnKmt2uxsLUGh4ga72gNYyhtN7ppMCMogg==
X-Gm-Gg: ASbGncvVqttAD+NnKprdARTUjxmIvmqKqoSn3xEgbsttFSKHo1QKetKPvtUDzjluIbj
	w2GgLssVXZW1YlkErSIl7PLUPMreY7C6aY2OSwzDGVNLnT7LRer0yJWt8cvSHLCj9IvOh05s9K6
	ouTGoF5ZEX0Kl27yV7vKa0/pwklIo2MhOwjs74TxTEpcjtvZ0VLqILNurroQegxH7ZoysgycejT
	YgbdSHUadux/5ph
X-Google-Smtp-Source: AGHT+IHy1J2JxM8WnWGcqY3IWvsyjkKdPAlURh8HAuDqMSBLAOg7okehxP+z3DVcYj3NYM332eUbD1juPYiiMr9xDh4=
X-Received: by 2002:a05:6830:82f9:b0:759:55bd:9597 with SMTP id
 46e09a7af769-7a04c567c90mr8296522a34.26.1759058030935; Sun, 28 Sep 2025
 04:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <635a605be3627ff476d47620f195a74fe5d634a2.1758934058.git.wqu@suse.com>
In-Reply-To: <635a605be3627ff476d47620f195a74fe5d634a2.1758934058.git.wqu@suse.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sun, 28 Sep 2025 16:13:39 +0500
X-Gm-Features: AS18NWAHTO3TBufY0_IhkFGI3st4ED8iRjN2ebg6VzgRBlpM7hGa7nwU1NvHjow
Message-ID: <CABXGCsObwh8TfAAYhoFSrgKsC4EKdi5tryThQgTgWPG8irwf8A@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: remove btrfs_fs_info::leaf_data_size
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 5:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a bug report that legacy code of "btrfs rescue chunk-recover"
> is triggering false alerts from tree-checker, and refuse to work:
>
>   # btrfs rescue chunk-recover /dev/nvme1n1p1
>   Scanning: DONE in dev0
>   corrupt leaf: root=3D1 block=3D13924671995904 slot=3D0, unexpected item=
 end, have 16283 expect 0 <<< Note the "expect 0"
>   leaf 13924671995904 items 11 free space 12709 generation 1589644 owner =
ROOT_TREE
>   leaf 13924671995904 flags 0x1(WRITTEN) backref revision 1
>   [...]
>   Couldn't read tree root
>   open with broken chunk error
>
> [CAUSE]
> The item end checks is from __btrfs_check_leaf() from tree-checker,
> and for the first slot of a leaf, the expected end should be
> BTRFS_LEAF_DATA_SIZE(), which is fetched from fs_info->leaf_data_size.
>
> However for the fs_info opened by chunk recover, it's not going through
> the regular open_ctree(), but open_ctree_with_broken_chunk(), which
> doesn't populate that member and resulting BTRFS_LEAF_DATA_SIZE() to
> return 0.
>
> [FIX]
> There is no need to cache leaf_data_size, as it can be easily calulated
> using nodesize.
>
> And kernel is already doing that, so follow the kernel to remove
> btrfs_fs_info::leaf_data_size, and use a simple inline function to do
> the calculation instead.
>
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CABXGCsOug_bxVZ5CN1EM0sd9U4JAz=
=3DJf5EB2TQe8gs9=3DKZvWEA@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  kernel-shared/ctree.h   | 8 +++++---
>  kernel-shared/disk-io.c | 1 -
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index b08e078b5a16..07334208abdf 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -69,8 +69,6 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
>  #define BTRFS_MIN_BLOCKSIZE    (SZ_4K)
>  #endif
>
> -#define BTRFS_LEAF_DATA_SIZE(fs_info) (fs_info->leaf_data_size)
> -
>  #define BTRFS_SUPER_INFO_OFFSET                        (65536)
>  #define BTRFS_SUPER_INFO_SIZE                  (4096)
>
> @@ -401,7 +399,6 @@ struct btrfs_fs_info {
>         u32 nodesize;
>         u32 sectorsize;
>         u32 stripesize;
> -       u32 leaf_data_size;
>
>         /*
>          * For open_ctree_fs_info() to hold the initial fd until close.
> @@ -426,6 +423,11 @@ struct btrfs_fs_info {
>         struct super_block *sb;
>  };
>
> +static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *fs_in=
fo)
> +{
> +       return __BTRFS_LEAF_DATA_SIZE(fs_info->nodesize);
> +}
> +
>  static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
>  {
>         return fs_info->zoned !=3D 0;
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index e8fbc1f986ee..dff800f55a74 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -1604,7 +1604,6 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp=
, struct open_ctree_args *oca
>         fs_info->stripesize =3D btrfs_super_stripesize(disk_super);
>         fs_info->csum_type =3D btrfs_super_csum_type(disk_super);
>         fs_info->csum_size =3D btrfs_super_csum_size(disk_super);
> -       fs_info->leaf_data_size =3D __BTRFS_LEAF_DATA_SIZE(fs_info->nodes=
ize);
>
>         ret =3D btrfs_check_fs_compatibility(fs_info->super_copy, flags);
>         if (ret)
> --
> 2.50.1
>

Hi Qu,

thanks for working on this. I tried btrfs-progs with your patch
(=E2=80=9Cremove leaf_data_size and compute from nodesize=E2=80=9D), and bt=
rfs rescue
chunk-recover now aborts with a BUG_ON.

# btrfs rescue chunk-recover /dev/nvme1n1p1
Scanning: DONE in dev0
We are going to rebuild the chunk tree on disk, it might destroy the
old metadata on the disk, Are you sure? [y/N]: y
corrupt leaf: root=3D3 block=3D22020096 slot=3D0, invalid root, root 3 must
never be empty
leaf 22020096 items 0 free space 16283 generation 1589645 owner CHUNK_TREE
leaf 22020096 flags 0x0() backref revision 1
fs uuid 95e074d1-833a-4d5e-bc62-66897be15556
chunk uuid deabd921-0650-4625-9707-e363129fb9c1
cmds/rescue-chunk-recover.c:2409: btrfs_recover_chunk_tree: BUG_ON
`ret` triggered, value -1
btrfs(+0x47ac) [0x55b8046287ac]
btrfs(btrfs_recover_chunk_tree+0x2439) [0x55b8046e17c9]
btrfs(+0xb7954) [0x55b8046db954]
btrfs(main+0x9b) [0x55b80462534b]
/lib64/libc.so.6(+0x35b5) [0x7f037c5e05b5]
/lib64/libc.so.6(__libc_start_main+0x88) [0x7f037c5e0668]
btrfs(_start+0x25) [0x55b804626b95]
Aborted                    (core dumped) btrfs rescue chunk-recover
/dev/nvme1n1p1


# gdb btrfs
GNU gdb (Fedora Linux) 16.3-6.fc44
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from btrfs...
Reading symbols from /usr/lib/debug/usr/bin/btrfs-6.16.1-2.fc44.x86_64.debu=
g...
(gdb) r rescue chunk-recover /dev/nvme1n1p1
Starting program: /usr/bin/btrfs rescue chunk-recover /dev/nvme1n1p1

This GDB supports auto-downloading debuginfo from the following URLs:
  <ima:enforcing>
  <https://debuginfod.fedoraproject.org/>
  <ima:ignore>
Enable debuginfod for this session? (y or [n]) y
Debuginfod has been enabled.
To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit=
.
Downloading separate debug info for system-supplied DSO at 0x7ffff7fc3000
Downloading 74.76 K separate debug info for /lib64/libuuid.so.1
Downloading 243.90 K separate debug info for
/root/.cache/debuginfod_client/b491e87a2de54e730ca53cc8b40a7ab0553c4140/deb=
uginfo
Downloading 923.54 K separate debug info for /lib64/libblkid.so.1
Downloading 1.53 M separate debug info for /lib64/libudev.so.1
Downloading 4.58 M separate debug info for
/root/.cache/debuginfod_client/53ec97ce69262294cc4162a31ec135e47fca54b1/deb=
uginfo
Downloading 4.05 M separate debug info for /lib64/libgcrypt.so.20
Downloading 24.23 K separate debug info for
/root/.cache/debuginfod_client/50638c3c126d99b831e230592e4f362ac70ac716/deb=
uginfo
Downloading 522.10 K separate debug info for /lib64/libz.so.1
Downloading 76.79 K separate debug info for
/root/.cache/debuginfod_client/14252b88876df8e502d0576d2933fc3a35eeeb15/deb=
uginfo
Downloading 455.94 K separate debug info for /lib64/liblzo2.so.2
Downloading 5.75 M separate debug info for /lib64/libzstd.so.1
Downloading 6.67 M separate debug info for /lib64/libc.so.6
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
Downloading 103.23 K separate debug info for /lib64/libcap.so.2
Downloading 16.13 K separate debug info for
/root/.cache/debuginfod_client/40d136ecfe35fe4b9539136c7798905d4513cb94/deb=
uginfo
Downloading 649.02 K separate debug info for /lib64/libgcc_s.so.1
Downloading 10.25 M separate debug info for
/root/.cache/debuginfod_client/1f70e857321c645c543ed9dcfaa0268ba6a48c14/deb=
uginfo
Downloading 591.57 K separate debug info for /lib64/libgpg-error.so.0
Downloading separate debug info for
/root/.cache/debuginfod_client/6d8969b5fac072c0bf86a70d1ff7bef5e53e2f5c/deb=
uginfo
[New Thread 0x7ffff7a166c0 (LWP 15224)]
Scanning: 30725970595840 in dev0[Thread 0x7ffff7a166c0 (LWP 15224) exited]
Scanning: DONE in dev0
We are going to rebuild the chunk tree on disk, it might destroy the
old metadata on the disk, Are you sure? [y/N]: y
corrupt leaf: root=3D3 block=3D22020096 slot=3D0, invalid root, root 3 must
never be empty
leaf 22020096 items 0 free space 16283 generation 1589645 owner CHUNK_TREE
leaf 22020096 flags 0x0() backref revision 1
fs uuid 95e074d1-833a-4d5e-bc62-66897be15556
chunk uuid deabd921-0650-4625-9707-e363129fb9c1
cmds/rescue-chunk-recover.c:2409: btrfs_recover_chunk_tree: BUG_ON
`ret` triggered, value -1
/usr/bin/btrfs(+0x47ac) [0x5555555587ac]
/usr/bin/btrfs(btrfs_recover_chunk_tree+0x2439) [0x5555556117c9]
/usr/bin/btrfs(+0xb7954) [0x55555560b954]
/usr/bin/btrfs(main+0x9b) [0x55555555534b]
/lib64/libc.so.6(+0x35b5) [0x7ffff7a825b5]
/lib64/libc.so.6(__libc_start_main+0x88) [0x7ffff7a82668]
/usr/bin/btrfs(_start+0x25) [0x555555556b95]

Thread 1 "btrfs" received signal SIGABRT, Aborted.
Downloading source file
/usr/src/debug/glibc-2.42.9000-5.fc44.x86_64/nptl/pthread_kill.c
__pthread_kill_implementation (threadid=3D<optimized out>,
signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
44       return INTERNAL_SYSCALL_ERROR_P (ret) ?
INTERNAL_SYSCALL_ERRNO (ret) : 0;
(gdb) bt full
#0  __pthread_kill_implementation (threadid=3D<optimized out>,
signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
        tid =3D <optimized out>
        ret =3D 0
        pd =3D <optimized out>
        old_mask =3D {__val =3D {140737488348266}}
        ret =3D <optimized out>
#1  0x00007ffff7af3383 in __pthread_kill_internal (threadid=3D<optimized
out>, signo=3D6) at pthread_kill.c:89
No locals.
#2  0x00007ffff7a9918e in __GI_raise (sig=3Dsig@entry=3D6) at
../sysdeps/posix/raise.c:26
        ret =3D <optimized out>
#3  0x00007ffff7a806d0 in __GI_abort () at abort.c:77
        act =3D {__sigaction_handler =3D {sa_handler =3D 0x7ffff7c34638,
sa_sigaction =3D 0x7ffff7c34638}, sa_mask =3D {__val =3D {2,
140737350157883, 3, 140737488345748, 12, 140737350157887, 2,
3834029161070891568,
              3835204542643123509, 140737488345840,
3833184727661539229, 140737488345856, 13820465504488253184,
140737488347496, 140737488346608, 93824993610128}}, sa_flags =3D
1433035184,
          sa_restorer =3D 0x55555c1e9230}
#4  0x00005555555587c4 in bugon_trace.part.0.lto_priv.0.lto_priv.0
(assertion=3D<optimized out>, filename=3D<optimized out>, func=3D<optimized
out>, line=3D<optimized out>, val=3D<optimized out>)
    at ./include/kerncompat.h:172
No locals.
#5  0x00005555556117c9 in bugon_trace (assertion=3D0x55555566df49 "ret",
filename=3D0x55555566d0f7 "cmds/rescue-chunk-recover.c",
func=3D0x555555681c60 <__func__.7> "btrfs_recover_chunk_tree",
line=3D2409,
    val=3D<optimized out>) at ./include/kerncompat.h:166
No locals.
#6  btrfs_recover_chunk_tree (path=3D<optimized out>, yes=3D<optimized
out>) at cmds/rescue-chunk-recover.c:2409
        ret =3D <optimized out>
        root =3D 0x5555556a6670
        trans =3D 0x55555c1e9230
        rc =3D {verbose =3D 0, yes =3D 0, csum_size =3D 4, csum_type =3D 0,
sectorsize =3D 4096, nodesize =3D 16384, generation =3D 1589644,
chunk_root_generation =3D 1588108, fs_devices =3D 0x5555556a4930, chunk =3D
{root =3D {
              rb_node =3D 0x7ffff0043200}}, bg =3D {tree =3D {root =3D
{rb_node =3D 0x7ffff04ec660}}, pending_extents =3D {state =3D {rb_node =3D
0x0}, fs_info =3D 0x0, inode =3D 0x0, owner =3D 0 '\000', lock =3D {lock =
=3D
0}},
            block_groups =3D {next =3D 0x7fffffffded8, prev =3D
0x7fffffffded8}}, devext =3D {tree =3D {root =3D {rb_node =3D
0x7ffff16a02a0}}, no_chunk_orphans =3D {next =3D 0x7fffffffdef0, prev =3D
0x7fffffffdef0},
            no_device_orphans =3D {next =3D 0x7ffff03d1480, prev =3D
0x7fffdaf41f70}}, eb_cache =3D {root =3D {rb_node =3D 0x7ffff2cf2230}},
good_chunks =3D {next =3D 0x7ffff02e1f50, prev =3D 0x7ffff013b0b0},
bad_chunks =3D {
            next =3D 0x7ffff02afcf0, prev =3D 0x7ffff02b0310},
rebuild_chunks =3D {next =3D 0x7fffffffdf38, prev =3D 0x7fffffffdf38},
unrepaired_chunks =3D {next =3D 0x7fffffffdf48, prev =3D 0x7fffffffdf48},
rc_lock =3D {
            __data =3D {__lock =3D 0, __count =3D 0, __owner =3D 0, __nuser=
s =3D
0, __kind =3D 0, __spins =3D 0, __elision =3D 0, __list =3D {__prev =3D 0x0=
,
__next =3D 0x0}}, __size =3D '\000' <repeats 39 times>, __align =3D 0}}
        __func__ =3D "btrfs_recover_chunk_tree"
#7  0x000055555560b954 in cmd_rescue_chunk_recover (cmd=3D0x555555697100
<cmd_struct_rescue_chunk_recover>, argc=3D<optimized out>,
argv=3D<optimized out>) at cmds/rescue.c:103
        ret =3D 0
        file =3D 0x7fffffffe48e "/dev/nvme1n1p1"
        yes =3D <optimized out>
#8  0x000055555555534b in cmd_execute (cmd=3D0x55555569b180
<cmd_struct_rescue>, argc=3D<optimized out>, argv=3D<optimized out>) at
cmds/commands.h:126
No locals.
#9  main (argc=3D<optimized out>, argv=3D<optimized out>) at
/usr/src/debug/btrfs-progs-6.16.1-2.fc44.x86_64/btrfs.c:469
        cmd =3D 0x55555569b180 <cmd_struct_rescue>
        bname =3D <optimized out>
        ret =3D <optimized out>
(gdb)


--
Best Regards,
Mike Gavrilov.

