Return-Path: <linux-btrfs+bounces-2666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9812A860F29
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 11:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2391A2858C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9605CDF2;
	Fri, 23 Feb 2024 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcJFsKj7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD85CDC9
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683914; cv=none; b=BQHEvirHokEw9+BH6vXgu3+vnHsdeKC69YcNvboNFi8NlxumkhvIDaB69b3mKpt2hyMUEo1oj/5q1E6PTqd2YS6rNO7BBSF9PToCe1h8/d9DdZWzicNbFCkFeYfq8Vg11XB2RF6yHfSsAXemE4MPF9km3MdfZ5qVQdYlWVi68RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683914; c=relaxed/simple;
	bh=PYCjZNeDdOk2UnVQz4ga2cdZQa+GxWDW3Yd57LXY6gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bn41Sv6bPeO/MLhgYfb5KL9GiEYwfpKvy2gFs+0Xjy5dZFmS+8xXTMpB/hnZAtfu7R34594jeoB1oAaMTlGaxqEjNH1nzG9e2+0rUk3NeTvzzrv5hEVYYY4GcSkFMfuINUvyYnJccXQospq9uT2uLLTwEI3iwvJsWo46CsgtmJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcJFsKj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC238C433F1
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 10:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708683913;
	bh=PYCjZNeDdOk2UnVQz4ga2cdZQa+GxWDW3Yd57LXY6gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZcJFsKj7CR/G3eh1FCCB3JV/OEzN8FstnV/HKBxsTQcXUqRuS47poz0dZcXe8yp1C
	 m3GAuohSakEtgYFoV6ONyF0TvbKM1VHfZimJzpsFygP7dOx+yRnopQpxNiF6Gv1YNV
	 bhDYLh7kYuDMNG3dRjLdc57v60y87pXrHk0B4j0rvp4CdOIGFKZ/KvFjO0hHGlL1qb
	 5jsq0E0CGql4tIwVcfr7WU/OzyQROT1qZqTbppESHReZFW890FUX/NAZhs5ctPoB8Y
	 lPxRr2iplhGX4zEoIQIL5zCccCJ13BkgGG885ZqF21fz23/xyar8AiRmRE1zExEBI4
	 4HIYbAirrnG8w==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso125759166b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 02:25:13 -0800 (PST)
X-Gm-Message-State: AOJu0Yxxh6cSjGn8VC3Q/cp62Vfbm4kRPN1LPqhU7hdKI8GDuKRLOF51
	UryJg2v1XHEfV2Sdp43l8xX7cXY8JFw7a9ORvnOfpK/fGRfap9rNTatd/9E2IfKy1F+H/sNwCJ2
	3XJZFA3AH23ra+bMn/zevBLwn+fM=
X-Google-Smtp-Source: AGHT+IHPm3JYw9jYZrXtog/77XNnXca7AVQCs9qa7BUfKg4rxWD1a51gpWYslpRod9y3TQg0aDmg7jhsYuxguVd2qIo=
X-Received: by 2002:a17:907:11c5:b0:a3f:899e:d3ac with SMTP id
 va5-20020a17090711c500b00a3f899ed3acmr1193799ejb.35.1708683912153; Fri, 23
 Feb 2024 02:25:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa1dd06ced5ae3d775646ffa2eff05d0ce6da6df.1708674214.git.wqu@suse.com>
In-Reply-To: <aa1dd06ced5ae3d775646ffa2eff05d0ce6da6df.1708674214.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 23 Feb 2024 10:24:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H741jSULRwtPeF4fbvt1TwxULi-Baf5YLEkWGfHA3odow@mail.gmail.com>
Message-ID: <CAL3q7H741jSULRwtPeF4fbvt1TwxULi-Baf5YLEkWGfHA3odow@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: always free reserved space for extent records
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Fabian Vogt <fvogt@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 7:44=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> If qgroup is marked inconsistent (e.g. caused by operations needing full
> subtree rescan, like creating a snapshot and assign to a higher level
> qgroup), btrfs would immediately start leaking its data reserved space.
>
> The following script can easily reproduce it:
>
>  mkfs.btrfs -O quota -f $dev
>  mount $dev $mnt
>  btrfs subv create $mnt/subv1
>  btrfs qgroup create 1/0 $mnt
>
>  # This snapshot creation would mark qgroup inconsistent,
>  # as the ownership involves different higher level qgroup, thus
>  # we have to rescan both source and snapshot, which can be very
>  # time consuming, thus here btrfs just choose to mark qgroup
>  # inconsistent, and let users to determine when to do the rescan.
>  btrfs subv snapshot -i 1/0 $mnt/subv1 $mnt/snap1
>
>  # Now this write would lead to qgroup rsv leak.
>  xfs_io -f -c "pwrite 0 64k" $mnt/file1
>
>  # And at unmount time, btrfs would report 64K DATA rsv space leaked.
>  umount $mnt
>
> And we would have the following dmesg output for the unmount:
>
>  BTRFS info (device dm-1): last unmount of filesystem 14a3d84e-f47b-4f72-=
b053-a8a36eef74d3
>  BTRFS warning (device dm-1): qgroup 0/5 has unreleased space, type 0 rsv=
 65536
>
> [CAUSE]
> Since commit e15e9f43c7ca ("btrfs: introduce
> BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting"),
> we introduce a mode for btrfs qgroup to skip the timing consuming
> backref walk, if the qgroup is already inconsistent.
>
> But this skip also covered the data reserved freeing, thus the qgroup
> reserved space for each newly created data extent would not be freed,
> thus cause the leakage.
>
> [FIX]
> Make the data extent reserved space freeing mandatory.
>
> The qgroup reserved space handling is way cheaper compared to the
> backref walking part, and we always have the super sensitive leak
> detector, thus it's definitely worthy to always free the qgroup
> reserved data space.
>
> Fixes: e15e9f43c7ca ("btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOU=
NTING to skip qgroup accounting")
> Reported-by: Fabian Vogt <fvogt@suse.com>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1216196
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/qgroup.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 3846433d83d9..b3bf08fc2a39 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2957,11 +2957,6 @@ int btrfs_qgroup_account_extents(struct btrfs_tran=
s_handle *trans)
>                                 ctx.roots =3D NULL;
>                         }
>
> -                       /* Free the reserved data space */
> -                       btrfs_qgroup_free_refroot(fs_info,
> -                                       record->data_rsv_refroot,
> -                                       record->data_rsv,
> -                                       BTRFS_QGROUP_RSV_DATA);
>                         /*
>                          * Use BTRFS_SEQ_LAST as time_seq to do special s=
earch,
>                          * which doesn't lock tree or delayed_refs and se=
arch
> @@ -2985,6 +2980,11 @@ int btrfs_qgroup_account_extents(struct btrfs_tran=
s_handle *trans)
>                         record->old_roots =3D NULL;
>                         new_roots =3D NULL;
>                 }
> +               /* Free the reserved data space */
> +               btrfs_qgroup_free_refroot(fs_info,
> +                               record->data_rsv_refroot,
> +                               record->data_rsv,
> +                               BTRFS_QGROUP_RSV_DATA);
>  cleanup:
>                 ulist_free(record->old_roots);
>                 ulist_free(new_roots);
> --
> 2.43.2
>
>

