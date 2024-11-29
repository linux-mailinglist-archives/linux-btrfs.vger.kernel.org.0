Return-Path: <linux-btrfs+bounces-9968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A772C9DE722
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 14:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BEEB237DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20B319D8BE;
	Fri, 29 Nov 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK58Ozny"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9311176FB6
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886333; cv=none; b=QMsN+OiHD/I3W96ebC1hqDItwvNf89dx0CblUvqVEa3eUNDpyn5QlVYRkp6M7ZDO1Qo4FsBmvjmZYpA8WCigQXl/VRo8bh2qHQEz6Ezae+4UO90URp+az12r1nT6WxFC41CFMSrcCIq/YDoHZyEQGP5TE7Y44jQrb4g4HCee2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886333; c=relaxed/simple;
	bh=vT/08YPb2QPftJ065ZfNEOjUpdPJNc3vmL5fsrOOvtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRQ5ClKXhljAE9DoInWWzReLl4iLeXTUKv1hKpBt1CDlV21wVRRSUMBADEDQbcj6uWJQW+3bbvaukHje+qtBpvyadcidXITIZW1jPi10lN+qLbbbDanOxtZHNHkPoJjeiNspD2l3E7htw1Kqhi1ejjCqIp4D1HY8lhHxQjjPmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK58Ozny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B667C4CED3
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732886332;
	bh=vT/08YPb2QPftJ065ZfNEOjUpdPJNc3vmL5fsrOOvtY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LK58Ozny+9TXL1sLv+eYvYlZfrV/dw15UeyyJqK+wnyWXa2q/lfajasKENDscqhAd
	 yBAafjLzFUngxzm7xYEHDZYT+GUrvLlIYHUkRQNqtCkyLeYv/C46MPH83ZXV1dsK9K
	 1113aml3jOHb8u8HQ7+VgfekyPVQQXcO/n1HJ9IFOB4bOuztkPXD+UoHqNDwENiXeq
	 iP36bFpKZD0ID311tUUNhhEp73G8z4z+9C2EIvG1285A6EOJHH9pMh4h9CGn2+k3u4
	 uI94jrIfIU2yjXk4zlfuWNdorAUG9uThRBaE+4vdUpLxoSXGam5rqmez8Ab/DZ0C3q
	 pbFyD/QvyezXA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa55da18f89so268498566b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 05:18:52 -0800 (PST)
X-Gm-Message-State: AOJu0YzMPS9SJXAjUOAuWcao3g6Wny2E2qI9d9b3XNG7fjO5Kc1xwg19
	JdcNjeCSaa44v0aDcwGm8dRHtVnumebR3hRqwnHbhUXuRLt7oi7ldCprqbEUg45hMexhtZ90S4s
	MpRNQ0u3/QAtP5bEUnjoplkOgb9I=
X-Google-Smtp-Source: AGHT+IFQZN06TvO6OihT07ABoa2EjKH76O+2g2XDKMOij7JbhsH7wPo7Jc7s9B2onsP9KkTePAmAYlq9+PkRLe365g4=
X-Received: by 2002:a17:906:9d2:b0:aa5:2d9a:152a with SMTP id
 a640c23a62f3a-aa580f36e97mr733372966b.34.1732886330793; Fri, 29 Nov 2024
 05:18:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be18a9fcfa768add6a23e3dee5dfcce55b0814f5.1732812639.git.jth@kernel.org>
In-Reply-To: <be18a9fcfa768add6a23e3dee5dfcce55b0814f5.1732812639.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 29 Nov 2024 13:18:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H42w-bweh4m+G_c_DEPf18e+OqCxR-SR7yt7LCCSpAFXg@mail.gmail.com>
Message-ID: <CAL3q7H42w-bweh4m+G_c_DEPf18e+OqCxR-SR7yt7LCCSpAFXg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: don't BUG_ON() in btrfs_drop_extents()
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 1:11=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> btrfs_drop_extents() calls BUG_ON() in case the counter of to be deleted
> extents is greater than 0. But all of these code paths can handle errors,
> so there's no need to crash the kernel. Instead WARN() that the condition
> has been met and gracefully bail out.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Changes to v1:
> - Fix spelling error in commit message
> - Change ASSERT() to WARN_ON()
> - Take care of the other BUG_ON() cases as well
>
> Link to v1:
> - https://lore.kernel.org/linux-btrfs/20241128093428.21485-1-jth@kernel.o=
rg
> ---
>  fs/btrfs/file.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fbb753300071..f70ce6c65d12 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -245,7 +245,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tr=
ans,
>  next_slot:
>                 leaf =3D path->nodes[0];
>                 if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
> -                       BUG_ON(del_nr > 0);
> +                       if (WARN_ON(del_nr > 0)) {
> +                               ret =3D -EINVAL;
> +                               break;
> +                       }
>                         ret =3D btrfs_next_leaf(root, path);
>                         if (ret < 0)
>                                 break;
> @@ -321,7 +324,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tr=
ans,
>                  *  | -------- extent -------- |
>                  */
>                 if (args->start > key.offset && args->end < extent_end) {
> -                       BUG_ON(del_nr > 0);
> +                       if (WARN_ON(del_nr > 0)) {
> +                               ret =3D -EINVAL;
> +                               break;
> +                       }
>                         if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) =
{
>                                 ret =3D -EOPNOTSUPP;
>                                 break;
> @@ -409,7 +415,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tr=
ans,
>                  *  | -------- extent -------- |
>                  */
>                 if (args->start > key.offset && args->end >=3D extent_end=
) {
> -                       BUG_ON(del_nr > 0);
> +                       if (WARN_ON(del_nr > 0)) {
> +                               ret =3D -EINVAL;
> +                               break;
> +                       }
>                         if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) =
{
>                                 ret =3D -EOPNOTSUPP;
>                                 break;
> @@ -437,7 +446,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tr=
ans,
>                                 del_slot =3D path->slots[0];
>                                 del_nr =3D 1;
>                         } else {
> -                               BUG_ON(del_slot + del_nr !=3D path->slots=
[0]);
> +                               if (WARN_ON(del_slot + del_nr !=3D path->=
slots[0])) {
> +                                       ret =3D -EINVAL;
> +                                       break;
> +                               }
>                                 del_nr++;
>                         }
>
> --
> 2.43.0
>
>

