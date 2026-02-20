Return-Path: <linux-btrfs+bounces-21803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bc6MrxcmGlRGwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21803-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 14:08:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 740C0167AE0
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 14:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA69C3016895
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CEF346770;
	Fri, 20 Feb 2026 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQe0EPpd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B73446D8
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771592887; cv=none; b=TmaRR34Dy12IsmlPDdJvT7ME1O3PFYXi5Ganl6SZKaYXxIu44pc4vXbPTWgWW7UrUAN9fRwYGcRrxGsuzQxYFbdWzX7OjjaYj6+bjXNoG5YKmJBeGXnRD8sNzm8RHn2f7ftsU7pNwwnO87gjKU328K/zXUDbfwcDrKvYYDxRZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771592887; c=relaxed/simple;
	bh=gwMlFboWcviwKqcx+u6xwyq6zo5SZjy/u1mM/Nt/npg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iift1KEK162TsJr/LPT4LqDyXEZfYh779jjcUIxrDp9qf9ai+oEPlj3HnFhcOV9b2hOYZ18VZSpuDq4wOsZ1Nv7V/NM488Wrkb4cS3NKADO4VuLL9MVrhIoOqiDhY3WnM+mIVESGqpyL1BYFK37qX6/eBiCvcx0pDqjc2Bi1maU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQe0EPpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C95BC4AF09
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771592886;
	bh=gwMlFboWcviwKqcx+u6xwyq6zo5SZjy/u1mM/Nt/npg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bQe0EPpdfTMtwb935lXXAtjZOvSIfqFcqAkqNYjcnhNgdVKAC6JungiBJiVcrMvfo
	 HV8qiGMoypk1ZpOSxKZUd74dU8iMcQntcY3IvUHWWcIIesn1ogY86i2mmzEj2cC1Lx
	 f7hV3QgizT2jHhU/LJIdfkZAzHCBuNjMrG54pzBn4Fq4zxx4Xa7MgniCJLSMWl8d7t
	 LwD2sljYSprLn/O1uHJWrl9KpYp4pZqrQwOZD13vh5Ff5bGjGiEV4Dcm0BImkh3JgF
	 9nCcTQV+VBz5ZWm3/w1I282LQh0jcld3RejxSsblJbNUaMj6itfaQc825tC1qVQaKZ
	 Ff8tseRDQAawg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b885e8c6727so376098766b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 05:08:06 -0800 (PST)
X-Gm-Message-State: AOJu0YxlIaH0sPK3ziSbThAAgUnnMPbRPbArwTxoDruwxbFj2Mr0hnhP
	NPWuDUzUK1B42LI+plwlbrESAdTpBcRqZV7n1A0gY7ZRs2mXRiO65icmAVLjWOSppCGrRz3bE2e
	hB3ZH6wXn/8ZH4YQXo+087ApQtUKHiWg=
X-Received: by 2002:a17:906:7953:b0:b8e:fc90:7119 with SMTP id
 a640c23a62f3a-b905444d1fbmr365267566b.30.1771592884934; Fri, 20 Feb 2026
 05:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220130209.5020-1-mark@harmstone.com>
In-Reply-To: <20260220130209.5020-1-mark@harmstone.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 20 Feb 2026 13:07:27 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6RnMw=GLAuv20u0e8azr5Tyr_wXFKKjUEgvp3iFAak_g@mail.gmail.com>
X-Gm-Features: AaiRm53pucSv0UQFR3EIQx9E0_Zd4J-FckBNMxiIIsr3C0Jl2XGOHVbYYnY1lPc
Message-ID: <CAL3q7H6RnMw=GLAuv20u0e8azr5Tyr_wXFKKjUEgvp3iFAak_g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix chunk map leak in btrfs_map_block() after btrfs_chunk_map_num_copies()
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21803-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,harmstone.com:email,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 740C0167AE0
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 1:02=E2=80=AFPM Mark Harmstone <mark@harmstone.com>=
 wrote:
>
> Fix a chunk map leak in btrfs_map_block(): if we return early with -EINVA=
L,
> we're not freeing the chunk map that we've just looked up.
>
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Cc: stable@vger.kernel.org
> Fixes: 0ae653fbec2b ("btrfs: reduce chunk_map lookups in btrfs_map_block(=
)")

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Side note: if there's a Fixes tag, we don't need a CC stable tag
anymore nowadays.



> ---
>  fs/btrfs/volumes.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1bd3464ccdd8..a1f0fccd552c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
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
>
>         map_offset =3D logical - map->start;
>         io_geom.raid56_full_stripe_start =3D (u64)-1;
> --
> 2.52.0
>

