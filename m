Return-Path: <linux-btrfs+bounces-17231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1820EBA683F
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 07:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1A37AECA4
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 05:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC852147E5;
	Sun, 28 Sep 2025 05:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GGsvUOea"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AAD83CC7;
	Sun, 28 Sep 2025 05:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759036634; cv=none; b=LTFpnBMvsH4po6pMmySNV4Sk7QfRwL7K09Y1Yc6q5HaNM3ABiNhvBadUG6dNTcJxQIq4LayKcZh2r0T6RIW7UMmby9auQzfKC3JaRB2tsz6nQkrtzle8Rq4r8zzauoCGTbzbaHKW/T7z0K5uKvjGiNsG5T8uAkcLecR38tL4+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759036634; c=relaxed/simple;
	bh=120H8x9aCJOBBDvx0/lOwJynkgdQdgC4Smc7Vt82Z+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOHoZ4872B09vKEIBKXTKCYQBew4pNs6HLrKtHXo8ke68RjbKIzNurksgzT+WRMyZV5kYde4W9t5KmJMol5/8XqcEUNd5nJPNORJPWGVxtPptjdpZw2iY3Fexg07XpFEnK0XFibIyDvpJpml2/5W8yMXe+goUxM0K04yJ8KrRUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GGsvUOea; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759036624; x=1759641424; i=quwenruo.btrfs@gmx.com;
	bh=QwvCN1v3qadMlwJjf/MUBdIqxeEkWgMFqIP5ECX7oQE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GGsvUOea39DGXv/Ra8YpLpwmmwFZbaoEttLvvObRK/uWX/I4fKa1h1AHd8XIf1j5
	 ePxq6nnliJLG0rDM44ZHotHjs5c2kB+Qa2zIUhJQSdh/lJia2mFCVP/CfQn3RPKmj
	 XdoDc5REMYnExluN2gt5kcq0nr5Iobq8Nb4vqs0AM0jHNKbAu6VzjFSX+OnAmlewY
	 xkO4VAWSMIJiWJrUcqFTeFGljtf6DBjU4QJSP7tFhqO+tPXJSTyTXrPre904NXqMF
	 kRXHjfZpi0Ktt2q4SAY0MZSBFGjO4PQbYULgbgbNGbeaRFuTPq4p5HDEK8ujc3Lvy
	 rlrIJwbhBAjAS5+6+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryXN-1uZDzu1tvJ-00dMbo; Sun, 28
 Sep 2025 07:17:03 +0200
Message-ID: <b431fe00-43f3-49c2-a58b-8f79cb2134dc@gmx.com>
Date: Sun, 28 Sep 2025 14:46:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Add the nlink annotation in btrfs_inode_item
To: Youling Tang <youling.tang@linux.dev>
Cc: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250926074543.585249-1-youling.tang@linux.dev>
 <adda6065-26a2-4d31-b4f0-ccb20e0fadeb@gmx.com>
 <bda4b547-4dea-4c05-8679-1cf021bbe340@linux.dev>
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
In-Reply-To: <bda4b547-4dea-4c05-8679-1cf021bbe340@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l/gqaFZ35Q7XIFCvm/5trPyF75xNCGzYFXczlzALAU+2pVB9AjW
 PRbNOsvKmIbpAqdEO6e2Ci9gj8p8nsIS9KgyntAWtA5qA6EysAvRqRYwMCZ6MA5i9TW1G7I
 ZdEM01k6gj6MD8woPsPli6HrU1qYC+WSY6JQCCkPtn49FJeo8wROqTd7IbfRwCHnMADGOuS
 MTdYLFPGyhqbAeVpwUNrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:io1FL/NoKcQ=;+GuYuNyQuuEq46mYiFcWTpmCire
 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
 QZScLEgzZBwQFA==



=E5=9C=A8 2025/9/28 11:44, Youling Tang =E5=86=99=E9=81=93:
> Hi, Wenruo
>=20
> On 9/26/25 16:34, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/9/26 17:15, Youling Tang =E5=86=99=E9=81=93:
>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>
>>> When I created a directory, I found that its hard link count was
>>> 1 (unlike other file system phenomena, including the "." directory,
>>> which defaults to an initial count of 2).
>>>
>>> By analyzing the code, it is found that the nlink of the directory
>>> in btrfs has always been kept at 1, which is a deliberate design.
>>>
>>> Adding its comments can prevent it from being mistakenly regarded
>>> as a BUG.
>>>
>>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>>> ---
>>> =C2=A0 include/uapi/linux/btrfs_tree.h | 1 +
>>> =C2=A0 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/=20
>>> btrfs_tree.h
>>> index fc29d273845d..b4f7da90fd0e 100644
>>> --- a/include/uapi/linux/btrfs_tree.h
>>> +++ b/include/uapi/linux/btrfs_tree.h
>>> @@ -876,6 +876,7 @@ struct btrfs_inode_item {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64 size;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64 nbytes;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64 block_group;
>>> +=C2=A0=C2=A0=C2=A0 /* nlink in directories is fixed at 1 */
>>
>> nlink of what?
>>
>> Shouldn't be "nlink of directories" or "nlink of directory inodes"?
>>
>>
>> There are better location like btrfs-progs/Documentation/dev/On-disk-=
=20
>> format.rst for this.
>>
>> And you're only adding one single comment for a single member?
>> Even this is a different behavior compared to other fses, why not=20
>> explain what the impact of the change?
>>
>>
>> If you really want to add proper comments, spend more time and effort=
=20
>> like commit 9c6b1c4de1c6 ("btrfs: document device locking") to do it=20
>> correctly.
>=20
> My understanding of nlink is as follows, please correct me if I'm wrong,
>=20
> /*
>  =C2=A0* nlink represents the hard link count (corresponds to inode->i_n=
link=20
> value).
>  =C2=A0* For directories, this value is always 1, which differs from oth=
er=20
> filesystems
>  =C2=A0* where a newly created directory has an inode->i_nlink value of =
2=20
> (including
>  =C2=A0* the "." entry pointing to itself).

Have you checked what's the meaning of the nlink number for other fses=20
and why other fses go like that?

Especially the impact to user space tools like find?

>  =C2=A0*
>  =C2=A0* BTRFS maintains parent-child relationships through explicit bac=
k=20
> references
>  =C2=A0* (BTRFS_INODE_REF_KEY items) rather than link count accounting.
>  =C2=A0*
>  =C2=A0* This design simplifies metadata management in the copy-on-write=
=20
> environment
>  =C2=A0* and enables more reliable consistency checking. Directory link =
count
>  =C2=A0* verification is performed during tree checking in=20
> check_inode_item(), where
>  =C2=A0* values greater than 1 are treated as corruption.
>  =C2=A0*
>  =C2=A0* For regular files, nlink behaves traditionally and represents t=
he=20
> actual
>  =C2=A0* hard link count of the file.
>  =C2=A0*/
>=20
> Thanks,
> Youling.
>>
>> Thanks,
>> Qu
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le32 nlink;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le32 uid;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le32 gid;
>>


