Return-Path: <linux-btrfs+bounces-1814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03B83D05C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 00:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712B1291944
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 23:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71928125D8;
	Thu, 25 Jan 2024 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XktM/QUp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6801F10A2D
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224162; cv=none; b=iUz2h6UYgPeyw57RnxmtNVhpDPlcjMzLPlS+c6iDwvECdsoSFAsFprvg3LoKb17Cz4O6gClTjwz5U4B+NgaAWjvK36QTh5fG6bLd+jYytyBpCBvVfmGPdC+2QoYIAXZ4g8k363baoQwyBNsCzMtGPiPj0ZQwiBBSFhz0Ia896KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224162; c=relaxed/simple;
	bh=1LZA60cL7JW63j1ehRCI103KOigaJg0Xd+pIHACI+BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxrV0AuXUTakFIGC6rQIh4N1ss8hOf0U2a9MsDXYdFLxs7BZ4E7biDVFSDdfBbg2UjCbvNaufThq8Ml1hcIj6a5lksKfkr3mfnIhtuz98QA53UvqrgPKaUTfZlYp3m9X43Ut9sA9fk4dBrLoY1ryYEGur1rOcRUR5nFWLm+zoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XktM/QUp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706224157; x=1706828957; i=quwenruo.btrfs@gmx.com;
	bh=1LZA60cL7JW63j1ehRCI103KOigaJg0Xd+pIHACI+BM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=XktM/QUpHzDVKUXqjTgWkodNrXt+3HC/K9d2/P4krwZP+6lDDEWGL8tEE+g1oC3M
	 8ZA5EoXEjd/Sjc7YftWaORBhuBYzQ4SgNDePb+FOJc8RXAfzGCssgROJvEsqrhODh
	 +J4lSKzsHuOwbQDaTt4fk5zPSOBkJMXQP2pjB3az/QEzvQRq4V/i0vcmnVzP2k/qM
	 qlvUzZYCFsFvYpcMujJ60C8AzHwMmdBBrcmt1Omnyj5AKApYnrPJXl9yZoqzAec1Y
	 v9eqL4+F8nhFT48rBGsL9HZX8xx4YaG1tYM2fvKu384kopLkzyT5bpSDCFUoRechW
	 K2Eu276cfKdpvEMizQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMXQF-1rlV4l3Ljb-00JeR1; Fri, 26
 Jan 2024 00:09:17 +0100
Message-ID: <f23a7b78-4261-4f40-bd47-1bceb3d694d2@gmx.com>
Date: Fri, 26 Jan 2024 09:39:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] btrfs: handle block group lookup error when it's
 being removed
