Return-Path: <linux-btrfs+bounces-11460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E890EA35636
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 06:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBDF188F376
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 05:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA11885BE;
	Fri, 14 Feb 2025 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C3JkBRay"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6200F1714D0
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739510827; cv=none; b=ZsGnVCfpspYj8vDavgceLFi4xhVOR532sYv7/ehFqqsEBuZJWM0YyX1RkawsQeikD6TOa8li+sMf/MpUoO+CJVhG4LM/gDod3zgfaR10eETEGt7m4a9A5Oq9JXPS0VR/G8hjkmWa2TX6CN9b5U4OaPNIXdMQnZUPEBGUFeUZqEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739510827; c=relaxed/simple;
	bh=ktg3RKPjGRipdQPnZkbC9fgAWDMo1NrSdXdxhTrtdqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ujSpVrlkq7Y57IPsdiBCg/KZFpKCjcc8LKurKJf4ogGPtcCKG83tjIG86uUPRmY7MSGDJdy2qnz/uD2uQBIMFNWidd/OPgefvOGF/hx6EGJUGdtiEt+3dPJ0O+BQxu7xPIY7VxYnTZOymheOba4exi8hcTL1NqmxM/kj8EC+aYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C3JkBRay; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739510822; x=1740115622; i=quwenruo.btrfs@gmx.com;
	bh=89yAf0YEx2pm9yhe26mWegXeJ3nAxqc/KyUhFuQF6/Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C3JkBRaykkFETBKVlnipM3CHZWOSXakpLp6W4gqffBj9+0VOLx8XpkmrA4IyKi1/
	 zMSVgb1ZeBEHm2r9VCHMwY9hLR3emVVBwJ6O3Yfh0ByoxdoE5i0cQwsoOBW0eH6Dw
	 YOymPQF7/klXFYX4aeA0X5bUue4XyixCsmiDRsMWbIWsLO4N2D2qMwjoWYgSKld/I
	 lCyx/PSfLZDlly6lihcGR/V1wfgGXM01uISOWrUIERBshUB/rqhv2IoCMS02NMWtc
	 uDUuShaLD8kaDjebGVRWypD+9T8FgX4raVDQzgdZggkn7yWNNSKn6aGz1x+XugCDr
	 hj6M5gSUGDXqeOQijQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N17UQ-1tFV640yvi-00uM29; Fri, 14
 Feb 2025 06:27:02 +0100
