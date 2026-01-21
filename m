Return-Path: <linux-btrfs+bounces-20863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON8qIiAxcWmcfAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20863-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 21:03:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C9B5CC7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 21:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D651848491
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 17:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE551387359;
	Wed, 21 Jan 2026 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS4zgXXh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70E33D4F5
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016013; cv=none; b=D2obweEF/S56UUnbVL1Nk2pt4zdA1Ae81r9gfQJO7Mqs2EaMXVR7B4MEJU5VG4gFn99tBOA+ykvusvc8JFm46qyxJRrSyvQ7hZt+YGiusOjKDJKqv32bf9VTthSU8HqwlTEOjz1VW26ncGWX4sWYvVv0HHAtuRsPKyiljbLRGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016013; c=relaxed/simple;
	bh=aXzBJ2JbpPI4ChU0GQq5ln26ksg75WMcCP5KEP8GJSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHLr54xVz9uBPgamd1kYfv+0iwIiW3IJdMuOplPVLvNv3bdJjmibVhL1tnnXrjIP7V1x1YqC63U1o6xZls+bO9S9VN8rg2hZiysnlCpkQu3W5YOhZTR7ivBUhHprwzMHS5S5ItQSBljGtmw1w4RrS9JSQLoOaHeNExobphy8URw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS4zgXXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB86C116D0
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769016012;
	bh=aXzBJ2JbpPI4ChU0GQq5ln26ksg75WMcCP5KEP8GJSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NS4zgXXhaQicDIEbk4z34xax0p+95j5IC+St0MTkN5sZj6tQotIuJDEoWYPL2TTnQ
	 GSmo6btOq2kVXihx6v8qb1suGXNzpGeYd5bosD49yBYhauvSIZuR7P2QZ40JdcFcb4
	 UdqqbI7AyHF1EDPxr5u0wtp1M8crEi9UwsucC4VAWsDbFAg8WJHh3Chv+ru1w/5vAt
	 d4l4ma+JnUovRonl+zXpy4GsZ3x/a4+rchoVePpWxAxg5spAtOQ2F4h1Gmf6SiAub7
	 QwiYYxt9hj+fB95VGyvL0441FQxZ1h6O+OYlAVMS6ug0pqt7/ZDHkL1ieLDf6t7bXM
	 E3x3Gj4QmHilw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b86f3e88d4dso7331866b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 09:20:12 -0800 (PST)
X-Gm-Message-State: AOJu0YxXFL1sWQl0tzOZ01OgiyESnjdKiW0aE/nN3nIztYAh2ZxyGZ8h
	ZvVvO7R3arvO0DO+GPJSp5QRWRmIqkxOxH+keqOKT8odhimo+v2Rx3GXiOCC/0dK4Nf+B6JQtdc
	nJeusEGNOM75gb2gV8XuQZcgV9SkUdeg=
X-Received: by 2002:a17:906:7944:b0:b7c:e4e9:b13f with SMTP id
 a640c23a62f3a-b8792f85b25mr1793566066b.39.1769016011034; Wed, 21 Jan 2026
 09:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768714131.git.wqu@suse.com> <dd1a7815d7993344949f5dda84f44ac083ea349b.1768714131.git.wqu@suse.com>
In-Reply-To: <dd1a7815d7993344949f5dda84f44ac083ea349b.1768714131.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 21 Jan 2026 17:19:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6fNT3POEke+Uiyj=4ez=23zvHWUacL1kkvPaCtZEUJHw@mail.gmail.com>
X-Gm-Features: AZwV_QhQUamChvXR50xZuuGVvMbMwcCQ-ZM1rKh_VB92tmrzSlEu41x4Z6GcDvY
Message-ID: <CAL3q7H6fNT3POEke+Uiyj=4ez=23zvHWUacL1kkvPaCtZEUJHw@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: add strict extent map alignment checks
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20863-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 49C9B5CC7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Jan 18, 2026 at 5:31=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently we do not check the alignment of extent_map structure.
>
> One of the reason is, the existing self tests for inode and extent-map
> will not pass.

The reasons are the inode and extent-map tests use unaligned values
for start offsets and lengths.

>
> However that test failure comes from two reasons:
>
> - We have invalid cases in the self tests
>   Those cases will be rejected by tree-checkers, and no one is really

by tree-checkers -> by the tree-checker

>   bothering removing the those cases, due to how hard to modify the test

the those cases -> those cases

>   cases.
>
> - Some test cases is always 4K block sized based but the fs_info is not

is always -> are always

>   properly initialized to reflect that
>
> Thankfully those legacy problems are properly addressed by previous
> patches, now we can finally put the alignment checks into
> validate_extent_map().
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_map.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 7e38c23a0c1c..07a7bd426c84 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -319,8 +319,15 @@ static void dump_extent_map(struct btrfs_fs_info *fs=
_info, const char *prefix,
>  /* Internal sanity checks for btrfs debug builds. */
>  static void validate_extent_map(struct btrfs_fs_info *fs_info, struct ex=
tent_map *em)
>  {
> +       const u32 blocksize =3D fs_info->sectorsize;
> +
>         if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
>                 return;
> +
> +       if (!IS_ALIGNED(em->start, blocksize) ||
> +           !IS_ALIGNED(em->len, blocksize))
> +               dump_extent_map(fs_info, "unaligned shared members", em);

What are shared members? I would say:  "unaligned start offset or
length members".

Thanks.


> +
>         if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
>                 if (em->disk_num_bytes =3D=3D 0)
>                         dump_extent_map(fs_info, "zero disk_num_bytes", e=
m);
> @@ -334,6 +341,11 @@ static void validate_extent_map(struct btrfs_fs_info=
 *fs_info, struct extent_map
>                         dump_extent_map(fs_info,
>                 "ram_bytes mismatch with disk_num_bytes for non-compresse=
d em",
>                                         em);
> +               if (!IS_ALIGNED(em->disk_bytenr, blocksize) ||
> +                   !IS_ALIGNED(em->disk_num_bytes, blocksize) ||
> +                   !IS_ALIGNED(em->offset, blocksize) ||
> +                   !IS_ALIGNED(em->ram_bytes, blocksize))
> +                       dump_extent_map(fs_info, "unaligned members", em)=
;
>         } else if (em->offset) {
>                 dump_extent_map(fs_info, "non-zero offset for hole/inline=
", em);
>         }
> --
> 2.52.0
>
>

