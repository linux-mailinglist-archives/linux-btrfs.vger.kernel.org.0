Return-Path: <linux-btrfs+bounces-5383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616A28D6EBA
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jun 2024 09:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8517A1C213A2
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jun 2024 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24ED18EB1;
	Sat,  1 Jun 2024 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C7G+XxPa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97E18026
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Jun 2024 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717228378; cv=none; b=Ls4J2kONWKLymGxzFDFPU9LJH4x/eCd2a+EP8p3imXHyLl4JCmIGOfWn8tVSUYadkDuVlempU3MI1d2wUjYwdgqR+E58eRk4ObsdHpVkUq0Ckdoij6RwySv0hDyzIUVf9YbJvk+vbPEp+3TFR5Idl/thF0YE1jPWYu3xBFw9SQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717228378; c=relaxed/simple;
	bh=0FtP1hlqH6jkFDms9CJWnBSUxmIxIXlGlnyvBah3anQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ecXRP5jwUqvfJ4iF2e7JlXsv9ND7EJ0+0awSLpGZ1t25LV+i/jfp09HFwgckOqxCIcbNInu3YdXF08u/YUrl5v0OENCSrMsDEmOzVLOvanWrd6ycaHidn521dWKxKY0MdHR0OlR1YlWH5vQwVk+KL9l6f7ey4PNy8XPa5JRPQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C7G+XxPa; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717228370; x=1717833170; i=quwenruo.btrfs@gmx.com;
	bh=AMg/tHIzPloSxBWIeYPwzBjVWVFb0ZTrWZ/JJO1aNQk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C7G+XxPaX/yj4e3z3g1q+IF/0RMRw0kysKrOAHNMFONKcLpDzoP3Sf9TBWHouwMg
	 qDiAIz53qegcyw2jx73ZiJIBef0EdvegWUG8MybWxA8VvfXQlkoKg33oe8vMAi5mO
	 33/utvLc+h1hC9K0eR2dcUPLOO40lE2HL+MJkfKsPDAc//uQK1V6/iRy1rv+IIT2o
	 2hMjieHF+gSHXjzlFIyjeEB8qtC4SdSebXFHUclSl5T/lFwOv/Px8uf84wkk7P0R9
	 p7tBh8RDzL0Oxfqp78Qvy57YTyG4ydh44zxS9qDYvBs/BnZgfRbvRPe9E3AR5fKcS
	 CGb6ljrDkIqp/tOxDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DNt-1sCV8J0RuH-0003Vr; Sat, 01
 Jun 2024 09:52:50 +0200
