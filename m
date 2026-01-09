Return-Path: <linux-btrfs+bounces-20347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38635D0BA86
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 18:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB3F5317FA97
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0E366DB6;
	Fri,  9 Jan 2026 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1pKL+ZT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E9366572
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979355; cv=none; b=RmbKcWluaJPO9yCgFEeyAsSX+Ys+DzH5oS5hy3JtjVnrN2nwH+PO37ue4PnG4gdvpoKdjpMx/vR/m/AFbGpycKw+0lrhLeO6g9t5AVq5MbaTRLbmFfrVjBTjqryUDd4aGe/GnB+aH3jR96zV96JxiV0zp1RwYyV9dAA87q21fMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979355; c=relaxed/simple;
	bh=O+qymsBA/2GVEZI1isu/C73b0PPUUQ9PnIv+b3CAPKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyBpSTAaycTdej8frRJflwTQLOjweU04X+JTNOAyvgECqTOrJwCF/0W/O1jCndzR/2ACl9Jx+Z2dk1niq7O8nht5vhr09mCsSiJzOQn6NnakZsogTWtnug0bNUsjlZGws+bUH1Z8Z7ubbkahhs3EyWtaSm+u30+AVORWYKxzBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1pKL+ZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC41CC2BCB0
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767979355;
	bh=O+qymsBA/2GVEZI1isu/C73b0PPUUQ9PnIv+b3CAPKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O1pKL+ZTSq1DZoHK0A5q5YXA8Syr/2HeCO7xBYHu4mw+vsskfApUdTHsGh4Ob4rM6
	 IPctalCNRxYPvymYGtNEmgR9zNx25AAcTJ7CtTr/WTW1y97PgRPYtepCqOeHK7m/EX
	 Qy7ZbA9/wdoQ1GLmLnAmoeM8uAcVufnvQLAycmhNxJPSJodDOPYAeI+Z4pHOK7l3YR
	 9jcCYsLptNIPrQ+/MR3yx7jPwegL/f1jE2ZXsL9wGwYFrxiZlRzkCa4VrI/dkpJx0g
	 gz3IOMbd5BnU8gP+1TEMYL+Hfv1to8tCQ6c9w5VGQmqijI6PKcWz6YvEkPDS8l1vbA
	 AmAFoGzUA/1Xg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b73161849e1so875885466b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 09:22:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaZKOFyFJ9KMFA1vhgnXgk7fK+BHF9Y8EqH2rmHq5TBFSgZcGXwGwQ7+JIaK5LhrQq4PmJQTnW96MT6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZ+eL0GcGYK5Cw7cJrR4pfZqL4iwwvCUgFL5JbMYJl2244fto
	PxofwkU9dNzTuRwtZhPSQoFaN4yPLQgfSeAlOxy5BVnTFdM1cPBs2kh92wBKZWLqdrgqPpmby4s
	ioCzvAPr3BoOFmfcNsKS3/0th8ctmXyM=
X-Google-Smtp-Source: AGHT+IGNeMiRGaBgkGv1YIhQAjT+h41Y9fAjPCZxxY3boKMBMsylL0UVS9kjPSaUPhdOsovke1gQQG9Jvm9s71a1JKs=
X-Received: by 2002:a17:907:3fa3:b0:b7d:406f:2d3d with SMTP id
 a640c23a62f3a-b84453fc81amr1120844466b.54.1767979354246; Fri, 09 Jan 2026
 09:22:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H4k3Dj9gQQhBz_eadnRUaWaNPaf7+MYucshY6cis2by5Q@mail.gmail.com>
 <tencent_A63C4B6C74A576F566AA3C0B37CE96AC3609@qq.com>
In-Reply-To: <tencent_A63C4B6C74A576F566AA3C0B37CE96AC3609@qq.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 9 Jan 2026 17:21:56 +0000
X-Gmail-Original-Message-ID: <CAL3q7H43qVe8MxC14Mb-XFGdMc0VNQD5zg=-RSNims3mTgfdhw@mail.gmail.com>
X-Gm-Features: AQt7F2qKDNPDIZzbQeomqo3ZHDTkGZZK-wTqJOQ1C9aRWannS5Tkg0okyuChEFc
Message-ID: <CAL3q7H43qVe8MxC14Mb-XFGdMc0VNQD5zg=-RSNims3mTgfdhw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: Sync read disk super and set block size
To: Edward Adam Davis <eadavis@qq.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 1:02=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> When the user performs a btrfs mount, the block device is not set
> correctly. The user sets the block size of the block device to 0x4000
> by executing the BLKBSZSET command.
> Since the block size change also changes the mapping->flags value, this
> further affects the result of the mapping_min_folio_order() calculation.
>
> Let's analyze the following two scenarios:
> Scenario 1: Without executing the BLKBSZSET command, the block size is
> 0x1000, and mapping_min_folio_order() returns 0;
>
> Scenario 2: After executing the BLKBSZSET command, the block size is
> 0x4000, and mapping_min_folio_order() returns 2.
>
> do_read_cache_folio() allocates a folio before the BLKBSZSET command
> is executed. This results in the allocated folio having an order value
> of 0. Later, after BLKBSZSET is executed, the block size increases to
> 0x4000, and the mapping_min_folio_order() calculation result becomes 2.
> This leads to two undesirable consequences:
> 1. filemap_add_folio() triggers a VM_BUG_ON_FOLIO(folio_order(folio) <
> mapping_min_folio_order(mapping)) assertion.
> 2. The syzbot report [1] shows a null pointer dereference in
> create_empty_buffers() due to a buffer head allocation failure.
>
> Synchronization should be established based on the inode between the
> BLKBSZSET command and read cache page to prevent inconsistencies in
> block size or mapping flags before and after folio allocation.
>
> [1]
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> RIP: 0010:create_empty_buffers+0x4d/0x480 fs/buffer.c:1694
> Call Trace:
>  folio_create_buffers+0x109/0x150 fs/buffer.c:1802
>  block_read_full_folio+0x14c/0x850 fs/buffer.c:2403
>  filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2496
>  do_read_cache_folio+0x266/0x5c0 mm/filemap.c:4096
>  do_read_cache_page mm/filemap.c:4162 [inline]
>  read_cache_page_gfp+0x29/0x120 mm/filemap.c:4195
>  btrfs_read_disk_super+0x192/0x500 fs/btrfs/volumes.c:1367
>
> Reported-by: syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db4a2af3000eaa84d95d5
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks, I've added it to the for-next branch with minor editing
(uncapitalize the first word in the subject and added some blank lines
for readability):

https://github.com/btrfs/linux/commits/for-next/

> ---
> v1 -> v2: replace inode lock with invalidate lock
>
>  fs/btrfs/volumes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 13c514684cfb..68ff166fe445 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1364,7 +1364,9 @@ struct btrfs_super_block *btrfs_read_disk_super(str=
uct block_device *bdev,
>                                       (bytenr + BTRFS_SUPER_INFO_SIZE) >>=
 PAGE_SHIFT);
>         }
>
> +       filemap_invalidate_lock(mapping);
>         page =3D read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_N=
OFS);
> +       filemap_invalidate_unlock(mapping);
>         if (IS_ERR(page))
>                 return ERR_CAST(page);
>
> --
> 2.43.0
>

