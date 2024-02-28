Return-Path: <linux-btrfs+bounces-2849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B086A9D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 09:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 491F1B257D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 08:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051602C848;
	Wed, 28 Feb 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OJMZJXm2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F12C6BD
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108700; cv=none; b=Xmv1cJsbrS9pDJUERQ4hmz2HtQlUm4MC+q4SFiyyY6bgS87crg61Slv5lsc/FraK4MwOAnnzdsvTyeB9YW7GI9aj+8ItxlyxlXQxsgbWEt9E2GdVGkKmTUddPBNR0v90k5+h92n4Dj9cqafFOSoOyo8/J1YeCyL+77RI7ye4wjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108700; c=relaxed/simple;
	bh=vNtKyAgzz89URXCqo21K3MG+XhZIKMKMEykPCiAKKEs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ZFR1Zxii06JoCZ/7sW/bRCrPzTE5olTkePz1882jrIhUYBy184/kwOofGXxtEuz4L9lvd9ZCU1vq+g4mTbp5FjIHfE4HCV/anREaOqRXt9yTWlE076qFIyL/o474SxpiEsERRCXy4QgewAx0BIXnsv24ea8sdCbdD+8cXRQmP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OJMZJXm2; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709108692; x=1709713492; i=quwenruo.btrfs@gmx.com;
	bh=vNtKyAgzz89URXCqo21K3MG+XhZIKMKMEykPCiAKKEs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=OJMZJXm2+tkgacJCxxu1s9EMVGKOjZlu+DuMG8wy26rPbg/55YeqLN5D89D8oYSY
	 W8MneVtPpTNB0ecjXCvzgYf9wwqYyUzqhdLQNedFuJBHyr066CCcwSyI9XrEkVLQ4
	 UwZQc9H3bnZDCsXpxML3HaQEr2xWYhRQ0W0KVZOI/Si0P+/P5iUyKxHUuGcfHaXDI
	 x8rwkp0HcH2L2fsOFD9+vmiToEA064qcBa6V+304w/zDfb/ObMh+e1knqXCpCmzGA
	 0rShXRw2kELmAMNDuajeZlLztM/9MqqwS000VtIyPRV7AfwYHQyj3OzR2HBCn4X9x
	 C1VBSM1gueUWL4e1kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4hzj-1qvd121QMp-011j38; Wed, 28
 Feb 2024 09:24:52 +0100
Message-ID: <671192d3-1331-480b-b00a-af3eaf794089@gmx.com>
Date: Wed, 28 Feb 2024 18:54:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.4 and 6.9 btrfs blocked and btrfs_work_helper workqueue lockup,
 is it an IO bug/hang though?
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Marc MERLIN <marc@merlins.org>, linux-btrfs@vger.kernel.org
References: <ZdL0BJjuyhtS8vn1@merlins.org> <Zd5s1k8bFguE2NVl@merlins.org>
 <2020a7b4-b052-4144-8386-b05102a5465d@gmx.com>
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
In-Reply-To: <2020a7b4-b052-4144-8386-b05102a5465d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CC1fllhO//FkEEUz3nSkLtM81aLCkKNJA6PiN/aTygNplD8pQu9
 mAWsT8Ms8iiOSKmSpHiYLt7lraU07gPnl0nRCX2LHgq5N6KnMyUotd/RkUmcUNElJd5/zFU
 IuYnZrzShXvigAVtf5zvDWZ4DRl/ojLioRIFgcMplhccM4mj49erKloU3ROsoV5vEl4eg4a
 piFRaBO9VyJiblpE1azEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tD9lNunUEqo=;LKiHn5+Zp59dJ8GAocGac0ozB4g
 s6rIVpYHFgjOKmyycQ+99T69lkek9iwmVQbYRGCYpgmT4x5EtfX1LiQrJsNt77IBDiqYSGjVq
 G5K8G3NfngWqIcMmG6+t/MoFTBLjfW3IxI/agOCIgKwUwAI+XDi0+E/qXVAMalSDRsSXvnLGO
 PP4t6QO9txX+Olt5q5Bz7i4oJUKVsf+Ni3KXoYh1LkCdKGF1/8pDQSC6jCo8dEiymzTslACg2
 zZi8UTw0/jqm/Udbu3+x8pnxCudioTukuHqYtfa+ATrTisw1dmq8nueJsuzgEqOQySLGe2Vvj
 D0aSW8jNp2VEPDoys7Had5TXL/ieOIyCi+tSP3g7OfrF46NAd/QMi6tf//T7/KlysRmd+PxJ+
 DyJIRW77bjHwY46N7yvQgBNF/QZ6IsDm5th7sO6QlFHAPewZw8ubNDP4DxRGPkkCwiulQpAPg
 uxtrKXVm1BESq5dbzWMo/EQMMoXTli5QCFk0VckWLQvtaySr5YRz5FxNKpky5kDx9+eu/wbRZ
 BdaRqhbl9dh5eul3la1Mk9VddwX32xJ54AV30XWjFi0ka17ouG5DXL1iRWNelR1wUOIE5vSWS
 9+ic1PsMXotdq3dTJEv+NPgQVKfa8++pcjcN9bM2Y9Sejt/wHo/sZ5u8cL36xEBUIiWqmeV08
 X0UwwNZKUQKXOHd1BsbDTnEkdofGfxMJRoLLRqifMu6/IDGcFCp8VOx1AXDG0zIMj7v6rB7pp
 QuHigtmlfszoS+iGrXkd8IOkeCmzW0b6oozfjY/Bn+pf+6O05GkHcPCOLvDyShgL4rqkU7nT2
 Yjh/9xyq1o/11gXzLQO2GKKEW9IZFYZByUApkpJ6gQezY=



