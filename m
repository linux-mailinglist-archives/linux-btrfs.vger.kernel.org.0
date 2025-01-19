Return-Path: <linux-btrfs+bounces-10999-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219C7A16004
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 03:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B5A1886AD4
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 02:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B4F14286;
	Sun, 19 Jan 2025 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BC+GLukE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EC1F5FA
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737254831; cv=none; b=ubhVLUJXLjJ90PCGxhhuFerCVYYLdMiC4lpkILCQCdYXiPaUbFAm9tM1mNe7F/dXvHiah+rpshv/rkFEKrOOd5teEN/l6uFPRAdna0zt5ZQZTM/w93Sb7QmcKE2FQsQ3Osk378e0s/JlB1SKb1Db6jJSD8/j1biKRxbGgy4Kojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737254831; c=relaxed/simple;
	bh=B2ZSBMQpMfFMERzkv1Klyu01wmbxAuu401n5+ateyqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C3hIfMxusNhuf9+7TkHrgUCgMzWbnbsrpyB+PcAuHqR8Owz02qxTfnjpLyc9z/n9plT8WDvNkTIMIq2W9dYdZ5t6VxHPxMkBCsZbCSNPePhV+JvXZb17+7lnkN3YHWrRwuHfgwCLXeUpB1hnbEyzo2WaxRqIn2NgVc2yUWEmh48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BC+GLukE; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737254826; x=1737859626; i=quwenruo.btrfs@gmx.com;
	bh=UigmLhAqCoZMaRCb3+IufoTjEznh2kFgwHi+APBRFF8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BC+GLukE0iyrBxTzd+5ruEkHp0mNnQ82Qlqxj93ZG5l6AKLGfEWsxgQXJJjPfps8
	 DrU0HETsXkeDCAMsOu9HLkaf3sU2uLy7qGgVqDT/Xcn+jaTQebhBqoWVxEbXUJjxw
	 z6XZ3cL2lc/Swa/Vu3/lFfbpN/Eb0K9KTDRyAk3wyXmK1tlEHT5gj+TtN3yzm53wv
	 uDGG17jAzXw8bbqKmY04jUfPaYJSIZDOxt4rU9N85tc5djQvXqzHVYfBZHRfx1H9d
	 wAmbLfFachZGDbz65TdZW0IPaoYM/SrBeEETwn5rrShqO8ZCk/hBIja7z5bDUP3fX
	 cg7K12cqlIsfH8Ey4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6lpG-1tb0pr3Qqs-007WcC; Sun, 19
 Jan 2025 03:47:06 +0100
