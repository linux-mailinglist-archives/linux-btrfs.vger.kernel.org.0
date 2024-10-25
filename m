Return-Path: <linux-btrfs+bounces-9180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F6E9B1119
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 23:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEFB1C20B78
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 21:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E982161FC;
	Fri, 25 Oct 2024 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lT59QQ4Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A761215C7A
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889832; cv=none; b=OPYiP8s0x2wg5AUuevwBiwbpeUZWqrn/3yLkSdUJonaVCpVNXZw0v9eLZ3p7rNOIgZZcRZMHvwKSaAfgatB+3JBgGj6sxO5cjF6kWJaKtKWl6gHNx9rcLo+gS8OKbyyoThGtzPn9IEfT1uZ+Ua5vOdDsvSVpUUZfrp0TcmxgcU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889832; c=relaxed/simple;
	bh=LRk+3yN9C6lTb/1lg9icn+0djmwj1PzRpN3+ttSqqtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjfwCdgCNv56GZ1x13bzdM/6vvRReoxqRblTjoZGj35iK/ZM59LzVRy94PixCw9jauVWYqTcm+lrAnW3cadZAcqG1BUCZZwQ/wkiEv8QXLhKR9TtL1vMQRgzLwSWwgSZaoCH+dn+BHsFW7RUXhcgTS/2SODytvVfo42P0LWhpsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lT59QQ4Y; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729889826; x=1730494626; i=quwenruo.btrfs@gmx.com;
	bh=mlOD1uB7ht4Urb1kbGab0C6TTDFhP9C6TQ7Rl2A4Xpo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lT59QQ4Y6kpSjDByp6xQWW1LHNd1is4EETxy1w3ny7kCoWCqo67amH/nXKoYk0km
	 3Bv/K7PCWYmAikOdK6VCwC7p9i8tmGd1xoe3u62PkA8XwEatHUhMAUqNuT6HAPJ3b
	 Hn26/9v2SjmoJvku9uC+CXW3EMTco+mz8LQBuPSnCCeFl7BNLlgMATgwXEUaOxg3O
	 qc7S9Gmd5d4MmPC6SAMFcA0zyXnRe9oe6DI4JI5ALsjX/ON21Yz7eqLr9V0JvEHAh
	 JY8jr3iMit8R+G/HnISe9tROwE69M+sRqXwnQh0mXXA/qgiJXjkFOUaU9uuXBKSyK
	 USnNDuJS6LgBS6NtUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUGe1-1tVlXm1kZv-00Z4Qh; Fri, 25
 Oct 2024 22:57:05 +0200
