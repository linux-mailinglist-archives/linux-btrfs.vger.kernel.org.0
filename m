Return-Path: <linux-btrfs+bounces-12098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB5A56A83
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 15:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963E916D4C4
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF7D21B8F6;
	Fri,  7 Mar 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu752rde"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2121B8E1
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358288; cv=none; b=grOueP7eBcDfNOGSJ4WTpvsXSQRNEpQkOxYNMXECh6zLTP5EnINmOa0PxZK59uutNy8dKXJLe+Yl6HRERbhPpf+1Dd50f+0ExP+EIXzBOr80UTlOaDay6e1WDRuBSjkBRDIfb93Ctb01zfynCQSfQrRd1V1mOXKHJwNz9EfbqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358288; c=relaxed/simple;
	bh=yjF50Ig9s4fDfWZ1ztJogmD2dEV2Iw1zhC7Pcr2SKrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRVnkm9sJmxlSqRaVpK0ppBTraXL2cHszCkiG3x5pGfg9OQ+I3lyTSN9I28RqRHjeSg0riV74pbhZrH9NFNiuJkG6QRYLxA8pYNoKqrqbkWJznAUq4+jrptJFAA2ph2BiDxUzNNvmGMBjSWh+4vn52JQo9toh3va2V5ar/bDJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu752rde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30744C4CEE5
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 14:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741358288;
	bh=yjF50Ig9s4fDfWZ1ztJogmD2dEV2Iw1zhC7Pcr2SKrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nu752rdeIUbRiuQxWfJ+pQUrtXAJQ4K37FJY0lDLrRa5dNWfYtGaMAkUG/u46Gda4
	 p9rkXX0fgJD2xW2a2R7ybf4mt3HnArIoEuTXoqOSDWvKdcCnxyhppRL05kt977uhMd
	 Y2tqzr6G6WGn4euWx6uE9MmcosvJm4pYAXYOsCKHG7sUpmGqqQZ8Yp6Puw6aijgsO2
	 K3zSK4r29iX8qTZLswkiLllJvLDz+Vm6M6AhMbn0an3vJGzli/UNqqan7plCa9CYbr
	 PY6D/+zucplcBHApjf03qEndY1CUcPo3TB8ih4Bj3mcf/LIaBv5xFuZtLESs4wjO09
	 WKLLBoYHI4Xbg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso3242037a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Mar 2025 06:38:08 -0800 (PST)
X-Gm-Message-State: AOJu0YyMo8zsqZlN6mBYBn21W6iY1WfTm4cGCFm+07HNx0bwXR+vASB9
	5C8paM6OCClAhd9GYk+PVeo8Ri2c5uFtF46wrECRHGzQSaQL66DvSZHQwzS+QC4gwhpHg8Wrt4Z
	dMAwINJlFs9mRmdZhoXvyNmv2xlQ=
X-Google-Smtp-Source: AGHT+IEnfihRAzw4bImIMuKljTebAu+e+lEqsW9CBm2BEaJbXebRw08dQ1kG0OvDPSmZY+zZbhLkdojXfRw5riDP5wQ=
X-Received: by 2002:a17:907:86a8:b0:abf:514a:946a with SMTP id
 a640c23a62f3a-ac2526db875mr363824266b.28.1741358286695; Fri, 07 Mar 2025
 06:38:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741306938.git.boris@bur.io> <817581cbc85cfda4c2232fecbfdb6b615b7067ca.1741306938.git.boris@bur.io>
In-Reply-To: <817581cbc85cfda4c2232fecbfdb6b615b7067ca.1741306938.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 7 Mar 2025 14:37:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H75p9GUAav64pvTZf4SVpQ=rbcVHAuo5zUEeAytkxXkYA@mail.gmail.com>
X-Gm-Features: AQ5f1Jo6YCllIEyN4d-p_rFYAFPzvdp4y5sRo4gBMhrlTf92MHEsxAv5hPWWKz0
Message-ID: <CAL3q7H75p9GUAav64pvTZf4SVpQ=rbcVHAuo5zUEeAytkxXkYA@mail.gmail.com>
Subject: Re: [PATCH 4/5] btrfs: explicitly ref count block_group on new_bgs list
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:31=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> All other users of the bg_list list_head inc the refcount when adding to
> a list and dec it when deleting from the list. Just for the sake of
> uniformity and to try to avoid refcounting bugs, do it for this list as
> well.

Please add a note that the reason why it's not ref counted is because
the list of new block groups belongs to a transaction handle, which is
local and therefore no other tasks can access it.

>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 2db1497b58d9..e4071897c9a8 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2801,6 +2801,7 @@ void btrfs_create_pending_block_groups(struct btrfs=
_trans_handle *trans)
>                 spin_lock(&fs_info->unused_bgs_lock);
>                 list_del_init(&block_group->bg_list);
>                 clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_fla=
gs);
> +               btrfs_put_block_group(block_group);
>                 spin_unlock(&fs_info->unused_bgs_lock);
>
>                 /*
> @@ -2939,6 +2940,7 @@ struct btrfs_block_group *btrfs_make_block_group(st=
ruct btrfs_trans_handle *tran
>         }
>  #endif
>
> +       btrfs_get_block_group(cache);
>         list_add_tail(&cache->bg_list, &trans->new_bgs);
>         btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);

There's a missing btrfs_put_block_group() call at
btrfs_cleanup_pending_block_groups().

Thanks.


>
> --
> 2.48.1
>
>

