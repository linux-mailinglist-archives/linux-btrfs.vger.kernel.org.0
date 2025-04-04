Return-Path: <linux-btrfs+bounces-12794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C66A7B871
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 09:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E28E189C0A2
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 07:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9663F191F98;
	Fri,  4 Apr 2025 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FQZxKWBw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822FA18FDD5
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743753273; cv=none; b=mHLA/NIHiypr/z1iNDdrJ1QROlSTmOvLF3rpjkEhB6bG5Ksa3WywuzOLaY7eaJK9XNWQIOth26vFx3eWYQpprvKmzWUcBSu0EIIbCyTWItpGjoKO9/y42ycI+rjCdTfOMvpsDgAuBviiEdFKQ2x3nmHz9vviIHWgy0x/j0GH1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743753273; c=relaxed/simple;
	bh=RIcHR4p8WaDNXMNHcYzzcs70N7OaYxXr8XdR739Vo4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fcsiMyosgisce672Q3xvP3/DFk3KnKa7Auw0xZRn8T3uqynpdDO60TlQmCBRHWEHu6pY7ohz3vYw55kMA76tmbLAIqlFp5es9qZUuTT2LK4l+OQmnsGWPFzY80sd8StlqvBjmhYiNfn/7eE8jX9YcwMDQ4jdBo22XdLYfjbKn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FQZxKWBw; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743753269; x=1744358069; i=quwenruo.btrfs@gmx.com;
	bh=L5+Zc34mhd7UwnHT1+HzjD8VO0S12QMVq0gg/oGH5KU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FQZxKWBwY+ucGoxAZlV5ADhIwpThIyuHAuzKqV5VcnMVLdfq8FGWvaX0rKmzRQ1R
	 LTowwWC2QFZyq8Z8fHo2rEw7tld5N0ZXUc6/NMja9qUm/X7swiUWTpHm3iiMnlAlM
	 xcoandIlZrM/ZwOUUipnPkVNL7ehutt8ahUHizgLasiNAVMGUUl+Cpm8Sdhi06ZEm
	 w9Th8B/aO4zWR8WU9129uQ5FWkJ0gY95AtdRIUFYDIJnlgRBUwiVoQS8Cc3ue3suh
	 QHzmKRJXSOqKWOurk2yS7AS5TtcKeaxdzTDGJOpoUBZt4czgwRci+eELxLXX1JEp5
	 G8WwP/lOYq7AI7QWwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYeMj-1tdsM33tJL-00QMfY; Fri, 04
 Apr 2025 09:54:29 +0200
