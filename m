Return-Path: <linux-btrfs+bounces-2447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF168572D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 01:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FAB0B21EE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 00:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3E2FC01;
	Fri, 16 Feb 2024 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jM8E9rkM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D3EED4
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044576; cv=none; b=ojGLpwy59wkOj7Nfneo59TEotEvKZE0XqbONzLlJd2WwDE/k4HkV8kkKLGB2/alggeXpmYTzL/tyOBAYTKm7jGP/63WlXoJpJ7/WkQS63hguR2BjRG/qrxjDGX1K0uhE6jb1T9D5csrkQgaHQIr8PvFAA+qhvhdiRJe5uFa/yCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044576; c=relaxed/simple;
	bh=Dy0d0F5IhjbcqQegeJzRtRaFe+z5kR58ayg3wtqcXpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOgDIV0saZDtQxb7J/GYFr6uOTLfHWprw3+bJuFikahrCfT/6JKDl2DdnuC2zE2nvdvEDDHkXl4Rug7uinxK7XoucbOmlstZ3DzhM8lLCsvsLBc1dcyTdr+ORyGV/JeOrk6xHmc6h6cL6fuvouq1UXx4nO70ltyV9/PYWy61DB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jM8E9rkM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708044563; x=1708649363; i=quwenruo.btrfs@gmx.com;
	bh=Dy0d0F5IhjbcqQegeJzRtRaFe+z5kR58ayg3wtqcXpI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=jM8E9rkMWAj1yQjXqE9xyCFs75RXnDvxlZXxkPa5VwMaxTHlT7lnqgp5eOQzDjj5
	 xAp6Y/IUqCYFw60PIIIMchphMWfE+WPFufaIV8/fVeWEiSzxMsIjJYOJ5mdVHrPu8
	 KkdVEeU0+ZcIJeJUpWy3/ARp+2roHdb9b9G81Hvodn4GdJXEldV2enThSSY1kSBqq
	 yxAtrIdIwI8h0MT/MDBE5GsOJWdFhTwPkUgRmJDcDRr+DCh2ce86Bjijjz6IB5MSP
	 ssrDhzoeqPMISWZJECdrMwetWhUGuVRY39KJDExA9GurT9jnqJfy+9f07pLXloNmf
	 xbvvk5Y4WN+bPnaulQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf0U-1r9f8q2OYM-00ioYv; Fri, 16
 Feb 2024 01:49:23 +0100
Message-ID: <ae41aadd-d4bf-4cb7-9b53-2e44ceeff6b2@gmx.com>
Date: Fri, 16 Feb 2024 11:19:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mounting causes errors after power loss
Content-Language: en-US
To: Kyle Smith <mr.kyle.smith@gmail.com>, fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <CAKb79g0cM38YmV7rqeoC1EpO9vU856Y8LH2Kh7zxT5frDFfZDA@mail.gmail.com>
 <d66eab3e-d6b7-466a-82e5-c153ed49ce9a@gmx.com>
 <CAKb79g1KrW2KVdZkThu6X26wMKTyErq-eT+r555H4kXCTGDa1w@mail.gmail.com>
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
In-Reply-To: <CAKb79g1KrW2KVdZkThu6X26wMKTyErq-eT+r555H4kXCTGDa1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IV4zjnV4aEpzSwJPG9FZRNYxKLWpyS4Yde3yupKxzOQZuTHiMwn
 7nqk1IyxBgWacMWPrmQIKauV9YOR/4yFVkeyI3uF5PB2MTF+LQMmolNl8d98W3xNd0zmwV8
 pWSseCNne6zZgjhBCx0oRZK8z3KiWtAwDmcBRT6RC5lmIfbEdqGtfVUduJmq59gV3R4ez9l
 i4So3XjEd/rczzXkJmzcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o8WlaD/bp+Q=;tqFm1V9YGu9vxXnD/9K6dycTGd8
 K8gMQUa7FOJqqj/Ishl4+D3lXYq/4Fin1QinUbznqgp57IU7+q83s/9l8zhwzdz6X76U3Deqc
 gFZxoZVk3wPbzgAaiqEDDTl9CLYEsuGp2ay7nkNMPB8K+myqXgDUFWKwaVXm+JbltQ3MdsvPe
 Sf9GIwq5GUNfXZc6TKfgLDG+3YfAOFxiL9wf0Gf/voIFpR0RvjY6vb7DngXUy2WAgV3daVUZZ
 oEcYdxuRCzRD/H7On3rEzJsr5vv92tM2wmzuuxlXg/VQzBQZgRdFyJHHjEPwKMVgA7tO0Ksfh
 C8KZRxxfNIHPPm5eun//pROFWrGa+hxxeYBCXRFIJ3OhuICFsYf1xCcc223j3Pj+PKAdfh6HG
 ZQdWd7Mt2qOxlVhRPiTFsW12JRAPCk1K5zYRS4DTbXvwqhJkIaAjPh3Vf9st4sAEEKsGhWOKP
 bl+dTiwI/HtVcsA1Nwzvadk320NRQEEvBWh3uKCbRZmJTGK8t1rnkDm/hMNCF+L/OhhZQYOto
 rTGZs2eaLFRPOgst577RrWJR+7fNUn/cPLlJwsEvGm9ZOJEOAst8gAeFfHUzSjrp1cDCU07zw
 Wbo8LIPj+ZPDKCJcPbgjAXRmQd5XxJp46jmauObHl0Fxpzo2q3e3uv+ZWuJxomFeFxsuoGEqS
 VYSfdYe3GzkIyPpnZyFd6HGjz+0x/Ab9AqfJOZfIHrL3zmlBGemdEHFAZKgdciLEX15vK9+YC
 SKupfiVV1R8eDv0VvYHJCAZq5etxvq4ofqwAKTiiFQd/1JUou9V549CAJlFRUohKn1fEyOm9L
 fgo+726SfDyt+Jle2WRpR4YHeWNXMSGtja//7aYzgH4xk=



