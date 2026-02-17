Return-Path: <linux-btrfs+bounces-21724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCi6CTXSlGmfIAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21724-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 21:40:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 773D915008A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 21:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 136D63008D1C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1947F37881F;
	Tue, 17 Feb 2026 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="tivs9QAr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CD937755D;
	Tue, 17 Feb 2026 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360808; cv=none; b=soOgfQ52A28L0CHLe72xlfymnuOyhG3WV4lTuZdTCtON2D/dyY6nqxXNnAG7V2PBVlGQ/4YJtyjzXlWomcL0ok0uxavOKO2gxxGUPBNBn/6WnfEMa/ERi3fUXKAkjJWGar9Nq1MLShAMty4jHQzFdelZQPF1huWQoo+PjnrYAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360808; c=relaxed/simple;
	bh=VGhX4Ogsh+FJfbU10qrWEpJKF3am+UiOGev2mNCKz/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ku8bUe/NnHJTx8NSQJvdk5GmQObNqgULGPDPu3BsM7AfQHjNonGKFN/UxLevJTW/lUK1rinRmtmDku7KM00TBsMnBNd1dE8SaN79VAkDaK0X0rXtQuB8GWPseemhbktBsQLv/ny4Npqcvzv8WLdAFcLwsPCJhfjYIzq3LGJ7MSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=tivs9QAr; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fFs2n0LQsz9vDB;
	Tue, 17 Feb 2026 21:40:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771360801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qoh+JC2WqTbmXPWJ9UMu4ZCYCOIs//btRKehbviphEw=;
	b=tivs9QAr115OQSIsHairo4zg4AVl5eFzwB1ilTHBioCY4uTg5eQ7DXr9ZX29hdqW1dtP7+
	yaso66OYtRjkvh8OiHzw7KYUFwam4WW8goJDed+iukbF2mH/KmfRgRktr7G+tMy3lnReIG
	zHoW40P+DcJThaQuiH7kyv720bpjd5w4ojAItbTvazG2E2KdxeERkAY4TTbXiOkz5MiIk4
	LIBCGJLgL6pQ3sQVrwVaAeebgMont8jnb7DJKHftsrbjXyjjtGWMDsndOV57gOml55zFzR
	9Svt2jf30l+PMj0HJ8ALUAkmPjSZriJfTuj/+OV5A+5HMce9/vcKB7dHw17YCQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::202 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.com,  clm@fb.com,  linux-btrfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't commit the super block when unmounting a
 shutdown filesystem
In-Reply-To: <CAL3q7H7ezZL_HMsa2SthbPg-muM85Jc7OwiD2nh7-w0XOXH3tw@mail.gmail.com>
	(Filipe Manana's message of "Tue, 17 Feb 2026 18:11:10 +0000")
References: <20260216002252.3831277-1-mssola@mssola.com>
	<CAL3q7H7ezZL_HMsa2SthbPg-muM85Jc7OwiD2nh7-w0XOXH3tw@mail.gmail.com>
Date: Tue, 17 Feb 2026 21:39:58 +0100
Message-ID: <87cy23t881.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.47 / 15.00];
	SIGNED_PGP(-2.00)[];
	INVALID_MSGID(1.70)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21724-lists,linux-btrfs=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 773D915008A
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Filipe Manana @ 2026-02-17 18:11 GMT:

