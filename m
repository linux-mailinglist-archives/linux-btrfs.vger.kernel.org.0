Return-Path: <linux-btrfs+bounces-8187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ECE983C51
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 07:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C568A1C225FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 05:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6E3AC2B;
	Tue, 24 Sep 2024 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Fgv8VLVA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015BF2E401
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155135; cv=none; b=ddCI6lRBJnU0oO2Lz8xdts1kS6HSyk6XeEGGzw6KJHLqa57jhntDKKPoknqMQhwkjwmGwW64+uWvxQi23vgraWDerVSXThK2MTIPFjg5NiLCmkFNLm4Gcfp4LzgDHcyIkVqND1Qq+r5aQWvCLSJo6eFT8+C4nV3w6auz8xEfG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155135; c=relaxed/simple;
	bh=wnlmVdseJ2GwiNwXXwHQOCfinGss4iEOFv2Z/qt84NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gG0pkd9n+ReQ6VxHHEEnekbIAe0MFIWPJrYin2mjfvVxjBvb9whq83iho3U1zThLmvHkEJ8PBHFJN9se6zYjZ1Iv90Q97PWa7TOIF5TdOlzrbsvF1+K4nwltCXCru5F3sRoZ3Rzhb6tHG/vDR+ZQxue2sUHiwBO7v9iPuOZ8HMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Fgv8VLVA; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727155130; x=1727759930; i=quwenruo.btrfs@gmx.com;
	bh=4Hgac4UsSSxMubQrnh6FAizNgR9RCggq1ky+sQIVMCA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Fgv8VLVAygbDrZ1KRU+DA3GPjG9wquLWkc7f1QD+lECa1KKtYlJr/5cuQbnw9iLJ
	 LNzLeypG0kDcVqm92QyiOvHFrPkDOrd2xfDiFgGF/Ugd+NEH3TP5nw6Gv5SIQqpe5
	 JoCFNEB9+gzA4lJYJFqgE+JsPxV0S3Kok7FVSxZCynCQTBCXqioYch09bKx9E95hV
	 KOWOY3YFvUit6b7NX25PwUqOrQAFQVPXmwFkWKHRVel+5bHNQ1Y2oSiyf7mmaZxXC
	 voXHh9l2Nu+YTLrCFFDcsDJIrRp540ULGeqoIPvwrVhmXxV6dLmRXedPkJ3xc0qwQ
	 +54GzgGzDHX7CJXjng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McY8d-1sNTTo3fzx-00jJ1a; Tue, 24
 Sep 2024 07:18:50 +0200
Message-ID: <a9793ad6-1254-43d3-8a78-6bad7a27eaf1@gmx.com>
Date: Tue, 24 Sep 2024 14:48:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Filesystem corrupted
To: Dave T <davestechshop@gmail.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB4TvLV=6JNyk+m+R-bkec-y+GZo4MaaMK8cn=5ghf9Sgg@mail.gmail.com>
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
In-Reply-To: <CAGdWbB4TvLV=6JNyk+m+R-bkec-y+GZo4MaaMK8cn=5ghf9Sgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VDUDi5XK4b11HOn3tCVNA9NOQV6w4fkl1XYhU90rHDzlsmknYoO
 +5P1JIPv9rDZScJp+D53rOFI+qnN8lfBn3cPqNkCaebp1nADW9m66xQlwjNrHgZuLFIbkXD
 zGG1LKhmObH+xMx17K071VjooUWMibyV4GcrKGGUu211zYBWGhF5EMAOePbQsJ6vzDbPfSp
 Q5GiDK0zRRu7rEv3gT12Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zFkbgCsuGyo=;GD7OFr/7YCjwKFW5k4+aOPU7s3d
 5LUBIOOf0a7RhyAFR0CayIaCS80ljK4SUVQJZKXa6+rvs6Tf3HAmOemHWLIDte2S81lw4Sh4L
 FJZlWbDvNEFkMmjWnDy4mF0o4Enas1Q7Amtj/6ys4lfj/Bwl0/WRmueOkuhkL/ByKnZVXxAOS
 aHyG3v+YmWbHs9gJCBeBeed4ju8n0EjgSWXcpaQRHsK1MmmgvJ8NRje4ZgRY8BTRsS4hskjy5
 wUVrcdwL3SNfiPpEPylVvjhM0Z+THK7XI5Dhp8H6NFjqwGEZjIzSJBCNhZSY8yZRtzD6AgNaB
 i9B3dRJLTsRwBUhEvejkJVZ3UGttqP2wXUQm2K2aO116Z5FHL8ZZ+ZX0I6dqwHvDSFFpkH51D
 aJLDIA5PU1ScTHpVI5GGrvOOuy8Jo8YZKgXarvviKQ6yszz8/A6e9pMv1/NGPDoDnluYd3lO6
 15tP4stTm2Dh4qjYLjIk+p/FAaC29DgqINIvmumGPSPc2rUQqO0emsAclqeJeociWWtI5a/b+
 2ra9alXnD4RbelIaRCxc+5M9Be3COhmITwa9z0R2BgehBjeeq8KWAUM7jdLW+4r0zCdnNFu79
 AQAgrmju3kWz5W6CT/rczSDHg+sOtjE3cTcwv5b6Zz6vPjlFgDeFiULaO+1/2nLrFJ6HQAI1p
 ivANgEW3Jlh+vlMU4n+goyJ40WjrUT6FAq9PHRrtdE2czgrT4ypsYBIB5ItYm+W1loHCIQbQf
 GlkpbjDnv6vNDNSOUYTtpFXBHW1dVuaQIxWxCYDlcA6f0inJZhUoMo+qsE3U+KhTwyKy7Bhj4
 p2fC4mdTOhOdzdMEAvYJagRg==



