Return-Path: <linux-btrfs+bounces-7657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B94B963671
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 01:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700C81C20E8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C681AC439;
	Wed, 28 Aug 2024 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VKhAdUjY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12D18990E
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889057; cv=none; b=JHgyUufoRhbikx5CyjvxLBbM8J+s6Kpj7zh1ozkcx0qFMb6qOC11DtbM/iPL2DKpf7jtSjpwD5C4tFDipS8A/e0veqoHZgY+3UXVYg2/L5UOqhjiZwceHwRaAN51755CB8SzxLXsA6wWe2qS3ZTbd1tYNbw31KyDFGINjoEWUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889057; c=relaxed/simple;
	bh=Xwb+R2HbqL0CvSFZlGzF2AmCy+3h2kJowMd/Do+2zsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MclOIrwkgPWAqPAAOnt3Tc9+fS0yIa3o3IebXyktxLEVsgyClUjTVpJStD++lxFNBFdmqe3a890+vTMu5HsSp2s3+81bddDMlLpLn6lD9y1/mKgOtIlhDNbY0eIStHBdb13Rx2MTTdqfnwJaiJdg6dNuCsRjRZydHnVt8rH6mG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VKhAdUjY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724889051; x=1725493851; i=quwenruo.btrfs@gmx.com;
	bh=W1E1YK0NLRzTtp+S5ylJF0ncPGKh5JM3W32HJ397unc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VKhAdUjYO/93zmEf/K5kBjOBX7jA2dJFmFyLL0gAajGKy0wCPDfaxdDwXKi5q0Ai
	 Fil0k07TVbQA/m6xc7jWjeGD2CIJ/kY0sUAFyGEb3AU3DidB9P9+BWNkxlVQbKPtz
	 VH7k59BeoP6IlqiTVrZQRwu/F7pylkBoYHnfKMT/QNnjayCjQ1IgZdqVBwZvZYvDU
	 HCoiTx7dW3UbIhGCE0apFaYrn7MFWE4pvaABdGTUmT0/4T74hXGHL8pID3Gt9cXyR
	 Tkx6Q/Q1d27vOHcjbl3UDc2GjT5Q+1IL/QLOe9JJxtl6PiHKDfHFu4M17bNtUKib7
	 8kEDNiHTKUzMcMW6aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpSb-1sC2M73oj3-00ebLA; Thu, 29
 Aug 2024 01:50:51 +0200
Message-ID: <b3ff8ec2-392c-4c36-9625-f79be715cfa4@gmx.com>
Date: Thu, 29 Aug 2024 09:20:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: interrupt long running operations if the current
 process is freezing
To: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Rolf Wentland <R.Wentland@gmx.de>
References: <7c5345c3acb54ca6e02fdb2398d9af14a0bebd35.1724885694.git.wqu@suse.com>
 <20240828232629.GA2980463@perftesting>
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
In-Reply-To: <20240828232629.GA2980463@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Az2pan/umYPBguNN6n9pzDgJPWOKLGcKrOsy0ofThaY/1yh/4sH
 sPpwnSmB4HZ8Mho0Q1TaH9LvAfCPN8uRmTOiRlWEgYaUk/CAHQ6h3pcAQkEGjk5A6IKKUc/
 U4X7TMXEo/zQ6D7MBZaGWFoSAr8KYp1FefIJ7CO8mpzfgpxncyOywZAq1xxLENRW29JcEie
 HtoBAwxDjfXFKhHSuXwTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o8ThkKSg1V4=;BGxgrse4wu97HEic5hmucdlStEY
 ADzlysnKygpu2Ae1ZbfUOBhn9azknLb2XDWSLcuJ2et1rEue/ywx5IxH/uc6Q17L9a7BVzAKZ
 eL77cJiN+xU+oVggliUJglYdiPqXXEiyc3a293FVWb9mrB5QjoL0zS/Q/p4P3H9xv/pZCj76p
 5jzd4Q8sE7bqQDmSfJw00ofvtAqMOEuZa8pKk0MZsJ4i5SKRF6D/WIQTwTBkSQGevTWVoJm7b
 kcHq9OliXoQkD1My4vPD4XbIyZKL9p2IR8ASBCEacpMjBvo3+nUlJouIRhp05W+6binVJb5QA
 t8b65xyxy3FmjOcXyyXG+GmDlmFXDalFOaGehXoLRq8F8ufCHvPVzKKojwlIlQDvC7AlY0WBV
 7MFrYsrZU7E9X8YqRZPMKNsV1xos2tMI5knIjAtAv9Dxv0RTYv4LsUgXJFtbXLDEq8xHP7nfZ
 M4yNxkmIjBUApNb0IKnPoJi4dmCNv8rHLNbGrMiHJ2b1mzfroridR+X0TUbTWzub0XjKQleVA
 fTPuS/rPWMyZZSoSks8PkKZkCoDhZZoaEbWo8CPyvs9R6KtKexOaY8Jphq/ZUwhZkLihGb/bx
 NgB11vAxERQfJaIKLe8fwG3B506bhFg81Z0nGAgfWw0zJmt5mdBczoI0BS/ywEB9zD0iL7k2N
 sEAh3Ls9idJO39LyphrTWF2dmhLfh5nH7cjyKeGfjkW/GLxil+XdBc9L+7RElCogYtMih8Hf+
 m1GaM/NMrSC8MF/UyFC5FWw1Drg2jz7VobzoOFxMoKmFvVOw8OL70K8gZECbDh4kuWDgL8yRW
 1/47DgKa3W6yAZxHxx9IadnA==



=E5=9C=A8 2024/8/29 08:56, Josef Bacik =E5=86=99=E9=81=93:
> On Thu, Aug 29, 2024 at 08:25:00AM +0930, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report that running fstrim will prevent the system from
>> hibernation, result the following dmesg:
>>
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
>> Introduce a helper, btrfs_interrupted(), to check both fatal signals an=
d
>> freezing status, and apply to all long running operations, with
>> dedicated error code:
>>
>> - reflink (-EINTR)
>> - fstrim (-ERESTARTSYS)
>> - relocation (-ECANCELD)
>> - llseek (-EINTR)
>> - defrag (-EAGAIN)
>> - fiemap (-EINTR)
>>
>> Reported-by: Rolf Wentland <R.Wentland@gmx.de>
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1229737
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> I don't love the name, can we call it something like
>
> btrfs_task_interrupted()
>
> or something?  I don't want people to get confused about what it's doing=
.  Once
> you rename it you can put
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Sure, would go btrfs_task_interrupted() instead.

Thanks for the review,
Qu

>
> on it, thanks,
>
> Josef
>

