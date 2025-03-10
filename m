Return-Path: <linux-btrfs+bounces-12134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20043A59189
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 11:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4546D16AAF1
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 10:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810B8224250;
	Mon, 10 Mar 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGpwXtaS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5A225408
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603563; cv=none; b=M6JjJwP1Nvci4tCChVJKF8yOK9vr6xqmBQ3upaKD34GmYGx5XiYM7B5bk/7W3H8A6fM4musIgUVHSPSs5UinIo3g69lPwTmkiiVWFQAiWuwkRZ0m399uUABLIrF7qBrKWdUe1e4HSJvJkXGH/ZH5kvHhxcxuNYlX/XyzFmn5Vds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603563; c=relaxed/simple;
	bh=nWYvkVwkkApaoKhNnVQmPg2a5kTvAR0XFUoijBV5TBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5yt4ubjhpZ/U05lfKptK1+E0qy+MxTcNBCO+t7oBtX0g4FWWJlvMajyWv+VQBsoFC+g/64Oofq76Mt64EvDcUyX9BzWCjXYoHVAGXx3fYp8B3Rn4CA8UTx8g3Bz4oJengwY2rSzvi+Ub0zVF8inKV0BH6guVTIuSAqDqKYMW6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGpwXtaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC1FC4CEED
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 10:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741603563;
	bh=nWYvkVwkkApaoKhNnVQmPg2a5kTvAR0XFUoijBV5TBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JGpwXtaSTEE9PfjQBV21o8vzSkKu0fGQ3Xxa4dF3UECcVY03awbZBc8rEOiGpMOdB
	 zGAVzAa49vN6qWLriJRwd9XSqmgFbf+zW5TmMlvEd9uLp5me/X+r2P/gng0ny5sHFv
	 VOoIfUhOBdxJsCCgTls2OYRn4LaFoMUEeNGUTS21ZT1yx1zJPKHbHFXzECS36nyWiO
	 jASNZF2US2zufJjB1GDRU1ztDHuJ7rPPYjpkwS46Eu+JNc2HJJ8Tihg0DI8ePbDJgM
	 IqZBCmwmPyvllPChbcBzYL8ZZbSl4b+fBvqdqPiF/jgCyyB1yR5YSAaHkIl8s9sUPI
	 tOMalZqgy6+2A==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso559365866b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 03:46:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YxtkxpM7vkFlY4GZ/VEpJersTKYV5ep4773etiicVSrbNant70i
	ORedttjrwhF6yqs/J9IOsP+vfhH4Gp6w4eig2QsZWOrqNRQs7BukQqi3sHDLjCDCdEHm8/O0/NY
	EbfamKg7t4HiyHEixhuxZwjlDQxI=
X-Google-Smtp-Source: AGHT+IFKMC1Mp25UNKdtdZ9S+vhYs4X9sEvt5rgiYGoaBvK5s6mS9g8nWiR+9pLZl25dTQjm93sZM9k9P5ZoJLpIf5w=
X-Received: by 2002:a17:907:7fa5:b0:ac0:3d5c:4fc6 with SMTP id
 a640c23a62f3a-ac252b56146mr1345274566b.27.1741603561855; Mon, 10 Mar 2025
 03:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f6d2a09fb43742fb5be38f820908510e298f8d40.1741354479.git.fdmanana@suse.com>
 <202503082341.T7dnq95G-lkp@intel.com>
In-Reply-To: <202503082341.T7dnq95G-lkp@intel.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 10 Mar 2025 10:45:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4kad4ojST6ejTQqWMzr-J5ikVb=OABConGjXUHKrV6FQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoDyrvATg6Wb9yt0fdB-M2iyLqKwwojeuWj-tNrZQcXURmjZ_rk1BbuHuQ
Message-ID: <CAL3q7H4kad4ojST6ejTQqWMzr-J5ikVb=OABConGjXUHKrV6FQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] btrfs: make btrfs_iget() return a btrfs inode instead
To: kernel test robot <lkp@intel.com>
Cc: linux-btrfs@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 3:32=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
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
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250308=
/202503082341.T7dnq95G-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250308/202503082341.T7dnq95G-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503082341.T7dnq95G-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    fs/btrfs/send.c: In function 'send_encoded_inline_extent':
> >> fs/btrfs/send.c:5535:15: error: assignment to 'struct inode *' from in=
compatible pointer type 'struct btrfs_inode *' [-Wincompatible-pointer-type=
s]
>     5535 |         inode =3D btrfs_iget(sctx->cur_ino, root);


You're testing against a branch that doesn't contain this dependency:

https://lore.kernel.org/linux-btrfs/89867e61f94b9a9f3711f66c141e4d483a9cc6b=
d.1741283556.git.fdmanana@suse.com/

It's in the for-next branch of the github repo:

https://github.com/btrfs/linux/commits/for-next/

but not yet in  any kernel.org repo.

Thanks.

>          |               ^
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

