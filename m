Return-Path: <linux-btrfs+bounces-12135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FF0A591AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 11:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A8B3AE0E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 10:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F645229B29;
	Mon, 10 Mar 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH+4GpSW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B14229B11
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603631; cv=none; b=GdOhCdECo0U1UpfO2sordXcozElnXHekGWyLiv8DfCQf7/yE6FRuvCFUkSEvbYvtytBPWlZBjgqDe1A+YzkF08cOGkLpN0zdUjRh1No604xJ0BDRVxszpAWIpCJ/V8Lyjvsf04G430QNScSZwImom6QDE2rIOqUNjo9UwtsHWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603631; c=relaxed/simple;
	bh=Sc9/v3JuthVpaujL0gcxOlKafMze0NJxxDCqEp489d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ep9IyCE7nom8dmNUiefW7Th7qdjhemVwciymEwrTU+eGlcrB0prjbU7v7MM1R9ICzQGODhBVgCr6zYcFguNEeJVdUGuafgrKgCyBW5TIjCIo6aX3Z6FfhsvppvHkFvlM4KPt+kwH6fOp261bVGrCdWzRwc8C7tuVODHE0YpZ3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH+4GpSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517C7C4CEF0
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741603630;
	bh=Sc9/v3JuthVpaujL0gcxOlKafMze0NJxxDCqEp489d8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rH+4GpSWm70MDdz90J7WW3e4ZM9LjCnSU4zwgbT8SOFlddqVCH/3RCSdyos4/kzyP
	 dFMWx1NJ4K7McNB9oaj90ertP74A5yQggnQhxCQO1xcO+ozMNrEAX29kJp3jGOK5ls
	 NBsDiSZr9WR78oOYqfZ78WUGzKDBB2uLHo6aYzW0N9XZLsc3KhKJpz0g49pEdeHpmW
	 /hX+tKQdtN4vR/t4WAYFEhht6Yox8doDzXITAl6HDpPT4JcTq1oHCRwuWh9LKt2sHv
	 xr9N5cjFJCMWDe8FzlcYrLFZa+JJrb8athYeufmyntax2/ephCyCUJTwrnRhWRsVh6
	 2p4kAzh2UgnfA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abbd96bef64so654879566b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 03:47:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YyxLyTqLnwmurKR14JAegRS9j4S3juOyiX/oLTdRyBBp8upYJk0
	qJibvRwPBpurlSzSI0G9WC1GH+uvAqf6lKrvtTORwQj0bBGJcYQwKd3CwlsgN6KUqb/oEor0Ven
	XOCyhK0MPT4J1QlU6gkW85WC66P4=
X-Google-Smtp-Source: AGHT+IE0Qz01VzgipkgxgkfoRbX692A0lttf+JeI1m/AaZEuHJKWtSe6j975Vn4wdPQ5YcuAZTwi8kxmz+yBkADcLL0=
X-Received: by 2002:a17:907:1ca3:b0:ab7:b30:42ed with SMTP id
 a640c23a62f3a-ac2521295eamr1615213666b.0.1741603628863; Mon, 10 Mar 2025
 03:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f6d2a09fb43742fb5be38f820908510e298f8d40.1741354479.git.fdmanana@suse.com>
 <202503090344.SeJrOfHD-lkp@intel.com>
In-Reply-To: <202503090344.SeJrOfHD-lkp@intel.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 10 Mar 2025 10:46:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H649w5+hRzX_pRB=6kMVQFSfLL7=2dt16taiVzOUYOgzQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpH99uf8nj-3JsGIluLIezRqAJA4enqoTTq_8A9S1s8aybiFQFmOMw-9rg
Message-ID: <CAL3q7H649w5+hRzX_pRB=6kMVQFSfLL7=2dt16taiVzOUYOgzQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] btrfs: make btrfs_iget() return a btrfs inode instead
To: kernel test robot <lkp@intel.com>
Cc: linux-btrfs@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 5:49=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on next-20250307]
> [cannot apply to linus/master v6.14-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/fdmanana-kernel-or=
g/btrfs-return-a-btrfs_inode-from-btrfs_iget_logging/20250307-214724
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git f=
or-next
> patch link:    https://lore.kernel.org/r/f6d2a09fb43742fb5be38f820908510e=
298f8d40.1741354479.git.fdmanana%40suse.com
> patch subject: [PATCH 4/8] btrfs: make btrfs_iget() return a btrfs inode =
instead
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/202503=
09/202503090344.SeJrOfHD-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd70=
8029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250309/202503090344.SeJrOfHD-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503090344.SeJrOfHD-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from fs/btrfs/send.c:11:
>    In file included from include/linux/xattr.h:18:
>    In file included from include/linux/mm.h:2224:
>    include/linux/vmstat.h:504:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      505 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:511:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      512 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:524:43: warning: arithmetic between different e=
numeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-=
enum-conversion]
>      524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      525 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
> >> fs/btrfs/send.c:5535:8: error: incompatible pointer types assigning to=
 'struct inode *' from 'struct btrfs_inode *' [-Werror,-Wincompatible-point=
er-types]
>     5535 |         inode =3D btrfs_iget(sctx->cur_ino, root);
>          |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    3 warnings and 1 error generated.

