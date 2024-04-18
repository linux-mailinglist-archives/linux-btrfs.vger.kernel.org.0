Return-Path: <linux-btrfs+bounces-4410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6088A94D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 10:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D4028271C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A57127B57;
	Thu, 18 Apr 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="spF5no39"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CB7D413
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428647; cv=none; b=NePltFff/uizOJF5e6OgaIBl/W3bcf9zVQxN+90qrhMKdqI23apA+RdGfvx5Rs8THWo0cM4w7HvAuXbHAKBcayFXMT3v4FSfVJredwWFDMD1vMhofjB0wYzn1fjM7oUJ4HAkx8x2djuLI1eDrW3PZqhYc7ZSAc9ikwN6SPQUn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428647; c=relaxed/simple;
	bh=CmfwcUw2v6PRJYFzUJSQJHZ72IQjH1Ej9fUInkgWwoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J16vCuPDmRnNqR7V4XzAt+8rgxnP0weHrk3uVkseXFukWMighGt+N9YvdKB0UZcresVYCMRfoidUSfbDq43Cl0pRZsbqURN7ZOd0QBrpIPZF9NjA9FU4eNTh1V+yYA7zQLJNilJm5XqQsSFvhHOEILFqhe/mJQiLXR7iQe6S+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=spF5no39; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713428638; x=1714033438; i=quwenruo.btrfs@gmx.com;
	bh=CmfwcUw2v6PRJYFzUJSQJHZ72IQjH1Ej9fUInkgWwoA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=spF5no39jb7SAqfewLzL08sA3U6JNKmteTImZOtd5/VVePQM/nLjfoZUUMJ1fCg+
	 36Puq6VqEk/0JpQPAvih9UwBzox5J06tUIavegs5FT4j0AWeBN51OScPBXmuvCIK5
	 NSndfJEbB1AjYEen0ZJZXvWkNckXjHXgULDdT0VETLghELr+thO0POBxsSv46L9Xu
	 k/52LZ8sWFNMkoKXdxE4i9PWRWuAnqPu/+brT6bUHB75R+j9Vl1ciJOfV0epEarW4
	 vWUpeD6FG1xnszVU3rpqxWbkJQwZ045V2CT4wHrZImjfBmSYHt32Ed1Ej73LrNrvC
	 YCLDD03cpq8OULefjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4JmN-1rxeAu2jgn-000JMW; Thu, 18
 Apr 2024 10:23:58 +0200
Message-ID: <01c4de1f-ef41-4332-be50-a8a2a7b2efe9@gmx.com>
Date: Thu, 18 Apr 2024 17:53:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: report filemap_fdata<write|wait>_range error
To: Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
 linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
References: <80c3c9ccb6e7ea366d88f0e5b2798f5bbd3b381c.1713234880.git.anand.jain@oracle.com>
 <1556267cd2fd5f2d560a50b4b169ec4d58c95221.1713334462.git.anand.jain@oracle.com>
 <041bef79-743b-4726-adee-9c0ddf332e6b@gmx.com>
 <d3a646ed-ce67-4380-82f9-920fcbec5300@oracle.com>
 <b2818f72-0158-4caf-9687-9d0ca4672a03@suse.com>
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
In-Reply-To: <b2818f72-0158-4caf-9687-9d0ca4672a03@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:reYlT6g7U3JZTry9qB4MF4E1A5FPN9LjEbRk3c/ofkMrDqvxmL5
 czQU+Rj21ZAm0cde4IzP7ww3V55tXHukPp2ozXpWvL4VabpqlsUHWeGr8J00FnUUbgI5wS3
 r0I1E0MCofX4u+oZqk0M61v+0oGlFKZ677pfoHYbYeEX1uU31B8wBZhJozGUp2eHaI5vvQw
 GSUNpJNCJqq25l9Ln5Xmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qAD917qY9/0=;0YPK7R4MmhVeOQDIpMBussmz2Tp
 6gTcdcSp3RmTRqg5mgNYN6K6PWnfxerlU9QxH1Du0eIUfnoD5WtyMmROVRniMnx77Imbt/S++
 NnHUjDHU31vDJBOKtoL9iQsvEyhAwxTGof3uPAR/5ukRGJU9V848ZEfi1dm4JtkhVXxXi9mpO
 3c7dcB2m9xJAGFWUWzSa50ng1Ou6x2hUgCJJhaxpO6waGEasdQYcFHQcfNnuMn4NeI3w7GPed
 D0M0263xqhUhosiHk+TOdp2Glq2txqRXH+eRXuQv1Yddk2KxhvwIod77JzUPVUttwjAuJU7Zh
 XHacq9p0v4T/HfNdohdUbdtJLjRgNNvPSePn8k4Rt3wAbLPG+D9GfbZIa5Rdrv+2TQn835yga
 P8q5L6iRCOUdcnJcw5yqL8m9oDkQt7PbSfnqmloBz9NJCcXP9Br9pN+KxKjY09iDdZWVJyYWy
 /XSQLAfI1zckhq/sOCbMQ93wpRjUBwv3kp/MKs2j/BGVUBXme7kkUOGa8lappBpp+SAUzhz/r
 uhrS3xwuHrBYYOg10P9KHUMfT0vRZzBf6RdWImxWmxtvnlfMSXxtmYHlu4XtnbOloT8vW1IyL
 22LSFByU/gt9xqHCIkrb+QHLqHzHNayWocXfpsvhQMbB7IUely1EZK1YIgq6V96Abyj+NoGio
 l0j06xtMsY2uKYpl0njEeQHo+dVjnwAKhqHpRDFY68cKveCp1KNLSV11hJ9shji4Gervg3Y4C
 Wa++DLF98UaK1eaAutpBcift72uZynJy3nws1+p/VRdcy2DgXeX739WO4K3Kt7CTcWFSI/hlT
 kLMYSgUy6aRrzgCEHfIj5skZpd0Hj3QM9PAuYBMle5v+E=



