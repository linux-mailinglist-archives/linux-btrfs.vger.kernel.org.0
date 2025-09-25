Return-Path: <linux-btrfs+bounces-17195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B5BA118F
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 20:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CEE1C2317F
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED08131B122;
	Thu, 25 Sep 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="FPaJARfo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9302F25FE;
	Thu, 25 Sep 2025 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826620; cv=none; b=lLF3RgQ8cEHw1nonnr7TOPEnxrlEbx/j29qyDYw95rgzjfb1pdmJtmboaCVznNVJ7x+yB/7UJHg2pZsFoBxFz94rilTwbvRtgKvuj4aGJvxc4wq5kmH8ZmrnQY1r+p44/ib42R7buO2FPYeXahfw8ip5GmH/m5tnC78hSUbR8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826620; c=relaxed/simple;
	bh=/kUnDydi7GOU2wrt+7lXJY3iDruaObfBM4Lpzc+jpuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NsKbWC1Mo0pYAUI+YPRsXMVLQ4UiGkko+ntaaRbEZr+fOeApKZa2uA5mGLomw2Ynz/98+AYuFjfNQY2foT47tYE8YQ9X8Xe+fDrIm7T0pLKaf2oNakEPwULhDu6+CsOKtu9DEwgEwUsPqaI4EbeLxnnrSYRyhTlNASzI4MgUfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=FPaJARfo; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cXjcj2G5KzB0lB;
	Thu, 25 Sep 2025 20:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758826613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GSJk51wGcX8ogggQQD5GJZXXOMs7lSWLNHhhqSkA+QU=;
	b=FPaJARfoKGbJUTR+IW5JxIpdKOvsSh86Dy2cyu/023vj+HPcmiVmLFAlNk3LdB5dJ7Db1i
	AKB3FzQ8HE8zxQbAHwESSRF6+Xeizm2Vo34gEAB8lnoyPOIWXhdEUQuida16qKaewvgYTt
	Q+bvDcIwBQwqAZcdOEz/3JO726OPCtMr+CkQgUEbUU9m2MtmVNc0Y2yN6mz5btrq8QuGxz
	8Rge60iYNKRZDqw/1xKzXSjbZ3RCr6LV2S/GTt2tUhWHfjXIOmocppddSBNpz/2WqXTjHR
	YmFPIheT6mis3K1zw35oY4dHnHybtYd9rbe+l2vIhjuBqa7n2gEeMtJea74htw==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Boris Burkov <boris@bur.io>,  linux-btrfs@vger.kernel.org,  clm@fb.com,
  dsterba@suse.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: ioctl: Fix memory leak on duplicated memory