=E5=9C=A8 2024/2/16 10:51, Kyle Smith =E5=86=99=E9=81=93:
> On Thu, Feb 15, 2024 at 3:23=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
[...]
>>
>> Those are all fixable by the latest btrfs-progs, so no big deal.
>>
>> Furthermore, this is not caused by some powerloss, but more like some
>> older btrfs bugs.
>> Or sometimes even memory bitflips (this need extra debugging to confirm=
).
>>
>> By all means, it's recommended to use kernel newer than v5.11 at least
>> (thus recommended to go at least 5.15).
>
> I'm currently using OpenWrt 22.03.5 which uses the 5.10 kernel, and I
> am eventually going to move to OpenWrt 23.05 with the 5.15 kernel. In
> the meantime, are there any btrfs patches that I should backport to
> the 5.10 kernel?

I don't think so, unless you want to backport all the tree-checker code
to the 5.10 kernel.

> Is there any problem upgrading the kernel from 5.10
> to 5.15 while btrfs has these errors?

Still hard to say. See my reply about the dump below.

> Would upgrading alone be enough
> to fix these errors or is a "btrfs check --repair" required?

=2D-repair is required. It's already a corruption on disk.

>
> OpenWrt also provides btrfs-progs 6.0.1. Is this version new enough to
> safely and reliably fix these errors? "btrfs check --repair" has been
> successful everytime.

I believe it's should be fine.

>
> Please provide the debug steps to check for memory bitflips. The
> system has been very stable so while I don't think this is a memory
> issue it would be good to rule it out.

If it's x86_64 based, you can try some UEFI payload like memtest86+.

If not, you can go memtester program.

>
[...]
>>
>> Unfortunately the dump is not enough to confirm anything.
>>
>> Please try the following ones:
>>
>> # btrfs ins dump-tree -t /dev/mapper/luks-part | grep -A5 "(27535265
>> DIR_INDEX 55000957)"
>>
>> # btrfs ins dump-tree -t /dev/mapper/luks-part | grep -A5 "(27535266
>> DIR_INDEX 55000959)"
>>
>> After the direct match, there would be a line like:
>>
>>          location key (XXXX INODE_ITEM 0) type XXX
>>
>> Use that key to do such search again.
>
> I wasn't able to find the  "(27535265 DIR_INDEX 55000957)" or
> "(27535266 DIR_INDEX 55000959)"  strings in the dump. Here are the
> lines matching any of those values. I get the same output with "-t 5"
> or just removing the option. "-t" alone was throwing an error.
>
> # btrfs ins dump-tree /dev/mapper/luks-part | grep -A3 -E
> "27535265|55000957|27535266|55000959"
>      item 61 key (256 DIR_INDEX 55000957) itemoff 13638 itemsize 45
>          location key (27535265 INODE_ITEM 0) type FILE
>          transid 17119099 data_len 0 name_len 15
>          name: .sharedContents
>      item 62 key (256 DIR_INDEX 55000959) itemoff 13593 itemsize 45
>          location key (27535266 INODE_ITEM 0) type FILE
>          transid 17119099 data_len 0 name_len 15
>          name: .sharedContents
>      item 63 key (256 DIR_INDEX 55415388) itemoff 13545 itemsize 48

So it really means the inode 27535265 and 27535266 are gone.

It may be something related to the transaction split in older kernels,
as the deletion of the inode item and those dir items should be in the
same transaction.

But it's pretty old kernel, thus I'm not sure if it's possible to pin
down the fix/offending commit.

In that case, no obvious memory biflip.
But since the damage is already done, a --repair is required.
>
> I see these two "location key" lines but no new key values to search
> for. Should I be looking for something else?
>
>          location key (27535265 INODE_ITEM 0) type FILE
>          location key (27535266 INODE_ITEM 0) type FILE

Considering that's the only error, it should really be those two inode
items missing.
Or it means the dir index are not properly deleted.

[...]
>>
>> For your case, it's completely unrelated, but I'd like more dump to mak=
e
>> sure it's not some weird memory bitflip.
>
> This is good to know. Can I rule out the lower LUKS layer and the disk
> firmware since I'm not seeing a transid mismatch? These btrfs errors
> are the only problems I've had with LUKS2 on eMMC.

The problem is, you can only find out if it's something wrong with flush
when you already hit a transid error.

So forget flush related problem for now.

>
> Please let me know about backporting any relevant btrfs patches or
> debugging a possible memory bitflip.

I don't have any good idea on how this happened.

Adding Filipe and he may be aware of which commit is the cause/fix.

Thanks,
Qu

>
> Thank you for your quick help.
>
>
> Kyle
>
>> Thanks,
>> Qu
>>
>>>
>>>
>>> Thank you,
>>> Kyle
>>>
>>> [0]: https://lore.kernel.org/linux-btrfs/CA+XNQ=3DixcfB1_CXHf5azsB4gX8=
7vvdmei+fxv5dj4K_4=3DH1=3Dag@mail.gmail.com/
>>>

