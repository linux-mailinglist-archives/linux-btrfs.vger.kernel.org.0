Return-Path: <linux-btrfs+bounces-11350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495D9A2DB37
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2025 06:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEBB18869D6
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2025 05:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E4F374FF;
	Sun,  9 Feb 2025 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oQJD6K2p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7010F4
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Feb 2025 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739078334; cv=none; b=oQf84cWqY2L2RKAawqCJJRNcZXIn7Pkw9NnZ4LVR5hJJr4msMsQUOLFXATr5Y9u+8Y+HIRi1lwgwFNNMaKQCAKtS9GRPZoZpVt74H1mz9z4wFAkiOrFjVP/CGl1ukHBRCFrfqRwFJ9ytb0+ImQFJWv1k0JqcGblj030ixwB8VOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739078334; c=relaxed/simple;
	bh=UXui7LJ/+IsF3ROy18V8/F7bX7LH1iATUnoJNiPjVzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p665Uf+rsRRdWApF7p3bDClCUId0H/6IkyTCc4GVLV7Sv/q+NHC2OjDlTevfTH0UgoQDzI0E+31uon8pI+5aBfhfH1mCpOjL7nsbMZnRtQ+wVjqIr5YIY7+KiWsk88h5yN+WPMVv3W28XhOaFHHfaJDUTlUrwC/V4p1FGyueFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oQJD6K2p; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739078329; x=1739683129; i=quwenruo.btrfs@gmx.com;
	bh=UXui7LJ/+IsF3ROy18V8/F7bX7LH1iATUnoJNiPjVzM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oQJD6K2pg/VyNqzwl049v9fXONri+59sgAIXm0/Ac5Uvo/hzphL0CoL0uBWhpYvs
	 7R4d5bbzDpLP7jdFeWRU7rUqBfRuN9L40gjDRy7IUPfuJ9gUEvjJS/ZHxP0QVNnsm
	 ZyLchbX0nxjqMHBdEVAUBHHwdr39scNhiDF7s9z3HarxkAvMGfQkR+HPGGZD8nbN7
	 0hnWdN4Vg8GH+vgj+wLIPRGyCh4SkpyylBu23+BgxgPfktWCvIL0OeBeIBdkyIiuc
	 kZVzMxQ1rzOryujhZzrLJbqz3G9BYgPWlJ94HVOYVWXRdNBISV9eRDj2pM/xUO8Rp
	 riQM7xAtWcT9FZvBNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wys-1tmTtM3ONw-003qkU; Sun, 09
 Feb 2025 06:18:49 +0100
