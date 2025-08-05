Return-Path: <linux-btrfs+bounces-15849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D79B1B15C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 11:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34C71896549
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E3C25A631;
	Tue,  5 Aug 2025 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Heu6vIM2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B109261581;
	Tue,  5 Aug 2025 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387104; cv=none; b=faNhRnBc+wKbBLfTVwXbqlconX1rLtAIDmM3adPCsi5xuRYYughhlQxa2rTFV1ZqZ3yCcCRMcJA/5Ot+0/zMKR9oaQSDT0pU8Xt8exP8KGpoKr8UcMdF3dcnSOEN0KSuk+KwuGuPO9EtbOI49dNaDv/gXXZQsfizdmOscp8+IVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387104; c=relaxed/simple;
	bh=0rJLYMoQFJdKooNLH+ASn75gvQ65KMFsvgb88O1+jQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5xbJkOvGNP8S5d1xSNYFPSzx156pWAJLBb9n23XI38uT4+wriFabc02YgL4IveaiyGHQT8FjOytJEQg4UrXa0cVAt+i9YepXQmMpRqCBJeszO30Yj3510oLQER11GG7yOBSAqpn9ffgCcDhpjg/SlWr/C+MhyWWnLMb0LC4uFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Heu6vIM2; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754387099; x=1754991899; i=quwenruo.btrfs@gmx.com;
	bh=BDYgvSq5/dmcy/7MC/gkzLmjuAlM/XVj1yJHd9JTJVA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Heu6vIM2Y4IAWN6nuGsdoAFW/hTdDavmeibu6/rEdL/lnXlJKiIp/e8wdXyXhn9g
	 b+xTPYyEkWyGu6Zjg+eFXaplR8OFSLQo7A39jmnQEfbF2R8R3Ixwr430GF4SlkUxo
	 Rf17n4Adm0Ai7LoKYMfxml2UyoeSdnwvw2+R709IRgEBPLi2om/b6oG67CN2cgN8P
	 H13mNywIsyHxwZfJUe+1kvPV2wysx/ntIEqQU7g0kNbDP18A6VHr/mPswNSGK7cHi
	 13PhKV2AAS+3WeZf/d3UyPRta1KlLvt6CVJyiGI1t+99m52r/tuUPigOaig9rljfe
	 q/o8EJohu0Jp9J0NCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRVb-1v7erp0iWB-00Ne3n; Tue, 05
 Aug 2025 11:44:59 +0200
Message-ID: <dd96b969-6e3f-44e2-a749-20dc9802ff8c@gmx.com>
Date: Tue, 5 Aug 2025 19:14:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] btrfs/137: Make this compatible with all block sizes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
 fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 djwong@kernel.org, zlang@kernel.org, fdmanana@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <991278fd7cf9ea0d5eed18843e3fb96b5c4a3cac.1753769382.git.nirjhar.roy.lists@gmail.com>
 <c1feb41e-608b-4578-b7f7-bf9dd0801836@gmx.com>
 <aJHR2fsx8ltPUuh5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
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
In-Reply-To: <aJHR2fsx8ltPUuh5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:woPo7Kj9HWpP8naUFLSS3Cpjs0aET9t5KreOzfEuqlKB3t+eZ34
 RAjq+mymUzrZh9Ief9OlbiM4tdDIfu+ltcVYLdDF5KsOibVPOHSMHzyD8waZQUZu0QsfsEV
 MEPW970mbrNsPb9VZDpcVsMoThINc35hTIsp8jl9327T+mDpaKk0NhZ8Xeigo7cgh84Mntf
 JKzSPwP4PV3ulzfgkbuHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ay/ssaOiztU=;63Jv2o5Keo14pscBURaILRcbxIr
 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
 pJ/b5biDyZEvBVenXlKfNmc=



=E5=9C=A8 2025/8/5 19:11, Ojaswin Mujoo =E5=86=99=E9=81=93:
> On Mon, Aug 04, 2025 at 01:28:24PM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/7/29 15:51, Nirjhar Roy (IBM) =E5=86=99=E9=81=93:
>>> For large blocksizes like 64k on powerpc with 64k pagesize
>>> it failed simply because this test was written with 4k
>>> block size in mind.
>>> The first few lines of the error logs are as follows:
>>>
>>>        d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
>>>
>>>        File snap1/foo fiemap results in the original filesystem:
>>>       -0: [0..7]: data
>>>       +0: [0..127]: data
>>>
>>>        File snap1/bar fiemap results in the original filesystem:
>>>       ...
>>>
>>> Fix this by making the test choose offsets based on
>>> the blocksize.
>>
>> I'm wondering, why not just use a fixed 64K block size?
>=20
> Hi Qu,
>=20
> It will definitely be simpler to just use 64k io size but I feel it
> might be better to not hard code it for future proofing the tests. I
> know right now we don't have bs > ps in btrfs but maybe we get it in the
> future and we might start seeing funky block sizes > 64k.

And in fact I'm going to add that bs > ps support very soon, since we=20
already have large folio support for data, it will be just a simple=20
mapping_set_folio_order_range() with a min order.

But still for btrfs, we're only going to support 4K, 8K, 16K, 32K, 64K=20
block sizes, thus I don't think we need to bother larger bs yet.

Thanks,
Qu

>=20
> Same goes for not hardcoding block mappings in the golden output.
>=20
> Regards,
> ojaswin
>=20
>=20


