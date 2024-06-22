Return-Path: <linux-btrfs+bounces-5902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC89132E7
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jun 2024 11:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B741F2258F
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jun 2024 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B014D432;
	Sat, 22 Jun 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jo/B0WF6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32CE14C5BF
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Jun 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719049283; cv=none; b=tWurGlCjssxBqWvXQm37WKwu75TXDM3z3EMygptxRg0s9oRr4ZBRak6mJ1UlDyBQMHRbJt+20l5ZK7G3nza4cNAQHQYtX+K7x1mQe7kdu+/4UhAaPfF27x4/dACL/w8DSR/FV1Is9uzZBEgWDfk9I02dLxeAR2jaJcmbCUwoigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719049283; c=relaxed/simple;
	bh=EBQ1rseLhnCWmv/CGuvG4ZSdCl4U82aYxt4C/4+rH5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y4hKGAiwqBPA3l1kH7RQvmkayl8tyhzv54gNm3lVriIfbrqjZYuTmvYo+hKGAHYbTw4gqWMXz98NO6J3d+4ESh6y+LcflmsTLNQ93uLysPWsKpMkhC6PzpP3xYdyEFXDtdB52/HkCYy5PGHtUc/q28iL+00GZ2l56U2cborgrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jo/B0WF6; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719049278; x=1719654078; i=quwenruo.btrfs@gmx.com;
	bh=EBQ1rseLhnCWmv/CGuvG4ZSdCl4U82aYxt4C/4+rH5o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jo/B0WF6XpNXC4PAthiMAGnnodNFhXsqpEpuRvrsRD+6lkW+kwv0fBH0zvi84RUp
	 /8FSS6XiFtJ7Bm1XudCgCJyuTRZSH8iNMLWP/oRtzbIvr/oIdHwYQVu40EKVOHj/n
	 l9Dc+r1R+HgeLiGDwO8UrzHJORIP3jOTe3un+2c0j23jIyC7meEONAP/fadz+KhTd
	 /YmK0Ji8hekroR1/i5rQQlAtqkHMf4K0/YlfHKmg0jP9Gs/spaaZELjcusJL6HKZ6
	 4rZPV1mwJwq/He1qLnXWuKdc/5XVsSIF1jzjOZcVuJMNt4ORrQSuZsJ4N7VeFXin/
	 1mbovtmtmhzInc0kYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QS2-1sGXOP1nou-006Gnn; Sat, 22
 Jun 2024 11:41:18 +0200
Message-ID: <08774378-624a-4586-9f24-c108f1ffeebb@gmx.com>
Date: Sat, 22 Jun 2024 19:11:14 +0930
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
In-Reply-To: <ae6aab7d-029d-4e33-ace7-e8f0b0a2fa36@bouton.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E05HfAHLoHefQmZ35JuHoBJ9ynHrub/Y4r75kj7HEad9LobIuZm
 zn+Dxfytmq+INeAr0NDavA0NdwI/QsCC3QyrYZCObWEExlWfhu3bxh05AwQeFRTwoG5+75V
 GfuuNFYijXUAyU4FN34ATXlrX2NSSsaPqp9XLc0GVHxI7lp0CHIuWKRzgLgQfOt1M5V7tYJ
 /XEEygZIZV/Ix4ULM1yJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Uy9PadGT1pw=;d+L1nhJw3banVEIvH/LmF5n9wN0
 CJN4n5EARMLUO3+3qWxiLFQRZqmVotToXieOsYIuMOW140rSn1u2BpX9SAnQF78FVHjJ6A193
 V9tLoluQWOddoWEZo9GVChOZCw5E6m4U3YucDcKXlT9Ldli9Y+GK7fLrJF6xfuwz3rUJRwHVC
 Jb1coYDOf4xN8b43pcantM6ysWWa78p308a+OcK9d1IW2BF7b4IUB3SsA3rZSa1ZW10cC6iQv
 jWA1pLyD9VPKNbhu/r5ViGEwQZ0A7idSAwzoE/gyw6JfzA4eUWGs7V7kVcWvBbUBvy7MqfjxD
 GjQOZxCRHVsfF0S8y5692PdsOQ+KI6ZsLnFiYazcX6oBc8SnMLYKnO+VFcWIL8eAitLxwgWKn
 /ycI1+qx2DfV74KiRaytQOj8W0Z8rfHa0B6ZDNu1OCTZF2aNoEIQ0NgP7mDZ77NaF1I5DQImd
 b1mAtJGxS2jaFDiRYW7s7uYP2Ffhsi5NHv2yy5J4KBBbLuPaffMlK4NwUSIXO+6evFHpKzWwo
 0HDWUDkZFJuUYOXYqq2iuVDyKrizAy3kJhkFb2+lx08RVoE9CFdTbVmfX3CYG9bBTuy04u9+6
 1zz5rAMs5RVTUey72jj0juIj8RuDp3J7R/AyC5fE+IdYsyiWPx5WxJKusfD4cDRHZXAjv5GJ6
 9GyeL4EMMCqh8t+gQSuLNIXM2B0eZPzzpC/Cx4DWp0H8hMVOCtT8WPdJuekWSSskB3MNcmver
 d0bpyLhCFdvbCGpuJLOn6Au1csKGJX5dvECBa64qliYWzEXRftCgGdiAs+8w2udM1ocgHgAh8
 n9FkHASr4qCvZkywLumzVqrOrf4efQPmRwc9aa7TpsoH0=



