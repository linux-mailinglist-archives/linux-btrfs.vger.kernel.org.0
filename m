Return-Path: <linux-btrfs+bounces-6213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1761B927F12
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 00:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9424C1F228A1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1780A144317;
	Thu,  4 Jul 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="thb2f78d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6C1442EA
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720132728; cv=none; b=HWzz1UAC5qmOHVspGVAKS8WuMx2K4LBh8dSQ2DiishVd7UGPaEQ4EDI4RT05yn0HGz/n1vKJhzIPrlaLrKlfdipCbifkuJozWnjvamqodPHgUrKuNKW8NN6jtI03+CUQSps7pOVx8e9Wl6kCb5UmzzXjAqngMb5DsB0r/X9R9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720132728; c=relaxed/simple;
	bh=Jd5YyEHXgjtLFrvYaG8jF3fGybzEIQpzlDlYtpR6s4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FI4zbddiUNA0SmylFNPMv/knUk3HI4qP9W6GYR0uu/5HxaAF/e6oKbrMiz5512f+5mK3osfg3Jt783/zokBeeWHMfq9cZZSK8h3hZbKx3hYUbS1Zs7wrJNiQTI2ytEvYS87OQaGjGZkMyvOeBwcMrkSoKt6jURvvRbFAkCI+dfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=thb2f78d; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720132722; x=1720737522; i=quwenruo.btrfs@gmx.com;
	bh=94HJcL5i+8hxuOZyr9J3m+jyGdtp0Zl3nZdBvrsLybc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=thb2f78dC+Vvj4vgszXFYwa4L3pNU9UtG7X8HphtrBKdq7BEKNJq8V5Z7h2Qaf8R
	 hHaZJOu0+WrV8pgs5bmsFWa8yDdtfYxn9/jnoXNvfkrNXdXTOlnvoOJZe4WdUWx+s
	 qlL6sWEGB/aTba6P+sSpZ1uX4aJml2IxktQCXll8OIqT7ZDkJqaPce2QNCdPjh6U9
	 X8r9gX1XVLzDHsqKiAyu4oZQueOBQX+TdMtM89L1h7QYOfDziOk+1EmgFq5iSkELt
	 g7/pOBMc+dyOEzh4fx0HdayhY47k4pthwN6100NBbt1CKnzWsbpuyOCBDATs08I/Y
	 GWXSmGS/kPYTc/dEEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNKlu-1snFHM18oc-00RiGo; Fri, 05
 Jul 2024 00:38:42 +0200
Message-ID: <2650d27a-5127-4ec9-b62f-ec1683d0cecf@gmx.com>
Date: Fri, 5 Jul 2024 08:08:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: scrub reports uncorrectable csum errors linked to readable
 file (data: single)
To: Lionel Bouton <lionel-subscription@bouton.name>,
 linux-btrfs@vger.kernel.org
