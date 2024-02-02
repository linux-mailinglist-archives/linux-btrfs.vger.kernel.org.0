Return-Path: <linux-btrfs+bounces-2078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E122D847ACD
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 21:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562E41F2662D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 20:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EEA7C6CE;
	Fri,  2 Feb 2024 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="MXxpj7pb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F877F37
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907350; cv=none; b=MkXT6CdG9Xu+lNguFejjK2PPWxj/sM6uhRBGFH9bcT6fRyNohVXMLT3txXTAHc8BTmJUzFGmh3ucyJlCXlC51fByukFqpse9ict9ehgVTGeMC25APl94k0gv+cmfYlirVmT2CFe2LSFQDPi6+ZqUusahzNjvxY8uztW3s9ICbhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907350; c=relaxed/simple;
	bh=jfOjKEKl+opNxTSnNZOo2SkrZr4wJ8XYjRAYxC+0KNg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d9rFHwnTVsZYDe7/U/UNJpLr0/NbL0NtX73/keGwJDAhyry1QHQaouvYI5xYA867vKWCLLzA7j2jWt2y5T6YO3g3K3eHjb1iRJvNHrpkroU32w7UmV/SvhKH/eECrp2Z0M9NknI/mwZ9A0NKoiLY+JPCKxsNmuIRXlwS6uAfaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=MXxpj7pb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3510d79ae9so328988866b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Feb 2024 12:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1706907345; x=1707512145; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yFKiQldlJn9FP/mE3Da1JyodQRXpBKbJlRmdbJYYSrM=;
        b=MXxpj7pbK0r2ALUt0NIjFNk4vYX/9doux+HYHqE2oQY9/8sev+YqMfIjWzukn7qas4
         EFNbpFSM+DgLXP5owr1olrFXL1ltLVx80wKNmRf7u/jWWgmEnfyPNZQnAXCnxJm4I7PU
         Mck46Q2ckE66h25Ez4xEia1TlBE4KvjxtSaAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907345; x=1707512145;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFKiQldlJn9FP/mE3Da1JyodQRXpBKbJlRmdbJYYSrM=;
        b=TPABiDbtwM6iqumzUa2DevHuulZd6DLjqQAsz3Ryd83hDpebRiI11Ln4hljH6J2jKT
         EHq5Oz38XtrN084b4mBd9iOcC9vK+vrnt5ojY44K9gFewNEcjqQVVc2C0qaKdh79Oags
         qrumiYL62IWYa5ZyxAgPOVa9WXycxknAja1oysnEYYZcNwSqoC4/HWZMiseFTewWiVje
         UyDYpa3+A7PL2xDBivsMZ+auGJx0F89pL8BYOUoKjw+kqj8AqYCJnPCDpyKmK2kAHIia
         8WbhuzIMaysdZOHlWR+BrAixzQmQyH5GSMROHK1CuTAeRRzQNL08nBv6w/MHui421Y3F
         YfTA==
X-Gm-Message-State: AOJu0YygzoKyVUSwvsGQbm/HX8pnlzZxhwT/ECA6v8rHhzSGhJB/uUzm
	+jwpuCmEhUwPJYwuV/NaPCDvkATrsy71TYhVc7i8iAkHWw6TRcr1auav/pvD2MDBenRy8mZdpmt
	ZAqCnYw==
X-Google-Smtp-Source: AGHT+IGT148JGjqWulj73zSgLNa/lQpoiA55JvRGvPmpRYT6+Ism8YN5H0gft66vD3lzARAVZy1Utg==
X-Received: by 2002:a17:906:118b:b0:a31:8f88:8c8f with SMTP id n11-20020a170906118b00b00a318f888c8fmr5496197eja.11.1706907345373;
        Fri, 02 Feb 2024 12:55:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX8IpHzFH8ELc3KGcM6f6W8nTOlytsjsS1nDMasmIQVru6ykWLtbENO353HK2eHyiYUcOGq7xWF0YMrcAq1Fj9iM7dLledHXF4MEhQ=
Received: from able.exile.i.intelfx.name ([178.134.111.230])
        by smtp.gmail.com with ESMTPSA id ao3-20020a170907358300b00a36ca9cd705sm1248129ejc.75.2024.02.02.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:55:44 -0800 (PST)
Message-ID: <8dbde6d822e8af18d3249a0273e9bf12a951b6f2.camel@intelfx.name>
Subject: Re: [PATCH] btrfs: don't refill whole delayed refs block reserve
 when starting transaction
