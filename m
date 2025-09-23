Return-Path: <linux-btrfs+bounces-17114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7929BB94E5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 10:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22937ACA6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8734F30DD37;
	Tue, 23 Sep 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="CkxfsVnR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D582F0C64;
	Tue, 23 Sep 2025 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614487; cv=none; b=fwdiN2g5pqP92W1tlCjXbes7n1EhomqX0mxm5yp2PqD8MIU8KR6PIs/3JHLypZcXFNhd7DmCuQvBGjof8UACjFOmpV0YxpdyoM5/cE/uFsm351bk4Tu8Oph9nLVyCu39aUefMeY83J0GjuccuVwzRoKVIJkjHS5sTIYuTy0fZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614487; c=relaxed/simple;
	bh=iodYp67UVHqm1nPbWB2pFuAa+5L0PMgvahROTF+qR+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hg94tcqzyhOdjyLMdrroJCWuHEHUcWHq7j12HsyAK5G30pm/TTnAeRHmcaLgmM8UKNLmxgvl8QJ+h88nRP6ix2fCZVQed+DhwyspCefdjUlrEJxUyVwofCaWyN9JaZN1lYCyBWrZ4aoFDEkFeZCaasiQq3ZZPSqcbG22IhbuX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=CkxfsVnR; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cWC984tTtz9xxF;
	Tue, 23 Sep 2025 10:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758614476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0i/JHecjqYVh0fyu9Qt3iPq9ZA77kGdWgqnhOc8B1pI=;
	b=CkxfsVnRca6fyC/OwUlVEOd0pWG8bBS4DuyffEVboWNyf3D9uIzm5bTfiAsH2ZREow5219
	Qq33NfE99D4+6QHtXE80Us0cPHWacB/kTHxLcJ1HohrBUmnT7xG0Mt/0eJLowRG8yACPbL
	8Gv91E79oi+08aC2Cox8YeqEZjamXqNNK+aE0KaQ3jx+yLljbEV/4LeJXIzQTdLFbUyHTK
	OeZKurNIlH/NrMsat0Yl26izDj/Q6hNiERSOMK7iVC+GvJpiQOj+QLlGjFKQS7sZeU3Y9a
	StiT9Eb2LtHVtC7+Gr0QVGfwXRsjDC6AjaFPcHz/6krMk1g+cAvpZJKnZ4jxtA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,  dsterba@suse.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Remove open-coded arithmetic in kmalloc
In-Reply-To: <20250923075658.180417-1-mssola@mssola.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Tue, 23 Sep 2025
 09:56:58 +0200")
References: <20250923075658.180417-1-mssola@mssola.com>
Date: Tue, 23 Sep 2025 10:01:14 +0200
Message-ID: <878qi54myd.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 4cWC984tTtz9xxF

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miquel Sabat=C3=A9 Sol=C3=A0 @ 2025-09-23 09:56 +02:

