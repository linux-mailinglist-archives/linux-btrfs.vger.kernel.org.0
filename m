Return-Path: <linux-btrfs+bounces-1411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA0E82BDEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 10:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854821F21F82
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 09:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157CB5DF23;
	Fri, 12 Jan 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MVVdj2Mq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A385DF0A
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705053208; x=1705658008; i=quwenruo.btrfs@gmx.com;
	bh=FiSOVHgql7U9xnVXxNy+hMfJH9AXCCthzqOfb4xN3CQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=MVVdj2MqpDgEA7xiFSwsfUgNhUokzw/veITuFfX3Jcuk8AhOtz+0d4l0JoVzhdpU
	 sokU0hWUoaHVmK1pvMZ5Ia7pTRGs5OPtU6ejU98iEm9vrElpi3HEFiACy6NlMb6fS
	 qX9KzDd3iotl4jjyXOL/Y8CPh/IPW6AEZ0tdTVZkIBIQ3eLwINiZVorfv+BlzpLGA
	 AXji/tkArR/2QNoc1J6OAkqO9XZdy9OULkBM/ZhioMjJ+AHefmUc8+SE1Quad4E3j
	 0hRO807C35eT+S86c13sqNSuRMeyPhV0yAIFKJs/fRnA9Ilp/trrTZNjgf/CcG1lq
	 edFMDs8AexPLPAqz1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Udt-1rUYwj0H7Z-006zK9; Fri, 12
 Jan 2024 10:53:28 +0100
Message-ID: <2e275902-dc1c-41b1-b1fb-998f7fd16de3@gmx.com>
Date: Fri, 12 Jan 2024 20:23:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scrub reports uncorrectable errors with correctable errors
 unrepaired, but all files are fine
To: Rongrong <i@rong.moe>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <8bd12a1ee60172f53ee0c27374f41c3ec9976be8.camel@rong.moe>
 <27fb4ed5-c3ce-4ab7-a3fd-d77dc8dd4fb2@gmx.com>
 <b10d90cc5eb4f49eabfe3cc0df92ef40b64428b0.camel@rong.moe>
 <794c3085-c5ee-417f-aeaf-d6c0ebd7d96f@gmx.com>
 <f8999f0745b2cddb42d3fbc16fdaf346b530c848.camel@outlook.com>
 <1b4f45c0-da2b-4817-8cdf-a07fd405ce9c@gmx.com>
 <50e1a0a0cf29f361426c0eb7005d389e4dd2833c.camel@rong.moe>
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
In-Reply-To: <50e1a0a0cf29f361426c0eb7005d389e4dd2833c.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I9KW/M7k/D+E/NNB9uBNVflXKs/grssM16dvMGukZvAIxKFOFJD
 8ygfOfUzZuWKVSpNxD76zIT2tqxiVb5eYO+SNRzjy1HyE0mXgaHi0p/WD7qUkw9T58LEuoD
 5bYVyRrdxx+ur2PMA6j4464gTjvLNQJI9QcSBHm9l9DhkKpX1S/EpFpzezo3nO5QEIhe1ZV
 5X5R1scUONm/KF4YJMk/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WugvXyTpl5s=;GHxidoqx0PKsnOiH890jbVbDkzG
 hbbToC35vZtkTt0yYV+dCOgXfgdOOnNaAB3CNCVUqBED3cDYY9JIN8st9Ed7M4m7sLHfo2Cxw
 TzU+uDkwhpHdxrLa0ZU9Q15I2PhqNqZHjt2NF9MTHWUPIUyp14B9RuNMY8XMHlyc4SokAvfiI
 NL1eyNl0byYdE7LF5uWP+C1Qj9KSX2dBmY5T3R6X2HbmX0bHKWrUe3UUyumPerib/AcFuG4ye
 XSDRBVVoG5dTZJ4mJKA/suLg0rWl3MNqp3XbPk8PPvsC2XWiKnuaQmJ/S36Efpincl2h0Uj4X
 bi2E2uW9SJGGkG76t8CU+HlzxRAVaKHJKeUa+ddm1IZuwxUhhMTqsUJTiVnI2CffJt+BuLTdb
 durzhtR4te0Jn7CjZNUfezyJDcLxwkD9/t8MAGLNW77TEzGh1/+JiXM6wTBpCMeGoex3GTJqf
 GYeTzk6hS4kCnciN2rnK65uBljJRZL+x5MnZhhm7oLSfvgLBBthqdZIRYPa5VI8PWcrwjpr/v
 Hd+cWiJCX/TCdrcPR8hNXwRlmdfivg8tGWKra0U2BSPSw42UMQrzrBJs+xVxLNk0bbLViw3QG
 Kiiqr00Wl6xpUetoNh+rKDrjS4GnOaI1B4uzkszg8yhPBTrQKsgRT/oizeLM3+DiluK8MCGvt
 5SkQSWznXgZEBNkrJgysLwJercvNbY0SVBTM4B/SKzXYEI4PKfyqTBpnWQmBRd6tKX/nch+E2
 QMISZwBRnakThcK95DWxSI+0JdrLQdB462uyuuAWP7a/zCNwTxqp4dfb+tugTlx+sKv9D7EP7
 Bjzwl5rVGtUJqsJlSWoE53t1I35MCPKACJqSKzUzbipWbNCxoVhB+VksqcyxckxmWsyP9+yxc
 wdkkAt8NIg4vmBPGXeLSkKu5MCIvxFRUYkiNtifCgwTTBLaNoOhf7NL2U3qbjLgyOa/uCizUf
 D2pZJ/ekTUeHJP6xSX9skl/iViA=



