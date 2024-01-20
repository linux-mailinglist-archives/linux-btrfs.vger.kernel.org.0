Return-Path: <linux-btrfs+bounces-1581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB718332E0
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 07:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85877B2307A
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 06:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477020E0;
	Sat, 20 Jan 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jlcofXBN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F510E1;
	Sat, 20 Jan 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705730416; cv=none; b=Eqj1snHMfd0AJbPCo4icfWf5rX4tEet/uI5LiCKGxBmpAz/xkdxd00uzbKukFxJ8vv7AakG9lWFX4t5MNid199Z9zMfSsi1Rf6GMcn6Hplu/ceSa5gpXxQVy9PGTmiYdtzbzN2dUHpqIpOs5YScOJB0yyw26VLUvNg1xYOmLtu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705730416; c=relaxed/simple;
	bh=cIkFBfLpMKWlQkZCQmZqdlejJJB9NpMVtpEI3jG1RZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dm0j5NZYkEeUQZnW4Me7/33Ij7AIwzmtb7vMGweu812NFGIEAfSqIbr9EbGGpvyy5KpvkcYSW3xqrM/Mdb0ZSW8m0M/GV6in5GNdNPaiUw/JjRlWZdy916wv/LdOx+Snp2n7w4J/wu7Mplfzx9fevL7tSei1dRYADgvxDCnP6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jlcofXBN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705730390; x=1706335190; i=quwenruo.btrfs@gmx.com;
	bh=cIkFBfLpMKWlQkZCQmZqdlejJJB9NpMVtpEI3jG1RZQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=jlcofXBNNJEm2bZ2SzdQjp25/DEjZq6r0fTEfF0oRSuYQutg7kRCpBeQF+QA8SCU
	 3364EEuv4bX4xx0RjfwlevR2V9K8VQjJ1bi1bFvD/EHiKzziNzkwY2UwhKyZ8ZY3b
	 +zSZVShMjn3ec1eiBz+pAra2pUPcWRAuMPjLsOC/veUAXiyWaP8xS9+NV4f/XyvUs
	 od4b8c2OI1wxYV+6U6IhZ59JG6wnzKbEAVT005Zq2Eds913OON/+rNlvJq1rfviPJ
	 iXjned0twTs94ZuyU2OEiD+dGSvQy+lV2+5ZZFx5p4zbCFhrT9xn3d2TXTYcxKbSG
	 QMIo5KZHgm1ge+I56A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQe5u-1rnZaN2sdS-00Ni1C; Sat, 20
 Jan 2024 06:59:50 +0100
Message-ID: <fbe2009b-1ae8-4ebb-98e6-7ca9c2ef6584@gmx.com>
Date: Sat, 20 Jan 2024 16:29:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux Kernel Bug] kernel BUG in btrfs_get_root_ref (assertion
 failed: !anon_dev) and general protection fault in btrfs_update_reloc_root
To: Chenyuan Yang <chenyuan0y@gmail.com>, linux-btrfs@vger.kernel.org,
 clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
 Zijie Zhao <zzjas98@gmail.com>
References: <CALGdzuo6awWdau3X=8XK547x2vX_-VoFmH1aPsqosRTQ5WzJVA@mail.gmail.com>
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
In-Reply-To: <CALGdzuo6awWdau3X=8XK547x2vX_-VoFmH1aPsqosRTQ5WzJVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rqMFq29DGLQxE41/8lph09W7U1P8Q+yXnIzBV7ODg2O+ymxMNjx
 fyXp4i5xpKTSiRSV5i9z6G/XxBpPqQZEMhh2oIn56LSqaGZXRJS0ozYbnZvjvvkaaHhr+QF
 9/X3QNm6WSXpAYnwnywG2ANoKckY5lStH0x/GN4BnYFRbIixaKEN2sFROQShKgUr9z69K4+
 h5VmvOt4QoHXWt8DYDGPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0zZtcIJfibk=;1c5WKL1gxYHg5Cd9pneBtfHsct5
 IQXZjUVoPi8ijFGRD/QcBB4QfIDidc1q/ObsnU/KYfcuOfhH9jfeqC7Ow7HgGCw2C/3UHNNfI
 q6IBo3S+cJYuHudlxRtRV1yeTtu1y0gjxvobz5no74dAHN8qMadT3Q1rrGczYjKLM7mMO4gOT
 Ed3oTGwZ/DROcvg9YExJw7nEWQWqkL1rJq3p18F7Uo/uvokcRiS/1svJ44AJl8zdh+QWjMA62
 +H6FOcoSdtarlz+JQCweacYgfGfndOrXWYbcI+r3K+k3Frds7PzmVPlHRESc6VYs40SFhEsnl
 pSqFnbSc7iRJZXAk+OflabGsgqQE1kG+U9Ial8xhif4cWTNm93K4o9NVM0x0j+7PjHiCz2y9Z
 pCD1dKxMGTwUH92K7x2mOxyVZ6x9nLMjNSIbk22E9zE9kWHrH3VAoOaufAtdSWYI17kkGTDWt
 qIF3F+3HpFQ7Nwmm3VoByduLdbPKT68Gd34oR69cdefxD6k3TdZf/sGc1sRZmLaV9etfo0u1K
 Oa/oueiin6dAlPH7puPpC8xSleSmMo26A8MRudPHRKhSJptz2ZvBAhmDPUIN0kIvhH0t3ROVi
 cCj6dBloWL/Y9dzf9TwcwVz1xSiB4vqvgU8tK2l6g0QG5VPG1lLXFy5xwhPs89ZIoUotxkL1U
 iToszTflWtcAeRpF8ktSWRPdaLlBs/OLwVRg1IHE1w6sVWzRqK4eUVbqbzp96jGG4DZsUJ07k
 H629+jK/PIfebFYCronX9Qu6vBym95izPVT/sx/NSMnSHAY8LkKe8Y7+2BHx6GO4qkD0WPQr1
 P/eNgTuPq+AsYuH3WlNWX+MWvZorS03F2XgjvD7Ez9DOvvVWBhAvOc+PT4wRgUpsa3d2UZRo3
 iqw7oKjaNj6WJc7k1CJoA9GdpxpF6diCx/W5bGHr3jtEcW4ihrsFNePQrgKUZ0G0YobGGYbyr
 jxRAU1PELC4euXGkYT+kIVQidQg=