Message-ID: <9f395072-1a01-4cac-9332-cd7a7f6042a5@gmx.com>
Date: Sat, 26 Oct 2024 07:27:02 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix mount failure due to remount races
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 Enno Gotthold <egotthold@suse.com>, Fabian Vogt <fvogt@suse.com>
References: <a682e48c161eece38f8d803103068fed5959537d.1729665365.git.wqu@suse.com>
 <20241023163237.GD31418@twin.jikos.cz>
 <08e45ca0-5ed9-4684-940f-1e956a936628@gmx.com>
 <20241025190221.GM31418@twin.jikos.cz>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20241025190221.GM31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FXlW4j5DGMlU4rcF2YSkEFpV5lph7BaKyfFnpvmpwFvr4bg2M5a
 OZwVEIVKTdsjIDb//bCDAZ/bhtzMIo5bKAKFrUIa+XFsYCWY9eOsmbHcDsND7UrZx2M0qSa
 V7ym7HCV22vN+9HAJL5rDBxgSVt5EZYnhxRuERYcWTz9lqOtCD4N1rYw8oHnkVn/wTTHmDy
 66SPOedKfhnhsE4V43I8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MmGrvfz8RGU=;l9WTmbT8Q9tvcskDSvLtUrYEX0T
 h7FvG7DM5XNrlHaRenSzzgOwpOlFWcne4lUWI0J9hcyX7V2SIw7pe0xXsmr+kX7qlb2GDCjWr
 hA5DE3Q9F+C4Viy3rUwThPjpe5dLgDpOHys7HHwyYbeVMt54nifYwm0T4CCIJNC/ig7tQu0kw
 ESXlE3rUACHMjIv8hseL0yebIu3i07xUd49JzrVls832iJHk6y6xP4U39kgm+7w1hG/jxf8/G
 Jj/d3tMutW95O2UJAZSyAMeHdDaaRgiuDcHacRcCXQ4aX865bxjUzppgJTZQeH7q3m/M4wa+z
 PXhQUlmln8vH79Uv7P/IU592Z+dLgoO0GtCNPq4MshHLV0OnZ4VB8ZT/G953Wrer06DluAdft
 p7ozXqCR0wWfkb+FEtdckzuS8y4QgnvZVF2EZLBz3vRYm//S7WalW4wYfLVa4ecF/dLzEKeyU
 g0TW/u4r+yuxG9M+LAdYB4xmBaY78ev6dCASBfawdkOQgJIZnOa3oVWJjkg+BXe69OOJEEAgM
 rmavv9ANWVVXUmKr3v+6b2/Fs7HQZ2EqrH+doqEhcIbG0ZLViHGjewc6sS6wRKQh3kcPNtvem
 +DNvpGJhIJXcnfFFfPqncrJeJHeZfqKSVsrn6w2QzYx+o09sDotGMLIbBrywNLUi5ooxlZCpw
 ay3zW/KoVZ+c8NK8nvMoxLNAsVMJsMELjXbDwefpPCgqpQhhewb9TRqaYQdWfFYDIFMZIJG9l
 +ulakr+7OTvWZOnDlHMphmldog43CEfbt9AZzm3mrJNCKkb2VlOPouKyoU80K9svnHTrOgYQd
 UxtyGD7Q0Xch39DnmYbiU5B3cQBTHqlfP0g6gbGc0ZCZI=



=E5=9C=A8 2024/10/26 05:32, David Sterba =E5=86=99=E9=81=93:
> On Thu, Oct 24, 2024 at 07:23:20AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/10/24 03:02, David Sterba =E5=86=99=E9=81=93:
>>> On Wed, Oct 23, 2024 at 05:08:51PM +1030, Qu Wenruo wrote:
>>>> +	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONL=
Y))
>>>> +		ret =3D btrfs_reconfigure(fc);
>>>
>>> This gives me a warning (gcc 13.3.0):
>>>
>>> fs/btrfs/super.c: In function =E2=80=98btrfs_reconfigure_for_mount=E2=
=80=99:
>>> fs/btrfs/super.c:2011:56: warning: suggest parentheses around =E2=80=
=98&&=E2=80=99 within =E2=80=98||=E2=80=99 [-Wparentheses]
>>>    2011 |         if (!fc->oldapi || !(fc->sb_flags & SB_RDONLY) && (m=
nt->mnt_sb->s_flags & SB_RDONLY))
>>>         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>>
>>>
>> Weird, my local patch/branch shows no fc->oldapi usage, thus no warning=
.
>>
>> The involved lines are:
>>
>> -	ret =3D btrfs_reconfigure(fc);
>> +	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY)=
)
>> +		ret =3D btrfs_reconfigure(fc);
>>
>> Thus no warning.
>
> This was caused on my side. The patch does not apply cleanly on for-next
> or my misc-next, I'm using wiggle to merge the changes and it for some
> reason always adds the fc->oldapi to the conditions. Please refresh the
> patch and resend, thanks.

I have already mentioned this has a dependency on the following patch:

https://lore.kernel.org/linux-btrfs/e1a70aa6dd0fc9ba6c7050a5befb3bd5b75a13=
77.1729664802.git.wqu@suse.com/

Furthermore that patch should have a higher priority, as it breaks the
very basic of subvolume RO/RW mount.

Thanks,
Qu


