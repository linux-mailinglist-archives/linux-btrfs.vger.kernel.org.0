Return-Path: <linux-btrfs+bounces-442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04827FE0FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 21:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF4A28229C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99B060EE0;
	Wed, 29 Nov 2023 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TWqkb694"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2571D68
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 12:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701289661; x=1701894461; i=quwenruo.btrfs@gmx.com;
	bh=dYKyVGkZViH1C+BDyiusIWvOZn3TDVenMf6pQWARIOI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TWqkb694wJAYoCD9ylHomySt3Nlq5ojFoPyPOLmlGZfJDYNKMk1opfI36AzPSQ4x
	 938D0gOOFIpXUwW6HBzZFXIQTp5TQCNIi+BxNxyszPfBUvE0QADq4g2zzjP5G++T/
	 md4jQ2aqtTUOYu/qay42XnHhSMRYiA6bvs8ySCepxm/JRCG2dzfDBWM7pIEE59iCJ
	 nV9pS/CzZUWLd2BpBkd1OXpxAORf+dMss6xdQvJZo81UnRbP3jylm5xqVSKc8zn7m
	 GlpYXDhBgmT9/Xk/6a+P1S2VRSKpwObCpfe2si6Zblyc7NWe85u86lUCiwWW6XQpe
	 xT9UY6LuhNniIHCJaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63VY-1rNm8T0KuO-016Nse; Wed, 29
 Nov 2023 21:27:41 +0100
Message-ID: <c87f6f12-15ef-4860-a3c8-7038c51eddb1@gmx.com>
Date: Thu, 30 Nov 2023 06:57:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] Enforce 4k sectorize by default for mkfs
To: Hector Martin <marcan@marcan.st>, Neal Gompa <neal@gompa.dev>,
 Qu Wenruo <wqu@suse.com>
Cc: Josef Bacik <josef@toxicpanda.com>,
 Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
 Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.cz>,
 Sven Peter <sven@svenpeter.dev>, Davide Cavalca <davide@cavalca.name>,
 Jens Axboe <axboe@fb.com>, Asahi Lina <lina@asahilina.net>,
 Asahi Linux <asahi@lists.linux.dev>
References: <20231116160235.2708131-1-neal@gompa.dev>
 <20231127160705.GC2366036@perftesting>
 <fb78d997-cb99-4b98-8042-bdcdbff22b88@marcan.st>
 <f229058e-4f5d-4bd0-9016-41b133688443@suse.com>
 <CAEg-Je8r0K0k8UMcAafxXyrNuxJrxJbGhkwvo10pUw+rxhCa8g@mail.gmail.com>
 <aaee6d4f-4e89-4bc7-8a7e-03ffc8b81a34@marcan.st>
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
In-Reply-To: <aaee6d4f-4e89-4bc7-8a7e-03ffc8b81a34@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sQ9h69TrETyIydJoxq3c15N8jsF5VuKLtKEQs+lhMOvdBrVGhNC
 25BHCHgJwZKodHfoS1YXOK/goZpC93w3/oGFDqvtbk9S/xhmUXwHiTXS07pjAM8gMUVZcHb
 MqQKje/RduZCUJycvA41Klv4bFJ/PNb9LImaAnDCr9DZNhFYNDNoZqZx4GIyA7QFBmKwMFq
 2aTHfuzC9dXQDkfWtvV7w==
UI-OutboundReport: notjunk:1;M01:P0:yBXd5j7ICLs=;pZiusqj/8gXXW+7x+/OYmdifdsB
 8WkWwsgGrRyHfDW3DlxkAIzSxi9jECfhhhuhZOv/B9+CEPPDgY+/NGOEMjaUBiXPfrnu2Qpj+
 mwv2B7Cmhz5UMTBXhKSrLpdy5h2+ArTmLWph3ogqI2XMdlPJMS+wPvJqH2+O1avRP29J6faZu
 vnxnXqOPqWA2mZGrblzlNw31l3QwRaLIEk2+csnn658jEjV7sMuv4hNEK2Q/MuV+/DKCE5e/R
 z6Ksyepbg28q681lJC1OlOognKDfo07CNo34yYz3xzvorriqOUYxhnkWEh3mc7T/ZwXQWAj/f
 TOKsT7GFTQn6oZTPquntuTOwThoPReNOUf5UosUfEXktuxfoKUZePvlmqhSw5ZA0PRp/DULyA
 uWm875WyhvK3k3ocz71cegkYjTBzk7G107y84FsVgeGJeR5BMPPZBcbBGU75yIfWXEbTHeKOj
 1DRChzvjgL4R2tDzsZ6GUXEG3cf2wdXc5XX8P8go/xjOhlVrFDIqOdx1OAGHatXHCRzK7b1LM
 5+51gzgJ9lBHUwZkEMwdbEA0NiCuuwwq6qHDPlCYZDMqhNzD4bbZszoCqPQ8T5Mo+bwYS2xry
 aL47Bjio6NP9mq3GN6+67RLW+xAYXQiNx0rzS1mxi7tpml1PJZ9HqdfwHyNpPTm5MY+xZqnBG
 bF2m4f2K+5uN/1SVJC/MZgc93IDuV+DqhJgUtNc+D34744P0Iamea+EQnrzMKCA+JxiA4LwLp
 fFdi0352kOH65hZZUk3S2GrPzlbp+pAbkxiM0/jqiUe3FY6W13F2Q8RfRKUJcAibTRNfqtO9e
 Y/HpMfZ/hu3TBjkd9UcaQoL79FD772eGk8xUNPQR7qt/mjN/uL4Sa0a0vzrxYqPBHAov60GVw
 vxDiGXjMbW+/LST63kTKJgM4R6JlCD3pTRumoTIGEYVq1sAfFuA6zoyvRQaY3H+JomnujAaxu
 uQcgopVjCHWTw1AehhyP88JZtVg=



