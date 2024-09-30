Return-Path: <linux-btrfs+bounces-8324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F348F989F51
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 12:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8161F220DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33F18990B;
	Mon, 30 Sep 2024 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uWDtcc5d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689526AEC
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691915; cv=none; b=mT0FofCH3Vq0FJA4K8JDsDEZcQvKhoWNMije13qrO8swZXMby4vYWLeCoyMKLdpKEp0CHeYNx2Brqtxs58znQGy7Vlp1bvefS/P5dwnZwHKRRaTzD3YE5CbCzwo6Wh97klLmi+SdBVDhJx3DccI29BnjOODF3163fkI61fbYcHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691915; c=relaxed/simple;
	bh=ywZ8KujJUsKC7Tbw+yCyrYoAvu497LjquA+iCJtsZJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jyAtXZE0R+p7woRenARGm7mh9T9mpfPSs46ThNFWDJMHeUg3NWDCzNoH4g7Zsfgk4K1WUVBCYdSb9iRT0DvpZh/UqhmgMc57Mhma2eEidi3eE0OTH6eQwwGWs1U52k39z1P2e5K7j5aqMW8tUljE4aNVNoL64Xsn7FGSr192m3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uWDtcc5d; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727691908; x=1728296708; i=quwenruo.btrfs@gmx.com;
	bh=qnMK5GgHnIosG487xBj/pS1VVi7/Up5c0StnJ8bzj4s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uWDtcc5dF8nca3T27x+D8jnXgx/0Jl7patM9pKO9lvFbODW0rq80mRYOGnBWLGYI
	 MzrTJdxFE1SXGzLbLd6jOhEmlO5KbnnkfxDeeB4fGHNgxlF/grFhMbzf3e4m4i5xA
	 RYSCzq4+d7o9oyVplgmdgAeuS0c3mBu4W2GG+gmyUPiW3EwHifuGeNyzjJlrj7wmQ
	 Yo4+vNdw93HPCW4vvs+Ja6E1puABcs6efgRip0JXt1mP1deszF+HYaouKvOxb6sOl
	 Qj5+R2jJu3H1b8o2rF6YlPB6xzM0H7YRnJLdP7klXEEI/Ue8gpy6HyJlEDEHeP/qH
	 jKFjpzP/mlEJj5725A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiaY9-1sIZ3T09A7-00abt8; Mon, 30
 Sep 2024 12:25:08 +0200
Message-ID: <34787783-dfb8-4505-848d-ed31913cc478@gmx.com>
Date: Mon, 30 Sep 2024 19:55:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Bytes_scrubbed_=E2=80=94_more_than_100=25?=
To: Leszek Dubiel <leszek@dubiel.pl>, linux-btrfs@vger.kernel.org
References: <03362532-cf30-4f02-b5fc-f1a5cc5f5a53@dubiel.pl>
 <0600035f-ef46-4b2d-af68-557541aeeb15@gmx.com>
 <c59b8d64-e9dc-4cf5-94f4-554f9f05d797@dubiel.pl>
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
In-Reply-To: <c59b8d64-e9dc-4cf5-94f4-554f9f05d797@dubiel.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f/j9m6EffAVpM4ItQapS1emymfABBJtwYNsRHBAuuxze/k11bBl
 +KLdkfD5dlG05zRrVGX2Ccob5vdWW5C6W3VGFD1u9X+W5+NXuO1K8zFA/MKLz9P46inXWYL
 DiquNiYBZbSaEhFXQWHfXUyaduc5eJLvviPkDsWAkGHF5ddb7M+znZQzJfeFaC3KPfGvxnm
 9KrSVAM9evpbncLS1zn4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AFW5KG9BypI=;fMA0btrvw0SlFLX5EeBhaFd/o4P
 3LOjhClMdOg+2vHXCkbbBWdBDU7IyozlY3AcEbvwEcf2srpyEt3mlbFVCdVPXlDitNv+mSn5i
 wyH/mzs88QgcDpJ7Cb835GV8rbx4B1G+QapUOer6ttNORMCRbPqUUSTvOZfSWfVBFC/KUtIaW
 aFKjT4EAINylHs37vA2m8HTwHb/MTIMRa4tTuWncaUeu2/uXkwAXDO2VpHAL2Ngu9sBkumBdz
 ZE1yye7RhfU7oEmyEXIHdB9TZXBPAIkkIi/227sTc0YGtdCFR5/IocvoZev7+05VL8J1Hwar6
 jPyCfl5rENSy2y8bT/L7wi9smh0ACH5400fFzb5UjhP+Ct5vqL9N+1xmaRrzQYZR7m7hOn9BR
 qRu0LsrL461KUnT/CjVjOVvKLEX1gjwFaT7rOhH3YtRJ/braCfg2Npaj73AIjzvP7LfaIADUu
 GEcyRF6Mf4uJ8Yeo/GGZAkN+0DU2y94rwpNa4z513KKcN4aoxfYFpDEtg5ZZkM9A1wsjq0Smt
 M50A7WfrdwJ/3NenMT4j0iqIHKTA8vtKGJLk9rsil9NuR2wY0y8oN9cDtzheLOJOBgoJpGbNw
 WcXyAGKbwJnE8fcvEDjsqK4e15OXWUNSPHAKBTyNoyRxJlfdoSr5QH5iJRrWIQeFXT3wL1GAt
 bQ7Pbqm/MToKzC3NV/Jz8ck+xChbUefoCXBLQIXKTcsfgwJ0I67sCVepCJh3sWxTCTkCu2QfK
 hjdFWDCd5PqqZlqBXqlBkDx+DmI+LiKuAtH7kUBS6354YcogiYEE1G85BF0aF/QdUEq2eYfOB
 mBDu2WX7blzspuoBBDaj6uO1i7NbvGrlwPkorwZ9OLerg=