=E5=9C=A8 2024/6/22 18:21, Lionel Bouton =E5=86=99=E9=81=93:
[...]
>>
>> I'll mount the filesystem and run a scrub again to see if I can
>> reproduce the problem. It should be noticeably quicker, we made
>> updates to the Ceph cluster and should get approximately 2x the I/O
>> bandwidth.
>> I plan to keep the disk snapshot for at least several weeks so if you
>> want to test something else just say so.
>
>
> The scrub is finished, here are the results :
>
> UUID: 61e86d80-d6e4-4f9e-a312-885194c5e690
> Scrub started:=C2=A0=C2=A0=C2=A0 Wed Jun 19 00:01:59 2024
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fini=
shed
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 81:04:21
> Total to scrub:=C2=A0=C2=A0 18.83TiB
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 67.67MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 no errors found
>
> So the scrub error isn't deterministic. I'll shut down the test VM for
> now and keep the disk snapshot it uses for at least a couple of week if
> it is needed for further tests.
> The original filesystem is scrubbed monthly, I'll reply to this message
> if another error shows up.

I briefly remembered that there was a bug related to scrub that can
report false alerts:

f546c4282673 ("btrfs: scrub: avoid use-after-free when chunk length is
not 64K aligned")

But that should be automatically backported, and in that case it should
have some errors like "unable to find chunk map" error messages in the
kernel log.

Otherwise, I have no extra clues.

Have you tried kernels like v6.8/6.9 and can you reproduce the bug in
those newer kernels?

Thanks,
Qu
>
>>
>> Best regards,
>> Lionel
>>
>>>
>>> If btrfs check reports error, and logical-resolve failed to locate the
>>> file and its position, it means the corruption is in bookend exntets.
>>>
>>> If btrfs check reports error and logical-resolve can locate the file a=
nd
>>> position, it's a different problem then.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> The stats output show that this file was not modified since its
>>>> creation
>>>> more than 6 years ago. This is what led me to report a bug in scrub.
>>>>
>>>>
>>>>>
>>>>>> - Some including the original subvolume have only logged 2
>>>>>> warnings and
>>>>>> one (root 151335) logged only one warning.
>>>>>> - All of the snapshots reported a warning for offset 20480.
>>>>>> - When several offsets are logged their order seems random.
>>>>>
>>>>> One problem of scrub is, it may ratelimit the output, thus we can no=
t
>>>>> just rely on dmesg to know the damage.
>>>>
>>>> I wondered about this: I've read other threads where ratelimiting is
>>>> mentioned but I was not sure if it could apply here. Thanks for
>>>> clarifying.
>>>>
>>>>>
>>>>>>
>>>>>> I'm attaching kernel logs beginning with the scrub start and
>>>>>> ending with
>>>>>> the last error. As of now there are no new errors/warnings even
>>>>>> though
>>>>>> the scrub is still ongoing, 15 hours after the last error. I didn't
>>>>>> clean the log frombalance logs linked to the same filesystem.
>>>>>>
>>>>>> Side-note for the curious or in the unlikely case it could be
>>>>>> linked to
>>>>>> the problem:
>>>>>> Historically this filesystem was mounted with ssd_spread without an=
y
>>>>>> issue (I guess several years ago it made sense to me reading the
>>>>>> documentation and given the IO latencies I saw on the Ceph
>>>>>> cluster). A
>>>>>> recent kernel filled the whole available space with nearly empty
>>>>>> block
>>>>>> groups which seemed to re-appear each time we mounted with
>>>>>> ssd_spread.
>>>>>> We switched to "ssd" since then and there is a mostly daily 90mn
>>>>>> balance
>>>>>> to reach back the previous stateprogressively (this is the reason
>>>>>> behind
>>>>>> the balance related logs). Having some space available for new bloc=
k
>>>>>> groups seems to be a good idea but additionally as we use Ceph
>>>>>> RBD, we
>>>>>> want it to be able to deallocate unused space: having many nearly
>>>>>> empty
>>>>>> block groups could waste resources (especially if the used space in
>>>>>> these groups is in <4MB continuous chunks which is the default RBD
>>>>>> object size).
>>>>>>
>>>>>>
>>>>>> More information :
>>>>>> The scrub is run monthly. This is the first time an error was ever
>>>>>> reported. The previous scrub was run successfully at the beginning =
of
>>>>>> May with a 6.6.13 kernel.
>>>>>>
>>>>>> There is a continuous defragmentation process running (it
>>>>>> processes the
>>>>>> whole filesystem slowly ignoring snapshots and defragments file by
>>>>>> file
>>>>>> based on a fragmentation estimation using filefrag -v). All
>>>>>> defragmentations are logged and I can confirm the file for which th=
is
>>>>>> error was reported was not defragmented for at least a year (I
>>>>>> checked
>>>>>> because I wanted to rule out a possible race condition between
>>>>>> defragmentation and scrub).
>>>>>
>>>>> I'm wondering if there is any direct IO conflicting with
>>>>> buffered/defrag IO.
>>>>>
>>>>> It's known that conflicting buffered/direct IO can lead to contents
>>>>> change halfway, and lead to btrfs csum mismatch.
>>>>> So far that's the only thing leading to known btrfs csum mismatch I
>>>>> can
>>>>> think of.
>>>>
>>>> But here it seems there isn't an actual mismatch as reading the file =
is
>>>> possible and gives the data which was written in it 6 years ago. Tthi=
s
>>>> seems an error in scrub (or a neutrino flipping a bit somewhere durin=
g
>>>> the scrub). The VM runs on a server with ECC RAM so it is unlikely
>>>> to be
>>>> a simple bitflip but when everything likely has been ruled out...
>>>>
>>>> Thanks for your feedback,
>>>> Lionel
>>>>
>>>>>
>>>>> But 6.x kernel should all log a warning message for it.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>>
>>>>>> In addition to the above, among the notable IO are :
>>>>>> - a moderately IO intensive PostgreSQL replication subscriber,
>>>>>> - ponctual large synchronisations using Syncthing,
>>>>>> - snapshot creations/removals occur approximately every 80
>>>>>> minutes. The
>>>>>> last snapshot operation was logged 31 minutes before the errors
>>>>>> (removal
>>>>>> occur asynchronously but where was no unusual load at this time tha=
t
>>>>>> could point to a particularly long snapshot cleanup process).
>>>>>>
>>>>>> To sum up, there are many processes accessing the filesystem but
>>>>>> historically it saw far higher IO load during scrubs than what was
>>>>>> occurring here.
>>>>>>
>>>>>>
>>>>>> Reproducing this might be difficult: the whole scrub can take a wee=
k
>>>>>> depending on load. That said I can easily prepare a kernel and/or n=
ew
>>>>>> btrfs-progs binaries to launch scrubs or other non-destructive
>>>>>> tasks the
>>>>>> week-end or at the end of the day (UTC+2 timezone).
>>>>>>
>>>>>> Best regards,
>>>>>>
>>>>>> Lionel Bouton
>>>>>
>>>>
>>
>
>