From: Ivan Shapovalov <intelfx@intelfx.name>
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Date: Fri, 02 Feb 2024 21:55:42 +0100
In-Reply-To: <eba624e8cef9a1e84c9e1ba0c8f32347aa487e63.1706892030.git.fdmanana@suse.com>
References: 
	<eba624e8cef9a1e84c9e1ba0c8f32347aa487e63.1706892030.git.fdmanana@suse.com>
Autocrypt: addr=intelfx@intelfx.name; prefer-encrypt=mutual; keydata=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
 NzAT4cw
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-V3AO0tzeyBiSAtRCYD6E"
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-V3AO0tzeyBiSAtRCYD6E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2024-02-02 at 16:42 +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Since commit 28270e25c69a ("btrfs: always reserve space for delayed refs
> when starting transaction") we started not only to reserve metadata space
> for the delayed refs a caller of btrfs_start_transaction() might generate
> but also to try to fully refill the delayed refs block reserve, because
> there are several case where we generate delayed refs and haven't reserve=
d
> space for them, relying on the global block reserve. Relying too much on
> the global block reserve is not always safe, and can result in hitting
> -ENOSPC during transaction commits or worst, in rare cases, being unable
> to mount a filesystem that needs to do orphan cleanup or anything that
> requires modifying the filesystem during mount, and has no more
> unallocated space and the metadata space is nearly full. This was
> explained in detail in that commit's change log.
>=20
> However the gap between the reserved amount and the size of the delayed
> refs block reserve can be huge, so attempting to reserve space for such
> a gap can result in allocating many metadata block groups that end up
> not being used. After a recent patch, with the subject:
>=20
> =C2=A0 "btrfs: add new unused block groups to the list of unused block gr=
oups"
>=20
> We started to add new block groups that are unused to the list of unused
> block groups, to avoid having them around for a very long time in case
> they are never used, because a block group is only added to the list of
> unused block groups when we deallocate the last extent or when mounting
> the filesystem and the block group has 0 bytes used. This is not a proble=
m
> introduced by the commit mentioned earlier, it always existed as our
> metadata space reservations are, most of the time, pessimistic and end up
> not using all the space they reserved, so we can occasionally end up with
> one or two unused metadata block groups for a long period. However after
> that commit mentioned earlier, we are just more pessimistic in the
> metadata space reservations when starting a transaction and therefore the
> issue is more likely to happen.
>=20
> This however is not always enough because we might create unused metadata
> block groups when reserving metadata space at a high rate if there's
> always a gap in the delayed refs block reserve and the cleaner kthread
> isn't triggered often enough or is busy with other work (running delayed
> iputs, cleaning deleted roots, etc), not to mention the block group's
> allocated space is only usable for a new block group after the transactio=
n
> used to remove it is committed.
>=20
> A user reported that he's getting a lot of allocated metadata block group=
s
> but the usage percentage of metadata space was very low compared to the
> total allocated space, specially after running a series of block group
> relocations.
>=20
> So for now stop trying to refill the gap in the delayed refs block reserv=
e
> and reserve space only for the delayed refs we are expected to generate
> when starting a transaction.
>=20
> CC: stable@vger.kernel.org=C2=A0# 6.7+
> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> Link: https://lore.kernel.org/linux-btrfs/9cdbf0ca9cdda1b4c84e15e548af7d7=
f9f926382.camel@intelfx.name/
> Link: https://lore.kernel.org/linux-btrfs/CAL3q7H6802ayLHUJFztzZAVzBLJAGd=
Fx=3D6FHNNy87+obZXXZpQ@mail.gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Tested-by: Ivan Shapovalov <intelfx@intelfx.name>

Thanks!

--=20
Ivan Shapovalov / intelfx /

