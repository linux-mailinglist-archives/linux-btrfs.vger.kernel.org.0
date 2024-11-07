Return-Path: <linux-btrfs+bounces-9382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7720B9BFF47
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 08:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17F6B21CAF
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794F1991CD;
	Thu,  7 Nov 2024 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DyWfqr6W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D53119596F;
	Thu,  7 Nov 2024 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730965422; cv=none; b=s7kXbPvj54fXNvYINrp1EqPkuMPWrvjF48P95JGkXscNwquS04rzBA8mHkMDSOrSohWOcVJ+EbBEH5RG4vKKcAyO+puS14HLyP4mExYzDQmh4+dxru6e7wVfUrtBMeAQ9452gfn8t7935IuAqNm8PZMgTX8L1xHkusv9dKs6aBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730965422; c=relaxed/simple;
	bh=vFd2X+d0ImmK8Up7uTYKk62dU9fVNPJEmqfehz0cixk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fd3jQgTcwQl/S7ECU0oEYVGxKzRgc513WxmZSv5LML9i9Ry2bujgPqDxIvufrHrVv/ZrwbOnuHzBohSd2WLAXETHfaY7wjMHIQFJp3wTl40n6gF8kHaS69x8hjeOjSYrdLEteW+V7BhWvR9x1+8e+K0162oTeiN5Iyd61pQjmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DyWfqr6W; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730965410; x=1731570210; i=quwenruo.btrfs@gmx.com;
	bh=7KiL5mobqPuW3Uj8daUd+bOjgYFyZsb4cSFettbWVz0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DyWfqr6WI/qvXvK+XoaPxX5Vi4rtYZRl4wGEKLvXIWoErleb9CYPPq6ERdqIMpMQ
	 k/zYAtHnZ9o8+qG0C5pqG0xv0KFqXx81Jd1bg4UpwQN/o4z0A8Hk7u2YGiPKiiuwm
	 FpUylbNuTUKEbixfn2rDUst/yEfRuHIlAfAQ0d/n53+t8BUIeNTsFXa2F/bvMKWLk
	 nAEwkIWVtknH35XTwSWkqkl3spnYWwwe2w/TnbGPXlJxx/72Mavl3J70J4sz0+dSP
	 aKtoBKRDWbw9+TD7P1exmZx0qtGOOTwTz9kVciECpED+MNl75hYV1sVKFymFO3Y4h
	 xuc8OjG3CoRciuUnmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOiHl-1tSPTa1wZ5-00QnI9; Thu, 07
 Nov 2024 08:43:29 +0100
Message-ID: <3f16a547-4f75-483f-87b1-ca30819001b6@gmx.com>
Date: Thu, 7 Nov 2024 18:13:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] btrfs: a new test case to verify mount behavior with
 background remounting
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>,
 Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>
References: <20241106054328.19842-1-wqu@suse.com>
 <20241106093503.3gaon45f44b3r6sv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <1b96c1a2-c0f6-4c05-89a3-709c547d3e0f@oracle.com>
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
In-Reply-To: <1b96c1a2-c0f6-4c05-89a3-709c547d3e0f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lG/CUanxLWN7eo/F81ag3M0PrcimuHkAoEzGX9NG5egkD330mIC
 SzDyhwfpUqGOXU+jndbEycksV8Fq93poKV0psGDJ/PPHF5aaBI/eahFILAyjgEeQO9fpqgA
 Z1PS2V+NqCvhvQeZaqq6Cye2nq6iUj0mNKdlOfM5GnRCsVujl2ongg6HviqQdD15yEq6c4p
 1qCnzUy0ZVjDy1FiLn56g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+7rA/9DdAf4=;a3tqqeJAEBAsTIhjs1tAlia9+to
 GLg7Gfsd3QHFN0xvREoQGpW8Hzx51d92d2nf7RkmA5YugFCLdFnsHw2G47UyqwLs8zWPwtEVb
 dERgUtOq0WCxukzTwnshF38dj9qH/JN3a2hJM1pkqZEZyG2vfoFRtNz6Qfxy85pK8/f/8/8XT
 xMyuFh+RlibfAU0nZYI+H1lUVyTSlVFfU8kO119kyhZYn8KZEuFyv24JlaNNhC6B6jy9OrjC2
 vO0F+L5xSrK+j+BKMAc/T8+drehO9qeaFY/4U362qDk8Rofj8+UZX05Nc8B70UOl4faBeHO1V
 ivoZ2vjWINXwpdI8QDTIOqR/nF4kqc0Xt7jP3VSTDkrqMwNCFlUvbWCo4Q60ol7uOh27XkjWh
 GBwRi1ijb5+KNAQWj1K8xVxfJ00qKAhfT9l8GZ9rGb1x+I/VNb5ArcAIGY/bKTIoidauQH8OG
 epWwBVaDCy+XtolLSb62CW2DpFj+URoKwZ8CuqlWZLr0S2TSQ1X1z2lFavKtvaQsXfDHvfRKL
 PLB+58FnkyRae/U8MbEUV2p7P6++puDo4UL5MDa+gwmNXSX9WXOs/F2SFNH3NsPEL7VJf7Kb/
 MSzOLBpPSlWkbHdNmqg/KN1ZBgiFIiR2NyTIv4i4uNoLOWWBLlYEgt+Y0/fhIoGC2bVX7DCtZ
 AwtRVXPe4Id/QZHoBSS1a0Khr0A+Xcv1w1eFcBKB36EjFDi+2ZPJp4MJ8nGrSYsXZI2IVb3PE
 ke9lLiBVYP2JWh8jNu51zIcybhJz/bR7Ru3tf574o6HNxzEME+wAqTUvEkcZWQA/2q5uOkfDx
 t6B5JRE+rwLOK4rQ25kqYqY05EbpHs8HtIds6IHgUs6oASyvvz3LL580dav7yYSPbOK9t9222
 ADjEEMmHDhsMIMZeuhNk/PmGvf82cwIkfE6eULf2cC/SG0ErEkCS8wCy/



=E5=9C=A8 2024/11/7 17:47, Anand Jain =E5=86=99=E9=81=93:
>
>
>
>>> +# Subv2 may have already been unmounted, so here we ignore all output=
.
>>> +# This may hide some errors like -EBUSY, but the next rm line would
>>> +# detect any still mounted subvolume so we're still safe.
>>> +$UMOUNT_PROG "$subv2_mount" &> /dev/null
>>> +
>>> +# If above unmount, especially subv2 is not properly unmounted,
>>> +# the rm should fail with some error message
>>> +rm -r -- "$subv1_mount" "$subv2_mount"
>
> nit:
> Nice, if unmounting $subvol2_mount fails, rm will fail as well.
> To capture the unmount error why not redirect its output
> to the test case=E2=80=99s full log:
>  =C2=A0unmount $subvol2_mount >> $seqres.full.

Because if $subvol2_mount is already unmounted (e.g. the interruption
happens after the umount funished), then above command will cause stderr
to pollute the golden output.

So at least we need to redirect both stderr and stdout, e.g.

   umount $subvol2_mount >> $seqres.full 2>&1

I'm fine with newer change, although that can always be done when
debugging, and with the initial test (and all the failures I have hit),
it should be good enough for now, until we got some new regression.

Thanks,
Qu

> If you're fine with it, Zorro can consider to change this
> during the merge. Nevertheless, the code looks good.
>
>  =C2=A0 Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> Thx, Anand
>


