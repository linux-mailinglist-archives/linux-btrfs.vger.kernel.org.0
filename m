Return-Path: <linux-btrfs+bounces-83-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65EB7E8F0B
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Nov 2023 08:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336BCB209F3
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Nov 2023 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3936FB4;
	Sun, 12 Nov 2023 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kFUpF8Qa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9EF63CA
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Nov 2023 07:51:13 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878FD2D59
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Nov 2023 23:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1699775468; x=1700380268; i=quwenruo.btrfs@gmx.com;
	bh=QI2PXPnBdq+LQRmD2Wt5cd4/GkY+CCRM12yY1d0jyok=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=kFUpF8Qas6Lw7X3F7/ChaphDr4JYG/hM2SZapEKXaLuGj70QCjSyNbdc6XcpnRj6
	 FpolkdLa31XR5Qkq0i7MFYMzB39kKm3ebtx+VHMTCsUo8n/D5AZXRM4sCLlttvslw
	 Y3CiaZdCpvUtsi3rO3qLbB9GTTlqdvPKb9TgpZX3HBkiXIJ0b3oTI5KbUmCefCfU8
	 FEkIgbubdiHF4x+v12T5QrasZHzs5Ij+Mdu9Kfn/XPKiCAPXF/ymJ8UQrcCrPI15e
	 22SiDK6PyMixl1W1a6Ul9Zj3i6XAxorHEoH4Y1M6b8QAUpLeN0fOPiyYWSdNRCk0X
	 kYTtaIsPs8Sa7sYgZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzfG-1qtw0v3lRq-00R585; Sun, 12
 Nov 2023 08:51:08 +0100
Message-ID: <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
Date: Sun, 12 Nov 2023 18:21:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: checksum errors but files are readable and no disk errors
Content-Language: en-US
To: Johannes Hirte <johannes.hirte@datenkhaos.de>, linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
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
In-Reply-To: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aifeJl9wXBbtlS003TsvaJ+IVqLmp+wPwkSaSSFMQZJak++n3+D
 2LV5fgq3jD/H2YpE6j6EoQfHwHRHyDYep7HPamP+D8eUMQEJ6JnihJraKtnEZqyH4Feaue8
 GL7+parT6ryNlPstePo2H0R/AMSNtuqlelhFoWMf2bmcRcrP9Fcdd53v5eHXbALDIAf2E4g
 Z0n1c//t5AJxQM9QxJ7iw==
UI-OutboundReport: notjunk:1;M01:P0:BmeHBVeHZ9w=;rMWsVTQlS2aiVtYYY3poiJxZNH3
 gCdqOSC0HxY2qNUQqQbzyixEuJ3dPVf4f1N5NEWtUZzr7KieiB9StjwYqI2Jrq/aGfhLa//X3
 etECI6QmkEwfLfOBdaABWtEKLArjA0CQcIvhUniAeFJMwBO4l9ObRopWqJUoWpb5OJWDSpvC3
 9mKKuzHFxyetxTe+Om3L0vWmuta5FCNI1NDoYmXJeH2CM8VQtBgI1Nn7az/vewmsAonPPR0mx
 bOEwhw0f3+bNZ4qILWB8rrU06spl74m6kxLupyoxdU/hECwf/Tp7LHqKFIaQNJEcqFcrlE4xo
 W7+nDxDEirVtCclLgPRficpxG6Hk4V76GrpNZJ4IbhzVnMXX4Wh4H10KJ+/6APXKMMIYSNyZs
 j8jvvaJ8bb4FusVhVkxew12a83w9ghe6Y9DQLihRoQRGTk5OBN1qxle8448kewg71QHkVeWO2
 2Tq9kPQhV2trjaGb9vFHjwuYpFkw7z7kYtkWFdUbYIMVyhfxIeQYdaq0FYOj7jEFkaKfbMbME
 hU6uhf9xP2U2QZL84HXB+WSJDhkt7etIafKECxW9dqWRSfY2e6SCKPnQWBIeTfPP67bxF/9BR
 Lxf/F2MDGJyxuyzYGG69ovyxH4t16gnh8YJouAhdcL7zPaj2EEMQJzfCyYpecXJACcgL3/efc
 SyHPCz4nnk5tMltYuBnPfbkFGa0UEj52wiKVjRs5smxMg5uC9f9zbHiPtRRum++gETTtZ+FYX
 S52/eONpsLxYHB4LPmwO0r4c5ZLSdigdceXfRugdI3mML+nZHca0ObWeUBLQZUWGd4xP4OXxJ
 LHgJ9fEFecbQ22Q+jAOlUujoFPU9w3RfJNkExy2MFGLebVbcccHJ9wyNcf6J2yqhV07rYkGzp
 Dy7FKWReF7qJLLW1U/aR4ss6RtLjcvv1YYslNeIuz4DlrBZM2Uv3aWhgQa5xPrMhSCWOv7gpK
 JY+FefokXQQl3xsLbqSdhwUV1uE=



