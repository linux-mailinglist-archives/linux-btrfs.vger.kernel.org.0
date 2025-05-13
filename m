Return-Path: <linux-btrfs+bounces-13974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E03AB5352
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 12:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DBC3BB3DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417E72868BD;
	Tue, 13 May 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rBEtQez0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD4215073;
	Tue, 13 May 2025 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133855; cv=none; b=dEIfu6XNBsW3tCgMKrq6V+MmiGLBZQFIIfglnJ2pIGBIPT/Uvo9FOCoNU1W/QP76+osw4yuYgV4LfV+H3VkTXEiTvKKcpch24oMNOYn+4IGunHCrVuPT0xaT/vBuRLbB1kj5wO3kRFMuJ4yFYLMdAB3pL1R2EUtd/mP5S5Jbjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133855; c=relaxed/simple;
	bh=URhbLErSA7YaqD8JvAC72SGFG00yu40odLIMK0OQ/js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQ+tP2k2n+3cJSeQMQlD+17PFVXmtxLInVTnqPSxUH3+O213ld/+wd1d4nk2yYV4wHOXa8IzJSDoTOZEcOLxTSuEGWikcm4QnICSpd5oipD6+lyM88N45LpKfFAx86iVxfrmYZ3Y4qKCFw+J7y73hgGvJEDMeJ+TrIXeZDhnNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rBEtQez0; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747133846; x=1747738646; i=quwenruo.btrfs@gmx.com;
	bh=URhbLErSA7YaqD8JvAC72SGFG00yu40odLIMK0OQ/js=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rBEtQez0TZaKSmLJDhdKfffJHZ6rwen3AU9y4rNiXSKOBrkpg/rIbTFgZV9pHPyc
	 Jz8HBWKeGz+oXw01+1fUc9j1wRvAK9sx0ourPoLg0/rK6fuipE+tbPz8MP1vQCp1a
	 mgrvClXLIow3SXPqdEszfnUAR12W5jHbvwBNm5cBcFr4a03Z9kE7+FDRa5ytpvz79
	 agJ70oqR8/0LPT2PhO3SOAItPg9ABvkUHh1/K1cWSsSL5ckDVbeQasZgmnSGCToFO
	 lLfaoFuWVQiGKxz77rHBGsZt1nr5kusxfEh2qzRJk9YCYn1SdmYaFDv4mCFM8+Ykj
	 96vpM4b8r5Fi7bbLog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNJq-1uRUvP3whu-00TWc4; Tue, 13
 May 2025 12:57:26 +0200
Message-ID: <e01c7c8e-e7e9-472b-b0d2-89c2cf12b7a5@gmx.com>
Date: Tue, 13 May 2025 20:27:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: a new test case to verify scrub and
 rescue=idatacsums
To: Anand Jain <anand.jain@oracle.com>, Filipe Manana <fdmanana@kernel.org>,
 Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250512052551.236243-1-wqu@suse.com>
 <CAL3q7H7cqfhVNwEJ6dgXgZSmfUbOrSNZuua3MPWTs0LJ43BQXQ@mail.gmail.com>
 <c119cf23-3165-42fd-85f8-e2240eb9b7df@suse.com>
 <CAL3q7H4dxAGTK9XBe2Yeoywy7-HTktwt_Jcp=FE0yNYnrU8H0A@mail.gmail.com>
 <4208096e-459c-4379-99a5-6bf1defc65ac@oracle.com>
 <0d50d010-0010-4cee-a663-c6e86b3b5409@gmx.com>
 <f442c391-cb4d-4b9b-ae1d-e38d2d573c25@oracle.com>
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
In-Reply-To: <f442c391-cb4d-4b9b-ae1d-e38d2d573c25@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3pMHXCYQ3B6rMRW0JGEoOYBxgorw2N30O1oJYP5LSOTv7BiFs44
 HkARy8S4eT/wVAeoSKNykWyZyeqvwCSlxXEHsqB3okhhgoslPo0wQrxVXsR6nsYQc9TOHHE
 EpwxbX+NvweL42Quo1tSpcSvcdFW73tjZyspyu/RVxrwGPenbN4YqDLfCMbAPPxi0R/bm+5
 yQSK7vjcDC+brU+WP0sRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kG55NXsdFPs=;WmRtfpSvjG0MprPjSBH13v2qjX3
 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



=E5=9C=A8 2025/5/13 19:27, Anand Jain =E5=86=99=E9=81=93:
[...]
>>>
>>> Makes sense.
>>>
>>> As there is no way to check if the kernel has commit fix 6aecd91a5c5b
>>> testcase will crash the system. That's a bit concerning.
>>
>> In that case you can add the test case to dangerous group at merge time=
.
>>
>=20
> Oh, right =E2=80=94 we can use dangerous.
>=20
> I thought you were still sending v2 with Filipe's review comments?
>=20

Well, you reviewed the v2 version and applied, thus I guess it's easier=20
to add the group on your side:

https://lore.kernel.org/linux-btrfs/60d18eaa-c6b0-45f3-952a-437abfd25636@o=
racle.com/

Thanks,
Qu


