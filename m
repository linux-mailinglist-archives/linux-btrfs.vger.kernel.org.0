Return-Path: <linux-btrfs+bounces-1816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C566883D074
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 00:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEB228F737
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 23:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A212E49;
	Thu, 25 Jan 2024 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kiSCfJAO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3542111A1
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224503; cv=none; b=HpNgirYrGauTmdb12SYgaF9b7bSx3y5y8mWhr0OIWRyO8bXh7EOD5EmmFf6sG/MqYnCOJ5eDv7BdOsDRWTYlawvbrykwhGeoq1FUOOJCerVa4c+j9PN3jxNCMYPynbF3DDAIreatuhuMeUJk4ZUqIfEFpcZhUBWiAy0FKq2H+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224503; c=relaxed/simple;
	bh=lRtzX0IeT9nd3roTzm1pIVcWC+NRzW7gbWTdVC8JUPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTTuRevIkEW8qNmCFv+aAakNyi9pQqz1sPtGVhjVrfvVNacuq1WDrC0sm7jUOPgH7v+jzepo6FCz9AN4FOLb0ROt8j2xwE7c423LP964ipn7L62FVkb6haVWhdMi8nn394prOycx0W5xo2hymxfnhm130XXeiAvCyo76NR7Zk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kiSCfJAO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706224496; x=1706829296; i=quwenruo.btrfs@gmx.com;
	bh=lRtzX0IeT9nd3roTzm1pIVcWC+NRzW7gbWTdVC8JUPE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kiSCfJAO2MkrtCG/78CNImI/yPVvK+QJRB3BFu5OjCeUFMxdjFp6EuWxTJJoJa81
	 umHrm7QOzRtoBihL+ySjU/uD+Q6Hnx1yjM37t61R0watMEUgtwy2TpjWsQk/DUu1r
	 cwMNIQnfeEUi+QaxLTEVU5Gj2SECA5rDH2DW23JbowUV7FMp2vg8XgsarBHYqA2ZK
	 09qSGfvO0d1++XhjtC0G54slRCrj22QZlFdsMlAFCKgSaXKjdCoyOy35lT/TeNu94
	 hKX1Ip4xrv+kOM9UrUPXF6xZDOj5Yc8QMKDUnaEECa2O/tcq97z51ijoeOPK8M5+x
	 2um+vdjN4pjpswPB9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyuc-1r7VY92Byo-00x1Sf; Fri, 26
 Jan 2024 00:14:56 +0100
Message-ID: <94ce38d7-9a02-4d7a-a5d3-2e703eef121e@gmx.com>
Date: Fri, 26 Jan 2024 09:44:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] btrfs: handle invalid root reference found in
 btrfs_find_root()
Content-Language: en-US
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
 <0011782bc0af988fc393ae8cee8b2d761def05d4.1706130791.git.dsterba@suse.com>
 <73f3c94a-7661-411a-8c86-f309d3acd329@gmx.com>
 <20240125162818.GP31555@twin.jikos.cz>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240125162818.GP31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QhEOPaFpY+/H1fQjDMVFBdLJ9KwNtcatoCfYjd33GsvOCa+5Utp
 iQQlwD/9LdIo2VmrOFC5uoraS+OYgOLIjbXRG1HjV2alihjxa0UnhzAwNAkL+ytmCxkDLX7
 GC9z0T+pMo9145P+AiEB8Ciko5a0FHy4SqdMkVQbmFIuHcB3sMYrWp8NObQ7aOGhKY+NUoN
 gZXLfSveUwI9fo33Du8/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LCeFXb11cVs=;TL5d4AmqLD8TxvlCbAE3YrXzJPT
 xiWD+DFevvrRQPgOcl3SE5fYjJxTS6cckroGi7myv66Bp0+L7kwz5lGGdH9H/S/ceFNQEGBbW
 NhjWuvCK/ySou7+eSE/MPy8TXAWSbZrI0w/21u7Yk08eGpZcXYpmdRfh5O6NvskDge7jBsZ/8
 q63HxER8ml6WYcyYINk3OVUDXk8y8EL20Zn4yv6T+e1dph6Dn9/726oM7Y7f7UbFs3aXM8bHY
 5Jm5etf/FmvNyYUhWPF0ZDlebQh/+5xA8QbMNYAUhTO2Ugu1qAp1MqoenfqGIxjWQ959ekCqW
 nhMOAQdRTizGm3gc7Xxrmr3zNqTWvYSfXeARpWYWQ9N7HXJRhW02lAeUtEwV2BqIx4jJyOGnm
 7kDHztLw+kGwMxZuHdIbg9Fo+CDMEAIykbwRrZ1fCWxsCp1eDl1QVBl4s2x0aqAvYZ1DVlkrW
 BEgCmBi9YUf8DHh8lxvCsTRV14FgKIaQ0RjQvBNCSAuxkbPZz2727zC/YNS4wMM49eAdj54dR
 tdeOQ34pvbsLl+EjvBFTiDVHsBeOehkFUu2OmJFVVK54orsdm29PSxkJkcdpIbzDL6XkTZO2v
 bajdg38duWDKHk/G0cnP8YnkHY7+8maRO5KgzS7SyHstl1Og2tluh1nKEsCAtYo1znSdkv8ay
 +4IFTJS7rjyvVFXdxyosOOeHjjgntdItgJMSZPDRdsM+2sYOBzxMY0jVKBH1N2bYZX4UaybFZ
 06p5DN7GVHIHZe03aYRYWxe86vlWtio65P/opKyV9R9KLpD3Ymle4uBU8/JGICV/66RwbMq9s
 hVRJPuOK0PBvoetTdomG6LfJX5c8B7mfJ/V/yMJjtgHvCfJGkPeEnrWLBf+YLrB0nGcONQRbr
 Qpd2kaxrrN+0wAh+jKvWzJ1oI5BqC+9OIQ+X7N7Vi4HqB0ohmk0fHqgT6gLUKMyUMItVbnwcR
 mU9PSQ==



