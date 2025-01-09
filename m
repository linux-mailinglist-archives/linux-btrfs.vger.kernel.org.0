Return-Path: <linux-btrfs+bounces-10808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AACA06BA2
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 03:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB62F1888C5B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 02:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296D113D8A0;
	Thu,  9 Jan 2025 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="S3FY66R5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67EBA50;
	Thu,  9 Jan 2025 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390734; cv=none; b=b9Fm0DB7AUsHddLAXZuSbQHJKxEtMpK1EW8p2gwQ9QWJInoqLOFrOf7zfr3+8+TLR7dkPABBdTJ44uLf9GqAjl3A37VJzocLEV9jME6EZuFBWo6WXm1oifVPwpyxPKSe2NbIeMwhLvVanHBvXVqIwaSZgUo7W54aQV9J0z4Jj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390734; c=relaxed/simple;
	bh=B1ZtiYCx9L5pKdU4h3hD5zsfpJUWkf9jrTqSbvqu4uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnsCqu9zNtLnu96k0/8Y9wJ6YuA3eHUOrAto7SCTmdQhf5pbUYQGjpJZxrNbWYauDS7m/lzMR4fEFifeCVjP/aUfjXO/3j4m1UQGIRZhPCRRnlF5+N2YHG93i5u+SrZ6gj5thMylPgaAq7pw3ltR0yQnQuYePyH1RhcCHXT1j8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=S3FY66R5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736390726; x=1736995526; i=quwenruo.btrfs@gmx.com;
	bh=bP6gXNzdlzmL4VS1WMWPsAP/EuG6LZnaposTkCByok0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S3FY66R5amU969+G6GK1/ZVnk966QL63D2OmgnT85xMDtDCsYpx2Oee3LL+u9Dtu
	 qD1UhwFriEL1R2Fs5GEu99t5VSKbv0FA/l+/XDPCJK7VrQy+T/z/veZ6RRukMsCWy
	 zART7DTJDyKjZKdGxx/4Wa3zURFqdfTe1OgZy+3kybV3Q3MCz838hgkSQvFlUPedC
	 BhThS8eb3+rLF7tYERknPJ1BEIHv5EZAtC+eZK3Y01TqdsN0ARD0V8N/XOIzTRL74
	 ivCpnR06CrlHviRysJo38Bho/k42W2OM8Tcog2vPF5HICDzwf6lkna2tRTyY6Z/St
	 oEcM8hfOqSgdbOlEzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOA3F-1t7Hum2e7N-00T3sd; Thu, 09
 Jan 2025 03:45:26 +0100