=E5=9C=A8 2024/9/30 14:23, Leszek Dubiel =E5=86=99=E9=81=93:
>
>
> W dniu 29.09.2024 o=C2=A023:57, Qu Wenruo pisze:
>>
>>
>> =E5=9C=A8 2024/9/30 07:02, Leszek Dubiel =E5=86=99=E9=81=93:
>>>
>>> Strange balance statistics =E2=80=94 Bytes scrubbed =E2=80=94 more tha=
n 100% =E2=80=94 100.06 %.
>>
>> Kernel version please.
>>
>> And it's not balance but scrub.
>
> uname -a
> Linux wawel 6.1.0-25-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.106-3
> (2024-08-26) x86_64 GNU/Linux

The kernel may be a little old, but that's understandable for production
systems.

There may be some backport missing.

[...]
>>
>> And output for "btrfs scrub start -BR /" please.
>
> # btrfs scrub start -BR /
> Starting scrub on devid 2
> Starting scrub on devid 3
> Starting scrub on devid 4
> Starting scrub on devid 6
> ^Cscrub canceled for 44803366-3981-4ebb-853b-6c991380c8a6
> Scrub started:=C2=A0=C2=A0=C2=A0 Mon Sep 30 06:44:44 2024
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abor=
ted
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00:13
>  =C2=A0=C2=A0 =C2=A0data_extents_scrubbed: 82427
>  =C2=A0=C2=A0 =C2=A0tree_extents_scrubbed: 12964
>  =C2=A0=C2=A0 =C2=A0data_bytes_scrubbed: 5232234496
>  =C2=A0=C2=A0 =C2=A0tree_bytes_scrubbed: 212402176
>  =C2=A0=C2=A0 =C2=A0read_errors: 0
>  =C2=A0=C2=A0 =C2=A0csum_errors: 0
>  =C2=A0=C2=A0 =C2=A0verify_errors: 0
>  =C2=A0=C2=A0 =C2=A0no_csum: 0
>  =C2=A0=C2=A0 =C2=A0csum_discards: 1277401
>  =C2=A0=C2=A0 =C2=A0super_errors: 0
>  =C2=A0=C2=A0 =C2=A0malloc_errors: 0
>  =C2=A0=C2=A0 =C2=A0uncorrectable_errors: 0
>  =C2=A0=C2=A0 =C2=A0unverified_errors: 0
>  =C2=A0=C2=A0 =C2=A0corrected_errors: 0
>  =C2=A0=C2=A0 =C2=A0last_physical: 2215641088
>
>
> I have hit Ctrl+C, because this is production server.

Unfortunately we need the full output without interruption.

And I didn't notice there are 4 devices involved, in that case, if you
are able to run the command again:

# btrfs scrub start -BdR <mnt>