Message-ID: <43f5b804-d18e-4bd6-8c19-08b4c688307c@gmx.com>
Date: Sun, 19 Jan 2025 13:17:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS critical: unable to find chunk map for logical
To: Dave T <davestechshop@gmail.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
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
In-Reply-To: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WOzRyHdmeWQTJzN9LWBPuwOIXfsjFxA2zyLrpHX6g2cWtMFnrRx
 VglyhgrBsBH0v0G2AjqU98DatAWMfIZkzeeFPQgE86vvFaOOpV7kVb5hTNc04OMvh+Hgo3x
 vOMxAkM7c9eM0PR2KioPPUSE05gSGtuamAteuhsWZxUx6fqmNPmsN5UIUxEi14ZT6nVMzZd
 1d0nGLW2zgrcg3LvxmdUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+JtKyTBhwZM=;r5BamM/GibozOHp8C0IHe47cJMf
 S5dolzPAfFSvPphEpzr5y9JNlgclFhpHZiFc5L0Zu6D4q0ouCOIuHXYiJknytVGXEd+k1qWHt
 VkJXOUBXzy+P2B+BT6U8Snb1Z38Xtx5FzQYxYlY5yE9IMKzjXBQRKyC+bnti43PahLGeQUtV/
 fkeGWisGPNKnscYEq+2jcip/mZC30PbkkPZKwCB0RsCAgxLNnDF+7UyB7Y05RUDW/rpFb5sto
 5HIYaOKmu+Zic3kLgbofgbN3/jMEFxWVHe6543WxyeEIXYhJ4+CFQyphkMR9wsnbLiSFtke5J
 Rh9BD5m0+trWNsdKgcjhx6lk9sydLKm6RnHzrSzLC7YsiCFhYlvn3hkkZeb/8WT5LtwXuD9PO
 wvKF7kMkngstsONMmwq05Za6LWJFaLeMd4ZC7SIud5f6vMDJ4YdhRpfLc1HWLA1hIMlnGpNbw
 NfsKdlL2ULwY12kyIXFyBnedSBhg0fcWnrnigDHdaly/6lDkT81PBuK1jZQ/XdRtPjyPw6jbf
 NgXJjjuG5R999k4lMIsEEj2rbbRnDsNiHXnki3GbJTydnl0x/kRVmIL4fSgoRJDOd46+Ltoxw
 qVq2E/ZlcGxU2tgII4d5SUWGbuvxh+vu9oBA8WSHbkwTw7hnzqiB5Tw2cb56gJ0cZzumMhxNf
 AxPq9AuNrlFtdaCJjiTWRFOhdnQ+NN9EBTdONZ+CxaAKLMQPIAW6XKy0TB3WXHdCpJclcsj+a
 Cpu9B4aUa/FS4EEUZog6RkTrkjy0b9vX6G7cGOYqbZOXXRoGb9vzhg9lOOdZKP5hcXETO5PGh
 MwXqV/95gVu/o6Vot/E1LMK0v//W5TDZQDb9cUPlmpn7RsUtTSvRMN0UEPR6BqB+FcW/eEAa9
 a+rCLm0WqD+NH0vgp5yN1IpdG8n+w1kEdnYVe2th16LeiHeXAm+vn4r0rv18ID6qSb6lwwNEZ
 0u1CgQB64BH4zc5PSoVx7/RXwTKCGfbZfTQxi3zFE36wcmHipF6qXqzM/5vZKA0dZmydr6ffE
 6BohsP1TDGYze10OjjnlIQtLYcghT759gg7spufb4ogs6BUic/KicsNK2sp2vaxon02pQKkH+
 bfCWd46UnGrQbZDSDl3zfpDQmJ5j7XE4Be1XLa8MRuUntZGXaXCWwBmH+8g3i4+jEMHBTWtgw
 G11KT6hiIcw9DyRDJ+pUCg0iI4YochsMcMi2lgm5oYA==



=E5=9C=A8 2025/1/19 11:53, Dave T =E5=86=99=E9=81=93:
> I have BTRFS running on a laptop with a SK Hynix Gold P31 NVMe 2TB
> drive. Since I started using this drive I have seen a few BTRFS
> errors, but scrub has been able to fix them. But today I went one step
> further and found this "critical" error. Here's how it happened.
>
> I was downloading a large (4GB) file when my filesystem went
> read-only. I was not out of space. I rebooted. After rebooting,
> everything seemed fine. I ran my usual BTRFS maintenance, which is a
> filtered balance and scrub. No errors were found. (This is the 2nd or
> 3rd time I have seen this exact scenario since I upgraded to the SK
> Hynix SSD.)
>
> This time I decided to run full balance without filters. That task
> failed the first time with the error:
>
> BTRFS info (device dm-0): balance: ended with status: -22
>
> The filtered balance ran successfully again, but the second full
> balance also failed with:
>
> BTRFS critical (device dm-0): unable to find chunk map for logical
> 404419657728 length 16384
>
> I will paste most of my console output with just a few parts trimmed
> to make it less redundant. My bash function for the filtered balance
> is included too.

The most important part is the full dmesg, at least including the first
error and its call trace.

Single line dmesg seldomly helps.

Also "btrfs check --readonly" on the unmounted fs.

Thanks,
Qu

