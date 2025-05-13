Return-Path: <linux-btrfs+bounces-13973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B215AB533E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 12:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A543A5C4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613332857FD;
	Tue, 13 May 2025 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gzgDtCOv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3831E501C;
	Tue, 13 May 2025 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133643; cv=none; b=avWNDxwX55hRBcrePP1+9CAoRk9Utir63wb6BEjRdR7GI8xU9md0Y9IZBoQH2gmxTX457D2yBXuwJHg2trGY4tpld+rtdo0gsNP4Yg3R6IiMZiIqMv7i3/i04Mt4ooPFYe+BS802FTsrF/6lTZfswl2TcucZF0lpeFRvZr6XR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133643; c=relaxed/simple;
	bh=Nl/9lgYZEoD5DmJLfqkpiWEuaiXLbuaKDGdyY3rd9pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HRYAfYHR/1dPz4dfBEsFK+FwBFWX2o/NFqvocnCfMP48xkPaN6x97dfJlAQ2FKzi3xeyi2dx48uGQsboqv2cFStJ8+MOwbEjfD4uFPPEthx/mc0vOoyJPx4ySj1OM04KgzfVT7BUJ+7V3cJrGPTBvnJO9T2fiXXdTMVNX4MCJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gzgDtCOv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747133638; x=1747738438; i=quwenruo.btrfs@gmx.com;
	bh=Tis3RHspPSqt5I21dRHFLNOlpRe7FGK2DZIOS1XVNsI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gzgDtCOvLHX2XDoWEgmzUPbsi2Lu788YtRxt5h9EnVk/Jhnq7m61LOJ0Lx8hH7X4
	 HtKbSbEa5MSDmAzx9LrcCrpIFu/FbnTvhfG4tbEEvDZKbsVtRsKxFpc/Duy7GQISj
	 wN7sG3CRv1J7e2mLa73mWRaJJfDnd3Hu/nHAFgf6cOi++1oejVC75niNlh/+yNyN8
	 eP3nsGEtitTILe7KS1JSfOyjVOlvpbwjHzCmdcLp1sHKC9qOQ/fYFVPIsadyvMMng
	 Twt1kkhn204iWDbVQgjkdm+y7KJi6+Fph7c1OCyW8utzwoVOXBHQnQX7pcBkrklJV
	 obI+/dOXr7qWiIRFlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYPY-1uuknd3FEG-00mVc0; Tue, 13
 May 2025 12:53:58 +0200
Message-ID: <beee9078-8d6b-4788-9cb1-0d7ee6a6b78e@gmx.com>
Date: Tue, 13 May 2025 20:23:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/220: do not use nologreplay when possible
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250513070749.265519-1-wqu@suse.com>
 <22cdcf91-92af-45f9-ab5b-dc08455f0ba9@oracle.com>
 <05ac7288-ca4a-4da4-8cb4-54389021640f@suse.com>
 <760d5562-a9d2-4e64-9032-dd4008aeaf0e@oracle.com>
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
In-Reply-To: <760d5562-a9d2-4e64-9032-dd4008aeaf0e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OYlzMOM5q1h3zpj5bP37qCR3GwxWj8MrNzg2xzBHIh/2f4h7lwJ
 VBAQtgWYDekreLffEYNHAuDTEaJV8l6D8TNIQ5ZPdp3Qo7cZ6G1vwbqDr17GUTBjDABrudw
 iOAVS8BrD8S0VH/skA47dKXgGaS4QXUeNNuzRWtmbykiMuyhoF699kKtco7A+ewRHB/B4qP
 2FFlDyyf3sTJ0bV8M58EQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gHgzfvPUDkk=;CjK5ZVmmxsTMz3iHziA5sefvuR5
 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
 ip6fU/3l3e4rMGVtjW8qroAMCY0/TFICBs



=E5=9C=A8 2025/5/13 19:46, Anand Jain =E5=86=99=E9=81=93:
> On 13/5/25 16:56, Qu Wenruo wrote:
[...]
>> I'd say, if some option is deprecated, we should not use it at all.
>>
>=20
> It's marked as deprecated, but the code still needs testing.
> Also, since fstests runs on stable LTS kernels too, it's better
> not to remove it yet.

For older kernels without "rescue=3D" alias, it will not cause any problem=
=20
at all, because it will set "enable_rescue_nologreplay" to false and=20
completely skip anything related to "rescue=3Dnologreplay"

But different vice-verse, as "rescue=3Dnologreplay" still touches the=20
older one.
I do not think we will keep the "nologreplay" support in the future very=
=20
soon.

In the past we had some problem relateds to "norecovery" mount option,=20
deprecated it and reverted back (some other projects still relies on=20
this mount option, and all other fses have exactly the same named one).

But "nologreplay" is btrfs specific, we can remove it any time in the=20
future.

I think this is the perfect time to considering removing "nologreplay"=20
completely.

Thanks,
Qu>
>> Filtering out the warning may ignore some other problems not related=20
>> to the deprecated option, thus I do not think it's a good idea.
>=20
> why not something like:
>=20
> (untested)
>=20
> _filter_deprecated_warning()
> {
> # mount warning:
> #=C2=A0=C2=A0=C2=A0 * btrfs: Deprecated parameter 'nologreplay'
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0grep -v "btrfs: Deprecated parameter 'nologrepl=
ay'" | grep -v=20
> "mount warning:"
> }
>=20
> test_mount_opt "nologreplay,ro" "ro,rescue=3Dnologreplay" 2>&1 | \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_deprecated_war=
ning
>=20
>=20
> Thanks, Anand
>=20
>=20
>> Thanks,
>> Qu
>=20
>=20


