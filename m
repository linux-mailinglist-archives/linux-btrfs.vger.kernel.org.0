Return-Path: <linux-btrfs+bounces-674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E145805F0B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 21:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D6EB211D7
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5B669286;
	Tue,  5 Dec 2023 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YgjRraD6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA59D41
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701806705; x=1702411505; i=quwenruo.btrfs@gmx.com;
	bh=YQTwT/SYTHXZyJJSzkt07l6BXUmx+lYsQZXEWSkNPTg=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=YgjRraD6xbxX6CY9Bw1qX15gXSsGq/09VDfO5E6Ux1dGHQ5VrM+RzMAOV5uLCiB2
	 YURozUokNYBHE62IcBDOmLm7QnP9yUJFcZNwt01DohUzKlxdhoTdEeu0YkdQGnhqG
	 ZzFpTigM5ZLJdlr2l5aN1tLSbjU/kKmGtggaJicvNs2U7kJwqKvM1jF2dcW+XDQ/V
	 V7KfKSMepLioT9LXCFKVGyTgMMprt0dtXJuslGV7FVHKwy6p9vDTF/LaA0KpWodcV
	 RGKm1iWJNuOmF3Uhg38vuyMPrU/9cpzZXszA/AzvR+gi/NNXyk8EAkxtp1vLZr4Gn
	 XGjmD6+iBP7hYE7/pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdvmY-1ri1H43nzK-00azqP; Tue, 05
 Dec 2023 21:05:05 +0100
Message-ID: <8ba85386-fb30-415e-8ef1-05dcaf833c26@gmx.com>
Date: Wed, 6 Dec 2023 06:35:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scrub: unrepaired sectors detected
To: Stefan N <stefannnau@gmail.com>, linux-btrfs@vger.kernel.org
References: <CA+W5K0r4Jkhwm2ztJYwKQ1w91Cb0tObcd4PA6bLDOH18xbmYAg@mail.gmail.com>
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
In-Reply-To: <CA+W5K0r4Jkhwm2ztJYwKQ1w91Cb0tObcd4PA6bLDOH18xbmYAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fyuO6SJFF69c1qPAcYW3uiUfFignB0OPVkWFzQfXWYTOal/Mvc0
 EgWbtE9AVsiTnUQQPbAk745XeBLPZhUfVYSUNpSWZE5Ggl9fGqYgnJZcEML4PX3oOncJmvw
 QE/7lkr4Xa2YPrKxFlksJAyZPHHjyeo8wz+hlQiwyRZdwEOaPHt+r1D3xwtIVTY7WvxzVu9
 i+ctU80NyP8tvMTwmU6QA==
UI-OutboundReport: notjunk:1;M01:P0:/vv6hZMJUwE=;B6TIDnV//TZnR1iQ7axPjDFaFuz
 b7kI3Dr3oL/SsnxBJYW6do/Ft4caf+Cv560LcIFTVNGX86TZkz5cMj0mf6cXHAgwm75z3Mxd6
 AVYHqY6M/F7HC+gg89EVQ+hJP1w0KcCuCBJN8yUPNWqqc3UQvgkv4oTn1Z5i9uf8xtNOwJFlC
 YoBveGZv8XD3MW0mDdU764Kl/gihTCMFeGE2GWjF/gO2rY1hkAQWkitp7f5wt4R8oHcK+6Z0I
 Lt8gHi4OtOjeBQjHJRL2grvWZCGkyK8v+0WleosJJogR8LD7Hwh6anoii88sxuzRBdgVd41hV
 P9RJKVIPuDBSa6VrowMJnfSbVGRbMcW5oebj/G2DlW1RnYUJwnRnjBfjyj0UyvyuPis2xRBvo
 c4XhPlJvu+BxOvAFEAch7rmT8PXsna46Ks3YzuTw1NJ3Sh4w2rGs7Fk4Xc28xbGNQgHXF3x5r
 tAACT+TM8H+phkbYR7mUBKImeq0xxCPefSl4ZVnbBL3vMKnHH7CwaAGMjp5tx6+Oo7LEjv8fq
 affYb+LbVYicKqrKPswRgTyVH8ZOP3yMM6qodkC7pBXU1EuOicXtuB6O414akBKmIsADAIPkv
 77CgOwH9RREVZ5H+kSkXdEzFbV8js1tHCiylfnBWS6X1Mdmoyi/Bq3NiLSL/PFtWq1tU3BZUz
 GGCZ/M30waoOggI17GqqpYEodypkZYkSxCmQ7vObBimI3kAnTPvljUPHhzu/GRK2heaHazoZv
 qiXcbo2HZJEXB1rrUZ46cqQF5OGaZ0tyGcmREnZ4hdtrIDDzYC76acFlp4L7l+aT5LFFzkLc1
 7x8BxPm5F7WvYP2Veso1UK0alQHjK265WE7HGx3LtwLkOe3oCRXh7HFSb8k6xEsuZzze5VKM5
 NSKYI2YiztD+6Nqxutz4JKMIhYJ8unC3oVOR2S9MXjT43MZNlgf5JjpALFqiTwg9rxCd4fMwu
 ADM5+g==



