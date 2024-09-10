Return-Path: <linux-btrfs+bounces-7916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 120389744F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 23:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8011CB242F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126B1AB52E;
	Tue, 10 Sep 2024 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C6lHWiTn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B61AAE0B
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004273; cv=none; b=h04GPTyMqTPSMgTG3jr3N5UlTWJa6le05Yj6b7S67/1umifhDNRA92VRCLReR+wEmlb2WWJOmNH3oXX8N2BV+0NlLdUh/J9H4Ia+UiDTfeAJWIPstrby1jxwYhkxyAnkdu4C+/BjaLbOdzDALyZCvS9NnZC8CDKFMQk8kGMbFOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004273; c=relaxed/simple;
	bh=md6lzAgNWLltNS/mKxF6UetBOT1ph8qQYgnGW0E3GWs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HOLhQs0Aqk31ivqkp9k+gg0yr4UxOtDM0vStsoYogx95fzYlnF5qLz5W2dOEpFcJ+r9tsphS06+MY9M1aiNiYtld9DvZP503VIYUZ/mXGrkPcUGl1rGckKXYlumPZf9XFJBRR8AdiUKBjjHRXTGLIvVW1riaq5WAdK4jHFJ8/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C6lHWiTn; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726004268; x=1726609068; i=quwenruo.btrfs@gmx.com;
	bh=Jv8UStZV+NHgN/3Q0Fzn55ACb//i4vdYFP1BUU85ABc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C6lHWiTn+tGvRTMZsXUZAK4G08QX4Z8W+OnSAQc7Xz8NghyVQ82BIjYUQZu2YF08
	 NelB++3aSQHpqzXJWaZSXwSpeZLarwGnI02qsn/4JvUODaBuMqeOSMh0OwNxlDZuq
	 riWFgkjfibPkxNs6hfoyNL8Q32hFejZ1mc8VyGs18C0D82aNUFHJ4IGqcOCtIp5lr
	 0GpAcgJXYOo0FqNMWTKT5knLWs1zQ2sdzXLzwpkkqtO9oayfx/whf5EE++coCcjqN
	 EGtyhcZMjAuHP2TcO2CVjHWmvC4WIyU+pgQ/5f/zp0Gt0yDE+t7k8GnIJrJIgRTvk
	 tQXAmFrTzVZHDLAdRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mf0BG-1sLvc120uQ-00oNRY; Tue, 10
 Sep 2024 23:37:48 +0200
Message-ID: <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
Date: Wed, 11 Sep 2024 07:07:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Critical error from Tree-checker
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Archange <archange@archlinux.org>, linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
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
In-Reply-To: <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r74gAeCtcfsMweL/OoS1FoGws0ykfgfR/zyrZyf4qcJvUcQyu9E
 wa5W9mr9HKqBaXiEu/i8079tHpGd44RDXDWG9U1YclOZ6HQK6URSWOC8HDhlu3yZDrmW1Lb
 Yain5Iqbd73yiLUZRGcIM+KWjrlbHSg5/HtMhYgbpHSMADcJl46Ckd2ept+GMeBUT5Alpkx
 TqUsK5FYwbpbL0RUXiR3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LN1l7z0SSbI=;JXzpgjx0j30TeJlDcGHUJlVLgin
 AqmJ3mG094dvFtFDuAw7c5JI12D64i3eCKdsPF5ZE9aIlK8DPo59IWKOLcEhkmXTxwYi1DDqH
 sXPwpiW5wr9GIey+Jsy39gD4L3YwabhOsQZ0RzQt+kYN90F7w8KCyjAKoZ7CK91lCv6YdvbD3
 q7gl5jLpCzmdgzSdIFxWQfXS5tt+0nsHWxPGOQKKecArMmrX0WfrZRymN8/gooSef+YlYGTHn
 TR7yvh33f+IrDUYX2ADimz2VSPoGF0U8M8GdtysJ/65UdBiX9gYlLLcgM+Mr+sAwapq6LugH1
 fOC+k8htM/1K6NZdM5t62TMY7xcqWC1UE6vzQlBpGmkKW40wOyFiguq7+Von2FxSCVdFEa5Bw
 kl7ylHDco5kWetdWvoUb5LEk28cPpqgVnad3WQpjU28pAnqxaUGVVc+19pM6NrDvoXslu6/o8
 laY2Q4QsZJZtra/zhfrM1HbsLlsTHsvgu3iTJ8t5OBme5NDK6kADXlbSiMSK4QNAcwFZTGd4t
 tprKKQFz92E6t+MI0MvPn5isv/fgyImWpFbpCBbTavvhufup5fi2RJCfbDiFzccOqogZkw/2k
 mKZApPXVnqxaZl1NH34Dgo0z6WB+o/krUDedOQ17NKhNNm13ir0hKs7TAeTPg9utOe1qeHpmU
 UPjB/8uXiLRsb1C2nlwlEqffdUGyNg13i9ztq8iprYuw1/RDgsgr6xWFqlWgFPhVOjdu/JxbY
 ICZOUfd18UOi8RZFrKLNO3ZBFT9+06O2WQsMwoYi2hN5gBRU0m7oJth+08aaGOWR9lGusPJA4
 Z6eu6hw5PA9++XLqBvqghl5ZpahlGCSGGwUFFYa+72fNo=