=E5=9C=A8 2024/9/24 12:53, Dave T =E5=86=99=E9=81=93:
> Hi. I hope you all are doing great today.
>
Full dmesg please, the important thing is in the tree block dump.

Thanks,
Qu

> My errors, shown by dmesg, are:
>
>      [  +0.000001] ---[ end trace 0000000000000000 ]---
>      [  +0.000045] BTRFS: error (device dm-3 state A) in
> __btrfs_free_extent:3213: errno=3D-117 Filesystem corrupted
>      [  +0.000040] BTRFS info (device dm-3 state EA): forced readonly
>      [  +0.000006] BTRFS info (device dm-3 state EA): leaf 253860954112
> gen 33587 total ptrs 44 free space 7040 owner 2
>      [  +0.000006]   item 0 key (227177136128 168 4096) itemoff 16165
> itemsize 118
>      [  +0.000004]           extent refs 6 gen 135 flags 1
>      [  +0.000003]           ref#0: extent data backref root 490
> objectid 426314 offset 0 count 1
>      [  +0.000006]           ref#1: shared data backref parent
> 266540040192 count 1
>      [  +0.000004]           ref#2: shared data backref parent
> 266489888768 count 1
>      [  +0.000002]           ref#3: shared data backref parent
> 266355113984 count 1
>      [  +0.000003]           ref#4: shared data backref parent
> 254191386624 count 1
>      [  +0.000003]           ref#5: shared data backref parent
> 253776723968 count 1
>      [  +0.000003]   item 1 key (227177140224 168 4096) itemoff 16047
> itemsize 118
>      [  +0.000003]           extent refs 6 gen 135 flags 1
>      [  +0.000002]           ref#0: extent data backref root 490
> objectid 426315 offset 0 count 1
>
> [ many more lines similar to those ...]
>
> 1
>      [  +0.000001]           ref#1: shared data backref parent
> 267180081152 count 1
>      [  +0.000001]           ref#2: shared data backref parent
> 267147689984 count 1
>      [  +0.000001]           ref#3: shared data backref parent
> 267079172096 count 1
>      [  +0.000001]           ref#4: shared data backref parent
> 266967515136 count 1
>      [  +0.000001]           ref#5: shared data backref parent
> 266640392192 count 1
>      [  +0.000001]           ref#6: shared data backref parent
> 266567483392 count 1
>      [  +0.000001]           ref#7: shared data backref parent
> 266540072960 count 1
>      [  +0.000000]           ref#8: shared data backref parent
> 266504208384 count 1
>      [  +0.000001]           ref#9: shared data backref parent
> 266489937920 count 1
>      [  +0.000001]           ref#10: shared data backref parent
> 266355163136 count 1
>      [  +0.000001]           ref#11: shared data backref parent
> 254357438464 count 1
>      [  +0.000002]           ref#12: shared data backref parent
> 254230626304 count 1
>      [  +0.000001]           ref#13: shared data backref parent
> 254217519104 count 1
>      [  +0.000001]           ref#14: shared data backref parent
> 254191435776 count 1
>      [  +0.000001]           ref#15: shared data backref parent
> 253777051648 count 1
>      [  +0.000001] BTRFS critical (device dm-3 state EA): unable to
> find ref byte nr 227177795584 parent 266504192000 root 490 owner>
>      [  +0.000018] BTRFS error (device dm-3 state EA): failed to run
> delayed ref for logical 227177795584 num_bytes 61440 type 184 a>
>      [  +0.000017] BTRFS: error (device dm-3 state EA) in
> btrfs_run_delayed_refs:2207: errno=3D-2 No such entry
>
> The drive is a Samsung SSD 970 EVO Plus 2TB.
>
> Overall:
>      Device size:                   1.82TiB
>      Device allocated:           300.04GiB
>      Device unallocated:            1.53TiB
>      Device missing:                  0.00B
>      Device slack:                    0.00B
>      Used:                        299.07GiB
>      Free (estimated):              1.53TiB      (min: 1.53TiB)
>      Free (statfs, df):             1.53TiB
>      Data ratio:                       1.00
>      Metadata ratio:                   1.00
>      Global reserve:              398.55MiB      (used: 16.00KiB)
>      Multiple profiles:                  no
>
> Data,single: Size:298.01GiB, Used:297.82GiB (99.94%)
>     /dev/mapper/userluks  298.01GiB
>
> Metadata,single: Size:2.00GiB, Used:1.25GiB (62.51%)
>     /dev/mapper/userluks    2.00GiB
>
> System,single: Size:32.00MiB, Used:48.00KiB (0.15%)
>     /dev/mapper/userluks   32.00MiB
>
> What is the recommended course of action given this error?
>
> What other info do I need to share, if any?
>
> Thank you!
>


