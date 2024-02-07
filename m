Return-Path: <linux-btrfs+bounces-2218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5FB84D36F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 22:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC1C287BB9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623A127B7F;
	Wed,  7 Feb 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bGT4oxkd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C647127B4A
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339951; cv=none; b=CPUsuxlMD/45A9wsWHY2jP5sk4huixmvRrlP95hdakulnAkfX/P0e8Q+ao99FKjHaUc9DuW+vOQ8+JpCpHL7RRZ5i6vScCGGXS+aJn5u2AqOHamdfsSeu13Md8VQMVGEUSJnT3Yy4kfdTSFEFNfba2SBTDTkw1jSH6jQUA5r3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339951; c=relaxed/simple;
	bh=F8VryTW/1vPhms/6dpM7EWQ3b++XPhbtR5YpCayXVJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nfGLMafrNOeVDCxBKSxvPX5y5UNZwfnS9WVmioKz+HN/XQJtsXF7YtkhphJnfZRh9Weh/TotyqJJ5IT8lA342EpoG2Abbd+YwkCyn6+rDUqiaPBUkPtSDuck5NZnlmYIaEzrF+Ma860FzuW5bLVqPb/BBuAMpyrjS/RLMWOjtr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bGT4oxkd; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707339939; x=1707944739; i=quwenruo.btrfs@gmx.com;
	bh=F8VryTW/1vPhms/6dpM7EWQ3b++XPhbtR5YpCayXVJ4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=bGT4oxkdRsoDiMJf04ip231qS57U+SG3qQETj2uz5YILo1/oKAVb3uKaBBfKHonw
	 qXuIV68HDlXyBQrhGKUnwCOYWWItrP9VKQx5PnKRX1uWU9OKE23Xhs1tF1Xmnev/U
	 noUF/tNRwOem4fkcWB9RNt2i7NDIAImNm8BTCyJi3IjXT6wzwFj4UF2+DiKkeoNu4
	 j5czYERwg9uzhdxvNwTS2MBOULBT5kSwGWIalAs3GCGmlG0g/mxuHPWxDwbjH07xE
	 0V1ZXE8NFjMfdNH89ryRPbqEyWVWJxXa96zZwjE03IWoWtKHYQGnORZN7Xk/3LMYH
	 Wr+nzwrEU1BailVuuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDQeK-1rh92C2ehi-00AT2F; Wed, 07
 Feb 2024 22:05:39 +0100
Message-ID: <31d07ebd-0147-4761-85fb-5d07e67a6b0e@gmx.com>
Date: Thu, 8 Feb 2024 07:35:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: fix the stray fd close in
 open_ctree_fs_info()
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1706827356.git.wqu@suse.com>
 <abf545db2a21d27c02f92b8a3be0e836fbd3cdd5.1706827356.git.wqu@suse.com>
 <d8484431-72b7-4fe4-a4dc-264f82af7c22@oracle.com>
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
In-Reply-To: <d8484431-72b7-4fe4-a4dc-264f82af7c22@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ngWhzV+UAxgKqLk18hqQ9QacAZHuPxiNjnhR9HxTgR7VPIbFjmF
 EQFcRhRf5ZLtAWvYmEPgszpgv7wgbkIEie/rnksJxa42qlHhD+4Cbf3ifFazHISeudYRiNw
 Ls8K207X+EteSpkF5Q/WSm2JmD2vnyZYzuysPSVydhkenbIRmSNO+cTYQTra1KW+y5DEJZc
 9DKWHg+20HuZlHd+2LDfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/RMwtiKkQRg=;JngrYkJNvbAt8eM5MZaCKR5cIxH
 xBVVxaabwwv99xWErB5jMvqLbafhh3z6oZFQkAm93g12q4HRRRzEnJ8oiCuk6b9mHkc5eBkhP
 WcZKNwqL9EOTeRJTm+n0qziRMnDkDFlKaP/wJRX3bT34XhCJ4/S0jBalnXN+X2KIMG5xTp3Ol
 LzS/+bqVT2WvLOGQqj/xq9fYY981Y5z5u/QI+XVFZhs6By4p5/s/FIK0ezienX2g9sIvCWufM
 FQAKu41G8Qf/TB7wLyp3FApcOaI4vjc0gebQET3e3/cWeBzss7pP1qlFZ9v2bAqnex8cY03C5
 AXalbviIZfMrmkRcdmxTUUw36nMX4svUIF4Q97UzLSEcgmddBwGUV7ZBmgweZMfeGTqmUV8eC
 IQaUpk8f9ElR3x6Aw4TVKSXIAUg6gQ0lFjzuyv6wCqLfHcj6XsGonTqVzxg3wRZovv3aeHPDl
 4o45kFi4RE0NdjO1AX+6EMhfydh4DGxZP/kxUfgJbRsCKfX5qczR1PetL8HDsp7mnh0H612d4
 Gck9brArGj6gzAxWlxEQEEEWl6Ha/1lt3ydOqH91X6WIqRPgkTKyWM43jxsFIQF33ejl5uibZ
 4gbN/jCPwvTMdWIKsFSfBUIa+8SFd6hN+yeRwS67d0I6yIt5jwCS8z/I5ESh8gfAt6I3GfHoq
 b3xl0coEOjgro1kxgTclUHrkfYv8NLokcsdJdo1OHxGT8Kajct/af9VafsTr9/YZbJf3FMZWd
 R3HNIl09BjHVnstNac5ynZwEHBf3SqWh639d8bI6HdE++CKlV0zux5zfcvSE69kzX5nAPS9Dy
 nmvzOS78Qv+mgeGjCNnUtSiMuaHplMRl81+RqQZDJiYu0=



