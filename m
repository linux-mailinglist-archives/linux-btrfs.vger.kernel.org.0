Return-Path: <linux-btrfs+bounces-7609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA19C962364
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 11:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874642849E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC101649CC;
	Wed, 28 Aug 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tbarg683"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AB158DDC;
	Wed, 28 Aug 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837421; cv=none; b=X79Vn7QqqKDC7heo+edU+KX2NFWOczu3hBM85KCbpRJXK74aKqN8IDYyOszki12KMe58/xCy64XhOQ6/qVbX/g9po8yJ8IuDJGr/xuPtJ9qxJOhiYxWLe88vgvOhVZSgCPuV5ux7vRIH2tZgIyHGgvksXhiYSWxgIz9VAnBAE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837421; c=relaxed/simple;
	bh=WCFeaQ0RKQ1aHjHaiyMapeS4YAryYNRVQHYw/kJrKmA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qCgpyC1b86z9TXEMYc5xyf8ih+6DkqZvSchL0xZUXcUs1BvJfDmE/LM2syzKHWqHV7TJltJgriv1ZaeaOmflMoMNuFew3Yen3rWw7K3w5yEw4TeockqdEUGd0uwwwhOgn4xBhEe6n/OWx0Rk3Hcn0dT+uM8PB65+r1lg+AEyNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tbarg683; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724837409; x=1725442209; i=quwenruo.btrfs@gmx.com;
	bh=TahGRp3LXkcLlPHzF0dQJw62+L3Vjd9QTLFM3bWOlFg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tbarg683feaI/MxK6PclHfLLLw9i0zHOzqkStBwY/Ry7CD4+6TkhySWEvfsEpVt8
	 jLFSjEedJdQDR88RdhkLFD5++BMdTFgquE+/oPxTA1/w9Megi6/xkpZ6Ep0M+8c4h
	 qGeBN60UJhYeem0jBhCyUXXkAbWOkQXBYsDupnDYt9Z2MH8Z1X8+SOzoF3lY0uCCO
	 ARGob1LiD+AjY8cz5h4uey8gUi0LdF1alADUYrdqEIjZnqNL40pUNffMGF4BtQcQc
	 iEfdVIw4Bf1Yu7m2PMCgs9Q4GYyc3EewY0sKL5jtAWgTl4Bx9XB2muSEk4OcCwbtx
	 WL1TUoeWVxxttfrc9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiaYJ-1sCwWl2G5n-00c6s4; Wed, 28
 Aug 2024 11:30:09 +0200
Message-ID: <8d26b493-6bc4-488c-b0a7-f2d129d94089@gmx.com>
Date: Wed, 28 Aug 2024 19:00:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: add missing extent changeset release
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20240827151243.63493-1-pchelkin@ispras.ru>
 <230ede6f-1cbb-4b25-ab1a-a54f7d29c92d@gmx.com>