=E5=9C=A8 2024/2/28 18:48, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/2/28 09:44, Marc MERLIN =E5=86=99=E9=81=93:
>> Could anyone who can raad those things better than me, give me a clue
>> whether those hangs are hardware related like I'm guessing they may be,
>> or if they are potentially bugs worth looking into?
>>
>> Thanks,
>> Marc
>>
>> On Sun, Feb 18, 2024 at 10:24:04PM -0800, Marc MERLIN wrote:
>>> I've seen this with both 6.4.9 and 6.6.9 and had to sysrq reboot both
>>> times to recover.
>>> I'm trying to see if it's a hang of my raid card.
>>>
>>> That's the more recent hang with 6.6.9:
>>>
>>> The one with 6.4.9 is longer, so I put it here:
>>> https://pastebin.com/xz11JXWM
>
> This one looks like it's hanging at btrfs_commit_transaction+0x26c.
>
> But without the proper code line, it's hard to say what btrfs is waiting
> for.

Sorry, I forgot the remaining lines:

[40182.496902] aacraid: Host adapter abort request.
[40182.496902] aacraid: Outstanding commands on (6,1,4,0):
[40184.012607] aacraid: Host bus reset request. SCSI hang ?

And:
[126424.249101] sd 6:1:4:0: [sdg] tag#557 timing out command, waited 7s
[126424.268557] sd 6:1:4:0: [sdg] tag#557 FAILED Result:
hostbyte=3DDID_RESET driverbyte=3DDRIVER_OK cmd_age=3D91s
[126424.297648] sd 6:1:4:0: [sdg] tag#557 CDB: ATA command pass
through(16) 85 06 20 00 d8 00 00 00 00 00 4f 00 c2 00 b0 00
[126339.560891] aacraid: Host adapter abort request.
[126339.560891] aacraid: Outstanding commands on (6,1,4,0):
[126341.125939] aacraid: Host bus reset request. SCSI hang ?
[126341.142859] aacraid 0000:02:00.0: outstanding cmd: midlevel-1
[126341.160878] aacraid 0000:02:00.0: outstanding cmd: lowlevel-0
[126341.178870] aacraid 0000:02:00.0: outstanding cmd: error handler-0
[126341.198269] aacraid 0000:02:00.0: outstanding cmd: firmware-0
[126341.216574] aacraid 0000:02:00.0: outstanding cmd: kernel-0
[126341.256904] aacraid 0000:02:00.0: Controller reset type is 3
[126341.274617] aacraid 0000:02:00.0: Issuing IOP reset
[126404.886988] aacraid 0000:02:00.0: IOP reset succeeded
[126404.929542] aacraid: Comm Interface type2 enabled
[126413.976679] aacraid 0000:02:00.0: Scheduling bus rescan