Content-Language: en-US
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
 <cfe1bf94b8a6f24407795d3e1823a187ead04570.1706130791.git.dsterba@suse.com>
 <f2eb8f2f-999f-47a6-b920-fb5ba211fe72@gmx.com>
 <20240125161252.GN31555@twin.jikos.cz>
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
In-Reply-To: <20240125161252.GN31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gBHZmow5MmUMIjAqUN/q8ECdN8iu+gMtwxBB+ZOs7wKaHWMx/Zw
 kPQgiUPVC3hPa16sWK6jRhkquAYCVsHd3CW/KOcAcwC3FZX/e7qimWRVQbAZOXnxAAyJckG
 expKDWcI1Fw6dAWsajZ9W/5/ieNhLDG9PlM5Iasz1uI1u/+nOAWVcS0Jr9Biw04gs3BRvsj
 +iYfd1fYL6qASIVVQcjTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gk4utkAASOM=;6+Hs2QzBqGx/6ZBxDmjRzSsl2rK
 07BUgXQH8ewd6JIqPHMIVZKV9LA8m4ePHzI+g+zUJxPJF/SWOUXW6sstTgP9pgD9r7NVT3m+v
 gNZjaC/ESgleNkMCiB1bzz1mWaha6++AS8lGZbdTx4wt6LUOYCx28crapc16VvmJSmQh2xK0w
 SCbaULdfo4jVhVvtMcvKXUFk4vkEmtYQNgYyEWOA3jaDqBledHYxpBJgjW0qgehIqwohz9f5U
 /xkbogzmgHDCwj0luemToZGOjHjRpcGTNoTpEAZ0i6VeABs0qznKVpktsRVtqzVbZnsg70eNV
 RLAYxX2/NdSPQzWcdP9mIq9DScI8Y1DKqohEW3w2u+ORaLArbHsUcoacVmqHJzS2CZKJv3aAD
 +GxufJpHZL1R0Np5Vu8NxNZD4iZJJ5nVTBGMgNAfEYh0pDpAGR364Rea+U3lHlragkmxHxlvi
 IbzSKjLOdYXzzTPv/sahIWuIPU0XKHvw2WT0JQl/f4rWnSHQ9ZXqyDvfu12W5J2k9IsUizBo8
 UtJ4DylEPltwuguymGtrYxdlfUWqgtChPUr4YmZXUO/M+54RBf8KhYs2t3utMYCx6mM1qZIcG
 sYS7EZXHeBnXp3jgw4aMJMLTLKbeV8IBw/66giuM1kmovHjZjCRTsfzlp+znen4MGqF5e454E
 KtgnStAPDJ/b9AfT0szwp8JC3ZSGBYHJC1hBUB84I2KHZXx02XWq/ZBp8MxQ9OlvFkz26S6oy
 VOYPojF7GyMhVK5uJLQ+D8Xq+bYyiDEDnatKGCfbKS2TXvMfsYpKu5r/oYXgCZ87Y+CtQ2I0y
 +h8M46+J9r2/o588N2VM9RPElFTIHaYnT7MlbOVi1aKTLsOnfv+IMd5q7y1K6v/nuP20x1rUt
 TU38XAAenoSs9XHKb6P3XoBtONHu4BOLL7claj9akBZQaRGlU12Lg+KhmkN3ORr5sp8JptXZU
 r/Jxh4OuX0IjXlMydJOSC2RpAVI=



On 2024/1/26 02:42, David Sterba wrote:
> On Thu, Jan 25, 2024 at 02:28:02PM +1030, Qu Wenruo wrote:
>>
>>
>> On 2024/1/25 07:47, David Sterba wrote:
>>> The unlikely case of lookup error in btrfs_remove_block_group() can be
>>> handled properly, in its caller this would lead to a transaction abort=
.
>>> We can't do anything else, a block group must have been loaded first.
>>>
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>> ---
>>>    fs/btrfs/block-group.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>> index 1905d76772a9..16a2b8609989 100644
>>> --- a/fs/btrfs/block-group.c
>>> +++ b/fs/btrfs/block-group.c
>>> @@ -1063,7 +1063,9 @@ int btrfs_remove_block_group(struct btrfs_trans_=
handle *trans,
>>>    	bool remove_rsv =3D false;
>>>
>>>    	block_group =3D btrfs_lookup_block_group(fs_info, map->start);
>>> -	BUG_ON(!block_group);
>>> +	if (!block_group)
>>> +		return -ENOENT;
>>
>> This -ENOENT return value is fine, as the only caller would call
>> btrfs_abort_transaction() to be noisy enough.
>>
>> And talking about btrfs_abort_transaction(), I think we can call it
>> early to make debug a little easierly.
>
> There are several patterns, one is that transaction abort is called by
> the function that started it. It's not consistent but as a hint abort
> can be used anywhere if things go so bad that it's impossible to roll
> back, eg. in a middle of a big loop setting up block groups and such.

In this case, I don't think we can do anything to really rollback, thus
aborting early would help debug and provide a better call trace.

Thanks,
Qu

>
>>> +
>>>    	BUG_ON(!block_group->ro);
>>
>> But shouldn't we also handle the RO case?
>
> Of course but it's fixing a different problem with tracking of read-only
> status of a bg and I will not mix that to that patch.
>

