Return-Path: <linux-btrfs+bounces-15842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650DEB1AB12
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 00:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843451758E1
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 22:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74F22900BA;
	Mon,  4 Aug 2025 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="G9KOZDuU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0C23B0
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754348028; cv=none; b=abotZT8cdHbBPgRC6dbgLTSvLbVeUfw6AnZGTOyEOd4siwVsUz5r3mGs7yTPk81N3neWWWkDyKhPgKY4+9jJ8YZ+mU/6oaTuvgGbDtOyeOI2c6xgviK12a0yuF1X4MeQvhROsFZ+OHx1C8jUZ7144ifdHxpSS9t1fuFctqBhlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754348028; c=relaxed/simple;
	bh=cM6x2exjQ9ii9BTRuXKHwdISgMLj0FPDpRoRDploB+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ub9S3W9lHwt2D7jC0OsrYxk1vWd/XWixSXnDyFxrOcn+59gm/VC799LTSciXZFVp92scneVe8amLBGejZf4qZeqe4YXNaR+eR6npj5K+DyICyjcB5blYeqtatpoCQURk+VGGfbmWBz7xmv+RhbFQ9WON9y1bB95QzT/9twrc8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=G9KOZDuU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754348022; x=1754952822; i=quwenruo.btrfs@gmx.com;
	bh=l1bTkyncDrat0E2ODZ6kN/y1/5Sr5yS9t1WuWb0sKic=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G9KOZDuUHwp/FwF2uenKXhT2hrXmiIkHZYDyTFlnqInNGA7qjlsXmsTnlSdBZpnz
	 5KmHVJg43VO2vIf30Q7S7WSoawg3CZZaH6kWv9PhCzaxCICGrYmOo84CrYUoYPWtP
	 YgOruje25mWo8p7e4QC3v89Q1Grv3UErIpoW9Bk9i4vOgfPUecnuQyafTAzK7LNnO
	 8wvOc0e60aWKL3az07yswZNUjv5psiZfa8gVctExoTfStI/SKH3yf0MegwyCaNJfR
	 2ReHctROG8zum0M0dB549FxQIiSLP6Lt5TXbJ72bkHMUPgrLjRhBnd3KdYn/aafEP
	 qxH6Z5i7p6+arkcNsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSt8Q-1vDLPn4BI6-00Z9Kh; Tue, 05
 Aug 2025 00:53:42 +0200
Message-ID: <b4b30675-5636-4d6c-b6c9-631c7f87f6af@gmx.com>
Date: Tue, 5 Aug 2025 08:23:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] btrfs: keep folios locked inside
 run_delalloc_nocow()
To: Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1753687685.git.wqu@suse.com>
 <a5a3c2f37bbe0b32ffaa8a15a85515ab9f173a28.1753687685.git.wqu@suse.com>
 <20250805063658.ED67.409509F4@e16-tech.com>
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
In-Reply-To: <20250805063658.ED67.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+6VbI5Oim2bJ8TkCfQf/AxtqbYxPZppM1XfYVw5Sk0GH6jwArEM
 012CEsqCRySm2MWNgaZ5bfQTkXsEJCwPW6TYXhpg7dae/LUlA2/6lKXadF/PR7h0AD9f5Xd
 xcoqASFvtkvKuqvXBNo4BhzgPTqhWOJzn3ShQVdUwc4sqsxsDgh9asSiCm8ewrixqGodeVw
 lNU1c5sbu3mhQRDNNbwGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aIGj8+385wk=;awIklXlTUmrSvnp9T/QPNfLgQGn
 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
 n4MD9Lu+7ymuAMKbc8eiDGDZ4WCb9z0k=



