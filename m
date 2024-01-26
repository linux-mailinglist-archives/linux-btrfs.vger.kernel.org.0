Return-Path: <linux-btrfs+bounces-1837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 974FB83E4A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 23:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E829DB22BD1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC9F5A784;
	Fri, 26 Jan 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Wun/mJBa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D659B73;
	Fri, 26 Jan 2024 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306749; cv=none; b=hUj3hIxfSxCOKQPblTKIIiWaTyh7E7tBgpSeAKUk0G4FoZzkF1UQrelNUoNNVucI6MkY/YiE0dYVnP4SewnwfzmUwGEA0XOFeYJNKTAHrsoPLNuTH3CeGicsP4HaQhsGm0RweI/FHLT7lyad5UR2jgkLl0JB06PKqI9DHuJmTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306749; c=relaxed/simple;
	bh=quovCUEiBJzRcC6tpz1IJ7bTQOD+HpTMRkt5AyBCYDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VleeToeVxByvQeEBrAFwwdeRNWCszbhyeMHr+nooQOhTNwZgjmivJIkA1Sbx5C3ytL7RRQ+xF7/C4V5q8Ut7ddX5smpUysjKi+YmtpHySj+wBwlvG0jTYmxzfkM3SLlyTUjcx/SqzbHx1TXAlg+kqOPZoVrxQemgJn4piRF00eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Wun/mJBa; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706306743; x=1706911543; i=quwenruo.btrfs@gmx.com;
	bh=quovCUEiBJzRcC6tpz1IJ7bTQOD+HpTMRkt5AyBCYDU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Wun/mJBaip6NFrp5muOf6Z3rJTfgH00zXoLhhDynRnACkx4JPWDXyb8uUYsMU3m7
	 Z6LL5zYt6Ra7p2Hx1TKygWa2V9bJ1d71nhAMH5VffqcJywTvihWeQ4LAIKlW/SANK
	 /10bkttgWAuYKm0ZmgR96PpAh757h/VeQnlFOiyDqYvS064ORAZxHmtRrV4UDw6EL
	 Q3wXDnsdNBHoIt0KzjbgG0pSbugekVBGIrAOdNbzJZdgYPh6kPmAYRi/b3lJ558BA
	 PiQ9eV2CTRE6wIN42ASQN4NZGMNxIhVqwmTmWyGujHlRSP2cG+FnXU5JPievqauHz
	 a9VxRLfkyyMeYvOpcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzuB-1qwLIv3cT9-00dWG5; Fri, 26
 Jan 2024 23:05:43 +0100
Message-ID: <cbd72a58-6d6b-4e78-8028-63e92ad9502c@gmx.com>
Date: Sat, 27 Jan 2024 08:35:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>, Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1705946889.git.dsterba@suse.com>
 <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
 <20240126200008.GT31555@twin.jikos.cz>
 <8b2c6d1f-2e14-43a0-b48a-512a3d4a811d@suse.com>
 <CAHk-=wjhtqo_FEqZkPuOVUNZzsGhjftdcN9aQpA3f3WD0qS1pA@mail.gmail.com>
 <7c4bc81e-51b4-4b93-8cae-f16663b1c820@suse.com>
 <CAHk-=wj1h8GhhEuqmiCMZW7iBu3k7hn3mJSO9kTm7P31BCZExA@mail.gmail.com>
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
In-Reply-To: <CAHk-=wj1h8GhhEuqmiCMZW7iBu3k7hn3mJSO9kTm7P31BCZExA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QPU7Y2ELcU5BU3RNadFFUpS77GELHdeUSviHfF3gCeLc+U8cHx5
 2UAVC+dovE3CsmoNOCiCUjGRFi2PR9JLGhaHt/CrHuzdbYSVRWAbniu57A4qYWmR8bjW+A3
 gaf9UHxbFuNGY1AefNh3pHxb0yPfj4KJLPIZdYUDvJ8NOC0uvjZ90mWAYRa4b27yCG6lddZ
 JKXqXdECOx+FqqrZToZCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AwyVdHZMhf4=;VOAhamGl0dDKzNkWnG+WDmnE3AN
 0dA4NJTNGpPGxs4sAvBxsR5uBoRTkNgmquoFIC6jf6c/kcpczIuioL8jyNhK1mG4+KGmaBcm0
 AqttJUKLQKm/8Kk8zPJs/ulfPuUvLWuY4x0VnB+PFrEfsdpWmmgqkjMxwM+KxLOKtQosaFYFY
 7wOtXw9r71C5JaIr8m1DQBg9RrA+YiPMbHS2d+wJNY1vge2H4egajpiuwyvZu0EodA88yMZy7
 jU5qOIyK/06HdA+7+Vy7ccLh/4xvPD1xk/UwOqlVYo0ueTMXm1hID+OSq37NYYaLVSqA0YXVQ
 DXQ3hSXTRlLJYxYSnFZHjEzhEEmzmTmSa2dtFjQ6RUsMLss4mE/9jftdGyJBN6Gike6s03XdA
 B9jgASrnVlj/cdC0L0YXbDNc9zPYUiXGnddH/QIiEaemBK4KdL3sMxp2+K3/Dq8SRbev23JWR
 iE2MFKp65l0j/BcrBW7qwMfS2Vd+Ng3rAoKH5JzMDeIbuRNWwbjJ7Pu0z0uufT7t7Q7tCccCX
 DNlr1JoT9tyqL4xw/CvKb7Ric3nATWp2dZU7AHwuBGOO7uBwgUNabHMNHzkJm3K0lTDqel9NW
 Rve+T5wv7v5wa9dOyjp+k63hHKO9q5p6ugAHD1ENml0cUGbwviG/CJePJQOaImicXmvhOkIvk
 uLQzF7+Udb4GNQtPbJHp1jxizE3bBWtK6dSeaIW1IUVf23XeA49cDFxd3wBkqgZNGm4xoy6MU
 smt+LKUD+t//4mOEQYMrX/9EhgoSE0KZvBAWdY1yYlX9+PDWo5LZbS7HnYmdhacu8XPVfWQI5
 kYvWHDyxDd/OxO6LSMscT9V6GOzULzkrJ+wa5vIv+i/GZLR9LWGTEHsIzA7fXihlMRAe/tQ77
 ICN+AS1sgLEJLO4xsjEGdR12YfLkKSNn9ncEL6mMBIXq2K1cM5TXx9tWRpBDsHZpVtKWeRlmS
 J9fQteMqi9cOYk+NCQqgq/4Ct1c=



On 2024/1/27 08:32, Linus Torvalds wrote:
> On Fri, 26 Jan 2024 at 13:56, Qu Wenruo <wqu@suse.com> wrote:
>>
>> On 2024/1/27 08:21, Linus Torvalds wrote:
>>>
>>> Allocation lifetime problems?
>>
>> Could be, thus it may be better to output the flags of the first page
>> for tree-checker.
>
> Note that the fact that it magically went away certainly implies that
> it never "really" existed, and that something was using a pointer or
> similar.
>
> IOW, this is not some IO that got scribbled over, or a cache that got
> corrupted. If it had been real corruption, I would have expected that
> it would have stayed around in memory.

Yep, thus it makes sense to show the page status of an eb.

It could be some race that the eb pages are not properly hold, thus its
content changed unexpectedly.

Thanks,
Qu

>
>                   Linus
>

