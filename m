Return-Path: <linux-btrfs+bounces-21636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YtuRFCvtjGl4vgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21636-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 21:57:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E1C1278DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 21:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAFDE302801D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 20:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2AD35295E;
	Wed, 11 Feb 2026 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cBE+WZKo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B51CF7D5
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770843423; cv=none; b=hSNkZuMD6ljFHoXWZNRbq4d6yARLiPMjpmyzNbG+YRGHHZw//bKckIXXQ6eaccK1Szi4ZKE9g0+ojdYkYPWnbMPF8q55O05AWru6EzlxBtYBUKEocOcLOAI7ZDtgU6KjErI0Ppl927LQVcIw2YylDDw0/DPOQrnxfId1t7IoUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770843423; c=relaxed/simple;
	bh=TkREqohBHl3ty//vKQXEdChW+vrluRLMqZHL+wlIaz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp/nm2h4nRoh+ZIs7/PW2qgiTmXxk0Q5pqS4kXSBxVMoba3hDsX9mpbqD17BbkJxA6mY+YSimcK8ww3d8DNo+dwoLeITmWVlQ0js2Z8bNEb/xEqlxH27bvvwKsQqez4Az7LEZt36Wj0GFA0KpxX6h+w01Hma6HvfzpodoSocH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cBE+WZKo; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770843414; x=1771448214; i=quwenruo.btrfs@gmx.com;
	bh=MYcpYw5/BjfzTuRSqbSgSJF08RaOBDBXCBvd/9q3wEI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cBE+WZKo8kJOmRjVsbm+5ns5XUDHqmqamwINvNt3/6dkLDIL44xPHICCH+j/M8WG
	 rnKaA7FnJ1i8pXagZIrcAaQvEdoUl1kSaDNThZhkSHTiVBL2SMdPUzGDwKT6tzuY8
	 Rg1hbB3GvL+bPku64LlqeXOC2FSlo+obmMamTZqcjA9nzKdPNUbXoecs9QP1u7SJ2
	 wEBOrwYkHrky4LuHI98U4F4d7RDlrqgqQpCS+8IIp5YNEzUN8upawRJ6fNemX59Lf
	 HXJDwFcdEsrOeAwpECaSWEEWiyYukIWF+TsQXrG/VCFodXfHrcc5dPh1MivsjP0ok
	 Lsw+rR0R5WIkcFpvlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIwz4-1w69SW0s1q-00PhaH; Wed, 11
 Feb 2026 21:56:54 +0100
