Return-Path: <linux-btrfs+bounces-21592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH7nJGEIi2kdPQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21592-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:28:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52794119A78
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC5123020E9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F535E52C;
	Tue, 10 Feb 2026 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFHqsp+D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5095333F8B3
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719326; cv=none; b=celhLAJF2IVoAGsOLee4dbWm9DSEcO/Zepw9PvcimDhaYNOLEg/dGZxzE9l37ZSdV95f8EAyS4VUiyMaQ0YlmcEHrf7/AL1A463Vh52YV0k7EhnBxKFE6xvWc0ZDlLyhRjfQop7h4S3E0iMkxvBSZ9lCeIOv4dF7eL5aMriJu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719326; c=relaxed/simple;
	bh=/cwjQLkm6ULxN27DNGH/37yh6EIdSfoD1v4b+IKoEWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svNQYh0KDBr3KNoM/z3bgE9lLOBD1OvtSLG1q7PVpE6bNiY/xoztTFFkP3FRTvPlcUloW8727BvJp8M6vXFHWw+LiZZtWkvRaGMxHlMhTGOdVu9gg5JcNq/27sVs+yQTcikPTFVOk7W/r9wH3y65X4OQ8oYK3jzlTy7trxkps64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFHqsp+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21C0C19423
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770719325;
	bh=/cwjQLkm6ULxN27DNGH/37yh6EIdSfoD1v4b+IKoEWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PFHqsp+Dhd34otAir8bG4pQ7Dm/8ctOaMsiwzJbZuqwZhnPa5IJIUBYrpkHJ2GXmZ
	 dFUtLK/Bh6sxWzdKX/am7xnt4VeKSWuUASPiEnb7RQuQe2RaqqbVshrJXw2bGWcgkj
	 J5bVzDuCUISVeAr2wtqLrto/u4eSAMoLIRLzwUX3E4SDdn8tJEbIclg+pyx4tkwhmT
	 4KjvW+ktB8lXvs4VyySL6trhDSvRpfsSKEBagJozR+rU3f3DDaKallpIRl9+/kAtOf
	 FVsUeYclslTZbCwu/2kpu/1+g6+TedAzWKEUk73FrQPW6Ndzug4D8nwnzMh+RwIP6t
	 5OfPOqzYkhgCg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b86ed375d37so70519566b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 02:28:45 -0800 (PST)
X-Gm-Message-State: AOJu0YyUaR6R44+7I62zTlZpoBoC4txYnjKxM5XZ5W5ExSMNX3h03aLR
	MdRJCTufHXa07toilrieDiW8wEV4h+vKIcrreTw2pBaNqbQbxCqs38ajFxr+cji0T9Gu6+xxekZ
	nL5flRdLoiWYOT32t59GRNBWgQ7Ljtw0=
X-Received: by 2002:a17:907:6ea2:b0:b87:1741:a484 with SMTP id
 a640c23a62f3a-b8edf377b19mr847711266b.43.1770719324447; Tue, 10 Feb 2026
 02:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210073309.195274-1-johannes.thumshirn@wdc.com> <20260210073309.195274-4-johannes.thumshirn@wdc.com>
