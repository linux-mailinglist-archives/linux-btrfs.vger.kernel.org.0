Return-Path: <linux-btrfs+bounces-21896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIPOCQwSnmlsTQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21896-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 22:03:08 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF40D18C932
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 22:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F5AC3094CCE
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 21:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CCB33B979;
	Tue, 24 Feb 2026 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Y+Dd/wvO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93344304BB4
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771966980; cv=none; b=jke7382XhyWHG7QmXLLqUtbqaepoCbyCkak1k+r/r+eawETn+AM3KGKUaaun4wyp5prXirjdAyifxJZ3FYfSxKJh+3Gqej2N82KK+ejm5YEmf4qlHMNr6y6X5nmDaYzh0zk8sOetngU8T2+ROYO8Hrf4lda2RmvhgDF4yQBNStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771966980; c=relaxed/simple;
	bh=64P66YZDQIT0Nu6P55JGFIJIGViP+GXP69o73Iu6XL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0FmDH+5HxqyN+xKadXT2F/0Lab2u0jKNx5tLhpIKkZliBOyavoHJI+kEBP5KYcalclFy+pHqCvfe+x8OD5PqGwRkMpFcI3wT8xkH7BCabVU240PjC1SNC6+k6nLQ28LENqFMRak8oXR9BU0vXpJHR3cLlGdRJsSWhns3NZXiGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Y+Dd/wvO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771966974; x=1772571774; i=quwenruo.btrfs@gmx.com;
	bh=VNIv77/QVhwSZvkHJ8b6yY91W4ipTQVqYl53kVH5uUA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y+Dd/wvOUlciiSl+ElmOH0YOclKhndhcRFswh9Ca0iVc4BzaHbG3bWVGrJ2NGd4q
	 jf47Z1Q2ZDnXzV/T3LGanqZcMdkd9yaB/MHbuXjTXuY0T1a6JxvYs/Q1OseWePiR9
	 4JhqJJ+2XhBvLDoRywYlzrugjd6E/Ua73o/l7VxP99AI1kVyESd4xQm+gqXKc8XcL
	 p4dSK+v5x0vBKV1DveRGdgyMD2lMdyl2wrHoXN+ns8CCLGkI/xXQjXP5mAipsY2DN
	 98iAgIr+5HZU1odu9l0dL0EFJ0DBQsEEtLIXO1Glal+lfv3gida/M4Dw/Qb6w3vbS
	 s2VESzxyFNSIgn2DYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3il-1wJ1mA35xb-00IhRU; Tue, 24
 Feb 2026 22:02:54 +0100
Message-ID: <b040a823-cfe7-42b2-97b4-3f6ba80f98d1@gmx.com>
Date: Wed, 25 Feb 2026 07:32:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: introduce a common helper to calculate the
 size of a bio
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
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
X-Provags-ID: V03:K1:48RpUkf3kvmehWb74fJ8iYKDDY/lX5fiiTsJiQllJDZwn3Z+9df
 4IjJCNAYnHedcLsf32x/4P81NLy570a3EgJkZlbr7Bpbe0TC5710lwjjxZ8aaxFpk9QYa8I
 6v4kPvPe3WcI8fSTt5Uvnng9w7QHbmBakrP68fPc1c36bdzrsCjQPsC/che7Tb7e1V0a+IK
 o4cgW64H1VFG3Y3tIk7qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Sp2ZlwkiuRI=;/ylpFm88OKGVTFRZywXwq70U/7R
 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
 qYu5uqYI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21896-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: AF40D18C932
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

You know how I like to add ASSERT()s almost everywhere, but for this=20
it's already implied.

bio_first_bvec_all() has a WARN_ON_ONCE() line for it already.

Thanks,
Qu

>=20
>> +static inline u32 bio_get_size(struct bio *bio)
>=20
> 				  const ...
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
>=20