On 2023/12/5 18:21, Stefan N wrote:
> Hi all,
>
> I'm having trouble getting an array to perform a scrub or replace, and
> would appreciate any assistance. I have two empty disks I can use to
> move things around, but the intended outcome is to use them to replace
> two of the smaller disks.
>
> $ uname -a ; btrfs --version ; btrfs fi show
> Linux $hostname 6.5.0-13-generic #13-Ubuntu SMP PREEMPT_DYNAMIC Fri
> Nov  3 12:16:05 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> btrfs-progs v6.3.2
> Label: none  uuid: 3cde0d85-f53e-4db6-ac2c-a0e6528c5ced
>          Total devices 8 FS bytes used 71.32TiB
>          devid    1 size 16.37TiB used 16.37TiB path /dev/sdg
>          devid    2 size 10.91TiB used 10.91TiB path /dev/sdf
>          devid    3 size 16.37TiB used 16.36TiB path /dev/sdd
>          devid    4 size 16.37TiB used 12.54TiB path /dev/sda
>          devid    5 size 10.91TiB used 10.91TiB path /dev/sde
>          devid    6 size 10.91TiB used 10.91TiB path /dev/sdc
>          devid    7 size 16.37TiB used 16.37TiB path /dev/sdh
>          devid    8 size 10.91TiB used 10.91TiB path /dev/sdb
>
> $ btrfs fi df /mnt/point/
> Data, RAID6: total=3D71.97TiB, used=3D71.23TiB
> System, RAID1C3: total=3D36.00MiB, used=3D6.62MiB
> Metadata, RAID1C3: total=3D91.00GiB, used=3D85.09GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> $
>
> Attempting to scrub
> BTRFS error (device sdg): unrepaired sectors detected, full stripe
> 145926853230592 data stripe 2 errors 5-13

This is introduced in recent kernels, to detect full stripe RAID56
stripes which contains sectors which can not be repaired.

This is pretty new behavior as an extra safenet, as sometimes such scrub
itself can further corrupt the P/Q stripes and cause unrepairable sectors.

And I'm afraid that's already the case here.
Older RAID56 code (and even the newer one) still has the old write-hole
problem, thus previous power loss can reduce the redundancy and
eventually lead to data corruption.

Newer scrub code is addressing this by detecting and error out, other
than further spreading the corruption.
> BTRFS info (device sdg): scrub: not finished on devid 2 with status: -5
>
> Scrub device /dev/sdf (id 2) canceled
> Scrub started:    Thu Nov 30 08:01:03 2023
> Status:           aborted
> Duration:         32:17:10
>          data_extents_scrubbed: 89766644
>          tree_extents_scrubbed: 0
>          data_bytes_scrubbed: 5856020676608
>          tree_bytes_scrubbed: 0
>          read_errors: 0
>          csum_errors: 0
>          verify_errors: 0
>          no_csum: 0
>          csum_discards: 0
>          super_errors: 0
>          malloc_errors: 0
>          uncorrectable_errors: 0
>          unverified_errors: 0
>          corrected_errors: 0
>          last_physical: 7984173809664
>
> Attempting to do replace using brand new disks, failed at ~50%, ran
> twice with two different pairs of disks
> Disk /dev/sdi: 16.37 TiB, 18000207937536 bytes, 35156656128 sectors
> Disk /dev/sdl: 16.37 TiB, 18000207937536 bytes, 35156656128 sectors
>
> BTRFS error (device sdg): unrepaired sectors detected, full stripe
> 145926853230592 data stripe 2 errors 5-13
> BTRFS error (device sdg): btrfs_scrub_dev(/dev/sdf, 2, /dev/sdl) failed =
-5
>
> The data is fairly replaceable so typically have been previously been
> deleting files that fail checks and performing roughly 3-monthly
> scrubs and weekly balances (musage/dusage=3D50).

This can be something happened in the past but only caught by newer kernel=
.

Anyway if you're fine to delete some files (only 9 sectors affected),
you can try to locate the inodes for the following bytenr range:

  [145926853382144, 145926853414912]

The way to go is using "btrfs logical-resolve -o <bytenr> <mnt>".

And delete all the involved files, increase the bytenr by 4k, try again
until no more output for every 4K block in above range.

Normally it should only be one or two files.

Then retry scrub, re-do the loop until the scrub can finish properly.

Thanks,
Qu

>
> Any help would be appreciated!
>
> Cheers,
>
> Stefan
>