On 2024/1/20 14:45, Chenyuan Yang wrote:
> Dear Linux Kernel Developers for BTRFS,
>
> We encountered "kernel BUG in btrfs_get_root_ref" and "general
> protection fault in btrfs_update_reloc_root" when testing BTRFS with
> Syzkaller and our generated specifications.
>
> For "kernel BUG in btrfs_get_root_ref", it is an internal assertion
> failure `ASSERT(!anon_dev)` in `btrfs_get_root_ref`
> (https://elixir.bootlin.com/linux/latest/source/fs/btrfs/disk-io.c#L1319=
),
> which asserts the `anno_dev` should be NULL but it is preallocated
> here. I've attached the reproducible C program and report.

Thanks for this report, unfortunately the C reproducer did nothing
related to btrfs, it doesn't even try to mount any btrfs (no dmesg on
mounting/unmounting a btrfs at all).

I guess I'm missing something?

And through the dmesg, it looks like there is something weird here.

Firstly the ASSERT() got triggered means we didn't get any anon_dev
number assigned, but create_subvol() would return an error if its
get_anon_bdev() call failed.

So the only explanation I can come up with is, in a special system that
there is no anon_dev allocated at all, get_anon_bdev() can get @anon_dev
assigned to 0.

In that case, it just means the ASSERT() is not correct as it doesn't
take this case into consideration at all.

I can definitely submit a patch to remove the ASSERT().

Do you have any dedicated URL for this btrfs_get_root_ref() failure that
you want to put as "Reported-by" tag? Or I should just use your gmail
address as "Reported-by"?

Thanks,
Qu

>
> For "general protection fault in btrfs_update_reloc_root", it attempts
> to deference the null pointer in `refcount_inc_not_zero(&root->refs)`
> (https://elixir.bootlin.com/linux/latest/source/fs/btrfs/disk-io.h#L101)=
,
> which is invoked by `btrfs_update_reloc_root`
> (https://elixir.bootlin.com/linux/v6.7/source/fs/btrfs/relocation.c#L926=
).
> Here is the call trace:
> ```
> general protection fault, probably for non-canonical address
> 0xdffffc00000000cd: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000668-0x000000000000066f]
> [ 1904.856783][T69219] Call Trace:
> [ 1904.857057][T69219]  <TASK>
> [1904.857312][T69219] ? show_regs (arch/x86/kernel/dumpstack.c:479)
> [1904.857693][T69219] ? die_addr (arch/x86/kernel/dumpstack.c:421
> arch/x86/kernel/dumpstack.c:460)
> [1904.858074][T69219] ? exc_general_protection
> (arch/x86/kernel/traps.c:700 arch/x86/kernel/traps.c:642)
> [1904.858515][T69219] ? asm_exc_general_protection
> (./arch/x86/include/asm/idtentry.h:564)
> [1904.858941][T69219] ? btrfs_update_reloc_root
> (./include/linux/refcount.h:162 ./include/linux/refcount.h:227
> ./include/linux/refcount.h:245 fs/btrfs/disk-io.h:101
> fs/btrfs/relocation.c:926)
> [1904.859402][T69219] ? btrfs_update_reloc_root (fs/btrfs/relocation.c:9=
29)
> ```
> Unfortunately, we failed to find the reproducible program for
> "general protection fault in btrfs_update_reloc_root". I have attached
> the report and log for it.
>
> If you have any questions or require more information, please feel
> free to contact us.
>
> Best,
> Chenyuan

