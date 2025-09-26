Return-Path: <linux-btrfs+bounces-17214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FB8BA32FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 11:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5401C02EB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6844229E114;
	Fri, 26 Sep 2025 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="jDrkXg6W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C129B8DD;
	Fri, 26 Sep 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879427; cv=none; b=WpCGwYFX6qz7b28M9zFW1Z/mzq0TORdkhthXNE9RB8GOaKdGRv5kQmGkuU1ObYwNuj3C/wN3E9nFLqMquVhPqeVhjlnh/DbtxYjhWXN8+q93qiqtlDf8NnldPuPurhlhJUldt3fwHGsfq0KpTaYr/QsNxFKG9DxNIiP93h8x6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879427; c=relaxed/simple;
	bh=tRT3AeLAn10plskRfMyJ3Oo7BR7+ZEgC2BhhIACCQWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n+vChoursY3l4+UCwlZu7BMrgiCVf2cz2NJ1WkhsYaqmUgnsW9mG2++tzR4XhrEen7xEYZIFryKxgCc6Zv1UlPjOE76A4Ai+5bDXtFi/ny99T0K+UgVILsntAWXiKW6jT4/uWvC5Jw3nrP1rVvSjURbsQZB1tnq2M1PuJokLu9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=jDrkXg6W; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cY58D0cTdz9yBH;
	Fri, 26 Sep 2025 11:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758879420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxfBGYJT0a6nOIicJjUHpnM/yQaXPPgM9DO+hl1jICA=;
	b=jDrkXg6WXOUvsa811u3+LfxvadB0ZafRBjpXg5ILDY2QfMXL32CdInChyWkYuBfFNjUhCF
	JJEHM4MYoRD1UjQtXorRcNGwGCWmNThsb8oBGzroOmbwyYFyf6XL35DlLRU+b/VNrPXikJ
	KWnGoz6c8bkRJoZls89mhlmQ46lOgZF8U01oA6ZvjsN0tLoQo4oCJVq5Zv6bB1MYwlEoYB
	2fyYyNCfYifRN++A/WiUbdectUwW8Y/Y2oRr+Ol4VamWZx6FTzkfq1KOTO9yaCAmSCohiT
	RVn6yUn0SxadJUX8qdHE3Ys/HT9HtitlVwqcO0dw+W2/IMoSUVMRhjitXTd29g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org,  clm@fb.com,  dsterba@suse.com,
  wqu@suse.com,  linux-kernel@vger.kernel.org,  Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v2] btrfs: ioctl: Fix memory leak on duplicated memory
In-Reply-To: <CAL3q7H53nu8sGuDCbWzsVFHf5g1ybsRVrdyN6WaET61mk-g3mA@mail.gmail.com>
	(Filipe Manana's message of "Fri, 26 Sep 2025 10:04:13 +0100")
References: <20250925184139.403156-1-mssola@mssola.com>
	<CAL3q7H53nu8sGuDCbWzsVFHf5g1ybsRVrdyN6WaET61mk-g3mA@mail.gmail.com>
Date: Fri, 26 Sep 2025 11:36:52 +0200
Message-ID: <87qzvt7dxn.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 4cY58D0cTdz9yBH

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Filipe Manana @ 2025-09-26 10:04 +01:

> On Thu, Sep 25, 2025 at 11:42=E2=80=AFPM Miquel Sabat=C3=A9 Sol=C3=A0 <ms=
sola@mssola.com> wrote:
>>
>> On 'btrfs_ioctl_qgroup_assign' we first duplicate the argument as
>> provided by the user, which is kfree'd in the end. But this was not the
>> case when allocating memory for 'prealloc'. In this case, if it somehow
>> failed, then the previous code would go directly into calling
>> 'mnt_drop_write_file', without freeing the string duplicated from the
>> user space.
>>
>> Fixes: 4addc1ffd67a ("btrfs: qgroup: preallocate memory before adding a =
relation")
>> Reviewed-by: Boris Burkov <boris@bur.io>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> I pushed it  into the for-next branch [1] with a changed subject to:
>
> btrfs: fix memory leak on duplicated memory in the qgroup assign ioctl
>
> Note that we don't capitalize the first word after the prefix in the subj=
ect.
> I also made it more specific by mentioning which ioctl, since we have man=
y.

Understood! Thanks for applying the patch.

>
> Thanks.
>
> [1] https://github.com/btrfs/linux/commits/for-next/
>
>> ---
>>  fs/btrfs/ioctl.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 185bef0df1c2..8cb7d5a462ef 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -3740,7 +3740,7 @@ static long btrfs_ioctl_qgroup_assign(struct file =
*file, void __user *arg)
>>                 prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERNEL);
>>                 if (!prealloc) {
>>                         ret =3D -ENOMEM;
>> -                       goto drop_write;
>> +                       goto out;
>>                 }
>>         }
>>
>> --
>> 2.51.0
>>

Cheers,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjWXrQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZewjD/wPp7i1B1V6EuxDFcJoucwlCAaB9xQO5O3jhw0+HEaDekOcWO4C1c9L2ai9
zFkFAqBuAbJPRvRWrvgOpeJZlvt+f/9cKuUAiSeLxCYbhYf1l4Knj8EHTFgLDboL
5WFhHrlC7gC8mpK0o72i2oetJljmzGBMnxo9c+KlF6cuRABi/8cQ+aLL9vaupCyG
lsV63RadBJuI/yFE/0yDffBKrbJVqqj4V9aQh4gZKTiabn0ZuHmtoMyftyA7jfOM
z+acRiYcejMw3a4VEUjDNLb5VNxC+/yJ4aMr6nGUnY4ZMwXHlIDsRXDnczRJQGUi
+KSv8QYOGM9lhU46RJk72ZTwFDoVo4N9ZLfWjhCnXaBqGIau8OBhTfXtkimPq1+a
dGWwT8ef5hBRbAjA+ffJNHGRhJDYhjSqVvXqIxLxM6rBkJyirO9hbBRo7qt+QGNn
ikne3NlIqFIPkL4M7Ard3JUwrqMFn/4yB1UxF2oIgnmIo9la1bxxEN0ncF2sQbKB
hIBpfMZDqEGdSFLYTTnPG97of3A6m2VRqlwUHlfmV0H1+ZwCiYjFmDJoGDKqKKKJ
T07yKZouNiIKPxaoYiecItruTM5vYCrJVj89EifXM2JXL3PR4ceCni9V3+pd8v8k
eV/Rvl5vX9VL/dbhcGG7/Jrue774dkVj7i+jG+WJx1bL026dgQ==
=XztT
-----END PGP SIGNATURE-----
--=-=-=--

