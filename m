Return-Path: <linux-btrfs+bounces-19739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D369BCBD463
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CF25300E814
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7BA31577B;
	Mon, 15 Dec 2025 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CtXFnu9s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F317A31C
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792273; cv=none; b=rMKyEV5IyRMQsAQnpBVsDN0ukWZUou87/mRKxtqrHlo/9TxNAjfBkJC0AdXc9cO7ulXjm9THmrnLdQtaBgubL/LSWqWST8xKOzFEUj+xqHJOKEZ0jy5o9RKTigwraATZFwYqY/KYuPsVtIkW7Oku6OudF7ZLjjrjELEv1KIW/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792273; c=relaxed/simple;
	bh=lDn6SNANa/xoI8jJ1suVN8XCMFhZjudJx1sr57Runtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ftpnf+DMKHhhpQzxmLyrQ1YjXXY8N01QmG5/PTdUBAlqBRALNOm/iRMhpMFXGmjCFjMwOXt1pKMt6IPA6961tzUj39QVDGNXlkXimkGyOY/3iM5Wgy/oxfVZyrQN9d38bAgDNa6ul8ukboggVPFx4XbuEHlL3VOAQfVEB436AP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CtXFnu9s; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765792259; x=1766397059; i=quwenruo.btrfs@gmx.com;
	bh=V4njnLBV4tKrPPgQdxqgCtXepGMIINfTNVb1wRXrq8A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CtXFnu9sROD3ipQls974i+7OR3TOXAfyhe3bEVnfFAs5XuRu+0A/WGGOirsNo8Jk
	 If0Gs0ZZJHLAbyoRKC4ZucjTufbaBsn0R30K342JU/+JgRcQOKKI/XWtvf/xRHBAu
	 UwXwzjCZwAG0gyBViOQHEMpBW0aC4OckZqPF90hSmGRVQjb2IDSW2W+guEkTRBMMp
	 6UBTJ5OSxtGswsYX7ihmdNNgmA3u3Y6HtLLW1bAZw0ENs1c30Dreps1BYi6NYXnAN
	 0kFB4IT1f6OKXOAcu5r+6wqyIGVrA16mMUiT7grlbS+jgRaM08G3safymzOWPxLMj
	 62LTNA9IQagSX0XwRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhD2Y-1vzAvI39dK-00n2No; Mon, 15
 Dec 2025 10:50:59 +0100
Message-ID: <f2bec37c-0230-48d0-993a-157b4a9031cb@gmx.com>
Date: Mon, 15 Dec 2025 20:20:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: update stale comment in
 __cow_file_range_inline()
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1765743479.git.fdmanana@suse.com>
 <edd0445538783749845d7b1911737237a41595ff.1765743479.git.fdmanana@suse.com>
 <24e5d07f-322d-4eba-9aaf-e9f4be027bd6@gmx.com>
 <CAL3q7H6Vkz53Edf=i2+yKpqs7mQt_qqZiveV43L1qU8cK8WEvw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6Vkz53Edf=i2+yKpqs7mQt_qqZiveV43L1qU8cK8WEvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S40Aexffo3sq3GLo6w4NAbMsK+7czbYH+5vC/9maE4/zUnzVCCF
 AVKl8kqqZtFQNaqb3Z2XSFBmvrYDI6YqcVDDqcNHli+n4f2HZXLjrtjCwdPkBj40YaLYubA
 ruSvkXR4N2Gm4/O8Z7AE6Py0kqxgIJPWWLGWkUns2/kOLOsRWyEnAxElPldmkHwRmx/Z9uj
 phUenJTw6RFscv+WYZtQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xGFuibg8Sa8=;COvkiD6mKApvVufYVFy3zamV0Xt
 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
 yILRerIk=



=E5=9C=A8 2025/12/15 20:19, Filipe Manana =E5=86=99=E9=81=93:
> On Mon, Dec 15, 2025 at 9:47=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/12/15 20:08, fdmanana@kernel.org =E5=86=99=E9=81=93:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> We mention that the reserved data space is page size aligned but that'=
s
>>> not true anymore, as it's sector size aligned instead.
>>> In commit 0bb067ca64e3 ("btrfs: fix the qgroup data free range for inl=
ine
>>> data extents") we updated the amount passed to btrfs_qgroup_free_data(=
)
>>> from page size to sector size, but forgot to update the comment.
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/inode.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index f1ead789146b..6ae36cc5bcda 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -676,7 +676,7 @@ static noinline int __cow_file_range_inline(struct=
 btrfs_inode *inode,
>>>        /*
>>>         * Don't forget to free the reserved space, as for inlined exte=
nt
>>>         * it won't count as data extent, free them directly here.
>>> -      * And at reserve time, it's always aligned to page size, so
>>> +      * And at reserve time, it's always aligned to sector size, so
>>>         * just free one page here.
>>
>> There is still a "page" reference here.
>=20
> Ah yes, I will update it before pushing to for-next, thanks.

Oh, forgot my tag.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
>>
>> Other than that it looks good to me.
>>
>> Thanks,
>> Qu
>>
>>>         *
>>>         * If we fallback to non-inline (ret =3D=3D 1) due to -ENOSPC, =
then we need
>>