On 2024/2/8 03:06, Anand Jain wrote:
>
>> index c053319200cb..05323b2cd393 100644
>> --- a/kernel-shared/disk-io.c
>> +++ b/kernel-shared/disk-io.c
>> @@ -913,6 +913,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int
>> writable, u64 sb_bytenr)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->metadata_alloc_profile =3D (u64=
)-1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->system_alloc_profile =3D fs_inf=
o->metadata_alloc_profile;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->nr_global_roots =3D 1;
>> +=C2=A0=C2=A0=C2=A0 fs_info->initial_fd =3D -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fs_info;
>> @@ -1690,7 +1691,10 @@ struct btrfs_fs_info *open_ctree_fs_info(struct
>> open_ctree_args *oca)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info =3D __open_ctree_fd(fp, oca);
>> -=C2=A0=C2=A0=C2=A0 close(fp);
>> +=C2=A0=C2=A0=C2=A0 if (info)
>
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->initial_fd =3D fp;
>
> Why not do this in __open_ctree_fd()?

Because we want to keep open()/close() in the same layer when possible.

> then in the parent function, __open_ctree_fd you could:
>
>  =C2=A0=C2=A0=C2=A0=C2=A0if (!info)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(fp);
>
>
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(fp);
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return info;
>> =C2=A0 }
>> @@ -2297,6 +2301,8 @@ skip_commit:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_all_roots(fs_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_close_devices(fs_info->fs_=
devices);
>> +=C2=A0=C2=A0=C2=A0 if (fs_info->initial_fd >=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(fs_info->initial_fd);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_cleanup_all_caches(fs_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free_fs_info(fs_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!err)
>
>
> Essentially this patch converts the following nested open close
>
>
> fd1 open
> fd1 write zero
> fd1 write temp-sb
> fd2 open
> fd2 read super
> fd3 open devices
> fd2 close
> fd1 write temp-sb-to-remaining-dev-if-any
> fd3 write good-sb
> fd3 close
> fd1 close
>
> to
>
> [1]
> fd1 open
> fd1 write zero
> fd1 write temp-sb
> fd2 open
> fd2 read super
> fd3 open devices
> fd1 write temp-sb-to-remaining-dev-if-any
> fd3 write good-sb
> fd3 close
> fd2 close
> fd1 close
>
>
> However the patch
>  =C2=A0 [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in
> mkfs.btrfs
>
>
> achieved: (And reduced one less fd)
>
> fd1 open
> fd1 write zero
> fd1 write temp-sb
> fd1 read super
> fd2 open devices
> fd1 write temp-sb-to-remaining-dev-if-any
> fd2 write good-sb
> fd2 close
> fd1 close

The problem we are hitting don't care how many fds we opened or
whatever, as long as the final close is later than the final fs commit.

>
>
> This patch saves the temporary fd (which is a helper fd to read the sb.
> fd2 in [1]) into a new member fs_info::initial_fd, does not make much
> sense to me. This fix is a kind of a quick, patchy solution rather
> than a ground-up clean design, imo.

Nope, your version needs all caller of open_ctree_fs_info() to converted
to the new interface.

This one keeps the interface untouched and still solves the problem.

Yes, this can be enhanced, but not in the way you did.

The proper way is to make open_ctree_fs_info() to not to rely on any
external fd, but really make open_ctree_fs_info() to only open fds for
its devices.

This would make open_ctree_fs_info() to get rid of __open_ctree_fd()
completely.
That would be a large work and does not provide really much benefit
compared to the current workaround.

Thanks,
Qu

>
> Thx. Anand
>
>