> On Mon, Feb 16, 2026 at 12:23=E2=80=AFAM Miquel Sabat=C3=A9 Sol=C3=A0 <ms=
sola@mssola.com> wrote:
>>
>> When unmounting a filesystem we will try, among many other things, to
>> commit the super block. On a filesystem that was shutdown, though, this
>> will always fail with -EROFS as writes are forbidden on this context;
>> and an error will be reported.
>>
>> Don't commit the super block on this situation, which should be fine as
>> the filesystem is frozen before shutdown and, therefore, it should be at
>> a consistent state.
>>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>> ---
>>  fs/btrfs/disk-io.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 600287ac8eb7..cd2ce6348d88 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -4380,9 +4380,18 @@ void __cold close_ctree(struct btrfs_fs_info *fs_=
info)
>>                  */
>>                 btrfs_flush_workqueue(fs_info->delayed_workers);
>>
>> -               ret =3D btrfs_commit_super(fs_info);
>> -               if (ret)
>> -                       btrfs_err(fs_info, "commit super ret %d", ret);
>> +               /*
>> +                * If the filesystem is shutdown, then an attempt to com=
mit the
>> +                * super block (or any write) will just fail. Since we f=
reeze
>> +                * the filesystem before shutting it down, the filesyste=
m should
>> +                * be in a consistent state and not committing the super=
 block
>> +                * should be fine.
>
> Looks good to me, but I'll rephrase this with:
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index cd2ce6348d88..84829f5e97a8 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4383,9 +4383,8 @@ void __cold close_ctree(struct btrfs_fs_info *fs_in=
fo)
>                 /*
>                  * If the filesystem is shutdown, then an attempt to comm=
it the
>                  * super block (or any write) will just fail. Since we fr=
eeze
> -                * the filesystem before shutting it down, the filesystem=
 should
> -                * be in a consistent state and not committing the super =
block
> -                * should be fine.
> +                * the filesystem before shutting it down, the filesystem=
 is in
> +                * a consistent state and we don't need to commit super b=
locks.
>                  */
>
> The way it's phrased gives the reader an idea that we are not sure
> about what we are doing, which sounds bad.

Yes, I also like the new wording better, thanks!

>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Pushed it to the github for-next branch, thanks.
>
>> +                */
>> +               if (!btrfs_is_shutdown(fs_info)) {
>> +                       ret =3D btrfs_commit_super(fs_info);
>> +                       if (ret)
>> +                               btrfs_err(fs_info, "commit super ret %d"=
, ret);
>> +               }
>>         }
>>
>>         kthread_stop(fs_info->transaction_kthread);
>> --
>> 2.53.0
>>
>>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmU0h4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZSTTEACuZohzo3NCbPt7JT8DqfFE7qrSmP45fKAqJGMr0bwziHRDAmHEbGYyK0eh
MN7E5bl2VwTKDu+YoBstVmZolYpzOhT7JTICq6uDJab0gvh7t6FcJIzpwuGqmDLQ
OYcPcoPzvsrJnMcqKrLY4K9ms4xCjeLFkgA3/DayEa7vuRik0AsWqdvavcOX4Yz8
7WzixF3Q2ZOmLlKt+Jj+ptKnA3IwFFRGRtmfHVDUU1v12GmF92pRkrwZXKWUSYZz
gW4Iy5lZf91VVxTlha1l7s4ZMqzEK/4rLhVHHf8i5VgsnA9SP6LRM4jpVo8j0YIv
cagiYGWhpJ+JUZJrW6EXYF3BExnZiRWFY3vc4UCEyL9rndxl/fOzwa+Wtb8GpJ2p
CuwLmSfJsxJSdZ5GcLlJO66njpITN/VJtLCB1INR95rh7MI+rjh3XrXWV2j+TpIG
hveJE6fvoOvbaTNxD62fkdoZaHoOO4ataQ1GTkcFR2sf1+mp3ddZdUidjgd26xC9
mqbe/DWtC28duP0Zf91rrHlKv1hhlKiq2yozfjMT+n5tVslQItG0CsHQEmOEPZl+
QnUGms36kP8cBzcUZ2HuXWliL8z8IcKxFZiQGWhLjqOWvkQ/NIGtz4yLwP7lFpPV
sz1eqHtjMorcoroypH6hqEgVDZVcxOGVVtD7FZhlbLHSromlpg==
=1t7f
-----END PGP SIGNATURE-----
--=-=-=--