Message-ID: <ecd829a1-395c-406c-aaa5-4d5f75fb08bf@gmx.com>
Date: Thu, 9 Jan 2025 13:15:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] btrfs: fix double accounting race when
 btrfs_run_delalloc_range() failed
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <cover.1733983488.git.wqu@suse.com>
 <cc3ceda915ac4832fe8e706f3cb0fd2f5971efcc.1733983488.git.wqu@suse.com>
 <20250108215233.GA1456944@zen.localdomain>
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
In-Reply-To: <20250108215233.GA1456944@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dB8XfP07pj39w0HynfRUyc+EXAT5WJ8ZWaCBWsbgf5+zl9UNI4J
 Ast71peTJT9LtubrlGLoD59Pg+2vHeQxdR35qi+n/Uec7kkEZ8o5quCo1WiHk5Lpcz2H1YV
 LollMog7Ezj8uf0rNRJ0nr1XXXcjMUVLugT2ZA7bf9r3ZmLxTcOhQoTyIJMsMn2O1p6thtj
 sMPbOcffzUA2DoRR8D7Rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6Sx0rEwTduI=;xy+W0HtF80ZTjngJLnWmGF4QvDO
 KFyIHyWkWnW/O3oPId6EmvRP0XWf0Gv/NmCHzPbJBa5C7GNsdT81hcKsDz4RgbT3mbXnStK4v
 paoRcgzCwz6+BKm/YqUsoxMbp/BiXC/SwS0oZiPE7EN7D4JNyG7uwurAhBcwmG02cIIgl5xRI
 gOTayj1sg65yT2J1UvRdiDup86R5TDOZfrWOzM9cWdYXYVnTgDvpWeCTHvhDgD+IQGEULY0TC
 pqW7o/h4As/+Mhnw1gmpZkPluF16ejHeFYXWDOS8vEHER1HSYN9r88B2WSg3KHPaMJRSIrY2U
 49BeUi9LwogK/aw087zkJcCqkbsOYnnC60kumAhM8uw23wn67MKrtNbZChz32YgBJy7k7fMBC
 ApivYM8h2MkUEr0maEFqBqTkgGTmKljW/4iavNr5BXXm/LeB2FTi1I8PtwYWok2QaZ4PzAIbb
 G6xhEclvmv57s30jxCriTtjpEYAiBJyCZzZA3Mj+nqdE6aKEhT2LNFIf6pX7AMEPL01hOjpG7
 pguvo4ZWy5Ow4qC6FJzrbLFlhuw37y1iMOVozx6pIrCoujPNEgV0s3aAsoh22PIsf4ldc4Pof
 2oCeu9k41+uEUbgWuiXwD83YgKM1tPsxAEBs7S82SobNOlcVGTSiTVVcW4krguVSaaeo2TUCJ
 vxS9m8wLjshwqNNBe+Sga27v8N3jBfzJmUSSzrDdhyHE+m4/OHQu3LSSAZCaP+nQ1m1VbnZoT
 Iec/EBoHJTb/MbcmguEqQ+pQeNlI3yte9U5tzzymISeiqN8T8uPMgdNryUr8VCyc2ePaniHnE
 K1WpINxMv0GcL/xdC0bMQvB0ReYxwExRXB/S5yEk2CaKbLl+eL2ZNurcWv/f74nN2rBwh/W+I
 mSSKtOvVIzhP1/iV6C/95NsVIIIpAcirb6kdAAnSZ1O2nN+TVSRQ2TA8/kMMYXN0o9VxFCgek
 NLWV0UKGXUZLAT/EITn3ExIfVwc5ow2Wer6hSVYZdzkemY7GgZ4AOY9ETWvysm45jOQ2wFuJN
 NCuQJq+pVd4saiagwovz3VI9YASXleJ59L4O8kUJPoBwWZzuCXllu7Vv5o0O8p+rQH6r0Lz/b
 fzBIaGe6YwsZJ2R3F/62jhNLmcIl+X



