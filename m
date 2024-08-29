Return-Path: <linux-btrfs+bounces-7670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772C496521D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9352B236E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 21:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EA21BA286;
	Thu, 29 Aug 2024 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oa3I4Azg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D11B3B1D
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967472; cv=none; b=FK+5NLaHI8BB52K3ZMPhaJLbR60CGwk67AmbPOTFzw7+4n3x7Aov4waY2oLTcUKmNfuUwj3C0oYdt7irQUIDo3MzAv6E4IM0MbwEpYdgtp83qRXdvP4ZsGvB5Yc2262Qv3IHA68/wdmur2TWoBOLy1lkMgw/WQPWj1ySWfm7SWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967472; c=relaxed/simple;
	bh=Qaarvv8W4g1NJ/A4xhxQI6cqrE7p/bZ9nVmo2HZPMKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUFzLjuoOEi8jpyFRH5T5EHEGa3ad5LNS5stL9ELK0f9OlQfOBKFZRnIj8N26ireN/3zTYgP00EsiEjWhENilVBIqANiu73GLTZtstf292lrICNkdgUBB9pFaSvQYT7zSC2Ta9VRXhXE0cbwKpyMiLBHYe0vIwT4tBA0wWAWOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oa3I4Azg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724967465; x=1725572265; i=quwenruo.btrfs@gmx.com;
	bh=L7R8QUeoLpEAVKCL/W+udFYzMzB8TTKr3Ih9V0Xt4Pg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oa3I4AzgrDETXH1Ymq4hfS8+cziJwKZLa6xBVS/O5iOE/bk36Zz5V6p7IQDYUwmI
	 3l6Dmlfs1BgdYctdKbqkRas2OZvEQaA2nta+g3mvapgdNoIjdZTyR72OMcFq4ISMX
	 39iF4G1IUf4BYMsFzlMnYLnMWusxstGiQikX+4fLin0NU1ZIwv+bkyfgRDWrBiiDm
	 Snfe1bn99bYjzjFCR/8VS++4O2Te/mBJ+LIe/ywp/0Qu7xKvnKF0BOff228atmgve
	 2agvkL5mFHbWGjhIP0IKDcFpCI5vxXlDoxryP2zeb2ZfrdMqsG4BZ8eWP1BZi9wM1
	 5s6ePyM+PCHZ122xYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mplc7-1sIPES0HAD-00ph8j; Thu, 29
 Aug 2024 23:37:45 +0200
Message-ID: <a7aaf78c-4417-4f3e-b551-04b4898f1ba5@gmx.com>
Date: Fri, 30 Aug 2024 07:07:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: interrupt long running operations if the
 current process is freezing
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Rolf Wentland <R.Wentland@gmx.de>,
 Josef Bacik <josef@toxicpanda.com>
References: <bbcd9ebaeccb3a9e5a875a2ffc1afb498d6b75fe.1724889346.git.wqu@suse.com>
 <20240829165948.GM25962@twin.jikos.cz>
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
In-Reply-To: <20240829165948.GM25962@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ahph5yXmtcR/+MVePj58cXcCqrT3rXpKVjtCEpeX5wlNZ1M4Rbs
 Nc0sQkw/y7C+Ujmox8bw/luMP86BoT1/F2UHbHC/JwTqlGPI1dQ+lsleP3evw6kyR3iGrwc
 cVvPgFBkwsYaAIhLdwrzTggEBQRkwuAspyhYGEan77B80KlUtZ6gBpqA9Ul9nmuM0AtS+e4
 R2LsLkgGfD1mi5gogRV6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UaeCRp+C4KE=;M50Q7fzcilxgSoU7Q4+8v8vQbq4
 04ostVwbW4h9bmrUx/QRGGlju/wiO/H+A+LUv+LCEpHTdJFJOk4RlnW8N7Akh0SMijglgRCkX
 zUwjXi6kLuP4r9rr0dsG3yHmWi7KXDTvuoM7GBbTHGHaHgX6FRtJHIlb/ozPSbZMs0Weii3q0
 6GTTD5HdMfDCUUWAQBNVmeE9K1V4ighqngO0+V/73Qnui6CD5qgbxcoFrOmwdaeYfF15goEF8
 DQZllJGjCuQG8cchVmSzitSLxVqQLWBVqEzJra6GyrQuuc4WYvstcJMVpMiWaUCD1+01YLzH1
 FlPHjNudgjy97d2uYA3/FPqsKWczqtbbX3XAOtGqnTU4G7Wn8UPJgXvJWMkVDH04AXieW7tCT
 jgRhA72lfSoCcxyPXjyvcO7T6yVfNUam8UhoRjm8sY3X6Qld1DUQN4k1I1fiGNU57hAOYg1Oa
 3bOdgkzGc2DTxH3yqjuwzR0xHwGL7UcQ9JjgkvWqVmf++6V8/ZM+lRKNi1iflE4+Pncv1Mm6p
 eyJQKO1FEa3flM2oSpgxAT56rUG/dCld3KvqyFmA7tSxl9yBdU1t+Av+MxRWLX7O1C8WQ20AR
 5bTzzYB2WcrQV2UuE3ByLF6UZaWJwasOwytuGyVT8e8VdO73l7ASZlT11UGLWdP9paGBVXwxP
 D0aA2PiQ2GlH8DpmayLT0tcOC3lcMv6jxbk4AbHmMtYj5S1+B4XiGX/R0M1McFHgvNqGNqb43
 nOXX2cCxLVSBbxQ772mq4CgitaelgEWJzBOKmCcO58Q1lHy3iLCz5GVmOhhUMQb7E+EQLha6p
 eJV5gIXC68zfsKJp64dXldHg==



