Return-Path: <linux-btrfs+bounces-20950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDVmCO06c2kztgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20950-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 10:10:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7341A7306F
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 10:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D96A302EEA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA713370FE;
	Fri, 23 Jan 2026 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmtbwXfO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAA330DD2F
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159138; cv=none; b=HbBixHaA8nDqjfpbrjLDMd2Ub5DoiL3wEnTWqeL/vQKPKGT4p+Iugnd27rgh/d5b7n5rPJAdZxA1U6yOQUJ70iFsu1DhY76mOKZ2RmlrnSpdo/hymT7Ml8rM3cCVYxfjTNOTboPTz5dbvu+qW0Puu15tbaDa3LyfMBv2tLA4Mro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159138; c=relaxed/simple;
	bh=CAe/4poMxrPXe84KYtvJcy40fZxnOIPqv+4yAFyU91I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lz4ux0wilfgQbAM0Ny8J5zCxcTZmr/QXoLf55DatGiiYLQOO3ftyKE4nrth0UoxM2lIorq8EDbVuVYs6jRJLiEk9EnNhgSs4ReoZkV4OsablV/BCO9AeJcXf8aSCFae4TmOU9VWA2gZm4i3GwhXMSeC9cEAQwNVM3LGYqTurBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmtbwXfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A32C19422
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769159138;
	bh=CAe/4poMxrPXe84KYtvJcy40fZxnOIPqv+4yAFyU91I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LmtbwXfOsLvC63uqcHaMpgjEAo4xdrPGRqxwYvhRlZ62bJFro6U+hLxsj0XstRDYy
	 k01lFXzGSVTVYqYJW6rCDfEM9dUzeSz+P5QhI5Tz7Ckg4jTthj7flAbZu39rAJHmk6
	 ONXpavOnHQNO6QGRBPj1cwMgF8qcYT6soCCUW4Kq77xiIv5AB4gv8VN67z+5fFzzYp
	 fyyXes61mR14W/RwtIxzJpgP6of0Ydubr3qtB5+3/Lfq1pIJQ3/A4g+jKckYq/Jme4
	 bbb2os+rVDOYfFi1lHMZODL6/eypUtQAAcfIPIz4LNXV9517MkO3sk9Ag89PKmF4iI
	 PWqj5z16wdseQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b885d8f4092so124081266b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 01:05:37 -0800 (PST)
X-Gm-Message-State: AOJu0Yx+45g6UJdeuFNkKum956GSg506aKhOoDGzTis/JpFSmiWZjZRM
	ZyLNOVuQDfVzz7fWsZkot1jHsdoDQK64Yn+N7RZsVqmnFPk43e9178DYVasNWOA9enxdxynFijk
	RD0z6aa7GSSJrKAZ44xeVL8DMuAPtZhc=
X-Received: by 2002:a17:907:c0a:b0:b84:1fc7:9457 with SMTP id
 a640c23a62f3a-b885ac40de7mr143276766b.8.1769159136525; Fri, 23 Jan 2026
 01:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123081404.473948-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260123081404.473948-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 23 Jan 2026 09:04:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5+c6frv1ozconpz_sUBLtNyVTt8rfu92aVAF40=ccWQg@mail.gmail.com>
X-Gm-Features: AZwV_Qi3q4IcIIyCnlt38KJJN86E5b9bnsNUDTK2YtuWs2OEOo2oR5H2aT3CLYM
Message-ID: <CAL3q7H5+c6frv1ozconpz_sUBLtNyVTt8rfu92aVAF40=ccWQg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: fix loading of DUP block-groups with
 mismatching alloc_offsets
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-20950-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7341A7306F
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 8:18=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> When loading DUP block-groups where one of the backing zones is on a
> conventional zone and one is on a sequential zone,
> btrfs_load_block_group_dup() returns with -EIO as the allocation offsets
> of both block-groups differ.
>
> In case only one zone is conventional and the other zone is sequential,
> set the alloc_offset to the write pointer location of the sequential
> zone.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Shouldn't there be a Fixes tag here?


> ---
>
> This is another example, why we should only allocate metadata from
> conventional block-groups as long as there are still enough left for
> use.
>
>  fs/btrfs/zoned.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 92e6a65b2f9d..f74bd9099d8a 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1450,11 +1450,19 @@ static int btrfs_load_block_group_dup(struct btrf=
s_block_group *bg,
>                 return -EIO;
>         }
>
> -       if (zone_info[0].alloc_offset =3D=3D WP_CONVENTIONAL)
> -               zone_info[0].alloc_offset =3D last_alloc;
> +       if (zone_info[0].alloc_offset =3D=3D WP_CONVENTIONAL) {
> +               if (last_alloc =3D=3D 0 && zone_info[1].alloc_offset !=3D=
 WP_CONVENTIONAL)
> +                       zone_info[0].alloc_offset =3D zone_info[1].alloc_=
offset;
> +               else
> +                       zone_info[0].alloc_offset =3D last_alloc;
> +       }
>
> -       if (zone_info[1].alloc_offset =3D=3D WP_CONVENTIONAL)
> -               zone_info[1].alloc_offset =3D last_alloc;
> +       if (zone_info[1].alloc_offset =3D=3D WP_CONVENTIONAL) {
> +               if (last_alloc =3D=3D 0 && zone_info[0].alloc_offset !=3D=
 WP_CONVENTIONAL)
> +                       zone_info[1].alloc_offset =3D zone_info[0].alloc_=
offset;
> +               else
> +                       zone_info[1].alloc_offset =3D last_alloc;
> +       }
>
>         if (unlikely(zone_info[0].alloc_offset !=3D zone_info[1].alloc_of=
fset)) {
>                 btrfs_err(fs_info,
> --
> 2.52.0
>
>