On 2024/1/12 18:08, Rongrong wrote:
> On Thu, 2024-01-11 at 09:22 +1030, Qu Wenruo wrote:
>>
>> On 2024/1/11 00:21, Zhang Rongrong wrote:
>>> On Wed, 2024-01-10 at 20:10 +1030, Qu Wenruo wrote:
>>>>
>>>> On 2024/1/10 19:42, Rongrong wrote:
>>>>> On Wed, 2024-01-10 at 07:49 +1030, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/1/10 04:36, Rongrong wrote:
>>>>>>> I guess the root cause of the issue is that one of the DUP metadat=
a
>>>>>>> copies was somehow corrupted. Am I right?
>>>>>>
>>>>>> I don't think so, I think there may be some false alerts, either fr=
om
>>>>>> kernel scrub interface, or btrfs-progs.
>>>>>
>>>>> OK then. But I just wonder, if this is the case:
>>>>> Why `btrfs inspect-internal logical-resolve [LoC]` returned a file
>>>>> instead of ENOENT?
>>>>
>>>> Then we're having very conflicting results.
>>>>
>>>> "btrfs check --check-data-csum" is really the equivalent of scrub (ju=
st
>>>> offline), which will ensure EVERY copy is verified.
>>>>
>>>> If "btrfs check --check-data-csum" shows no error, I can only came up
>>>> with one possibility.
>>>>
>>>> - There is something missing csum and btrfs check doesn't report
>>>>      the problem in the first place
>>>>
>>>> This doesn't looks that correct to me though, as we have test cases t=
o
>>>> ensure btrfs check can detect extents without csum.
>>>>
>>>> Can you provide the full dmesg/logical-resolve/btrfs-check result
>>>> without hiding the bytenrs?
>>>> That would help us to really clue all the problems.
>>>>
>>>> Especially for dmesg, the full one (from boot to crash/report) is
>>>> appreciated.
>>>
>>> dmesg:
>>> Please check the attachment. Some log were rate limited. I may disable
>>> the rate limit and retry if you need.
>>>
>>> logical-resolve:
>>> It either reported ENOENT or /path/to/file. Did you mean you want the
>>> address in command? I guess the full dmesg should help in that case.
>>
>> Both would help.
>>
>> If "logical-resolve" leads to -ENOENT, and extra dmesg output caused by
>> it, please attach the extra dmesg and the logical bytenr.
>
> #!/bin/sh
> for addr in $(journalctl -t kernel -p 3 -o cat -g 'find logical' | cut -=
d' ' -f9 | sort -nu); do
>          btrfs inspect-internal logical-resolve "$addr" /mnt/tmp
> done
>
> All bytenr leaded to -ENOENT, but no extra dmesg.
>
>> If "logical-resolve" leads to some file, and the filename is not
>> sensitive, please provide the filename and the logical bytenr.
>
> #!/bin/bash
> files=3D""
> for addr in $(journalctl -t kernel -p 3 -o cat -g 'fixed up' | cut -d' '=
 -f10 | sort -nu); do