Message-ID: <a9d16fd4-2fec-40c7-94cc-c53aa208c9b9@gmx.com>
Date: Sat, 1 Jun 2024 17:22:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: raid5 silent data loss in 6.2 and later, after "7a3150723061
 btrfs: raid56: do data csum verification during RMW cycle"
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, linux-btrfs@vger.kernel.org
References: <ZlqUe+U9hJ87jJiq@hungrycats.org>
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
In-Reply-To: <ZlqUe+U9hJ87jJiq@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bw+HnluWmN0v6GkbtaI4FdnMsqhuVO38peRP+yIkgy7Kyp5BBcH
 w/qioTfs0tzKvHXW+6a0XA/4ZRGhfr4pU58wyn5QAgqXfsKRpp6dAmt7ZjSl67xyeYuyqaN
 +mTozkKU5bcNH8PL+DnHXzLt/o5oI+Re+KnPofsjezTCyKuDbFbVKigkzAZkhoMCwFJhhYh
 ue0Q5b1D3TCleAkQijmIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RVb8WmKuR24=;WTto7IqLUWoIvYvIQIakrigIr0z
 JzSfBQrmSIdGrARpIv0EOLwp8Uw9be3QuBRY0QYIlteKjpEreXzQ2fNng0LrZYh2PamgBtWQb
 pPJy6wXQ3WzNTVlB3VPyBRz9PTptWVXjJWBcT7XWd2RAMtyBjQXU+BnJcXYDd5g1jP4OfjV2F
 oMUzQKpLwLml86vqEacN20PYibsMFxgy1RU1CvgoEi3w8Uoxv+jVu+20twMoMzeNXVLaZeCoW
 GTC/Y9d/y8JUVryCSZynflOC28CcSNsFUao8npm1KXfXh3eoBefk94o9kXIEPJHd5oLQe9xgU
 Df4jj4Cg90hqS1xg3YKfbCCw/RNDpA9a19xXzh/lp3py4ndGjoZqkKbJxYvn+U+50f7PcQMuF
 gZvrMBurQIkTLzSJ65EloT/OPwHSMRVewDJJ8hl2jmfepAlZPkfrYi//IwoscmDeepQSbvCBn
 Y8OGftOKS2IABYwuJJE7LbDwdHqoGaLdVnHy21F0aYkrIcUwL253+VHp10YXuVJW7tg1vRO7c
 1drYR79iG24R2tJ/UmXJpliFeb6v7c7gbI5ZxrD7SpGhui9MdLmpsGrJfegy4M3ZL+ClnisV6
 WZmAcTmue0FevZKkTJUOcwnB8YQAPywXdhDJA5ot4UjnX+jtK0LDUnDZYoVMX0rJ4ldp6ABF0
 OV8+1ljMwPu95xMkcE1ex7mUulU5bZmrf988rx4840Yw6Vh9B5g0QUq7+Mf0+djxHh8GJBfMK
 f+2zACget6uzku8DxVbgoFzbQf593VgvKLoIZLaTc/FdAubVBhPGJcxnSlCxb1ZGu3Q1oCEuN
 47YnbusdUCaBbh/uujDA2mHBt5MBMPeW2vJMBO9Pi3byg=



=E5=9C=A8 2024/6/1 12:54, Zygo Blaxell =E5=86=99=E9=81=93:
> There is a new silent data loss bug in kernel 6.2 and later.
> The requirements for the bug are:
>
> 	1.  6.2 or later kernel
> 	2.  raid5 data in the filesystem
> 	3.  one device severely corrupted
> 	4.  some free space fragmentation to trigger a lot of rmw cycles

I'm still not convinced this can be the condition to trigger the bug.

As RAID56 now does csum verification before RMW, even if some range is
fully corrupted, as long as the recovered data matches csum, it would
use the recovered data instead.

And if any vertical stripe is not good, the whole RMW cycle would error ou=
t.

[...]
> --------
>
> In the commit, I notice that when reading the rmw stripe, any blocks wit=
h
> csum errors are flagged in rbio->error_bitmap, but nothing ever clears
> those error bits once they are set.

Nope, rmw_rbio() would call bitmap_clear() on the error_bitmap before
doing any RMW.

The same for finish_parity_scrub(), scrub_rbio().

Yes, this means we can have the cache rbio with error bitmap, but it
doesn't make any difference, as rmw_rbio() is always the entrance for a
RMW cycle.

Maybe I can enhance that by clearing the error bitmap after everything
is done, but I prefer to get a proper cause analyse before doing any
random fix.

[...]
>
> My third experiment breaks the error recovery code, but it does prevent
> the sync failures and missing extent holes, so it shows that the error
> recovery code itself is not what is causing the dropped writes--it's
> the bits left set in error_bitmap after recovery is done.

Yep, that's expected.

So I'm more interested in a proper (better minimal) reproducer other
than any fix attempt (since there is no patch sent, it already shows the
attempt failed).