On 2023/11/11 04:30, Johannes Hirte wrote:
> Hello,
>
> I have a server with two 2T-disks that were running in a Btrfs-RAID1
> setup. Recently I was running into the bug of btrfs-progs-6.6, so the
> system didn't boot anymore. Because I don't have physical access to the
> system, the only option I've had was a hard reset=C2=A0 remotely. After =
this
> I noticed several checksum errors during scrub on different files. I was
> able to delete those files, but the checksum errors persisted, now
> without any file associated. In the end, I removed one disk (sdb1) from
> the RAID. Because relocation doesn't work with checksum errors, I've
> overwritten the first 10M of the partition and mounted the remaining
> disk (sda1) degraded. After this, I created a new filesystem on sdb1
> andI synced the whole sda1 to sdb1 via rsync. This worked without any
> problems, although sda1 still shows the checksum errors. I'm running the
> system from the second disk now with the newly created filesystem. But
> now this FS shows checksum errors again. Two files are affected, both
> are images for virtual servers. I'm able to read both files, I can copy
> via dd without any error. But scrub says, there are checksum errors:

It can be some csum error in the non-referenced part of the file extents
(caused by COW).

In that case, you can try to defrag the offending file (and sync). As
long as there no reflinked nor snapshot for that file, scrub should no
longer report error for it.

For the cause of the error, the most common one is page modification
during writeback, which is super common doing DirectIO while modify the
page half way.
(Which I guess is common for some VM workload? As I have seen several
reports like this)

>
> [52622.939071] BTRFS error (device sdb1): unable to fixup (regular)
> error at logical 1673331802112 on dev /dev/sdb1 physical 1648107257856
> [52622.939189] BTRFS warning (device sdb1): checksum error at logical
> 1673331802112 on dev /dev/sdb1, physical 1648107257856, root 1117, inode
> 832943, offset 566788096, length 4096, links 1 (path:
> var/lib/libvirt/images/vserv03.img)
> [54629.309530] BTRFS error (device sdb1): unable to fixup (regular)
> error at logical 2209355464704 on dev /dev/sdb1 physical 1884523397120
> [54629.309656] BTRFS warning (device sdb1): checksum error at logical
> 2209355464704 on dev /dev/sdb1, physical 1884523397120, root 1117, inode
> 832950, offset 9149956096, length 4096, links 1 (path:
> var/lib/libvirt/images/vserv06.img)
> [54629.309666] BTRFS error (device sdb1): unable to fixup (regular)
> error at logical 2209355464704 on dev /dev/sdb1 physical 1884523397120
> [54629.309719] BTRFS warning (device sdb1): checksum error at logical
> 2209355464704 on dev /dev/sdb1, physical 1884523397120, root 1117, inode
> 832950, offset 9149956096, length 4096, links 1 (path:
> var/lib/libvirt/images/vserv06.img)
> [54760.218254] BTRFS info (device sdb1): scrub: finished on devid 1 with
> status: 0
>
> So what is going on here? I'm planning to recreate the RAID1, but with
> with checksum errors I don't want to go on. System is running kernel
> 6.5.11.

Since you can read the file without problem, you are totally fine to
ignore it.

Despite the above defrag method, you can also copy the offending file to
other locations (just do not use reflink), then delete the old offending
file (from all snapshots and reflinks), and copy the new one back.


BTW, it's recommended to check if your VM is using directIO for that
file, which is known to lead to false csum mismatch alerts.

Thanks,
Qu
>
>
> regards,
>  =C2=A0 Johannes
>
>