>          file=3D"$(btrfs inspect-internal logical-resolve "$addr" /mnt/t=
mp)"
>          files=3D"$file"$'\n'"$files"
>          echo "$addr: $file"
> done
> IFS=3D$'\n'
> ls -lhins --time-style=3Dlong-iso $(sort -u <<< "$files")
>
> 2214723584: /mnt/tmp/backup.img
> 463895592960: [SENSITIVE_1]
> 839699742720: [SENSITIVE_2]
> 1016250564608: /mnt/tmp/backup.img
> 1020487204864: /mnt/tmp/backup-1.img
> 1030859390976: /mnt/tmp/backup.img
> 1033007464448: /mnt/tmp/backup.img
> 1035155124224: [SENSITIVE_3].jpg
> 1048041357312: /mnt/tmp/backup.img
> 1084548710400: /mnt/tmp/backup.img
> 1091216670720: /mnt/tmp/backup.img
> 1095442169856: /mnt/tmp/backup.img
> 1104076341248: [SENSITIVE_4].mp4
> 1106023546880: /mnt/tmp/backup.img
> 1116741763072: [SENSITIVE_5].flac
> 1119192154112: /mnt/tmp/backup-1.img
> 1232789045248: [SENSITIVE_6].bak
> 1309241769984: [SENSITIVE_7].jpg
> 1348653416448: [SENSITIVE_8].m4a
> 1375150866432: [SENSITIVE_9].JPG
> 1380060102656: [SENSITIVE_10].jpg
> 1589173420032: [SENSITIVE_11]
> 1655601762304: [SENSITIVE_12].jpg
> 1661099704320: [SENSITIVE_13].jpg
> 1752384798720: [SENSITIVE_14].jpg
> 1756680880128: [SENSITIVE_15].jpg
>       276  58G -rw-r--r-- 1 1000 1000  58G 2022-01-09 10:53  /mnt/tmp/ba=
ckup-1.img
>       266  58G -rw-r--r-- 1    0    0  58G 2021-08-03 15:00  /mnt/tmp/ba=
ckup.img
> 96078331 448K -rw-rw-rw- 1 1000 1000 448K 2038-01-19 11:14  [SENSITIVE_1=
1]
> 63324217 872K -rw-r--r-- 1 1000 1000 872K 2022-01-17 13:46 '[SENSITIVE_4=
].mp4'
> 59771572 4.7M -rw-rw-rw- 1 1000 1000 4.7M 2020-02-26 16:20  [SENSITIVE_1=
0].jpg
>       267 2.4G -rw-r--r-- 1 1000 1000 2.4G 2022-01-24 05:22 '[SENSITIVE_=
2]'
> 99353010 244K -rw-rw-rw- 1 1000 1000 241K 2019-10-11 23:00 '[SENSITIVE_1=
2].jpg'
> 99485427 3.7M -rw-rw-rw- 1 1000 1000 3.7M 2018-05-04 06:21 '[SENSITIVE_1=
3].jpg'
> 59506999  28M -rw-rw-rw- 1 1000 1000  28M 2021-08-09 15:42 '[SENSITIVE_1=
]'
> 59507881  11G -rwxr-xr-x 1 1000 1000  11G 2021-11-06 07:05 '[SENSITIVE_6=
].bak'
> 59638058  39M -rwxr-xr-x 1 1000 1000  39M 2021-11-06 07:45 '[SENSITIVE_5=
].flac'
> 60958833 4.7M -rwxr-xr-x 1 1000 1000 4.7M 2023-07-04 05:53  [SENSITIVE_3=
].jpg
> 60952438 1.3M -rwxr-xr-x 1 1000 1000 1.3M 2023-07-04 05:56  [SENSITIVE_1=
5].jpg
> 60954090 6.7M -rwxr-xr-x 1 1000 1000 6.7M 2023-07-04 05:59  [SENSITIVE_1=
4].jpg
> 60967686 260K -rwxr-xr-x 1 1000 1000 259K 2023-07-04 06:02  [SENSITIVE_8=
].m4a
> 41949177  12M -rw-r--r-- 1 1000 1000  12M 2019-08-31 16:32  [SENSITIVE_9=
].JPG
> 41966502 1.8M -rw-r--r-- 1 1000 1000 1.8M 2019-10-15 16:59  [SENSITIVE_7=
].jpg
>
> No extra dmesg too.
> All these files have no reflink copies.
> The file with mtime 2038-01-19 should be intentional considering its
> usage. Its last modification occurred before 2023 I guess.

OK, this means at least those failed logical bytenr is not really failed
to be mapped.


> Hmm, let me recall...
> Seeing the mtime of files above, I just remembered that:
> The fs was converted from ext4 using btrfs-convert.

This explains why the chunk bytenr are not aligned to 64K.

If you dump the chunk tree (`btrfs ins dump-tree -t chunk`), you can see
all the chunks and their bytenr.

I believe there are quite some chunks not aligned to 64K boundary.
Mind to provide the chunk tree dump of the fs (before the full balance).

