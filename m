Return-Path: <linux-btrfs+bounces-21591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DzZEzUIi2kdPQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21591-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:28:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDB7119A71
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4526A3033ABC
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 10:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB235E52C;
	Tue, 10 Feb 2026 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIKSro96"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646033F8B3
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719269; cv=none; b=EfOX0nibb1FzLkYRGVeKO+z85stc66kY8eyRO5WzBKMppiLOdFdOPtJfomQbKHNdnFSSjpTaUhSi9Xa55TcQ9WFeC/TnS/h8yAsSrojlZA9IF5sRX8ZrnvdbjelYhNwz1rF0lgTTFo2mXIXQvis38b7Uejf1x+0uYUpU4dhK2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719269; c=relaxed/simple;
	bh=Q5gtmB7O2Ty5F/2J90F71rjYwd6p6FglpD8c7k55Tpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAjSW8K0MTbWAJ0nG1lVdsALBl4H/JEeL9A6YKQHB97xO3yy+iO+bhgIBvUhSby0fMcWj3yYzVEFE9QESClPXqSWD3cFQhj9kbCrlMKyt9ujyVThCWm4nnFEQD+sxTeP1JBgUatk0w5bgidB1zC1/W2vcjvtQ4apAbn2X6KCFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIKSro96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BB0C16AAE
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 10:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770719268;
	bh=Q5gtmB7O2Ty5F/2J90F71rjYwd6p6FglpD8c7k55Tpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sIKSro96mZt84fOkwAAGZmQsV1zdstilEu8JBRVJzf41JlUtPL68oy4IN+zDk3Von
	 Cialb4i+U2XUZQVno3Soi8noAEITm9LU10q432IxdQNJzcgIiOdg60Sq94NkUscxdZ
	 Gx78Q33k5q7SoA0f1hpGA/DjTF+b12DvogZNJqpQTxFDu0d+0vtFoH/GAgMwBsg00P
	 CsFjmKjyytk/4xeYFkIlBb4QX/Z+XuhlfVhn8PBYvNCZUl/YzRfNa6HlhMYyvQYmjR
	 xK8AnJ75vqPNR7EHaaGirVMJX1Od5wJs4WUsgIdHmRCLbkfUkZrob7oL4kri7mquXB
	 Oq6eCPmXyAfaA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so122097366b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 02:27:48 -0800 (PST)
X-Gm-Message-State: AOJu0YynFI18A2qgYau5udb7YyHqA3sd6bBiysAE4T7msvf02GQZ33xe
	ZBtujCDOhPJkmNd0BLJR1eh+evHYLo8IY+6lmlbbmewg5L+ypZJvyTAPtzAbb6b9zbhuMoV4g9u
	4NpjLZJrEotLwutFxYB9hiuS13is9xNc=
X-Received: by 2002:a17:907:c0e:b0:b87:d186:19e3 with SMTP id
 a640c23a62f3a-b8edf3d50camr930074966b.43.1770719266795; Tue, 10 Feb 2026
 02:27:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210073309.195274-1-johannes.thumshirn@wdc.com> <20260210073309.195274-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20260210073309.195274-3-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Feb 2026 10:27:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4BB6M-Sv+rKovbMMSH9jiiTwLrQ+M+5vtWrVYiuY3qJg@mail.gmail.com>
X-Gm-Features: AZwV_QjrA0EOA2BrZPNl_dBozbk6CPOeqdbhEGFcb8Ve2Mf0EPRunDqYERk7nxs
Message-ID: <CAL3q7H4BB6M-Sv+rKovbMMSH9jiiTwLrQ+M+5vtWrVYiuY3qJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] btrfs: zoned: move partially zone_unusable block
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
	TAGGED_FROM(0.00)[bounces-21591-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DCDB7119A71
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 7:34=E2=80=AFAM Johannes Thumshirn
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/block-group.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 764caaf1d8b2..e3e7852dd3e0 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1597,6 +1597,24 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info =
*fs_info)
>
>                 spin_lock(&space_info->lock);
>                 spin_lock(&block_group->lock);
> +
> +               if (btrfs_is_zoned(fs_info) && btrfs_is_block_group_used(=
block_group) &&
> +                   block_group->zone_unusable >=3D div_u64(block_group->=
length, 2)) {
> +                       /*
> +                        * If the block group has data left, but at least=
 half
> +                        * of the block group is zone_unusable, mark it a=
s
> +                        * reclaimable before continuing with the next bl=
ock group.
> +                        */
> +
> +                       spin_unlock(&block_group->lock);
> +                       spin_unlock(&space_info->lock);
> +                       up_write(&space_info->groups_sem);
> +
> +                       btrfs_mark_bg_to_reclaim(block_group);
> +
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

