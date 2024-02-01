Return-Path: <linux-btrfs+bounces-1989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1E9845319
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 09:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0F61C21940
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 08:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC015AAAF;
	Thu,  1 Feb 2024 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JTFLH01o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE415AADA
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777368; cv=none; b=owYEmJ47yAMT3D8mNkR6b7yZeK7oZK1kLJL3D4IHtZ+KPZousSSOW7QqtqS87sYZWl8RZ4BM4LF8GMj5MOs78vKIyuVnKxHsYKa5jT3UHccEvYe6EmHtEonu+TFwine/EjoxNX+7+mkYGx449p/lm0NnQt3oZvk6/RRHQsWo9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777368; c=relaxed/simple;
	bh=QnBaZgzQHPLXwQLZsTthXbN+ILzeNVBVd9A5RAd4KfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9xWMFX4doGsnm3NKKwiRdSw0jYPDXMUQwTSxJ5iUZC0onEj5lPVy6Hr+zWLevShXcEFD1CxoVyn51YqXEeVeW8c79w+FcgP6yGWKat/Z/0tSpUaWzNXupuG8IasHR43uh4fouai/2861oPqaXLYEv5fvU0f8UYO+ys9H3Ua4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JTFLH01o; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706777359; x=1707382159; i=quwenruo.btrfs@gmx.com;
	bh=QnBaZgzQHPLXwQLZsTthXbN+ILzeNVBVd9A5RAd4KfU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=JTFLH01oBgN5cdYnw6bozD6LZwkTuncKvzLW33+Do+fH9vTsypiw5ixt2fee1ELe
	 6j8LHfIhsDt5nD3rOUXXq7G2k2RZdMOsA86BBn/xPnhbcVOCZmPh7u9awYHOz4HMu
	 TKw/6RoOwSTM4cSgGC4owPLuI0Hc8efXd2OCIUV0gW+WTMqNjgMiidaX8Pc9fbAc2
	 MrDa8dVK7lhtJD+o/5L7dgAyLeRMtGaySL+4tTSaHZtaxKA9ArANL2mR1mCojS+nB
	 vJwq9duWqNxNMfUtxKhG2fYe43WjiOfshpF24hP+7pavwsvk4FYCjTxT4A+sHr4+H
	 LJVmQ1O7/RKabFxuTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVNB1-1reVKb1quF-00SLRX; Thu, 01
 Feb 2024 09:49:18 +0100
Message-ID: <04a9a9cf-0c77-4f1e-b9f3-12cceeb7ef57@gmx.com>
Date: Thu, 1 Feb 2024 19:19:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in
 mkfs.btrfs
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
References: <06b40e351b544a314178909772281994bb9de259.1706714983.git.anand.jain@oracle.com>
 <20240131204800.GB3203388@perftesting>
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
In-Reply-To: <20240131204800.GB3203388@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7zi5SWis/1LVbTUiw+9kebo2ADSDS1tmnR+7PQWH4E8B4yOdvqo
 nt6Bm+Uep4K0q3i4Wtv20QKmEIM98K/W81ylKXzFxD/nyZJErXnDT31v3BJBEQbtMNyAuyZ
 7pre71SSE214xSzY4sy5z1gLqBK58IHKhWcfdFWJtu9uIdQDZ2CANw7VWJkPlrYFLZiZ8Ne
 tREZV0ZfZeXCC1AktxvnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hcwgqgBgRUE=;cpx5aEje0m3Xtv/ynoBhMZTcjyB
 h6igr6GIl09QiFEn/1Y96uE6CY9yGcIsJHeAvDpMI5Js+yzbQJMFcinLO+0+aBlQYlIX64I5q
 Jqw96o+Lv/CPKpQYk2vhWCZwNjpL0LbbhkIkR1ds4GbziATeyG5GXP+6vlDwZHvbw5STqcZ53
 J5ZSD40AoobZslJbCwCqN+zOZbCP/If1doqdJgUsWzjlYS3bkzmBbpQBCgHqAGg6IPss3IqAe
 yn7EGT4Q6NkJSYLNhRI0T1s/OYusPVef1+Wp7R+eo56r9EuICm8/DpFliiOSgrWdWxAPb1nnk
 YPcdpeyml6dqzvCAFdUcpyJGDtsdhhebcYDgXiwDRgj+jGm71BFbwALFh5N1Qfr89f1CMIlY7
 CQN43s1zYqx9B6Wedp2JLfxU7/5Yutn2E97g/IgKchcaCTPjyGP80vCArr8syCz1Tijtva/gM
 iECGu3F4YISqnp0Yd/RzlH67sntXSRnY3x1tATn58RkKD2ym5CScgJH1Ss2hprdslsSrGrekH
 CHVqdCsv5/GnxOTBZ9dnWg4ZQcWrTqTUEzTEE/J9Jqp64FA/sjGSJV1Oq9T2FqiJHcghJJt6Y
 qmrhMnf0hmpWazQ7l5dzksHReHmY6LaZjE8A+gMxB9beimq07w8CR1vUrCqR1nw9fBZo3xMY2
 8JSHUZQG6hzrWQIqDTVV/dOTKX/+RyFYxg+oBXxRWG0vOwOxIPZemnkNpHkpDmyT54qTP6Zev
 KuVH0oI3jl5Jk+GyAwAYy0HpFccAyyNu8LNloqq39ItLA7e2r3bMc6jcImMLQr6HbN12ZCTbJ
 dbokBoq0UDpeNCGYEPZcPOsWvXqrvlPIEWXaP0DkaWhls=



