Return-Path: <linux-btrfs+bounces-1500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CD382FEC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 03:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90A71F267BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DA08BFC;
	Wed, 17 Jan 2024 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dVYd+DG8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A98BE3
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705458233; cv=none; b=OPj7hu2bgWFFcw9J5fhZidJvh5nhIwt170orWC0CQ26R9EFOe67uTK9GOyEB4KHwkNar9bKpc8k/wfOTHpoqpEpHYzxGnkESsA6+KxILdSDKKWBm90Wek2wYlSziZ+XjxlZPRizg4DgmE0KCfHnedEK204WUx0DBD71RcaFLAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705458233; c=relaxed/simple;
	bh=X51/M3WSM4eWl4n2PHZnNRAwnrnEc3Z3f7LCEyt2FCs=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=iyJ3RqSlSxQOd0kC/e3eb9xBrRCL6kXJDZUOYimRzbIXOZmWjHLgxuUKRMm356KdIyve+0MrMc6xyZMb2TT1g5l9bFGQohOgjv4Lz6kaHbmT4/T7VIBUgAl6VX1/BFVv5LYGZSAf2nWRQ7v67aaApDOXuxpzGWGm6rLD17/IgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dVYd+DG8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705458222; x=1706063022; i=quwenruo.btrfs@gmx.com;
	bh=X51/M3WSM4eWl4n2PHZnNRAwnrnEc3Z3f7LCEyt2FCs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=dVYd+DG8/AeK6SCwLx/4EsShcPNoc6Yi1rSSfCaI3o1Ix/qTEcvifpaPeTC6xfMj
	 Yo2/4hEYYEU196EKjgtzwci6g79FFSFPngf9e7l26dYVde8L3NX5KQRzSeT2pgaEA
	 U2UwHIthuO45lEbZ7gZLTefJK1xF1xNz4R19/geoT2XOk3caR6w1IFof298hORNtv
	 KAP6/UCyFMFQwJcYMZXMBAgiCNkza5dUaDtN7T+IM5wucuOP8lAVRro+LtKZqvynQ
	 AnZoOUeU1YENmxDcEUg6H/eRHw2VhhkYHn02uaa5VqgOdH817xQBFL7xYG7SaQ0D/
	 ZmxLCXMFDKEHBQDvWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMyf-1rlhjr0gm9-00MJI9; Wed, 17
 Jan 2024 03:23:42 +0100
Message-ID: <cd3cd289-e63e-4c5f-9842-401069ab4f53@gmx.com>
Date: Wed, 17 Jan 2024 12:53:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: avoid use-after-free when chunk end is not
 64K aligned