In-Reply-To: <20260210073309.195274-4-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Feb 2026 10:28:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H50nU4WwPRP74Q9S1nktXKwiwm0SFys-VqQbWdzQh1YMw@mail.gmail.com>
X-Gm-Features: AZwV_QihpDgc7O0HQaNr9t1osbIQdrCmp7wiR6qq4OU6xaPCqwvC9dPpuxqgsqQ
Message-ID: <CAL3q7H50nU4WwPRP74Q9S1nktXKwiwm0SFys-VqQbWdzQh1YMw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] btrfs: zoned: add zone reclaim flush state for
 DATA space_info
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21592-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52794119A78
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 7:34=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> On zoned block devices, DATA block groups can accumulate large amounts
> of zone_unusable space (space between the write pointer and zone end).
> When zone_unusable reaches high levels (e.g., 98% of total space), new
> allocations fail with ENOSPC even though space could be reclaimed by
> relocating data and resetting zones.
>
> The existing flush states don't handle this scenario effectively - they
> either try to free cached space (which doesn't exist for zone_unusable)
> or reset empty zones (which doesn't help when zones contain valid data
> mixed with zone_unusable space).
>
> Add a new RECLAIM_ZONES flush state that triggers the block group
> reclaim machinery. This state:
> - Calls btrfs_reclaim_sweep() to identify reclaimable block groups
> - Calls btrfs_reclaim_bgs() to queue reclaim work
> - Waits for reclaim_bgs_work to complete via flush_work()
> - Commits the transaction to finalize changes
>
> The reclaim work (btrfs_reclaim_bgs_work) safely relocates valid data
> from fragmented block groups to other locations before resetting zones,
> converting zone_unusable space back into usable space.
>
> Insert RECLAIM_ZONES before RESET_ZONES in data_flush_states so that
> we attempt to reclaim partially-used block groups before falling back
> to resetting completely empty ones.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/space-info.c | 22 ++++++++++++++++++++++
>  fs/btrfs/space-info.h |  1 +
>  2 files changed, 23 insertions(+)
>
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 243b2593d4bc..b174c68a5ebb 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -129,6 +129,15 @@
>   *     churn a lot and we can avoid making some extent tree modification=
s if we
>   *     are able to delay for as long as possible.
>   *
> + *   RECLAIM_ZONES
> + *     This state only works for the zoned mode. In zoned mode, we canno=
t reuse
> + *     regions that have once been allocated and then been freed until w=
e reset
> + *     the zone, due to the sequential write requirement. The RECLAIM_ZO=
NES state
> + *     calls the reclaim machinery, evacuating the still valid data in t=
hese
> + *     block-groups and relocates it to the data_reloc_bg. Afterwards th=
ese
> + *     block-groups get deleted and the transaction is committed. This f=
rees up
> + *     space to use for new allocations.
> + *
>   *   RESET_ZONES
>   *     This state works only for the zoned mode. On the zoned mode, we c=
annot
>   *     reuse once allocated then freed region until we reset the zone, d=
ue to
> @@ -905,6 +914,18 @@ static void flush_space(struct btrfs_space_info *spa=
ce_info, u64 num_bytes,
>                 if (ret > 0 || ret =3D=3D -ENOSPC)
>                         ret =3D 0;
>                 break;
> +       case RECLAIM_ZONES:
> +               if (btrfs_is_zoned(fs_info)) {
> +                       btrfs_reclaim_sweep(fs_info);
> +                       btrfs_delete_unused_bgs(fs_info);
> +                       btrfs_reclaim_bgs(fs_info);
> +                       flush_work(&fs_info->reclaim_bgs_work);
> +                       ASSERT(current->journal_info =3D=3D NULL);
> +                       ret =3D btrfs_commit_current_transaction(root);
> +               } else {
> +                       ret =3D 0;
> +               }
> +               break;
>         case RUN_DELAYED_IPUTS:
>                 /*
>                  * If we have pending delayed iputs then we could free up=
 a
> @@ -1403,6 +1424,7 @@ static const enum btrfs_flush_state data_flush_stat=
es[] =3D {
>         FLUSH_DELALLOC_FULL,
>         RUN_DELAYED_IPUTS,
>         COMMIT_TRANS,
> +       RECLAIM_ZONES,
>         RESET_ZONES,
>         ALLOC_CHUNK_FORCE,
>  };
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 6f96cf48d7da..174b1ecf63be 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -113,6 +113,7 @@ enum btrfs_flush_state {
>         RUN_DELAYED_IPUTS       =3D 10,
>         COMMIT_TRANS            =3D 11,
>         RESET_ZONES             =3D 12,
> +       RECLAIM_ZONES           =3D 13,
>  };
>
>  enum btrfs_space_info_sub_group {
> --
> 2.53.0
>
>