Message-ID: <ad298eab-b9c9-4954-beb7-fc09b238ed23@gmx.com>
Date: Fri, 4 Apr 2025 18:24:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: A lot of errors in btrfscheck. Can fix it?
To: fperal@elemariamoliner.com, linux-btrfs@vger.kernel.org
References: <CA+n7ozwhzdWs=KaBQh2miNwPwYxqBi+MEb807kddGNUZAOyNEA@mail.gmail.com>
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
In-Reply-To: <CA+n7ozwhzdWs=KaBQh2miNwPwYxqBi+MEb807kddGNUZAOyNEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/cu/h0Ym+Gs6qV81bbOKF85+bUGQJ3EJVg5stuRbeyK942tSnL+
 b1W5NrF/is+b3TG+nVsv5E+Tn7tgGblLIsZg16438waV8NiduqMpKfP/cM0+Jwo2VPGhgkP
 DYH6My/zCQXpMtT2H50zq4Y5CLuN/0t78oqWz4qtRZctCpEf7WwsSB0hJra3QTLXoOO7G5K
 2V4ebndyENE1Ka11mdqfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xyqPTCviXRo=;GCdTi9r4EibfTUJblHpw3h0TNjc
 WxzbFV8TKhmX3tnSS3PEY5+AkI7CTAztxNPjtNj1ePKkW8mun0oecEbzm1B8BkX4dfWOkBpMJ
 qpArQWd2mCSinWZTXHFcLzW544LTVr5ELvcXSaPBCN6swu65wrQ/G8xIoLhBKzgFa408NyIRy
 j93yuMOQ3MYTaBtgxVgbzGX3VSxgxpOpSOdoLMO+QMuhFl8mqvAU/CYJ2ok38exdQTMGB7u0v
 2REEodQ8KylIoON3LVGKpaoE8e6UIp36WFTQS5FrvG3BazInpD4ZzQ8ju4wbwTv3wpOQvBA8J
 8u/DeE3kvQlrLbY7v4dXQqtvulaJZDoCcdAIj7cFnTDFP6+IFK0xilfh9juWZRfipk2UqQ1Cs
 F2xSGZfTMqiyT92B2bbglqwAycGyU2bBiZlH7WoT4BchWFonaC3oFfeAPJLBDUVpFZyErViIL
 paACUBy3UJzLBvio7LxKjrqUCahdPt9AD1CjevyfUple/TEmQQLx0/ZxeH2L5vUNzr7XlLfdF
 CjxqSdASiZYv60Ec7JtDJxdrhYEVp1oon57gm8k6UblS9LFT9tIwK0ZEkICzKcbxveUdvnDCY
 Zv2k5ixJ1Nz6X2m77G71+VITmhl5ume00yUAkGcY+wW86x6p7jgh1vDAysyaoIcGiuLpyU/pI
 IsuKwu3Ln0CMkwYHvxfyfxrnqnDyaJhlXHmGJRqi0353x3dKVsoaA9vZfvTc3Ed598URKfaiO
 e6YFHK94vhHu+ipevytI3sRjiI+5qv3jXbmn3q/P3ce/uwyJoLu3XK9y4E1/g1kwAD5R8Qj9X
 e47tsUU5KN4vty4S2fFxty6K5Rkw8cFABCfwgvECZNPxFbuh2YPaYzyFHG5tmqBr1pChJ+4wo
 PnLJHhaRg2gCNHpouB8y47+ZhDOvak1X3FWu0xPWIJHNOAmHA+QLe2G5Iip6IDezizC6mRvs7
 DqrK1aliGT2pKqCUKy5N8foJqY36JaYmRw2ROYPGE5HY7d7n5SykbwUJwz1CbKu0VKgVNi1oH
 cE/zRaiBJpLYE9kKjdkn8q7vvHnzCZFHEwfrjPhpbSQyrXgbkLawv4QnC5MXg3f6RBKj9eACR
 krQLf7/0mmogZ/WCJbUCbHiEFe/jjH9sounAsiVg898yKWdKP/72cBjTAiuheSVMUsoaq4sTJ
 ZL69Lavm4crSKTAZ5dlV0x2eFGNjal1LIsDdlTozalCyKzyffbrbs2texqzxGp/lpLfmzwA1D
 FtUO/6HDsHSdbhktlRbszNRliKWjWxelD61kRN2OnxUs8eEEABp7MgPgKjW7Y/RTPk5WyQ+eb
 W9r1PBIt3qhal22DclPql/ryE58PtL5RShEifUosS2BlBEtSx7audiwlsQxJzQK5a1SboRjmm
 Hjxwx/57CYBf7v4k5mLQlYxJPwoCImfj9V9pWoUAF9VZOHy+c5K8YoD97l/Gbe2vnmjeRNlXu
 lY87HKg==



=E5=9C=A8 2025/4/4 09:00, Fernando Peral P=C3=A9rez =E5=86=99=E9=81=93:
> Opensuse leap 15.6 with btrfs in /dev/nvme0n1p1
>
> one day fs remounts RO.

The first time you hit RO the dmesg is the most helpful.

>  I reboot the system and all works and i
> forgot about it.  Then some days after it happen again... and again,
> and once each 1-2 days.
>
> I boot with last opensuse tumbleweed rescue system and run
> btrfs check /dev/nvme0n1p1  > btrfserrors.log 2>&1
> file size is 7MB (72000+ lines)
> This is an extract
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> parent transid verify failed on 49450893312 wanted 349472898974925 found=
 820429
> parent transid verify failed on 49450893312 wanted 349472898974925 found=
 820429

Although you have ran memtest, the pattern still looks like some memory
corruption at runtime:

hex(349472898974925) =3D 0x13dd8000084cd
hex(820429)          =3D 0x00000000c84cd

BTW, the 349472898974925 value looks too large for a transid, thus it
may be the corrupted one.


Not sure why but the lowest 2 bytes matches, maybe an indication of
random memory range corruption.

There used to be a known bug related to amd_sfh driver which causes
runtime kernel memory corruption.

But it should not affect the openssue kernel AFAIK.

So I have no idea what can cause this, especially when you have ran
memtest already.

[...]
> My questions
>
> Can the fs be fixed?

Nope.

> Can the copies I have done be reliables?

 From the fsck, at least csum tree is not corrupted, thus the recovered
one should have csum verified.

So yes.

Thanks,
Qu>
> Thanks in advance.
>