To: dsterba@suse.cz
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Qu Wenruo
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Rongrong <i@rong.moe>
References: <8531c41848973ac60ca4e23e2c7a2a47c4b94881.1705313879.git.wqu@suse.com>
 <12744dd0-a56e-487e-b27d-4ad66498d7e5@wdc.com>
 <de82a8aa-7b51-4aa1-9cd6-a2f749a6e941@gmx.com>
 <20240116182807.GB31555@twin.jikos.cz>
 <49056bc2-55ba-4f09-9a30-0caf4016bfc2@gmx.com>
 <20240117005520.GG31555@twin.jikos.cz>
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
In-Reply-To: <20240117005520.GG31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5U1NREOV/AcUenc3oIu5f76/FcobhCHpvtehtGZref8Yh5j8RS2
 qyc+Mds2JbwTpG7pqzd/iE1hNoZRbT3KQAclv2prIqYxIgVQC2ncHKWEFxQ+UveM8N021IN
 2+7RmzjMOVgV8OdbBsq6Oar9dsJchqTIT0SgFqotf4FL7hxBo16KkDLjUoH+zcj0LXKWVah
 5IsUDxf2qGNKAOKpHfTqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d2hskjUvzhI=;6MPDmY7sfpvv9xodDnrUsjsvRd+
 0XZoJOmnAaRfD739jYS5fLGLawKJXae7LWSmFd5cl1BvG38pfKbfciEo30p6sLQUafJNR0XKd
 plB/trMVHBL646NqLUvyPqx0Dws6JcWebRcFSMHKWuaUD16+qMt8w8VJX7mJc7TXCN9eWJ2nK
 e93B9S3J4FjsUMkev2zdTnDqZSu0heaOZN219RHDnCQco+cjXkB1zYTQCov30Cg+sywabZRrS
 ssdqcPG1QDSsjU253q39/dra7HcpC4Cb1B9PMIu9y9V1CNm47FaBsRROSY3QCtTM0etZBWCv1
 4rffHcvd6cwSbLgY8VhEz/gil1riUkDr+ZhBv5AWaqAeBkTPAcxzwTc6V3q8jTh6KpHIYHk8Y
 4lhiZh3sEQ85fVcnQX964NpRu+GNDxpeFQg204GXePxzUebOudOd3pJo5B/MotZNy8SQOYIAc
 BLKDVa+Sw8aHK7uiwAulW5TAx5+hI2hNSd+n0gXM6ikF2ZKB1SyeI3d7iag9ShKl8YPjU2vuf
 tSjWBLAOF/NJKgXYTiKqjpGSM9VIlDvubFa03GKXqwzpJGPpXbxIJ2o6Rt8WYk4pXn4Pg3b0+
 c54Dnz4XgrxCXCQba4P5b/kBwOQ7gv8s+2/JbvithsLOVjJISy+Md3X079miZlfH18MWNHRee
 jAev9uCT4fxNd6QpUcNKUy8LjeP3mtVZPeyZfwpkoFPl9i57/SGBoeO0ukMc8rUMwpsayPhEW
 b0JNEuvI9VodyYS1RBHRV+Q/yt5ufPE1lU8rnUP0VwR9BQosG0qPIO4zwMUBm7hUAwruS8wbk
 XYOJZTW9JZhqmfpoPBld8BR0nQasfSohqT0ZMjhsjrHROVLXnswQxL254oH8fzSRUOYrwYa91
 nEYS+MaqF150hpq0VAOWsQL0CdwagwRaWaJJQigyPW5uoHhfpftH44qXqRo17nkZLDheBPCQx
 BLnyQMIUa9PLA9hO7GQvN+8Y22I=



On 2024/1/17 11:25, David Sterba wrote:
> On Wed, Jan 17, 2024 at 06:36:00AM +1030, Qu Wenruo wrote:
>> On 2024/1/17 04:58, David Sterba wrote:
>>> On Tue, Jan 16, 2024 at 09:20:58AM +1030, Qu Wenruo wrote:
>>>> On 2024/1/15 22:39, Johannes Thumshirn wrote:
>>>> [...]
>>>>>
>>>>>> - Make sure scrub_submit_initial_read() only to read the chunk rang=
e
>>>>>>       This is done by calculating the real number of sectors we nee=
d to
>>>>>>       read, and add sector-by-sector to the bio.
>>>>>
>>>>> Why can't you do it the same way the RST version does it by checking=
 the
>>>>> extent_sector_bitmap and then add sector-by-sector from it?
>>>>
>>>> Sure, we can, although the whole new scrub code is before RST, and at
>>>> that time, the whole 64K read behavior is considered as a better opti=
on,
>>>> as it reduces the IOPS for a fragmented stripe.
>>>
>>> I'd like to keep the scrub fix separte from the RST code, even if
>>> there's a chance for some code sharing or reuse. The scrub fix needs t=
o
>>> be backported so it's better to keep it independent.
>>
>> So do I need to split the fix, so that the first part would be purely
>> for the non-RST scrub part, and then a small fix to the RST part?
>>
>> I can try to do that, but since we need to touch the read endio functio=
n
>> anyway, it may mean if we don't do it properly, it may break bisection.
>>
>> Thus I'd prefer to do a manual backport for the older branches without
>> the RST code.
>
> I was not sure how much the scrub and RST are entangled so it was a
> suggestion to make the backport workable. It is preferred by stable to
> take patches 1:1 regarding the code changes (context adjustments are
> ok). In this case the manual backport would be needed, let's say one
> patch is taken without change and another one (regarding the RST
> changes) would be manualy tweaked.
>
No big deal.

It turns out that, I can indeed split the patch into two.

The change on scrub_read_endio() is already shared by both regular and
RST scrub paths.

The only change I did to RST specific path can be split out into another
patch, which doesn't even need to be backported.

So yes, the split is possible, and it should make later backport much
easier.

Thanks,
Qu

