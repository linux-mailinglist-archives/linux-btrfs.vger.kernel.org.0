Return-Path: <linux-btrfs+bounces-10110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9B9E81ED
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 21:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09192281DEB
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 20:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA97154BF5;
	Sat,  7 Dec 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GrTadidp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35134CC4
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Dec 2024 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733603172; cv=none; b=FRO2eOzKJDT1hxkiNZJOUNiNiIZJ5zcJD2xt/fvQfEGTAjm6EgeYSwb2GaBPPaLOAYuKiHx2/DivsKQMpLA2gwP2mzneC4nuquy1AMthPh0X+4ysv1depjXK9VupzqHL2FPw28PFI3saccYlDF+HNjuy0NIu7f8PImf73rOzCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733603172; c=relaxed/simple;
	bh=z14qycMsnj23opbli249LfOgIIaAQIPt5g9NYv12uEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EfHJFO380BloAUpTZT7RQRI+21DrJLbXUM9GiCxcZUyGaelf8Mow3O+qAainsumIii2KlgfMdmm68wjwzRcEFRGNhJ7hPlKF0sDDipsPzpPApsROyRrPwiqLqAyvk0mDkPihG7ka44yUxCWfWiESQLG9HuNBbIFrfmQIeT5m4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GrTadidp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733603164; x=1734207964; i=quwenruo.btrfs@gmx.com;
	bh=z14qycMsnj23opbli249LfOgIIaAQIPt5g9NYv12uEs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GrTadidpqWiUaKabWKRZxqm5x8O1FJ8OEvsk7scibi9hND5UAvf033lHe31asoln
	 3/yp6lIyk0fn8chRRK2RIyfy8PPKJiLlMRSDF/5buL/fEbet8/D2I8qI3Mu/1A1F6
	 Png/nyw2eAuy6gbgSmMEryJstYf2Wzj2sbGHETxspmPZPLEMhF3yYQzSTJFB3QoF1
	 lUOY6sviSsyWpOKkistxXan8Ih95vRX+RqW1wSAOx5sPvz0H8GPhxdNkzPE5pP8hg
	 rEz3BwkZMU4coXvExYYPR26u5WgfyAn5Oou7C5ksYxuYG0iSxeET8vBFs3zpkGBUL
	 tN/2ZLCarKToka3Xyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQgC-1tXAXU0iCu-018A56; Sat, 07
 Dec 2024 21:26:04 +0100
Message-ID: <cfa74363-b310-49f0-b4bf-07a98c1be972@gmx.com>
Date: Sun, 8 Dec 2024 06:56:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
 <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
 <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com>
 <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
 <b5f70481-34a1-4d65-a607-a3151009964d@suse.com>
 <9ae3c85e-6f0b-4e33-85eb-665b3292638e@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <9ae3c85e-6f0b-4e33-85eb-665b3292638e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:acAFGTbNwDgcn8YJ7wVGVb3G0VZSBBUA8Fo62hI0WhZOQD4aLVd
 2/VZER1HO6Yuh+TnRKAx4k1fbd2VFDd2Ies3mvS8eDdYxxWjirqBJDoLLGJt+6vC6u+Prow
 6u2Gl1eQg0s7XtrU036BsMnkFSg9M1jomuzH5iIPA2ARn7V6aMUDOQTzXvVwjE7V7PBOJEL
 DwHM/esMgL/8ySQU7aTWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cpte+fGy1QQ=;OJIigPJ9QmoJCWtuMz9f03j4NVk
 H5fTEkFwoZTOJfif0AgtzZis6q9O5Us5qoK96Ozg72iZFxhfyIZIeN6IIs8CtLmvXs/XWoxBd
 kP17Ql9wczNICpgAkI7QxP/izG4XT1JW2nfF1y35laq1LQs2EAqmoMqzkd6eL181LDUKEjxeY
 fiLRI92dm5F5dyu6z446tM3aaoIEGcCSJ4DFTvdRckIHIRwncNqbQ09M73y6i/KBSf2inAyoS
 X+ZvMA+sfQDAYjffNK+owRwAVC3YT3S6OO4VJJXTdzW6/yEBilSLBmgfdMtz4wdmRf8sY71us
 5Pr9MQ7iiU3BcKUCoH5dKTmWGcraXU3Ff6YR5Ww1TlytJW1ivGNJTPUGVaQ6z2C1TS0laOWYv
 UqjpnkxmWa1RMpnOE86QD9Gq1gYF7SqBa1LYvV0Loph/6y2IjbS7BW1x9RlQRia+I2bStuy5K
 duXWSQFDREOCdPnBuqaFRolDC01hVnf5Bvj8/Q8XvdTxpMxHQmM8jSdlpPcASh6m+0yfg5yQM
 rEesfO35wblsDKBztH/CHKMFRqEqmqbFuZ1n/BKFDQ64gkfXMXfTfjq0XuGIlq3U8zO4ssmwM
 bBLdBpVr9szpWyXcvS8dLMyU3Pb92x/ftaHmX9DwyPYV9l3H4gklbDux9+0AH4INhxd9mqzWZ
 Me2X38Q5YDXNBoXbTTUs1ePxTn5Ng38xL8W6BMPxwO40NcIcLZx00c13Z4MNyoJamTPmxAT1H
 lsJ5UEV/X8qvV1hKJaMOJ3JQaJ7N7Kct+WhVFKgqMkwCl87JyT8fPjTU086XcXBEW4sSlz1/C
 hm/a89CgOWLZf+P0x0Kfy89GVchboIbdy8/h+YshAR9OFO2pfzh4bDvaWMBJw70jvFw1sdP4W
 YlqcZwPTRJo2/J1/z9BQzCGctnAI7tltrR14Msplbb6BD0ujX3BWGUQqELyxLE3BjR7PlVIbj
 vWAW0mD0JD5/47xuaeRsSiY9YdJqaMuVsyNK+C/OCqCh74JipqMbtQqzjUEsQr6PUzt7dxjui
 sw0ZcCUVTZGGNfeN8DjOO20tuTs5Orw9v96caVmhGU5/F7xSbwk2KItvAS6o1iy5cfXM55mcM
 yePjSwGohhAwnOaotwJR48m5XJaM4L