=E5=9C=A8 2024/4/18 16:52, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/4/18 16:48, Anand Jain =E5=86=99=E9=81=93:
>>
>>
>> On 4/18/24 14:30, Qu Wenruo wrote:
>>>
>>>
>>> =E5=9C=A8 2024/4/18 15:44, Anand Jain =E5=86=99=E9=81=93:
>>>> In the function btrfs_write_marked_extents() and in
>>>> __btrfs_wait_marked_extents()
>>>> return the actual error if when filemap_fdata<write|wait>_range()
>>>> fails.
>>>>
>>>> Suggested-by: Josef Bacik <josef@toxicpanda.com>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>
>>> Looks fine for the patch, although I have a small question.
>>>
>>> If we failed to write some metadata extents, we break out, meaning the=
re
>>> would be dirty metadata still hanging there.
>>>
>>> Would it be a problem?
>>>
>>
>> I had the exact same question, but what I discovered is that the
>> error originated here will lead to our handle errors and to readonly
>> state. So it should be fine.
>
> Yep, I know we would mark the fs error, but would things like
> close_ctree() report other warnings as we still have dirty pages for
> metadata inode?

Nevermind, I just injected a metadata leaf writeback error with this
patch applied, and everything looks fine, no extra warning on btree inode.

So I believe we're already doing proper cleanup.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Thanks,
> Qu
>
>> Further, if submit layer write/wait is
>> failing there is nothing much we can do as of now. However, in the
>> long run we probably should provide an option to fail-safe.
>>
>> Thanks, Anand
>>
>>> Thanks,
>>> Qu
>>>> ---
>>>> v2: add __btrfs_wait_marked_extents() as well.
>>>>
>>>> =C2=A0 fs/btrfs/transaction.c | 4 ++++
>>>> =C2=A0 1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>>>> index 3e3bcc5f64c6..8c3b3cda1390 100644
>>>> --- a/fs/btrfs/transaction.c
>>>> +++ b/fs/btrfs/transaction.c
>>>> @@ -1156,6 +1156,8 @@ int btrfs_write_marked_extents(struct
>>>> btrfs_fs_info *fs_info,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (wait_=
writeback)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 werr =3D filemap_fdatawait_range(mapping, start, end);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_extent_st=
ate(cached_state);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (werr)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cached_state =
=3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cond_resched()=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start =3D end =
+ 1;
>>>> @@ -1198,6 +1200,8 @@ static int __btrfs_wait_marked_extents(struct
>>>> btrfs_fs_info *fs_info,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 werr =3D err;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_extent_st=
ate(cached_state);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (werr)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cached_state =
=3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cond_resched()=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start =3D end =
+ 1;
>>
>

