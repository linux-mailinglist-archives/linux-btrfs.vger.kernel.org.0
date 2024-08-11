Return-Path: <linux-btrfs+bounces-7104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09AA94E3CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 01:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748491F2233E
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 23:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C720161326;
	Sun, 11 Aug 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="InFDr0gI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00852AF1A
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723418085; cv=none; b=s6HaB835h4XlkqtH+IfG+hsMJAhHjwqHoyCUUSMG4cmLTqHs94ESQ9HCN7DxO7iIgD+4SdUoiQgB4IO+oIy1FJPXMY0rB6ih+nW2OLczbPHGGSsbk0dV6U0aN3Vq6EpnhGmwVDcf5Akln4rdd1j/yKq8vPi9OzU4zxXzQNs0K7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723418085; c=relaxed/simple;
	bh=JXPv5IISJCz3rW0YiUGIr85RK9u1qvOya7mbFMjpjjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ta0uosjcpWYYps2DbCBY0EfbgS8Cv04cGBMRp/FiQ+wD+SVjIG6NdJz7kdtNi/cltYt3891SQy8+BFN5BjSXZwNXmNecE9FG+akCi0ERJPJiXSF5l6XEo7ab/+55tnQ/OYqfWsqKG+uUv5+9u3u6w7n+lk1IsTAZPAikURBKBcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=InFDr0gI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723418080; x=1724022880; i=quwenruo.btrfs@gmx.com;
	bh=lb8N62ywYLm2+CDRBvv/tm53tak6MTyDvVWoNS45XCk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=InFDr0gIazYYyz9aDOdRhGk75+u4czdtoTvsJJ9uhy6SrvSBYoBDCwMTauVDqwu4
	 1Zb39zS7X8j9g7aY4EyU08pJrnq6NPUd2HepLOx7xG7Ay+VmpIU+0Z4BSl8cjTs+4
	 ZyAHHCzsWZ8F/ovwQyiP3WR8Ad8P2iJIFH+m55eaqPqz24wS7VKc03DafZk2aqtF1
	 +2GRpu5zLA8hGFi2609JlZd/ZT8syNciwtUz+erHo0fa1Lukh8y4ANws0g9mfePKG
	 S27VUs0Me8mulIrWp2ZY3ujtOljADzJCCjHuN8A5FlIJ3Ucam3deF7jOcFCocd0Z8
	 tbrJO9euat9anIFWug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ygt-1sbN1Y2flL-0006yo; Mon, 12
 Aug 2024 01:14:40 +0200