Just in case, is the fs using RAID5/6?
>
>
>
> Yesterday after about 10 minutes scrub was finished.
>
>
>
> During scrub there was an error:
>
>
>
> [1764229.950738] BTRFS info (device sdc2): found 2 extents, stage: move
> data extents
> [1764231.573799] BTRFS info (device sdc2): found 2 extents, stage:
> update data pointers
> [1764234.059672] BTRFS info (device sdc2): balance: ended with status: 0
> [1765121.795098] BTRFS info (device sdc2): balance: start -dusage=3D0,li=
mit=3D2
> [1765121.842319] BTRFS info (device sdc2): balance: ended with status: 0
> [1765122.036288] BTRFS info (device sdc2): balance: start -
> dusage=3D20,limit=3D2
> [1765122.074392] BTRFS info (device sdc2): relocating block group
> 43792020275200 flags data|raid1
> [1765125.357367] BTRFS info (device sdc2): found 2 extents, stage: move
> data extents
> [1765130.162696] BTRFS info (device sdc2): found 2 extents, stage:
> update data pointers
> [1765131.161454] BTRFS info (device sdc2): relocating block group
> 40262597345280 flags data|raid1
> [1765131.976454] BTRFS info (device sdc2): found 1 extents, stage: move
> data extents
> [1765133.180662] BTRFS info (device sdc2): found 1 extents, stage:
> update data pointers
> [1765133.705422] BTRFS info (device sdc2): balance: ended with status: 0
> [1824793.905634] BTRFS info (device sdc2): scrub: started on devid 2
> [1824793.906309] BTRFS info (device sdc2): scrub: started on devid 3
> [1824793.920337] BTRFS info (device sdc2): scrub: started on devid 4
> [1824794.096698] BTRFS info (device sdc2): scrub: started on devid 6
> [1826317.387741] perf: interrupt took too long (3929 > 3927), lowering
> kernel.perf_event_max_sample_rate to 50750
> [1835794.061788] ata3.00: exception Emask 0x0 SAct 0x60fdf03f SErr 0x0
> action 0x0
> [1835794.061815] ata3.00: irq_stat 0x40000008
> [1835794.061831] ata3.00: failed command: READ FPDMA QUEUED
> [1835794.061842] ata3.00: cmd 60/20:90:50:d6:40/01:00:93:00:00/40 tag 18
> ncq dma 147456 in
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 res 43/40:20:58:d7:40/00:01:93:00:00/00 Emask
> 0x409 (media error) <F>
> [1835794.061880] ata3.00: status: { DRDY SENSE ERR }
> [1835794.061892] ata3.00: error: { UNC }

This matches the original error, which hits a read error.

But I'm not sure if it's the cause of the problem, unless there is
reliable reproducer.

