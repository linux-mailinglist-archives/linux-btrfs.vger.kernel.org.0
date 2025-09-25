Return-Path: <linux-btrfs+bounces-17193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF439BA100F
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 20:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F95167E2F
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B6315D5F;
	Thu, 25 Sep 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="idHrrXII"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B72E6CC4;
	Thu, 25 Sep 2025 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824792; cv=none; b=A1eEOrl0qbjGzuf0eJvJkMDmwWz0eIXdqNgj+i0Fymb4jfVbh6Jxd6Dziy7NbeaUFB0DvbhW/K/DEo7WMbvsgRV3PblGhbgRc1wAHtWkcyFmUV82Wq/1pyH4/Zy3VfXMTBpR757j0GcLLbAiimCPs2yNYqfs5FBZ7GZe8pLvVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824792; c=relaxed/simple;
	bh=VuVpvTgUyDBXguLcZEGrohFNDW7CDTK5J9Hl/7WAfN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nd8yl8PaYSZpY6Rr0KkDaEU9rz53cBkxcPAGvwFY4JPPP/s3Vqz+7bexhL/qrs65CUy5C4Id6gTFRvV7hV4DywRubwhowUAIZRCFhoWFQp6NjFuVB79a050CGtJf8z3XsxXw0apJdzb+fp10t11GDfA82HJTzjjtnlURE0D8mog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=idHrrXII; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cXhxS1WS0z9y0p;
	Thu, 25 Sep 2025 20:26:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758824780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/q234ki5avHvLmyOYC2Ht/wHa6c4bgBi0q4a4XcIos=;
	b=idHrrXIImNR9F4Hhyxk/Egeb5iJTK1MW843lBRVTgNzqhBm3L3FJcxqrEj9u+058XoZG8P
	yd5FRrWxbG74Je1uag3D5pNP9i1b3SRbDoTpjJoy03mDq6zyA3DihCpCRcu1Bk482X7REr
	ylwYzU0c/B/YszWz02CmKohcafnx4Rwqo/0zxo6z5HHnPMH75Ga8ltIWObcdxQ0s2zWw6f
	7NIm1npFjxGMkK2uSFO0fhkDtNI2RGUjTa/+t8kH4Eif1YITCopgAbx99U39+EK1h4RVek
	Ow501owgLid93mDP5ktYC44sYX/hOnMPy8PiVcs27xhaV7Kom3z1LVTagyf0qQ==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Boris Burkov <boris@bur.io>,  linux-btrfs@vger.kernel.org,  clm@fb.com,
  dsterba@suse.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: ioctl: Fix memory leak on duplicated memory