> Roughly at the end
> of 2023-07. I always use the latest stable kernel, and the btrfs-progs
> I used then should be v6.3.2=C2=A0(from Debian sid).
> Soon after the conversion, I deleted the ext4_saved subvolume and then
> did balance (-m/-d/--full-balance? I am not sure) and defrag.

I think only metadata is fully balanced, considering most of the failed
logical bytenrs are all for data chunks.


> I had used the fs a lot until scrub said there are errors. I might or
> might not have scrubbed it before. I can't recall it clearly. But I am
> sure that this was the first time I saw errors in the fs.
>
> The mtime of files probably hints that there may be bugs in both btrfs-
> convert and scrub.

That can be another bug. If you can find some other files with 2038,
please open another bug, either github issue (btrfs-progs, as I believe
it's a bug in the convert process) or the mailing list is fine.

And I believe either way, I'm going to dig into the beyond-2038 problem
anyway.
Although it would be better if you have the original ext4 fs and able to
reproduce the problem through btrfs-convert.

>
>
>> Since you have a disk dump of it already, mind to full balance the fs,
>> then retry to see if there is any difference?
>
> Full balance eliminated all scrub errors.
>
> Usage before:
>
> Overall:
>      Device size:                   1.82TiB
>      Device allocated:              1.07TiB
>      Device unallocated:          766.84GiB
>      Device missing:                  0.00B
>      Device slack:                  3.50KiB
>      Used:                          1.03TiB
>      Free (estimated):            805.79GiB      (min: 422.37GiB)
>      Free (statfs, df):           766.83GiB
>      Data ratio:                       1.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>      Multiple profiles:                  no
>
>              Data    Metadata System
> Id Path     single  DUP      DUP       Unallocated Total   Slack
> -- -------- ------- -------- --------- ----------- ------- -------
>   1 /dev/vdc 1.06TiB  6.00GiB 128.00MiB   766.84GiB 1.82TiB 3.50KiB
> -- -------- ------- -------- --------- ----------- ------- -------
>     Total    1.06TiB  3.00GiB  64.00MiB   766.84GiB 1.82TiB 3.50KiB
>     Used     1.03TiB  2.39GiB 208.00KiB
>
> Usage after:
>
> Overall:
>      Device size:                   1.82TiB
>      Device allocated:              1.04TiB
>      Device unallocated:          793.95GiB
>      Device missing:                  0.00B
>      Device slack:                  3.92MiB
>      Used:                          1.03TiB
>      Free (estimated):            795.85GiB      (min: 398.87GiB)
>      Free (statfs, df):           795.85GiB
>      Data ratio:                       1.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>      Multiple profiles:                  no
>
>              Data    Metadata System
> Id Path     single  DUP      DUP       Unallocated Total   Slack
> -- -------- ------- -------- --------- ----------- ------- -------
>   1 /dev/vdb 1.03TiB 16.00GiB  64.00MiB   793.95GiB 1.82TiB 3.92MiB
> -- -------- ------- -------- --------- ----------- ------- -------
>     Total    1.03TiB  8.00GiB  32.00MiB   793.95GiB 1.82TiB 3.92MiB
>     Used     1.03TiB  2.61GiB 144.00KiB
>
> Metadata got even more puffiness, weird.
>
> See also the attached dmesg.
> Explanation of the kernel version (6.7.0-x64v3-dbg-dirty):
> KASAN enabled
> My previous scrub patch applied, which should have no side effect for
> what we are discussing about mainly in this thread.
> (And yes, while scrubbing the fs before balancing without the patch,
> KASAN discovered UAF =E2=80=94 I am not sure if it is a vulnerability th=
at
> shouldn't report in public. I will make another bug report this weekend
> if it is OK to do that)

If you can provide any dying dmesg (thus better using the VM) of the
crash (no matter if it's KASAN enabled or not), as long as it has a
backtrace, it would help a lot.

>
> Should I test balancing only data/metadata to find more clues? Maybe
> metadata? Cuz balancing data is painfully slow :( But if there is
> indeed such a need, I'll do it!

Since after a full balance and the problem is totally gone (aka,
matching the "btrfs check" result), you no longer need to do any balance
as experiments. (Just do the balance on the real disk if you want to
avoid future problems).

Only the crash backtrace would be needed.

Meanwhile it's my turn to dig into the reason why unaligned data chunks
are causing problem.

Thanks for all the detailed info and experiments, this would really help
us to improve btrfs.

Thanks,
Qu

>
>> Thanks,
>> Qu
>
> Thanks,
> Rongrong
>