> This is an API cleanup in which the deprecated use of 'kmalloc' with
> open-coded arithmetic is being removed in favor of 'kmalloc_array'. This
> doesn't fix any overflow we are currently facing as all multipliers are
> bounded small numbers derived from number of items in leaves/nodes, but
> it's still a good idea to move away from deprecated uses of 'kmalloc'.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>
> ---
>
> Changes in v2:
> - Provide better wording since this is not fixing any current overflow
>   issues.
> - Drop commit introducing some new __free(kfree) uses in favor of a
>   new patch set to be provided in the future which does a more
>   systematic change.
>
>  fs/btrfs/delayed-inode.c | 4 ++--
>  fs/btrfs/tree-log.c      | 9 +++------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 6adfe62cd0c4..81577a0c601f 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -738,8 +738,8 @@ static int btrfs_insert_delayed_item(struct btrfs_tra=
ns_handle *trans,
>  		u32 *ins_sizes;
>  		int i =3D 0;
>
> -		ins_data =3D kmalloc(batch.nr * sizeof(u32) +
> -				   batch.nr * sizeof(struct btrfs_key), GFP_NOFS);
> +		ins_data =3D kmalloc_array(batch.nr,
> +					 sizeof(u32) + sizeof(struct btrfs_key), GFP_NOFS);
>  		if (!ins_data) {
>  			ret =3D -ENOMEM;
>  			goto out;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 7d19a8c5b2a3..d6471cd33f7f 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4062,8 +4062,7 @@ static int flush_dir_items_batch(struct btrfs_trans=
_handle *trans,
>  		struct btrfs_key *ins_keys;
>  		u32 *ins_sizes;
>
> -		ins_data =3D kmalloc(count * sizeof(u32) +
> -				   count * sizeof(struct btrfs_key), GFP_NOFS);
> +		ins_data =3D kmalloc_array(count, sizeof(u32) + sizeof(struct btrfs_ke=
y), GFP_NOFS);
>  		if (!ins_data)
>  			return -ENOMEM;
>
> @@ -4826,8 +4825,7 @@ static noinline int copy_items(struct btrfs_trans_h=
andle *trans,
>
>  	src =3D src_path->nodes[0];
>
> -	ins_data =3D kmalloc(nr * sizeof(struct btrfs_key) +
> -			   nr * sizeof(u32), GFP_NOFS);
> +	ins_data =3D kmalloc_array(nr, sizeof(struct btrfs_key) + sizeof(u32), =
GFP_NOFS);
>  	if (!ins_data)
>  		return -ENOMEM;
>
> @@ -6532,8 +6530,7 @@ static int log_delayed_insertion_items(struct btrfs=
_trans_handle *trans,
>  	if (!first)
>  		return 0;
>
> -	ins_data =3D kmalloc(max_batch_size * sizeof(u32) +
> -			   max_batch_size * sizeof(struct btrfs_key), GFP_NOFS);
> +	ins_data =3D kmalloc_array(max_batch_size, sizeof(u32) + sizeof(struct =
btrfs_key), GFP_NOFS);
>  	if (!ins_data)
>  		return -ENOMEM;
>  	ins_sizes =3D (u32 *)ins_data;

As discussed with David Sterba, you can ignore this one as it has
already been addressed on his side.

Sorry for the noise.
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjSU8obFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
Zf3IEAC2Ra0nLrXG4eJe4nM8hfXDZLriw8qG3h2zPNHQGwfQs01DvLGVbK3W6Wkk
3LOB9U5q6DNuJwRAPyjSQJKXel/3qBy2+FRFaUUt02H7yfwpC4j0led02f+ggJFl
2/kZLYFXlh4B3z6lVShG23hCgK9/Vie6nGnKOiwTNMmq5TbyeWzRRzdWxx/dIoT/
70Z2XZJ4EKdcFvcRoxtgdzCBzy9sPPo63VnzB4I5dIYHKFCU7bz6Hs+XRd+dD4sK
+cKngwLTmVc4V+hRLKTk2m9B9nawqy0tQ2388rr0zZ3dSuNtURviVO8NUoRxwiOc
JKk0BvHD94auMqlPYp388tLJOIxu8Js/0KflAhZeWwWwh3c/ZT4QdJNZ6qvEqUTH
7RQcsdPDUXGQNJRIqqHefMauf1/jSWK8XSDNL5uM40rPrtpQK+V6TJ5IqeVDzx45
Ar4fjYIsXbYfQxZYcz5n59QagSzVTAjpylUcnYKizOyLHkkM4/M7E0bP/eYZVHXq
3uRoDP3OQEuohKzdNB5yQ3uIRXeMecUu1lYjTl/utefKIp85ubyu9g7kNsFlKots
Vo6K2n++RWCWqXYYd3sJAq1CqrmXgYaXKn4CBtauOHfeyDefsLzpNEFJ6J63e0OK
dKFlWXXqIK9prHPR/MdvB5nBWeuo45hk0yKw67yO7Pend1PlWQ==
=OWh2
-----END PGP SIGNATURE-----
--=-=-=--

