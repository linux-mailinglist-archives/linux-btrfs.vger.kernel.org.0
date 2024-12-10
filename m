Return-Path: <linux-btrfs+bounces-10174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60D9EA422
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 02:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E1E166865
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3122D2FC23;
	Tue, 10 Dec 2024 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aphbXUbJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18712E4A
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793271; cv=none; b=qWNF6Xjr1pAK3HQ/o0WVcxV8RX1InCi5bmnbTIxQf0X6lkay8X2hm8cJT2WNO0x3bk/cUx+WQY+gcCHHSgIS9tNv4YHf5np4Nj0GdTarYIvqHBgG6hiFH6KSGeNu3qzcJ80tpudfwdH0NpZT3qhzds1hNXbfsy6htSyAVw0C2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793271; c=relaxed/simple;
	bh=sm2+YId/GOdexpDmGIYxbxOfT7ghRpaL6UbhP1DKfas=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ODIOjO1FKbWSDK8NXPqQM87WGujH4ljpLnaCvfIupvTrxAJOU5XR5Tjw21QWaXmnLE2BgzAVZF1rZLykhYaWGbpmQfed7zx09waXHE5XmQywYUgvve29pWKcqkYwaqxq3mVsG/BAs/pJ4fGUkUuzpFT7QnRZ7vhWJz1IU6iXTVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aphbXUbJ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733793265; x=1734398065; i=quwenruo.btrfs@gmx.com;
	bh=sK8Osp5Y2nnKwLkq7gVTV9UOomEI6nvh5B8+5qhdz+c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aphbXUbJUlWz6TpFdxLOL/ovX6kBTyATuV9hRWkF4Nh0HOFrc15jmzZBDZVbRP3X
	 JOE5q7T3rkrtFrQa53BA6O0GuivGziji19YdhLMwWTBpRvIbNnGAmrFnjUbeR0XN9
	 pC9rczJp84neFpu3k6TlV8u3g4uXElHOxsUZFMD1ZRJsGhzMBHTbeLknobCXTVV91
	 MIJovKT0zE/EsMH5cU0jCXM6lFjtiiGhOwXukkfLWOfNdONTxFVdYRPMslRNrCQub
	 TRtxTWsiUubvC4uONFxxWFMlkt0fpXpGB+upYUFT6M2kqttjLj2T7kogvEvppcDVA
	 LwuHCQ53ewBASeNCfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MybKf-1tYl9333KH-014aar; Tue, 10
 Dec 2024 02:14:25 +0100
Message-ID: <84b36917-c7a1-49a0-98ab-569df0df6fab@gmx.com>
Date: Tue, 10 Dec 2024 11:44:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: super slow mounts and open_ctree failed
To: Christoph Anton Mitterer <calestyo@scientia.org>, Qu Wenruo
 <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <9b9c4d2810abcca2f9f76e32220ed9a90febb235.camel@scientia.org>
 <1067d68e-322a-4aa4-b72c-f07e21d3afdb@suse.com>
 <ee6c1c04eed9b0bf56abd68013320fc05e6b3953.camel@scientia.org>
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
In-Reply-To: <ee6c1c04eed9b0bf56abd68013320fc05e6b3953.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LkYPJQoH52OWjbb5fLvDPZb322uYFnQIZE7v0OPX72iLt9AWvh3
 +iSrArniEvD0SI/XVs1sXVdpVe3K+0B2TGWmKhW5nr4F4/vyQoyCRdRDAIsdtyzP+2Jp60F
 0Q0ebWAQUBYJdmqJQqAZA5elejniFcyneWcWRht8XB2bGnvxb6+XXRy65Fs+w+E8Zk4Po5t
 pVjqEaVD5IpLXHOLB9kTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RSPf4L2pGJ4=;djpEotUgiPKY57nXHkWcp+qCqnd
 xSPyJoSKl9Ik0IUss0O+/sJ8TRwAj/TMThWXdYC4QSecIpdr3aURVsJFsbmAjGbV1f5ZcNZ9T
 5YlscKfO+3gQy6B3CI5ULA4+Yaooqf+2D6SpUhHeSvUiEqNtIY9MPRVAaDEFyhLyERx4hJLn8
 Ix8qLQz1l83pOTYkX+yg+tul83XgTqwY04n9UaqHrdBWhwKd5c2H6wuhYRRzCM7sY056RC2MH
 JpI+uH8nY/sn4snW2VVhxvfzr7yZF7uPnDv5X9LPZpzbYex7zz0BOQ0+TzPlc8tQLhavgeScp
 Rldkp4YaSbxoWRayixaYxmHUzuu7QNgQQ6vKO4brku9n3YBfIdd3/40zOBRYQxAW1ZnfyXjzV
 33pvWBmhKsIwM2BI9Gdy0KTOsOSk+Cj0SSrTD7eoPwwfUFTAdPXjFYvhmkoeUbFVTfgPUPmWL
 MSnsiLomUvZYeCYaJkZELiPQMWOnEFW+Tf6cZ2v3biDl9tj1Bbe1wKj7ybchmH7K1ifmBd57P
 idKPUxivSYWnH8AFwvjyZMHFBvB4evSP2A14AZPAOK6VYWq4h+Iq/JJpuOJlv7mP5IId6lnP0
 h1GUd6XS5ZUTyCu8wAVfSQyRpBe2I8eh5TQ2DqiAxfTm1wTx0yqa/wk+dlWK8V/Jipa5plvBj
 kb49Egr52QT0pIQwPGIjwFbkYcv6YD/FZxCx2sF9Lguehax8MTGDTFIMsXZQQCrGrVAcF5h2U
 FnHzdhW6ZXJIfZXSVFAKncpUtYgxmFbva8UyDyf9+nmsA5fWiseIkPFrvnW9/lnlgG5j5itO8
 BnLWmgkBjpOxxf1qcQ7Xaxti1anwtAtRQ+BD/AnzQDy0vmjmF9EnSsSJVPDypWaw+sJFYEMBG
 k0MTq+PKlUqsTU6diXSM9vdUdi5UQt/WXPe+ecIIpUYfFIXTE5ZvNlEvZuKkKWlWbpPAzuh40
 5eSmQ5Repc3fxS5mfGLaDjoNpxGfH3fO7taLMRnbE5egGsjKvs9k39/4Ef7jPyRWzD4LQk4hk
 TGZ5qjD9nBcX8zhtb/QCla8pS+upoZAqySDaUVY56iklmIYVQ8uycFvgvT7gNCG5MeUVYRktq
 qXdP0h3utR8D7zG3ddP18iCBSXUurC



