Return-Path: <linux-btrfs+bounces-14880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A41AE5042
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 23:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9502E4A07D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 21:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5411221545;
	Mon, 23 Jun 2025 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HFZ02bZr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6A2628C
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713808; cv=none; b=GMq1Um/U3bOfP13Eq3aG12xPfOSosGLi/kWesd+Csr5jxJvbIBJHTu+I9egY9aqlaFYMY5Q4LPl/LNyEF92mu51prVH8lwNFCZGeHZwvmV/JILs/DZcjOOn3oP/kyBhDge0o7maVXqWofZCWcnHHyjEeuQ/vMmtlhHULoJ9hDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713808; c=relaxed/simple;
	bh=9CicCjhNj+4iAi8luML5NjGRO0T1ks+MKwZ40MQNMkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvPmKN5tVcqK+7y5SsMdFFSuRk51HpFKRkiwIzinS/v7T9O9rz5GQWiNSizXTObQQj2QHbmlyPxjSPT5TXh12STahwU9fHZTM+tkmRjcsksGWp9fprSMQE1xhrfjA6ES1GLiuzDAtLks4z5G9tKqdn4h8TIwpiT1eQIUXB+oBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HFZ02bZr; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750713803; x=1751318603; i=quwenruo.btrfs@gmx.com;
	bh=N15WvXYPYgRmq286MACza2HqpjEj4Y6pc3cXsJuBdN8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HFZ02bZr3cl8SDiHJTDHAayk9sDnoJVZxucHnv2iaU6flQe7msnhd2Kiv9+IL9eb
	 p/sbvDe9+ng+NaCIEt3xMe0gYVD/ohc1nXgSq6cgMxgvtGInCrQpLnPNl4ndU17ax
	 cAXBN+FMQggMH8m+PwkMWMgOpp6LTmF8m6uiBPHEpo0rGNNCIFcRsrpobEb5LDz/5
	 tIO5deoGEaPcbl272rR5ed9Gp9g/GOfdxBeti3Z9MEvRDMPrzg/dSXWgS2fOH0LOp
	 x6PjsQL47fOomjSWEAtF2hlT9iDQ14Y83Q+Ds3IOI7IJs8/db+Dh22b7v+tXLFhfe
	 dKPEbCFuy8vMQRDbvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VD8-1uo1I02OuQ-00z8SV; Mon, 23
 Jun 2025 23:23:23 +0200
Message-ID: <ade587d5-886b-42fb-be8d-1cef4486326d@gmx.com>
Date: Tue, 24 Jun 2025 06:53:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] btrfs: add comments to make super block creation
 more clear
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1750674924.git.wqu@suse.com>
 <c86ee5c7e8588b9755c66f6827dc5087de2fd910.1750674924.git.wqu@suse.com>
 <20250623151028.GB28944@twin.jikos.cz>
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
In-Reply-To: <20250623151028.GB28944@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OpfekOcTKiGrUVyV+O1JiEt4lsPcmmZ2xOiUkTiiNkmdKjp4vdg
 shG3IS/8Qi7Hus+iljfXXwdv0b8qMx9FjRN6PTIhj4ALk13AqDnBngYwKJHJSFbhjX3qeCF
 w5ZvIWQtNNvih+RVm4OQrTqqApY6oiZl7K5EwI1iHomoUtzyuszrsAROiefDwrQUroZTppk
 r7QIhk+R0QLsedEB3UkSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L+mxGbmV7l0=;cKrT4LD/1RKQB2KBS7VnGonOOWX
 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
 aJly7Q1Gr5ukbi9r



=E5=9C=A8 2025/6/24 00:40, David Sterba =E5=86=99=E9=81=93:
> On Mon, Jun 23, 2025 at 08:16:47PM +0930, Qu Wenruo wrote:
>> @@ -1894,6 +1885,20 @@ static int btrfs_get_tree_super(struct fs_contex=
t *fc)
>>   	set_device_specific_options(fs_info);
>>  =20
>>   	if (sb->s_root) {
>> +		/*
>> +		 * Not the first mount of the fs thus got an existing super block.
>> +		 *
>> +		 * Will reuse the returned super block, fs_info and fs_devices.
>> +		 */
>> +		ASSERT(fc->s_fs_info =3D=3D fs_info);
>> +
>> +		/*
>> +		 * fc->s_fs_info is not touched and will be later freed by
>> +		 * put_fs_context() through btrfs_free_fs_context().
>> +		 *
>=20
> There's a trailing space and this breaks 'git am' checks, and the line
> is also in other 2-3 patches. It's a bit annoying to fix manually,
> please fix it and resend.
>=20

Weird, checkpatch doesn't give me warning during commit hooks.

And that's the only tailing white space exposed by standalone checkpatch=
=20
run.

Mind to share where the other tailing spaces are?

Thanks,
Qu