You're testing against a branch that doesn't contain this dependency:

https://lore.kernel.org/linux-btrfs/89867e61f94b9a9f3711f66c141e4d483a9cc6b=
d.1741283556.git.fdmanana@suse.com/

It's in the for-next branch of the github repo:

https://github.com/btrfs/linux/commits/for-next/

but not yet in  any kernel.org repo.

Thanks.

>
>
> vim +5535 fs/btrfs/send.c
>
> 16e7549f045d33b Josef Bacik   2013-10-22  5519
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5520  static int send_encoded_i=
nline_extent(struct send_ctx *sctx,
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5521                           =
             struct btrfs_path *path, u64 offset,
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5522                           =
             u64 len)
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5523  {
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5524          struct btrfs_root=
 *root =3D sctx->send_root;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5525          struct btrfs_fs_i=
nfo *fs_info =3D root->fs_info;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5526          struct inode *ino=
de;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5527          struct fs_path *f=
spath;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5528          struct extent_buf=
fer *leaf =3D path->nodes[0];
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5529          struct btrfs_key =
key;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5530          struct btrfs_file=
_extent_item *ei;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5531          u64 ram_bytes;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5532          size_t inline_siz=
e;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5533          int ret;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5534
> d13240dd0a2d13b Filipe Manana 2024-06-13 @5535          inode =3D btrfs_i=
get(sctx->cur_ino, root);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5536          if (IS_ERR(inode)=
)
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5537                  return PT=
R_ERR(inode);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5538
> 6054b503e2eafac Filipe Manana 2025-02-18  5539          fspath =3D get_cu=
r_inode_path(sctx);
> 6054b503e2eafac Filipe Manana 2025-02-18  5540          if (IS_ERR(fspath=
)) {
> 6054b503e2eafac Filipe Manana 2025-02-18  5541                  ret =3D P=
TR_ERR(fspath);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5542                  goto out;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5543          }
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5544
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5545          ret =3D begin_cmd=
(sctx, BTRFS_SEND_C_ENCODED_WRITE);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5546          if (ret < 0)
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5547                  goto out;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5548
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5549          btrfs_item_key_to=
_cpu(leaf, &key, path->slots[0]);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5550          ei =3D btrfs_item=
_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5551          ram_bytes =3D btr=
fs_file_extent_ram_bytes(leaf, ei);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5552          inline_size =3D b=
trfs_file_extent_inline_item_len(leaf, path->slots[0]);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5553
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5554          TLV_PUT_PATH(sctx=
, BTRFS_SEND_A_PATH, fspath);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5555          TLV_PUT_U64(sctx,=
 BTRFS_SEND_A_FILE_OFFSET, offset);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5556          TLV_PUT_U64(sctx,=
 BTRFS_SEND_A_UNENCODED_FILE_LEN,
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5557                      min(k=
ey.offset + ram_bytes - offset, len));
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5558          TLV_PUT_U64(sctx,=
 BTRFS_SEND_A_UNENCODED_LEN, ram_bytes);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5559          TLV_PUT_U64(sctx,=
 BTRFS_SEND_A_UNENCODED_OFFSET, offset - key.offset);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5560          ret =3D btrfs_enc=
oded_io_compression_from_extent(fs_info,
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5561                           =
       btrfs_file_extent_compression(leaf, ei));
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5562          if (ret < 0)
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5563                  goto out;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5564          TLV_PUT_U32(sctx,=
 BTRFS_SEND_A_COMPRESSION, ret);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5565
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5566          ret =3D put_data_=
header(sctx, inline_size);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5567          if (ret < 0)
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5568                  goto out;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5569          read_extent_buffe=
r(leaf, sctx->send_buf + sctx->send_size,
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5570                           =
  btrfs_file_extent_inline_start(ei), inline_size);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5571          sctx->send_size +=
=3D inline_size;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5572
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5573          ret =3D send_cmd(=
sctx);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5574
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5575  tlv_put_failure:
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5576  out:
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5577          iput(inode);
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5578          return ret;
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5579  }
> 3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5580
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

