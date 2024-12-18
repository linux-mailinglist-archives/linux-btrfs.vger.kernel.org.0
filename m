Return-Path: <linux-btrfs+bounces-10591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0371F9F6F51
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 22:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C0C189141D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 21:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547731FCD08;
	Wed, 18 Dec 2024 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="elnWO7RC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245A1FCCF8
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734556527; cv=none; b=G5kfr5rEMoVamCd1gy9Ef8+n0yPIC9Kt118Vs/tTVd9tjx2A2LWJwmfbzQwqc+0AFEO9H8J2b5D19fQuh9Vz9bxGsFlJak5d4zhTc/JE/jpizi1/I58MvCjgsONygp+8SnQigZXGam44XARc2bbhwIcXeCuT3L8tvQU1jwjiJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734556527; c=relaxed/simple;
	bh=4n1lJJ90r7dJTKsJNXzvjmcwMuQ0UhIZI53lykokI7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+nMureLzS6T40kpPRNXIGJP6VtdVyEfVLinPEZ+zWUy8R2xF8ci18mNf3xa+YCWvUYlj6xLqlRWdgkErCwg6MNc7Lh6BSRT5aa7fJwtVDi8hJce8OdqNqiufLzH8FDqmxYAfRpFg29+G1sexzcH/5+Vr5olUISBz8bEIOuC+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=elnWO7RC; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734556522; x=1735161322; i=quwenruo.btrfs@gmx.com;
	bh=4n1lJJ90r7dJTKsJNXzvjmcwMuQ0UhIZI53lykokI7s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=elnWO7RCYXBiuIJcizUtWLN+3gJl+J+bK8KO5wFc2Nx5bumuC8KF/t19aPodVDyv
	 Qk9tTGwrhUrfbYEGyy+Ay/HjsB7MdOcxCK5eEm2TguHpMZcil4g/5eI8dQsYRrooO
	 M0eCfO+JPg1SjQztLNPk+igtMvED6XZxz0ZdzyF8dtb8Y6iZGtRJ44/qR4yUSLgw5
	 X3HygQeXeyV/6yLYIXv9ca16BiGK8u1YhSk03NgFTfiBghe8U/19JWYzn6S03sg5a
	 9KCJ5Y3P2xfmjQ0tfHzd2BCG+txf+2aIZUyLG8S8vI8Qk7VY6BliMUBfaWSnS8BuH
	 f4Lju48SH9Lvru7YXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp5Q-1t5Kq6069s-00VevE; Wed, 18
 Dec 2024 22:15:22 +0100
Message-ID: <f441de5b-d132-4033-bcbf-a259531f4721@gmx.com>
Date: Thu, 19 Dec 2024 07:45:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] btrfs: migrate to "block size" to describe the
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1734514696.git.wqu@suse.com>
 <20241218183155.GE31418@twin.jikos.cz>
 <73f9e7d0-9954-4507-a48a-2759cf3a2f2f@suse.com>
 <20241218203601.GI31418@twin.jikos.cz>
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
In-Reply-To: <20241218203601.GI31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gBTnpWZz6AIh+PNp1a79/7SPyS6Zg10cKNI+nyhZiwmuCbzqyVa
 KHzJb/+Zjjxxaqj3sUygdXNJApayUjBVBSxjSNOVlgqEohuA7m0xNrVuPV+Fq+NgKC88eCR
 s+ynM88XNmh78lqSzbwfqRkE5bVtfq/2+hKE5qCXgxT2OysbzRJ5TVyjNbIX8wbjoW+tUCl
 f/SDmvROYjFS9AGLpRjuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nYWZc0AjUMM=;OsW/+IFkdAczH66rxbGYO1f8WU6
 fjK556egk0+EHokMIhXoLpwFeduc22Wyspq+wAmanacrRaCpVXEdRPhfHqQN1C4Xb3iZBhDG3
 MnJ2naZQNY2VyLvZYt0iOUyle087URu3mIuonssZ/Q3k0A4xuVrGCn2stqcsfIWki5w0TrzLP
 Zua3PxVDUyt0kU0TsivWwcWROjasxhZjQX3qhRtMHDVXgWleTeMdl6hfPtbYKl/WZ5vLI/t1I
 KcpYd9K2eD4wJG9QZstX4Hc8IZaaz64IQzPU5I9xmv30ZBASsn7G8om3IxhHZBzvEvqQN22Dt
 zrVGMLFxG7Sig9GdStbQyanXn3oyU3BXDUTyq+jSbIP4NWmwMg5Jiw8exZZCoErQArsNTHJsz
 zA1lgk6hxfBk8Hx/wpKBMpev9ryYMtL4c6Nle810puD0Hrbe1bQqugOIf/bhVROS4YWS+dCEN
 W/lnltKfTS5Si3aWv4YswYnpCtzBtULMtcazCvKLEKhyxKKNRQG3nAwNp2UAKeIK6471tj/AI
 KVe1flmpaPa484ZSmZsHDibDk6jNqME/CTQlp3VQVwSIZeZFh2up0DHVUWoDv4fAPuHUzn4OT
 8IJjy1pqwge4O1NTMqHNMBGCOvkfwFH5Dxr5I7hwZJ90Vs2m1Qlq6mpZFmEv98kIM5ByUOAMa
 A88zHTWzHrAxwDV0NeFQoQPvUZ1ZC6D9Ic0rk3P2pTs/sLo3XsQ6NAQTCLfNyu4dEV9eD2qv3
 ANVc1ja2zDl84uy+jOcOfp58whbpdImMVikUt+2eGVjZ82+Q0G52rJRakrF6FCfSohOWTfoN8
 9mBsyuSPGm8SEB93y6Hk4wYEFKc2sOlWmpe9D/L2iUp2taq7f3iU9lX+icBoToWRui+QMaBYp
 Eg9TDXO4ZoDrWLFWTlSYh23lhRl8a+C5fa0LCfcCsgKNvG/jBGIPyb//jRMniaPzMCaT4Lwzu
 R3uHZxwwdI1Hldp99cSe8O8lnlO2eGNPZ35qd6XJoiFkTR6etLvzH85HvNWi/QKjktkn8kBOC
 P9mNofOcp8mblqeEfKwSsBsbn/WgSlq70K+RHTxVLGkuHOKVDhMQ1bwld+Iz725MAS4djN68f
 Z4R48Lia9NFBojTYkqm3paQ6o1t+Wu



