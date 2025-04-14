Return-Path: <linux-btrfs+bounces-12979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E30D1A87793
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 07:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF90189102C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 05:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB31A2387;
	Mon, 14 Apr 2025 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="N9Vrkb5k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFBB25776
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610006; cv=none; b=GuEgtk1bBhQ4FKHcPfBAVO6VH8HQ5nQGHoGz0R7XI7hgC911jKkFdWtbdn8zPM2b+OPVdlsrIq4jUmjT24yMRL478cs+Yt+oyJ4S0kyT7IXcPt5SjsaPIi0Hvqnz3LGz1mWHqyUOZRYyyZQiusHSd4rmgbiN32eb+CTRW9tlxYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610006; c=relaxed/simple;
	bh=qPd6q3HEiVg7761A30SfSf2x4hwDGfgcwzLtyGnQ4Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rw2MmM2N2mWw2WcuQbVHM0MMKX1B5CP5uSxafvAegRd57EuSGgeySNqgPp7KhHRfFk1uaqKzGXROw1vcQqVF6Afr+k+CCkSS132sG2CXIeW37nUowk41bZ2jGL0wqNUb5y8umenHpdem41PGWtqHIErSAVQBx3F3H/cfPdTTqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=N9Vrkb5k; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744609999; x=1745214799; i=quwenruo.btrfs@gmx.com;
	bh=qPd6q3HEiVg7761A30SfSf2x4hwDGfgcwzLtyGnQ4Xw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N9Vrkb5klkk1eRFYaxNZQDn7kKUhgJRYAUaIHJ0uWHwX3LIvYQ9sEp58B69TRiAC
	 Y39PQu9lZK+RPV4hGcQtEaCKO5LQyWEr963fMcT0lGJ/muuXOKeALRNjAxsjHmNi9
	 sKxGOhIv/ljEHlFAf+ujuCZ0OATCsLW+YIYiFKOY0pZppNTYb6m8wDCsUXVxhKOJ1
	 naSdOCYgCArN8uQ14EqXgRKAI29eDWiae6Xi1/BsTb34zrrA4G6MGC0slPTZeA+Du
	 2p3DYW1M9PULprxJzBxgwJJXT5J4wXB+PlksV2MWAocMJ/zIoGKLO4v6oF6FDSHp2
	 5wPTnSaMwAWylykAGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mf0BM-1tOqKT076A-00o4Fy; Mon, 14
 Apr 2025 07:53:19 +0200