> =C2=A0fs/btrfs/transaction.c | 38 ++------------------------------------
> =C2=A01 file changed, 2 insertions(+), 36 deletions(-)
>=20
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 70d7abd1f772..3575b2bf3042 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -562,56 +562,22 @@ static int btrfs_reserve_trans_metadata(struct btrf=
s_fs_info *fs_info,
> =C2=A0					u64 num_bytes,
> =C2=A0					u64 *delayed_refs_bytes)
> =C2=A0{
> -	struct btrfs_block_rsv *delayed_refs_rsv =3D &fs_info->delayed_refs_rsv=
;
> =C2=A0	struct btrfs_space_info *si =3D fs_info->trans_block_rsv.space_inf=
o;
> -	u64 extra_delayed_refs_bytes =3D 0;
> -	u64 bytes;
> +	u64 bytes =3D num_bytes + *delayed_refs_bytes;
> =C2=A0	int ret;
> =C2=A0
> -	/*
> -	 * If there's a gap between the size of the delayed refs reserve and
> -	 * its reserved space, than some tasks have added delayed refs or bumpe=
d
> -	 * its size otherwise (due to block group creation or removal, or block
> -	 * group item update). Also try to allocate that gap in order to preven=
t
> -	 * using (and possibly abusing) the global reserve when committing the
> -	 * transaction.
> -	 */
> -	if (flush =3D=3D BTRFS_RESERVE_FLUSH_ALL &&
> -	=C2=A0=C2=A0=C2=A0 !btrfs_block_rsv_full(delayed_refs_rsv)) {
> -		spin_lock(&delayed_refs_rsv->lock);
> -		if (delayed_refs_rsv->size > delayed_refs_rsv->reserved)
> -			extra_delayed_refs_bytes =3D delayed_refs_rsv->size -
> -				delayed_refs_rsv->reserved;
> -		spin_unlock(&delayed_refs_rsv->lock);
> -	}
> -
> -	bytes =3D num_bytes + *delayed_refs_bytes + extra_delayed_refs_bytes;
> -
> =C2=A0	/*
> =C2=A0	 * We want to reserve all the bytes we may need all at once, so we=
 only
> =C2=A0	 * do 1 enospc flushing cycle per transaction start.
> =C2=A0	 */
> =C2=A0	ret =3D btrfs_reserve_metadata_bytes(fs_info, si, bytes, flush);
> -	if (ret =3D=3D 0) {
> -		if (extra_delayed_refs_bytes > 0)
> -			btrfs_migrate_to_delayed_refs_rsv(fs_info,
> -							=C2=A0 extra_delayed_refs_bytes);
> -		return 0;
> -	}
> -
> -	if (extra_delayed_refs_bytes > 0) {
> -		bytes -=3D extra_delayed_refs_bytes;
> -		ret =3D btrfs_reserve_metadata_bytes(fs_info, si, bytes, flush);
> -		if (ret =3D=3D 0)
> -			return 0;
> -	}
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * If we are an emergency flush, which can steal from the global b=
lock
> =C2=A0	 * reserve, then attempt to not reserve space for the delayed refs=
, as
> =C2=A0	 * we will consume space for them from the global block reserve.
> =C2=A0	 */
> -	if (flush =3D=3D BTRFS_RESERVE_FLUSH_ALL_STEAL) {
> +	if (ret && flush =3D=3D BTRFS_RESERVE_FLUSH_ALL_STEAL) {
> =C2=A0		bytes -=3D *delayed_refs_bytes;
> =C2=A0		*delayed_refs_bytes =3D 0;
> =C2=A0		ret =3D btrfs_reserve_metadata_bytes(fs_info, si, bytes, flush);

--=-V3AO0tzeyBiSAtRCYD6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmW9Vs4ACgkQe94XyOTj
Dp3I+A/9HuMT/wgwV87PEG5RBnGdCWmY/muuN3peO4oArbOzvsBKze+fOMG6zlsn
4Ha8PWmw9e68tgwwcCjPXGgRuuNc3jxmzXNnOA979Vj8Diub5BIK1IqtRH0id5lU
l49/s9csSTa4CLmxxnFSDX2k05lhiWdw8VyqQJgPXMq1EZhrAR5kArtScMcM3tWa
6Dbf38euQlGyWn3lx4V50nfW1WtfkWyiW8OnKsPO5eitXLsDwnvpKZNUuHXEPTTJ
f2ylgE//HnHO4hRg3TBUfN1AifEq8ebeLAZhXZ7Emq+iaQ+mSJvhk0zhOcQ/dblM
qkC9yXi8wdvYuEC3j+n3Bx4Hn34uybyhkiAZNnLYdotn5XFsjbhAHK+du2h4/KQx
ogRL6xLzW9hPsWs8Pqfc6HuxcwS1DKqpbgGeauodCmGXUMAw5FomCnKB7vo+Q9Hi
OQfJXwdXjIifLpHMwuL2jMn1OedvgOO9QTmCyICij44DAXJX5R0K8PYUKt4D9VG9
fsBqL1Z7hPzK/XTNyzskndPvYamngPA3OhO6W2xCIPpOcAUlnqQK6Lhf+IR8ThT9
oQ5Q4mDp5NlHv80nONjkr5XZXW8QQkCyc3KpOwZx6Gwd5dai3eDTyxj6C1q9yJRd
/KocyGapESpgmPvAs532wb9E1vhNgFCQvMLHJuMstj+vJqiGBWs=
=EHLD
-----END PGP SIGNATURE-----

--=-V3AO0tzeyBiSAtRCYD6E--