It looks like there are something wrong with the aacraid driver, without
several hanging IOs.

That may be the cause.

>
>>>
>>> Here's the 6.6.9 one here. Can someone help me confirm that at least
>>> this one is likely not btrfs' fault but just underlying I/O hang?
>>>
>>> If so, idoes the 6.4.9 match the same symptom, or is it a different
>>> issue?
>>>
>>> Thanks,
>>> Marc
>>>
>>> 135577.600958] INFO: task md12_raid1:1276 blocked for more than 120
>>> seconds.
>>> [135577.621963]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.6.9-=
amd64-volpre-sysrq-20240101 #19
>>> [135577.641401] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [135577.665522] task:md12_raid1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state:D =
stack:0=C2=A0=C2=A0=C2=A0=C2=A0 pid:1276
>>> ppid:2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:0x00004000
>>> [135577.691381] Call Trace:
>>> [135577.699494]=C2=A0 <TASK>
>>> [135577.706627]=C2=A0 __schedule+0x6af/0x702
>>> [135577.717853]=C2=A0 schedule+0x8b/0xbd
>>> [135577.727933]=C2=A0 md_super_wait+0x5d/0x9c
>>> [135577.739287]=C2=A0 ? __pfx_autoremove_wake_function+0x40/0x40
>>> [135577.755602]=C2=A0 write_sb_page+0x242/0x25d
>>> [135577.767482]=C2=A0 md_update_sb+0x4c1/0x679
>>> [135577.779072]=C2=A0 md_check_recovery+0x276/0x484
>>> [135577.791965]=C2=A0 raid1d+0x46/0x10db
>>> [135577.802178]=C2=A0 ? raw_spin_rq_unlock_irq+0x5/0x10
>>> [135577.816122]=C2=A0 ? finish_task_switch.isra.0+0x129/0x202
>>> [135577.831629]=C2=A0 ? __schedule+0x6b7/0x702
>>> [135577.843292]=C2=A0 ? lock_timer_base+0x38/0x5f
>>> [135577.855662]=C2=A0 ? schedule+0x8b/0xbd
>>> [135577.866222]=C2=A0 ? __list_add+0x12/0x2f
>>> [135577.877341]=C2=A0 ? _raw_spin_unlock_irqrestore+0xe/0x2e
>>> [135577.892618]=C2=A0 md_thread+0x113/0x140
>>> [135577.903553]=C2=A0 ? __pfx_autoremove_wake_function+0x40/0x40
>>> [135577.920016]=C2=A0 ? __pfx_md_thread+0x40/0x40
>>> [135577.932413]=C2=A0 kthread+0xe8/0xf0
>>> [135577.942221]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135577.954084]=C2=A0 ret_from_fork+0x24/0x36
>>> [135577.965583]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135577.977475]=C2=A0 ret_from_fork_asm+0x1b/0x80
>>> [135577.989877]=C2=A0 </TASK>
>>> [135577.997078] INFO: task md13_raid1:1278 blocked for more than 121
>>> seconds.
>>> [135578.018044]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.6.9-=
amd64-volpre-sysrq-20240101 #19
>>> [135578.037405] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [135578.061454] task:md13_raid1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state:D =
stack:0=C2=A0=C2=A0=C2=A0=C2=A0 pid:1278
>>> ppid:2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:0x00004000
>>> [135578.087065] Call Trace:
>>> [135578.094972]=C2=A0 <TASK>
>>> [135578.102074]=C2=A0 __schedule+0x6af/0x702
>>> [135578.113302]=C2=A0 schedule+0x8b/0xbd
>>> [135578.123297]=C2=A0 md_super_wait+0x5d/0x9c
>>> [135578.134757]=C2=A0 ? __pfx_autoremove_wake_function+0x40/0x40
>>> [135578.151023]=C2=A0 write_sb_page+0x242/0x25d
>>> [135578.162869]=C2=A0 md_update_sb+0x4c1/0x679
>>> [135578.174470]=C2=A0 md_check_recovery+0x276/0x484
>>> [135578.187342]=C2=A0 raid1d+0x46/0x10db
>>> [135578.197352]=C2=A0 ? raw_spin_rq_unlock_irq+0x5/0x10
>>> [135578.211262]=C2=A0 ? finish_task_switch.isra.0+0x129/0x202
>>> [135578.226731]=C2=A0 ? __schedule+0x6b7/0x702
>>> [135578.238278]=C2=A0 ? lock_timer_base+0x38/0x5f
>>> [135578.250688]=C2=A0 ? _raw_spin_unlock_irqrestore+0xe/0x2e
>>> [135578.265933]=C2=A0 ? __try_to_del_timer_sync+0x64/0x8b
>>> [135578.280350]=C2=A0 ? __timer_delete_sync+0x2e/0x3d
>>> [135578.293706]=C2=A0 ? __list_add+0x12/0x2f
>>> [135578.304886]=C2=A0 ? _raw_spin_unlock_irqrestore+0xe/0x2e
>>> [135578.320238]=C2=A0 md_thread+0x113/0x140
>>> [135578.331038]=C2=A0 ? __pfx_autoremove_wake_function+0x40/0x40
>>> [135578.347265]=C2=A0 ? __pfx_md_thread+0x40/0x40
>>> [135578.359599]=C2=A0 kthread+0xe8/0xf0
>>> [135578.369323]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135578.381272]=C2=A0 ret_from_fork+0x24/0x36
>>> [135578.392702]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135578.404534]=C2=A0 ret_from_fork_asm+0x1b/0x80
>>> [135578.416877]=C2=A0 </TASK>
>>> [135578.424012] INFO: task dmcrypt_write/2:2017 blocked for more than
>>> 121 seconds.
>>> [135578.446256]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.6.9-=
amd64-volpre-sysrq-20240101 #19
>>> [135578.465619] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [135578.489691] task:dmcrypt_write/2 state:D stack:0=C2=A0=C2=A0=C2=A0=
=C2=A0 pid:2017
>>> ppid:2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:0x00004000
>>> [135578.515301] Call Trace:
>>> [135578.523384]=C2=A0 <TASK>
>>> [135578.530433]=C2=A0 __schedule+0x6af/0x702
>>> [135578.541490]=C2=A0 schedule+0x8b/0xbd
>>> [135578.551650]=C2=A0 md_write_start+0x160/0x1a7
>>> [135578.563748]=C2=A0 ? __pfx_autoremove_wake_function+0x40/0x40
>>> [135578.579993]=C2=A0 raid1_make_request+0x89/0x880
>>> [135578.592962]=C2=A0 ? sugov_update_single_freq+0x20/0x106
>>> [135578.607926]=C2=A0 ? update_load_avg+0x372/0x39b
>>> [135578.620814]=C2=A0 ? get_sd_balance_interval+0xf/0x3d
>>> [135578.635156]=C2=A0 md_handle_request+0x126/0x16d
>>> [135578.648040]=C2=A0 ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt
>>> 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
>>> [135578.674973]=C2=A0 ? _raw_spin_unlock+0xa/0x1d
>>> [135578.687325]=C2=A0 ? raw_spin_rq_unlock_irq+0x5/0x10
>>> [135578.701386]=C2=A0 ? finish_task_switch.isra.0+0x129/0x202
>>> [135578.716851]=C2=A0 __submit_bio+0x63/0x89
>>> [135578.728043]=C2=A0 submit_bio_noacct_nocheck+0x181/0x258
>>> [135578.743026]=C2=A0 ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt
>>> 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
>>> [135578.769994]=C2=A0 dmcrypt_write+0xd1/0xfd [dm_crypt
>>> 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
>>> [135578.794848]=C2=A0 kthread+0xe8/0xf0
>>> [135578.804612]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135578.816438]=C2=A0 ret_from_fork+0x24/0x36
>>> [135578.827741]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135578.839744]=C2=A0 ret_from_fork_asm+0x1b/0x80
>>> [135578.852280]=C2=A0 </TASK>
>>> [135578.859445] INFO: task btrfs-transacti:2415 blocked for more than
>>> 122 seconds.
>>> [135578.881710]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.6.9-=
amd64-volpre-sysrq-20240101 #19
>>> [135578.901270] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [135578.925345] task:btrfs-transacti state:D stack:0=C2=A0=C2=A0=C2=A0=
=C2=A0 pid:2415
>>> ppid:2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:0x00004000
>>> [135578.950996] Call Trace:
>>> [135578.958960]=C2=A0 <TASK>
>>> [135578.965902]=C2=A0 __schedule+0x6af/0x702
>>> [135578.976995]=C2=A0 schedule+0x8b/0xbd
>>> [135578.987195]=C2=A0 io_schedule+0x12/0x38
>>> [135578.998015]=C2=A0 folio_wait_bit_common+0x157/0x202
>>> [135579.011950]=C2=A0 ? __pfx_wake_page_function+0x40/0x40
>>> [135579.026658]=C2=A0 folio_wait_writeback+0x30/0x38
>
> But in v6.6, btrfs is only waiting for its metadata to be properly
> written back, that's the only blocked btrfs thread.