References: <c2fa6c37-d2a8-4d77-b095-e04e3db35ef0@bouton.name>
 <4525e502-c209-4672-ae32-68296436d204@gmx.com>
 <1df4ce53-8cf9-40b1-aa43-bf443947c833@bouton.name>
 <80456d11-9859-402c-a77c-5c3b98b755a5@gmx.com>
 <05fc8552-1b6f-4b6c-82b2-0cf716cc8e6b@bouton.name>
 <ae6aab7d-029d-4e33-ace7-e8f0b0a2fa36@bouton.name>
 <08774378-624a-4586-9f24-c108f1ffeebb@gmx.com>
 <c24180e5-b0dc-47e5-91b0-7935e85ccc4b@bouton.name>
 <1fe1927e-356d-4181-8c5e-34f73b8b201d@bouton.name>
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
In-Reply-To: <1fe1927e-356d-4181-8c5e-34f73b8b201d@bouton.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aO8bpbgwfjS2VjROnQrnHPKLTaXFqPwtTtUMU3t5+ASb9YPmatn
 0LM022Ysw/jS+/wExQSHHlx75UcJgYNeTYRnCw1I33H2Lqh5ubSyR4b+6eQEW0nKRNOarHb
 4JjgDiZ/MvZPNhCroKwArUQjeRwgVb5mc7rkUEVQ9uTCV8TiVV6qwbiS4qyb5VczTUJvr/d
 aljtK52aBtl7T3eoOoY5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S7+z9h3c3Y4=;leVGbhoxbfC5QSTzyUqAyOZjTdG
 6jk5AuKfmLfJAPZaLb4FDUIgHEx+oRywGOxmrjdULjFeIzs5fjNEj6NcCPxPEIUcoocTHOkac
 M4ORNvZhQKX2JiHvCnX0nRax4Tp+15Q64ztOKsYeQg+UO7yKfPS/8tWI+lcPCajc21TmUIngG
 weEeEYyJq6+VrzgZsVX+5vsiYfW6biZlrY+DdXFRjlXyPH3fS0XgsgWo8YCkVtMjDBWOjV4ob
 d+tcnwQ9xCxKf0NZIzkIDhfjZYRUE47nT/do5naHIvubGL7I0AaaKsWrD8HMGHWk3w4ncq0o6
 EOHEMTyc+jUZVjZpGlMx4OgXmR2RZZil0brb3SDZ1ZOhQ015OdYlqatWJ33RAi96Zmphx9Pdt
 KkmJZ0ffCljAjURHwzqRZxC6w4c8oI04cnohmbOg6VBtldbZClZThRBX5MXQKVOfvQxajrHSe
 r1CLk6SbqAUNh5TyQmgddajabBFGi3kFaBJwinkNaDJR//3N8icQNT03+yVVdjVCwfLebZUXw
 ecrU/e5Lc4FJMesQ0naNFRRIdZ9sl8iybVy2y75/TrZo9Pc8Ye1WnIQQudNEqDjmpjVzbof+q
 zucNSSXiCthwcMrh20D/1YLXJSilZ/syI24WPtziCLQoXR0gaMGGVzZrQ/zcdoAO1kbzMhgg2
 bs3yaWgh91Lz0X9xLXcd0XiC1i/SPNrjHbNK9RKZcitkho4wZXj3hzmCCPUleHa/XXZ2JpXKq
 hCoYcMf10QdX9bdKhkt5/yvkyt2I0wembpRoL9tckicATuXKPxQTy0D2IHohmCn4S/ngqvdzi
 qme/DZGG80iok/TBOYW2hbUHlGtOzFKWNgF7aHlwvEHlc=