=E5=9C=A8 2024/8/30 02:29, David Sterba =E5=86=99=E9=81=93:
> On Thu, Aug 29, 2024 at 09:26:17AM +0930, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report that running fstrim will prevent the system from
>> hibernation, result the following dmesg:
>>   PM: suspend entry (deep)
>>   Filesystems sync: 0.060 seconds
>>   Freezing user space processes
>>   Freezing user space processes failed after 20.007 seconds (1 tasks re=
fusing to freeze, wq_busy=3D0):
>>   task:fstrim          state:D stack:0     pid:15564 tgid:15564 ppid:1 =
     flags:0x00004006
>>   Call Trace:
>>    <TASK>
>>    __schedule+0x381/0x1540
>>    schedule+0x24/0xb0
>>    schedule_timeout+0x1ea/0x2a0
>>    io_schedule_timeout+0x19/0x50
>>    wait_for_completion_io+0x78/0x140
>>    submit_bio_wait+0xaa/0xc0
>>    blkdev_issue_discard+0x65/0xb0
>>    btrfs_issue_discard+0xcf/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55=
ecf8e6bf82]
>>    btrfs_discard_extent+0x120/0x2a0 [btrfs 7ab35b9b86062a46f6ff578bb32d=
55ecf8e6bf82]
>>    do_trimming+0xd4/0x220 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf=
82]
>>    trim_bitmaps+0x418/0x520 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6=
bf82]
>>    btrfs_trim_block_group+0xcb/0x130 [btrfs 7ab35b9b86062a46f6ff578bb32=
d55ecf8e6bf82]
>>    btrfs_trim_fs+0x119/0x460 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e=
6bf82]
>>    btrfs_ioctl_fitrim+0xfb/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55e=
cf8e6bf82]
>>    btrfs_ioctl+0x11cc/0x29f0 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e=
6bf82]
>>    __x64_sys_ioctl+0x92/0xd0
>>    do_syscall_64+0x5b/0x80
>>    entry_SYSCALL_64_after_hwframe+0x7c/0xe6
>>   RIP: 0033:0x7f5f3b529f9b
>>   RSP: 002b:00007fff279ebc20 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
0
>>   RAX: ffffffffffffffda RBX: 00007fff279ebd60 RCX: 00007f5f3b529f9b
>>   RDX: 00007fff279ebc90 RSI: 00000000c0185879 RDI: 0000000000000003
>>   RBP: 000055748718b2d0 R08: 00005574871899e8 R09: 00007fff279eb010
>>   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
>>   R13: 000055748718ac40 R14: 000055748718b290 R15: 000055748718b290
>>    </TASK>
>>   OOM killer enabled.
>>   Restarting tasks ... done.
>>   random: crng reseeded on system resumption
>>   PM: suspend exit
>>   PM: suspend entry (s2idle)
>>   Filesystems sync: 0.047 seconds
>>
>> [CAUSE]
>> PM code is freezing all user space processes before entering
>> hibernation/suspension, but if a user space process is trapping into th=
e
>> kernel for a long running operation, it will not be frozen since it's
>> still inside kernel.
>>
>> Normally those long running operations check for fatal signals and exit
>> early, but freezing user space processes is not done by signals but a
>> different infrastructure.
>>
>> Unfortunately btrfs only checks fatal signals but not if the current
>> task is being frozen.
>>
>> [FIX]
>> Introduce a helper, btrfs_task_interrupted(), to check both fatal signa=
ls
>> and freezing status, and apply to all long running operations, with
>> dedicated error code:
>>
>> - reflink (-EINTR)
>> - fstrim (-ERESTARTSYS)
>> - relocation (-ECANCELD)
>> - llseek (-EINTR)
>> - defrag (-EAGAIN)
>> - fiemap (-EINTR)
>
> Is it correct to interrupt the operations? If there's a reflink in
> progress and system gets hibernated what's the reason to cancel it? It
> should be possible to just freeze the state and continue after thaw, no?

One process trapped inside kernel can not be frozen.

And it's really user-space programs' job to determine if they can resume
the work.

Thanks,
Qu

>
> Imagine a case when a long running file copy (reflink) is going on and
> the system gets frozen. This is wrong from user perspective.
>