On 2023/11/29 23:28, Hector Martin wrote:
>
>
> On 2023/11/29 6:24, Neal Gompa wrote:
>> On Tue, Nov 28, 2023 at 2:57=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>>
>>>
>>>
>>> On 2023/11/29 01:31, Hector Martin wrote:
>>>>
>>>>
>>>> On 2023/11/28 1:07, Josef Bacik wrote:
>>>>> On Thu, Nov 16, 2023 at 11:02:23AM -0500, Neal Gompa wrote:
>>>>>> The Fedora Asahi SIG[0] is working on bringing up support for
>>>>>> Apple Silicon Macintosh computers through the Fedora Asahi Remix[1]=
.
>>>>>>
>>>>>> Apple Silicon Macs are unusual in that they currently require 16k
>>>>>> page sizes, which means that the current default for mkfs.btrfs(8)
>>>>>> makes a filesystem that is unreadable on x86 PCs and most other ARM
>>>>>> PCs.
>>>>>>
>>>>>> This is now even more of a problem within Apple Silicon Macs as it =
is now
>>>>>> possible to nest 4K Fedora Linux VMs on 16K Fedora Asahi Remix mach=
ines to
>>>>>> enable performant x86 emulation[2] and the host storage needs to be=
 compatible
>>>>>> for both environments.
>>>>>>
>>>>>> Thus, I'd like to see us finally make the switchover to 4k sectorsi=
ze
>>>>>> for new filesystems by default, regardless of page size.
>>>>>>
>>>>>> The initial test run by Hector Martin[3] at request of Qu Wenruo
>>>>>> looked promising[4], and we've been running with this behavior on
>>>>>> Fedora Linux since Fedora Linux 36 (at around 6.2) with no issues.
>>>>>>
>>>>>
>>>>> This is a good change and well documented.  This isn't being ignored=
, it's just
>>>>> a policy change that we have to be conservative about considering.  =
We only in
>>>>> the last 3 months have added a Apple Silicon machine to our testing
>>>>> infrastructure (running Fedora Asahi fwiw) to make sure we're gettin=
g consistent
>>>>> subpage-blocksize testing.  Generally speaking it's been fine, we've=
 fixed a few
>>>>> things and haven't broken anything, but it's still comes with some r=
isks when
>>>>> compared to the default of using the pagesize.
>>>>>
>>>>> We will continue to discuss this amongst ourselves and figure out wh=
at we think
>>>>> would be a reasonable timeframe to make this switch and let you know=
 what we're
>>>>> thinking ASAP.  Thanks,
>>>>
>>>> Reminder that the Raspberry Pi 5 is also shipping with 16K pages by
>>>> default now. The clock is ticking for an ever-growing stream of peopl=
e
>>>> upset that they can't mount/data-rescue/etc their rPi5 NAS disks from=
 an
>>>> x86 machine ;)
>>>
>>> As long as they are using 5.15+ kernel, they should be able to mount a=
nd
>>> use their RPI NAS with disks from x86 machines.
>>>
>>> The change is only for the default mkfs options.
>>>
>>
>> Right, and the thing is, it's fairly common for the disks to be
>> formatted from a Raspberry Pi. So until some kind of support for using
>> any sector size on any architecture regardless of page size lands,
>> this is going to be a big problem.
>>
>
> Yup, I meant what I said.
>
> Someone sets up a rPi5 as a NAS, formats the disk from it, as you would
> normally when setting up such a thing from scratch. Later, the rPi stops
> working, as rPis often do. This person's data is now *completely
> inaccessible* until they find another Raspberry Pi 5 or an Apple Silicon
> laptop.
Got it.

I am putting too much trust on RPI, as my experience is pretty good so
far (just for VM hosting and running fstests), thus I though everyone
would just go x86->aarch64, at least for NAS hosting/VM testing...

>
> This is going to be *common*. And since the 16K decision is made at
> format time, these people are going to be oblivious until they find
> themselves with an urgent need to acquire a Raspberry Pi 5 to access
> their data at all, and then they're going to be mad. So the longer you
> wait to flip the switch, the more people unaware of their own data's
> fragile accessibility condition you will build up, and the more upset
> people you're going to have even long after the change was finally made.

In that case, I'm totally fine to support the switch of default sector
size, sooner than later.

With Asahi already running 4K sector sizes, and I have not received any
death thread for the loss of one's data, I believe the prerequisite for
the switch is already here.

And even if there are hidden bugs, default to 4K is in fact going to
make it faster to get reports and fixed.

Thanks,
Qu
>
> - Hector

