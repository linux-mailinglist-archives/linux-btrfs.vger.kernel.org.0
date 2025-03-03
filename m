Return-Path: <linux-btrfs+bounces-11976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E4A4BAA7
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 10:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DDC3AEF07
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862151F0E4F;
	Mon,  3 Mar 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oyGqfY9V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D921F0E2E
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993597; cv=none; b=jjh8Gqq57fREwieLY1k0fW7bEx4jJOeTEdXHgbB0QUNWn3ps0pM70Hgu/9gExFGlcL/mi+2dsQKdBRHYt8v7VSZsPlVKy/4Je3T5GPZmPSvOoJYG1Wxqm4F5Q4QM8PQqVQlTiFrC3c3aaOVkhs604TtSTICqSg8owsVSfEo7rLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993597; c=relaxed/simple;
	bh=R41IJJoHlR8K/AqpeokK5+wPY776/wCC+LY8SrLlfTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSKCce7jDklp/5AZVjqHKbJ5OduloAXaEHlstl7Qq/Ls9P47EEnoYTpjjHH+k6VLETK0/hrXHF5hIrPyK+JizhZ6fifQHMbGN7E183HWzU1ZXcFepP7VaJPDL7R5txIOcm/H3iVBisqt6rb7dcSbFtSJm4lY3uC21uRDIPRJzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oyGqfY9V; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740993592; x=1741598392; i=quwenruo.btrfs@gmx.com;
	bh=WiFXqdAeDC70Y4mDV7ANo682WQeuTh9CRSlEm9NRKv0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oyGqfY9Vmuxyz08OrH5UljFoVyLkoPtethYAN9SZznUrQMBpN+mG78EYQGKFJzdH
	 2OPP5lItVv5klf5KH1i8SCUVM5eTUaArXYoGirSj6b1Zmr4WbcdWPxPcRxj8cjaJO
	 reYSqZ6SpKdrfbdffXvgpWTq9HAXJO1GNVqhjetnow2LYT+GzK2ba1hShc4lG3Oeq
	 uWHPctKlbJge/NzSFPfcByljtHTY5sF/jSRKs+IgXCbLA1UiQJs8Gqq7wYk3fhpJD
	 6Uo4E03VCNfz6IDPZ1yc12k4Lr6q8AFsazvjdThAOcccpU6TAIJ5VDsVU9NCFV815
	 bBNr8SzB5TP5C8/kOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lY1-1tpJDA2r11-006tVz; Mon, 03
 Mar 2025 10:19:52 +0100
