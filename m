Return-Path: <linux-btrfs+bounces-10586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB769F6ECC
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 21:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E716A9EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 20:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9031C1FC109;
	Wed, 18 Dec 2024 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="h48Du321"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB0157E82;
	Wed, 18 Dec 2024 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734553160; cv=none; b=tH/bDpOpTFuPpFaXDImqu78+cmGjOrTkeLJ8W6L5rYeIET/z/4AaIgFSVfWbGJLt3V5DqPspW5VCXhlYaxcdIZrjDg919Yfs/jCwWjHi5k45fWmlAl4c/zLMgBERIxg7Ms+t105NynjIBae496lCPk09T5xY55e4dF97f7a1ep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734553160; c=relaxed/simple;
	bh=6jwd0ipT3oGGRW7xVGzjO+Hg4MOfpzOO2Z2fOkqER9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFFJlwDyX65YiVT/WC1O6vCoCYp6G5cJpZL4cb+Ik23zdbCgVlzgR49fUCwTsewIfk41byEMcCjkT5NZ7jxbLFnhMT5TfyCg/mX6TSJKS7c0YhUcFyaZSGGQlJhKo0wIUDX8UdJ2pbnPa7j44k0d4p0T4TG5WBb8ZwSOZxo9YLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=h48Du321; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734553146; x=1735157946; i=quwenruo.btrfs@gmx.com;
	bh=od5URkdEfhynodlyffApnC2vsLZ2WCQHzDkven0hFU8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h48Du321aNj7ai/kg3B21JzOLkOmcJmqgSpH2Mf5dombg8TOOJ49S9BL17Rjk1yD
	 4C14XN+C9FPVKprK7jbM8hW9ECyTZHG4X9C28Mtej1nb7jH68k9Z/D/PZQF8BSu+i
	 3Lp3LaczdGraKbglueyTIZp/y/ypamlTPMgmc7Kb4l/0ZakIfgYljNu4m8O+lUGZ7
	 2KLmDtmQ7EXmqPRXtmZFcGaZ3uMV/4+6iaZZpUDywPOGHyMKChLDPHEuYmtata8CH
	 puCp3sfB8RqIhnEbQOzk312XStINkUAN3aPaKM1z8P8QtVdvJpd7xDLVccV7870Rd
	 qRS3/YhVjnHIo7ySdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZktj-1t2KVy1thv-00X2fu; Wed, 18
 Dec 2024 21:19:06 +0100
Message-ID: <d4c1334e-0275-453c-bdea-7878dc8c56f1@gmx.com>
Date: Thu, 19 Dec 2024 06:49:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test swap activation on file that used to have
 clones
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Filipe Manana <fdmanana@kernel.org>, Christoph Hellwig
 <hch@infradead.org>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>