>
> balance() {
>          echo "starting btrfs balance for $path"
>          path=3D$1
>          runtime=3D0
>          while [ $runtime -le $max_runtime ] && [ $dval -le $max_dusage =
]
>          do
>                  echo "starting btrfs balance with $dval, $mval ..."
>                  start=3D$(date +%s)
>                  time btrfs balance start -dusage=3D$dval -dlimit=3D2..1=
0
> -musage=3D$mval -mlimit=3D2..10 "$path"
>                  end=3D$(date +%s)
>                  runtime=3D$(( $end - $start ))
>                  #echo "runtime =3D $runtime"
>                  dval=3D$(( $dval + $step_size ))
>                  mval=3D$(( $mval + $step_size ))
>          done
> }
>
> dval=3D15
> mval=3D15
> runtime=3D0
> max_dusage=3D100 #btrfs balance filter parameter for maximum dusage so
> balance does not run a very long time
> max_runtime=3D360 #if any balance iteratin exceeds this time, that is
> the last balance run on that path
> step_size=3D5 #increment of dusage and musage filter parameters with
> each loop iteration
>
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/mapper/rootluks  1.9T  733G  1.1T  40% /
> Overall:
>      Device size:                   1.80TiB
>      Device allocated:            741.04GiB
>      Device unallocated:            1.08TiB
>      Device missing:                  0.00B
>      Device slack:                    0.00B
>      Used:                        731.96GiB
>      Free (estimated):              1.08TiB      (min: 1.08TiB)
>      Free (statfs, df):             1.08TiB
>      Data ratio:                       1.00
>      Metadata ratio:                   1.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>      Multiple profiles:                  no
>
> Data,single: Size:736.01GiB, Used:728.07GiB (98.92%)
>     /dev/mapper/rootluks  736.01GiB
>
> Metadata,single: Size:5.00GiB, Used:3.90GiB (77.98%)
>     /dev/mapper/rootluks    5.00GiB
>
> System,single: Size:32.00MiB, Used:112.00KiB (0.34%)
>     /dev/mapper/rootluks   32.00MiB
>
> Unallocated:
>     /dev/mapper/rootluks    1.08TiB
>
> starting btrfs balance for /
> starting btrfs balance with 15, 15 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 20, 20 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 25, 25 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 30, 30 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 35, 35 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 40, 40 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 45, 45 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 50, 50 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 55, 55 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 60, 60 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 65, 65 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 70, 70 ...
> Done, had to relocate 2 out of 743 chunks
>
> starting btrfs balance with 75, 75 ...
> Done, had to relocate 3 out of 743 chunks
>
> starting btrfs balance with 80, 80 ...
> Done, had to relocate 4 out of 743 chunks
>
> starting btrfs balance with 85, 85 ...
> Done, had to relocate 5 out of 743 chunks
>
> starting btrfs balance with 90, 90 ...
> Done, had to relocate 3 out of 741 chunks
>
> starting btrfs scrub ...
> Starting scrub on devid 1
> scrub done for xxxxxxxxxxx
> Scrub started:    Sat Jan 18 13:23:04 2025
> Status:           finished
> Duration:         0:05:15
> Total to scrub:   732.04GiB
> Rate:             2.32GiB/s
> Error summary:    no errors found
>
> btrfs bal start /
> WARNING:
>
>          Full balance without filters requested. This operation is very
>          intense and takes potentially very long. It is recommended to
>          use the balance filters to narrow down the scope of balance.
>          Use 'btrfs balance start --full-balance' option to skip this
>          warning. The operation will start in 10 seconds.
>          Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting balance without any filters.
> ERROR: error during balancing '/': Invalid argument
> There may be more info in syslog - try dmesg | tail
>
> # dmesg | tail
> [  +0.000002] RSP: 002b:00007fffb6d0bd60 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000074c0e=
2887ced
> [  +0.000002] RDX: 00007fffb6d0be60 RSI: 00000000c4009420 RDI: 000000000=
0000003
> [  +0.000002] RBP: 00007fffb6d0bdb0 R08: 0000000000000000 R09: 000000000=
0000000
> [  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000000
> [  +0.000001] R13: 00007fffb6d0cd41 R14: 00007fffb6d0be60 R15: 000000000=
0000000
> [  +0.000004]  </TASK>
> [  +0.000001] ---[ end trace 0000000000000000 ]---
> [ +15.464049] BTRFS info (device dm-0): balance: ended with status: -22
> [Jan18 14:39] perf: interrupt took too long (2506 > 2500), lowering
> kernel.perf_event_max_sample_rate to 79800
>
> starting filtered btrfs balance again...
> [...]
> starting btrfs balance with 90, 90 ...
> Done, had to relocate 5 out of 739 chunks
>
> starting btrfs scrub ...
> Starting scrub on devid 1
> scrub done for xxxxxxxxx
> Scrub started:    Sat Jan 18 14:54:41 2025
> Status:           finished
> Duration:         0:04:59
> Total to scrub:   732.45GiB
> Rate:             2.45GiB/s
> Error summary:    no errors found
> Finished btrfs maintenance.
>
>
> btrfs bal start /
> WARNING:
>
>          Full balance without filters requested. This operation is very
>          intense and takes potentially very long. It is recommended to
>          use the balance filters to narrow down the scope of balance.
>          Use 'btrfs balance start --full-balance' option to skip this
>          warning. The operation will start in 10 seconds.
>          Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting balance without any filters.
> ERROR: error during balancing '/': Input/output error
> There may be more info in syslog - try dmesg | tail
>
> dmesg | tail -n 40
> [  +1.771510] BTRFS info (device dm-0): found 28 extents, stage: move
> data extents
> [  +0.316996] BTRFS info (device dm-0): found 28 extents, stage:
> update data pointers
> [  +0.220585] BTRFS info (device dm-0): relocating block group
> 1585334714368 flags data
> [  +1.846705] BTRFS info (device dm-0): found 24 extents, stage: move
> data extents
> [  +0.354401] BTRFS info (device dm-0): found 24 extents, stage:
> update data pointers
> [  +0.204265] BTRFS info (device dm-0): relocating block group
> 1584260972544 flags data
> [  +1.731777] BTRFS info (device dm-0): found 32 extents, stage: move
> data extents
> [  +0.213906] BTRFS info (device dm-0): found 32 extents, stage:
> update data pointers
> [  +0.172966] BTRFS info (device dm-0): relocating block group
> 1583187230720 flags data
> [  +2.552611] BTRFS info (device dm-0): found 30749 extents, stage:
> move data extents
> [Jan18 15:43] BTRFS info (device dm-0): found 30749 extents, stage:
> update data pointers
> [  +4.242339] BTRFS info (device dm-0): relocating block group
> 1579966005248 flags data
> [  +1.595657] BTRFS info (device dm-0): found 1399 extents, stage:
> move data extents
> [  +1.134944] BTRFS info (device dm-0): found 1399 extents, stage:
> update data pointers
> [  +0.766037] BTRFS info (device dm-0): relocating block group
> 1578892263424 flags data
> [  +1.355692] BTRFS info (device dm-0): found 31 extents, stage: move
> data extents
> [  +0.202763] BTRFS info (device dm-0): found 31 extents, stage:
> update data pointers
> [  +0.162848] BTRFS info (device dm-0): relocating block group
> 1577818521600 flags data
> [  +1.329057] BTRFS info (device dm-0): found 21 extents, stage: move
> data extents
> [  +0.148113] BTRFS info (device dm-0): found 21 extents, stage:
> update data pointers
> [  +0.125740] BTRFS info (device dm-0): relocating block group
> 1576744779776 flags data
> [  +1.325564] BTRFS info (device dm-0): found 18 extents, stage: move
> data extents
> [  +0.118156] BTRFS info (device dm-0): found 18 extents, stage:
> update data pointers
> [  +0.093427] BTRFS info (device dm-0): relocating block group
> 1575671037952 flags data
> [  +1.416460] BTRFS info (device dm-0): found 13 extents, stage: move
> data extents
> [  +0.133543] BTRFS info (device dm-0): found 13 extents, stage:
> update data pointers
> [  +0.107911] BTRFS info (device dm-0): relocating block group
> 1574563741696 flags data
> [  +1.765062] BTRFS info (device dm-0): found 862 extents, stage: move
> data extents
> [  +0.951968] BTRFS info (device dm-0): found 862 extents, stage:
> update data pointers
> [  +0.628234] BTRFS info (device dm-0): relocating block group
> 1573489999872 flags data
> [  +1.721233] BTRFS info (device dm-0): found 18 extents, stage: move
> data extents
> [  +0.275571] BTRFS info (device dm-0): found 18 extents, stage:
> update data pointers
> [  +0.155941] BTRFS info (device dm-0): relocating block group
> 1572416258048 flags data
> [  +2.470482] BTRFS info (device dm-0): found 21244 extents, stage:
> move data extents
> [  +8.365052] BTRFS info (device dm-0): found 21244 extents, stage:
> update data pointers
> [  +5.340568] BTRFS info (device dm-0): relocating block group
> 299998642176 flags data
> [  +3.354148] BTRFS info (device dm-0): found 26160 extents, stage:
> move data extents
> [  +3.453557] BTRFS critical (device dm-0): unable to find chunk map
> for logical 404419657728 length 16384
> [  +0.000011] BTRFS critical (device dm-0): unable to find chunk map
> for logical 404419657728 length 16384
> [Jan18 15:44] BTRFS info (device dm-0): balance: ended with status: -5
>


