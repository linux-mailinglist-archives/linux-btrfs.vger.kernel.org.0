Return-Path: <linux-btrfs+bounces-5268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3008CDDB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 01:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0CC1C219C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 23:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9931292D7;
	Thu, 23 May 2024 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XVh1PbfB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93941292CE
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506601; cv=none; b=tBKRbtCA1egk1ZXR3z6nFTggmQWp1w1+doDQ8IQd1zXNsf/M3C2jVCIn83GLJL6W+ip5e9HaNdJRO8sXXf6tb7lut0TlTnXMulviUZynTf14zRRR8xMY5NzOBfCOocSt/P3rf9Oz3rShC7iIXM6F1K9/uX3b/uJwNW6xTWs0SrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506601; c=relaxed/simple;
	bh=nv6fdyX4pUlyyRX9cJa4O98wfhmP6FBgODKk4IAgzQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqdLmQxHHu2rnLw/2sUNkkW3EXzcQguDYoDlWdM10cQkWdxy+aSh2XSmDGAKN2yb+oEOVl1FxvI0cWamOthEDKBr7NIXCI+gj2SWodFhEVDk1ubAXgWf60IPOaAcotWweX0a4sESvXUaUI7d+Ol9DLWN12ohBtmQL/8JXV3t3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XVh1PbfB; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716506592; x=1717111392; i=quwenruo.btrfs@gmx.com;
	bh=n3lFlc9a+VZUqiYxWe5upG3/QhCDjDnxvg3iNW0WDdA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XVh1PbfBzwEGfgUteovzh0eWmc3tPBmNvMYKf8RUpIkYizKkFw1nrq/uGQ5MxNPY
	 s86N4LTEPXJR7K58nBzK6UXnbVyzH1GAvVtwYRYinP4kyGRl8b0Y8YHgvPQrbXunM
	 8145EAOPKAslo4+wjiuMBQnrxUgvl2FqTzhEGzWjJ1EuUUSyRA+W4Y5pB1M4bzrBP
	 3woIM06Jf3XB2YFmbgpAAARpGPEbVdDzERmPBZhKOkEQ5/tcWHkOgtY5PTZVkPepQ
	 ES4VJUqq147UUQsMKqfhK8xiUGW3vJPNeDNjasIHylSZx9U5ORPA+6lsmTPklF9Bv
	 gDXHP8c1VtxkgHvOdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvPJ-1s04Uc2DgL-00SgVK; Fri, 24
 May 2024 01:23:12 +0200
Message-ID: <5cb1affd-8f9b-4879-8815-56d716733910@gmx.com>
Date: Fri, 24 May 2024 08:53:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] btrfs: remove extent_map::block_start member
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1716440169.git.wqu@suse.com>
 <c230088e8bc683b3ff09fd333e968ae01519dd1c.1716440169.git.wqu@suse.com>
 <CAL3q7H6C23anvfyxCumZ8TveM+xgPnMZFWrDUo_Gop=kc1C9-g@mail.gmail.com>
Content-Language: en-US
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
In-Reply-To: <CAL3q7H6C23anvfyxCumZ8TveM+xgPnMZFWrDUo_Gop=kc1C9-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ngjc/fshfGO1EyKTrbBsPbD3WxVdGUb8ZV6/I9nPbW7oD0MwWGL
 6GHC63EV7XyE/YYJn7W3hYY02VGpqQAoRbzBlYNaMnN6qfmBdSYPdk3O5S9fJdXVuCXJ+1H
 18aWYYV/WxLEqUjNfLuYagRGJC20sCT7C0CZ7uW1ixvK4l3/1kq5DugAuU4pNcqVwnUwfX1
 3dmvABlzrMrsmy/lrnnKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:++imcaEXznE=;s2W9aAg3FvDd/2AzInCT2H2q4qk
 v0/Ebet9Nl6884JKjJ54+BQltfAIzqCkYhyRHpZd7bZnsG5talg5nJhViTyKNengtrloe35gl
 FLdqWdnAo4Knp8KfrrVIWy19BqtC5zDhbVakpoXk1c06kLfj0G47bcYxm+cOarM+yucXrlHUk
 bKog6VgyCA/m9fWC+l6ebwqlKTqTszN+C2D2R1ngixKetJ1Uj5KjsWngK/Ox771KeSon7ZSo1
 sqUccC0MM4875dQHs37/2uneiCMMTfHnvV1f8VLtuUe/aBYBEscxiq+79FP3JAec9Z+V77q1o
 RSpZjjxnUuG6Bw2aCd+SXquMmPDa2P1j7nGS1PQH/XQs6RkXL7cEhKZywyJEGLAuPlEKyw4p6
 Mj7ytUC2i2KX88bX2hUmppcCwvR+lhzVyOKLNxIIvI/GeHKYqpNf5abnbv0pONtJigML0H14/
 +DWApjj6/ufp9pwZmesZvAzEgykDwA026N2/cj7/omQiGa6AQLXFpgu7V7xKZvphHrzOMvinQ
 HbaoXxlqqKcGeAjlucTkcoM1Hfy4Jfo+NLEvh50kg+M6wgwRnIw2VBfiWwmLAcDSQDnV9E1XQ
 +MUhaMiCe5HYmbAbHZY9qgam1yxYskX83/wqbKUh8tkGrs6ETaBHDS8rzv2jmu51fAwDOmjX2
 E1ZfaMus+gGw81KNxEGpfKTjHXVSspMk5WZ0nzVcsjP56V7nUm7K6qdMR2lR7c7mrcP6zqdqe
 H4HYe/dNvdI185zSibYWy7Xg9kV/axJ9xupAEYu7MmvklFaxbUA1NxsbzOR22tPcUT9qppVf1
 fnE4qPuavrY6LJmRstVlpLDDXEfl3s6RHOzr5IYamiW2Q=



=E5=9C=A8 2024/5/24 03:26, Filipe Manana =E5=86=99=E9=81=93:
>> @@ -2703,7 +2700,7 @@ static int btrfs_find_new_delalloc_bytes(struct b=
trfs_inode *inode,
>>                  if (IS_ERR(em))
>>                          return PTR_ERR(em);
>>
>> -               if (em->block_start !=3D EXTENT_MAP_HOLE)
>> +               if (extent_map_block_start(em) !=3D EXTENT_MAP_HOLE)
> This should be:   if (em->disk_bytenr !=3D EXTENT_MAP_HOLE)

That's fine, the extent_map_block_start() would handle it correctly, as
for any disk_bytenr >=3D EXTENT_MAP_LAST_BYTE, it would return the
disk_bytenr directly.

But yes, we can save one if() check and would update it.

Thanks,
Qu

>
> Everything else looks fine. Thanks.

