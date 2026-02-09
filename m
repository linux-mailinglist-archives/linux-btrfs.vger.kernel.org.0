Return-Path: <linux-btrfs+bounces-21554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKkANuEQimlrGAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21554-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 17:52:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B9C112B05
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 17:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 058D5303A6FF
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE238553D;
	Mon,  9 Feb 2026 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA2BLNN8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73E3816EC
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655701; cv=none; b=ZmB87qvwf4GquuDRABG2ijiiWVJ7FWhiiht4LPLfdxS/Hf/HmcAF3uv7O5sTP34zqOJIDKMj4ObnnEGymW8SNP/f/MNOo3z8lywoN4AZBcibMf9ge7eMn4XXBV9KHyLjHnRi1O85teHiTVpg60im8X4f6LK36QihGhh5evu31U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655701; c=relaxed/simple;
	bh=YspohJCXJvUf0qG5GH10yXiAijhdnqh8DWH5XpfWIPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3j4UaF6ud7UWYWGanggg2MWOf2ji50rwgl3UqF6EL1UWzxeZP0z2jEz/kUwOIvC7n0Y9fR5Y//d6LdAtE1hVA3btuE2Jdn44cj+sa2LOOr6rSNr7kf1Sht7hp/pMZLlDUmq3RrkCExWvmLolTQwWtIPUmIIQSbxudjfyOb6oYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA2BLNN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D020BC19424
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770655700;
	bh=YspohJCXJvUf0qG5GH10yXiAijhdnqh8DWH5XpfWIPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IA2BLNN8xL93GmKExwdJq0+vAL4wio3Sqk4nQFJzdIucd+2KtfPrr75AJ8yU+liSh
	 KAiz1LiZR0yqvlMxHVULRQJ/NfWLPGc7WHISXZNCV9dljuLp4hBiPuGK6GUWYx6e6q
	 TvV8lxnjdqXGX3cmhBYGUlR3rPxBdSLGg7iFwHRorzwxsiXOYjT/BaJo6MNhsAoDOS
	 wTnkV5IuymoZbCS4af3dEx1tQcZ01WJtkKXXS4GOTzuP9wJOOjPRFfnPjyEdh1yJqL
	 0z11Z1e5BzZKcSJ76uRd9ge5er0yEFVw1qoR8U6z0oJtecrLktuZe3jcPLmzlIH9xD
	 pcK3A/Ocx+nkw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8837152db5so620485266b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 08:48:20 -0800 (PST)
X-Gm-Message-State: AOJu0Yy03KJU7nSzV4QXeGstrGiYRHhrE1iadQ4FFoo8slKDT4b7Bxzb
	WgxZQxyYnQFhQjl50IFZ/WfxDdR7k+lZOXJ0lZnYu5wKJa16ydwLNSQdDG4gZraDj5hea2Ro4sN
	CQRS0+1lOTFOEV6I6d39JcXqBrdNdap0=
X-Received: by 2002:a17:907:6d15:b0:b8e:3957:f0d5 with SMTP id
 a640c23a62f3a-b8edf1ea5f1mr629528266b.25.1770655699320; Mon, 09 Feb 2026
 08:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209143644.96411-1-johannes.thumshirn@wdc.com> <20260209143644.96411-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20260209143644.96411-2-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Feb 2026 16:47:41 +0000
