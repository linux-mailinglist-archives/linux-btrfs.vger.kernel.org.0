Return-Path: <linux-btrfs+bounces-19446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BEBC99FB6
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 05:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D41D2345093
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 04:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1B28A1E6;
	Tue,  2 Dec 2025 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RtUVGfWN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BCC212B0A
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764648557; cv=none; b=jQaM7wAe2f8qkpCsUpknKvDcIZnfF0F9lMMisoGC693P+DiTRja0JFn7HIHQ/Ok3XiOFxGXmO1qAfyGkT7uNfMikPLJZW7uudNMfE6W+gfXS6PPJHH3uhKz/yCBMfofLKhFJwqCf+bp5SRkDXZ2jKVqBsAgae9LKzkZZcZ72arQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764648557; c=relaxed/simple;
	bh=hLbP65He4C14+QFYXqxkivtLYTwFsh+H2BxIOwxHAcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y8r+sAf7GeOtjk6KEYvzmqh4zeFr/RYDc/BpzGRWTZBvMXnzMGFf/stK9lCHvFxoOQlx5gReaV9kznOGSb1JkVrwUi4hYHJHjpiLigsBBLuTe/+U3yXOVGT/2X3mDs7IAatitLxwA/b/x/DjlT61OCU7U4Je7v2NbAb8/J0BWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RtUVGfWN; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764648552; x=1765253352; i=quwenruo.btrfs@gmx.com;
	bh=/MC1UiGPhtKo+visOLfbO8Gr2Rb+GG47+XAw0sEhaOA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RtUVGfWNvs7OQqqJunb0IiR71mVVVTpFP9YzyqSiUgz7U3ejExc/j//lVIMMW7TC
	 ZioGiM5nlAval6/TvYY5utoj6ceXxSHIJKdHHkSoFg5Clh3vyn9Z7TS5xHpgMlA5p
	 w0+DTq9ZJpTkOa1Y/u72RtZc9/IwVMfhihuFbGvyz4QHIsAIbNbVAovKCl80EVxUt
	 x30CKgnIfKW5Lp43rwKT3xyEXsmjJfc3BVbpQ8jDJtEgscnNM4d1PY+CbgNk5BpMI
	 sNebA5Flf3YWngg6mxh1djuc/W5kO9qcY1QkcAVo6HhkJk904IdOZR0cLl88vqdIz
	 lY4txYhC2vV7x3uU4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9kC-1vIZWl2Hng-00HP1t; Tue, 02
 Dec 2025 05:09:12 +0100
Message-ID: <fa100509-d871-47f5-85d9-286eb6a037b0@gmx.com>
Date: Tue, 2 Dec 2025 14:39:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] btrfs-progs: add block-group-tree to the default
 mkfs/convert features
To: Nicholas D Steeves <nsteeves@gmail.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1764228560.git.wqu@suse.com> <87o6ohisqg.fsf@gmail.com>
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
In-Reply-To: <87o6ohisqg.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h67onqbtlVijUBJKxGGirAi6VL7r6T2173Chqoux+tnbhfkbdfv
 gpdm3iTZcGM1Vt9t6NPPs6+2+qADqjxnJIcvmcY1/65N62bu50FyR+AerW0RiSwai1kKKGr
 m9DZQShQjvaVFuNfvjKnQwsuV864sX+GR8acc898gnDaLboEwXQ/oQaLjlj3TGL+c3eaSko
 V9rWk1zjP+yEg2pUAW9UA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PJaEExwREe4=;Ob/rmB+ToQS0cSd0zsg2GNSPGn4
 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



=E5=9C=A8 2025/12/2 11:51, Nicholas D Steeves =E5=86=99=E9=81=93:
> Hi Qu,
>=20
> Qu Wenruo <wqu@suse.com> writes:
>=20
>> [CHANGELOG]
>> v2:
>> - Automatically remove bgt feature when dependent feature is missing
>>    Instead of erroring out. This will allow us to run the existing
>>    no-holes/v1 free space cache test cases without any modification.
>>
>> I was planning to do this during v6.12 but forgot it and now the next
>> LTS kernel release is not that far away, it's finally time to make the
>> switch.
>>
>=20
> Does this also mean that block-group-tree is considered recommended and
> production-ready for users of linux-6.12 LTS, or that it will only be
> recommended for the next LTS kernel series?

I think 6.12 is already safe enough (the current safe version is 6.6).

>=20
> Also, are there any known disadvantages that result from having used
> btrfstune compared with a pristine FS created with
> mkfs.btrfs -O block-group-tree ?

I can only come up with the disadvantage of btrfstune itself, e.g:

- Older bugs in btrfstune that failed to resume interrupted conversion

- Certain ENOSPC bugs if the fs is really full

- Offline conversion

As long as the fs can be safely converted, there should be no difference.

Thanks,
Qu

>=20
> Best,
> Nicholas


