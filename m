Return-Path: <linux-btrfs+bounces-1594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E7A83604E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 12:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B8A1F2801D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 11:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B663A8C2;
	Mon, 22 Jan 2024 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu6p4WH5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949B39AE8
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921399; cv=none; b=SGDWSAbreW0bovsaknTDdSrd0q9XnNbyIt/DMv4sEhD5pwCxX4z6IA3RXh7lKu2T6npJfMP0g45hF2ZpMQeMqq6Ql8a3edYiru0D/wOUSs10HL+GpRkdcxxxRf+XAB6oz3UJ3XdAuJspyTUy2AcwJc3mDzvzrxky4Y1CyFZvzMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921399; c=relaxed/simple;
	bh=YrgXFOJs2G8vmnfhMWBykApGI8OHQlSj5vS4jXpdg3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDZNEym3Fv6nd4PWAnNIz7Joda/9WxpJtPWPoi7H54uqlCu7O92D0urrsiaxOPIGwQk2EVthpmbbo9hB3kbG9nqIpcbKOUCfQhz3ONipY8pv2lPpM3eNH90TRkK42sjFFYcA2gtF0mmFC9UflPYLYXA7OHQzGpgP0qI8kSUOPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lu6p4WH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71B5C433F1
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 11:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921398;
	bh=YrgXFOJs2G8vmnfhMWBykApGI8OHQlSj5vS4jXpdg3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lu6p4WH5ZIN2X65ofh861yeIodyyCxHfjytLjQTUqR+wTTTDfs/O2t1ZlXOjWATeq
	 LerJFYhsywn6LFwpXIN/yOiUt2yx0U5Oap/DBD7T/10icFEOFOkXfVIaPv5T3ZeFb8
	 1Rt0m7MbxA7jVYng0YNUEQptVvow7NOuAUXxld84nuxxx3zbXgdY69iXduhBQx9UFw
	 N0aw+P3E+g0O50um6mKV/LjqctQmkhXEjQPvOuedgWyl/l2HicAmA5jCAVf3uvHxJX
	 ML3GRPdpX3ECLdE7Me41U+Qv4LzGyplSIa0VHDzKPlUx9ApIZh9zFpj+p94OWuvGD3
	 OGZPIrxGsZjnQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso695985666b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 03:03:18 -0800 (PST)
X-Gm-Message-State: AOJu0Yzw4zO3nguTuv/S23945UigXZyfXZKDWZ53NZDOlahjS9b32dAf
	YZB216Si02MhYZQW3Abb7Y7vado6WMF/4JxwXXRjOHPNynU39oOs89ExmtGOMb95AAErWJK4vFL
	idjWZC7RhdP9SAPv9gp8LSDKJ/lY=
X-Google-Smtp-Source: AGHT+IFuvUK8pbXFrNaOK+Bnz4WCBCTlz8fnDWHr6j7bYj8N2eETbLZBh1uFt5v+lWhYjjjctj6HTemS4YEriWoPHOc=
X-Received: by 2002:a17:906:830f:b0:a28:b985:8da0 with SMTP id
 j15-20020a170906830f00b00a28b9858da0mr3816675ejx.22.1705921397115; Mon, 22
 Jan 2024 03:03:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a80cb4b32af89787dadee728310e5e2ca85343f.1705741883.git.wqu@suse.com>
In-Reply-To: <6a80cb4b32af89787dadee728310e5e2ca85343f.1705741883.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 22 Jan 2024 11:02:40 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7G-yq-NvU1yUtw9Q8qsZMWtH97FJ6euqvg_t4jerLOhA@mail.gmail.com>
Message-ID: <CAL3q7H7G-yq-NvU1yUtw9Q8qsZMWtH97FJ6euqvg_t4jerLOhA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not ASSERT() if the newly created subvolume
 already got read
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 9:12=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a syzbot crash, triggered by the ASSERT() during subvolume
> creation:
>
>  assertion failed: !anon_dev, in fs/btrfs/disk-io.c:1319
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/disk-io.c:1319!
>  invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>  RIP: 0010:btrfs_get_root_ref.part.0+0x9aa/0xa60
>   <TASK>
>   btrfs_get_new_fs_root+0xd3/0xf0
>   create_subvol+0xd02/0x1650
>   btrfs_mksubvol+0xe95/0x12b0
>   __btrfs_ioctl_snap_create+0x2f9/0x4f0
>   btrfs_ioctl_snap_create+0x16b/0x200
>   btrfs_ioctl+0x35f0/0x5cf0
>   __x64_sys_ioctl+0x19d/0x210
>   do_syscall_64+0x3f/0xe0
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
>  ---[ end trace 0000000000000000 ]---
>
> [CAUSE]
> During create_subvol(), after inserting root item for the newly created
> subvolume, we would trigger btrfs_get_new_fs_root() to get the
> btrfs_root of that subvolume.
>
> The idea here is, we have preallocated an anonymous device number for
> the subvolume, thus we can assign it to the new subvolume.
>
> But there is really nothing preventing things like backref walk to read
> the new subvolume.
> If that happens before we call btrfs_get_new_fs_root(), the subvolume
> would be read out, with a new anonymous device number assigned already.
>
> In that case, we would trigger ASSERT(), as we really expect no one to
> read out that subvolume (which is not yet accessible from the fs).
> But things like backref walk is still possible to trigger the read on
> the subvolume.
>
> Thus our assumption on the ASSERT() is not correct in the first place.
>
> [FIX]
> Fix it by removing the ASSERT(), and just free the @anon_dev, reset it
> to 0, and continue.
>
> If the subvolume tree is read out by something else, it should have
> already get a new anon_dev assigned thus we only need to free the
> preallocated one.
>
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 2dfb1e43f57d ("btrfs: preallocate anon block device at first phase=
 of snapshot creation")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 57be7dd44da5..5d5faa844408 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1336,8 +1336,17 @@ static struct btrfs_root *btrfs_get_root_ref(struc=
t btrfs_fs_info *fs_info,
>  again:
>         root =3D btrfs_lookup_fs_root(fs_info, objectid);
>         if (root) {
> -               /* Shouldn't get preallocated anon_dev for cached roots *=
/
> -               ASSERT(!anon_dev);
> +               /*
> +                * Some other caller may have read out the newly inserted
> +                * subvolume already. (For things like backref walk etc).

Btw, whole sentences are not put inside parenthesis.
Should be something like:

... subvolume already (for things like backref walking, etc).

Apart from that:

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +                * Not that common but still possible.
> +                * In that case, we just need to free the anon_dev.
> +                */
> +               if (unlikely(anon_dev)) {
> +                       free_anon_bdev(anon_dev);
> +                       anon_dev =3D 0;
> +               }
> +
>                 if (check_ref && btrfs_root_refs(&root->root_item) =3D=3D=
 0) {
>                         btrfs_put_root(root);
>                         return ERR_PTR(-ENOENT);
> --
> 2.43.0
>
>

