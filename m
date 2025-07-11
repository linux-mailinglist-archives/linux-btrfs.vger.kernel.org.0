Return-Path: <linux-btrfs+bounces-15482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712D4B02618
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 23:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A751A675D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8E7205E3B;
	Fri, 11 Jul 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DU7CCs7I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3EF1E1A3F
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267836; cv=none; b=Pxq3C0n6mV+tlU/h6iDwKrjIs2eWOlx6oyK9HewEpPcFgDOEQIny3BpX8cqTv6kepj9kh/LXs9Idzl/MdMv9y4RqBOHp+qWXD/fWQtL6NPt2urgP22BFKb1XmvJgaFffPs0hBedPhNEOto5yTv4AlSkCAs43nw0i/QAoIxObyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267836; c=relaxed/simple;
	bh=Wte10+9KURV3P6r9m2FqLTWHNpHRE81LqhsFIrFfJJQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Spx+kcZvrcdl4naU96fqP3qR8iT3KJoIEhmPt2hXWGm8iwUEXKzc5QlBmhtO/OGeCmm0U3+VHleh8+cBufRusk0jnhxp4f1WHPRhj7PbbmK403JGRAU1yqs4c0AAEfe42o1Z70BfMJzyaIOKQQ6FCA+ceMmX8PZWY0A0brh3YjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DU7CCs7I; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:To:From:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ouRR3PIMIy0cucoYUvf3qTPQn4J1JmkzeKyViAF11oE=; b=DU7CCs7IP7XhIhZ0xhKFj1noT/
	adZQVV/V/g9DkdkCxV15/+dDGkgrfUd57TvSWF00iWMWHvFH+1kIRkDGnvZIPzNgqQySkgAsuJMA8
	voRsEhWwvfkSolJfVTCG8YC5tCRIjvANQXIjPAAUnu8rOA/RRezWCYIX2c+3tEl3SLTRDEvUDcIpe
	ikrnF+qffm5Eq5Dx+3tqYmzcXeajOZx8Z0eAcMK1flfsAdgC56KkUpZT7zvu+iB2Tu22L52n3ihW5
	NSeQZdwwVYohxf44mu4xMZPKZ584wSd0mC7zOqTwCogwrp5JKDVshvkgcc/e5j9Ox7gcg6BQ5Znwq
	x0UWs55A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <sten@debian.org>)
	id 1uaKuH-00GSuG-Kg; Fri, 11 Jul 2025 21:03:45 +0000
From: Nicholas D Steeves <sten@debian.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Russell Coker
 <russell@coker.com.au>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Scrub problem with Debian kernel 6.12.33+deb13-amd64
In-Reply-To: <5defd3da-16df-4ffb-907b-7bbec0bf9a41@gmx.com>
References: <3036994.e9J7NaK4W3@dojacat>
 <5defd3da-16df-4ffb-907b-7bbec0bf9a41@gmx.com>
Date: Fri, 11 Jul 2025 17:03:38 -0400
Message-ID: <87h5ziignp.fsf@navis.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: sten

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qu Wenruo <quwenruo.btrfs@gmx.com> writes:

> =E5=9C=A8 2025/7/7 20:25, Russell Coker =E5=86=99=E9=81=93:
>> I ran a scrub on my laptop running the latest Debian/Testing setup.  It'=
s a
>> Thinkpad X1 Carbon Gen6 that has just been updated to the latest firmware
>> (Thinkpad BIOS, management engine, and some 3rd thing on the motherboard=
).  It
>> had crashed a few times before which I think has been fixed by the firmw=
are
>> update, it is plausible that the crashes caused some corruption.
>
> You miss the most important thing, kernel version.

Well, it was in the subject line (6.12.33, Debian revision 13), but
I agree that it's best to put it in both places.