Message-ID: <db20af73-0b5d-4327-9393-929173d4f91d@gmx.com>
Date: Fri, 14 Feb 2025 15:56:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG report] fstests/btrfs/080 fails
To: Glass Su <glass.su@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <30FD234D-58FC-4F3C-A947-47A5B6972C01@suse.com>
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
In-Reply-To: <30FD234D-58FC-4F3C-A947-47A5B6972C01@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fM0A86rZrY9HJiIjatDYx06NgOi0PgjcM9TsirRXc7knxcO0ZHO
 KB59vhgKiyCnDk080lxHCYnZVY/4neWPmN4saL3SzyV4Y93cvJcYFlmsj9l61WKaJHBNLIt
 Bb7WF+OajR1sWTOsRjT2BwMS9NfURt9D2lunv5pmIRjtVcXeRmAEtHJ5Azz8iJKf2CDM8LY
 xFgXfd8DVlR3rGV8COt8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x0Kif7IlMGE=;oH5/ON0NLTtDEWt2aIqZF5NDKca
 jmtNZhK8PLxL4nD2d5tNbG882bqf/YU67jhqJ2KcUhf+iDSi6Sme8rRh/C4ovbDxs26dIZ2PU
 Ys430zHUmdt3u7jY0nsFaaw5raLWg7owVZ7HyR8vAR8QFaoUDrF1q1RwLUiTZi7UnWPhFf5F9
 h7/HNH+4VUPuA8Lpndji5/gJT+loYf8ujYd2PhS9ZKg0yjHjm4NkV1kOw9BG2UTyUXP795c3k
 XC9MbC+fm3Tcc8rOJ8cRxlADjiAXqabVgV6a2EItSJJ2Fxig3wxWaxpZ7k72AwFSIiHIqXaIB
 P9oSrcaLxt1uRW6FP/l/ovCQobg9znEAYxt0w5P0oGC2gZ6oJom2ZWLcsAllrl5dDRoUzKHkB
 Diqnz+VbVWz+JFkjBDgsJS0BDO1h1qcIHZ3789BOpPz61z6UY0UY6wGl0H52wDUBaK+ptBpSk
 0+P3I3vJvnFcChC6HKr49//SYZMF0d43R8ipb3kFoAWsZ4eyXjEJglXavzPHhrLhAMsX8MsAS
 OwEf7LJILySrybq6srPnDq7mWUZ66TE0z8QfmTiLzg3CSxx4EN9irQkM0x+QUewCleqXmLSq7
 pvgFWgvv6Bl6hLtizSbiEl1NaKhfmLrUxr3RUNAXQH9PVfo1Rtg/sEXp09EcQ619EbJ2OUw8f
 hJorHwMig5Ig0gNEhaaWSHPbx86J6doCrhk1HNPCiyk/tzgpE/NHk9RS/70W3jm5JoXcSmWP0
 mkP/KcQv2c5aDmwR+dNZboQWQnE36dD+ElrOVrkKezhY3PTZrETeu5OKLjrXDOiwmcCFdoNew
 IwLTAn8T4UxW9iH7NfxHR9H+0Vy8K6Si3uyly7Tt3Ff8t7xMcAcvNzwzBazeNVm/A/q69REUD
 W7I+H4G1QN2892G90r7YVyW0Kt0Wj9hx+qdV4vbTmIaoP/bfpPjZc5xFBj2PnmsheLbPHU3HH
 9DeWa33k+gYVe2hy+juirjVNWi3BQEet7jvs9FXM9js+NqPhLDZk+fxXCCyLkkC5eKctjN+Og
 r9WeeSvT6BBBh6ZwA/hxzLgdzrhzLIt5Ww3KtFVOYUFLMV4lzrYK/h/O1ZI6dY0cQaSMIy4Fk
 Qo+HebY2x00FFewZRTeF7BJTJZF4SYeKY5USrbrE9XTbBVuTqIloe1n1tVEHXGrBQAYb1CAHr
 Xp1K/P+TZlMIHt3KOdzTgs1BBO/V0ZV6dTMAfcu+SNeCGOdUB/0VyUgEF7RSzlcTAqhiHvW1Y
 +tG21QKlfRK145trUpTBuNMpE/Z0rkJxWUunsWsIvY9l/b0xLg1UmOOCaPlBa5qHpZsjzZQqw
 +H+ZvuUMpSpbCLRNkTDK2onPEAf/A7SDsFa4w1QsPVcILlLk568de9Jpphyr9ivMP1mQfX6Fm
 jlfC47zXzGBKIOMqaND0oPl9bSd8PWq7SWftbkpV5cr9bclQUCoHRxfBeA



=E5=9C=A8 2025/2/14 15:41, Glass Su =E5=86=99=E9=81=93:
>
> Hi
>
> Recently I found btrfs/080 fails like:
>
> btrfs/080 124s ... [failed, exit status 1]- output mismatch (see /root/x=
fstests-dev/results//btrfs/080.out.bad)
>      --- tests/btrfs/080.out     2024-08-29 09:10:14.933333334 +0800
>      +++ /root/xfstests-dev/results//btrfs/080.out.bad   2025-02-14 12:5=
3:24.667572260 +0800
>      @@ -1,2 +1,3 @@
>       QA output created by 080
>      -Silence is golden
>      +Unexpected digest for file /mnt/scratch/12_52_59_984815662_snap/fo=
obar_39
>      +(see /root/xfstests-dev/results//btrfs/080.full for details)
>      ...
>      (Run 'diff -u /root/xfstests-dev/tests/btrfs/080.out /root/xfstests=
-dev/results//btrfs/080.out.bad'  to see the entire diff)
> Ran: btrfs/080
> Failures: btrfs/080
> Failed 1 of 1 tests
>
> It can be reproduced once in about 20 times on v6.13, misc-next(HEAD: 1c=
08f86eeadab89e8f6ad8559df54633afb7a3ba)
> in my VM with 32 cores.
>
> Configs and log are attached.

I checked your kernel config, it looks like it has a config that is
known to cause problems:

- CONFIG_PT_RECLAIM=3Dy

I'm unable to reproduce the bug locally, with 64 runs.
But that's with CONFIG_PT_RECLAIM=3Dn, as I use that config to workaround
the bug.

Mind to test with either that config disabled, or apply this hotfix and
retry?

https://lore.kernel.org/linux-mm/20250211072625.89188-1-zhengqi.arch@byted=
ance.com/

Thanks,
Qu
>
>
> =E2=80=94
> Su
>
>
>
>


