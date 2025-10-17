Return-Path: <linux-btrfs+bounces-17920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD90BE703D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 09:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00CF24EA435
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 07:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2880825CC74;
	Fri, 17 Oct 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Xi8Yuo8g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4841DC9B1
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687683; cv=none; b=pLCLr55W2HXDORWGTJDekUfhcbY9/faG/0xDCM3UW0WSJpKfGiOw2V6VnTNMuUh/Ps+IplWKJ9xvNRd7/xjh9ZfaS74xQLCAC7qUnwNHDh06xmPD8KI9Iw5P2MDYepnwr4S9UPpj2vSipgVBsGo/Tl1oQGNB+RXjonec1H4y9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687683; c=relaxed/simple;
	bh=N1z4+0JTOcXsvPnoo//L983OBtXU/zafbpdfp/eeY78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srqLl62fpPUiqhIkwtB+B9T3lSkmG+kOCMJLyogN4Wq2mFC9BE/CMneQous1IxIuNpjwbnl/d2N3kN/k0vjtfAooJ7ljxCQMAQ+zGi4oDqvb+x4i4HEiqCIDCovJBl5U3J0b3PASVFel0lkP6wEOztpgSINlqp2mXJnVdLSrzV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Xi8Yuo8g; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760687677; x=1761292477; i=quwenruo.btrfs@gmx.com;
	bh=N1z4+0JTOcXsvPnoo//L983OBtXU/zafbpdfp/eeY78=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xi8Yuo8goE4iGx3Ji8tMSyJPe6gDw/CfVLuxBEdtlaGIiQ0yHCkR+igk4kPlpnk7
	 jHyUFn8nzP/8f3lqYojEtpniuC5VyWw4qawAaNdsJV6UM5vKBlhhjr9QOnfyYbTj5
	 ghKnRMD6ihK0wYfA/RumhsTR8EPJR7EhDG8elwL+sO9zjLx8iuGisbI7sTRBMek97
	 ALzz3bW129ovvPEdIpi73tmcokL0a0vEHZ4nvGcrbS1ykItP/DLffkqh8qlAYoxRR
	 75Apd87tmG3tBrf5mwpOGfxb3EH7r1kNlQbmOEYSRsKd8qz5nEZFxANB7+HO7ra76
	 aTIn94VPVIpA3KzjlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyyk-1uFtD03Ppm-00wA2I; Fri, 17
 Oct 2025 09:54:37 +0200
Message-ID: <7a20d7da-d536-459c-be04-b530d8d1ef98@gmx.com>
Date: Fri, 17 Oct 2025 18:24:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: scrub: cancel the run if the process or fs is
 being frozen
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1760588662.git.wqu@suse.com>
 <36aa07502d2edd17d21e28b97d71cab182c12bdf.1760588662.git.wqu@suse.com>
 <20251016164224.GH13776@twin.jikos.cz>
 <c66eae15-2651-405c-a024-05a31e836fc5@gmx.com>
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
In-Reply-To: <c66eae15-2651-405c-a024-05a31e836fc5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c2atBrq0QlLRD7c0F9EPydVssWOYk48OA5CccgF+k/fyX2nktnO
 jNRuMYAg7MlC5OkHuejPLsHuO2nbMEIYpT7hFnTB7QrQbTfoC4YqWA4rt6HLtuGB8YuHbZI
 0GOXlypnXyx7s0z8arx+HrvspneXF8a34Gr1wsyWLPQN9iVjkdWsC5rEWF5LJQAzThZ5S8R
 zbXbcgMbaz9gE+1nmd2Gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ka6OGeOPIVA=;APsfAti9gvLGrcPzo2DvBuqONzz
 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
 q0+jA==