=E5=9C=A8 2024/9/11 06:58, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/9/11 06:35, Archange =E5=86=99=E9=81=93:
>> Hi there,
>>
>> Since today, my system started randomly becoming read-only. At that
>> point I can still run dmesg in an open terminal, so I=E2=80=99ve seen i=
t was
>> related to a btrfs error, but did not try anything since I could not
>> open a web browser anymore. But I=E2=80=99ve seen the error to be =E2=
=80=9CBTRFS
>> critical=E2=80=9D and related to a =E2=80=9Ccorrupt leaf=E2=80=9D.
>>
>> I=E2=80=99ve tried to run `btrfs scrub` on the device after rebooting, =
and in
>> fact it aborted almost right away triggering the same error in dmesg
>> (but not turning the system read-only, so I can copy paste it here):
>>
>> [=C2=A0 365.268769] BTRFS info (device dm-0): scrub: started on devid 1
>> [=C2=A0 385.788000] page: refcount:3 mapcount:0 mapping:00000000d0054ca=
e
>> index:0x9678888 pfn:0x11ce15
>> [=C2=A0 385.788015] memcg:ffff9fc94db8f000
>> [=C2=A0 385.788021] aops:btree_aops [btrfs] ino:1
>> [=C2=A0 385.788235] flags:
>> 0x2ffffa000004020(lru|private|node=3D0|zone=3D2|lastcpupid=3D0x1ffff)
>> [=C2=A0 385.788248] raw: 02ffffa000004020 ffffea9a8574ff88 ffffea9a8473=
85c8
>> ffff9fc95b8365b0
>> [=C2=A0 385.788255] raw: 0000000009678888 ffff9fc9ae554000 00000003ffff=
ffff
>> ffff9fc94db8f000
>> [=C2=A0 385.788259] page dumped because: eb page dump
>> [=C2=A0 385.788264] BTRFS critical (device dm-0): corrupt leaf:
>> block=3D646267305984 slot=3D92 extent bytenr=3D1182031872 len=3D106496 =
invalid
>> data ref objectid value 257
>
> Full dmesg please.
>
> Normally it should dump the full content of the tree block, to help
> debugging the problem.

Nevermind, the code doesn't dump the full leaf for debug anyway.

In that case please dump that corrupted leaf by:

  # btrfs ins dump-tree -b 1182031872 /dev/dm-0

Thanks,
Qu
>
> Thanks,
> Qu
>> [=C2=A0 385.788283] BTRFS error (device dm-0): read time tree block
>> corruption detected on logical 646267305984 mirror 1
>> [=C2=A0 385.796803] BTRFS info (device dm-0): scrub: not finished on de=
vid 1
>> with status: -5
>>
>> According to https://btrfs.readthedocs.io/en/latest/Tree-checker.html
>> this is not really expected, and the last paragraph says to report
>> troubles here. So here I am, in the search for advice about this error
>> (web searches returned nothing with this specific error except the
>> commit/ml messages that added the code for it) and how to fix my random
>> lockups.
>>
>> Regards.
>>
>> P.S.: I=E2=80=99m not subscribed to the list, so please keep me in copy=
 when
>> answering.
>>
>>
>