References: <dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com>
 <Z2Ey4yQywOEYqEOI@infradead.org>
 <CAL3q7H4Age-k0ifGh+n4QwExC1vTgWGd3NROcX40vQXKRipBqw@mail.gmail.com>
 <20241217172223.GA6160@frogsfrogsfrogs>
 <db59d0b2-6542-41e1-abf7-0c38b91cdf4d@gmx.com>
 <20241218200927.GC6160@frogsfrogsfrogs>
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
In-Reply-To: <20241218200927.GC6160@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SHfukfyfSpb+WrjRfNzj6CUgLb+ybRxVY6UkIo8jHztQM3wx8IL
 p/4Ci7j+s+gcROmhMtd9UgU3uFIAPp/OtaCQd0hmZi973HqJubbNC089yd63D4y5ncR9vkr
 snAHHmsxntIAlZ9HoT0dP/F5ndEFE0cU3pKv9HDCbdCUgAXp9jNh2Ht4YFPWKWvpg6DpGIV
 JKlIkjQNCnqfAgwVuOhqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UsgGzmInNGw=;mVkLnMbN/0r73SZyr4qFZQZ1XUh
 1GgRzerrxxVdcMab0IvCcT9a46FoIjKI+Kcj1gX3CgyJdK4AmQcwbwK21MKVVgucJlrZZzI5Y
 SY8NeAnyL3yxFDO/bWpsetW4FsbeX+cbLw5H7gu+yQBZBmxUeDJS/jorb6DM6PIG5NBGk+CJh
 KMZlwU8yCuZYGIdBOUP2dODaQ/k7DwqGtzAAKhVrY7jale7yDDlNBDPLHGzBDA1cOf0vi8Ha0
 ThTqc/eVnXgRN+va+FJE53gEAKUTmIWj8LbqM1R7MeOVvtNMSo00NoRja/ddj592bSUAPmW0L
 2f3o4d9J8QaTC8z958rU2KYVZeXklAHYPm2NQYXwrqekGlxscAoXwyvUFgcEuskRC0e6wXEoz
 oZuUpb4w2ayU3ELXEBxhqq6Tb70IHl9txlP1dja8moChE1cjFrPWZHfHIszlP3NQ0tY35JbKY
 zl5fm+Crsg5wsa2gLLP+/YPF10FaMa7TIyiOuYn9JvQtZksRAnplPG9JwGn3ia8EpxxR8QScP
 0oZRHKTtdORhsw+YWEJaJIWJIGkNAHC3hlh10pmy2BQystohYSaXS08BaGtHQPsXfwfuRsGWZ
 oHob0ce10xR19G3w6KmFESBH9PlAsuQmjbxfsiDj1sq27aoVaWl6meZrf5SRStOlNBcZ3nIYS
 Xjc2hoZMPrPo/ZTVfADqc1c5aBpkShmhh6ICEt9D89GBsbMuy6Jrm1dO0B0VRPXYo+CWU6fQN
 tNsjdcvIVY4P4v0z7Z4Yf/bDT1Yt3lr4TMKaLAEJub27AMTWN7R6wv4R6s7YnurVIIzaBh8vr
 bu7RomYh8PRP+Z8zQprjxFIJcOdjFwLrASPnc7i36dokmyesXSg/D7qzpe9vVFXu0B3UvwtSe
 FgkKVpTcd5RTXXXyZ6/q5XfZ3qm0KrIFRSfpQBw0oHNEvH/Bef6HU6aztYNGrbYN96wF9AV+k
 8o/zjYTfqVl2CbUXye//wgUioqS8Lp1kKvtHZF7DhaQmR1bqnOiRbbCwQ+MQUDwM7DHMBeEq+
 O8A+94Nr8AhLGXVLLrmqWr8J1tZqTaS+Q+2wu3e1NJ5Mw1zoKqjchWQwzo15LTGn+F8IggwgF
 Afv+4WnG7CaVPIRfGLF3ZPfAfvq5GR



=E5=9C=A8 2024/12/19 06:39, Darrick J. Wong =E5=86=99=E9=81=93:
> On Wed, Dec 18, 2024 at 09:07:26AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/12/18 03:52, Darrick J. Wong =E5=86=99=E9=81=93:
>>> On Tue, Dec 17, 2024 at 08:26:33AM +0000, Filipe Manana wrote:
>>>> On Tue, Dec 17, 2024 at 8:14=E2=80=AFAM Christoph Hellwig <hch@infrad=
ead.org> wrote:
>>>>>
>>>>> On Wed, Dec 11, 2024 at 03:09:40PM +0000, fdmanana@kernel.org wrote:
>>>>>> The test also fails sporadically on xfs and the bug was already rep=
orted
>>>>>> to the xfs mailing list:
>>>>>>
>>>>>>      https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=3D=
xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
>>>>>>
>>>>>
>>>>> This version still doesn't seem to have the fs freeze/unfreeze that =
Darrick
>>>>> asked for in that thread.
>>>>
>>>> I don't get it, what's the freeze/unfreeze for? Where should they be =
placed?
>>>> Is it some way to get around the bug on xfs?
>>>
>>> freeze kicks the background inode gc thread so that the unlinked clone=
s
>>> actually get freed before the swapon call.  A less bighammer idea migh=
t
>>> be to call XFS_IOC_FREE_EOFBLOCKS which also kicks the garbage
>>> collectors.
>>
>> I'm wondering why this GC things can not be done inside XFS' swapon cal=
l?
>>
>> So that we don't need some per-fs workaround in a generic test case.
>
> I suppose one could call xfs_inodegc_flush from within swapon with the
> swap file's i_rwsem held, but now we're blocking swapon while we wait
> for some unbounded number of probably unrelated unlinked inodes to be
> freed on the off chance that one of them shared blocks.
>
> A better answer might be to run FALLOC_FL_UNSHARE on the file, but now
> we're making swapon more complex and potentially issuing a lot of IO to
> make that happen.  If you can convince the fsdevel/mm folks that swapon
> is supposed to try to correct things it doesn't like in the file mapping
> (instead of returning EINVAL or whatever it does now) then we could add
> that to the syscall definition.

Sorry that I'm no familiar with XFS to provide any help, but the swapon
call on btrfs is already very complex.

It needs to verify every extent of that file is not shared, and block
the subvolume from being snapshotted.
(The extent shareness check iteslf may already cause quite some IO)

So at least to me, a little more extra logic and IO shouldn't be a huge
blockage, since we're already doing exactly that since the btrfs
swapfile support.

Thanks,
Qu
>
> --D
>
>> Thanks,
>> Qu
>>>
>>> --D
>>>
>>
>>
>