In-Reply-To: <CAL3q7H6860uRYyT2O9wRA99pD_MqFKdu=-tTngSJReM5hGNZwA@mail.gmail.com>
	(Filipe Manana's message of "Thu, 25 Sep 2025 18:48:06 +0100")
References: <20250925145331.357022-1-mssola@mssola.com>
	<20250925172529.GA1937085@zen.localdomain>
	<CAL3q7H6860uRYyT2O9wRA99pD_MqFKdu=-tTngSJReM5hGNZwA@mail.gmail.com>
Date: Thu, 25 Sep 2025 20:26:15 +0200
Message-ID: <87plbegzi0.fsf@>
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

Filipe Manana @ 2025-09-25 18:48 +01:

> On Thu, Sep 25, 2025 at 6:25=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>>
>> On Thu, Sep 25, 2025 at 04:53:31PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 w=
rote:
>> > On 'btrfs_ioctl_qgroup_assign' we first duplicate the argument as
>> > provided by the user, which is kfree'd in the end. But this was not the
>> > case when allocating memory for 'prealloc'. In this case, if it somehow
>> > failed, then the previous code would go directly into calling
>> > 'mnt_drop_write_file', without freeing the string duplicated from the
>> > user space.
>> >
>> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>>
>> LGTM, thanks for the fix!
>>
>> One thing though: I don't like the label names. I think with multiple
>> cleanups the best way is to name each label with the cleanup it is for.
>> Once you have some named ones, "out" feels unspecific, and encoding
>> every single action like "out_sa_drop_write" doesn't scale as you add
>> more cleanups, so it's just not a useful pattern. It's already quite
>> clunky with just two.
>>
>> If you fixup the names, you can add:
>>
>> Reviewed-by: Boris Burkov <boris@bur.io>
>>
>> > ---
>> >  fs/btrfs/ioctl.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> > index 185bef0df1c2..00381fdbff9d 100644
>> > --- a/fs/btrfs/ioctl.c
>> > +++ b/fs/btrfs/ioctl.c
>> > @@ -3740,7 +3740,7 @@ static long btrfs_ioctl_qgroup_assign(struct fil=
e *file, void __user *arg)
>> >               prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERNEL);
>> >               if (!prealloc) {
>> >                       ret =3D -ENOMEM;
>> > -                     goto drop_write;
>> > +                     goto out_sa_drop_write;
>> >               }
>> >       }
>> >
>> > @@ -3775,6 +3775,7 @@ static long btrfs_ioctl_qgroup_assign(struct fil=
e *file, void __user *arg)
>> >
>> >  out:
>>
>> call this free_prealloc
>>
>> >       kfree(prealloc);
>> > +out_sa_drop_write:
>>
>> and this one free_args
>
>
> Rather than adding yet one more label, which over time has proven
> error prone, I'd rather have a single label.
> Just the existing 'out' label and then the fix would be to replace the
>
> goto drop_write;
>
> with
>
> goto out;
>
> kfree() against a NULL pointer is safe.

I wanted to keep it simple and just fix the issue at hand. Actually I
found out about this as part of a larger refactoring involving cleanup
functions [1], which would fix the amount of labels as well.

Hence, as David mentions on another email, I would handle cleaning up
the amount of labels as part of another series.

>
> Also, missing a Fixes tag which should be:
>
> Fixes: 4addc1ffd67a ("btrfs: qgroup: preallocate memory before adding
> a relation")

I will add it as part of v2, thanks!

>
> Thanks.
>
>>
>> >       kfree(sa);
>> >  drop_write:
>> >       mnt_drop_write_file(file);
>> > --
>> > 2.51.0
>> >
>>

Thanks for the review,
Miquel

[1] https://lore.kernel.org/all/87plbh4qe9.fsf@/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjViUcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZRXiD/9IFL1jF7AaWrAC1t0INGqTiXK8FoVkvf6/R4vh6ljLusT7H7pI6H1FJvo2
r0SGTtM5VEkLBXj3w9s3+mJvZ5kaeX7rCR6r4rJpHsnVR4mToEPJkihOYVMEqfVD
P79eEQI+3aeK0IYy5CvHV9Vu1sAJI3Y8zw0I9/53kpUKLGxARpni9uA5F84c8qsb
z6HU7hiXnEjhwxn7lgiwJRrASb+qkuwddypsFtIguUY8CB2Q6EUVlTbxXOhwn9Xi
vnonHNMK7sMYkrgxxkGFm8kTZO8D6NEuNdYenHhKF1K77RkMMrXHy7gXFEhmE6u9
aMFgj26Edf6tBnXQ1a2bPNUbHiN71UR/RGSBvUyQNlz0V/077tQ4ma2O93UyjYMm
a2RnJl7LkgHEVy7mSsprSVMDl1kb5/J2Qk1HfLJSZMML8ZcrTkKkkVE+wWY3bjCb
zoCl7uugJF3eKlDF+/nwybf1dXZP5YObv4UJN0JQYLz5F8pYnwDCv5VyS3GuHSc8
0HX/qSYcreKR8jPouQt2KO1ftXtPRXzMrkiAWPhSOJkmWE2p+GAYy6moN11fmdMn
PwE/qyy+vmz1KppAiQpqQLuSZZZSy1Ewhf1jpwwVbQyhhcvr56HBofs3AXYi3DSh
fQGOYR/SqG7iwiG+d2HxnetjCeJVh77YKFYz23dPKDJXH10ZMg==
=n7N/
-----END PGP SIGNATURE-----
--=-=-=--