Message-ID: <5c42a8a3-6571-474a-936b-df13057ff0ea@gmx.com>
Date: Mon, 12 Aug 2024 08:44:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "inode mode mismatch with dir" error on dmesg
To: =?UTF-8?B?5bCP5aSq?= <nospam@kota.moe>, linux-btrfs@vger.kernel.org
References: <CACsxjPYnQF9ZF-0OhH16dAx50=BXXOcP74MxBc3BG+xae4vTTw@mail.gmail.com>
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
In-Reply-To: <CACsxjPYnQF9ZF-0OhH16dAx50=BXXOcP74MxBc3BG+xae4vTTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+9LPszxU5FAYaNUaNJrwPfMb6VWHbTjKaDgbCI00InXcK3SWn+8
 dgCSBrab9qLomYd/iKCO/+LPq0SZxE7/wTghHmEXdMIQByL9BBKLESj6BHVeEhcOBs2LDCD
 RX22k7GIchPYKVB2NtHR0QJz8S9KTqO2d0bIBGcsktR32cNBdGeTnpa48PrDpCjW/aNXtr0
 seelBImPt7uvX2LSmWOww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D17y43xQo7M=;QxUYc5GtAMOKSIKs+Blh/hgl1gF
 rz6RbVEVt9BBHpEXvvbN38iOM8aa3o136JS4gbxPmFiw3HnfBHallMZti8NT0eSZhlXCpa2YB
 UCemB6RTTu3R5XhAIa+i0Qd2ZWbjjMuJgMNaLt7aKAzbN6CZGU/UGnbUKVU0s2s72ItuUsUFV
 Dogw39K1FMgcr7ulsz0Aa5UxY4KwxaDWe5ZtXp7DAAh5+KFgsMUYHHG8dIYVajYmK2sWtVD/4
 Ftp1UKlnN6xSUmoNqAfvv3NLf3iFNKiHOfn69S9sNq2zRYcswU9d+oVIYcQydCP7L+aHbseKS
 fUhExGoP+cPOtP44oWyg6kioEqjsdmkfNdAaoLw3ptRzhFN021SlxztZ99oaXeYvevu9Wvmcf
 XfyZQbF4Bu2Rj5JuA93nS73XEE5fEqBrJ85aG0WDwULLOIo1um9T9ewo9hT8CTtps3ksbeHnp
 neUDf/KaSXyyXbrEAnycQtl2SneI7Ho0EZsQGBxYuKu2z36x5FZEp4HnWCA6xLYsLD5CpQJUJ
 iSKmnxjmnpKjLwyS/oKG/AxlZiaOcwwihnMjDOtx22l472WNormFCoVM/0bnogPHpNPHSyURV
 K+MGr9fW4vSYSuyHELKh3QcAI7FvzwG4Xr7cszNSyMcSq9tOk+LiUABUL93bIE1Dk5IYF4kRK
 XPAaife9SWZVVWY5SD0WtYyrFNmqPnsgcOfIjlW2V+r+cYEEJvB8nKggESWVJPEe2kbdD+ce8
 zhkskON+ErQNwvZUR8Zw1n3Cf2yGBYD9URsH8NNamDPWWVtUA4C2J1celiYYlcJQR2e5q2V+X
 N1NozZJA0MG7bnQB6fJLsUHw==



=E5=9C=A8 2024/8/12 01:27, =E5=B0=8F=E5=A4=AA =E5=86=99=E9=81=93:
> Hello, I've been encountering this error for a specific directory on
> my filesystem:
>
> kota@home:~/.cache/mozilla/firefox-esr/a5h8u08v.default$ uname -a
> Linux home.kota.moe 6.9.12-amd64 #1 SMP PREEMPT_DYNAMIC Debian
> 6.9.12-1 (2024-07-27) x86_64 GNU/Linux
> kota@home:~/.cache/mozilla/firefox-esr/a5h8u08v.default$ ls -l
> ls: cannot access 'safebrowsing': Structure needs cleaning
> total 0
> ?????????? ? ? ? ?            ? safebrowsing
> kota@home:~/.cache/mozilla/firefox-esr/a5h8u08v.default$ stat safebrowsi=
ng
> stat: cannot statx 'safebrowsing': Structure needs cleaning
> kota@home:~/.cache/mozilla/firefox-esr/a5h8u08v.default$ sudo dmesg | ta=
il
> [ 1881.553937] BTRFS critical (device dm-0): inode mode mismatch with
> dir: inode mode=3D040700 btrfs type=3D2 dir type=3D0


This inode has correct value, but it's the type inside the dir inode
corrupted.

The corruption itself looks like a very basic bitflip (0x2 -> 0x0).

Please run a memtest first before doing anything.
And also please provide the CPU/memory models just in case.

Unfortunately for this particular case, kernel's tree-checker (sanity
checks) is not enough to detect it as it involves several different
items which can be in different leaves.

>
> It's been happening for a long time now (months? years?) but I've
> never bothered to try to fix it because it's not data I cared about,
> so was simply a minor annoyance when scanning the filesystem
>
> But is there a way to fix this?

And for the repair, the current btrfs-check is not able to handle them yet=
.

I can work on btrfs-progs to provide a fix soon, but that may take
several days.

Thanks,
Qu

> I'm happy to just delete the directory rather than try to recover
> anything inside.
> btrfs check also found the issue, but seemed unable to fix it.
> btrfs scrub does not find the issue.
>