On 2024/1/26 02:58, David Sterba wrote:
> On Thu, Jan 25, 2024 at 02:33:53PM +1030, Qu Wenruo wrote:
>>
>>
>> On 2024/1/25 07:48, David Sterba wrote:
>>> The btrfs_find_root() looks up a root by a key, allowing to do an
>>> inexact search when key->offset is -1.  It's never expected to find su=
ch
>>> item, as it would break allowed the range of a root id.
>>>
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>> ---
>>>    fs/btrfs/root-tree.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
>>> index ba7e2181ff4e..326cd0d03287 100644
>>> --- a/fs/btrfs/root-tree.c
>>> +++ b/fs/btrfs/root-tree.c
>>> @@ -82,7 +82,14 @@ int btrfs_find_root(struct btrfs_root *root, const =
struct btrfs_key *search_key,
>>>    		if (ret > 0)
>>>    			goto out;
>>>    	} else {
>>> -		BUG_ON(ret =3D=3D 0);		/* Logical error */
>>> +		/*
>>> +		 * Key with offset -1 found, there would have to exist a root
>>> +		 * with such id, but this is out of the valid range.
>>> +		 */
>>> +		if (ret =3D=3D 0) {
>>> +			ret =3D -EUCLEAN;
>>> +			goto out;
>>> +		}
>>
>> Considering all root items would already be checked by tree-checker,
>> I'd prefer to add an extra "key.offset =3D=3D (u64)-1" check, and conve=
rt
>> this to ASSERT(ret =3D=3D 0), so that we won't need to bother the impos=
sible
>> case (nor its error messages).
>
> I did not think about tree-checker in this context and it actually does
> verify offsets of the item keys so it's already prevented, assuming such
> corrupted issue would come from the outside.

If the root item is fine, but it's some runtime memory bitflip, then I'd
say if hitting an ASSERT() is really the last time we need to consider.

Furthermore, we have further safenet at metadata write time, which would
definitely lead to a transaction abort.

>
> Assertions are not very popular in release builds and distros turn them
> off. A real error handling prevents propagating an error further to the
> code, so this is for catching bugs that could happen after tree-checker
> lets it pass with valid data but something sets wrong value to offset.
>
> The reasoning I'm using is to have full coverage of the error values as
> real handling with worst case throwing an EUCLEAN. Assertions are not
> popular in release builds and distros turn them off so it's effectively
> removing error handling and allowing silent errors.
>
Yep, I know ASSERT() is not popular in release builds.

But in this case, if tree-checker didn't catch such corruption, but some
runtime memory biflip (well, no single bitflip can result to -1) or
memory corruption created such -1 key offset, and ASSERT() is ignoring it.

That would still be fine, as our final write time tree-checker would
catch and abort current transaction.

So yes, I want to use ASSERT() intentionally here, because we're still
fine even it's not properly caught.

And again back to the old discussion on EUCLEAN, I really want it to be
noisy enough immediately, not waiting for the caller layers up the call
chain to do their error handling.

Thanks,
Qu

