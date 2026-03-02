Return-Path: <linux-btrfs+bounces-22141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMmpG9NmpWmx+wUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22141-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:30:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FBD1D687F
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 811943038F3B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 10:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3867E396B85;
	Mon,  2 Mar 2026 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjczVriB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D532D7C7
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446954; cv=none; b=VX4QooduSHglC3dsl9+d1P9P7d8+J9G8nB77p2fk71ZXvwNmjaYVPUUgdNgQrM5TBiTck2s6CfBH0HS5WwB9JXL+94pNJdav2yGR26YZW8V2L201b6Itb91MKucnww+vs11TAQ8NvjL/RNPh/5L+vKJP6KaAJlHVkjms4VFbHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446954; c=relaxed/simple;
	bh=sFOpUD/a3jUYf91Z2FTa0KJClF2QnroFc7/nuRdPP7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHpy59nYDR6gJDJ80g2omS97mV0NDxNMnufxsYNm33FF97JCCvRczYwx4mPqXZvE4t4D65oHAzFb4QZC/w9YdSquCxq1ha3tFHdGzYZ8lqpwLMybnPrR3xq4ZQTpSXBPBBmvR5XWFSo3fT57h8W+YLD2Zu3yYPr8uRg9hPCqulw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjczVriB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632B2C19423
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772446954;
	bh=sFOpUD/a3jUYf91Z2FTa0KJClF2QnroFc7/nuRdPP7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VjczVriBeYo5rs3InGan6VN2ptBBfvLaViVRhCNmN52Yn7BLjyloXIY59dL+H/yiN
	 8VrRdnbcxynhktFeRRmXtUZmPO/j8t70U/56AFHJqZGyg5YBXKK/RhQb02RN5Jm1gY
	 inMFQiUZkmibsji0rABSjyTN8tlVzVjs0TP2+e3eQhwK11NGhNk+yOe+xmAK+9lwO8
	 kRZLJ6oXTq4KU3dE34OKApI5epnoMUITQK9F3Hd1fClVjdprA6CImstnQYH+En2bGb
	 16n31o56m5u9lW46eIiBDkG+S3f0yns6SvwMiqZw0tb6A7pOFgL+ymaeEVW8o4/p7Q
	 bTj9smWmGwPlw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9381e78a31so421825966b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2026 02:22:34 -0800 (PST)
X-Gm-Message-State: AOJu0YzEu/4JUIszSYEqAstG/NLZOXnvgl1z7p7MmZ4SXGrbxIfEcY8J
	2gZEIJhShtGF8ln4fQgDqbYZraxn6TMlpPShELHr7Pdhm/bC/aEDCTgU69vXrfBkfU5q+XlZA8s
	wx+HGtbce5ICylPtXsAZ3c9Y/kiEN+/M=
X-Received: by 2002:a17:907:1b1d:b0:b93:c5a9:a5e4 with SMTP id
 a640c23a62f3a-b93c5a9ba08mr18854366b.5.1772446952875; Mon, 02 Mar 2026
 02:22:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227131224.159801-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260227131224.159801-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Mar 2026 10:21:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4_U2VHZUdKLb7qCXwwcFTsFUDZFuA6Qsy8umDGTNrYBw@mail.gmail.com>
X-Gm-Features: AaiRm52CAAh7SxMm88HQmxN-ne0NoDus03pXUi1yjBnEMl0RB-yVOQXDebDfssI
Message-ID: <CAL3q7H4_U2VHZUdKLb7qCXwwcFTsFUDZFuA6Qsy8umDGTNrYBw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: pass 'verbose' parameter to btrfs_relocate_block_group
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22141-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: B5FBD1D687F
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 1:14=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Function `btrfs_relocate_chunk()` always passes verbose=3Dtrue to
> `btrfs_relocate_block_group()` instead of the `verbose` parameter passed
> into it by it's callers.
>
> While user initiated rebalancing should be logged in the Kernel's log
> buffer. This causes excessive log spamming from automatic rebalancing,
> e.g. on zoned filesystems running low on usable space.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/volumes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c0cf8f7c5a8e..95accc9361bd 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3595,7 +3595,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_i=
nfo, u64 chunk_offset, bool v
>
>         /* step one, relocate all the extents inside this chunk */
>         btrfs_scrub_pause(fs_info);
> -       ret =3D btrfs_relocate_block_group(fs_info, chunk_offset, true);
> +       ret =3D btrfs_relocate_block_group(fs_info, chunk_offset, verbose=
);
>         btrfs_scrub_continue(fs_info);
>         if (ret) {
>                 /*
> --
> 2.53.0
>
>