>> The system is running LUKS encryption.  After the monthly btrfs scrub I =
got
>> the following in the cron output:
>>=20
>> ERROR: there are 1 uncorrectable errors
>> Starting scrub on devid 1
>> scrub done for d90583c8-9284-48b4-9444-abd00924002a
>> Scrub started:    Mon Jul  7 02:30:01 2025
>> Status:           finished
>> Duration:         0:02:46
>> Total to scrub:   226.35GiB
>> Rate:             1.36GiB/s
>> Error summary:    csum=3D110693
>>    Corrected:      0
>>    Uncorrectable:  110693
>>    Unverified:     0
>>=20
>> I ran the following commands to get more data and got the below output. =
 It
>> seems that we have a clear problem of btrfs dev sta reporting 0 errors w=
hen
>> there were apparently many errors!

Russell, was this bug reported in Debian?  Imho this one is kind of a
big deal when we're at the release candidate stage.  Please feel free to
add me to the X-Debbugs-Cc pseudoheader if/when you report btrfs-related
Debian bugs in the future.  Also, since I seem to remember that you're
excellent at finding and reporting bugs, maybe you'd like to co-found a
btrfs-enablement team?

> Already fixed by upstream commit ec1f3a207cdf ("btrfs: scrub: update=20
> device stats when an error is detected").

Which is 5bd799d2 on the linux-6.12.y branch, and is first present in
v6.12.34, so Debian 13 (trixie) is no longer affected; however, trixie
was affected when Russell reported this issue.

[snip]

>> ERROR: there are 1 uncorrectable errors
>>=20
>> Below are the kernel messages.  No mentions of files or directories so t=
he
>> scrub doesn't seem to be doing it's job well here.  It should either fix
>> things or tell me what rm command I can use to replace things that can't=
 be
>> fixed!
>
>
>  > Jul 07 20:47:20 dojacat kernel: scrub_stripe_report_errors: 7117=20
> callbacks suppressed
>
> Thus the output of file path may be rate limited.
>
> And dmesg is not the best way to tell end users where the corruption is,=
=20
> furthermore there are a lot of valid reasons that a path can not be=20
> resolved (already orphan, belongs to a tree block etc).

I agree!

> Although I believe you're right that btrfs should have a reliable way to=
=20
> indicate which files are affected, but we do not want to populate the=20
> dmesg without any limit either.
>
> In the future we may have a better solution, but for now the best=20
> solution would be using the logical bytenr e.g. 327893450752, and pass=20
> it into `btrfs ins logical-resolve` to do the path resolve.

Are logical bytenr numbers stored anywhere outside of the kernel log?  I
hope they're stored in filesystem metadata :)

Regards,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmhxfCoQHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYZEnEAC3BjlsvbhAz/MeJXXEDUiJEQNZh/bOViwE
0MJg9ZLw51MwwIcnt/AWUVybHGzvr0dX2G0PRtp3ewEi/1/9UJ8Q4/bV+oIJ9bfe
RSZTeJvYhtOp/wMwbeZDs1bDEmII2hqIJ/aMoatZD3DyCd3v9rlhhmpseCXj3Ohf
hvXJ4jqznS9rSPK/pxpJGeWRDkbDm5rIAXvH+OgxIuLBrJViy2q05gMNZtLswoZj
YuKcPgPrruXxO2D7SRlWc0akhWsyOwELpK7nwbjWhskq7Gx7o6sSzhwb64lhikB2
AKVLZZhgiy3tXXU8Q8ZPFwYCHrOA961MmOR+AZL86U94Igh2EhbjKlnVKHOUV4Ca
tLUc2VTfccsowaNuCSRFa9cAJeLnkkhUC9k7JKKC2py5wZqRv0m9xvPvtLnmY3MK
r00tllb4JMUl+pBL4LywzoZYOZX+tobo8Ge1AZ1phVLivg96xhanloTpDv4X0uSz
JPLg43XGkFWStSOHxYwgJErGJrg5PtMuPhWFQyv+SRwzU+5iJnP96vHzp6DYA1oZ
hUZLDTUWfSSvoiZ1j02XRbs4xFR9jJrvhiokzxNyPB2ms/Vy2HjNcCTxuDud+4bq
4J18K7phLZez+phF/wt4fWYxRT8jrbaO1n4YKf4DL1uEoUNpgu/njTasMbFU5so+
9IC82aNaIA==
=8tmH
-----END PGP SIGNATURE-----
--=-=-=--

