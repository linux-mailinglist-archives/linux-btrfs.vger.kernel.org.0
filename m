Return-Path: <linux-btrfs+bounces-9218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3809B5839
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 01:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EC61C22E7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 00:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B68F5B;
	Wed, 30 Oct 2024 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QgTTSuyw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561263CB
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246907; cv=none; b=vEBw0lWzguynQRAbMP+hQP86ADqXNJgAtxhBXwGmSJcsDO/LKpKPETAhrH/wnDymQWZdvRBigma533a9UiguKsm1Yo1iOZ6V5+lTdPbF/27K6ZrJbIqnG7pcvP2ulzQGg76nTpISJfPmKainzcvpxmA4J/6h8MnUFuDWmzD6CVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246907; c=relaxed/simple;
	bh=qRKGyzPUo6/lHDKS3JtROdQx5xv+iOlMTofOo/WBxWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EM1YN65W/92opCii5cnpfVto9KmoO8WnUWcF36FZnHCqBzFPw5NfWlJNeJjElcU1LSg25thU/z745q9KclwCaHTUB5OCkh6BTtI92DL7iJus3c2GU+1+vFonHZC2z0YahIgGv+fQMYoFv2haW/XUCUzrlGAoIaUqthvx4/RZd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QgTTSuyw; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730246901; x=1730851701; i=quwenruo.btrfs@gmx.com;
	bh=78+gm2DF02Fa5YFpE+V80u7XXbBfXCNwnHVUN8HYTdU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QgTTSuywVyndj1z1VQb2tn+WjxlUHPIP+8ffLEwfQyM8PLJG/KkD2q3II9CVCA4C
	 c9Mx3IwNT+g1qAJBDp5eSPPO6KOIqBx9fMZG096MwVyAmXa4GB/iF/KkyWenEELb5
	 KIMWhvAM1ml9SMj81s3D922QSYcjZRUymzdW0AbbpVFJF8F+ISN3WGeBdMuO3Yld9
	 wI8z6qRvv50ksQiwgAGnzvlpTlRMOt2P+TmubQ0s2DMbyylbT1trsHVOMMUaNAONn
	 VgniNp8o7p68u0K4CKjnZr4YtiMH6/e7Z1dId4fG1sHA+SWHIGP2aRc6oRg3pF76Z
	 9rWGweERLGeqtSFL1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7zFZ-1tsd7P3qDL-011R4J; Wed, 30
 Oct 2024 01:08:21 +0100
Message-ID: <f7b5794c-821c-4f22-8bcc-40edc47e9ab4@gmx.com>
Date: Wed, 30 Oct 2024 10:38:17 +1030
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
 <9f395072-1a01-4cac-9332-cd7a7f6042a5@gmx.com>
 <20241029235951.GV31418@twin.jikos.cz>
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
In-Reply-To: <20241029235951.GV31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zCkFr16ka2av9hgARmK5avx98vZu0CRGOqQeoK1hGoeMvO59Qva
 +FzNucoWsWOEYtio/DbQNp+tsU8yEdP5wc0HSXDMeWVGDUubQL7Y6ILMTKvLPiTQpu3IRKg
 uh4Eq6UnBPnZSjOGwuVVBgIkuRPu/9jPmS5C8oy46dFWn+F70C7TjqzNqhs5NCoX0pf5mQV
 chdjiYchQHWhjMEI/xSqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EA7Q8pmIzAA=;vz2M9pNxctmb4MgDepNmr/5LVmN
 uJhut0n5vPOorJOjSTkWcSEjGAEtEhyt04Q1wjIkYBXiqS+HS2rwRw5I5mvRbOvRbX1HHOzqK
 LxAZLgTXcyuPt5m9jEYtNTQiVbeCyMCGHinWL+dOKXz6uZhfGnrlpQ2v3e0djefVBrX58/7pv
 xqJaud0tiotRYcQ/znnLOf1mAbCZA7ojlgeaGvuRfri8aSBxFH1sEgw33NAkB37y8WZCst5y8
 TP2QTK/N55r4IQxpdw7ShwZsPDR8pjd0UaIpWyvukURhyT3flc1xkPGgL4p6rNerM1jThtaZG
 FOE5qZoxk3j/VYo57B2/9AYUatLr8qcLshmLzhlpxsiY92ZVe0gPg5y8esGuT+cNnR2BYZarJ
 D/zYHjpVn9MpX8x0qU78XAVhGS0ptu9CGDppPGebs0Ux5HfVRXS6rS2MEfqjiRjcYPKGMY1dj
 UisuBdrnrJI21kM4LW6g6OmlbNJdny9YevBt6/3tqkg0/hOupGxfGUFKQgWr3xpmHwb37HLC3
 ing4jApwnZMjGMg6h0nDDbbN69tKQgv6m52IR/0wjwHPxpg/DScnWVHehr8PjQV365/a5CY8z
 57v/COF9V2/P4jJ4aqbA2TV6IoyHfqJ5U0W7t4Ec5fL3sookg1DN88ucAiTqlRkx80rgvq6D2
 qcwjHZJXHukc2bohYMBejlJb23b4TZqPuGNwsxwhZflvJeZ6h5dwel7rRQZN2C+mi5m+pTtn4
 repf5bpx/QQYq3yk9lU3nnBHGFzrHZLJ39HnMX/4V0NDA2+kG4iiN8RoXyG+eTNfosF8WtZGf
 TygK9KSAUCRo7PGQ+hfEB/vA==



