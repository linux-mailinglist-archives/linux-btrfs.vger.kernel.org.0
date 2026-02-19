Return-Path: <linux-btrfs+bounces-21789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNIQB0BFl2lMwQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21789-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 18:15:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB19516108E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 18:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E09993012518
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5306534EF10;
	Thu, 19 Feb 2026 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxJEFMtX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0504244685
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521326; cv=none; b=qngw0USTr+pGMt0o2kJM7DZCt1/cgztnpg0xXMqG5mglVM8O+IZ/+yfPzXFUuD9VhRKm+1VJoPXTYgkLIF/lqkGLLSw++aoGmC/t7ceiKPMkYZ9o7DvULXeZNenjjUuR5xathJheDMLEJs2I6zoBrEIZ9LyOJwZHPLGVx6fICgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521326; c=relaxed/simple;
	bh=dQGJxa4QsccDIjIr93pXbgW3LfWs1hHJTSOJ6jGz5rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZC/ws6XBGHWey3QQBfAWATpf0tjNwMtlLulNRV1jlmney1TT1T1MtxVi7cYfb5RKVtt40oNNxfp5xZVR/dL5wuHyhImpx4T87ldkpwTaY8+nY8rKNpR6s1brpGK2HfdAt8aHqjXfPDaPVMGJ/cWQNAji4OYsPYMPGVx1RhH1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxJEFMtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487D5C116D0
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771521326;
	bh=dQGJxa4QsccDIjIr93pXbgW3LfWs1hHJTSOJ6jGz5rw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KxJEFMtXs0ScnpJTXw9kOD1i/gliM/7fOaPW39NSdF7ld2gcREB6Fhuy9+s8Jy+/F
	 IspJGF9KSfGvQF0zJRBUhSJfsVCaSUHmWpV3C70Tiu6m/Vo1kq8IotqQtrnrrYMwAk
	 r3kZmNCNib1D78evfjI0WTj5/o0uQN59JFF0aIOarDvPjnEwb2AZ93dWs6FkF/mDKT
	 y1hJdmueECq1WXy/LJXpIGJDc37Z4+xnJb/5ltKjimsVYiacHAEHslRSQR1+19w1xh
	 FZg0CVo3PeWTxn3S9Je569NYYEJFNxzps3A7aFw0bvyI7yo5l4QlegRJU4Z46c6pAO
	 Kt2emDfRiRZJQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65bebcbffe8so2116117a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 09:15:26 -0800 (PST)
X-Gm-Message-State: AOJu0YzuvrSQHuVbkmZv8cERgiDdUdtrjghsNQB+iEbLUH99pvahIHDQ
	qP7N1RUnCrE03KZE7INu8DcWzYvdEjp+cQdb/JQOTc7/+V6lZ3ZjIrYrHOHuBsDr3U3O5zINuR1
	Nw0wIz9nfbkSX0x3oaq8PnK8pG2zmnLE=
X-Received: by 2002:a17:906:d552:b0:b87:368a:2bf7 with SMTP id
 a640c23a62f3a-b903da48f1amr457415166b.13.1771521324735; Thu, 19 Feb 2026
 09:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219163313.15888-1-mark@harmstone.com>
In-Reply-To: <20260219163313.15888-1-mark@harmstone.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 19 Feb 2026 17:14:47 +0000
X-Gmail-Original-Message-ID: <CAL3q7H60cQ_vdfv4rycH0nd--5cXA_y2pB+4GnFscNueF_heng@mail.gmail.com>
X-Gm-Features: AaiRm53b2tPV0_gG4IchTeDGB5X2Wc8CKFNcIYYvyBlCJzsbWj4TDKtI4gujU0I
Message-ID: <CAL3q7H60cQ_vdfv4rycH0nd--5cXA_y2pB+4GnFscNueF_heng@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add check in remove_range_from_remap_tree() for a
 NULL block group
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21789-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,harmstone.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AB19516108E
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 4:33=E2=80=AFPM Mark Harmstone <mark@harmstone.com>=
 wrote:
>
> Add a check in remove_range_from_remap_tree() after we call
> btrfs_lookup_block_group(), to check if it is NULL. This shouldn't
> happen, but if it does we at least get an error rather than a segfault.
>
> This fixes a bug introduced in the patch "btrfs: handle deletions from
> remapped block group" in for-next.

Same comment as for the other patch, that change is already in Linus'
tree, so we can and should add here a:

Fixes: 979e1dc3d69e ("btrfs: handle deletions from remapped block group")


>
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Suggested-by: Chris Mason <clm@fb.com>
> Link: https://lore.kernel.org/linux-btrfs/20260125125129.2245240-1-clm@me=
ta.com/
> ---
>  fs/btrfs/relocation.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index f2abc5d625c1..679e551707f5 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -6003,6 +6003,9 @@ static int remove_range_from_remap_tree(struct btrf=
s_trans_handle *trans,
>                 struct btrfs_block_group *dest_bg;
>
>                 dest_bg =3D btrfs_lookup_block_group(fs_info, new_addr);
> +               if (!dest_bg)
> +                       return -EUCLEAN;

Since this is a EUCLEAN and highly unexpected, we can use unlikely
here, see: https://btrfs.readthedocs.io/en/latest/dev/Development-notes.htm=
l

With those two changes:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +
>                 adjust_block_group_remap_bytes(trans, dest_bg, -overlap_l=
ength);
>                 btrfs_put_block_group(dest_bg);
>                 ret =3D btrfs_add_to_free_space_tree(trans,
> --
> 2.52.0
>
>

