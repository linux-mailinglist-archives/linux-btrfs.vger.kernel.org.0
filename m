Return-Path: <linux-btrfs+bounces-15346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198BAFDA4D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 00:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386AD540170
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1132472AE;
	Tue,  8 Jul 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k/r46op5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F4246763
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011998; cv=none; b=PGczQ93/6TfZXmMyIE6fdOyJDIOcTNdvCOpOsyCd0QP+eRboN2Vv2IS/YLkTraG+PcnL3jEfPcs6sJTS2Ing9mBR9wVI9yCrf2VamzeY3wt5Re/vXngAgauOJinT/rYdcIjw0n0zpGiwwIv7jPUBGxN6k0fmtWXU3sXS6Jaf0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011998; c=relaxed/simple;
	bh=vKaQNK93BSuCof8dxworWa0Wmzdwmr0Mjuag3dnqKAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlNKmDhb3j3qsegybXAkn7i2u5voIg6zLPFs1+rgsCZPiCEd0BDcwHxm1rvvWY05VB277eIG5relrxdzxg4yAM0wxyHujKPeuP5+HP0yKfiZUYpTKoFjrJ/DTQ2rO1z6vl/GCdQEcxvWSqumrE3LPTHWOZZa44yxxAVr1Wq0PmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k/r46op5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752011989; x=1752616789; i=quwenruo.btrfs@gmx.com;
	bh=8oYe6G9B6wNGp3d2IgIp8CJDTBu+rhC34P3979ZF7RM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k/r46op5lI2V/+D8jSIMB7O02WvbT/wFdt+3aPYXv7uloaMtOl5rkrv0dZRiQKrb
	 zPXmwqfqNY4UavviHd7NbfpSAxrnculSZRFMc1stbTsKqpsa0zoRb7OcMuUBIjqTq
	 l2UR2ck2g6CQw3jJZf9CjymkBeIH7KGxa0PNe/8bdPi328T06wkraKMBCCsVrdu8Q
	 2UQMztwvqLr25exLmcx1echajNyMsOnPFa510lN6zQBPaZ69hHNy18mYeKwtEGi70
	 MzQdNJdbH/y6NxyHMoHnVXjDjMuOTPr2N7chKxbtzAwZczRYOMdYTuv3AE3NJ1iOe
	 ueWOQ8KO8UGgdH1AuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1uS8YE3oha-005ZnS; Tue, 08
 Jul 2025 23:59:49 +0200
Message-ID: <39e284e4-046f-4363-a6c7-46f844de58dd@gmx.com>
Date: Wed, 9 Jul 2025 07:29:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] btrfs: do not poke into bdev's page cache
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
References: <cover.1751965333.git.wqu@suse.com>
 <f72cac03-3c3e-400c-adfe-cc045845fcd5@wdc.com>
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
In-Reply-To: <f72cac03-3c3e-400c-adfe-cc045845fcd5@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+6BTOlvyYtFynIBtSaQd4Gtl4XTP2pdlNoIF+sF0YlFazfqvSS4
 8CPdlcfTXZVd/RJ7igkIKAd/p5IUgCPJ6ZWiWVQvmgplqJ8zVQrJTF6Vltnh3772Jlf4f+m
 D8HuhZcJuTPd8H810yJDcRVqhlqUQrnU6jPy5YsH+AHSk1cPB8yZfB+GvqqIGoHUUAOgLmS
 xjns03C8QEZosEi2QSSJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ov1tramU8bY=;M59MTNIc9h0qkaLGfx67eV7Dj3n
 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



=E5=9C=A8 2025/7/8 20:05, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 08.07.25 11:07, Qu Wenruo wrote:
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
>>     This is the easist one to kill, just kmalloc() and bdev_rw_virt() w=
ill
>>     handle it well.
>>
>> - Scratching super blocks
>>     Previously we just zero out the magic, but leaving everything else
>>     there.
>>     We rely on the block layer to write the involved blocks.
>>
>>     Here we follow btrfs_read_disk_super() by kzalloc()ing a dummy supe=
r
>>     block, and write the full super block back to disk.
>>
>> - Writing super blocks
>>     Although write_dev_supers() is alreadying using the bio interface, =
it
>>     still relies on the bdev's page cache.
>>
>>     One of the reason is, we want to submit all super blocks of a devic=
e
>>     in one go, and each super block of the same block device is slightl=
y
>>     different, thus we go using page cache, so that each super block ca=
n
>>     have its own backing folio.
>>
>>     Here we solve it by pre-allocating super block buffers.
>>     This also makes endio function much simpler, no need to iterate the
>>     bio to unlock the folio.
>>
>> - Waiting super blocks
>>     Instead of locking the folio to make sure its IO is done, just use =
an
>>     atomic and wait queue head to do it the usual way.
>>
>> By this we solve the problem and all IOs are done using bio interface.
>>
>> [THE COST AND REASON FOR RFC]
>> But this brings some overhead, thus I marked the series RFC:
>>
>> - Extra 12K memory usage for each block device
>>     I hope the extra cost is acceptable for modern day systems.
>>
>> - Extra memory copy for super block writeback
>>     Previously we do the copy into the bdev's page cache, then submit t=
he
>>     IO using folio from the bdev page cache.
>>
>>     This updates the page cache and do the IO in one go.
>>
>>     But now we memcpy() into the preallocated super block buffer, not
>>     updating the bdev's page cache directly.
>>     If by somehow the block device drive determines to copy the bio's
>>     content to page cache, it will need to do one extra memory copy.
>>
>> - Extra memory allocation for btrfs_scratch_superblock()
>>     Previously we need no memory allocation, thus no error handling
>>     needed.
>>
>>     But now we need extra memory allocation, and such allocation is jus=
t
>>     to write zero into block devices. Thus the cost is a little hard to
>>     accept.
>>
>> - No more cached super block during device scan
>>     But the cost should be minimal.
>=20
> I've also grepped for the users of btrfs_release_disk_super() because I
> think we should remove it as well as after this series it's a plain
> kfree() wrapper and found that `sb_write_pointer()` in zoned.c is still
> using the page cache for superblock reading.
>=20
> Should that be converted as well in the final series?

Thanks a lot for exposing another page cache user, sure it must be gone.

Thanks,
Qu