Thanks,
Qu
> [1835794.067408] ata3.00: configured for UDMA/133
> [1835794.067557] sd 2:0:0:0: [sdc] tag#18 FAILED Result: hostbyte=3DDID_=
OK
> driverbyte=3DDRIVER_OK cmd_age=3D0s
> [1835794.067568] sd 2:0:0:0: [sdc] tag#18 Sense Key : Medium Error
> [current]
> [1835794.067576] sd 2:0:0:0: [sdc] tag#18 Add. Sense: Unrecovered read
> error - auto reallocate failed
> [1835794.067583] sd 2:0:0:0: [sdc] tag#18 CDB: Read(16) 88 00 00 00 00
> 00 93 40 d6 50 00 00 01 20 00 00
> [1835794.067588] I/O error, dev sdc, sector 2470500184 op 0x0:(READ)
> flags 0x0 phys_seg 3 prio class 3
> [1835794.067635] ata3: EH complete
> [1835794.603327] ata3.00: exception Emask 0x0 SAct 0x400077d0 SErr 0x0
> action 0x0
> [1835794.603362] ata3.00: irq_stat 0x40000008
> [1835794.603386] ata3.00: failed command: READ FPDMA QUEUED
> [1835794.603401] ata3.00: cmd 60/08:f0:58:d7:40/00:00:93:00:00/40 tag 30
> ncq dma 4096 in
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 res 43/40:08:58:d7:40/00:00:93:00:00/00 Emask
> 0x409 (media error) <F>
> [1835794.603456] ata3.00: status: { DRDY SENSE ERR }
> [1835794.603472] ata3.00: error: { UNC }
> [1835794.609200] ata3.00: configured for UDMA/133
> [1835794.609286] sd 2:0:0:0: [sdc] tag#30 FAILED Result: hostbyte=3DDID_=
OK
> driverbyte=3DDRIVER_OK cmd_age=3D0s
> [1835794.609296] sd 2:0:0:0: [sdc] tag#30 Sense Key : Medium Error
> [current]
> [1835794.609303] sd 2:0:0:0: [sdc] tag#30 Add. Sense: Unrecovered read
> error - auto reallocate failed
> [1835794.609311] sd 2:0:0:0: [sdc] tag#30 CDB: Read(16) 88 00 00 00 00
> 00 93 40 d7 58 00 00 00 08 00 00
> [1835794.609316] I/O error, dev sdc, sector 2470500184 op 0x0:(READ)
> flags 0x800 phys_seg 1 prio class 2
> [1835794.609349] ata3: EH complete
> [1835795.360727] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510580,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.360982] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 260, inode
> 36773998, offset 4096, length 4096, links 1 (path: home/maciol/Prywatny/
> KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/cache2/
> entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.361150] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510575,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.361269] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510579,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.361364] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510576,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.391274] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510574,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.468634] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510573,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.476320] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510570,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.479512] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510569,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.479684] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510568,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.487264] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510563,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.500093] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510566,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.500278] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510567,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.508469] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510556,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.518921] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510552,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.527371] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510555,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.537808] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510554,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.541458] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510553,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.553123] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510546,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.562765] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510543,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.581281] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510538,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.586417] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510530,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.594729] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510533,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.598533] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510527,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.610179] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510521,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.618452] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510497,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.740108] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 474794,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.740278] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 474591,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.797381] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 485871,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.797529] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 485699,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.850217] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 480591,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.850363] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 480374,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.896064] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 491658,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.896208] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 491457,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.911429] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510462,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.943464] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510160,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.968486] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510359,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.992121] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510305,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835795.999645] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510270,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.010103] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510422,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.102149] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 502757,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.240543] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 501010,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.240680] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 500861,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.283617] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 503824,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.323145] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 501777,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.350275] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 499694,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.461669] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 506156,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.461812] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 505947,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.510217] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509475,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.560508] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 504761,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.599381] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 508858,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.621902] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 506961,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.643107] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510010,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.662458] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510392,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.703427] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 496448,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.703579] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 496328,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.725346] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509682,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.766586] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509152,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.811192] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509306,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.837058] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 507981,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.907900] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509003,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.954076] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510241,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835796.979035] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 509838,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.035297] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 461329,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.035490] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 461179,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.117058] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 510200,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.165032] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 471435,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.165200] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 471331,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.269686] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 467223,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.269876] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 467010,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.419407] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 456630,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.419548] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 456436,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.454144] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 439388,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.465529] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 482984,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.475238] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 482983,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.482156] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 451534,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.504520] BTRFS warning (device sdc2): i/o error at logical
> 18020330024960 on dev /dev/sdc2, physical 1264358174720, root 445892,
> inode 36773998, offset 4096, length 4096, links 1 (path: home/maciol/
> Prywatny/KOPIA/AppData/Local/Mozilla/Firefox/Profiles/639vvh1h.default/
> cache2/entries/B1308678666CCF53425333751D17CE4B19B47F63)
> [1835797.504560] BTRFS error (device sdc2): bdev /dev/sdc2 errs: wr 0,
> rd 1, flush 0, corrupt 6513, gen 0
> [1835797.516654] BTRFS error (device sdc2): fixed up error at logical
> 18020330024960 on dev /dev/sdc2
> [1839683.067841] perf: interrupt took too long (4917 > 4911), lowering
> kernel.perf_event_max_sample_rate to 40500
> [1858484.849762] BTRFS info (device sdc2): scrub: finished on devid 6
> with status: 0
> [1861863.999660] BTRFS info (device sdc2): scrub: finished on devid 3
> with status: 0
> [1881501.412639] BTRFS info (device sdc2): scrub: finished on devid 2
> with status: 0
> [1909672.849628] BTRFS info (device sdf3): scrub: started on devid 1
> [1926492.714806] BTRFS info (device sdc2): scrub: finished on devid 4
> with status: 0
> [1943962.429562] BTRFS info (device sdf3): scrub: finished on devid 1
> with status: 0
> [1952243.542008] BTRFS info (device sdc2): scrub: started on devid 2
> [1952243.542552] BTRFS info (device sdc2): scrub: started on devid 3
> [1952243.543065] BTRFS info (device sdc2): scrub: started on devid 4
> [1952243.577412] BTRFS info (device sdc2): scrub: started on devid 6
> [1952256.723006] BTRFS info (device sdc2): scrub: not finished on devid
> 6 with status: -125
> [1952256.737537] BTRFS info (device sdc2): scrub: not finished on devid
> 2 with status: -125
> [1952256.738013] BTRFS info (device sdc2): scrub: not finished on devid
> 3 with status: -125
> [1952256.778698] BTRFS info (device sdc2): scrub: not finished on devid
> 4 with status: -125
>
>
>
>
>
>
>
>
>
>
>
>
>
>


