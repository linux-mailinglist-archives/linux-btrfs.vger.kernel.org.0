Return-Path: <linux-btrfs+bounces-21706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yADvH25UlGl3CgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21706-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 12:43:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6A814B873
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 12:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3BF304705A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1934D335076;
	Tue, 17 Feb 2026 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlrDu41g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0B334C3E
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328560; cv=none; b=Zfwy+gEkGSpBCNXcU7UUfGePjdwn2pCHyKgPGohuvOWgRKDZbtNommUvTort5x1DE7aRW6P8mJsbsDT6nm7jO8vLRW+DEXyaU+wiNAuWALizMC/S4e0ZRUZvbwW0lArnD30vLR1OdPp0UJFjsJKMwTf9aQ5GsYuV2w9j8KDf6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328560; c=relaxed/simple;
	bh=pv/Mhv5mg40BowQTErNbiOAo1nxDtseUWg9ioTkaWVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nx7y9JQVv8/oO32CcyNcwZTtiit9p1JsWjLEi7QSvw/+pjt6iEkVJWdVbHKg77DXEFlkqUkXLirxb7UJyPWY4bGYFW67l43xmP2j2iKvFJcrgZ/Y7WjXVYHQK9+kvkJuyArBH7po47+LioO9TlBY1MFCVHZ4jr/kb5llpQU1NlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlrDu41g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24741C2BC9E
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 11:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771328560;
	bh=pv/Mhv5mg40BowQTErNbiOAo1nxDtseUWg9ioTkaWVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KlrDu41gvlWKLpa0u+MfO7GYMZ7OhvLhXaGCREfwI2BWM/bfO0+OhuB2jDx+4sKMy
	 tsM32qyh6zH5sC0lZLzTtQa/Baf1Gme7RtPfu6HriZSW9JDmnME5e2YWdWQxRc8Pip
	 UDxYUtv5tJ48/MuF5Azkw570rVcuIfwXOsRUWMDMe466nQDtrXuAEq96gNbUFSZYbi
	 484vtK4oMwrAXCTw64aPDogRsS1e2PcuzA2r5o0XcY+G4FKQ6nIC8KaotEMnd/UdyM
	 48P/STMLh7PmVq2iAjbTf1Om+edn3uM2Hgh/WZHg36IfwK2MJhpQ7ptHbqk23WYbHz
	 yD+NC7ybdn0ww==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8876d1a39bso462948866b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 03:42:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhEO/PMW5ZwxBsER7YXj6PdTlaY0HryDbevdZVQuNYKT2CgfuPSHFpr3wEgUf00E0itZc7YUigTfrubA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JerINtP2TQ5kZJ4cgvbTfz79FrSmvoPyWr3XMcIruRbYG3yi
	N6+n6J1sWHc+duejIlOI19YfE/TIpJ+cuhZHY1Z1U3/0KLkKPYRMkb+lYD2+rN3UD8WO5B+050h
	30yt79nuIF3x6rbME9fuFzsPQ1OYP9LU=
X-Received: by 2002:a17:906:dc8c:b0:b83:95c7:f87b with SMTP id
 a640c23a62f3a-b8fc3c7fc49mr586022166b.37.1771328558543; Tue, 17 Feb 2026
 03:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216221632.23087-1-jkchen@ugreen.com>
In-Reply-To: <20260216221632.23087-1-jkchen@ugreen.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Feb 2026 11:42:01 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7-SNQMoXzvTVCVzZx9gYXq3rzRfRp5OERz+riPQ-=tow@mail.gmail.com>
X-Gm-Features: AaiRm52LenniYhN4MGfAwmNe9Ht9I5QXW7AQPat9rLhrlTr0JsbG45nd3gDltJI
Message-ID: <CAL3q7H7-SNQMoXzvTVCVzZx9gYXq3rzRfRp5OERz+riPQ-=tow@mail.gmail.com>
Subject: Re: [PATCH] btrfs: check snapshot_force_cow earlier in can_nocow_file_extent
To: jkchen <jk.chen1095@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkchen <jkchen@ugreen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21706-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ugreen.com:email,suse.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B6A814B873
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 10:17=E2=80=AFPM jkchen <jk.chen1095@gmail.com> wro=
te:
>
> When a snapshot is being created, the atomic counter snapshot_force_cow
> is incremented to force incoming writes to fallback to COW. This is a
> critical mechanism to protect the consistency of the snapshot being taken=
.
>
> Currently, can_nocow_file_extent() checks this counter only after
> performing several checks, most notably the expensive cross-reference
> check via btrfs_cross_ref_exist(). btrfs_cross_ref_exist() releases the
> path and performs a search in the extent tree or backref cache, which
> involves btree traversals and locking overhead.
>
> This patch moves the snapshot_force_cow check to the very beginning of
> can_nocow_file_extent().
>
> This reordering is safe and beneficial because:
> 1. args->writeback_path is invariant for the duration of the call (set
>    by caller run_delalloc_nocow).
> 2. is_freespace_inode is a static property of the inode.
> 3. The state of snapshot_force_cow is driven by the btrfs_mksnapshot
>    process. Checking it earlier does not change the outcome of the NOCOW
>    decision, but effectively prunes the expensive code path when a
>    fallback to COW is inevitable.
>
> By failing fast when a snapshot is pending, we avoid the unnecessary
> overhead of btrfs_cross_ref_exist() and other extent item checks in the
> scenario where NOCOW is already known to be impossible.
>
> Signed-off-by: jkchen <jkchen@ugreen.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, I'll add it to the github for-next branch, thanks.

> ---
>  fs/btrfs/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 845164485..3549031f3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1921,6 +1921,11 @@ static int can_nocow_file_extent(struct btrfs_path=
 *path,
>         int ret =3D 0;
>         bool nowait =3D path->nowait;
>
> +       /* If there are pending snapshots for this root, we must COW. */
> +       if (args->writeback_path && !is_freespace_inode &&
> +           atomic_read(&root->snapshot_force_cow))
> +               goto out;
> +
>         fi =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_ext=
ent_item);
>         extent_type =3D btrfs_file_extent_type(leaf, fi);
>
> @@ -1982,11 +1987,6 @@ static int can_nocow_file_extent(struct btrfs_path=
 *path,
>                 path =3D NULL;
>         }
>
> -       /* If there are pending snapshots for this root, we must COW. */
> -       if (args->writeback_path && !is_freespace_inode &&
> -           atomic_read(&root->snapshot_force_cow))
> -               goto out;
> -
>         args->file_extent.num_bytes =3D min(args->end + 1, extent_end) - =
args->start;
>         args->file_extent.offset +=3D args->start - key->offset;
>         io_start =3D args->file_extent.disk_bytenr + args->file_extent.of=
fset;
> --
> 2.43.0
>
>