On 2024/2/1 07:18, Josef Bacik wrote:
> On Wed, Jan 31, 2024 at 11:49:28PM +0800, Anand Jain wrote:
>> I've reproduced the missing udev events issue without device partitions
>> using the test case as below. The test waits for the creation of 'by-uu=
id'
>> and, waiting indefinitely means successful reproduction. as below:
>>
>> --------------------------------------------------
>> #!/bin/bash
>> usage()
>> {
>> 	echo
>> 	echo "Usage: ./t1 sdb btrfs"
>> 	exit 1
>> }
>>
>> : ${1?"arg1 <dev> is missing"} || usage
>> dev=3D$1
>>
>> : ${2?"arg2 <fstype> is missing"} || usage
>> fstype=3D$2
>>
>> systemd=3D$(rpm -q --queryformat=3D'%{NAME}-%{VERSION}-%{RELEASE}' syst=
emd)
>>
>> run_testcase()
>> {
>> 	local cnt=3D$1
>> 	local ret=3D0
>> 	local sleepcnt=3D0
>>
>> 	local newuuid=3D""
>> 	local logpid=3D""
>> 	local log=3D""
>> 	local logfile=3D"./udev_log_${systemd}_${fstype}.out"
>>
>> 	>$logfile
>>
>> 	wipefs -a /dev/${dev}* &>/dev/null
>> 	sync
>> 	udevadm settle /dev/$dev
>>
>> 	udevadm monitor -k -u -p > $logfile &
>> 	logpid=3D$!
>> 	>strace.out
>> 	run "strace -f -ttT -o strace.out mkfs.$fstype -q -f /dev/$dev"
>>
>> 	newuuid=3D$(blkid -p /dev/$dev | awk '{print $2}' | sed -e 's/UUID=3D/=
/' -e 's/\"//g')
>>
>> 	kill $logpid
>> 	sync $logfile
>>
>> 	ret=3D-1
>> 	while [ $ret !=3D 0 ]
>> 	do
>> 		run -s -q "ls -lt /dev/disk/by-uuid | grep $newuuid"
>> 		ret=3D$?
>> 		((sleepcnt++))
>> 		sleep 1
>> 	done
>>
>> 	#for systemd-239-78.0.3.el8
>> 	log=3D$(cat $logfile|grep ID_FS_TYPE_NEW)
>> 	#for systemd-252-18.0.1.el9.x86_64
>> 	#log=3D$(grep --text "ID_FS_UUID=3D${newuuid}" $logfile)
>>
>> 	echo $cnt sleepcnt=3D$sleepcnt newuuid=3D$newuuid ret=3D$ret log=3D$lo=
g
>> }
>>
>> echo Test case: t1: version 3.
>> echo
>>
>> run -o cat /etc/system-release
>> run -o uname -a
>> run -o rpm -q systemd
>> if [ $fstype =3D=3D "btrfs" ]; then
>> 	run -o mkfs.btrfs --version
>> elif [ $fstype =3D=3D "xfs" ]; then
>> 	run -o mkfs.xfs -V
>> else
>> 	echo unknown fstype $fstype
>> fi
>> echo
>>
>> for ((cnt =3D 0; cnt < 13; cnt++)); do
>> 	run_testcase $cnt
>> done
>> -----------------------------------------------------------------
>>
>>
>> It appears that the problem is due to the convoluted nested device open
>> and device close in mkfs.btrfs as shown below:
>>
>> -------------
>>   prepare_ctx opens all devices <-- fd1
>>     zero the super-block
>>     writes temp-sb to the first device.
>>
>>   open_ctree opens the first device again <-- fd2
>>
>>   prepare_ctx writes temp-sb to all the remaining devs <-- fd1
>>
>>   fs_info->finalize_on_close =3D 1;
>>   close_ctree_fs_info()<-- writes valid <--- fd2
>>
>>   prepare_ctx is closed <--- fd1.
>> -------------

The problem is, even if we change the sequence, it doesn't make much
difference.

There are several things involved, and most of them are out of our control=
:

- The udev scan is triggered on writable fd close().
- The udev scan is always executed on the parent block device
   Not the partition device.
- The udev scan the whole disk, not just the partition

With those involved, changing the nested behavior would not change anythin=
g.

The write in another partition of the same parent block device can still
triggered a scan meanwhile we're making fs on our partition.

If you really want to change the behavior, you need to reuse all device
fd, and even with the reuse, you still can not solve the problem as mkfs
on another partition can still lead to the race.

Thus the proper way to do, is just to follow the udev's doc, to use
flock() on the parent block device.

Thanks,
Qu
>>
>> This cleanup patch reuses the main file descriptor (fd1) in open_ctree(=
),
>> and with this change both the test cases (with partition and without
>> partition) now runs fine.
>>
>> I've done an initial tests only, not validated with the multi-device mk=
fs.
>> More cleanup is possible but pending feedback;  marking this patch as a=
n RFC.
>
> I'd like to see the cleaned up version of this patch, but I have a few c=
omments.
>
> 1) I think re-using the fd is reasonable, tho could this just be reworke=
d to
>     create the temp-sb and write this to all the devs, close the file
>     descriptors, and then call open_ctree?
>
> 2) I hate adding another thing into a core file that we'll have to figur=
e out
>     how to undo later as we sync more code from the kernel into btrfs-pr=
ogs, I'm
>     not sure if there's a way around this, but thinking harder about add=
ing
>     something to disk-io.c that is for userspace only would be good.
>
> Thanks,
>
> Josef
>

