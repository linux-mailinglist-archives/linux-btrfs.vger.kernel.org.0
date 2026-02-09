Return-Path: <linux-btrfs+bounces-21555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEHOBAkTimlrGAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21555-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:02:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B46D6112D04
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBBA23032F60
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AFD385530;
	Mon,  9 Feb 2026 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p54Q04MG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986CA1DFD96
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656248; cv=none; b=atMTMGERhkPepYT6DCIT/iiv8rGSjO39NwwA8/y0owT7YnsCpFoRgTroxuVE+3LmfAVNl9LeSsKj3DSlIqkTAtd/qqwMqPY3fvAr6OEE4FbNwrOIqL5I45OaNAkGIiQTkrRz71PgmTfyUq+/YXYDzOcfAn4UWKQILfxfUV+rDmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656248; c=relaxed/simple;
	bh=odlXy3uLcA4NQOQnzVIbyhOIli6uC4K8IVOGZNVWU04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAoKQkz/z5xeY4o7Qn8O1MHfEw743T8pr/e1e9M9o1q+LNK1TJXck8Ipnrm6zEGRs5kwNQE/BF4BzPpPrX2GLsI4KPi+lYxnUhEJYMmJGl85upO6Ss+qbfMMWwhsAsYII2UMFI+ZAgSI3M6VrXauNbitcCX3U6NKrHoS3Qbfr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p54Q04MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2803FC4AF0B
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770656248;
	bh=odlXy3uLcA4NQOQnzVIbyhOIli6uC4K8IVOGZNVWU04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p54Q04MGUFQ10hfSykcmlyQwWkJCFhF5LCOkbBAdTa3EhZzETPHsmexBAAz+vA2uL
	 f7Wtarh9kyVsUNs/t9UYuqfxtEQnYaHuk752XbIIYTPcYhNNJhY/pa9eCnDd0xSRtS
	 QPesR1pL7y3glExaAS9O28flH6RP6sldDu1oy+INbTgtu421dStIHu/ecwx6N9bKs+
	 E+dxcLh8GXWK1ITKHdw/66SjWJfS92fmLu02bryXXXEzhjtBX4cpvWdCP1pFMmbDyk
	 CD1T6PLCp4dihZinN7xWNmY8F5ycLedhVr6GrkqWhl26T/rjS6sTKJZEVBXsgzHCHm
	 DhcTYnEY8Qr/Q==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so4034613a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 08:57:28 -0800 (PST)
X-Gm-Message-State: AOJu0YyUg6dO36NkeCcnNip3LOGwvk/01uwGef3jWX0N35l820PFxE7u
	DWBdY5UdfIALSPBOgDtG7sZ3JtkURGdIMvvvrJlpXICnvVdiiMfnuO2nza851pdbfS474SxDZLh
	H2PGvDAJ9puHGmnE+IDtfd0KXLUKrEGs=
X-Received: by 2002:a17:907:940a:b0:b88:448c:be08 with SMTP id
 a640c23a62f3a-b8edf14f46dmr707077366b.5.1770656246740; Mon, 09 Feb 2026
 08:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209143644.96411-1-johannes.thumshirn@wdc.com> <20260209143644.96411-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20260209143644.96411-3-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Feb 2026 16:56:49 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7c9UrfgS3LayY4GEVSjFd+XkwPJMPXZSavi3Hi6Rf6Pw@mail.gmail.com>
X-Gm-Features: AZwV_Qgm27zbFK-AMxK0uvcfQxQ7bE5zbiJn5YyqJ7r159F1cZ6pSZWo8vPgmWE
Message-ID: <CAL3q7H7c9UrfgS3LayY4GEVSjFd+XkwPJMPXZSavi3Hi6Rf6Pw@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: zoned: move partially zone_unusable block
 groups to reclaim list
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Christoph Hellwig <hch@lst.de>, Hans Holmberg <Hans.Holmberg@wdc.com>, Boris Burkov <boris@bur.io>, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21555-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B46D6112D04
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 2:38=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> On zoned block devices, block groups accumulate zone_unusable space
> (space between the write pointer and zone end that cannot be allocated
> until the zone is reset). When a block group becomes mostly
> zone_unusable but still contains some valid data and it gets added to the
> unused_bgs list it can never be deleted because it's not actually empty.
>
> The deletion code (btrfs_delete_unused_bgs) skips these block groups
> due to the btrfs_is_block_group_used() check, leaving them on the
> unused_bgs list indefinitely. This causes two problems:
> 1. The block groups are never reclaimed, permanently wasting space
> 2. Eventually leads to ENOSPC even though reclaimable space exists
>
> Fix by detecting block groups where zone_unusable exceeds 50% of the
> block group size. Move these to the reclaim_bgs list instead of
> skipping them. This triggers btrfs_reclaim_bgs_work() which:
> 1. Marks the block group read-only
> 2. Relocates the remaining valid data via btrfs_relocate_chunk()
> 3. Removes the emptied block group
> 4. Resets the zones, converting zone_unusable back to usable space
>
> The 50% threshold ensures we only reclaim block groups where most space
> is unusable, making relocation worthwhile. Block groups with less
> zone_unusable are left on unused_bgs to potentially become fully empty
> through normal deletion.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 3186ed4fd26d..1fb23834d90c 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1597,6 +1597,22 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info =
*fs_info)
>
>                 spin_lock(&space_info->lock);
>                 spin_lock(&block_group->lock);
> +
> +               if (btrfs_is_zoned(fs_info) && btrfs_is_block_group_used(=
block_group) &&
> +                   block_group->zone_unusable > div_u64(block_group->len=
gth, 2)) {
> +                       /*
> +                        * If the block group has data left, but at least=
 half

The comment says "at least half", but in the code below we check if
more than half.
So either adjust here or change the code above from ">" to ">=3D".

> +                        * of the block group is zone_unusable, mark it a=
s
> +                        * reclaimable before continuing with the next bl=
ock group.
> +                        */
> +                       btrfs_mark_bg_to_reclaim(block_group);

We could avoid adding a locking dependency and call this below after
unlocking the bg, space_info and groups_sem.

Otherwise it looks fine, thanks.

> +
> +                       spin_unlock(&block_group->lock);
> +                       spin_unlock(&space_info->lock);
> +                       up_write(&space_info->groups_sem);
> +                       goto next;
> +               }
> +
>                 if (btrfs_is_block_group_used(block_group) ||
>                     (block_group->ro && !(block_group->flags & BTRFS_BLOC=
K_GROUP_REMAPPED)) ||
>                     list_is_singular(&block_group->list) ||
> --
> 2.53.0
>
>

