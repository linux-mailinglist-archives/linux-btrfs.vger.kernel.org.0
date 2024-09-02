Return-Path: <linux-btrfs+bounces-7728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B89682FD
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 11:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECDB1C2206A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7B51C2DBA;
	Mon,  2 Sep 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TLskVNh0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BC187355
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268857; cv=none; b=KLEXSEghC/fAxccUUipVY2SEaMsGjUL+TCuSRpyPttVpa551NUVOzF3mQZIFq1wXZjPWNtwrgOKq7k4OmRroMTkU7GF4Z+om+zuIDD12sMxUTe8cU0kkiQZxHuQChv2y/5ok3bz5rVr69M3gR7OT1LAaid3+KG/pq2dAoMmDN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268857; c=relaxed/simple;
	bh=biM1DvcOGfaZNoJcBIQ6vmXJA7h2DvrC0HIPMP2mgzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTk+jxj9bmEnfp323+MFWokF167fafIIJ7iJlbMyz9qDiWZZzxuWwFcNyDOr/VK1/pu4wJ/SFG84q3cRfTxIt3wJtv0qC39FNQK8TOxYS75PvNx2cgFqVXkC52VdovcO1ZU0AO6t+QzJx2uSZlCu4xJkC7VqUBK0uN5QtCd7dNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TLskVNh0; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725268852; x=1725873652; i=quwenruo.btrfs@gmx.com;
	bh=YFHLsQfRZMQDknx5w/07JO5r10u7DANu7ugLsjCP/7A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TLskVNh0owMUGQbKuTC+Fg5OdYd0NF8iYyAS4W7lMf807q0d59YyGrP13cOfjma+
	 yadxzT3jPRq73/9gsA0pMHzlS8KwAC71gAkOCqnReH+/m7ZFDZ7JS36tc6x7G0iIj
	 X0F1ZBZZuSpJefp39rbHeE7VzfcfbAzqKXNOIJSN2C6z4ioH2+Poik90fdOx3Mi7W
	 vUcDjEU6v3V4Vn1eg08ytejA8GeeoUlIbP8Jps8i5Syr1vYQhewpgJQgB5/QmRg8g
	 HM74iyd11+eJsJD4DJMxaDBdhuCXI2s+Mo/A/+Jq23I+tezGDnIR5Vy2UFTgPkH+s
	 DJrPa2GjnAOXWAz6gQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLiCo-1sTWM72eRc-00OMTn; Mon, 02
 Sep 2024 11:20:52 +0200
Message-ID: <f2074aac-b479-4fba-92df-bec086af7343@gmx.com>
Date: Mon, 2 Sep 2024 18:50:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: interrupt fstrim if the current process is
 freezing
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Rolf Wentland <R.Wentland@gmx.de>
References: <eeffae0b8beecb3406f43ff48e788fd9d88fb2e2.1724971143.git.wqu@suse.com>
 <20240830185113.GW25962@twin.jikos.cz>
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
In-Reply-To: <20240830185113.GW25962@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M2gUcZXlbMz+0z6gKpisO8gVXiF8049A+REoLBLRrx9NkTExhLT
 8N8RKBNvwef/liuZxZYVWmgA9DfQkITN9WznX33PzGSfKTnIBGR6wDdx/2J7oWDJBJutf0H
 imhwQPq6i4jMePC1Kr2fersyN0DtuFYERBWNeNbze5iSj4veoFLEi3L/CA43ZHT+2TInp8A
 3ZAU1GEvno92lon+DCoTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lGFbs2V2+Po=;NaktKhJQXuFKdhZQKe51IYWq+4N
 Jjczay7fiELDnDi7sYpK9yWZeuCD0QjOrOfQvgbhSp4RR0eE0QT7yngr8jBZfySzvcsCQrOmT
 MBP7Wsmn+vmNZu3e6NqEbQGd4jiX/vKb3fw4DCI0cJ24GYmilo4/RgsK+AUZQzZIiCox0aPw0
 e3EV7ss0NVya5urFnOCrGgvnHf+BiQu6dy/vps8JLqyNh+uxxmRNGgt9x7d4sHQV8TghHbZsW
 tNUSPtuSzuWGVlPnNqMx8yMTQLi8AVHzJtBhoUTJLjlGgid+6QFpAeuEmaLD4vGcIlE7C5EI3
 /aB8t+wnmcPIVlzD1y2bg0mhGR1nuv/pTCxRj232J7SbHeOLYsyM5eKI6CtAHxVHzv8Fi4i2n
 wKb/iGndNBmhiPz0qNhShfaFxV/JaM7z8GlCk+eRcC158NEf1pfIAWLWvvMvFDXQ0ruwBeBQ7
 jX6RLrpJy9gXBedx2fiKggExfZta4F0OXNDrLUsD6BhPm1JX0D5wrYGXjTiQ+gaN0lKSbzb7J
 n9zFGi4RnXVLNlpLlCaKAH8M0k8jaqvYidyzEdD5qf6JZcDqh7AzeXB5oU2ZXfz/ewDDr6F2u
 B9lpphaOhOhQ9Km+bsRrFwqrXDr9enNR6QEeHrv66I/9y05aWPTGH3IFatg+Qj+uI6BQH/5ih
 ZrPFMp8f3+k5gVGzrPR0Ujni6dB2hefm/RqYVlg7V+wVI9xxetP5vx+4qERQtmRqA2pD7VhFJ
 ObV/fQPqry/ChADjPfewGL1LBg8a+aViLhihCVxrgNBa+SnZSDRFTU0ZmmSwTapbT2cKWlhn7
 L60I/tfHcV+D/tXv3QOQVGSGsnbIK2t57zoCyHxt8aSec=



=E5=9C=A8 2024/8/31 04:21, David Sterba =E5=86=99=E9=81=93:
> On Fri, Aug 30, 2024 at 08:09:11AM +0930, Qu Wenruo wrote:
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
>> task is being frozen for fstrim.
>>
>> [FIX]
>> For now just do the extra freezing() check at a per-block-group basis.
>>
>> Reported-by: Rolf Wentland <R.Wentland@gmx.de>
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1229737
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> As a quick fix it's ok, I hope there's some way to support freezing of
> the ioctls, try_to_freeze() or schedule() at the right time could work.
>
> Reviewed-by: David Sterba <dsterba@suse.com>
>

Please drop this one.

The change itself is not enough, furthermore Luca Stefani sent a better
version, with extra handling inside the free extents discarding code,
which looks more like the root cause of the problem (as free extent
discarding has no size limit)

Thanks,
Qu