=E5=9C=A8 2024/12/7 18:07, Andrei Borzenkov =E5=86=99=E9=81=93:
> 06.12.2024 07:16, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/12/6 14:29, Andrei Borzenkov =E5=86=99=E9=81=93:
>>> 05.12.2024 23:27, Qu Wenruo wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2024/12/6 03:23, Andrei Borzenkov =E5=86=99=E9=81=93:
>>>>> 05.12.2024 01:34, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> =E5=9C=A8 2024/12/5 05:47, Andrei Borzenkov =E5=86=99=E9=81=93:
>>>>>>> 04.12.2024 07:40, Qu Wenruo wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> =E5=9C=A8 2024/12/4 14:04, Scoopta =E5=86=99=E9=81=93:
>>>>>>>>> I'm looking to deploy btfs raid5/6 and have read some of the
>>>>>>>>> previous
>>>>>>>>> posts here about doing so "successfully." I want to make sure I
>>>>>>>>> understand the limitations correctly. I'm looking to replace an
>>>>>>>>> md+ext4
>>>>>>>>> setup. The data on these drives is replaceable but obviously
>>>>>>>>> ideally I
>>>>>>>>> don't want to have to replace it.
>>>>>>>>
>>>>>>>> 0) Use kernel newer than 6.5 at least.
>>>>>>>>
>>>>>>>> That version introduced a more comprehensive check for any RAID56
>>>>>>>> RMW,
>>>>>>>> so that it will always verify the checksum and rebuild when
>>>>>>>> necessary.
>>>>>>>>
>>>>>>>> This should mostly solve the write hole problem, and we even have
>>>>>>>> some
>>>>>>>> test cases in the fstests already verifying the behavior.
>>>>>>>>
>>>>>>>
>>>>>>> Write hole happens when data can *NOT* be rebuilt because data is
>>>>>>> inconsistent between different strips of the same stripe. How btrf=
s
>>>>>>> solves this problem?
>>>>>>
>>>>>> An example please.
>>>>>
>>>>> You start with stripe
>>>>>
>>>>> A1,B1,C1,D1,P1
>>>>>
>>>>> You overwrite A1 with A2
>>>>
>>>> This already falls into NOCOW case.
>>>>
>>>> No guarantee for data consistency.
>>>>
>>>> For COW cases, the new data are always written into unused slot, and
>>>> after crash we will only see the old data.
>>>>
>>>
>>> Do you mean that btrfs only does full stripe write now? As I recall fr=
om
>>> the previous discussions, btrfs is using fixed size stripes and it can
>>> fill unused strips. Like
>>>
>>> First write
>>>
>>> A1,B1,...,...,P1
>>>
>>> Second write
>>>
>>> A1,B1,C2,D2,P2
>>>
>>> I.e. A1 and B1 do not change, but C2 and D2 are added.
>>>
>>> Now, if parity is not updated before crash and D gets lost we have
>>
>> After crash, C2/D2 is not referenced by anyone.
>> So we won't need to read C2/D2/P2 because it's just unallocated space.
>>
>
> You do need to read C2/D2 to build parity and to reconstruct any missing
> block. Parity no more matches C2/D2. Whether C2/D2 are actually
> referenced by upper layers is irrelevant for RAID5/6.

