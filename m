Return-Path: <linux-btrfs+bounces-6212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11838927F09
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 00:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBCA1C21E6E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 22:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ECE1442FC;
	Thu,  4 Jul 2024 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lOipLE15"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E93F9C5;
	Thu,  4 Jul 2024 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720132382; cv=none; b=uImLlcewTunFtAxMHeQ3RqV3DSV2M3qdzGZfCZRdxJ9lFAjLxIhT841cv+/j37djRTOoq47ZF0FY0gdwftGnpbK75R3hxEgwFyMe+gvCJvSFWAPhv4kRmZTq8oHWMrCMpuziQ1PvkuS6YU2xpZ4MuKbNRiixVJjdn06CM6liOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720132382; c=relaxed/simple;
	bh=74lNvrfPxbs8+eP9vL5vMeG0sw3VXPItHCk1N1s7SME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnWoxfyOdzXfDa0BWuG5HHfugPtotfo9NsNYLQp5a8v7O0nJdWRMAIyFnyV1yIKpXs2yz18QLV1/+Va9OJroiwle3Aweh0m1Bbn4cSOQ2AT6pRKjNX4oxvW+03qJ5/sdE+yAZElJ+dP6GZ6D96QEn6UFfBMOecLqIQuGgj16vDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lOipLE15; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720132372; x=1720737172; i=quwenruo.btrfs@gmx.com;
	bh=4Fw9JHDQguqTZj3eEbece4zfLkom2eZW9yCZTYl+hTI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lOipLE15RN/+num62joO3s1snJpsjrBI0BiusrkhIPT+b86Cq0iSPDxt/4PwAq70
	 /wCimmoQXsQxj3xKVFUTnih1S5K5Q2XdmURl4PyvK8+dkz6nxgDUcyHG4Ii4TnZDM
	 oyaUa68J1X6ccCqLjFF+dnMJS/I1etiQVNFuG4yeiT2JRlx7xiwiEK1BRmhBx+/0m
	 n9oU17F46sQV79Vksd8BIKfWOXt/vmNxLGHk2Ufuh8ocyOFzGv4PQd/FEid4RJezG
	 oCt9FGHuISSDj54k7uVk2bRFSLZeflXfVAKjIXE9EUiOH//MNwCr6rUCSaf+JJU/A
	 U2bvWT1JspCmScVGuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dwj-1sJuxK1R6T-017txf; Fri, 05
 Jul 2024 00:32:51 +0200
Message-ID: <0246e506-db8b-47a8-94f0-943e7be92dcc@gmx.com>
Date: Fri, 5 Jul 2024 08:02:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough
 memory
To: Filipe Manana <fdmanana@kernel.org>,
 Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>, dsterba@suse.com,
 josef@toxicpanda.com, Qu Wenruo <wqu@suse.com>
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
 <CAK-xaQagqS0kePozkim7sB_Zi+8NrDRnbqFuLVQ3s4F+0WZ+DQ@mail.gmail.com>
 <CAL3q7H5AFbSy0JC=u_MAfNR-J_kFQkaG6_pXJimD80tchFXytg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5AFbSy0JC=u_MAfNR-J_kFQkaG6_pXJimD80tchFXytg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EEvuVFE6NHxdRvxOGOW2EUWZqpXCeYMRTRBHPd3HnkEzk6/xY+2
 3KM/j0vbxEuBEKZXpmgb6h0PjDuCMC5p7EdMeB+uLn+VMAk8PhMlc9dzd5Bq+gP2YeexKe7
 w2JBuRmSCTAaAoK/FWMwEy6XgqXGX7yuZ4iSfFp0ZHNTyly+23EeJvxyvZG1NXnrxgGx8oV
 U1mwDnyu8dK3xYuNGrn+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7C9UOGk6or8=;pjCyGb12OB4g0CchJyP0KB7vdW+
 6PVy+CtkEy6EVO+UeyBsh/MTgfzjzQHlyF2NXNhK673oOr0U/H3v+q1BtBRmUmdRPGsw8eIg+
 GHFjpxVlUhD1Phv2r+rY1SVAh3YAze8d4zUE9d3PZ5o08xiBUoNhuCn1ssNBvfMZbgPrJVENL
 csdwxeJQsCv/NoIFTUtVJIdgJYT5VFMhnqD/E4WpWjbPuqEA3Il/AtjP/99S3EU5cKb+y+6hp
 RQs8W2VmYRKmUfplDetEBB9DxrUFCTN2sKxohxDEKmO0M+OXy+9Nzk+eKTKwYci0FOY5KAZSn
 pkjZ2YLUyKOXx3IOOQgdNBN7Hb8Ihl+cN9ESSZdDGcxLnfcj4g6BmHpzd1re3xgIA0zysgVfd
 ZIWovnNp6V5PuQNiR8QXJTXdlm1lXk9CJAAJd7KOKT9Fd/CEOwmh0Lh8mogZvG3fV7EcSxvOa
 mJZ6KwFHgcx7k0hmr1zrElFDI9zQ1soirr2bMboU1UE0y4p6Z4YW8NMx43s0hkSC0yZyp4cBI
 E8Cm3+bnn97wNIeClAvEvCEWfma8iu3yg/fhL9MqXonYXQmHnhSbPYmKHjq/X53mGPGdpenk7
 nwJhukrQQjGGjm3QQXvsys33Rv3JAth26SIWWLXYjXmAvyVJz50WCbL0yk/nsspT2ZlvJ7MbM
 KI554nZLWGyMyPvGq/IeycFXIlP1ukbJz85APMd4tFZNJzFUWcdPF4EWi820jOU9UHJcNgvYX
 pzjvkU54yvR1LpOkrjXwObNnonC0E9Hq6SYArb6q+jY4iV/KDnuzIqyxJgpRJYdJIKyQnIXNd
 4J2wFC5d8SVrMKmctcwQOmjB6kzURu9aRxOQ0vFNJGgVU=



