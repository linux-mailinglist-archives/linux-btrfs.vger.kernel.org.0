Return-Path: <linux-btrfs+bounces-21590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHLLErcHi2kdPQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21590-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:25:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45B119A29
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5605F3015BAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD835F8A1;
	Tue, 10 Feb 2026 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSIB1Aao"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655933F8B3
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719154; cv=none; b=LTtyEyeieM4P9V+1mkSg77l6njzzVEXEJg9uAFtKwFkta4TgO53Ejshttf9cIHHzZLiYqbRdRn5XNWN0Ih87K1o6Gm28yfdmWOS9dCTmC2brRN750W5FgSWKoj7caMiVXJGUCbTaBPrORhxESbsnIZmeZo17OnrXlSH5QfQWJS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719154; c=relaxed/simple;
	bh=RpF83YjKi7AkLfgA+KURmvCRr0ZxUVMPhYdo7ZYxGYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmaWJQhwRZMEJxEE9U4f3M1eIMdjj6k6+4tWGpktMlTni+M9jgBnsyFs3KdS34zqUPKERQlUse2t+Dl3bLABlzi/3RTvGIk+FVfbQdiYhvpV3Kty6RJTXcAe3PUuVLjZ1juoiSaoXf6mu1NoYMFAlbi9WqUMLn8mgB3Wx4YjbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSIB1Aao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DC5C16AAE
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770719153;
	bh=RpF83YjKi7AkLfgA+KURmvCRr0ZxUVMPhYdo7ZYxGYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VSIB1Aao3O6BfbhB05XJaZUMHkw6yf9CVjByl1WIc6NAiJIzqiTDRrqtQS/dfMONJ
	 t8YJe3sw8svcnv/1YcG8uw8fE08OsVhQ3VOmRepPn2XlNZOF0NCrwPneGkj7/mPDvR
	 jU1pmfB6UesJ2tS2WS6MlC7e714wiZXhg/Q1jbdymBPWY6gtdN5VikzBZK+kXzTgRw
	 18/lY4mph4QTgp/wzyXXi1poT7TWL0GJuENbYNib/BbNW2hdslAT5oX8uHkDnj0tWp
	 m0oPSpM2bKS1azOFPnbCAhntC3zvN0B0TOfutak/RlcHCq+WcG4mNSHohMQ/g8BYjK
	 HIl/h4gIMpm7w==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b885e8c6727so643117966b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 02:25:53 -0800 (PST)
X-Gm-Message-State: AOJu0YxcI1BTt63i7b7DZYRw9qQAMHbzikXfDKDUCcUYUZlMwvD1lQZ6
	ZfBWrCbMH7fjTvIlC3FCR9mQqLTjsGijV5TJYyF9aLp5h7EEkgNJ4j8/9/NiyT0+YmhWrH46irS
	aeLpMaeog0/Y8KiaJ3aybmU7Y7yUPa1I=
X-Received: by 2002:a17:906:7303:b0:b88:5a61:5461 with SMTP id
 a640c23a62f3a-b8f509d580emr123150766b.2.1770719152182; Tue, 10 Feb 2026
 02:25:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210073309.195274-1-johannes.thumshirn@wdc.com> <20260210073309.195274-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20260210073309.195274-2-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Feb 2026 10:25:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4Rx4L_vqWbntOfdCO6aTSkTbogDFgO__RV5V6EUUmYvw@mail.gmail.com>
X-Gm-Features: AZwV_QibMIKdXPnHcygrYXFikOoTzoUO0it-3rdz7Zq2_WVM9rxwymrUm4Bul-s
Message-ID: <CAL3q7H4Rx4L_vqWbntOfdCO6aTSkTbogDFgO__RV5V6EUUmYvw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] btrfs: zoned: cap delayed refs metadata
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21590-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0C45B119A29
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 7:34=E2=80=AFAM Johannes Thumshirn
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
>  fs/btrfs/transaction.c |  8 ++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index e8bc37453336..3a7ace7b3044 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -207,6 +207,28 @@ void btrfs_dec_delayed_refs_rsv_bg_updates(struct bt=
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
> +       cap =3D usable >> 1;
> +
> +       if (block_rsv->size > cap)

Same comment as before. The block reserve is not locked, tools like
KCSAN will report a data race here.
Either lock it, or use data_race() - though we would be vulnerable to
load/store tearing and with very bad luck still trigger the ENOSPC.

Otherwise it looks good, thanks.

> +               ret =3D -EAGAIN;
> +       spin_unlock(&space_info->lock);
> +
> +       return ret;
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