On the other hand, there is not enough info provided for v6.6 kernel on
the raid card controller.

Mind to provide the full log?

Thanks,
Qu
>
> On the other hand, there are a lot of md/dm related hanging, which I
> believe is the cause for blocked btrfs IO.
>
> Thanks,
> Qu
>>> [135579.039897]=C2=A0 __filemap_fdatawait_range+0x74/0xbf
>>> [135579.054353]=C2=A0 ? __update_freelist_fast+0x17/0x1e
>>> [135579.068568]=C2=A0 ? __clear_extent_bit+0x323/0x338
>>> [135579.082257]=C2=A0 filemap_fdatawait_range+0xf/0x19
>>> [135579.096112]=C2=A0 __btrfs_wait_marked_extents.isra.0+0x98/0xf3
>>> [135579.113089]=C2=A0 btrfs_write_and_wait_transaction+0x5d/0xbf
>>> [135579.129372]=C2=A0 btrfs_commit_transaction+0x67c/0xa62
>>> [135579.144094]=C2=A0 ? start_transaction+0x3f7/0x463
>>> [135579.157540]=C2=A0 transaction_kthread+0x105/0x17a
>>> [135579.170970]=C2=A0 ? __pfx_transaction_kthread+0x40/0x40
>>> [135579.185951]=C2=A0 kthread+0xe8/0xf0
>>> [135579.195732]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135579.207593]=C2=A0 ret_from_fork+0x24/0x36
>>> [135579.218942]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135579.230778]=C2=A0 ret_from_fork_asm+0x1b/0x80
>>> [135579.243146]=C2=A0 </TASK>
>>> [135579.250316] INFO: task dmcrypt_write/2:5016 blocked for more than
>>> 122 seconds.
>>> [135579.272593]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.6.9-=
amd64-volpre-sysrq-20240101 #19
>>> [135579.291991] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [135579.316244] task:dmcrypt_write/2 state:D stack:0=C2=A0=C2=A0=C2=A0=
=C2=A0 pid:5016
>>> ppid:2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:0x00004000
>>> [135579.341930] Call Trace:
>>> [135579.349929]=C2=A0 <TASK>
>>> [135579.356826]=C2=A0 __schedule+0x6af/0x702
>>> [135579.367910]=C2=A0 schedule+0x8b/0xbd
>>> [135579.377939]=C2=A0 md_write_start+0x160/0x1a7
>>> [135579.390216]=C2=A0 ? __pfx_autoremove_wake_function+0x40/0x40
>>> [135579.406491]=C2=A0 raid1_make_request+0x89/0x880
>>> [135579.419401]=C2=A0 ? update_cfs_rq_load_avg+0x176/0x189
>>> [135579.434131]=C2=A0 ? update_load_avg+0x46/0x39b
>>> [135579.446738]=C2=A0 ? get_sd_balance_interval+0xf/0x3d
>>> [135579.461129]=C2=A0 md_handle_request+0x126/0x16d
>>> [135579.474037]=C2=A0 ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt
>>> 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
>>> [135579.500975]=C2=A0 ? _raw_spin_unlock+0xa/0x1d
>>> [135579.513370]=C2=A0 ? raw_spin_rq_unlock_irq+0x5/0x10
>>> [135579.527308]=C2=A0 ? finish_task_switch.isra.0+0x129/0x202
>>> [135579.542831]=C2=A0 __submit_bio+0x63/0x89
>>> [135579.553918]=C2=A0 submit_bio_noacct_nocheck+0x181/0x258
>>> [135579.568943]=C2=A0 ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt
>>> 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
>>> [135579.595885]=C2=A0 dmcrypt_write+0xd1/0xfd [dm_crypt
>>> 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
>>> [135579.620760]=C2=A0 kthread+0xe8/0xf0
>>> [135579.630682]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135579.642699]=C2=A0 ret_from_fork+0x24/0x36
>>> [135579.654188]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135579.666045]=C2=A0 ret_from_fork_asm+0x1b/0x80
>>> [135579.678418]=C2=A0 </TASK>
>>> [135579.685606] INFO: task dmcrypt_write/2:5286 blocked for more than
>>> 122 seconds.
>>> [135579.707870]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.6.9-=
amd64-volpre-sysrq-20240101 #19
>>> [135579.727445] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [135579.751591] task:dmcrypt_write/2 state:D stack:0=C2=A0=C2=A0=C2=A0=
=C2=A0 pid:5286
>>> ppid:2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:0x00004000
>>> [135579.777266] Call Trace:
>>> [135579.785223]=C2=A0 <TASK>
>>> [135579.792124]=C2=A0 __schedule+0x6af/0x702
>>> [135579.803200]=C2=A0 ? __pfx_wbt_inflight_cb+0x40/0x40
>>> [135579.817139]=C2=A0 ? __pfx_wbt_cleanup_cb+0x40/0x40
>>> [135579.830818]=C2=A0 schedule+0x8b/0xbd
>>> [135579.840951]=C2=A0 io_schedule+0x12/0x38
>>> [135579.851745]=C2=A0 rq_qos_wait+0xe8/0x126
>>> [135579.862795]=C2=A0 ? __pfx_rq_qos_wake_function+0x40/0x40
>>> [135579.878021]=C2=A0 ? __pfx_wbt_inflight_cb+0x40/0x40
>>> [135579.891951]=C2=A0 wbt_wait+0x95/0xe4
>>> [135579.902022]=C2=A0 __rq_qos_throttle+0x23/0x33
>>> [135579.914398]=C2=A0 blk_mq_submit_bio+0x2b6/0x4dd
>>> [135579.927273]=C2=A0 __submit_bio+0x29/0x89
>>> [135579.938356]=C2=A0 submit_bio_noacct_nocheck+0x121/0x258
>>> [135579.953357]=C2=A0 ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt
>>> 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
>>> [135579.980432]=C2=A0 dmcrypt_write+0xd1/0xfd [dm_crypt
>>> 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
>>> [135580.005323]=C2=A0 kthread+0xe8/0xf0
>>> [135580.015088]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135580.026929]=C2=A0 ret_from_fork+0x24/0x36
>>> [135580.038259]=C2=A0 ? __pfx_kthread+0x40/0x40
>>> [135580.050266]=C2=A0 ret_from_fork_asm+0x1b/0x80
>>> [135580.062628]=C2=A0 </TASK>
>>> [135580.069774] Future hung task reports are suppressed, see sysctl
>>> kernel.hung_task_warnings
>>>
>>>
>>> --
>>> "A mouse is a device used to point at the xterm you want to type in"
>>> - A.S.R.
>>>
>>> Home page: http://marc.merlins.org/=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | PGP
>>> 7F55D5F27AAF9D08
>>>
>>>
>>
>