X-Gmail-Original-Message-ID: <CAL3q7H43xOoRNwRrCypsoK--=yt1CtYZcVUG77tQqgUgsr0ULA@mail.gmail.com>
X-Gm-Features: AZwV_Qg1TaEey0buLhx28GOoBevt0KjtSSs4ksfGX110A-_Jq6wGmX263EY5l1s
Message-ID: <CAL3q7H43xOoRNwRrCypsoK--=yt1CtYZcVUG77tQqgUgsr0ULA@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: zoned: cap delayed refs metadata reservation
 to avoid overcommit
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
	TAGGED_FROM(0.00)[bounces-21554-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 36B9C112B05
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 2:46=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> On zoned filesystems metadata space accounting can become overly optimist=
ic
> due to delayed refs reservations growing without a hard upper bound.
>
> The delayed_refs_rsv block reservation is allowed to speculatively grow a=
nd
> is only backed by actual metadata space when refilled. On zoned devices t=
his
> can result in delayed_refs_rsv reserving a large portion of metadata spac=
e
> that is already effectively unusable due to zone write pointer constraint=
s.
> As a result, space_info->may_use can grow far beyond the usable metadata
> capacity, causing the allocator to believe space is available when it is =
not.
>
> This leads to premature ENOSPC failures and "cannot satisfy tickets" repo=
rts
> even though commits would be able to make progress by flushing delayed re=
fs.
>
> Analysis of "-o enospc_debug" dumps using a Python debug script
> confirmed that delayed_refs_rsv was responsible for the majority of
> metadata overcommit on zoned devices. By correlating space_info counters
> (total, used, may_use, zone_unusable) across transactions, the analysis
> showed that may_use continued to grow even after usable metadata space
> was exhausted, with delayed refs refills accounting for the excess
> reservations.
>
> Here's the output of the analysis:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Space Type: METADATA
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   Raw Values:
>     Total:                256.00 MB (268435456 bytes)
>     Used:                 128.00 KB (131072 bytes)
>     Pinned:                16.00 KB (16384 bytes)
>     Reserved:             144.00 KB (147456 bytes)
>     May Use:              255.48 MB (267894784 bytes)
>     Zone Unusable:        192.00 KB (196608 bytes)
>
>   Calculated Metrics:
>     Actually Usable:       255.81 MB (total - zone_unusable)
>     Committed:             255.77 MB (used + pinned + reserved + may_use)
>     Consumed:              320.00 KB (used + zone_unusable)
>
>   Percentages:
>     Zone Unusable:    0.07% of total
>     May Use:         99.80% of total
>
> Fix this by adding a zoned-specific cap in btrfs_delayed_refs_rsv_refill(=
):
> Before reserving additional metadata bytes, limit the delayed refs
> reservation based on the usable metadata space (total bytes minus
> zone_unusable). If the reservation would exceed this cap, return -EAGAIN
> to trigger the existing flush/commit logic instead of overcommitting
> metadata space.
>
> This preserves the existing reservation and flushing semantics while
> preventing metadata overcommit on zoned devices. The change is limited to
> metadata space and does not affect non-zoned filesystems.
>
> This patch addresses premature metadata ENOSPC conditions on zoned device=
s
> and ensures delayed refs are throttled before exhausting usable metadata.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>
> If anyone's interested, if pushed the space_info analysis tool to:
> https://github.com/morbidrsa/debug-scripts/blob/master/analyze-space_info=
.py
> ---
>  fs/btrfs/delayed-ref.c | 26 ++++++++++++++++++++++++++
>  fs/btrfs/transaction.c |  7 +++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index e8bc37453336..dc6a2685a5da 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -207,6 +207,28 @@ void btrfs_dec_delayed_refs_rsv_bg_updates(struct bt=
rfs_fs_info *fs_info)
>   * This will refill the delayed block_rsv up to 1 items size worth of sp=
ace and
>   * will return -ENOSPC if we can't make the reservation.
>   */
> +static int btrfs_zoned_cap_metadata_reservation(struct btrfs_space_info =
*space_info,
> +                                               struct btrfs_block_rsv *b=
lock_rsv)

Can we simplify and not pass the block reserve?
This is meant only for delayed refs rsv, so in the function we can
just access fs_info->delayed_refs_rsv.

> +{
> +       struct btrfs_fs_info *fs_info =3D space_info->fs_info;
> +       u64 usable;
> +       u64 cap;
> +
> +       if (!btrfs_is_zoned(fs_info))
> +               return 0;
> +
> +       if (!(space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
> +               return 0;

Removing the need for this check too, since the delayed refs rsv is metadat=
a.

> +
> +       usable =3D space_info->total_bytes - space_info->bytes_zone_unusa=
ble;

This should be done while holding the space_info's lock, otherwise it's rac=
y.

> +       cap =3D div_u64(usable, 2);

Could also be: usable >> 1
And then directly used below and eliminate the need for the variable.

> +
> +       if (block_rsv->size > cap)

Same as above, racy, the block reserve is not locked.

> +               return -EAGAIN;
> +
> +       return 0;
> +}
> +
>  int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
>                                   enum btrfs_reserve_flush_enum flush)
>  {
> @@ -228,6 +250,10 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_in=
fo *fs_info,
>         if (!num_bytes)
>                 return 0;
>
> +       ret =3D btrfs_zoned_cap_metadata_reservation(space_info, block_rs=
v);
> +       if (ret)
> +               return ret;
> +
>         ret =3D btrfs_reserve_metadata_bytes(space_info, num_bytes, flush=
);
>         if (ret)
>                 return ret;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 0b2498749b1e..422c967a0916 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -678,6 +678,13 @@ start_transaction(struct btrfs_root *root, unsigned =
int num_items,
>                  * here.
>                  */
>                 ret =3D btrfs_delayed_refs_rsv_refill(fs_info, flush);
> +               if (ret =3D=3D -EAGAIN) {

Probably make it explicit this is expected for zoned only, adding an
ASSERT(btrfs_is_zoned(fs_info)).

Otherwise it looks fine to me, thanks.


> +                       ret =3D btrfs_commit_current_transaction(root);
> +                       if (ret)
> +                               goto reserve_fail;
> +                       ret =3D btrfs_delayed_refs_rsv_refill(fs_info, fl=
ush);
> +               }
> +
>                 if (ret)
>                         goto reserve_fail;
>         }
> --
> 2.53.0
>
>