=E5=9C=A8 2025/1/9 08:22, Boris Burkov =E5=86=99=E9=81=93:
> On Thu, Dec 12, 2024 at 04:43:55PM +1030, Qu Wenruo wrote:
>> [BUG]
>> When running btrfs with block size (4K) smaller than page size (64K,
>> aarch64), there is a very high chance to crash the kernel at
>> generic/750, with the following messages:
>> (before the call traces, there are 3 extra debug messages added)
>>
>>   BTRFS warning (device dm-3): read-write for sector size 4096 with pag=
e size 65536 is experimental
>>   BTRFS info (device dm-3): checking UUID tree
>>   hrtimer: interrupt took 5451385 ns
>>   BTRFS error (device dm-3): cow_file_range failed, root=3D4957 inode=
=3D257 start=3D1605632 len=3D69632: -28
>>   BTRFS error (device dm-3): run_delalloc_nocow failed, root=3D4957 ino=
de=3D257 start=3D1605632 len=3D69632: -28
>>   BTRFS error (device dm-3): failed to run delalloc range, root=3D4957 =
ino=3D257 folio=3D1572864 submit_bitmap=3D8-15 start=3D1605632 len=3D69632=
: -28
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 2 PID: 3020984 at ordered-data.c:360 can_finish_ordered=
_extent+0x370/0x3b8 [btrfs]
>>   CPU: 2 UID: 0 PID: 3020984 Comm: kworker/u24:1 Tainted: G           O=
E      6.13.0-rc1-custom+ #89
>>   Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
>>   Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>>   Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
>>   pc : can_finish_ordered_extent+0x370/0x3b8 [btrfs]
>>   lr : can_finish_ordered_extent+0x1ec/0x3b8 [btrfs]
>>   Call trace:
>>    can_finish_ordered_extent+0x370/0x3b8 [btrfs] (P)
>>    can_finish_ordered_extent+0x1ec/0x3b8 [btrfs] (L)
>>    btrfs_mark_ordered_io_finished+0x130/0x2b8 [btrfs]
>>    extent_writepage+0x10c/0x3b8 [btrfs]
>>    extent_write_cache_pages+0x21c/0x4e8 [btrfs]
>>    btrfs_writepages+0x94/0x160 [btrfs]
>>    do_writepages+0x74/0x190
>>    filemap_fdatawrite_wbc+0x74/0xa0
>>    start_delalloc_inodes+0x17c/0x3b0 [btrfs]
>>    btrfs_start_delalloc_roots+0x17c/0x288 [btrfs]
>>    shrink_delalloc+0x11c/0x280 [btrfs]
>>    flush_space+0x288/0x328 [btrfs]
>>    btrfs_async_reclaim_data_space+0x180/0x228 [btrfs]
>>    process_one_work+0x228/0x680
>>    worker_thread+0x1bc/0x360
>>    kthread+0x100/0x118
>>    ret_from_fork+0x10/0x20
>>   ---[ end trace 0000000000000000 ]---
>>   BTRFS critical (device dm-3): bad ordered extent accounting, root=3D4=
957 ino=3D257 OE offset=3D1605632 OE len=3D16384 to_dec=3D16384 left=3D0
>>   BTRFS critical (device dm-3): bad ordered extent accounting, root=3D4=
957 ino=3D257 OE offset=3D1622016 OE len=3D12288 to_dec=3D12288 left=3D0
>>   Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000000008
>>   BTRFS critical (device dm-3): bad ordered extent accounting, root=3D4=
957 ino=3D257 OE offset=3D1634304 OE len=3D8192 to_dec=3D4096 left=3D0
>>   CPU: 1 UID: 0 PID: 3286940 Comm: kworker/u24:3 Tainted: G        W  O=
E      6.13.0-rc1-custom+ #89
>>   Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>>   Workqueue:  btrfs_work_helper [btrfs] (btrfs-endio-write)
>>   pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>>   pc : process_one_work+0x110/0x680
>>   lr : worker_thread+0x1bc/0x360
>>   Call trace:
>>    process_one_work+0x110/0x680 (P)
>>    worker_thread+0x1bc/0x360 (L)
>>    worker_thread+0x1bc/0x360
>>    kthread+0x100/0x118
>>    ret_from_fork+0x10/0x20
>>   Code: f84086a1 f9000fe1 53041c21 b9003361 (f9400661)
>>   ---[ end trace 0000000000000000 ]---
>>   Kernel panic - not syncing: Oops: Fatal exception
>>   SMP: stopping secondary CPUs
>>   SMP: failed to stop secondary CPUs 2-3
>>   Dumping ftrace buffer:
>>      (ftrace buffer empty)
>>   Kernel Offset: 0x275bb9540000 from 0xffff800080000000
>>   PHYS_OFFSET: 0xffff8fbba0000000
>>   CPU features: 0x100,00000070,00801250,8201720b
>>
>> [CAUSE]
>> The above warning is triggered immediately after the delalloc range
>> failure, this happens in the following sequence:
>>
>> - Range [1568K, 1636K) is dirty
>>
>>     1536K  1568K     1600K    1636K  1664K
>>     |      |/////////|////////|      |
>>
>>    Where 1536K, 1600K and 1664K are page boundaries (64K page size)
>>
>> - Enter extent_writepage() for page 1536K
>>
>> - Enter run_delalloc_nocow() with locked page 1536K and range
>>    [1568K, 1636K)
>>    This is due to the inode has preallocated extents.
>>
>> - Enter cow_file_range() with locked page 1536K and range
>>    [1568K, 1636K)
>>
>> - btrfs_reserve_extent() only reserved two extents
>>    The main loop of cow_file_range() only reserved two data extents,
>>
>>    Now we have:
>>
>>     1536K  1568K        1600K    1636K  1664K
>>     |      |<-->|<--->|/|///////|      |
>>                 1584K  1596K
>>    Range [1568K, 1596K) has ordered extent reserved.
>>
>> - btrfs_reserve_extent() failed inside cow_file_range() for file offset
>>    1596K
>>    This is already a bug in our space reservation code, but for now let=
's
>>    focus on the error handling path.
>>
>>    Now cow_file_range() returned -ENOSPC.
>>
>> - btrfs_run_delalloc_range() do error cleanup <<< ROOT CAUSE
>>    Call btrfs_cleanup_ordered_extents() with locked folio 1536K and ran=
ge
>>    [1568K, 1636K)
>>
>>    Function btrfs_cleanup_ordered_extents() normally needs to skip the
>>    ranges inside the folio, as it will normally be cleaned up by
>>    extent_writepage().
>>
>>    Such split error handling is already problematic in the first place.
>>
>>    What's worse is the folio range skipping itself, which is not taking
>>    subpage cases into consideration at all, it will only skip the range
>>    if the page start >=3D the range start.
>>    In our case, the page start < the range start, since for subpage cas=
es
>>    we can have delalloc ranges inside the folio but not covering the
>>    folio.
>>
>>    So it doesn't skip the page range at all.
>>    This means all the ordered extents, both [1568K, 1584K) and
>>    [1584K, 1596K) will be marked as IOERR.
>>
>>    And those two ordered extents have no more pending ios, it is marked
>>    finished, and *QUEUED* to be deleted from the io tree.
>>
>> - extent_writepage() do error cleanup
>>    Call btrfs_mark_ordered_io_finished() for the range [1536K, 1600K).
>>
>>    Although ranges [1568K, 1584K) and [1584K, 1596K) are finished, the
>>    deletion from io tree is async, it may or may not happen at this
>>    timing.
>>
>>    If the ranges are not yet removed, we will do double cleaning on tho=
se
>>    ranges, triggers the above ordered extent warnings.
>>
>> In theory there are other bugs, like the cleanup in extent_writepage()
>> can cause double accounting on ranges that are submitted async
>> (compression for example).
>>
>> But that's much harder to trigger because normally we do not mix regula=
r
>> and compression delalloc ranges.
>>
>> [FIX]
>> The folio range split is already buggy and not subpage compatible, it's
>> introduced a long time ago where subpage support is not even considered=
.
>>
>> So instead of splitting the ordered extents cleanup into the folio rang=
e
>> and out of folio range, do all the cleanup inside writepage_delalloc().
>>
>> - Pass @NULL as locked_folio for btrfs_cleanup_ordered_extents() in
>>    btrfs_run_delalloc_range()
>>
>> - Skip the btrfs_cleanup_ordered_extents() if writepage_delalloc()
>>    failed
>>
>>    So all ordered extents are only cleaned up by
>>    btrfs_run_delalloc_range().
>>
>> - Handle the ranges that already have ordered extents allocated
>>    If part of the folio already has ordered extent allocated, and
>>    btrfs_run_delalloc_range() failed, we also need to cleanup that rang=
e.
>>
>> Now we have a concentrated error handling for ordered extents during
>> btrfs_run_delalloc_range().
>
> Great investigation and writeup, thanks!

