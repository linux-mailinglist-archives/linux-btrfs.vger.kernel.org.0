Return-Path: <linux-btrfs+bounces-1369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BEA829EE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 18:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612CA283F83
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD954CE0D;
	Wed, 10 Jan 2024 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJIWim8m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85A495D1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 17:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BDFC433F1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704906695;
	bh=F8wrRI1CeP/3hznCiQd2+sQlLwZr8JA/Gmv1bwDTZhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eJIWim8mO/eJXf9d3ZrucuFNET/8WU+TvLPQTNuuF7TfMbtOi7uuVppgTe/fnOOxC
	 JBM65UVWUqTcq6p++JQht5besOWfUZugs5DvegGs7yt6pkfa6gvm+sNZw++d1AmoA9
	 MHu/0VknoBmszHosdmqBLebo0mhBPYg0/zv55R3JuaqM1P5YkXneAt3Uy4RWR3AU0t
	 Rh+lPbfIjm2zi00C4Z8UZfH+gNUV+suzqNKlPI+4Nq3/10QC3HQG73dMLBlO7XZ63y
	 kM1Uvqbla5cXO6Nm4yz/qY73KndSPDq0m+SGJC8G1oekpQXMIYAJwJ+yEmnImNwb6F
	 HvfiJtXC27m+A==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28ab7ae504so421763866b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 09:11:34 -0800 (PST)
X-Gm-Message-State: AOJu0YybDmc+aeaDCzejS18LDzoZnyejplzmxSzfNZIYBW4WwYddfhst
	t1SpfibacUNedNZR2cbWlwi3vf4WHEyyfCe45vY=
X-Google-Smtp-Source: AGHT+IEE3bcA7mdyWCzmKEzmUxxAqymm1YAftDSkuf3ZFTpOcYpMiRCz8abNvN9hMTcrmY/m/pyNS3IeH1X0HOT3bNY=
X-Received: by 2002:a17:907:31c3:b0:a2a:d44a:cada with SMTP id
 xf3-20020a17090731c300b00a2ad44acadamr1030459ejb.129.1704906692416; Wed, 10
 Jan 2024 09:11:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110165550.1701-1-dsterba@suse.com>
In-Reply-To: <20240110165550.1701-1-dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 10 Jan 2024 17:10:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H59+4J8N_jV5VpdrxRC5k5kq5MrzEeSGLsb1nQa+o3GMA@mail.gmail.com>
Message-ID: <CAL3q7H59+4J8N_jV5VpdrxRC5k5kq5MrzEeSGLsb1nQa+o3GMA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: send: return EOPNOTSUPP on unknown flags
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:56=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
>
> When some ioctl flags are checked we return EOPNOTSUPP, like for
> BTRFS_SCRUB_SUPPORTED_FLAGS, BTRFS_SUBVOL_CREATE_ARGS_MASK or fallocate
> modes. The EINVAL is supposed to be for a supported but invalid
> values or combination of options. Fix that when checking send flags so
> it's consistent with the rest.
>
> Link: https://lore.kernel.org/linux-btrfs/CAL3q7H5rryOLzp3EKq8RTbjMHMHeaJ=
ubfpsVLF6H4qJnKCUR1w@mail.gmail.com/
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 2d7519a6ce72..7902298c1f25 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -8111,7 +8111,7 @@ long btrfs_ioctl_send(struct inode *inode, struct b=
trfs_ioctl_send_args *arg)
>         }
>
>         if (arg->flags & ~BTRFS_SEND_FLAG_MASK) {
> -               ret =3D -EINVAL;
> +               ret =3D -EOPNOTSUPP;
>                 goto out;
>         }
>
> --
> 2.42.1
>
>