Message-ID: <ae03b6f9-bcd1-4676-ab50-1d78c44f1a15@gmx.com>
Date: Mon, 3 Mar 2025 19:49:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] btrfs: make subpage handling be feature full
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1740990125.git.wqu@suse.com>
 <20250303090102.GU5777@twin.jikos.cz>
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
In-Reply-To: <20250303090102.GU5777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W8jXphmQsd71a0FY4HrzsHDlTvY9ab9Ivr7cdWFZyf2jOZpnIJa
 4LptQqUDstNfILccBCjzwjK+nB5KCr0sy32rfBVCHjzrvBRCTMs2NGmN48CoZTvM0LoeAuV
 siDwBSrC3TH7tyZYm9sZWNaD3YBLG8a2+ezkGWaAJ6dunm89hCl1QVlxdFAA//wTLQFJQbP
 bLNAOg06TDMXW/BNQ5Elg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7H/sklS2JaI=;rUQUYv3ifVGOIQmY1KSr8fJ4ZXC
 m61jB8vZPtQtAaATK12f5NZquPGf16b+2tqD55G+gSMZ31OzCKKlDcc/LjLgy+QHZdwqYw+4I
 G3Ekp58Gub2Nl1Atuiw4lPz4ztKvr8v0hFlTNfNTe368YYTJO63fxjj4r6DmgXxz0+sJimCh5
 MpkCXMIEr7NvhWHnNH5mx+iLus6S+c7fLYUfpVovN8DfBeDWxo96Nlsd19uXeNgcdX3PspFGz
 nMDkUTL5F3XfMAVhbTKBwg2jE3+EdkISo21CUy9FM2QwG4KKZ5uNNImBTbiwkNnB+wOV9L3cq
 ulFo1f4L/VxNjV0MkoAYEmzLN8GgrV/64YDXcB2g8rLUbU0drVwVmbubcSWHf5LrVMu2KIu+5
 P0KimERGTEyTBAoujlMGJgMTi4/1hbt4pH4hd+hzdqssA4HBlcJeNBAH2KxYhg66OeiPAdoft
 BdqMWZourxEXFuzOSRQ5H1ve6pyuqoGMLpYvU506asKbPqf5BH9bwNVlkOKWZ7VMi0qDDcU1/
 jxpdO5ubzR/Ne1/9/X4igf3oM6MUFkYLJgIOoY1sYNwPYmCF5WIsQzOgmHMHszNJYTJb8Ry2v
 VhUhKg8GtAnX4t+pvPw+5FW+iiSvL1FOD1Qu0N7rjCypRrsexWiryM3Rc7wzUQfyoSTOWIrhP
 H+ZKCFIhPD//5kz8bcz58zUcGRr7Y9v+1eG4lRqCfx3M+7pDODZAXUJLX1hgYyLwO4SbHdKCG
 Lc/fqNKZH4b4bbYAbYh9zLZHa9PMch+8OlFM3Mp2N6wnIXvR3FWUY/FWJxkeDfFpCUDrHDHz+
 AMycl28Tj0+W0LCPK7BSrXtH8ud6wWTkYLpAcQ1QZKXDpkol4TFzzwsae9d19AVZ+ayRN5PsC
 TevWuOIFnIpFrviAnBn1vcKCKiBiSbGEMi8E5tusQhijVXgX6BdQ4xk4h0Wknv4oQeXG/U45d
 UlxzUYpaCqX9fXyYyhqYsuwRkUfokOfYMtRW70QEy8jTc9c4bsQnqpBcn1Okqlc9FteG83Nxt
 3jD1OtO0vJpOSAOT3dfU8s4FG8y3n+24fDSVTrphNR0Q/vWCaXGeEXUbqXM3fWMZAZC3NWf7W
 +MRdmYfuEE1fOUAfHbfZxjwz6KPaeOUUx7AcBiE5IH0Mi7wcD1hIUiHw2Do+LIFH9vCto7vRy
 KXChDWn9WBGb5xagXNy8Eh72uBxws+vA2FbdT2ExCQYoIBFS0QYZ7ffl6MLV8fSpe6lTID0Vd
 K6uPKmInes/EI0p0xQLbt7ONaKulu7BNSPodldPheMFwEsBE6SpTkNe9awNM/kwGsbBZKnJzJ
 BFnJwfskDgsVcD47bSmO87iBjRyplB8Gzbipvq9f6A5oWGEftEiv0p5JK9rocKLKl3ENX6Fdt
 rCj3+khXB7CpDY8Gyf5rh6RgA2dHLdysRK4c0fYgQsdExDDrEnMC+RbYha



=E5=9C=A8 2025/3/3 19:31, David Sterba =E5=86=99=E9=81=93:
> On Mon, Mar 03, 2025 at 07:05:08PM +1030, Qu Wenruo wrote:
>> [CHANGLOG]
>> v3:
>> - Drop the btrfs uncached write support
>>    It turns out that we can not move the folio_end_writeback() call out
>>    of the spinlock for now.
>>
>>    Two or more async extents can race on the same folio to call
>>    folio_end_writeback() if not protected by a spinlock, can be
>>    reproduced by generic/127 run loops with experimental 2k block size
>>    patchset.
>>
>>    Thus disabling uncached write is the smallest fix for now, and drop
>>    the previous calling-folio_end_writeback()-out-of-spinlock fix.
>>
>>    Not sure if a full revert is better or not, there is still some vali=
d
>>    FGP flag related cleanup in that commit.
>
> Let's keep it, the more compelling reason is that we want uncached
> writes so we'll have the groundwork for that and ready for testing.
>
> Do you intend to push v3 to for-next for 6.15? I know you removed the
> v2, we can postpone it if there are more potential problems.
>

So far my local tests on both aarch64 (the usual test VM, 64K page size
and 4K block size) and x86_64 (with experimental 2K block size) shows no
problem so far.

And this time I have looped generic/127 for extra safety, so I guess it
should be fine this time.

Last but not the least, the analyze can explain all the writeback
related bugs I hit so far.

I'll take one or two days to shake out extra problems before pushing the
whole series (with 2K block size support) to for-next.

Thanks,
Qu