=E5=9C=A8 2024/10/30 10:29, David Sterba =E5=86=99=E9=81=93:
> On Sat, Oct 26, 2024 at 07:27:02AM +1030, Qu Wenruo wrote:
>> =E5=9C=A8 2024/10/26 05:32, David Sterba =E5=86=99=E9=81=93:
>>> On Thu, Oct 24, 2024 at 07:23:20AM +1030, Qu Wenruo wrote:
>>>> =E5=9C=A8 2024/10/24 03:02, David Sterba =E5=86=99=E9=81=93:
>>>>> On Wed, Oct 23, 2024 at 05:08:51PM +1030, Qu Wenruo wrote:
>>>>>> +	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDO=
NLY))
>>>>>> +		ret =3D btrfs_reconfigure(fc);
>>>>>
>>>>> This gives me a warning (gcc 13.3.0):
>>>>>
>>>>> fs/btrfs/super.c: In function =E2=80=98btrfs_reconfigure_for_mount=
=E2=80=99:
>>>>> fs/btrfs/super.c:2011:56: warning: suggest parentheses around =E2=80=
=98&&=E2=80=99 within =E2=80=98||=E2=80=99 [-Wparentheses]
>>>>>     2011 |         if (!fc->oldapi || !(fc->sb_flags & SB_RDONLY) &&=
 (mnt->mnt_sb->s_flags & SB_RDONLY))
>>>>>          |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>> Weird, my local patch/branch shows no fc->oldapi usage, thus no warni=
ng.
>>>>
>>>> The involved lines are:
>>>>
>>>> -	ret =3D btrfs_reconfigure(fc);
>>>> +	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONL=
Y))
>>>> +		ret =3D btrfs_reconfigure(fc);
>>>>
>>>> Thus no warning.
>>>
>>> This was caused on my side. The patch does not apply cleanly on for-ne=
xt
>>> or my misc-next, I'm using wiggle to merge the changes and it for some
>>> reason always adds the fc->oldapi to the conditions. Please refresh th=
e
>>> patch and resend, thanks.
>>
>> I have already mentioned this has a dependency on the following patch:
>>
>> https://lore.kernel.org/linux-btrfs/e1a70aa6dd0fc9ba6c7050a5befb3bd5b75=
a1377.1729664802.git.wqu@suse.com/
>>
>> Furthermore that patch should have a higher priority, as it breaks the
>> very basic of subvolume RO/RW mount.
>
> Sorry, I have a hard time to keep up context for each patch, I've been
> sweeping mails for anything that we need to get to 6.13. Can you please
> resend patches that are related together in one series/thread, like the
> mount option fixes and the folio or subpage fixes? That would help to
> ensure I don't miss something. Thanks.
>
Sure, will send out the mount fixes (just two patches) first.

Then combine all the subpage related ones that are not yet merged into a
patchset.

Thanks,
Qu

