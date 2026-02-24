Return-Path: <linux-btrfs+bounces-21899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM3RMIcknmn5TgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21899-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 23:21:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9F718D184
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 23:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3092301DAF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F20C3191BB;
	Tue, 24 Feb 2026 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bSdhGtJ8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E2263F34
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971698; cv=none; b=ocSCGLpwk3HIEaw1I3emDuXq16lMYqkds4ZtaA9TUK8jbQGMehmxEMzr/hjQWl2S35KAYTpuyFkTVUj8VhRRmPeJDyDcMNgjaItiCwR9jq4bBGQLSuDYppxl58lUgajKKlHlU1yAP5LmleA01GOBnAhTnJvFKdMABRtbMUKN2Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971698; c=relaxed/simple;
	bh=Y9jpPWx0p7azZT87cWArys6kYQlKb0BcNN/7X56kXbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQY28d0zOvdBcdw9qJo6EW5H0ZeApdGsEMyiAKKSVvW/3hVtkz/0xbKqOjC/pbr0ubMy+jD9rQquTIIG+liv+QKgGSwrN6D9q1HYw3P5b+zQJDQjUIwvUP1v+dMpFsk9lBDVpW5LHIXeNprrrAycYpsuuCZLEkFosc2YzzxHlLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bSdhGtJ8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771971694; x=1772576494; i=quwenruo.btrfs@gmx.com;
	bh=1pHFFe9b2m1MWHzFmazlTMcSRVDCPs9honinYYboMJ0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bSdhGtJ8PIPLpIHeukGFSXIeRma19ptppfxoxdvBBNf3e++u6raz8yc78uK34CSv
	 ywBNdTYnQORH/Pb2KO6Gpdg7r3DsJyRfE9WufIA9JrErCxjKhW1Bdp9qrF60gMB5F
	 g0NaB6f2yEJaE98e+1hKAzj1/eiIYRb91H+36OSCTLUg0SrPPRPPY1ndi8v+rfit5
	 xiSOM/RLiZYnFzvIJvkrqQZlxfwbwUvgJEZaxF23z+OsehHIUXs9ZRF9wnqGek137
	 ZsTO7lrgtGfsr+E79xxij6J8/hq6QseYleocbyoWbRCM5VPtbzye95o7CmPZnkUhL
	 rDtkoPuYXUEHGNsHfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4Qwg-1vkjSC0G6o-00tPOS; Tue, 24
 Feb 2026 23:21:34 +0100
Message-ID: <c6f5bcdf-2c26-44c6-9bfa-f77968bd5e76@gmx.com>
Date: Wed, 25 Feb 2026 08:51:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: introduce a common helper to calculate the
 size of a bio
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1771558832.git.wqu@suse.com>
 <4392c94fea9644702e3985c30cf0a30c434aa3d5.1771558832.git.wqu@suse.com>
 <20260224141518.GV26902@twin.jikos.cz>
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
In-Reply-To: <20260224141518.GV26902@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZYCf4AZLjnMdac4l7/+9mqUVJLvxz1XNpSJc0yzA99hOF2gzDQq
 Plls00alO580/xYH02dK9FteC6GTJz/rF3INl//uOLWdXPBeXfimdAsx22ZawnXOaHLQ931
 JAP9QTf08YPe8RDSNtawhqjezkDB+a7okb4NhiOWjNpDTxHMDxeEKVP/9b2W9PR1pAgiz16
 hFwDJLj8BSxkuidefKLnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bEjFx9n/04U=;fI+sgH80fTnYpzCDY34c71daUw2
 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
 EJK5auTNovasawkrY44Zps0t1OsBq
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21899-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmx.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 2B9F718D184
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/25 00:45, David Sterba =E5=86=99=E9=81=93:
> On Fri, Feb 20, 2026 at 02:11:50PM +1030, Qu Wenruo wrote:
>> We have several call sites doing the same work to calculate the size of
>> a bio:
>>
>> 	struct bio_vec *bvec;
>> 	u32 bio_size =3D 0;
>> 	int i;
>>
>> 	bio_for_each_bvec_all(bvec, bio, i)
>> 		bio_size +=3D bvec->bv_len;
>>
>> We can use a common helper instead of open-coding it everywhere.
>>
>> This also allows us to constify the @bio_size variables used in all the
>> call sites.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/misc.h   | 15 +++++++++++----
>>   fs/btrfs/raid56.c |  9 ++-------
>>   fs/btrfs/scrub.c  | 22 ++++------------------
>>   3 files changed, 17 insertions(+), 29 deletions(-)
>>
>> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
>> index 12c5a9d6564f..189c25cc5eff 100644
>> --- a/fs/btrfs/misc.h
>> +++ b/fs/btrfs/misc.h
>> @@ -52,15 +52,22 @@ static inline phys_addr_t bio_iter_phys(struct bio =
*bio, struct bvec_iter *iter)
>>   	     (paddr =3D bio_iter_phys((bio), (iter)), 1);			\
>>   	     bio_advance_iter_single((bio), (iter), (blocksize)))
>>  =20
>> -/* Initialize a bvec_iter to the size of the specified bio. */
>> -static inline struct bvec_iter init_bvec_iter_for_bio(struct bio *bio)
>> +/* Can only be called on a non-cloned bio. */
>=20
> Please also add an ASSERT for that.
>=20
>> +static inline u32 bio_get_size(struct bio *bio)
>=20
> 				  const ...

Won't work. bio_for_each_bvec_call() will cause warning, as=20
bio_first_bvec_all() doesn't have const qualifier for the bio.

And if you're on GCC 15.2.1, it will require much more strict checks for=
=20
const qualifier, to make sure all access to that pointer won't modify=20
its content.

This is already causing some proxy writes to cause problems in btrfs-progs=
.

We need to be more cautious with const usage with newer GCC.

Thanks,
Qu

>=20
>>   {
>>   	struct bio_vec *bvec;
>> -	u32 bio_size =3D 0;
>> +	u32 ret =3D 0;
>>   	int i;
>>  =20
>>   	bio_for_each_bvec_all(bvec, bio, i)
>> -		bio_size +=3D bvec->bv_len;
>> +		ret +=3D bvec->bv_len;
>> +	return ret;
>> +}
>=20
> Reviewed-by: David Sterba <dsterba@suse.com>


