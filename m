Return-Path: <linux-btrfs+bounces-16169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8B9B2D3BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 07:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC9E7A781B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 05:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8205725A2D2;
	Wed, 20 Aug 2025 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="efZ5mADo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415BE2F4A;
	Wed, 20 Aug 2025 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668723; cv=none; b=nkxN3TWEWZaT1o1F1PPfTqaWs5E9frvoSICyd1XRinXmg3bRJvCSyLTQLljhCcLwuPf8OeeL+RmHOONQwfkzZsNqwPDjdVf+KA3G+QkJsRhi7jrNtf24zJh1eFwmZ+ob84xuQrTR8rj/qHFoDqqKdbgJoO3TaaDxeBChjwXxpX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668723; c=relaxed/simple;
	bh=ErlfmCRhzCwAKbnQpWfXupe3TIYkuX8rQeY2DJ3UFFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9PQ7JMOdhEmlCxSEnRCDwKodnIB8fQEQp2ArqVVAdFrET72RYAdya4HEcWoVT/rP1xTCUXBsJu/kQwCxN+29C/d/rA4fvWsHTETS2sJyLxJreuNCPszEVAj8H2WG2l5Bkqhghrr/HG2cGMEkVcYoG4ZqWLp3AEauta98G4Jh6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=efZ5mADo; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1755668714; x=1756273514; i=quwenruo.btrfs@gmx.com;
	bh=ErlfmCRhzCwAKbnQpWfXupe3TIYkuX8rQeY2DJ3UFFY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=efZ5mADozCkcPAWx/GcLk4XOjOpG+Pa8m+s5x3oeEPXL6Ws6A1wmtIAst2AcuuFj
	 6LpPCyTxVn1O5s8SGDDSTHAvqNM2aAj3+emFOIAIDR/SwmNaJBZ85Exn0hGpgZgrU
	 jU7VfNSdlHLBBQW5PYAb3wEu1z/D18HwjmrjuKE1S8yvs2FbYEhkEF7nukgVzDmg7
	 S4zDW76RdK4mpRclSs0UEqQuwVl37Y9fZHkgWGrlLf9InsPMho3JnQv2gzuvj2fXY
	 gM6nWyCjTO5vHi7yY0YcDK0G0oUdrPIhwbW0RBZvTTyZCkSQLgOuxfECwWA/wQyNu
	 ERaMlgcu9Gt4QcE5QQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8GMq-1uSera0KRM-00yBlW; Wed, 20
 Aug 2025 07:45:14 +0200
Message-ID: <fa0dc9e3-2025-49f2-9f20-71190382fce5@gmx.com>
Date: Wed, 20 Aug 2025 15:15:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] generic/563: Increase the iosize to to cover for
 btrfs
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
 Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
 <ecdd04bce98bb0d1393289e84cf8913ae10cb222.1755604735.git.nirjhar.roy.lists@gmail.com>
 <26059372-f900-4348-997e-d6c379c685f8@suse.com>
 <0ca943e2-10fb-42b4-b111-d6f619d7b702@gmail.com>
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
In-Reply-To: <0ca943e2-10fb-42b4-b111-d6f619d7b702@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cp9jrPJDiqnMPeaTsD9c/qsXBTHxMzwDwBRWYJDRFbTBOy16VCC
 l0eLYizCYIqWH07SlP91AlQSnr9q6Z2uEGRkGKM9GuqufXnhFP/HdGpUe7YH66vmzKve5rC
 KbUFGGdnzEJlavwso/XlFo5zFc9ZmOMRePLserqu43P7TgOkOnTSYbuzmLFgny+DNuWpEdx
 f08P8YJdcwPFKdOT21BKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:widWP+CsEE0=;IJJToK+q3KhoXMi5US3XnsMhKbP
 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