Nope, in that case whatever garbage is in C2/D2, btrfs just do not care.

Just try it yourself.

You can even mkfs without discarding the device, then btrfs has garbage
for unwritten ranges.

Then do btrfs care those unallocated space nor their parity?
No.

Btrfs only cares full stripe that has at least one block being referred.

For vertical stripe that has no sector involved, btrfs treats it as
nocsum, aka, as long as it can read it's fine. If it can not be read
from the disk (missing dev etc), just use the rebuild data.

Either way for unused sector it makes no difference.

>
>> So still wrong example.
>>
>
> It is the right example, you just prefer to ignore this problem.

Sure sure, whatever you believe.

Or why not just read the code on how the current RAID56 works?

>
>> Remember we should discuss on the RMW case, meanwhile your case doesn't
>> even involve RMW, just a full stripe write.
>>
>>>
>>> A1,B1,C2,miss,P1
>>>
>>> with exactly the same problem.
>>>
>>> It has been discussed multiple times, that to fix it either btrfs has =
to
>>> use variable stripe size (basically, always do full stripe write) or
>>> some form of journal for pending updates.
>>
>> If taking a correct example, it would be some like this:
>>
>> Existing D1 data, unused D2 , P(D1+D2).
>> Write D2 and update P(D1+D2), then power loss.
>>
>> Case 0): Power loss after all data and metadata reached disk
>> Nothing to bother, metadata already updated to see both D1 and D2,
>> everything is fine.
>>
>> Case 1): Power loss before metadata reached disk
>>
>> This means we will only see D1 as the old data, have no idea there is
>> any D2.
>>
>> Case 1.0): both D2 and P(D1+D2) reached disk
>> Nothing to bother, again.
>>
>> Case 1.1): D2 reached disk, P(D1+D2) doesn't
>> We still do not need to bother anything (if all devices are still
>> there), because D1 is still correct.
>>
>> But if the device of D1 is missing, we can not recover D1, because D2
>> and P(D1+D2) is out of sync.
>>
>> However I can argue this is not a simple corruption/power loss, it's tw=
o
>> problems (power loss + missing device), this should count as 2
>> missing/corrupted sectors in the same vertical stripe.
>>
>
> This is the very definition of the write hole. You are entitled to have
> your opinion, but at least do not confuse others by claiming that btrfs
> protects against write hole.
>
> It need not be the whole device - it is enough to have a single
> unreadable sector which happens more often (at least, with HDD).
>
> And as already mentioned it need not happen at the same (or close) time.
> The data corruption may happen days and months after lost write. Sure,
> you can still wave it off as a double fault - but if in case of failed
> disk (or even unreadable sector) administrator at least gets notified in
> logs, here it is absolutely silent without administrator even being
> aware that this stripe is no more redundant and so administrator cannot
> do anything to fix it.
>
>> As least btrfs won't do any writeback to the same vertical stripe at al=
l.
>>
>> Case 1.2): P(D1+D2) reached disk, D2 doesn't
>> The same as case 1.1).
>>
>> Case 1.3): Neither D2 nor P(D1+D2) reached disk
>>
>> It's the same as case 1.0, even missing D1 is fine to recover.
>>
>>
>> So if you believe powerloss + missing device counts as a single device
>> missing, and it doesn't break the tolerance of RAID5, then you can coun=
t
>> this as a "write-hole".
>>
>> But to me, this is not a single error, but two error (write failure +
>> missing device), beyond the tolerance of RAID5.
>>
>> Thanks,
>> Qu
>


