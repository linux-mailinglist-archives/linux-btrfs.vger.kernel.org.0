Return-Path: <linux-btrfs+bounces-16329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B4BB33A15
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 11:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7876E7A1B63
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633FE2BDC0A;
	Mon, 25 Aug 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KiBRuYf3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317820013A;
	Mon, 25 Aug 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112601; cv=none; b=snmXh0VDWLh3hE9i1wGT11/kyJzVa5HmemVasNcwbBIBbrTzFEalEQj7ySFB3ga4dlimvmHO+i6n/WA//q9KllQ3Nzq0QFscRDanty2qHFlXyNLQjVGxdm3bWNrZuH35AJcT3W/iGF4HkWro1lG11XGfXZhvwnUdTWEJznm6wzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112601; c=relaxed/simple;
	bh=GpMMXXtrrro+KyCTaVM/3scprUUxl3ko8HdPHlOnIn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeIzQk/SerMa0RyitVWE8RT5g4cARehlcpijjtdL5DEzTVGpdosDk6bSfPd254XRHby0Nf+syXZDzSNb5PbT3L/FZcx8Luvu+DHp8zXIwjHZCHw7hoju0aQaDX+8hvflMz92zTIHQ4L5whAz2BcUUbfORHilF7tUFe7LhSFcsGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KiBRuYf3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756112596; x=1756717396; i=quwenruo.btrfs@gmx.com;
	bh=8KacQJQEil5Z7jBxn6gRL6DKh3haZB2rdJQMAwnPR2k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KiBRuYf3GmsaKFj9SP24QempbNpt5hYQxl8i9QBJXrJQngo9tRbfO0WMUFyV9yom
	 BSFI+oZw4CshaNY1DV4HRrX0JTY5R0N1eQCtevnFPluNpfiokQUtjZANwOKwVMZ5j
	 3WKBvwGPHcO3kWb/xVWd4ll/QRd2mcPEAS+Lm+TlZahku4dHIp8dV2MqcjXMP2a8p
	 bhPxD0WyyVRbyvnm5DUEDEfl0qt/TObp95LdQtOHike0Vn5EaAveDUqA/HStRO0v8
	 /oRiKzuCvI2POYcHbz5G/MQSM3d3yHhdvMh0+w/pvOZ0IZbkAta+kE4+sxM1DJnso
	 Vxa5fcAnXHMg1EtPfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsnF-1v57HS2rdN-00SQ0K; Mon, 25
 Aug 2025 11:03:16 +0200
Message-ID: <663c2f5b-3bb1-4a40-b962-11c6d3a7f806@gmx.com>
Date: Mon, 25 Aug 2025 18:33:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
To: Daniel Vacek <neelx@suse.com>, Calvin Owens <calvin@wbinvd.org>
Cc: Sun YangKai <sunk67188@gmail.com>, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <2022221.PYKUYFuaPT@saltykitkat>
 <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>
 <aKiSpTytAOXgHan5@mozart.vkv.me>
 <e9a4f485-3907-4f1e-8a74-2ffde87f3044@gmx.com>
 <aKj8K8IWkXr_SOk_@mozart.vkv.me>
 <9cacdafc-98ec-4ad2-99a8-dfb077e4a5fb@gmx.com>
 <aKs2mCRjtv3Ki06Z@mozart.vkv.me>
 <CAPjX3FeOEg+QhkwKWe+qDH876bp6-t1GFO0sce7a6bmhM7umpw@mail.gmail.com>
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
In-Reply-To: <CAPjX3FeOEg+QhkwKWe+qDH876bp6-t1GFO0sce7a6bmhM7umpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:prcna7STclThLT6oJPiqCCvNUR5Lm/tRVoIUmJRsyjh99v4JTFZ
 YvbgBUgNZis9wepHq3VHN8PTNppl5oNZG26NJr9dUXhYBwl205KLIc7hIjgOO6fThqkbPaz
 VqjnARj1or1T4xbp28yI4gGvbkBl6+BisT4KvWOuLxMGHdlSQbjRBHGBNWktipiGEV1KwAv
 ABLvS7T5RXgKbzS8+hKXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OguBIZoJRww=;I5JFtqNRWkHKeTyzwEaw225ONGq
 +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



=E5=9C=A8 2025/8/25 18:21, Daniel Vacek =E5=86=99=E9=81=93:
> On Sun, 24 Aug 2025 at 17:58, Calvin Owens <calvin@wbinvd.org> wrote:
>> From: Calvin Owens <calvin@wbinvd.org>
>> Subject: [PATCH v3] btrfs: Accept and ignore compression level for lzo
>>
>> The compression level is meaningless for lzo, but before commit
>> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
>> it was silently ignored if passed.
>>
>> After that commit, passing a level with lzo fails to mount:
>>
>>      BTRFS error: unrecognized compression value lzo:1
>>
>> It seems reasonable for users to expect that lzo would permit a numeric
>> level option, as all the other algos do, even though the kernel's
>> implementation of LZO currently only supports a single level. Because i=
t
>> has always worked to pass a level, it seems likely to me that users in
>> the real world are relying on doing so.
>>
>> This patch restores the old behavior, giving "lzo:N" the same semantics
>> as all of the other compression algos.
>>
>> To be clear, silly variants like "lzo:one", "lzo:the_first_option", or
>> "lzo:armageddon" also used to work. This isn't meant to suggest that
>> any possible mis-interpretation of mount options that once worked must
>> continue to work forever. This is an exceptional case where it makes
>> sense to preserve compatibility, both because the mis-interpretation is
>> reasonable, and because nothing tangible is sacrificed.
>>
>> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount optio=
ns")
>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>> ---
>>   fs/btrfs/super.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> v3 looks good to me. The original hardening was meant to gate complete
> nonsense like "compress=3Dlzoutput", etc...
>=20
> Reviewed-by: Daniel Vacek <neelx@suse.com>

Now merged and pushed to for-next branch with the latest reviewed-by tags.

Thanks,
Qu
>=20
> Thank you.
>=20
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index a262b494a89f..18eb00b3639b 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -299,9 +299,12 @@ static int btrfs_parse_compress(struct btrfs_fs_co=
ntext *ctx,
>>                  btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>                  btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>>                  btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>> -       } else if (btrfs_match_compress_type(string, "lzo", false)) {
>> +       } else if (btrfs_match_compress_type(string, "lzo", true)) {
>>                  ctx->compress_type =3D BTRFS_COMPRESS_LZO;
>> -               ctx->compress_level =3D 0;
>> +               ctx->compress_level =3D btrfs_compress_str2level(BTRFS_=
COMPRESS_LZO,
>> +                                                              string +=
 3);
>> +               if (string[3] =3D=3D ':' && string[4])
>> +                       btrfs_warn(NULL, "Compression level ignored for=
 LZO");
>>                  btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>                  btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>>                  btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>> --
>> 2.49.1
>>


