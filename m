Return-Path: <linux-btrfs+bounces-19698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BEECB8836
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 10:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 804B230CD299
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80858313546;
	Fri, 12 Dec 2025 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnl6GXcM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3475313273
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532487; cv=none; b=u8VjTlCl1IEUIO9JxOJqe65/PSeAh/HD/FRX+PuHJgrscJDmjjVfYN3Ik2tH8vKRM8esuEbhBdJUvUmFc8jTBibpJWtJhzhY5Zs1qq+7uIdCuuSva2CZnyEIV2G+DEtNAfYVmOwECCz2bNB40BxMbC1pZvXNhAvEzVhlHANti80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532487; c=relaxed/simple;
	bh=/1EZ+K302r8TwinWPvDC5Kp2/fEyrW3Cvv0vpxELCbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbSw7XojJ0UB0H93waCOw3A7dUJM+dGU68jGo8xucwq05Weul/oHCpozLZ1KdMk2vQNDaH+YXC/G8iuD/P26ibrucQO3yIUUamXJyIW8zvNsRcg6qDaI5K7mV7PrnALILYEUXdd/d6/0dgbOnq1RAc4uFdaFN2Y8Y1t5KWns+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnl6GXcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C5BC116B1
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 09:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765532487;
	bh=/1EZ+K302r8TwinWPvDC5Kp2/fEyrW3Cvv0vpxELCbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hnl6GXcMwjXRKgu9MpmwUUHreKDc0qWZ91f+RM+ZC619b7l8j1nxrrEhRx4DOanTK
	 jOJo1a1wFt5mI8E3+t3bh2PMTMfo9rkobTMbsCmQhgTvjVA8WnPIh8tWvfIJE1qbFJ
	 wnYwD1k5XOD+o771Tr44eKdE0yHmCrvqMsVAjStdNVWozK+0ckFDnkWi5clxCopyEi
	 3en/M7dOyE8xwvBeAov+XPHdibttj6Yyr3WxBZpX/rCmlTZbIeOh3D75nA6XGPmqCj
	 tNYzhQMfBYDZ3lmJi4MQVVCzSpx80qu0AwK4d3MEgD5tUfC5gRNjUEQS5AMD8u2ZY9
	 fve+RozNmwwqg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b736ffc531fso202881466b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 01:41:27 -0800 (PST)
X-Gm-Message-State: AOJu0Yyscne9ljPxGgAcZ7AGsZxjFkd35mlki/2br28svnNbXDClfmmf
	RbbheVKsla6QIMBEjmKAvwn6XFVUelZ1uu+m8vIwq4yycq5y47C94a0DXkyJBCcGkiqLejmIRIC
	Xo2RopK2sLnmx8LEA3tgEhjmSg51fm0w=
X-Google-Smtp-Source: AGHT+IGmtSIkO+ZmCrv2lu74FmUwmTwjfkPjwc9Q293BCzX63ja3sYYyNJSXG8MxBzJGDodBEMNQQrLc3EsRPCz2vik=
X-Received: by 2002:a17:907:934c:b0:b79:ff35:6473 with SMTP id
 a640c23a62f3a-b7d236633f4mr128421366b.17.1765532485681; Fri, 12 Dec 2025
 01:41:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212071000.135950-1-johannes.thumshirn@wdc.com> <20251212071000.135950-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20251212071000.135950-3-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Dec 2025 09:40:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4nF8Si9BG_Bd+cBA86ECAM+4TYoRf+PuvdEOgeJ6dn9w@mail.gmail.com>
X-Gm-Features: AQt7F2oOFNiIrd39bjUhQ1lwIQZGdW4BinqpQw7u1_7wk8FtLci8fujUC6t-C5E
Message-ID: <CAL3q7H4nF8Si9BG_Bd+cBA86ECAM+4TYoRf+PuvdEOgeJ6dn9w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] btrfs: move space_info_flag_to_str() to space-info.h
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 7:12=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Move space_info_flag_to_str() to space-info.h and as it now isn't static
> to space-info.c any more prefix it with 'btrfs_'.
>
> This way in can be re-used in other places.

in -> it

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/space-info.c | 18 +-----------------
>  fs/btrfs/space-info.h | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 6babbe333741..7b7b7255f7d8 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -602,22 +602,6 @@ do {                                                =
                       \
>         spin_unlock(&__rsv->lock);                                      \
>  } while (0)
>
> -static const char *space_info_flag_to_str(const struct btrfs_space_info =
*space_info)
> -{
> -       switch (space_info->flags) {
> -       case BTRFS_BLOCK_GROUP_SYSTEM:
> -               return "SYSTEM";
> -       case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
> -               return "DATA+METADATA";
> -       case BTRFS_BLOCK_GROUP_DATA:
> -               return "DATA";
> -       case BTRFS_BLOCK_GROUP_METADATA:
> -               return "METADATA";
> -       default:
> -               return "UNKNOWN";
> -       }
> -}
> -
>  static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
>  {
>         DUMP_BLOCK_RSV(fs_info, global_block_rsv);
> @@ -630,7 +614,7 @@ static void dump_global_block_rsv(struct btrfs_fs_inf=
o *fs_info)
>  static void __btrfs_dump_space_info(const struct btrfs_space_info *info)
>  {
>         const struct btrfs_fs_info *fs_info =3D info->fs_info;
> -       const char *flag_str =3D space_info_flag_to_str(info);
> +       const char *flag_str =3D btrfs_space_info_type_str(info);
>         lockdep_assert_held(&info->lock);
>
>         /* The free space could be negative in case of overcommit */
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 446c0614ad4a..0703f24b23f7 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -307,4 +307,20 @@ int btrfs_calc_reclaim_threshold(const struct btrfs_=
space_info *space_info);
>  void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
>  void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 le=
n);
>
> +static inline const char *btrfs_space_info_type_str(const struct btrfs_s=
pace_info *space_info)
> +{
> +       switch (space_info->flags) {
> +       case BTRFS_BLOCK_GROUP_SYSTEM:
> +               return "SYSTEM";
> +       case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
> +               return "DATA+METADATA";
> +       case BTRFS_BLOCK_GROUP_DATA:
> +               return "DATA";
> +       case BTRFS_BLOCK_GROUP_METADATA:
> +               return "METADATA";
> +       default:
> +               return "UNKNOWN";
> +       }
> +}
> +
>  #endif /* BTRFS_SPACE_INFO_H */
> --
> 2.52.0
>
>

