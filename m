Return-Path: <linux-btrfs+bounces-9182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEEC9B118B
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 23:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034F51C2208B
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 21:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7861C2DA2;
	Fri, 25 Oct 2024 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DvCSw4RR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF5217F30;
	Fri, 25 Oct 2024 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890937; cv=none; b=W86tyiJFMxvj5+nmhT1L0Wl0MxcB4QvTq6HU+dLJYcha0w8DdZYpSDFJ6iHz2l4cltjPtQsyhECXKDqWu3qUBNYyjxMuGobvBzE2MlmPb3pP3bIAJ2FpV/7bDRqArC5MStpQ+TEu59/MY4+JaRUUsuIxZp16GcdQTQL9vT+E2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890937; c=relaxed/simple;
	bh=F84Q+2TWhtIjgHyGCwo6JzpH3dhFIrLTPNrHtKkDdQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qch5YEiF/TxhX2eQrSYlP7miceBmQa9892W66cghh24HMLtD705qZCgX8UhoTNloMGUbwzhl7NHbWLLGXmlE8036NfmEccdm7IlWfVgQjuIb6j3sms1RAj5JToCB+O2mABZg4QEziCTRwqSXakFsr9akrtXVcPSKIKGFjzDg7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DvCSw4RR; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729890923; x=1730495723; i=quwenruo.btrfs@gmx.com;
	bh=lK1MW+D3yvyCmUcUnm1BvQlb7XRKTqmP6xiYvdpMcYI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DvCSw4RRPys0R0lhojZrIsgU1guJmkK+TFpZPTt186XcC/hEzbBxN6gW91SSJQoL
	 TTpS9afhCUNpFZFALXHcdsspxycUPFbJgSYragcgM7YrLXqJFFsSFmJ+6MO9GGNDk
	 gNXScpt93IAAPgGE6hsrcDGNrT/Yr1326WL6y0l3SNSXYkPpGiB0HJVDknrKbd2pZ
	 hBiNTcL2UuacwFcGx/YYlURMVjWj1jOjf92HNgBQ/X0+vmxbpS4KtG+OjCQn/vUO5
	 WY69Os0ildCLYkzyBDQrD8y8LFWzuqBhfBy9bGw4YL+N2Y7EnmaHCMDWTeTU2965A
	 jzAL1cbe25QEDm8m3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McH5a-1taTcE2ve8-00gHzl; Fri, 25
 Oct 2024 23:15:23 +0200
Message-ID: <09b446c0-0c47-4822-b14f-5df1e7e4f4de@gmx.com>
Date: Sat, 26 Oct 2024 07:45:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add a sanity check for csum root before fill the
 data csum
To: dsterba@suse.cz, Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com, clm@fb.com,
 dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6718bd15.050a0220.10f4f4.01a0.GAE@google.com>
 <tencent_B5CA92105D925DA2993D4FD20DDD25BF8D07@qq.com>
 <20241025184424.GL31418@twin.jikos.cz>
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
In-Reply-To: <20241025184424.GL31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pxMtAtl0jChUk0aqUSaZIzTbCaYV9m1A1Ok2H8MPpbBDSK++PKM
 podVyySKA0eNap2nOmjc0OQACKToHEJTi+TWBpQDFJ15x5dOKBXfVKbErK4X3ajMocuBHNT
 6oRZtJw4nIgDEnTEJ1iOBAf/7yxy9WftxbiU0+YK8qkIKMPG4g7QOqd1JqOydwxxQ6T5j8y
 kFm0/pDfY4Tc0+MaOZYVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LaX5ffJmJbQ=;XIGkyU9aVIhCq8Sb29bBz+rcM7E
 Q32IzVgVVgSts1zoYTORJtz1EPXNKRPayMYGPiRxOH3kc8VcllStktqBC8l1GSkiG9Nfvjzvl
 v4XXZcI+kpdTDei85ecoUAS4s6KhLxU8F1j5iqbOnlpVP8fv1WGgsG7svxhmgY+2i/qpiJ+qz
 DRkFtWS3qo2DV9dWG013rS5E/wlUeNDIhNJnfBO3X/faZGBCK3vUB1T8/HGTbOqSyEpkyfQy7
 lsayIs7/x1E2uoQqiXGKc62IkuSUAY6s5Gcfw3PkB0OFgBScN0fY8ep49zlePl4+zgyzqFCQD
 Sel+0z3dNHyMSFeLxx82/h5OJZUQp2Qkhvum3tbJSgn8UlJi7o7N1qw3mUs4ijjzOzjsUWbt4
 Upz98GLlS0omvYxz862WXFoVt5zDzHT3JY3paYA2UL3qvrcoFfxq3Kr0iJLsoYcBRWuMI/jUL
 h8X5X+3T4j3S2u/pguHTSC1HonH9AS8tI+SBcNLZjhn4hanAfNaXp1WuVDaErz09pTdSDispi
 DT8Pfuj15yMlLTDiVtQCHA0XeYbK6fNRWKTzuu+i/QJNgyT3qAK+wf8l8F6ATmCdmzzbOUzge
 +lDyj0yGNx45qxJ5aINDZ3hKpkzJ3NFX8pxzWlNZJpiWakSjpXnIFE+7r9cWlIua8gvgnj7pH
 BXuQfSVZHuzwuFfLBpO6GNku2SJe6h/JlUCS19FPQ83h/9n3fFXxEpclJTq1Wc7zMdQeyUcWq
 iJ7jM+wcm0HxPy3iG/yS2C4jnXBHRS1gzl1jEWouK19tE6yJBSdrnvPH+o2dSFVK5h+88EsZ+
 9LEtzZxj6s87VUnR1x5ZiTUHMZJZCrZwPFoRJqkooI1os=



=E5=9C=A8 2024/10/26 05:14, David Sterba =E5=86=99=E9=81=93:
> On Wed, Oct 23, 2024 at 07:04:40PM +0800, Edward Adam Davis wrote:
>> Syzbot reported a null-ptr-deref in btrfs_lookup_csums_bitmap.
>> The btrfs info contains IGNOREDATACSUMS, which prevents the csum root f=
rom
>> being loaded.
>> Before filling in the csum data, check the flag BTRFS_FS_STATE_NO_DATA_=
CSUMS
>> to confirm that the csum root has been loaded.
>>
>> Reported-and-tested-by: syzbot+5d2b33d7835870519b5f@syzkaller.appspotma=
il.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3D5d2b33d7835870519b5f
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>
> Added to for-next, thanks.

Wait for a second, I believe LiZhi Xu's solution is better.

And sorry I didn't notice that until his patch is submitted.

The problem for this fix is, although it fixes the crash, it also gives
a false feel of safety that scrub is finding nothing wrong.

But the truth is, there is no csum root, and everything can go wrong.

Thus I'd prefer LiZhi's solution which error out and terminate the scrub
immediately.

Thanks,
Qu
>
>> ---
>>   fs/btrfs/scrub.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 3a3427428074..1ba4d8ba902b 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -1602,7 +1602,8 @@ static int scrub_find_fill_first_stripe(struct bt=
rfs_block_group *bg,
>>   	}
>>
>>   	/* Now fill the data csum. */
>> -	if (bg->flags & BTRFS_BLOCK_GROUP_DATA) {
>> +	if (!test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state) &&
>
> I've updatd the coment as this is double negation that could be
> confusing on a quick read.
>
>> +	    bg->flags & BTRFS_BLOCK_GROUP_DATA) {
>>   		int sector_nr;
>>   		unsigned long csum_bitmap =3D 0;
>>
>> --
>> 2.43.0
>>
>


