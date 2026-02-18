Return-Path: <linux-btrfs+bounces-21758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SkHFC+jSlWmqVAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21758-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:55:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F5A157302
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6371301E7D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64F33E37C;
	Wed, 18 Feb 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/kUrYvt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB512D3ECA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426528; cv=none; b=WhHEtJmS/Ao0PE+U2VQXrr9botCJoZfUy54KbQtaoVWRZ2tXpxOGB0Y8N/HaNZyiEeOkMNnJGAJ9+fNb4JOOLFnNmixi3kXHAp3ayvuVmYfX/jaDScwth60xzv25Up5vW9QwDXw1eMubluAf12kz0kRZhaud65yjuBV9GgPMU8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426528; c=relaxed/simple;
	bh=gvZJfVnDCjwXj5GnMnyP1hdJI0IphI8xclg66jqKcKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/BnLsO1Dm+iAY7BNwZh2W5wcwhTxj+nooYTLRNIbnYWpQH/o6mKWNU3PGlC+4i21DRUbFcWikppmjHOSOvRXHcVlwzHX5mWGgqZavuSF9I0TUSRYNHdiZ73RWRL/5sIPsNesz2BY2IQE8+p1fyA9jyOPJHj/0QmmflZYMHCIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/kUrYvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1A4C19421
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771426528;
	bh=gvZJfVnDCjwXj5GnMnyP1hdJI0IphI8xclg66jqKcKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R/kUrYvttgKHU/GxPv2AKnOabxPnfNx1yJFq9oxbIpA4xsy44xcHFrsGtWKPJ4weG
	 QORKKH8uZYIQ9qC6ct/NCmnCzJoXnCgQ6F/RiHTiEB/NS424RjqulVNNtPNBkgkCGc
	 0mlS0tYUsvbBv1VBkxjuJmDgwqvBWv9ZlSqEPl+iRNheG6DUZNT6UbxuqYdvuN4PDn
	 h31pEIFreXv2cuxBZ6uPqJxPYr6QPtavyVdtyJ4YFlgjytoZ+QJjkhjYSgu+38q666
	 Nw6OyS+xHfv9v7GF8x8XhpGkVpxufjGalVCXW3Ha6ZV37F+cxlEpT44yWS6LE874Xm
	 HI/DeCWm0Tppg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b883787268fso662002566b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 06:55:28 -0800 (PST)
X-Gm-Message-State: AOJu0Yx5vL5QF4O+3y9AEcNYzKZeNBorfKhDm+3gptf14fP5m4CGRW4W
	bqTW9So3iEHvTZP3SEgHLhpNT1jm8VImai+cb556WXToz43N8xY89bHfO3LIG/2zgTpay3g5BiO
	Kjo0WMT6/6CaMwRPHIV4l3sd98lKWLH4=
X-Received: by 2002:a17:907:3f08:b0:b8e:de4e:8a9b with SMTP id
 a640c23a62f3a-b8fc3d4b306mr727000166b.65.1771426526821; Wed, 18 Feb 2026
 06:55:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218143334.25014-1-mark@harmstone.com>
In-Reply-To: <20260218143334.25014-1-mark@harmstone.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 18 Feb 2026 14:54:49 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4nVSx-cVS03APKyhus_wx+QcFdP_67WrV8gTnP6ApFNw@mail.gmail.com>
X-Gm-Features: AZwV_QiXgXOP51zAKWilY5nKRJnTUqKQ1M-NHheq0LTV8T9YHvH8e3ptZawJjRg
Message-ID: <CAL3q7H4nVSx-cVS03APKyhus_wx+QcFdP_67WrV8gTnP6ApFNw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix chunk map leaks in btrfs_map_block()
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21758-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,harmstone.com:email,fb.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A4F5A157302
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 2:33=E2=80=AFPM Mark Harmstone <mark@harmstone.com>=
 wrote:
>
> Fix the two early returns in btrfs_map_block() so that we can no longer
> fail to put the chunk map after getting it.
>
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Reported-by: Chris Mason <clm@fb.com>

So being a bug fix, this is the type of patch that should have a Fixes tag.

The commit that introduced the first leak is not in any released
kernel, so no stable releases are affected.
However it's still useful to have the Fixes tag here, because in case
someone decides to backport the offending commit, either upstream or
downstream, there are scripts in place to check if there are newer
commits that fix a bug in the former commit and therefore must be
backported as well.

But the second leak was introduced in a much older commit, from 2024,
and should be backported.
Se comments inline below.

Also, since this was reported publicly, please add a Link tag pointing
to the URL with the review.

> ---
>  fs/btrfs/volumes.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 83e2834ea273..a1f0fccd552c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7082,7 +7082,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>
>                 ret =3D btrfs_translate_remap(fs_info, &new_logical, leng=
th);
>                 if (ret)
> -                       return ret;
> +                       goto out;

For this hunk:

Fixes: 18ba64992871 ("btrfs: redirect I/O for remapped block groups")

>
>                 if (new_logical !=3D logical) {
>                         btrfs_free_chunk_map(map);
> @@ -7096,8 +7096,10 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,=
 enum btrfs_map_op op,
>         }
>
>         num_copies =3D btrfs_chunk_map_num_copies(map);
> -       if (io_geom.mirror_num > num_copies)
> -               return -EINVAL;
> +       if (io_geom.mirror_num > num_copies) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }

For this hunk:

Fixes: 0ae653fbec2b ("btrfs: reduce chunk_map lookups in btrfs_map_block()"=
)

I would suggest splitting this into 2 different patches, each one with
the respective Fixes tag so that the second leak can be backported
more easily.

>
>         map_offset =3D logical - map->start;
>         io_geom.raid56_full_stripe_start =3D (u64)-1;
> --
> 2.52.0
>
>

