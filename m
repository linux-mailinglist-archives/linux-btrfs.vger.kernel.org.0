Return-Path: <linux-btrfs+bounces-15358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F3AFDEA9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 06:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C254317D76B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 04:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7444125F986;
	Wed,  9 Jul 2025 04:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QEHjcmT1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1413D2B2
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 04:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033755; cv=none; b=Go8ewtSFIXFKhNqeKEozwWFZcQw7USaUUumwY6uE0yFSbznIS5osO8bh93/SUYPQgyfhmSHymSWdCbb2hCIGav36S9rIH5C8KkpLwUrpUTBXSYs7K9O/EFtmPe5AGxgJUCUqhu+nQyVmQJ23urk8Kg6QUNKww2KKezF+DfVMjCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033755; c=relaxed/simple;
	bh=3aZE4TWkWGaVODSGDFSq6DYjcmD2oHthl8kHjIgtMJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQjrQ5zQZowtEEgh+kyyWdP2YDXSuXncrWI4qUlG6lcAqwpH/z3X/TQ1Fr1P2izkPsUH6kD/by8aaJgM7wAE/ZMeqtGdL/xW7C71bL+NqN1OhiNs1yE15Cr6WegUDF1+6/kTpjFvE4F0Z8mWxJe+s+06O0mZMigx/OacakP1h3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QEHjcmT1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752033748; x=1752638548; i=quwenruo.btrfs@gmx.com;
	bh=+YsVImXwfZVCyUbn2pwPWr7y+pNSD1VnVerL1yjN6qI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QEHjcmT1xpod2h8DsFdNwXodaUNwxqJt9D6+gWOf88Z5+C/dMq+Pdap/QQ4z3Yfa
	 +STl0D/lDcrwHiJx8z84eUNZHM27ZmrtQeQL6vZKuDR4PS4qpacMa3h7DHqqX9mJR
	 fS8r0aVKKpXm6WisekAU4gif1sN4AaqYjY+XeK/5JZ0cgcQflSaam6EZmdD3k+tyL
	 AfQtfQzT2ZHrRta2z45wvNTsMDXZ+BV+nT+YC2zKnK14Xw1SzuAJNF4vc4vPB1cwY
	 ABpmkXf35S5mAFLWCVvpAPLxTxos0eoyi1Wvy0oKfYfJcJY+f9PLTFAPswcCIZtSo
	 QD0taCJ8ywSyMIT1BQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvLB-1u7Ts63YGL-00Lk8h; Wed, 09
 Jul 2025 06:02:28 +0200
Message-ID: <f53950db-b6ef-4842-ab67-ed0f92ef632d@gmx.com>
Date: Wed, 9 Jul 2025 13:32:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] btrfs: do not poke into bdev's page cache
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1751965333.git.wqu@suse.com>
 <20250708152715.GO4453@twin.jikos.cz>
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
In-Reply-To: <20250708152715.GO4453@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b60fiKo0Q3p4SXKFNSQMdJC2ztSi/PSiOOP9BL7zhlKReadBsLl
 dRNv1q9HCW+kig5tkQb1h6IDG+76xO8CxPBuakLt+v4qtT33lBMXtw8ae8aWM3HcIfYqESt
 iTEr0yN9mdOHbqKxwHSfmlxi0DlsWiBnZo//cExp7DIXSFqXnksmWQoQnDzwG9XzOg5y8Hz
 FMRcafQgNgtihcb+gzjGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qpAbQ8FV7XQ=;63P5YZjxic7yaMqGqwCBXzNXMCb
 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



=E5=9C=A8 2025/7/9 00:57, David Sterba =E5=86=99=E9=81=93:
> On Tue, Jul 08, 2025 at 06:36:31PM +0930, Qu Wenruo wrote:
>> [ABUSE OF BDEV'S PAGE CACHE]
>> Btrfs has a long history using bdev's page cache for super block IOs.
>> This looks weird, but is mostly for the sake of concurrency.
>>
>> However this has already caused problems, for example when the block
>> layer page cache enables large folio support, it triggers an ASSERT()
>> inside btrfs, this is fixed by commit 65f2a3b2323e ("btrfs: remove foli=
o
>> order ASSERT()s in super block writeback path"), but it is already a
>> warning.
>>
>> [MOVEING AWAY FROM BDEV'S PAGE CACHE]
>> Thankfully we're moving away from the bdev's page cache already, starti=
ng
>> with commit bc00965dbff7 ("btrfs: count super block write errors in
>> device instead of tracking folio error state"), we no longer relies on
>> page cache to detect super block IO errors.
>>
>> We still have the following paths using bdev's page cache, and those
>> points will be addressed in this series:
>>
>> - Reading super blocks
>>    This is the easist one to kill, just kmalloc() and bdev_rw_virt() wi=
ll
>>    handle it well.
>>
>> - Scratching super blocks
>>    Previously we just zero out the magic, but leaving everything else
>>    there.
>>    We rely on the block layer to write the involved blocks.
>>
>>    Here we follow btrfs_read_disk_super() by kzalloc()ing a dummy super
>>    block, and write the full super block back to disk.
>>
>> - Writing super blocks
>>    Although write_dev_supers() is alreadying using the bio interface, i=
t
>>    still relies on the bdev's page cache.
>>
>>    One of the reason is, we want to submit all super blocks of a device
>>    in one go, and each super block of the same block device is slightly
>>    different, thus we go using page cache, so that each super block can
>>    have its own backing folio.
>>
>>    Here we solve it by pre-allocating super block buffers.
>>    This also makes endio function much simpler, no need to iterate the
>>    bio to unlock the folio.
>>
>> - Waiting super blocks
>>    Instead of locking the folio to make sure its IO is done, just use a=
n
>>    atomic and wait queue head to do it the usual way.
>>
>> By this we solve the problem and all IOs are done using bio interface.
>>
>> [THE COST AND REASON FOR RFC]
>> But this brings some overhead, thus I marked the series RFC:
>>
>> - Extra 12K memory usage for each block device
>>    I hope the extra cost is acceptable for modern day systems.
>>
>> - Extra memory copy for super block writeback
>>    Previously we do the copy into the bdev's page cache, then submit th=
e
>>    IO using folio from the bdev page cache.
>>
>>    This updates the page cache and do the IO in one go.
>>
>>    But now we memcpy() into the preallocated super block buffer, not
>>    updating the bdev's page cache directly.
>>    If by somehow the block device drive determines to copy the bio's
>>    content to page cache, it will need to do one extra memory copy.
>>
>> - Extra memory allocation for btrfs_scratch_superblock()
>>    Previously we need no memory allocation, thus no error handling
>>    needed.
>>
>>    But now we need extra memory allocation, and such allocation is just
>>    to write zero into block devices. Thus the cost is a little hard to
>>    accept.
>>
>> - No more cached super block during device scan
>>    But the cost should be minimal.
>=20
> I have a similar patchset, there was a discussion about how to write the
> super block
> https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/
>=20
> I did separate pages and bios for the write, not using the page cache
> and IIRC there were some problems with userspace interaction as it
> depends on the page cache as the synchronization point.

Do you still have some details about this problem?
In my fstests runs on non-zoned devices, it's totally fine.

And to be honest, I think this is very weird.
For filesystems that fully relies on bio interface, there will be no=20
interaction with the bdev's page cache.

Thus if there is something requiring the page cache as a sync point, it=20
will never work anyway.

Thanks,
Qu

>=20
> The preallocation of 3 pages per device is IMHO acceptable and it avoids
> any potential memory allocation failures when we're writing the most
> critical block.
>=20