=E5=9C=A8 2024/12/10 10:53, Christoph Anton Mitterer =E5=86=99=E9=81=93:
> Hey Qu.
>
> Thanks for having a look :-)
>
>
> On Tue, 2024-12-10 at 10:12 +1030, Qu Wenruo wrote:
>> It's 100% the block group items lookup, it's a known problem, and
>> that's
>> exactly why we have block group tree feature to address it.
>
> Sure about that?

Well, I was almost 100% sure, but not any more after you mentioned the
hardware raid56 controller situation.

>
> What makes me wonder - and have you considered that - is, that, as I
> wrote, IO of the mounting seems super slow, but at the same time, IO of
> sequential read (via dd) seems pretty fast.
>
> Also, we have many of these systems, and many of them have similar
> filesystems like the ones affected here (that is: nearly full (~90%),
> many files in on dir - it's the storage software which does that)...
> and I've never seen these timeouts before - only now with that one
> system where the (hardware) RAID got degraded, and it seems it runs 13
> background initialisations in parallel(!) (no idea why, it started
> automatically doing that).
>
> That's why I it feels a bit as if random read (as probably done by
> mounting) would super slow now, causing the timeous, but sequential
> read might be still fast.
> In which case I'd say it's at least 50% also some controller issue.

If degradation is involved it may greatly affect the random read
performance, pushing the original more or less acceptable mount time to
unacceptable.

But even in that case, block group tree should still work like a charm.
Because previous if we need to read 16K (the number, not the size)
leaves to find all block group items, we will only need around 30~40
leaves to do the same thing.

Even for degraded hardware raid56 array, 40 random reads on tree blocks
should be no big deal at all.

>
>
>> The open_ctree failure is mostly killed by systemd, as the mount
>> takes
>> too long time so systemd believe it's dead and interrupted the mount.
>
> I thought that too, but couldn't really find when it even times out per
> default.
>  From systemd.mount(5) I'd have followed that the default for x-
> systemd.mount-timeout=3D. is 90s, but it tries much longer.
>
>
>
>> I believe we will move block group tree support into the next default
>> mkfs option, but considering it's only introduced in v6.1 (thus your
>> kernel should support), we may want to wait for some extra time.
>>
>> And since your fs is totally fine, and is the perfect match for block
>> group tree feature, I'd recommend to go with `btrfs-tune
>> --convert-to-block-group-tree` to enable the feature.
>>
>> Such conversion will take some time too, and it's strongly
>> recommended
>> to use the latest btrfs-progs for that conversion.
>
> Since for the progs you recommend the most recent version (which in the
> stable distro would already be some effort), and you also say that the
> feature itself was only introduced in 6.1 (which we use)... should it
> really be used already with such an old kernel?

The code is introduced before 6.1, as part of the effort of extent tree v2=
.

It's us finally agreed to enable beneficial features other than combine
them into a huge but may-not-land feature in v6.1.

So for the stability it should not be the major concern.

>
> I mean we have production data on those systems and quite some
> scientists from the LHC will probably not be too pleased if its lost.
> ;-)

Although I can not say the same for the conversion tool though :(

So if the data is priceless, I'd recommend not to convert, but let the
hardware controller to do its silvering first to see if it can solve the
performance.

But if you have newer fses to build, then block-group-tree feature
should be considered, especially for larger fses.

Thanks,
Qu

>
>
> Thanks,
> Chris.
>