In-Reply-To: <87plbegzi0.fsf@> ("Miquel =?utf-8?Q?Sabat=C3=A9_Sol=C3=A0=22?=
 =?utf-8?Q?'s?= message of "Thu, 25 Sep
	2025 20:26:15 +0200")
References: <20250925145331.357022-1-mssola@mssola.com>
	<20250925172529.GA1937085@zen.localdomain>
	<CAL3q7H6860uRYyT2O9wRA99pD_MqFKdu=-tTngSJReM5hGNZwA@mail.gmail.com>
Date: Thu, 25 Sep 2025 20:56:50 +0200
Message-ID: <87ecrugy31.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miquel Sabat=C3=A9 Sol=C3=A0 @ 2025-09-25 20:26 +02:

> Filipe Manana @ 2025-09-25 18:48 +01:
>
>> On Thu, Sep 25, 2025 at 6:25=E2=80=AFPM Boris Burkov <boris@bur.io> wrot=
e:
>>>
>>> On Thu, Sep 25, 2025 at 04:53:31PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 =
wrote:
>>> > On 'btrfs_ioctl_qgroup_assign' we first duplicate the argument as
>>> > provided by the user, which is kfree'd in the end. But this was not t=
he
>>> > case when allocating memory for 'prealloc'. In this case, if it someh=
ow
>>> > failed, then the previous code would go directly into calling
>>> > 'mnt_drop_write_file', without freeing the string duplicated from the
>>> > user space.
>>> >
>>> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>>>
>>> LGTM, thanks for the fix!
>>>
>>> One thing though: I don't like the label names. I think with multiple
>>> cleanups the best way is to name each label with the cleanup it is for.
>>> Once you have some named ones, "out" feels unspecific, and encoding
>>> every single action like "out_sa_drop_write" doesn't scale as you add
>>> more cleanups, so it's just not a useful pattern. It's already quite
>>> clunky with just two.
>>>
>>> If you fixup the names, you can add:
>>>
>>> Reviewed-by: Boris Burkov <boris@bur.io>
>>>
>>> > ---
>>> >  fs/btrfs/ioctl.c | 3 ++-
>>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>>> >
>>> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> > index 185bef0df1c2..00381fdbff9d 100644
>>> > --- a/fs/btrfs/ioctl.c
>>> > +++ b/fs/btrfs/ioctl.c
>>> > @@ -3740,7 +3740,7 @@ static long btrfs_ioctl_qgroup_assign(struct fi=
le *file, void __user *arg)
>>> >               prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERNEL);
>>> >               if (!prealloc) {
>>> >                       ret =3D -ENOMEM;
>>> > -                     goto drop_write;
>>> > +                     goto out_sa_drop_write;
>>> >               }
>>> >       }
>>> >
>>> > @@ -3775,6 +3775,7 @@ static long btrfs_ioctl_qgroup_assign(struct fi=
le *file, void __user *arg)
>>> >
>>> >  out:
>>>
>>> call this free_prealloc
>>>
>>> >       kfree(prealloc);
>>> > +out_sa_drop_write:
>>>
>>> and this one free_args
>>
>>
>> Rather than adding yet one more label, which over time has proven
>> error prone, I'd rather have a single label.
>> Just the existing 'out' label and then the fix would be to replace the
>>
>> goto drop_write;
>>
>> with
>>
>> goto out;
>>
>> kfree() against a NULL pointer is safe.
>
> I wanted to keep it simple and just fix the issue at hand. Actually I
> found out about this as part of a larger refactoring involving cleanup
> functions [1], which would fix the amount of labels as well.

I clearly read too fast here. I applied your suggestion for v2. Sorry
for the noise!

>
> Hence, as David mentions on another email, I would handle cleaning up
> the amount of labels as part of another series.
>
>>
>> Also, missing a Fixes tag which should be:
>>
>> Fixes: 4addc1ffd67a ("btrfs: qgroup: preallocate memory before adding
>> a relation")
>
> I will add it as part of v2, thanks!
>
>>
>> Thanks.
>>
>>>
>>> >       kfree(sa);
>>> >  drop_write:
>>> >       mnt_drop_write_file(file);
>>> > --
>>> > 2.51.0
>>> >
>>>
>
> Thanks for the review,
> Miquel
>
> [1] https://lore.kernel.org/all/87plbh4qe9.fsf@/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjVkHIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZVtaD/9jlMfpAKzEsBSnB4YzQERqLEw/U+K5TfTgcqHru6uttqW91YvelkCnt/gB
arprAH4Dq8QAu2FAyF8cGji+sgeXCAAu3T5ROLNGAMw4jFKsEiqBlpLpVu0aIXKh
3qj+SvNZkLxLjVCzOMm+J3OYdpdYt5RIvu8Gr6QeDzBDyr2Wbw4c/hjC/u0IhpNg
r5Pdid9XuOrN7sk7vuD89pjCUfHsaLLYOj5i7HeNZ4bcOr2zafpX5gRSGvKjXdt6
qnniNOzSSjzbxQNiLugb7LrenK/51117+0ZP6fXZ4ESNc5G85fAjuC5e27I0DcGs
tpGqhfZgT4uUvb9KHo4GtuhtbZJY5JhTKw2MAVYox4W8JYgqa8Y2Dc6ndBvs62S4
oah6PSS/WOqUTNYyoeFIj3FkQ2Y8FQe71vObPCuNIUYlI5e3dKI5gBUeYRfxZnhW
pyIi2vXOf+yNUOHXtPN+jXRpcZJxQVTddo6nAhZlHf732KoOYXvL9RuLuvuoI3W7
HsoGvi4pGrEB2lJQ3bZGXoAHThtDqLwIfCExnBB6KihACJ5D889YqLvQ95tYs4qM
QnktJHdA+1ugJ2dcqKmk2LGkUNWzFTU6Vdy2xRM9DFB5BVFpfu4IhnQZmZTI6w/b
YdIIKBbsW0warrcArwaiRR4/EpehMGR9JwSsjV9vNMkIqwhUxQ==
=pIak
-----END PGP SIGNATURE-----
--=-=-=--