=E5=9C=A8 2025/10/17 07:05, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/10/17 03:12, David Sterba =E5=86=99=E9=81=93:
>> On Thu, Oct 16, 2025 at 03:02:30PM +1030, Qu Wenruo wrote:
>>> It's a known bug that btrfs scrub/dev-replace can prevent the system
>>> from suspending.
>>>
>>> There are at least two factors involved:
>>>
>>> - Holding super_block::s_writers for the whole scrub/dev-replace
>>> =C2=A0=C2=A0 duration
>>> =C2=A0=C2=A0 We hold that mutex through mnt_want_write_file() for the =
whole
>>> =C2=A0=C2=A0 scrub/dev-replace duration.
>>>
>>> =C2=A0=C2=A0 That will prevent the fs being frozen.
>>> =C2=A0=C2=A0 It's tunable for the kernel to suspend all fses before su=
spending, if
>>> =C2=A0=C2=A0 that's the case, a running scrub will refuse to be frozen=
 and prevent
>>> =C2=A0=C2=A0 suspension.
>>>
>>> - Stuck in kernel space for a long time
>>> =C2=A0=C2=A0 During suspension all user processes (and some kernel thr=
eads) will
>>> =C2=A0=C2=A0 be frozen.
>>> =C2=A0=C2=A0 But if a user space progress has fallen into kernel (scru=
b ioctl) and
>>> =C2=A0=C2=A0 do not return for a long time, it will make suspension ti=
me out.
>>>
>>> =C2=A0=C2=A0 Unfortunately scrub/dev-replace is a long running ioctl, =
and it will
>>> =C2=A0=C2=A0 prevent the btrfs process from returning to user space.
>>>
>>> Address them in one go:
>>>
>>> - Introduce a new helper should_cancel_scrub()
>>> =C2=A0=C2=A0 Which checks both fs and process freezing.
>>>
>>> - Cancel the run if should_cancel_scrub() is true
>>> =C2=A0=C2=A0 The check is done at scrub_simple_mirror() and
>>> =C2=A0=C2=A0 scrub_raid56_parity_stripe().
>>>
>>> =C2=A0=C2=A0 Unfortunately canceling is the only feasible solution her=
e,=20
>>> pausing is
>>> =C2=A0=C2=A0 not possible as we will still stay in the kernel state th=
us will=20
>>> still
>>> =C2=A0=C2=A0 prevent the process from being frozen.
>>
>> I don't recall the details but the solution I was working on allowed
>> waiting in kernel and not cancelling the whole scrub,
>=20
> That will only allow the fs to be frozen, but not pm suspension/=20
> hibernation.
>=20
> As I explained, pm requires all user space processes to return to user=
=20
> space.
>=20
> That's why your RFC patch doesn't pass Askar Safin's test at all, no=20
> matter if the pm is configured to freeze the fs or not.

If you really want to a resumable scrub/dev-replace between pm=20
operations, it's possible but not in the current scrub/replace ioctl.

You can do it in a kthread, and freeze the kthread during pm operations,=
=20
and resume from whatever it was.

The problem is, this requires a new ioctl, and we should also take the=20
time reconsider how the new scrub ioctl should be.

E.g. there are already some existing problems, like scrub cancel is=20
global, that you can not cancel scrub of a single device without=20
affecting others.

And of course there are some other minor things like the timing of=20
holding s_writers, but that's way small details compared to running=20
scrub/replace in a kthread.

If you really want to go that path, I'm totally fine and happy with=20
that, but that will be a way larger user interface changes.


For now, my series addresses the more user impacting problem (long time=20
out and all other processes frozen, just acting like the system is=20
hanging), and I'll add extra notes to scrub/dev-replace about the=20
behavior change.

Thanks,
Qu
>=20
>> which I think is
>> the wrong solution and bad usability. That way scrub may never finish
>> going over the whole filesystem.
>>
>=20
> That can be solved in user space, with minor changes to the return value=
=20
> of the patches.
>=20
> E.g. only return -ECANCELED for real cancelled runs, and return -EINTR=
=20
> for interrupted runs, and let btrfs-progs to catch the -EINTR cases and=
=20
> restart from the last scrubbed bytes.
>=20
> Thanks,
> Qu
>=20