Message-ID: <2e70231d-0593-457c-8f02-07f1a08f9e9c@gmx.com>
Date: Sun, 9 Feb 2025 15:48:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: enhancement to pass generic/563
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1736848277.git.wqu@suse.com>
 <20250128013049.GV5777@twin.jikos.cz>
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
In-Reply-To: <20250128013049.GV5777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p2xetkUFdIA9do2Jgi0XGtGQHUGqVE0JYZQxxHHOZSgZxAXuL4Y
 1lwOHJkkuhojnZr2ho3j0sJyJcGgLDFnBwDfTDjajPOGNaCQCo/pMUSO5l+BCgoD6M56w/e
 sVSQWGFlP3h/Wfb02Y0XdEHLSu1cyBTkK+OuYPLulEqhI8YMhpSIECZi3TnrOBLzOLHMRSZ
 /X1tve1+UoZwtESBgSJMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OtuMEJoqelc=;syaet5nWaHnbFAGbpxsk0YGz2w2
 SLQbZ2hfuTa8gh7ZNeTWptxuT/oSzqNgFao0A5Eex5xo+0UZNBYYaZP3CT4OZDi5zLZFCX765
 5AmMULTTEKY4bdR1fLfLsU0z7o4tTfGu7Hm9NIO5txJPp62Xv9GFpfawz/+wHhm9Py5q4/4Kt
 8+tOnco10IjEIYxycHhTei4BTPjbC+nRucLMd0A4/2yjiFSapqixcNb11Nimr04QpRpDctcOr
 TfIGkF2bXf1ReVQuMwzXp8XBYJVYegEMkrC29RCSepTr/mNGO3htXRdIQMkREERmchJm9tVCt
 pA7rhjEUeOkPOVho28yrY41/avZhS99tr/JaznNiCrWHpA446tfgBs115oyhHci6aQt2y4rW7
 vPijLkFRevRJVllwoRmYL66jz3YYPr7xue5VMR3bwiZybCZ590nUBw1BofkgG4dGLE9pzvH/g
 lO8x42PwTGjVGGkEl2LiABzOzOfZ9N8G5EvgimcIXQ8hele8lmxdHc66eqwMjDw8Afg4ZK0Sy
 WgRK0Imh5KCU8NBdqLO1XSUoQ6ehFEouRfBHYIiainNp4uC3S+VuEAvzO+HGfaxjqzkO8npVm
 19krIzIxK1NcKfWDV8SaS/0PAVy9X7lcTwRg5x3kh6k1POvbAhFxQfNqhjhiQK7VhstynhRHL
 5s/P5g2R14q1EG7c5NVOrizfydVZBpY9PLPFIRUkjc1sBKrE4VVeKXkwcD3eOnSUS4ROYj+jU
 RrqcTsLFIbEPkynbIkDkzQT0eNwXAKDUAaV8K8Eb2RacMBJAEuA3br19N/dbuhP4nHmyIwY5O
 C61B5N7IC1+yHyGb0g8tq/azBYMZ5GtS9xwVrWQnaMpnHQZs0lNTFkTGCLRM/ymqeb5oiBdvg
 /zRRmnKqnVmtM7jxZ0a4oQP3Q3YCBnJrUT0bGEcwQ9z+fh2wzr1N9f0Pfjtn3fLNvl9KhxlHy
 UHSdNi7otlCYge7W7nIUdFsgC3BKrjsLcC9keMu4/D5Yz92daoPv8397JTc3hrE0z/j8HaG/c
 JKKylqKvcb1Wu4HdFIbspta2mhrS+HTRsqSgPSz4BhcabyfVKhU+spWxNpEK6AbL0vSV81HZs
 ow3fN85WFcfiRn8dUV+KeLtV8IgmYNf8ehmZGoCEfVilVwyJ5AXRYCJqZnvKUC2Gkf8v6k+Mg
 iDBIvYQDLY6xNmNmR95WI0/NtTNq0nqkkP/Qrk3Vch3G3/yuAHjvkp2eiqwH3w5tcVkFOgAEl
 qfzLbYbyNFbojAf9eCW853rAVqbRGeXAp3duypwaY2AK0L2Kgx+l3uMojlfLYvG8aCFG4vs86
 XyI7ksoomHJMOGqn4tKIXiaL0/e0PdyuRsP5sqs34G6NdsvNGXvOJDMjzaomALZW5MNRiMIF7
 exENfewJsVpkPQlhDcRVmBUafcVfBMwSKS9n2Fch9E42EMCkSV/CcvvgAB



=E5=9C=A8 2025/1/28 12:00, David Sterba =E5=86=99=E9=81=93:
> On Tue, Jan 14, 2025 at 08:22:26PM +1030, Qu Wenruo wrote:
>> The test case generic/563 on aarch64 with 64K page size and 4K fs block
>> size will fail with btrfs, but not EXT4 nor XFS.
>>
>> The detailed reason is explained in the last patch, the TL;DR is that
>> btrfs is not handling block aligned buffered write in an optimized way
>> for subpage cases (block size < page size).
>>
>> The first patch is a refactor in preparation for the new enhancement.
>> The second patch is to solve the possible deadlock which can only be
>> exposed by the final enhancement.
>>
>> Eventually the last patch will enable the enhancement and pass the
>> generic/563.
>>
>> This series used to be mixed into this series:
>> https://lore.kernel.org/linux-btrfs/cover.1732492421.git.wqu@suse.com/
>>
>> But unfortunately the ordered extent double accounting fix is not
>> solving all problems.
>> And since all the ordered extents double accounting is properly fixed i=
n
>> for-next, we can come back to the subpage enhancement and focus on it.
>
> I'll add the patches to misc-next, but until rc1 this will not be in
> linux-next for testing. After that I think it's ok to add it to for-next
> but as usual more reviews are welcome.
>
Filipe recently fixed a data corruption bug that is related to how we
call btrfs_lock_and_flush_ordered_extents().

His fix is correct and has all the higher priority, but that will cause
some conflicts, making the original patch 2 useless.

But also thanks to his fix, I have now a much better understanding of
the whole read path and why it needs btrfs_lock_and_flush_ordered_extents(=
).

I'll update the series soon, based on Filipe's fix, with a much better
comment/patch on the whole read and extent locks situations.

For now please just drop the patch from your testing branch, it's no
longer applicable on any newer branches.

Thanks,
Qu