Message-ID: <537e0828-e061-4876-8285-98d3b2525141@gmx.com>
Date: Thu, 12 Feb 2026 07:26:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove out-of-date comments in btree_writepages()
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <f1694e9264f14706a274009aca35504f128c1df1.1770779554.git.wqu@suse.com>
 <CAL3q7H6p1ZirZ4cqGkjvU3oUSQcEfoYPLdchNS+94N=fCxO7DA@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAL3q7H6p1ZirZ4cqGkjvU3oUSQcEfoYPLdchNS+94N=fCxO7DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eZJS5YzWYYfOhDjYczpXPCtqCbD1PS7HLBSJfCAzM6lCh/Vyq5Z
 MlZPMhOGnZnygd5MX7xCdmWF9dKrZ5+5Mu+uYk6FvHtzam1OaEoNQf+rLTGdQGXbpvJUbFS
 jChBnNrTWxz7dBl7Q93yMK+qlnKDUNSt4X0yjKPBjk84zbyuguY14tH1ods4YdI86X5iKr+
 ahTGSy320g11QfgkNjNHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Iup7r87OPAs=;6Q3H8ravwbno8rY5rSryfoNY3En
 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
 cbnQue4tJjnPnpI/7gMkM5MWpceZN
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21636-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmx.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6E1C1278DB
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/11 23:17, Filipe Manana =E5=86=99=E9=81=93:
> On Wed, Feb 11, 2026 at 3:13=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There is a lengthy comment introduced in commit b3ff8f1d380e ("btrfs:
>> Don't submit any btree write bio if the fs has errors"), explaining why
>> we don't want to submit the metadata write bio when the fs has somethin=
g
>> wrong.
>>
>> However it's no longer uptodate by the following reasons:
>>
>> - We have better checks nowadays
>>    Commit 2618849f31e7 ("btrfs: ensure no dirty metadata is written bac=
k
>>    for an fs with errors") has introduced better checks, that if the
>>    fs is in an error state, all metadata write will not result any bio
>=20
> "all metadata write" -> metadata writes
> "will not result any bio" -> will not result in any bio
>=20
>>    but finished immediately.
>=20
> but instead complete immediately.
>=20
>=20
>>
>>    That covers all metadata writes better.
>>
>> - Mentioning functions no longer there
>=20
> mentioning -> mentioned
>=20
> But which functions? The only function I see mentioned in the comment
> is  submit_extent_folio(), which still exists.

Because it's wrong from the very beginning.

The original commit is introduced in commit c9583ada8cc4 ("btrfs: avoid=20
double clean up when submit_one_bio() failed").

At that commit, the function that can return >0 to indicate how many ebs=
=20
are submitted is submit_eb_page(), not submit_extent_page().

Function submit_extent_page() at that time can only return error from=20
alloc_new_bio() or 0.

So in that commit, the function name is already incorrect.

Later commit b35397d1d325 ("btrfs: convert submit_extent_page() to use a=
=20
folio") changed the submit_extent_page() to submit_extent_folio(), but=20
it doesn't matter anyway.

>=20
>>    It mentions the function submit_extent_folio(), but the correct
>>    function is submit_eb_subpage(), which can return the number of ebs
>=20
> I don't see any function named submit_eb_subpage() in current for-next.

Because it's removed by commit 5e121ae687b8 ("btrfs: use buffer xarray=20
for extent buffer writeback operations"), as I explained in the commit=20
message.

Thanks,
Qu

>=20
> Thanks.
>=20
>>    submitted for a page.
>>
>>    And later commit 5e121ae687b8 ("btrfs: use buffer xarray for extent
>>    buffer writeback operations") completely reworks this, and now we
>>    always call write_one_eb() to submit an extent buffer, which has no
>>    return value.
>>
>> Just remove the lengthy comment, and replace the "if (ret > 0)" check
>> with an ASSERT(), since only btrfs_check_meta_write_pointer() can modif=
y
>> @ret and it returns 0 or errors.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 34 ++++------------------------------
>>   1 file changed, 4 insertions(+), 30 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 3df399dc8856..9999c3f4afa4 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2386,38 +2386,12 @@ int btree_writepages(struct address_space *mapp=
ing, struct writeback_control *wb
>>                  index =3D 0;
>>                  goto retry;
>>          }
>> +
>>          /*
>> -        * If something went wrong, don't allow any metadata write bio =
to be
>> -        * submitted.
>> -        *
>> -        * This would prevent use-after-free if we had dirty pages not
>> -        * cleaned up, which can still happen by fuzzed images.
>> -        *
>> -        * - Bad extent tree
>> -        *   Allowing existing tree block to be allocated for other tre=
es.
>> -        *
>> -        * - Log tree operations
>> -        *   Exiting tree blocks get allocated to log tree, bumps its
>> -        *   generation, then get cleaned in tree re-balance.
>> -        *   Such tree block will not be written back, since it's clean=
,
>> -        *   thus no WRITTEN flag set.
>> -        *   And after log writes back, this tree block is not traced b=
y
>> -        *   any dirty extent_io_tree.
>> -        *
>> -        * - Offending tree block gets re-dirtied from its original own=
er
>> -        *   Since it has bumped generation, no WRITTEN flag, it can be
>> -        *   reused without COWing. This tree block will not be traced
>> -        *   by btrfs_transaction::dirty_pages.
>> -        *
>> -        *   Now such dirty tree block will not be cleaned by any dirty
>> -        *   extent io tree. Thus we don't want to submit such wild eb
>> -        *   if the fs already has error.
>> -        *
>> -        * We can get ret > 0 from submit_extent_folio() indicating how=
 many ebs
>> -        * were submitted. Reset it to 0 to avoid false alerts for the =
caller.
>> +        * Only btrfs_check_meta_write_pointer() can update @ret,
>> +        * and it only returns 0 or errors.
>>           */
>> -       if (ret > 0)
>> -               ret =3D 0;
>> +       ASSERT(ret <=3D 0);
>>          if (!ret && BTRFS_FS_ERROR(fs_info))
>>                  ret =3D -EROFS;
>>
>> --
>> 2.52.0
>>
>>
>=20