Content-Language: en-US
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
In-Reply-To: <230ede6f-1cbb-4b25-ab1a-a54f7d29c92d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EQxAa6N4eCuUYlyJ6dE+jwBaknc6xPy6Kr7LR4WikCixu6REo4G
 yP1gyOGu3kzwOyZKWi4hXWtA5eDP2pFsgwIWMCyDE4bXHTvB80YVREqsbXVXzXHo0vH3+qz
 VbLM9k69Hxgp7dQJX2aF6tnJjJtIoo9WPHdZdr01VOatkUeAkxrYa1flfCJC0LU2XE3krTi
 Ds7bG75zRWb/lv92b87+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vTPx81kz988=;Xh01KIyD3Y99VykRdzy0FtL+61P
 CkRbc7fyzcHCzxMIRG7g1GsBNH3PpGsgKWCraBskiMrWkDxHmaJu8nroTbQnvVTYssyX55OtB
 LhnSGYmmaATwLWH6SsTS4/SO0UUxJhEcI2uPFv07ZsNYOPWduOo6UF0FaHhXmRHa2tOqq7zNJ
 SIPqX5VGGIHmWMzFw7XTiK/jHnStfgRYSUiJ366xstBs2ZFWymHVD0Ly+nSBy+FFMVuYYbBBL
 Keah7R86TfdMsVj7Rejtq5e51+83dxWagCkvBKFmjFzwT+ih+KPqnlt/GGp3b+RvNoVBeiliS
 OCKuzdZPLh2jKNuXH8QXhMzyZPSvbua2aFizb6psI+gUvIPmkgTyX+KWlrtVvTrYpkB8rcDj+
 z3NnCfQ2WZNMxcsaLeO/SDPr6Mo9ffBYdcAiNjT3yEvJeFTl4C61MvP6AHdaCcgJOXm+b1XmX
 sjTb+VazCGgUu34JL4YoAfq+AXNUv0jsP+5yO7yGLXxZCHh7Q1Mji2sudhSAX1VQNJtgge/Mz
 T6CY3igzEVvT5Y2fHRXDYRGN59SuU696qPYbclhbfJxLaQX+vG7C1WX+OIOv+UCnCwAwsG/hO
 lGJqNjLr2aAIf5LA9iY9x4qwCcb5KMrc+1V00ZF7IS5Covvr5D79r0LxsQYEnGsw//91XvvB3
 vtdbznLB7mkM9/zjZvWm8ImzYB3tAUJhjGB8qG5vWBN/qJvyCBQ7iz0WjLFy64ObiDY26Post
 pyE7LdWAqIje9YekI3Jlw0SYZdQmJMEl+uVgavqtMzXH0h4xIzARaiFPqtHYcz9RXvRS7cquO
 ytcfxUnXScd2UsdXza51oVwcnnJDLiQ3mlpVmyCHDV/9E=



=E5=9C=A8 2024/8/28 18:54, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/8/28 00:42, Fedor Pchelkin =E5=86=99=E9=81=93:
>> The extent changeset may have some additional memory dynamically
>> allocated
>> for ulist in result of clear_record_extent_bits() execution.
>>
>> Release it after the local changeset is no longer needed in
>> BTRFS_QGROUP_MODE_DISABLED case.
>>
>> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>>
>> Reported-by: syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com
>> Closes:
>> https://lore.kernel.org/lkml/000000000000aa8c0c060ade165e@google.com
>> Fixes: af0e2aab3b70 ("btrfs: qgroup: flush reservations during quota
>> disable")
>> Cc: stable@vger.kernel.org # 6.10+
>> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> In this particular case, the changeset is really only locally utilized,
> thus should always be released.

My bad, after checking your latest reply to David, I think we can go one
step further.

Just do not pass changeset to clear_record_extent_bits().

A changeset is utilized for two reasons:

- To let the caller know how many bytes are changed
   Just like what we did for the qgroup enabled case.

- Allow the caller to revert its change
   This happens for qgroup_unreserve_range() when we hit an error and
   needs to free what we just reserved.

In this particular case, since qgroup is already disabled, we just want
to clear the extent io tree bits, not really bother how many bytes are
released nor keep the info for reverting.

So just pass NULL and everything should be fine.

Thanks,
Qu
>
> Thanks,
> Qu
>> ---
>> =C2=A0 fs/btrfs/qgroup.c | 7 ++++---
>> =C2=A0 1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index 5d57a285d59b..4f1fa5d427e1 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -4345,9 +4345,10 @@ static int __btrfs_qgroup_release_data(struct
>> btrfs_inode *inode,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_qgroup_mode(inode->root->fs_in=
fo) =3D=3D
>> BTRFS_QGROUP_MODE_DISABLED) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent_changeset=
_init(&changeset);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return clear_record_extent_=
bits(&inode->io_tree, start,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 star=
t + len - 1,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXTE=
NT_QGROUP_RESERVED, &changeset);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D clear_record_extent=
_bits(&inode->io_tree, start,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 start + len - 1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 EXTENT_QGROUP_RESERVED, &changeset);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* In release case, we shouldn't have @r=
eserved */
>