=E5=9C=A8 2025/8/5 08:06, Wang Yugui =E5=86=99=E9=81=93:
> Hi,
>=20
>> [BUG]
>> There is a very low chance that DEBUG_WARN() inside
>> btrfs_writepage_cow_fixup() can be triggered when
>> CONFIG_BTRFS_EXPERIMENTAL is enabled.
>>
>> This only happens after run_delalloc_nocow() failed.
>>
>> Unfortunately I haven't hit it for a while thus no real world dmesg for
>> now.
>>
>> [CAUSE]
>> There is a race window where after run_delalloc_nocow() failed, error
>> handling can race with writeback thread.
>>
>> Before we hit run_delalloc_nocow(), there is an inode with the followin=
g
>> dirty pages: (4K page size, 4K block size, no large folio)
>>
>>    0         4K          8K          12K          16K
>>    |/////////|///////////|///////////|////////////|
>>
>> The inode also have NODATACOW flag, and the above dirty range will go
>> through different extents during run_delalloc_range():
>>
>>    0         4K          8K          12K          16K
>>    |  NOCOW  |    COW    |    COW    |   NOCOW    |
>>
>> The race happen like this:
>>
>>      writeback thread A            |        writeback thread B
>> ----------------------------------+------------------------------------=
=2D-
>> Writeback for folio 0             |
>> run_delalloc_nocow()              |
>> |- nocow_one_range()              |
>> |  For range [0, 4K), ret =3D 0     |
>> |                                 |
>> |- fallback_to_cow()              |
>> |  For range [4K, 8K), ret =3D 0    |
>> |  Folio 4K *UNLOCKED*            |
>> |                                 | Writeback for folio 4K
>> |- fallback_to_cow()              | extent_writepage()
>> |  For range [8K, 12K), failure   | |- writepage_delalloc()
>> |				  | |
>> |- btrfs_cleanup_ordered_extents()| |
>>     |- btrfs_folio_clear_ordered() | |
>>     |  Folio 0 still locked, safe  | |
>>     |                              | |  Ordered extent already allocate=
d.
>>     |                              | |  Nothing to do.
>>     |                              | |- extent_writepage_io()
>>     |                              |    |- btrfs_writepage_cow_fixup()
>>     |- btrfs_folio_clear_ordered() |    |
>>        Folio 4K hold by thread B,  |    |
>>        UNSAFE!                     |    |- btrfs_test_ordered()
>>                                    |    |  Cleared by thread A,
>> 				  |    |
>>                                    |    |- DEBUG_WARN();
>>
>> This is only possible after run_delalloc_nocow() failure, as
>> cow_file_range() will keep all folios and io tree range locked, until
>> everything is finished or after error handling.
>>
>> The root cause is we allow fallback_to_cow() and nocow_one_range() to
>> unlock the folios after a successful run, so that during error handling
>> we're no longer safe to use btrfs_cleanup_ordered_extents() as the
>> folios are already unlocked.
>>
>> [FIX]
>> - Make fallback_to_cow() and nocow_one_range() to keep folios locked
>>    after a successful run
>>
>>    For fallback_to_cow() we can pass COW_FILE_RANGE_KEEP_LOCKED flag
>>    into cow_file_range().
>>
>>    For nocow_one_range() we have to remove the PAGE_UNLOCK flag from
>>    extent_clear_unlock_delalloc().
>>
>> - Unlock folios if everything is fine in run_delalloc_nocow()
>>
>> - Use extent_clear_unlock_delalloc() to handle range [@start,
>>    @cur_offset) inside run_delalloc_nocow()
>>    Since folios are still locked, we do not need
>>    cleanup_dirty_folios() to do the cleanup.
>>
>>    extent_clear_unlock_delalloc() with "PAGE_START_WRIBACK |
>>    PAGE_END_WRITEBACK" will clear the dirty flags.
>>
>> - Remove cleanup_dirty_folios()
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> We need a 'Fix:' tag for kernel stable branch.

The problem is, the original error handling behavior is not correct from=
=20
the very beginning.

Thus I can not locate a good offending commit.

>=20
> It seems that this problem does not happen (or less frequency) on  kerne=
l
> 6.6.y/6.1.y.

Unfortunately those kernels do not have the proper error handling either.

Thanks,
Qu

>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/08/05
>=20
>=20
>=20


