Return-Path: <linux-btrfs+bounces-21556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LLyB+8TimlrGAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21556-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:05:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4085D112D92
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 18:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A27B309C40F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ED13859D0;
	Mon,  9 Feb 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGFVUw63"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CB3859C7
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656389; cv=none; b=DbRyt2Q1HYh2oeZNcC3u6zLQIeitEZLfKOCHeMu6ZW16LkcqqT9S0GmlF+EmpphsipBgwUBzz5lBw8GFa0b93vFtAPMd8x13LB5FLT6tBlhpWNZvpWyXdaJYevbm5yLJM21aZ//KU++2zLc5LHfe8/wdyO3XvVeddrWSsYl/80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656389; c=relaxed/simple;
	bh=zk/9xQ56vKGyuouFFrLdH4bua+/BZ0tF8KJGQ/BCCWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSqJ1b32YpizOfmYPu8P+bTCytLo6XmqiR44HLYbXv4635AlLpv+4mZeQlX+7cyGspG2+e6fxO+4CQhNPKlXPlGfFhmHP6Pwvps+bI2NxBFOb0jjzWpKzLbdIsqTjQgigj1TGYnVEyXuCraYp6YEQDATVfOrCNYUh3Fp3wXtUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGFVUw63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6E0C19424
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770656389;
	bh=zk/9xQ56vKGyuouFFrLdH4bua+/BZ0tF8KJGQ/BCCWs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PGFVUw63+TSasKV86tSDxAykzOLLAJroWuWCv9D9Anpuc5q/zmR5MxElh3ePD80FA
	 1VWXHW16Mx7wFC+Yqi9Mh51Cafk38Ya/jMHdnR2g0b0XpKnni0Acu2+vbE0HyFsY7F
	 wnjOK+V80WZ35Cx51bTB+MFmA+mPcLLaWBWQkALNpglEhOTZ8l0o9df9zRnbm1zUDw
	 vZOsVlCaToR0SdClQqBZS/gKG3uYuJkJ8+Ud9BJjwv7f2LncpFPcGlH1VbdyCJn/np
	 gyBCeaJjITK166aIgHKPncug6W7Qa8RuV/X+tdPtrirwRdSeXNcEvP8MX/M0OGh34B
	 E2BW6egeJS2gA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b883787268fso504027466b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 08:59:49 -0800 (PST)
X-Gm-Message-State: AOJu0YxQ26Jc2HOy6ECsq+1Z0rs9drGUCK7YexhKlJ+rUZ+U2Dujkwmy
	o3+hwyJF/upQogilyGgvtsXGl2LLwBYE/NQ4XS7ul6TlF3jJrQp1rqbeqBcdBrCeNsaNEB7JwPp
	rzpB66srZgr84rY7qGMBZD/e7KikfM9I=
X-Received: by 2002:a17:906:c14a:b0:b88:7431:3942 with SMTP id
 a640c23a62f3a-b8edf2fae03mr657722266b.33.1770656388033; Mon, 09 Feb 2026
 08:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209143644.96411-1-johannes.thumshirn@wdc.com> <20260209143644.96411-4-johannes.thumshirn@wdc.com>
In-Reply-To: <20260209143644.96411-4-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Feb 2026 16:59:11 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7XPHvi87GpHwTUZ_uhNKRFY8SX+ObjgbEqwUz_-gDHPA@mail.gmail.com>
X-Gm-Features: AZwV_QityAxYOAYCSGaE9C0dfEXFofYC1Z821niIKDHqww8aTAbUAx4g-a4Qylw
Message-ID: <CAL3q7H7XPHvi87GpHwTUZ_uhNKRFY8SX+ObjgbEqwUz_-gDHPA@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: zoned: add zone reclaim flush state for DATA space_info
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
	TAGGED_FROM(0.00)[bounces-21556-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4085D112D92
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 2:46=E2=80=AFPM Johannes Thumshirn
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
> ---
>  fs/btrfs/space-info.c | 12 ++++++++++++
>  fs/btrfs/space-info.h |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index bb5aac7ee9d2..1d5d4f33116d 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -902,6 +902,17 @@ static void flush_space(struct btrfs_space_info *spa=
ce_info, u64 num_bytes,
>                 if (ret > 0 || ret =3D=3D -ENOSPC)
>                         ret =3D 0;
>                 break;
> +       case RECLAIM_ZONES:
> +               ret =3D 0;
> +               if (btrfs_is_zoned(fs_info)) {

It would seem more natural to have:

if (btrfs_is_zoned(fs_info)) {
    (...)
    ret =3D btrfs_commit_current_transaction(root);
} else {
    ret =3D 0;
}

Otherwise it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +                       btrfs_reclaim_sweep(fs_info);
> +                       btrfs_delete_unused_bgs(fs_info);
> +                       btrfs_reclaim_bgs(fs_info);
> +                       flush_work(&fs_info->reclaim_bgs_work);
> +                       ASSERT(current->journal_info =3D=3D NULL);
> +                       ret =3D btrfs_commit_current_transaction(root);
> +               }
> +               break;
>         case RUN_DELAYED_IPUTS:
>                 /*
>                  * If we have pending delayed iputs then we could free up=
 a
> @@ -1400,6 +1411,7 @@ static const enum btrfs_flush_state data_flush_stat=
es[] =3D {
>         FLUSH_DELALLOC_FULL,
>         RUN_DELAYED_IPUTS,
>         COMMIT_TRANS,
> +       RECLAIM_ZONES,
>         RESET_ZONES,
>         ALLOC_CHUNK_FORCE,
>  };
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 0703f24b23f7..4359e3a89b41 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -96,6 +96,7 @@ enum btrfs_flush_state {
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