=E5=9C=A8 2025/8/20 14:30, Nirjhar Roy (IBM) =E5=86=99=E9=81=93:
>=20
> On 8/20/25 03:59, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/8/19 21:30, Nirjhar Roy (IBM) =E5=86=99=E9=81=93:
>>> When tested with block size/node size 64K on btrfs, then the test fail=
s
>>> with the folllowing error:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 563
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read/write
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read is in range
>>> =C2=A0=C2=A0=C2=A0=C2=A0 -write is in range
>>> =C2=A0=C2=A0=C2=A0=C2=A0 +write has value of 8855552
>>> =C2=A0=C2=A0=C2=A0=C2=A0 +write is NOT in range 7969177.6 .. 8808038.4
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write -> read/write
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>>> The slight increase in the amount of bytes that are written is because
>>> of the increase in the the nodesize(metadata) and hence it exceeds
>>> the tolerance limit slightly. Fix this by increasing the iosize.
>>> Increasing the iosize increases the tolerance range and covers the
>>> tolerance for btrfs higher node sizes.
>>>
>>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>
>> Looks good to me.
>>
>> Just want to add some more analyze for the failure case.
>>
>> For the test it writes 8M data with 5% tolerance (around 408K) with=20
>> the total writes.
>>
>> With 64K block size (and it implies 64K metadata size) for btrfs, it=20
>> mean we can have at most 7 tree blocks of writes plus two super blocks=
=20
>> updated.
>>
>> Considering the default metadata profile is DUP, doubling the metadata=
=20
>> writes, the real limit is only 3 tree blocks.
>>
>> And when doing fsync, btrfs will create at least 2 new tree blocks,=20
>> one for the log tree root, and one for the log tree of the subvolume.
>>
>> This is still inside the tolerance, thus the test case can still pass=
=20
>> for a lot of cases.
>>
>> But if a full transaction commit is triggered, btrfs will need to=20
>> create at least 3 new tree blocks for root, extent and subvolume tree.
>> Depending on the mkfs config, it will increase to 7 tree blocks (free=
=20
>> space tree, block group tree, csum tree and uuid tree created at mount)=
.
>>
>> All are exceeding the tolerance limit.
>>
>> Doubling the io size will make the tolerance to be 8 tree blocks,=20
>> covering the worst case of 64K metadata sized btrfs, at least for now.
>=20
> Thank you for the detailed analysis. I will add this analysis in the=20
> commit message and address the comment for generic/274[1] and add your=
=20
> RBs in the next revision.
>=20
> A couple of questions for the above explanation:
>=20
> Doubling the iosize to 16M with 5% tolerance is around 819k. So, with=20
> 64k blocks, it turns out to be 819k/64k =3D 12. Considering DUP, it shou=
ld=20
> be approximately 12/2=3D6 blocks, but you are saying 8. Can you please=
=20
> explain this part a bit?

My bad, wrong calculation.

The original 8M tolerance is only for 6 tree blocks, with DUP it reduced=
=20
to 3. Thus a full commit transaction will always fail the tolerance check.

Doubled to 16M iosize, the tolerance is exactly what you said, 12 tree=20
blocks not 16, and with DUP into consideration it's 6.

With 6 tree blocks tolerance, it's borderline for a full commit transactio=
n.

The recent default mkfs config means 5 tree blocks (root, extent,=20
subvolume, csum and free space), and with incoming new default bgt free=20
it will be exactly at the boundary, but should still pass for now.

Thanks,
Qu


>=20
> [1] https://lore.kernel.org/all/0a10a9b0-a55c-4607-=20
> be0b-7f7f01c2d729@suse.com/
>=20
> --NR
>=20
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks,
>> Qu
>>
>>> ---
>>> =C2=A0 tests/generic/563 | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/generic/563 b/tests/generic/563
>>> index 89a71aa4..6cb9ddb0 100755
>>> --- a/tests/generic/563
>>> +++ b/tests/generic/563
>>> @@ -43,7 +43,7 @@ _require_block_device $SCRATCH_DEV
>>> =C2=A0 _require_non_zoned_device ${SCRATCH_DEV}
>>> =C2=A0 =C2=A0 cgdir=3D$CGROUP2_PATH
>>> -iosize=3D$((1024 * 1024 * 8))
>>> +iosize=3D$((1024 * 1024 * 16))
>>> =C2=A0 =C2=A0 # Check cgroup read/write charges against expected value=
s. Allow=20
>>> for some
>>> =C2=A0 # tolerance as different filesystems seem to account slightly=
=20
>>> differently.
>>