Message-ID: <50303c5f-4778-49c5-8118-8fecc218c509@gmx.com>
Date: Mon, 14 Apr 2025 15:23:16 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xfstests generic/619] hang on aarch64 with btrfs
To: Zorro Lang <zlang@redhat.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20250413125349.w5jxnnphr7wliib5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <17cd9240-99eb-49e1-8843-0a80a18f8ac2@suse.com>
 <20250414042322.ehea2rb5g5bo34zq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <31bd0214-955a-49a9-a4ae-f102044fcbdc@gmx.com>
 <20250414052259.ldxjeiamj2l23bwc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250414052259.ldxjeiamj2l23bwc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lSSVe4coD9FthVvlooJcMgI3H93mo+hWijpOQAOeLw36FsSFkmD
 +UeEJksfndrkdzo/xKDwWBrYl756kXDwwoWWr9XxzxYzSeUdPIGpAFVNfT/ro8IyO2m7L8z
 8usHnhrUF3UZ/Szr3FHS0cR0YPklo6Q4IPdoPpTwvOOYqNzKI1aYcXIRFqXqQb7U3lTHN9c
 i0T1u3MOLsqJtvHkycXdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1chhupQ/Bzw=;KtsHphN70pNEVLxof+jlj1BJA3P
 GY/4iMc1Wu+bU51Z5KiKf3zRReEHKPga8MJ1/K8k/yP33HfkNaiU9PWqud8dxtWKQTViseXNx
 KAB0awkVpEGcLD5mXc2beAJ4RxXoKFXx4q3JIHWx86vVUUhGFMtLdRQS2Y4nccknF2L19YXQ7
 wOAe0fEwydAw+0vzj2Q2IfkkP6pvmdydTYkLVPTXfLSJKxJEmFlA5VfqMjTrxV5cXIouRWwzk
 DcLzI/VJxZNKAsfbM+LTZ/WFCjVGp1Zmdh9me80ZdbrqYAcDeb8nL18UQvNO/VB4tDYxqsqwo
 hDVKn/HOu162r6tZI3DyP9s3Gmueh3XmtHyrU2/q+pe2jA9EIUq2XEv0dYWzlJTA4otoZ60ym
 503DI137bSJlTpb2VZGKE0ubVjFno3lDbJa+jjKeuyCEeFEttafl5k1M+kAHenZSv3D05RS75
 mksdRJfKm9AuMecF/X0mpjqKT5D2jWLTHy6iX3fKliFyX2GuDOUOXMTbHlvPhVSONTEOmNTYU
 xJ80+P05JCc/Tagx2bfbV/2+ovO4BmbXCDn6pvsoQN7kJuPgRInv5G3aq8lp1F8iNedU9WIq8
 Yaa7/RONoO2AwL8HqsXWvHPVhwQ9CXgTYWNZ1MWlqBlrex5klaeZKFKLyp+NQJcqqbYRjX5AH
 bjsTXq3el6/npCDH/dbqggwtM8NZAUmjn32O/3CPozg4ywyJ/T6PNixT68ZjwG7vEoogKYDfg
 eK0w3JnxUJQhaE4v6Qc8eJP6veKqBUfgAArkeOyjvPAAfgFigYlKUILvVT+Nwek/GKoaumPWu
 uPQq+89CfvJkdiv4Q3SJtxyFA1TNUTZ8iC78lNXbhEmocNiC56xoZqJ8zma6ov2FLLcmeC30/
 QNXDvNsGWbl70WTrN5hxoXWVmw78dwU6vFBgcfiLgJonAP1ZYmkKqqxx8Zp3BwH7Vjx7DrExx
 Q75YBHmCKoHtpsrrOSOWXxw8IOcKICFIe9UohDDSLMuQav1awIJIn2aLSzG6/UZNZYOJlV6A8
 OGQF7Mo9elidiSvFzauxW4dZDibaN8Rwq9P0poSTrxG2AODrxhgbZZGjV6fRxfyb46gCMhKaN
 abn+Y/b+M/yBugXrw4BK0IkNqT+ojwTKTNitaReaSqP4feWA55EYm12Oejqwl1+kr5HWRIB3H
 4JO3IGI5vJKbISzseCAN0FXTUWNcQAFsfkcK1RiB1WebmmnCxlCtu1XrAez4Enwwrqr/SuF5e
 2D1EFefzVbbrMzU4ybjMkjZo5wL/lKMNjb0dFi4TYOtMyxuelIRpeXuRq7arUmZfWY/698S77
 lRb5jQ1PBCNj3Sq2K9LPLOO6PJj01n43qX13ka+I1N2GfmTY9TgasW5ySAb3/gnCAEmbF8oQg
 X/TfZfbJ8e5TauSQf7PDUnG2KpbttQJT+LPpa46kq5Swo2lvIIOMQix/1UqedcM0G1MdRLw02
 ZGU2Jpg==



=E5=9C=A8 2025/4/14 14:52, Zorro Lang =E5=86=99=E9=81=93:
> On Mon, Apr 14, 2025 at 02:09:59PM +0930, Qu Wenruo wrote:
[...]
>> Meanwhile if you can reproduce it, the early "sysrq-w" call traces will
>> definitely help us a lot.
>
> How "early" do you need? I can add "echo w > /proc/sysrq-trigger" to gen=
eric/619
> source code, just not sure where do you need?

As long as there is no obvious activity shown in top or similar commands.
I'm afraid this requires some manual interaction to do the dump.

>
>>
>> BTW, you can use attachment instead of pasting all the config into the =
mail.
>
> Oh, I heard some mail lists don't like attachment, not sure if that's tr=
ue :)

It's true, but at least the btrfs list accepts some attachments, and
since I'm also in the To: list, at least I can share the attachment to
all btrfs developers if they need.

Thanks,
Qu

>
> Thanks,
> Zorro
>
>>
>> Thanks,
>> Qu
>>
>
>


