Return-Path: <linux-btrfs+bounces-16318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9160DB33597
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 06:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19261B24A25
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 04:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E72E272E5A;
	Mon, 25 Aug 2025 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QzbtWjfB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F641D130E;
	Mon, 25 Aug 2025 04:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097103; cv=none; b=Xpd5DUFAFrraS93UY2qaP0Dclr193OrPSVf3wCHMusovn22TEJFI5ZGCVhlqS9YDhzpAW7+KkwldGqmPIOBI3/BZXFQSkxgzalj6b35f+0Cs4P/k6wpq+nXXva7MAVZseECXun50hE+IqWJ7JGV8+jQ+Ey/1CL+4jXxUd2PzjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097103; c=relaxed/simple;
	bh=yx7PUkwYnm+up0uQkvtYH4mQOLqpm4rBYuSqxi9OPGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJFzXJ4B2KT6w+Q2R1cn8WOmzMu2UfQHNp/fjtI6H2yrajPD4ObKMFWSSdxijh/xcG7AxW5MVkyq8ZTKdzzAG4H88z5uOXyUcxC3aAuqg6c9+fJAWvJRKpWVo0DZr1g71DPbvyQH9CyIs5fPtR24nRGZofjb4vypnjwxcQZgFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QzbtWjfB; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756097099; x=1756701899; i=quwenruo.btrfs@gmx.com;
	bh=yx7PUkwYnm+up0uQkvtYH4mQOLqpm4rBYuSqxi9OPGg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QzbtWjfByDEi4ReZVlPlu7d1gj0/IhK6jy4qAK9eBLjTV7dsjv9h2sXedc9RDzm+
	 avBzW3VH97lnT5bzJ2yHVdlpAOJHoXM36t/qjl4iAW3VaRbyP35XRnxqMUHxPuVFY
	 lPpN7uxx9niSs0WITGCOW8mlVkfqlTAVILlSm59957jliYUWxmQ2TIH+1X0gdQfCY
	 SOX+dFssrIo9dXl5u8UoOF/oh3WEYxexq0yxI+c+ur4mJIejnlUezvhsQhKrzVd1N
	 +0KEaRhwzWTXDKMnOfC0cJxZUG0QmBaugU1yiZFLfWuW5flaYBJH9rMfL+c6BjLZj
	 2hckJt78lBUoVSX4Lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KUT-1uRhQp3Eef-00v8qY; Mon, 25
 Aug 2025 06:44:59 +0200
Message-ID: <36395df3-bc41-44c0-861d-0f7f8c47a46d@gmx.com>
Date: Mon, 25 Aug 2025 14:14:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] generic/274: Make the pwrite block sizes and
 offsets to 64k
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
 <1110f20bb5d26b4bef5596a00d69c3459709ab65.1755677274.git.nirjhar.roy.lists@gmail.com>
 <ca7656e2-0b8b-42e4-8dee-c2da44cc0f11@gmail.com>
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
In-Reply-To: <ca7656e2-0b8b-42e4-8dee-c2da44cc0f11@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ycWarT3eE1gLB2O24CMBPphVVttWAiDNc4+/FGNbZTz1i9Q8uJ5
 9n2p1RBC6WbAQA7HCjBWvmK6hxlws8QqEplrmwZgWq3zCH4dWpBGCkUTalP8q0JgJPv8k/a
 lW2tEqoAh84qCXup7O9hh9ZOefGNDPwh55kJ3+Gmxcb/FkECrC45KdcXNVRJQsIEohjetO/
 laeHpcNFMHF3b+52P1uhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:528qZan6d7U=;MRSTCnFRRxceoAgdeAAr89/peoZ
 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



