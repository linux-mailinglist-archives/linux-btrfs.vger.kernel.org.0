Return-Path: <linux-btrfs+bounces-21599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKY1M/MYi2ljPgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21599-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:39:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F011A537
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B61C3061459
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D3C2E764D;
	Tue, 10 Feb 2026 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ4KKJJn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0E31A56C
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723387; cv=none; b=csGYUZSlqyNpUrt4asGT0Oh+YUFWrav/gAIUWRKlP717oUX8IAsgYCtiEHEpCcCoedLWay412YWlQ1KNJdcCR6zW5Rqlbl+7EAp/VzGp06+RrwXs8S6litSc2YRmvFpvWE7Kzn8ze/jttKs6e6rtiqxfpzrowVTcJ/xdMbE1eno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723387; c=relaxed/simple;
	bh=XdPj9s8l6a3VJG79HdXpDoUt0xolgkHkGntsA1/sa1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6ku0E7OQndilvqI144DVYyj/wO5+LPaLK3+69ewyNfL58/yscKwqrnNp62VfHnyp0RlumCRdUUOWEZgp1UzN9kXgCvhROG+PSsbh1UOt1zB4/ebHT4ngMB8RkYR6w4enhqA+4IAT3fJ7qoSEQzowAKVffIgvsbiPCuGS5NzUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJ4KKJJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079BDC19424
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770723387;
	bh=XdPj9s8l6a3VJG79HdXpDoUt0xolgkHkGntsA1/sa1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tJ4KKJJndzF2ueaHt06yjIe+xgjcdWxL2Nw34zCSbJKPIiTWaoH7SsIvbQ8aKM+gP
	 XDBLzAAC0+dJet9pI66hn2YKiH6e/C4uwJy6z4ryEppdvnyrv+sY1HX2JVOXeB4bRO
	 rp25/vQ1tQMl3eEVKb2FUXsFvKBjwDJxVKSLxvRYWMOlhxI0jl7o0sXanNQF8lOHE5
	 ocNvruCcRTJtKLVGbZ3Tfwt8clcfV9MG9okhF2G+SXqlUtcDB5vgyql2D4nWVcJBXh
	 4e27ItkOzHVakWWf51rJ5paHLSEzXnmleI7Wi+PYF8ZaGUfGklezXyanY3UjOWPyj3
	 VYfnRTxbSmO9g==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8871718b05so893849966b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:36:26 -0800 (PST)
X-Gm-Message-State: AOJu0YyJ8Gme+ZRgoIzcz5JWO5TiUg7f/d8vRHXVjCHTxbncOQmnfg+9
	mN//O+EM24qKBJ/44JpXCjX6TDiBvxsy3d2Wb2LeCk6oA5ZpWyzV0K//ZcTPSqYX4z4ZgNonG+p
	elEVERAaUiGNnmIaWW5C8sKJwK1mLsRU=
X-Received: by 2002:a17:906:fe0e:b0:b72:70ad:b8f0 with SMTP id
 a640c23a62f3a-b8edf3410c3mr812329266b.36.1770723385551; Tue, 10 Feb 2026
 03:36:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210110423.264476-1-johannes.thumshirn@wdc.com> <20260210110423.264476-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20260210110423.264476-2-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Feb 2026 11:35:47 +0000
X-Gmail-Original-Message-ID: <CAL3q7H52GE9VCA6XFBs4BmL+rXb07fWoymCHoObXeJCUQbG5Jw@mail.gmail.com>
X-Gm-Features: AZwV_QjDRCXWPqztPpxH6eDTtabM1gBtVXxQDOIlsxR6Qzlm7Jp53wJWkpmikbo
Message-ID: <CAL3q7H52GE9VCA6XFBs4BmL+rXb07fWoymCHoObXeJCUQbG5Jw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btrfs: zoned: cap delayed refs metadata
 reservation to avoid overcommit
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21599-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4D5F011A537
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:04=E2=80=AFAM Johannes Thumshirn
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>
> If anyone's interested, if pushed the space_info analysis tool to:
> https://github.com/morbidrsa/debug-scripts/blob/master/analyze-space_info=
.py
> ---
>  fs/btrfs/delayed-ref.c | 28 ++++++++++++++++++++++++++++
>  fs/btrfs/transaction.c |  8 ++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index e8bc37453336..a4f968062fcd 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -207,6 +207,30 @@ void btrfs_dec_delayed_refs_rsv_bg_updates(struct bt=
rfs_fs_info *fs_info)
>   * This will refill the delayed block_rsv up to 1 items size worth of sp=
ace and
>   * will return -ENOSPC if we can't make the reservation.
>   */
> +static int btrfs_zoned_cap_metadata_reservation(struct btrfs_space_info =
*space_info)
> +{
> +       struct btrfs_fs_info *fs_info =3D space_info->fs_info;
> +       struct btrfs_block_rsv *block_rsv =3D &fs_info->delayed_refs_rsv;
> +       u64 usable;
> +       u64 cap;
> +       int ret =3D 0;
> +
> +       if (!btrfs_is_zoned(fs_info))
> +               return 0;
> +
> +       spin_lock(&space_info->lock);
> +       usable =3D space_info->total_bytes - space_info->bytes_zone_unusa=
ble;
> +       spin_unlock(&space_info->lock);
> +       cap =3D usable >> 1;
> +
> +       spin_lock(&block_rsv->lock);
> +       if (block_rsv->size > cap)
> +               ret =3D -EAGAIN;
> +       spin_unlock(&block_rsv->lock);
> +
> +       return ret;
> +}
> +
>  int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
>                                   enum btrfs_reserve_flush_enum flush)
>  {
> @@ -228,6 +252,10 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_in=
fo *fs_info,
>         if (!num_bytes)
>                 return 0;
>
> +       ret =3D btrfs_zoned_cap_metadata_reservation(space_info);
> +       if (ret)
> +               return ret;
> +
>         ret =3D btrfs_reserve_metadata_bytes(space_info, num_bytes, flush=
);
>         if (ret)
>                 return ret;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index aea84ac65ea7..746678044fed 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -678,6 +678,14 @@ start_transaction(struct btrfs_root *root, unsigned =
int num_items,
>                  * here.
>                  */
>                 ret =3D btrfs_delayed_refs_rsv_refill(fs_info, flush);
> +               if (ret =3D=3D -EAGAIN) {
> +                       ASSERT(btrfs_is_zoned(fs_info));
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

