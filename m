Return-Path: <linux-btrfs+bounces-21704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNTVC5tPlGktCQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21704-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 12:23:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D7814B4A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 12:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09113023A65
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C54331A5B;
	Tue, 17 Feb 2026 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="uBO/WZxq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611FE3314CB;
	Tue, 17 Feb 2026 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327382; cv=none; b=k7QoMuIlmdNP5hQi8YGcQ9qmw4hVjf2vYL3ckuT/OEU4gfgH01GpT+QFI/jy08LvLm1+A9w1Aq13A431cGlm5vvrX9TTD21RncacsHHToz+qt2Uv2STb9Bf0s4dl8+sHyQCcdFulA9O/PzU9FyzBn69jv74FZFvcJLjv8y25Bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327382; c=relaxed/simple;
	bh=/iJJi6O9KQw0JO2PuVU5/Hth5nKcrptg3AN1M6KD9D0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JB/GRPxOQUG0uyZkBkIjTa00HrcAZoTSXVDeHF6prGieVSzpry+twaikCTXADRrnjwh5VNk5aJxCevhxpVx9r+N9IWvIqeXoUBW4mV+BHsgvGMkJhiDaEPqoCG3QCE5oBzSCbVr6J8FR4orVak617cij1/IwmGhJbJx1p/0qCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=uBO/WZxq; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fFcgv0vX8z9t80;
	Tue, 17 Feb 2026 12:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1771327371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXNUb1FZkhWvSmqOHxeC7XFULLXFx9L3rzSNYQOkYE8=;
	b=uBO/WZxqlink6A1gAqd9RNAr4z5Os1MZ6n1Pob0nj5m6SJIVZhcLQ7u6QGFaB5ETfSxsXx
	rhQyNls9zICFFJxkILTrW05AVesevvwTU2jVWmwvWz4fxxb1ZHA/342o/xEDmEAuTb9YYe
	6iuShEhjO3quksl/RdJWgkNvo/GKs2utqoauMFc+hIZInMDCk306KV54znMSItdqdX77dC
	YZUhJsOyQHxuoNtJL67XoCoKAcpm16ypYgQIoUIV8zx1AOwb38j2yEeaa/Rwpi8Q+CqKyV
	49APkxzBQuODDIemJcQNXrlnbAcLEqNOe9JnBZAONwsdZ5wpAuRTeKjwNo1nQQ==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.com,  clm@fb.com,  linux-btrfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: free pages on error on 'btrfs_uring_read_extent'
In-Reply-To: <CAL3q7H7kyo5hEEhn_RO2=55qyAr_6=duS=VQB79wHwNggf+bcA@mail.gmail.com>
	(Filipe Manana's message of "Tue, 17 Feb 2026 11:10:38 +0000")
References: <20260216211215.4149234-1-mssola@mssola.com>
	<CAL3q7H7kyo5hEEhn_RO2=55qyAr_6=duS=VQB79wHwNggf+bcA@mail.gmail.com>
Date: Tue, 17 Feb 2026 12:22:47 +0100
Message-ID: <87o6lnty0o.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.29 / 15.00];
	SIGNED_PGP(-2.00)[];
	INVALID_MSGID(1.70)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21704-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: E3D7814B4A0
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Filipe Manana @ 2026-02-17 11:10 GMT:

> On Mon, Feb 16, 2026 at 9:13=E2=80=AFPM Miquel Sabat=C3=A9 Sol=C3=A0 <mss=
ola@mssola.com> wrote:
>>
>
> As for the subject, should be instead:
>
> btrfs: free pages on error in btrfs_read_uring_extent()
>
> Note we don't usually surround function names with quotes and we
> usually add the () after their name.
>
>> In this function the 'pages' object is never freed in the hopes that is
>
> that is -> that it is
>
>> picked up by btrfs_uring_read_finished() whenever that executes in the
>> future. But that's just the happy path. Along the way previous
>> allocations might have gone wrong, or we might not get -EIOCBQUEUED from
>> btrfs_encoded_read_regular_fill_pages(). In all these cases, we go to a
>> cleanup section that frees all memory allocated by this function without
>> assuming any deferred execution, and this also needs to happen for the
>> 'pages' allocation.
>>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>
> Not contrary to what you had just suggested for a cleanup patch here:
> https://lore.kernel.org/linux-btrfs/87tsvfu11i.fsf@/
>
> This is the sort of change that should have a Fixes tag, because it
> fixes a bug, something that affects users, therefore useful and
> important to have backported to stable releases.
>
> So adding a:
>
> Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads
> (ENCODED_READ ioctl)")
>
> You don't need to do any of these changes, I've done that changes
> myself and added it to the github for-next branch, thanks.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
>

You are totally right, completely missed that one.

Thanks!
Miquel

>> ---
>>  fs/btrfs/ioctl.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 38d93dae71ca..b3e8a8d9b19d 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -4651,7 +4651,7 @@ static int btrfs_uring_read_extent(struct kiocb *i=
ocb, struct iov_iter *iter,
>>  {
>>         struct btrfs_inode *inode =3D BTRFS_I(file_inode(iocb->ki_filp));
>>         struct extent_io_tree *io_tree =3D &inode->io_tree;
>> -       struct page **pages;
>> +       struct page **pages =3D NULL;
>>         struct btrfs_uring_priv *priv =3D NULL;
>>         unsigned long nr_pages;
>>         int ret;
>> @@ -4709,6 +4709,11 @@ static int btrfs_uring_read_extent(struct kiocb *=
iocb, struct iov_iter *iter,
>>         btrfs_unlock_extent(io_tree, start, lockend, &cached_state);
>>         btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>>         kfree(priv);
>> +       for (int i =3D 0; i < nr_pages; i++) {
>> +               if (pages[i])
>> +                       __free_page(pages[i]);
>> +       }
>> +       kfree(pages);
>>         return ret;
>>  }
>>
>> --
>> 2.53.0
>>
>>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmmUT4cbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZcbBEAC5cNraAddzTjz3cCETbXWi5qUSNkaYtOvk1cmkD+OWDIheVOdvO47hkMHY
YCvz6JqV48GEstV5IdW0hosL0NIPcPKGV+L2sP3m6ok7OFqZ6/buoLWdOr7Dth2X
ceyOoTh+k0Icz/6/RT8JPnGFPsheCC+07vD05S1jbrLxKoEXYBwRqtcq3edpIMPX
pKdeRQXzKpfdYA/8S5JTWruSe+9jTTGemcKRvEDHpRz5EYlTBM1NECOGRwxZOIAW
3gByCIVdBJQhgHTf8vcdSP7ysvuZchN6L+C9c11FCPLBDPAQFBJkG7kyV18DO/L3
i0CuppaWL7Sh2df67qg85INTeX5i9RUhJdsPfilSOG150gCRlp1/NXcIIrdZMzxB
WZN5eiFhGHYiPYnKD5rOm+UzaoLECbVjfbp+Mg2NItHAmQ5/2qsmeVPFdJsOltNg
NdHHz93PsfYRxfzjriZhzBd+KuEMr0cBhRDhC6pIS9qzZXJwq062bedL59GCubYA
+eEjn+ryimSOd8HTQ08aFTxpng2K3m3hbdAIDfNusJpVHQSle8cL8t4OO4gIAUUD
3Y0X3RgGGI2hrwy0/BkYQZskTccw+MZMFs8SzBzHyasBWIYwSlQjgng8b7PIOGqr
ntPXkQGkwuuhrjK6l6awCJU8SfxV7qgbaopYsFqGvIIJIac4Ww==
=qLy4
-----END PGP SIGNATURE-----
--=-=-=--

