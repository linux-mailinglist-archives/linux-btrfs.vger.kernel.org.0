Return-Path: <linux-btrfs+bounces-13410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F4A9BB7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 01:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2C4468254
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 23:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92FD28468D;
	Thu, 24 Apr 2025 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PWTcWQzT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572877111
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745538954; cv=none; b=XXMbq0uAxM12jKl//tw6RbvSvqfnfFTGA3IopWziEZfOsudOfu/d0XFCA+IsmpFqsYcS81e/M5zeUOoZ6uWk1/oJNAAlLM6uaUX3QBLidp/dyrf8px4DTKpl2oogWd3VnAy+XOvz+fipZvaMhClw0IJiC+koOPLfVwm0lzmtmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745538954; c=relaxed/simple;
	bh=VYyuNzMBuIlcWPW6ukp8G51aSveMghQjNc3Xcp+d98U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asDCDKr6LjsDwL6abF6fhCUQIR4KPIk5U/BLzOqMsaOqNn3r3lNzUOpCaqJEwZl39tRIyvoB4waiHg0Lpo2gdvjGntZn8o1Zvib6m8f82YwOugGHO5QKAmbFSDcpDsdgcdKsOIA+x6ZLrHGjdWcKMJbQl0bSWk168Yaa3lnab8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PWTcWQzT; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745538947; x=1746143747; i=quwenruo.btrfs@gmx.com;
	bh=6XMCDHbTZK2EFZlObdBNcIrzKWFRlilyDFnrvXuRKZc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PWTcWQzTdIgTdsEcGGdfNs95J0XRLXLRDGxl69oHHBXqr1BwyMlm+8TFfz9xOsMU
	 HwMVVSBfU+s/5/R6kmYICVO3GCP/jLe3YQASN8OT9F0Qcm6EGg2UlrixIs8tujNOE
	 OWb6A7zS+jRRdG6Q2SaEaCr2uhKeVt5IliYsjbjQK66gRCeP6qPOa5gmrs6g43qYg
	 dR7iwGINDPQZyE+c8Ha6diQK2k31BSyRRjROhPkf9VaON5TR61kF+ins39XGpcmzv
	 IQrwo9h4CYJSPgHIqtotBrwRXeieVRByEe7KDQybYWRmwNJ/MdqkPJx2m9MT6Yvny
	 EidpXWZq2XbjRfweJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4b1y-1u8e7I2zTS-005Fwg; Fri, 25
 Apr 2025 01:55:47 +0200
Message-ID: <96476d42-cd88-4f88-9888-81d818c2bf07@gmx.com>
Date: Fri, 25 Apr 2025 09:25:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix folio leak in btrfs_clone_extent_buffer()
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <3a03310eda52461869be5711dc712f295c190b83.1745531701.git.boris@bur.io>
 <9b32db21-e116-4eb5-9a54-7cc23a737523@suse.com>
 <20250424232519.GA321466@zen.localdomain>
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
In-Reply-To: <20250424232519.GA321466@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JlG/kt28BY7xZKXToWJ8Q3xG9hfDs2dW2gLiYQaMKfGHCEbuYX0
 EIzdxsR9MqGj55kulTMfSZF0LnwAIpMuap+owDXxjcAkYqJ46ZHNABHDtvh+xxubHrzBdC9
 YWhXyGzgKszOLvaR2ABvvtd8I1024w6afJH7i1AfAUB4fAm9UJCugUosJlGrHlRoi7dA4Et
 gb3w5a9PSA5LBddrSPk1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pz596UALxZY=;0KsQq3sFA1RY7DBcQgfPlIJAmRM
 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
 w==



=E5=9C=A8 2025/4/25 08:55, Boris Burkov =E5=86=99=E9=81=93:
> On Fri, Apr 25, 2025 at 08:11:34AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/4/25 07:25, Boris Burkov =E5=86=99=E9=81=93:
>>> If btrfs_clone_extent_buffer() hits an error halfway through attaching
>>> the folios, it will not call folio_put() on its folios.
>>>
>>> Unify its error handling behavior with alloc_dummy_extent_buffer() und=
er
>>> a new function 'cleanup_extent_buffer_folios()'
>>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>>    fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++-------------=
=2D--
>>>    1 file changed, 35 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 152bf042eb0f..99f03cad997f 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -2829,6 +2829,22 @@ static struct extent_buffer *__alloc_extent_buf=
fer(struct btrfs_fs_info *fs_info
>>>    	return eb;
>>>    }
>>> +/*
>>> + * Detach folios and folio_put() them.
>>> + *
>>> + * For use in eb allocation error cleanup paths, as btrfs_release_ext=
ent_buffer()
>>> + * does not call folio_put().
>>> + */
>>> +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
>>> +{
>>> +	for (int i =3D 0; i < num_extent_folios(eb); i++) {
>>
>> What if we hit error attaching the first folio?
>>
>=20
> I believe that attaching the folios is not relevant to whether or not
> they are NULL.
>=20
> eb->folios is filled out by alloc_eb_folio_array() which returns 0 only
> if it allocates all the needed folios and sets them in the eb array.
>=20
> And we don't call cleanup_extent_buffer_folios() from paths where
> alloc_eb_folio_array() failed, we jump straight to the release_eb label
> in those cases.
>=20
> This is further supported by the calls to attach_extent_buffer_folio()
> assuming eb->folios[i] is non NULL. Finally, I don't see any logic in
> attach_extent_buffer_folio() that would set eb->folios[i] to NULL.

My bad, it's indeed the case.

Reviewed-by: Qu Wenruo <wqu@suse.com>

>=20
> If you agree with this analysis, I can document this more explicitly
> than just the ASSERT as a pre-condition of this cleanup function?
>=20
> Alternatively, I was thinking of a no-functional-change followup of
> making folio_put() an optional step in
> btrfs_release_extent_buffer_folios() so that it can not call folio_put()
> during normal ref count driven frees but to call it in these cleanup
> paths.
>=20
>> In that case eb->folios[0] is still NULL, while num_extent_folios() wil=
l
>> call folio_order() on NULL.
>>
>> I think we need to enhance num_extent_folios() to handle ebs without an=
y
>> attached folios.
>=20
> Not a bad idea! Return 0 if eb->folios[0] is NULL?

Sounds good to me, as another cleanup patch.

Thanks,
Qu

