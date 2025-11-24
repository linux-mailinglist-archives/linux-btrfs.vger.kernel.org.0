Return-Path: <linux-btrfs+bounces-19323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EE4C8276F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 22:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AF72349710
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 21:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A45257859;
	Mon, 24 Nov 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="eV2oDwOk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28423EABF
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018033; cv=none; b=A18X6jjpc7b+kCEHbnVIkkixGdz3ilbXXDv6vU7wMQnT9myyUNFVvfmgWsRTr1N//BqmsIDOrwVXkws4NVZ4olPO6reCV7ciOOuMeyjfIS4CAaHmaumrEzVHQ++KKU5xuk8ff5xDkEnyUq7ZlGEmQoOw4hYSmE5J/X51dfq9z0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018033; c=relaxed/simple;
	bh=VczVc4ihjqyjSZHGQ0wiOnuCj3NrjbHHHaNqEyEFdIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqV5ZAC75QS4VuRJa8kQ11pz+mw+nlMzYyBHWs1vRpvWHG82hWsXjKTRHXDt1acstO1GyatJrg6clAHFKwD7k/CoQpFby9NRXGH5ayzHMlGQ0dNGKoP/IDV5O2u3h27WhSxus8TQPxalQ7dqpSfUmX7SOh4fX+IX/zRH2ZfEpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=eV2oDwOk; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764018028; x=1764622828; i=quwenruo.btrfs@gmx.com;
	bh=VczVc4ihjqyjSZHGQ0wiOnuCj3NrjbHHHaNqEyEFdIo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eV2oDwOkkwjGoYFZBVdXPzyTYhyJYS34VBLIk/2zBmcxA0qipCkP4xhprNpBXWlk
	 wJmQy2YsaxOQj8L8DccVSnvY+MxZJeg5tvRmod4jIxis0DSFNZ+MwPFl/DcuIcRWk
	 Ilu2C4jVi66aNP/WFwbuVy0Nz6+e59KoOQFr/oW7eCcYIQyzJXtDMHdN+AWdUbJkG
	 w4oUk/Kmi0X0pF+ZfHQh3xVEbS9UnZ9B1dRL0RPKFLpQumfbzBD1DVXBSOPXLlYGX
	 02jSKL/yNpOimf2s3fjdTQsrkrmDlTT8FLnKjBvcBNCNi0RBVEadmVFo84azoPgQS
	 hZUsx/QB+z1stn7TLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzhjF-1wIv7q26qn-00rTkW; Mon, 24
 Nov 2025 22:00:28 +0100
Message-ID: <959f1a72-9b40-4489-922c-98d17d328253@gmx.com>
Date: Tue, 25 Nov 2025 07:30:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] btrfs: make sure all ordered extents beyond EOF is
 properly truncated
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1763629982.git.wqu@suse.com>
 <5960f3429b90311423a57beff157494698ab1395.1763629982.git.wqu@suse.com>
 <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
 <21484358-d1dc-4c03-837a-28bc57c80fe6@suse.com>
 <CAL3q7H7Jb5t0uFYk6hJDydNu6DH5rNnPvRKOjfOCVbtqR=mHBg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7Jb5t0uFYk6hJDydNu6DH5rNnPvRKOjfOCVbtqR=mHBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m4eb+UHilnKTkSVQHInwzVWQ4qqNaBtiLRcGVc0pM94gCszxWay
 SeI+/yBvMS7mnxLSt9zWItAdQqLrxBUmmrsDL6ltx0yZJTKP75lPf/miBpk56J1QCLij8zw
 yH/Vz8ux8C4ovzRTOYrNx9a4HAHZ6JNso4I2kFmFw4RbXOFWWzWxjl88i04oduBZJ+cMk4O
 R3rXZAMVgF/3qbQJqnrTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W5IwJUoWIcE=;LBE9C7OPCyUAHcy6mzlYzp/4Ve0
 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
 ULxTmuaUigDJXNAfc=



=E5=9C=A8 2025/11/24 22:52, Filipe Manana =E5=86=99=E9=81=93:
> On Sat, Nov 22, 2025 at 1:14=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/11/21 22:25, Filipe Manana =E5=86=99=E9=81=93:
>> [...]
>>>> Fixes: f0a0f5bfe04e ("btrfs: truncate ordered extent when skipping wr=
iteback past i_size")
>>>
>>> The commit ID is not stable yet, as that change is not in Linus' tree =
yet.
>>
>> Thanks for pointing this out. Now it's removed from for-next and will
>> resend the series with proper upstream commit during the next merge win=
dow.
>=20
> Instead of waiting until the next merge window, David may want to
> include this in this one, in which case no Fixes tag is needed, just
> mention the patch's subject in the change log (that's usually what we
> do).
> This way it will avoid backports if we want until the next merge
> window (for 6.20).
>=20
> Or may be included in a pull request for one of the 6.19-rcs.

OK, considering this is a bug fix, I'll resend this patch (without the=20
whole series) with the Fixed tag removed.

[...]

>> Although I can definitely add an @end, I'm not sure if it's improving
>> anything, considering it's only utilized twice per loop.
>=20
> I don't think it's confusing at all in this context.
>=20
> It may be confusing when there's an end argument, where we may have to
> check callers to see how it's computed to find out if it's an
> inclusive or exclusive end offset.
>=20
> Now having the end offset stored in a local variable, it makes it very
> easy to see that it's exclusive, especially for such a short function.
> I prefer that than open-coding the sum multiple times (3 times in this
> function). The compiler generally optimizes and avoids repeating the
> sum, but it makes the code easier to read and reason.

Got it.

Thanks,
Qu

>=20
>>
>> Thanks,
>> Qu
>>
>=20