Thanks a lot of the review!

>
> The explanation and fix both make sense to me. I traced the change in
> error handling and I see how we are avoiding double ending the
> ordered_extent. So with that said, feel free to add:
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> However, I would like to request one thing, if I may.
> While this is all still relatively fresh in your mind, could you please
> document the intended behavior of the various functions (at least the
> ones you modify/reason about) with regards to:
> - cleanup state of the various objects involved like ordered_extents
>    and subpages (e.g., writepage_delalloc cleans up ordered extents, so
>    callers should not, etc.)

The subpage one should not be considered as something special, it's
really just some kind of enhanced page flags for subpage cases.

Thus I'll not explicitly mention the subpage bitmap, but directly
mention the involved flags (in this particular case, folio Ordered and
Locked flags).

> - return values (e.g., when precisely does btrfs_run_delalloc_range
>    return >=3D 0 ?)

My bad, I should update the comment in commit d034cdb4cc8a ("btrfs: lock
subpage ranges in one go for writepage_delalloc()").

Still better fix it here before too late.

> - anything else you think would be helpful for reasoning about these
>    functions in an abstract way while you are at it.
>
> That request is obviously optional for landing these fixes, but I really
> think it would help if we went through the bother every time we
> deciphered one of these undocumented paths. A restatement of your best
> understanding of the behavior now will really pay off for the next
> person reading this code :)
>
> Thanks,
> Boris
>
>>
>> Cc: stable@vger.kernel.org # 5.15+
>> Fixes: d1051d6ebf8e ("btrfs: Fix error handling in btrfs_cleanup_ordere=
d_extents")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++++++++++++-----
>>   fs/btrfs/inode.c     |  2 +-
>>   2 files changed, 33 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 9725ff7f274d..417c710c55ca 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -1167,6 +1167,12 @@ static noinline_for_stack int writepage_delalloc=
(struct btrfs_inode *inode,
>>   	 * last delalloc end.
>>   	 */
>>   	u64 last_delalloc_end =3D 0;
>> +	/*
>> +	 * Save the last successfully ran delalloc range end (exclusive).
>> +	 * This is for error handling to avoid ranges with ordered extent cre=
ated
>> +	 * but no IO will be submitted due to error.
>> +	 */
>
> nit: last_finished what? I feel this name or comment could use some
> extra work.

I can enhance it to @last_finished_delalloc_end and update the comment.

Thanks,
Qu

>
>> +	u64 last_finished =3D page_start;
>>   	u64 delalloc_start =3D page_start;
>>   	u64 delalloc_end =3D page_end;
>>   	u64 delalloc_to_write =3D 0;
>> @@ -1235,11 +1241,19 @@ static noinline_for_stack int writepage_delallo=
c(struct btrfs_inode *inode,
>>   			found_len =3D last_delalloc_end + 1 - found_start;
>>
>>   		if (ret >=3D 0) {
>> +			/*
>> +			 * Some delalloc range may be created by previous folios.
>> +			 * Thus we still need to clean those range up during error
>> +			 * handling.
>> +			 */
>> +			last_finished =3D found_start;
>>   			/* No errors hit so far, run the current delalloc range. */
>>   			ret =3D btrfs_run_delalloc_range(inode, folio,
>>   						       found_start,
>>   						       found_start + found_len - 1,
>>   						       wbc);
>> +			if (ret >=3D 0)
>> +				last_finished =3D found_start + found_len;
>>   		} else {
>>   			/*
>>   			 * We've hit an error during previous delalloc range,
>> @@ -1274,8 +1288,21 @@ static noinline_for_stack int writepage_delalloc=
(struct btrfs_inode *inode,
>>
>>   		delalloc_start =3D found_start + found_len;
>>   	}
>> -	if (ret < 0)
>> +	/*
>> +	 * It's possible we have some ordered extents created before we hit
>> +	 * an error, cleanup non-async successfully created delalloc ranges.
>> +	 */
>> +	if (unlikely(ret < 0)) {
>> +		unsigned int bitmap_size =3D min(
>> +			(last_finished - page_start) >> fs_info->sectorsize_bits,
>> +			fs_info->sectors_per_page);
>> +
>> +		for_each_set_bit(bit, &bio_ctrl->submit_bitmap, bitmap_size)
>> +			btrfs_mark_ordered_io_finished(inode, folio,
>> +				page_start + (bit << fs_info->sectorsize_bits),
>> +				fs_info->sectorsize, false);
>>   		return ret;
>> +	}
>>   out:
>>   	if (last_delalloc_end)
>>   		delalloc_end =3D last_delalloc_end;
>> @@ -1509,13 +1536,13 @@ static int extent_writepage(struct folio *folio=
, struct btrfs_bio_ctrl *bio_ctrl
>>
>>   	bio_ctrl->wbc->nr_to_write--;
>>
>> -done:
>> -	if (ret) {
>> +	if (ret)
>>   		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
>>   					       page_start, PAGE_SIZE, !ret);
>> -		mapping_set_error(folio->mapping, ret);
>> -	}
>>
>> +done:
>> +	if (ret < 0)
>> +		mapping_set_error(folio->mapping, ret);
>>   	/*
>>   	 * Only unlock ranges that are submitted. As there can be some async
>>   	 * submitted ranges inside the folio.
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index c4997200dbb2..d41bb47d59fb 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -2305,7 +2305,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *=
inode, struct folio *locked_fol
>>
>>   out:
>>   	if (ret < 0)
>> -		btrfs_cleanup_ordered_extents(inode, locked_folio, start,
>> +		btrfs_cleanup_ordered_extents(inode, NULL, start,
>>   					      end - start + 1);
>>   	return ret;
>>   }
>> --
>> 2.47.1
>>
>