>
>
> Test Case
> ---------
>
> My test case uses three loops running in parallel on a 500 GiB test file=
system:
>
> 		    Data      Metadata System
> 	Id Path     RAID5     RAID1    RAID1    Unallocated Total     Slack
> 	-- -------- --------- -------- -------- ----------- --------- --------
> 	 1 /dev/vdb  71.00GiB  1.00GiB  8.00MiB   647.99GiB 720.00GiB 19.59GiB
> 	 2 /dev/vdc  71.00GiB  1.00GiB  8.00MiB   647.99GiB 720.00GiB  3.71GiB
> 	 3 /dev/vdd  71.00GiB  2.00GiB        -   647.00GiB 720.00GiB  3.71GiB
> 	 4 /dev/vde  71.00GiB  2.00GiB        -   647.00GiB 720.00GiB 11.00GiB
> 	 5 /dev/vdf  71.00GiB  2.00GiB        -   647.00GiB 720.00GiB 11.00GiB
> 	-- -------- --------- -------- -------- ----------- --------- --------
> 	   Total    284.00GiB  4.00GiB  8.00MiB     3.16TiB   3.52TiB 49.02GiB
> 	   Used     262.97GiB  2.61GiB 64.00KiB
>
> The data is a random collection of small files, half of which have been =
deleted
> to make lots of small free space holes for rmw.
>
> Loop 1 alternates between corrupting device 3 and repairing it with scru=
b:

The reproducer is not good enough, in fact it's pretty bad...

Using anything not normalized is never a good way to reproduce, but I
guess it's already the best scenario you have.

Can you try to do it with newly created fs instead?
>
> 	while true; do
> 		# Any big file will do, usually faster than /dev/random
> 		# Skipping the first 1M leaves the superblock intact
> 		while cat vmlinux; do :; done | dd of=3D/dev/vdd bs=3D1024k seek=3D1
> 		# This should fix all the corruption as long as there are no
> 		# reads or writes anywhere on the filesystem
> 		btrfs scrub start -Bd /dev/vdd
> 	done

[IMPROVE THE TEST]
If you want to cause interleaved free space, just create a ton of 4K
files, and delete them interleavely.

And instead of vmlinux or whatever file, you can always go with
randomly/pattern filled file, and saves its md5sum to do verification.

[MY CURRENT GUESS]
My current guess is some race with dd corruption and RMW.
AFAIK the last time I am working on RAID56, I always do a offline
corruption (aka, with fs unmounted) and it always works like a charm.

So the running corruption may be a point of concern.


Another thing is, if a full stripe is determined to have unrepairable
data, no RMW can be done on that full stripe forever (unless one
manually fixed the problem).

So if by somehow you corrupted the full stripe by just corrupting one
device (maybe some existing csum mismatch etc?), then the full stripe
would never be written back, thus causing the data not to be written back.

Finally for the lack of any dmesg, it's indeed a problem, that there is
*NO* error message at all if we failed to recover a full stripe.
Just check recover_sectors() call and its callers.

And I believe that may contribute to the confusion, that btrfs consider
the fs is fine, meanwhile it catches tons of error and abort all writes
to that full stripes.



I appreciate the effort you put into this case, but I really hope to get
a more reproducible procedure, or it's really hard to say what is going
wrong.

If needed I can craft some debug patches for you to test, but I believe
you won't really want to run testing kernels on your large RAID5 array
anyway.

So a more normalized test would help us both.

Thanks,
Qu

>
> Loop 2 runs `sync -f` to detect sync errors and drops caches:
>
> 	while true; do
> 		# Sometimes throws EIO
> 		sync -f /testfs
> 		sysctl vm.drop_caches=3D3
> 		sleep 9
> 	done
>
> Loop 3 does some random git activity on a clone of the 'btrfs-progs'
> repo to detect lost writes at the application level:
>
> 	while true; do
> 		cd /testfs/btrfs-progs
> 		# Sometimes fails complaining about various files being corrupted
> 		find * -type f -print | unsort -r | while read -r x; do
> 			date >> "$x"
> 			git commit -am"Modifying $x"
> 		done
> 		git repack -a
> 	done
>
> The errors occur on the sync -f and various git commands, e.g.:
>
> 	sync: error syncing '/media/testfs/': Input/output error
> 	vm.drop_caches =3D 3
>
> 	error: object file .git/objects/39/c876ad9b9af9f5410246d9a3d6bbc331677e=
e5 is empty
> 	fatal: loose object 39c876ad9b9af9f5410246d9a3d6bbc331677ee5 (stored in=
 .git/objects/39/c876ad9b9af9f5410246d9a3d6bbc331677ee5) is corrupt
>