=E5=9C=A8 2024/12/19 07:06, David Sterba =E5=86=99=E9=81=93:
> On Thu, Dec 19, 2024 at 06:43:38AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/12/19 05:01, David Sterba =E5=86=99=E9=81=93:
>>> On Wed, Dec 18, 2024 at 08:11:16PM +1030, Qu Wenruo wrote:
>>>> [IMPEMENTATION]
>>>> To reduce the confusion, this patchset will do such a huge migration =
in
>>>> different steps:
>>>
>>> With some many changes everywhere this is going to make backports even
>>> more tedious. I think it would be best to do the conversion gradually =
or
>>> selectively to code that does not change so often. As you've split it =
to
>>> files we can first pick a few obvious ones (like file-item.c) or gathe=
r
>>> stats from stable.git.
>>
>> For the backports, we can put the btrfs_fs_info union to older kernels
>> and call it a day without the remaining part.
>>
>> So that both newer and older terminology can co-exist without any confl=
icts.
>>
>> Although backport conflicts will still happen in the context.
>
> This is what I'm concerned about. If patches don't apply cleanly they're
> rejected from the automated stable workflow and have to be handled
> manually.
>
>>> A quick and rough estimate for all 6.x.y releases counting file
>>> backports in the individual patches in the list below. This is period =
of
>>> 2 years, 104 weeks (roughly matching number of releases). So if there
>>> are 88 patches touching inode.c that's quite likely a conflict in ever=
y
>>> backport.
>>>
>>> This should be also correlated agains number of 'sectorsize' per file,
>>> so it many not be that bad, for example in ioctl.c there are only 4
>>> occurences so that's fine. The point is we can't do the renames withou=
t
>>> some sensibility and respect to backports.
>>
>> But at least, when a backport fails, we can easily fix the conflict.
>> It will always be sectorsize -> blocksize, either in the context or the
>> modified lines.
>
> Easily yes, but multiply that by number of failed patches and number of
> stable trees to backport. This takes time and currently the upstream
> backports are best-effort only, not all patches that fail to apply get
> manually backported. Enough that there are CVEs of everything and we
> have to care about them at $job so I'm not going to create more problems
> with backports than we already have just to fix a naming inconvenience.
>

But I have to argue, that will only leave the problem untouched forever
(even if it's just a naming scheme problem).

Yes, it will cause backport problems, but as you also mentioned, the
frequency should not be that high (ssunless it's scrub/raid56).

With the compatible union, it should further reduce the conflict chance.

We have leave the naming problem untouched for over a decade, I think
it's time to finish it once for all.

And I'm pretty happy to handle the backports if it's just the renaming
causing the conflicts.


I also thought about the more progressive solution, just put the union
into all involved structures, and call it a day with future usage
migrated to blocksize.

But it's really no different than the current one backport wise, every
time a sectorsize is changed to blocksize, future backport will be affecte=
d.

It's just changing the short huge pain into a long small pain, the
amount of pain is not changed. And there will be a way longer window
where we have mixed terminology, causing more chaos and confusion.


Thus I recommend to take this chance to solve our long existing
problems. Or it will really never be fixed.

Thanks,
Qu