=E5=9C=A8 2024/7/5 02:08, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Jul 4, 2024 at 12:19=E2=80=AFPM Andrea Gelmini <andrea.gelmini@g=
mail.com> wrote:
>>
>> Il giorno gio 4 lug 2024 alle ore 11:49 Filipe Manana
>> <fdmanana@kernel.org> ha scritto:
>>> I'll try that soon and see if I can reproduce.
>>
>> I'm creating a qcow installation with everything, to replicate this.
>> Sorry, it takes time.
>>
>> By the way, it's just me? (latest git master btrfs-progs)
>>   btrfs-image /dev/blah-blah loop.dd
>> works perfectly, but
>>    btrfs-image -s  /dev/blah-blah loop.dd
>> generate an image impossible to mount:
>> [gio lug  4 11:20:05 2024] BTRFS info (device loop40): first mount of
>> filesystem 496b800d-2f32-46bb-b8d0-03d6f71cf4b2
>> [gio lug  4 11:20:05 2024] BTRFS info (device loop40): using crc32c
>> (crc32c-intel) checksum algorithm
>> [gio lug  4 11:20:05 2024] BTRFS info (device loop40): using free space=
 tree
>> [gio lug  4 11:20:05 2024] BTRFS critical (device loop40): corrupt
>> leaf: root=3D1 block=3D40297906176 slot=3D6 ino=3D6, name hash mismatch=
 with
>> key,
>
> Sorry I have no idea about that. I don't use btrfs-image myself and I
> don't think I even ever looked at its source code.
> CC'ing Qu who might be interested in that.

That's the nature of "-s" option unfortunately.

Tree-checker has extra sanity checks to ensure the hash matches the name.

I think it's a little overkilled for image dump, would fix it soon.

Thanks,
Qu

>
> I'll reply very soon to the emails about the performance issues that
> correlated to related to the shrinker, there are some interesting
> things to look for.
>
> Thanks.
>
>
>> have 0x00000000365ce506 expect 0x000000008dbfc2d2
>> [gio lug  4 11:20:05 2024] BTRFS error (device loop40): read time tree
>> block corruption detected on logical 40297906176 mirror 1
>> [gio lug  4 11:20:05 2024] BTRFS critical (device loop40): corrupt
>> leaf: root=3D1 block=3D40297906176 slot=3D6 ino=3D6, name hash mismatch=
 with
>> key,
>> have 0x00000000365ce506 expect 0x000000008dbfc2d2
>> [gio lug  4 11:20:05 2024] BTRFS error (device loop40): read time tree
>> block corruption detected on logical 40297906176 mirror 2
>> [gio lug  4 11:20:05 2024] BTRFS warning (device loop40): couldn't
>> read tree root
>> [gio lug  4 11:20:05 2024] BTRFS error (device loop40): open_ctree fail=
ed
>>
>>> In the meanwhile, just curious: are you using swapfiles on btrfs?
>>
>> never used on BTRFS (i have a dedicated nvme partition).
>>
>> Same effect also disabling the swap, btw, and thp.
>