=E5=9C=A8 2024/7/4 21:51, Lionel Bouton =E5=86=99=E9=81=93:
> Le 30/06/2024 =C3=A0 12:59, Lionel Bouton a =C3=A9crit=C2=A0:
>> Le 22/06/2024 =C3=A0 11:41, Qu Wenruo a =C3=A9crit=C2=A0:
>>>
>>>
>>> =E5=9C=A8 2024/6/22 18:21, Lionel Bouton =E5=86=99=E9=81=93:
>>> [...]
>>>>>
>>>>> I'll mount the filesystem and run a scrub again to see if I can
>>>>> reproduce the problem. It should be noticeably quicker, we made
>>>>> updates to the Ceph cluster and should get approximately 2x the I/O
>>>>> bandwidth.
>>>>> I plan to keep the disk snapshot for at least several weeks so if yo=
u
>>>>> want to test something else just say so.
>>>>
>>>>
>>>> The scrub is finished, here are the results :
>>>>
>>>> UUID: 61e86d80-d6e4-4f9e-a312-885194c5e690
>>>> Scrub started:=C2=A0=C2=A0=C2=A0 Wed Jun 19 00:01:59 2024
>>>> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
inished
>>>> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 81:04:21
>>>> Total to scrub:=C2=A0=C2=A0 18.83TiB
>>>> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 67.67MiB/s
>>>> Error summary:=C2=A0=C2=A0=C2=A0 no errors found
>>>>
>>>> So the scrub error isn't deterministic. I'll shut down the test VM fo=
r
>>>> now and keep the disk snapshot it uses for at least a couple of week =
if
>>>> it is needed for further tests.
>>>> The original filesystem is scrubbed monthly, I'll reply to this messa=
ge
>>>> if another error shows up.
>>>
>>> I briefly remembered that there was a bug related to scrub that can
>>> report false alerts:
>>>
>>> f546c4282673 ("btrfs: scrub: avoid use-after-free when chunk length is
>>> not 64K aligned")
>>>
>>> But that should be automatically backported, and in that case it shoul=
d
>>> have some errors like "unable to find chunk map" error messages in the
>>> kernel log.
>>>
>>> Otherwise, I have no extra clues.
>>>
>>> Have you tried kernels like v6.8/6.9 and can you reproduce the bug in
>>> those newer kernels?
>>
>> I've just upgraded the kernel to 6.9.7 (and btrfs-progs to 6.9.2) and
>> monthly scrubs with it will start next week. That said the last
>> filesystem scrub with 6.6.30 ran without errors so it might be hard to
>> reproduce.
>> One difference with the last scrub vs the previous one which reported
>> checksum errors is the underlying device speed : it is getting faster
>> as we replace HDDs with SSDs on the Ceph cluster (it might be a cause
>> if there's a race condition somewhere). Other than that there's
>> nothing I can think of.
>>
>> In fact the only 2 major changes before the scrub checksum errors where=
 :
>> - a noticeable increase in constant I/O load,
>> - an upgrade to the 6.6 kernel.
>>
>> As nobody else reported the same behavior I'm not ruling out an
>> hardware glitch either.
>> I'll reply to this thread if a future scrub reports a non reproducible
>> checksum error again.
>
> I didn't expect to have something to report so soon...
> Another virtual machine running on another physical server but using the
> same Ceph cluster just reported csum errors that aren't reproducible.
> This was with kernel 6.6.13 and btrfs-progs 6.8.2.
> Fortunately this filesystem is small and can be scrubbed in 2 minutes :
> I just ran the scrub again (less than 5 hours after the one that
> reported errors) and no error are reported this time.
>
> I'll upgrade this VM to 6.9.7+ too. If 6.6 has indeed a scrub bug and
> not 6.9 it might be easier to verify than I anticipated : most of our
> VMs have migrated or are in the process of migrating to 6.6 which is the
> latest LTS. If the problem manifest itself on a small filesystem too I
> expect other systems to fail scrubs sooner or later if 6.6 is affected
> by a scrub bug.

So far it looks like it's the commit f546c4282673 ("btrfs: scrub: avoid
use-after-free when chunk length is not 64K aligned") fixing the error.

In that case, it looks like 6.6 is EOL at that time thus didn't got
backports.

To verify if it's the case, you can dump the chunk tree and check if
their length is 64K aligned, and if the dmesg shows something like this
"      BTRFS critical (device vdb): unable to find chunk map for logical
2214744064 length 4096".

Thanks,
Qu
>
> Like I wrote last time I'll reply here if other scrubs report non
> reproducible csum errors.
>
>>
>> Lionel
>>
>>>
>>> Thanks,
>>> Qu
>>>>
>>>>>
>>>>> Best regards,
>>>>> Lionel
>>>>>
>>>>>>
>>>>>> If btrfs check reports error, and logical-resolve failed to locate
>>>>>> the
>>>>>> file and its position, it means the corruption is in bookend exntet=
s.
>>>>>>
>>>>>> If btrfs check reports error and logical-resolve can locate the
>>>>>> file and
>>>>>> position, it's a different problem then.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> The stats output show that this file was not modified since its
>>>>>>> creation
>>>>>>> more than 6 years ago. This is what led me to report a bug in scru=
b.
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> - Some including the original subvolume have only logged 2
>>>>>>>>> warnings and
>>>>>>>>> one (root 151335) logged only one warning.
>>>>>>>>> - All of the snapshots reported a warning for offset 20480.
>>>>>>>>> - When several offsets are logged their order seems random.
>>>>>>>>
>>>>>>>> One problem of scrub is, it may ratelimit the output, thus we
>>>>>>>> can not
>>>>>>>> just rely on dmesg to know the damage.
>>>>>>>
>>>>>>> I wondered about this: I've read other threads where ratelimiting =
is
>>>>>>> mentioned but I was not sure if it could apply here. Thanks for
>>>>>>> clarifying.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> I'm attaching kernel logs beginning with the scrub start and
>>>>>>>>> ending with
>>>>>>>>> the last error. As of now there are no new errors/warnings even
>>>>>>>>> though
>>>>>>>>> the scrub is still ongoing, 15 hours after the last error. I
>>>>>>>>> didn't
>>>>>>>>> clean the log frombalance logs linked to the same filesystem.
>>>>>>>>>
>>>>>>>>> Side-note for the curious or in the unlikely case it could be
>>>>>>>>> linked to
>>>>>>>>> the problem:
>>>>>>>>> Historically this filesystem was mounted with ssd_spread
>>>>>>>>> without any
>>>>>>>>> issue (I guess several years ago it made sense to me reading the
>>>>>>>>> documentation and given the IO latencies I saw on the Ceph
>>>>>>>>> cluster). A
>>>>>>>>> recent kernel filled the whole available space with nearly empty
>>>>>>>>> block
>>>>>>>>> groups which seemed to re-appear each time we mounted with
>>>>>>>>> ssd_spread.
>>>>>>>>> We switched to "ssd" since then and there is a mostly daily 90mn
>>>>>>>>> balance
>>>>>>>>> to reach back the previous stateprogressively (this is the reaso=
n
>>>>>>>>> behind
>>>>>>>>> the balance related logs). Having some space available for new
>>>>>>>>> block
>>>>>>>>> groups seems to be a good idea but additionally as we use Ceph
>>>>>>>>> RBD, we
>>>>>>>>> want it to be able to deallocate unused space: having many nearl=
y
>>>>>>>>> empty
>>>>>>>>> block groups could waste resources (especially if the used
>>>>>>>>> space in
>>>>>>>>> these groups is in <4MB continuous chunks which is the default R=
BD
>>>>>>>>> object size).
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> More information :
>>>>>>>>> The scrub is run monthly. This is the first time an error was ev=
er
>>>>>>>>> reported. The previous scrub was run successfully at the
>>>>>>>>> beginning of
>>>>>>>>> May with a 6.6.13 kernel.
>>>>>>>>>
>>>>>>>>> There is a continuous defragmentation process running (it
>>>>>>>>> processes the
>>>>>>>>> whole filesystem slowly ignoring snapshots and defragments file =
by
>>>>>>>>> file
>>>>>>>>> based on a fragmentation estimation using filefrag -v). All
>>>>>>>>> defragmentations are logged and I can confirm the file for
>>>>>>>>> which this
>>>>>>>>> error was reported was not defragmented for at least a year (I
>>>>>>>>> checked
>>>>>>>>> because I wanted to rule out a possible race condition between
>>>>>>>>> defragmentation and scrub).
>>>>>>>>
>>>>>>>> I'm wondering if there is any direct IO conflicting with
>>>>>>>> buffered/defrag IO.
>>>>>>>>
>>>>>>>> It's known that conflicting buffered/direct IO can lead to conten=
ts
>>>>>>>> change halfway, and lead to btrfs csum mismatch.
>>>>>>>> So far that's the only thing leading to known btrfs csum mismatch=
 I
>>>>>>>> can
>>>>>>>> think of.
>>>>>>>
>>>>>>> But here it seems there isn't an actual mismatch as reading the
>>>>>>> file is
>>>>>>> possible and gives the data which was written in it 6 years ago.
>>>>>>> Tthis
>>>>>>> seems an error in scrub (or a neutrino flipping a bit somewhere
>>>>>>> during
>>>>>>> the scrub). The VM runs on a server with ECC RAM so it is unlikely
>>>>>>> to be
>>>>>>> a simple bitflip but when everything likely has been ruled out...
>>>>>>>
>>>>>>> Thanks for your feedback,
>>>>>>> Lionel
>>>>>>>
>>>>>>>>
>>>>>>>> But 6.x kernel should all log a warning message for it.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>> In addition to the above, among the notable IO are :
>>>>>>>>> - a moderately IO intensive PostgreSQL replication subscriber,
>>>>>>>>> - ponctual large synchronisations using Syncthing,
>>>>>>>>> - snapshot creations/removals occur approximately every 80
>>>>>>>>> minutes. The
>>>>>>>>> last snapshot operation was logged 31 minutes before the errors
>>>>>>>>> (removal
>>>>>>>>> occur asynchronously but where was no unusual load at this time
>>>>>>>>> that
>>>>>>>>> could point to a particularly long snapshot cleanup process).
>>>>>>>>>
>>>>>>>>> To sum up, there are many processes accessing the filesystem but
>>>>>>>>> historically it saw far higher IO load during scrubs than what w=
as
>>>>>>>>> occurring here.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Reproducing this might be difficult: the whole scrub can take a
>>>>>>>>> week
>>>>>>>>> depending on load. That said I can easily prepare a kernel
>>>>>>>>> and/or new
>>>>>>>>> btrfs-progs binaries to launch scrubs or other non-destructive
>>>>>>>>> tasks the
>>>>>>>>> week-end or at the end of the day (UTC+2 timezone).
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>>
>>>>>>>>> Lionel Bouton
>>>>>>>>
>>>>>>>
>>>>>
>>>>
>>>>
>>
>

