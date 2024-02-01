Return-Path: <linux-btrfs+bounces-2046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3D1846312
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 23:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39FBB24D93
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 22:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1F3FB14;
	Thu,  1 Feb 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cdoUdWpe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753313F8D9
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824810; cv=none; b=dS5JHQCZ8NTeZZVJnL8bsCNZ6xR1kf8QDTI7h5RbkmT4toFkrxEOOGPhGA9uNsKl1HiNRxYckciJ6C0BlKBNSjrBSmp0/MNsE0UNRe/RxK3QpA9xTrC6sXJXJ8O1X1BHvL+xdw4YMnev12a+4qTOwVb1vbDMauxnB9iFsGFbWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824810; c=relaxed/simple;
	bh=L98AHwNwn+VvMPbK6XBttb6ps/EvSOHfqX4G+6/iZ5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MC0ikKKCvxz5GuTvJ2NGRcvRPkPgrUX4PyML0RUKf6OKBZ3+fEGAT/G4QcrTP5L8Cm+5Wv+itAlLaRhua4rzCk/bKm44hG3MuIhu1268csz9rTC1TMWetAzFPAgnbcIRvgCDhdQ0RrvEOHhvgRmbccAGXtJQEY80f5r+qw+zPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cdoUdWpe; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706824801; x=1707429601; i=quwenruo.btrfs@gmx.com;
	bh=L98AHwNwn+VvMPbK6XBttb6ps/EvSOHfqX4G+6/iZ5g=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=cdoUdWpenkwar9FbMNvpBUN0tRgZqF1464+z3mkFn84zyIESLMFDYgE3ODupNT82
	 1OJnhJR+qnWywYFRdtOAGukNAfa+7KsV24SIXUibWomL01q/IV7mWbU8deVHMH7OR
	 hRPjfBE2puznP8udWaR/2yLVC5V0gGjvjsqv6a0gBSqdgeagTv8n9eV0y4x3jcUvm
	 eMmm5LQOx+IXGmHW5ev2j+YLLVtaf/0Wx6f1kOKJHNhYNJa566zd77bcbGUdsPOgU
	 VLZwePyRbTzhc7jNPbvwDPsMBRxRw9ZlmhtyDnByXmBhI9ldon/52ekIlo+Nhnis8
	 S6K7cCngJpAI9I8aKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKUp-1rkrVP2rMt-00Lqur; Thu, 01
 Feb 2024 23:00:01 +0100
Message-ID: <34047c7b-365b-41ee-b349-b4d645acb2d0@gmx.com>
Date: Fri, 2 Feb 2024 08:29:57 +1030
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
X-Provags-ID: V03:K1:2/8upQfvOEX1HIu3QcoDATYIFdiku+aWUQn+H44Eho8G6Uk138g
 1wJLqxVqlumEddHheYM2zLMmYRr17iXmhHutE3Py02SGn1s6KFj+IZdYPmoP9wthWvd2dj/
 3sLNFqeGsgs47OfkOCbp/4q9pmsMqE64Ykx3mpNaQG+LgLRIvhAvWvTKS1sOauZNRELmexX
 GDbAKgRk6qbG9j8YsXKNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oxJZy8cH5Do=;O3jGn85eWt0K5Ip4P6w7U6RH3Nc
 pLN5hnn9ug9GWoKyIpVVoreBiDEsL0BZF57eZa5+YgNCiIrCJke+vU1U8m35u4e3c+lDfVsbk
 LnDHXV7CrGfD9BL3itDimt8vFoh8GX17UMT2iTCX/8dcKprYsp1J6niS2JaxyU6Vhjdso7gjX
 lB5PXqH+CS/wwi/x0MEdIoOfFIfB2Qc8y5QgmwCTD1yJ0AdwqZFTkrLMxBz2Zl2ywM6idAGWe
 9b5OSJqoLtu0vtnGgrASK3WSXzuZmphzFjAEs6T1UKs5ptb9a6wvapTNBfcfGk8t3oHzPMd/a
 9RyCGyVLzF9SlwpvSrmfGBfJcYAldZvv7ICggV9wbBrsgL6LdFsWuSAmQHuZBTHEwxowoVTkk
 KrPzGWODlXKm/QNuVAN52Q+ZpyjbfO2kYKZ90udd8tQrn1uTaAUbfvWJHfG/iTVoLcLbThK4D
 qPaJbvKsqeAj0OWAEGaNkgEU1nQmWomupJAWu5wVhPyViPuo9wwerhC4RbuFpc/QS+zIH2ha2
 /o/XFQ8DiXfstgRMUZsduD+zb28cb3GFzBpSEHWc+OOrbPY7wL5irrkTz0yxAQyXT/PC4OjuS
 xu6vnXuDi44EgISAW3ix92wCsyJqrEzFd9n/xOf3GIKwksekdJc0TNvshwUKjLH8t3RE/PRH7
 OubhgxPIiyPSry8nxOrR77V0MQ5vL+cfFMkHVxJQZAymzdPWAJQB8lhiTXOUH+MavKyBBnYUA
 FRc39VDsbhWqPWF81hV29uOHSc/Y/hpXgzMPJF3DDj75f8yvtbfaGFoswjs7kno/6WBKww3pn
 7l7iF4jgFU60F6X9xM3kD8kJpGK4dmNAN4WwIelm8nrpg=



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

I did a full strace with extra debug output, the problem is not the
nested fds lifespan, but as I expected, a stray writeable fd.

In fact the problem is we have a pre-mature close on the first device,
if and only if using open_ctree_fs_info():

open_ctree_fs_info():
|- fp =3D open(oca->filename, oflags);
|- info =3D __open_ctree_fd();
|- close(fp);

That close() is the problem.
At that time, the fs is still just a temporary fs, without a valid btrfs
superblock.
Kicking off the udev scan at this timing is the worst.

We can keep that fd into oca, and close it after close_ctree().

And the problem should be gone, even we still keep the nested fd lifespan.

So although your patch is working, the explanation is no on the point.

And my flock() would cover the case, as it would prevent the udev scan
to be started.

I'll prepare a fix based on the findings.

Thanks,
Qu
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