=E5=9C=A8 2025/8/25 14:04, Nirjhar Roy (IBM) =E5=86=99=E9=81=93:
>=20
> On 8/20/25 13:45, Nirjhar Roy (IBM) wrote:
>> This test was written with 4k block size in mind and it fails with
>> 64k block size when tested with btrfs.
>> The test first does pre-allocation, then fills up the
>> filesystem. After that it tries to fragment and fill holes at offsets
>> of 4k(i.e, 1 fsblock) - which works fine with 4k block size, but with
>> 64k block size, the test tries to fragment and fill holes within
>> 1 fsblock(of size 64k). This results in overwrite of 64k fsblocks
>> and the write fails. The reason for this failure is that during
>> overwrite, there is no more space available for COW.
>> Fix this by changing the pwrite block size and offsets to 64k
>> so that the test never tries to punch holes or overwrite within 1 fsblo=
ck
>> and the test becomes compatible with all block sizes.
>>
>> For non-COW filesystems/files, this test should work even if the
>> underlying filesytem block size > 64k.
>=20
> Hi Qu,
>=20
> Do you have any other feedback for this? I have reverted the block size=
=20
> to 4k during fs filling as suggested in [1]

With that changed I'm totally fine. Feel free to add my tag:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>=20
> [1] https://lore.kernel.org/all/0a10a9b0-a55c-4607-=20
> be0b-7f7f01c2d729@suse.com/
>=20
> --NR
>=20
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>> =C2=A0 tests/generic/274 | 8 ++++----
>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/generic/274 b/tests/generic/274
>> index 916c7173..f6c7884e 100755
>> --- a/tests/generic/274
>> +++ b/tests/generic/274
>> @@ -40,8 +40,8 @@ _scratch_unmount 2>/dev/null
>> =C2=A0 _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2=
>&1
>> =C2=A0 _scratch_mount
>> -# Create a 4k file and Allocate 4M past EOF on that file
>> -$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc -k 4k 4m" $SCRATCH_MNT/=20
>> test \
>> +# Create a 64k file and Allocate 64M past EOF on that file
>> +$XFS_IO_PROG -f -c "pwrite 0 64k" -c "falloc -k 64k 64m"=20
>> $SCRATCH_MNT/test \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>$seqres.full 2>&1 || _fail "failed to =
create test file"
>> =C2=A0 # Fill the rest of the fs completely
>> @@ -63,7 +63,7 @@ df $SCRATCH_MNT >>$seqres.full 2>&1
>> =C2=A0 echo "Fill in prealloc space; fragment at offsets:" >> $seqres.f=
ull
>> =C2=A0 for i in `seq 1 2 1023`; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo -n "$i " >> $seqres.full
>> -=C2=A0=C2=A0=C2=A0 dd if=3D/dev/zero of=3D$SCRATCH_MNT/test seek=3D$i =
bs=3D4K count=3D1=20
>> conv=3Dnotrunc \
>> +=C2=A0=C2=A0=C2=A0 dd if=3D/dev/zero of=3D$SCRATCH_MNT/test seek=3D$i =
bs=3D64K count=3D1=20
>> conv=3Dnotrunc \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>$seqres.full 2=
>/dev/null || _fail "failed to write to test=20
>> file"
>> =C2=A0 done
>> =C2=A0 _scratch_sync
>> @@ -71,7 +71,7 @@ echo >> $seqres.full
>> =C2=A0 echo "Fill in prealloc space; fill holes at offsets:" >> $seqres=
.full
>> =C2=A0 for i in `seq 2 2 1023`; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo -n "$i " >> $seqres.full
>> -=C2=A0=C2=A0=C2=A0 dd if=3D/dev/zero of=3D$SCRATCH_MNT/test seek=3D$i =
bs=3D4K count=3D1=20
>> conv=3Dnotrunc \
>> +=C2=A0=C2=A0=C2=A0 dd if=3D/dev/zero of=3D$SCRATCH_MNT/test seek=3D$i =
bs=3D64K count=3D1=20
>> conv=3Dnotrunc \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>$seqres.full 2=
>/dev/null || _fail "failed to fill test file"
>> =C2=A0 done
>> =C2=A0 _scratch_sync
>=20


