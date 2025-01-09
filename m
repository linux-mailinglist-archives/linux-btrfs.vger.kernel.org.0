Return-Path: <linux-btrfs+bounces-10812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042FEA06D45
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 05:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8A13A2A87
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 04:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773E214219;
	Thu,  9 Jan 2025 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="V+GcQAli"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225001AAC9;
	Thu,  9 Jan 2025 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736398074; cv=none; b=nVZ/4gRijdxPcQq5dVDuuYtktrCQMpCp9MRXYUwHb1VHD7cRSFLgSErn1lsJtY7MJIr8MzE12EAvviHik7hYOqhBYIM5no7ohQIocpQC6MPwqMrSPiJWr6h15gHSFPC0eCMcKkgY/xUrsWclgQkxY/WIdGAqN8WRsNPD7JMtczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736398074; c=relaxed/simple;
	bh=sjT0hgA2ZW3U8X0I+i+k/SCW6jKnGdcZnJr+h9G98HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbQwXVap7iAjCg1Zo/kjSX2QIDxOl9laRMP4Na04WOop0gTkwpWdzZIK0eehSuskaPKulj3Uw0CrwY1krEnMHcISEwhtt4S8mDgQLNUvjeHA5RV/hgd8JEHGbz62datYbi8nXYGDeoYWvoU9plmO0BtiMz7bmB/qz4nocerrEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=V+GcQAli; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736398069; x=1737002869; i=quwenruo.btrfs@gmx.com;
	bh=sjT0hgA2ZW3U8X0I+i+k/SCW6jKnGdcZnJr+h9G98HE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V+GcQAlijjrA7+Zrgg74ceKUuZnxSk0bg3PuoHsF33oMjOte4rR+ZDwjLMPwaSzi
	 LO9CSG+MILtpB8gR9reh8A/u4nx6S5GFrKfRm82ji65gAco4cQrG+FjBZe43Ol2dG
	 ZvQ9uuRyqlhXwHxLNSfrZfoDifThGiNLdsHXcwydiV18EpU/8UGdoV2V9BiesRCgV
	 oehSqACQhvjuFs/p23yCScTgjNMFBXWG84+td6Nk45oXYErXYdiP6M1TDuiv5DDgY
	 FciJtmX6ns+TBq9McnAm73kJujvrM1qWGThEBFqk+VLa2hkPPCjprHhb9gv9xf3KB
	 P7RRPIpQYKfsm/CMiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq24-1tlDwa1wWe-016EIE; Thu, 09
 Jan 2025 05:47:49 +0100
Message-ID: <99431c75-5419-42d4-bb83-f3938941f7a7@gmx.com>
Date: Thu, 9 Jan 2025 15:17:45 +1030
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
 <ecd829a1-395c-406c-aaa5-4d5f75fb08bf@gmx.com>
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
In-Reply-To: <ecd829a1-395c-406c-aaa5-4d5f75fb08bf@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h04gZsod9plIyDpO2emP1AQ6mBlVQBz0ZlN+0FUVpVCwKA4jyPI
 eN23fZDTBfxWPh+fTKIPoDO7YKExTzdOrN6a7QjzrsRQb9sFkx21G6idTm0AZR7neOILT56
 +WGC7pnP2q/3vbvdtn+OzSeyERj291hQh2+GagagYVK/8lYEWBpmNd5+NxYoD6w4RXebWx7
 Plvv0f1oM/h7CrOlXm97Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GDVXIb0ZNzk=;aPHMH2Qt4bqvusrDV1ZvA9UGWMM
 TXs5QuqyGIBaRSY4bRgqK58CpcYHvptTslXeSOlHG9PpVeXmImqGWzIG3CNCYtmleMRa07P9b
 vEy80N0lMaViulJOcjjusvp+W98HoAa+GCToA2uTX0jMuk8qcx2ynbLsM//tn5YCH0OsEIdwd
 xPdTeXZShOeXKvYCyALE282YOccQVuHj0ChRDj6fZ/Fez+s59B4xmY15S54osY1ZfH9IF+g74
 zpalz2s1jVSlvuxQugJU8rfOFy+yDAQDQIqXhD8MbBDZnFmFhfCgIUcBlrTD0uD5jTtMbbB+X
 A7ZzgG2PCKKrJTpaIo7BRAxcn01HWdnhDSiltdtiv1ANnTd5akoM3upk/zb50GKcU9GoYHdFV
 nbjrT7H03MkNIlJbU6GdZtGt3Qp7oGiQVamlyOlxnOwcb8NNG85M/0DA233Rof1uHdLlRIT4F
 LdZ85zMZP/xr++qmUBMAFmxMWgb+Te+dzPT74jNzb8Z9KMbQaa9EJM8DmiVxqcR57vm1rcW2g
 6UndM2EDkBvQnJtKjdKhiD5vHSDqOWw/RTbLqGQj2SNFv3uCdARXcewsuGS/zXUv0+uXjbf8P
 O+X/PT9LEahAfHpmPu1tjJ13OMEu6P87FzhvRPYueAPWMIsNhhdIO/IJVMv04nz7g/46mlQYU
 H9uAA1lcACwGwER2Q+x39eGQiPeCKSlmd67Rwcoh8FV3dMzLWIKLVmk3T5XlE3D+DRWJxZTnq
 obDORczfIu8TE+67pG2qwSdn5U5TkX9pP0ey9dMH6Q4YAY7Go5my5XqeIIUmJ5CCVw1bi/orN
 hlh+QfaZO2Crcdf0Z+r0XyA27uqWz9G356e2lZZQMZHtxn2oz1WGj/f1DP3vb9b/SfeXt++Rb
 HX14HApEtFaN5maLNvXJidwzE54a4ssKsl+KPp72hDI7aJp2WxKZMmVcgsmRY+hAyf3OrK3Hs
 rV6UirRgknAQ16d27Qq7x7FFotYfLHuvT9tqw4euLmtpygKa7rnesSb8AnI0y9FY5rZ48xbxe
 dw3f+mXDYpy8fg1p1aS6FHjp7+qXpGBtEPi4TXvoSlfYqk7BqeUl2ro0s0rCBXs2NnLfWyQRl
 Je+T7r4+HBJP65gOOtEJrgZjI8xyQE



=E5=9C=A8 2025/1/9 13:15, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2025/1/9 08:22, Boris Burkov =E5=86=99=E9=81=93:
>> On Thu, Dec 12, 2024 at 04:43:55PM +1030, Qu Wenruo wrote:
>>> [BUG]
>>> When running btrfs with block size (4K) smaller than page size (64K,
>>> aarch64), there is a very high chance to crash the kernel at
>>> generic/750, with the following messages:
>>> (before the call traces, there are 3 extra debug messages added)
>>>
>>> =C2=A0 BTRFS warning (device dm-3): read-write for sector size 4096 wi=
th
>>> page size 65536 is experimental
>>> =C2=A0 BTRFS info (device dm-3): checking UUID tree
>>> =C2=A0 hrtimer: interrupt took 5451385 ns
>>> =C2=A0 BTRFS error (device dm-3): cow_file_range failed, root=3D4957
>>> inode=3D257 start=3D1605632 len=3D69632: -28
>>> =C2=A0 BTRFS error (device dm-3): run_delalloc_nocow failed, root=3D49=
57
>>> inode=3D257 start=3D1605632 len=3D69632: -28
>>> =C2=A0 BTRFS error (device dm-3): failed to run delalloc range, root=
=3D4957
>>> ino=3D257 folio=3D1572864 submit_bitmap=3D8-15 start=3D1605632 len=3D6=
9632: -28
>>> =C2=A0 ------------[ cut here ]------------
>>> =C2=A0 WARNING: CPU: 2 PID: 3020984 at ordered-data.c:360
>>> can_finish_ordered_extent+0x370/0x3b8 [btrfs]
>>> =C2=A0 CPU: 2 UID: 0 PID: 3020984 Comm: kworker/u24:1 Tainted: G
>>> OE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.13.0-rc1-custom+ #89
>>> =C2=A0 Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
>>> =C2=A0 Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>>> =C2=A0 Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs=
]
>>> =C2=A0 pc : can_finish_ordered_extent+0x370/0x3b8 [btrfs]
>>> =C2=A0 lr : can_finish_ordered_extent+0x1ec/0x3b8 [btrfs]
>>> =C2=A0 Call trace:
>>> =C2=A0=C2=A0 can_finish_ordered_extent+0x370/0x3b8 [btrfs] (P)
>>> =C2=A0=C2=A0 can_finish_ordered_extent+0x1ec/0x3b8 [btrfs] (L)
>>> =C2=A0=C2=A0 btrfs_mark_ordered_io_finished+0x130/0x2b8 [btrfs]
>>> =C2=A0=C2=A0 extent_writepage+0x10c/0x3b8 [btrfs]
>>> =C2=A0=C2=A0 extent_write_cache_pages+0x21c/0x4e8 [btrfs]
>>> =C2=A0=C2=A0 btrfs_writepages+0x94/0x160 [btrfs]
>>> =C2=A0=C2=A0 do_writepages+0x74/0x190
>>> =C2=A0=C2=A0 filemap_fdatawrite_wbc+0x74/0xa0
>>> =C2=A0=C2=A0 start_delalloc_inodes+0x17c/0x3b0 [btrfs]
>>> =C2=A0=C2=A0 btrfs_start_delalloc_roots+0x17c/0x288 [btrfs]
>>> =C2=A0=C2=A0 shrink_delalloc+0x11c/0x280 [btrfs]
>>> =C2=A0=C2=A0 flush_space+0x288/0x328 [btrfs]
>>> =C2=A0=C2=A0 btrfs_async_reclaim_data_space+0x180/0x228 [btrfs]
>>> =C2=A0=C2=A0 process_one_work+0x228/0x680
>>> =C2=A0=C2=A0 worker_thread+0x1bc/0x360
>>> =C2=A0=C2=A0 kthread+0x100/0x118
>>> =C2=A0=C2=A0 ret_from_fork+0x10/0x20
>>> =C2=A0 ---[ end trace 0000000000000000 ]---
>>> =C2=A0 BTRFS critical (device dm-3): bad ordered extent accounting,
>>> root=3D4957 ino=3D257 OE offset=3D1605632 OE len=3D16384 to_dec=3D1638=
4 left=3D0
>>> =C2=A0 BTRFS critical (device dm-3): bad ordered extent accounting,
>>> root=3D4957 ino=3D257 OE offset=3D1622016 OE len=3D12288 to_dec=3D1228=
8 left=3D0
>>> =C2=A0 Unable to handle kernel NULL pointer dereference at virtual add=
ress
>>> 0000000000000008
>>> =C2=A0 BTRFS critical (device dm-3): bad ordered extent accounting,
>>> root=3D4957 ino=3D257 OE offset=3D1634304 OE len=3D8192 to_dec=3D4096 =
left=3D0
>>> =C2=A0 CPU: 1 UID: 0 PID: 3286940 Comm: kworker/u24:3 Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W
>>> OE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.13.0-rc1-custom+ #89
>>> =C2=A0 Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>>> =C2=A0 Workqueue:=C2=A0 btrfs_work_helper [btrfs] (btrfs-endio-write)
>>> =C2=A0 pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D-=
-)
>>> =C2=A0 pc : process_one_work+0x110/0x680
>>> =C2=A0 lr : worker_thread+0x1bc/0x360
>>> =C2=A0 Call trace:
>>> =C2=A0=C2=A0 process_one_work+0x110/0x680 (P)
>>> =C2=A0=C2=A0 worker_thread+0x1bc/0x360 (L)
>>> =C2=A0=C2=A0 worker_thread+0x1bc/0x360
>>> =C2=A0=C2=A0 kthread+0x100/0x118
>>> =C2=A0=C2=A0 ret_from_fork+0x10/0x20
>>> =C2=A0 Code: f84086a1 f9000fe1 53041c21 b9003361 (f9400661)
>>> =C2=A0 ---[ end trace 0000000000000000 ]---
>>> =C2=A0 Kernel panic - not syncing: Oops: Fatal exception
>>> =C2=A0 SMP: stopping secondary CPUs
>>> =C2=A0 SMP: failed to stop secondary CPUs 2-3
>>> =C2=A0 Dumping ftrace buffer:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 (ftrace buffer empty)
>>> =C2=A0 Kernel Offset: 0x275bb9540000 from 0xffff800080000000
>>> =C2=A0 PHYS_OFFSET: 0xffff8fbba0000000
>>> =C2=A0 CPU features: 0x100,00000070,00801250,8201720b
>>>
>>> [CAUSE]
>>> The above warning is triggered immediately after the delalloc range
>>> failure, this happens in the following sequence:
>>>
>>> - Range [1568K, 1636K) is dirty
>>>
>>> =C2=A0=C2=A0=C2=A0 1536K=C2=A0 1568K=C2=A0=C2=A0=C2=A0=C2=A0 1600K=C2=
=A0=C2=A0=C2=A0 1636K=C2=A0 1664K
>>> =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |/////////|////////=
|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>>
>>> =C2=A0=C2=A0 Where 1536K, 1600K and 1664K are page boundaries (64K pag=
e size)
>>>
>>> - Enter extent_writepage() for page 1536K
>>>
>>> - Enter run_delalloc_nocow() with locked page 1536K and range
>>> =C2=A0=C2=A0 [1568K, 1636K)
>>> =C2=A0=C2=A0 This is due to the inode has preallocated extents.
>>>
>>> - Enter cow_file_range() with locked page 1536K and range
>>> =C2=A0=C2=A0 [1568K, 1636K)
>>>
>>> - btrfs_reserve_extent() only reserved two extents
>>> =C2=A0=C2=A0 The main loop of cow_file_range() only reserved two data =
extents,
>>>
>>> =C2=A0=C2=A0 Now we have:
>>>
>>> =C2=A0=C2=A0=C2=A0 1536K=C2=A0 1568K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1600K=C2=A0=C2=A0=C2=A0 1636K=C2=A0 1664K
>>> =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |<-->|<--->|/|/////=
//|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 1584K=C2=A0 1596K
>>> =C2=A0=C2=A0 Range [1568K, 1596K) has ordered extent reserved.
>>>
>>> - btrfs_reserve_extent() failed inside cow_file_range() for file offse=
t
>>> =C2=A0=C2=A0 1596K
>>> =C2=A0=C2=A0 This is already a bug in our space reservation code, but =
for now
>>> let's
>>> =C2=A0=C2=A0 focus on the error handling path.
>>>
>>> =C2=A0=C2=A0 Now cow_file_range() returned -ENOSPC.
>>>
>>> - btrfs_run_delalloc_range() do error cleanup <<< ROOT CAUSE
>>> =C2=A0=C2=A0 Call btrfs_cleanup_ordered_extents() with locked folio 15=
36K and
>>> range
>>> =C2=A0=C2=A0 [1568K, 1636K)
>>>
>>> =C2=A0=C2=A0 Function btrfs_cleanup_ordered_extents() normally needs t=
o skip the
>>> =C2=A0=C2=A0 ranges inside the folio, as it will normally be cleaned u=
p by
>>> =C2=A0=C2=A0 extent_writepage().
>>>
>>> =C2=A0=C2=A0 Such split error handling is already problematic in the f=
irst place.
>>>
>>> =C2=A0=C2=A0 What's worse is the folio range skipping itself, which is=
 not taking
>>> =C2=A0=C2=A0 subpage cases into consideration at all, it will only ski=
p the range
>>> =C2=A0=C2=A0 if the page start >=3D the range start.
>>> =C2=A0=C2=A0 In our case, the page start < the range start, since for =
subpage
>>> cases
>>> =C2=A0=C2=A0 we can have delalloc ranges inside the folio but not cove=
ring the
>>> =C2=A0=C2=A0 folio.
>>>
>>> =C2=A0=C2=A0 So it doesn't skip the page range at all.
>>> =C2=A0=C2=A0 This means all the ordered extents, both [1568K, 1584K) a=
nd
>>> =C2=A0=C2=A0 [1584K, 1596K) will be marked as IOERR.
>>>
>>> =C2=A0=C2=A0 And those two ordered extents have no more pending ios, i=
t is marked
>>> =C2=A0=C2=A0 finished, and *QUEUED* to be deleted from the io tree.
>>>
>>> - extent_writepage() do error cleanup
>>> =C2=A0=C2=A0 Call btrfs_mark_ordered_io_finished() for the range [1536=
K, 1600K).
>>>
>>> =C2=A0=C2=A0 Although ranges [1568K, 1584K) and [1584K, 1596K) are fin=
ished, the
>>> =C2=A0=C2=A0 deletion from io tree is async, it may or may not happen =
at this
>>> =C2=A0=C2=A0 timing.
>>>
>>> =C2=A0=C2=A0 If the ranges are not yet removed, we will do double clea=
ning on
>>> those
>>> =C2=A0=C2=A0 ranges, triggers the above ordered extent warnings.
>>>
>>> In theory there are other bugs, like the cleanup in extent_writepage()
>>> can cause double accounting on ranges that are submitted async
>>> (compression for example).
>>>
>>> But that's much harder to trigger because normally we do not mix regul=
ar
>>> and compression delalloc ranges.
>>>
>>> [FIX]
>>> The folio range split is already buggy and not subpage compatible, it'=
s
>>> introduced a long time ago where subpage support is not even considere=
d.
>>>
>>> So instead of splitting the ordered extents cleanup into the folio ran=
ge
>>> and out of folio range, do all the cleanup inside writepage_delalloc()=
.
>>>
>>> - Pass @NULL as locked_folio for btrfs_cleanup_ordered_extents() in
>>> =C2=A0=C2=A0 btrfs_run_delalloc_range()
>>>
>>> - Skip the btrfs_cleanup_ordered_extents() if writepage_delalloc()
>>> =C2=A0=C2=A0 failed
>>>
>>> =C2=A0=C2=A0 So all ordered extents are only cleaned up by
>>> =C2=A0=C2=A0 btrfs_run_delalloc_range().
>>>
>>> - Handle the ranges that already have ordered extents allocated
>>> =C2=A0=C2=A0 If part of the folio already has ordered extent allocated=
, and
>>> =C2=A0=C2=A0 btrfs_run_delalloc_range() failed, we also need to cleanu=
p that
>>> range.
>>>
>>> Now we have a concentrated error handling for ordered extents during
>>> btrfs_run_delalloc_range().
>>
>> Great investigation and writeup, thanks!
>
> Thanks a lot of the review!
>
>>
>> The explanation and fix both make sense to me. I traced the change in
>> error handling and I see how we are avoiding double ending the
>> ordered_extent. So with that said, feel free to add:
>> Reviewed-by: Boris Burkov <boris@bur.io>
>>
>> However, I would like to request one thing, if I may.
>> While this is all still relatively fresh in your mind, could you please
>> document the intended behavior of the various functions (at least the
>> ones you modify/reason about) with regards to:
>> - cleanup state of the various objects involved like ordered_extents
>> =C2=A0=C2=A0 and subpages (e.g., writepage_delalloc cleans up ordered e=
xtents, so
>> =C2=A0=C2=A0 callers should not, etc.)
>
> The subpage one should not be considered as something special, it's
> really just some kind of enhanced page flags for subpage cases.
>
> Thus I'll not explicitly mention the subpage bitmap, but directly
> mention the involved flags (in this particular case, folio Ordered and
> Locked flags).
>
>> - return values (e.g., when precisely does btrfs_run_delalloc_range
>> =C2=A0=C2=A0 return >=3D 0 ?)
>
> My bad, I should update the comment in commit d034cdb4cc8a ("btrfs: lock
> subpage ranges in one go for writepage_delalloc()").
>
> Still better fix it here before too late.
>
>> - anything else you think would be helpful for reasoning about these
>> =C2=A0=C2=A0 functions in an abstract way while you are at it.
>>
>> That request is obviously optional for landing these fixes, but I reall=
y
>> think it would help if we went through the bother every time we
>> deciphered one of these undocumented paths. A restatement of your best
>> understanding of the behavior now will really pay off for the next
>> person reading this code :)

And since we're here, just a quick note for the patch 4/5, that although
those two patches are fixing error handling, they are still mostly
backport oriented fixes (although I'm 100% sure it will cause conflicts).

They still are doing cross-layer error handling. E.g. the ordered
extents cleanup are not inside cow_file_range(), but done by
btrfs_run_delalloc_range().

I'm going to properly fix all those cross-layer error handling in the
next series soon.

Thanks,
Qu
>>
>> Thanks,
>> Boris
>>
>>>
>>> Cc: stable@vger.kernel.org # 5.15+
>>> Fixes: d1051d6ebf8e ("btrfs: Fix error handling in
>>> btrfs_cleanup_ordered_extents")
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> =C2=A0 fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++++++++++++-----
>>> =C2=A0 fs/btrfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 2 files changed, 33 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 9725ff7f274d..417c710c55ca 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -1167,6 +1167,12 @@ static noinline_for_stack int
>>> writepage_delalloc(struct btrfs_inode *inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * last delalloc end.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 last_delalloc_end =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Save the last successfully ran delalloc ra=
nge end (exclusive).
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * This is for error handling to avoid ranges=
 with ordered
>>> extent created
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * but no IO will be submitted due to error.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>> nit: last_finished what? I feel this name or comment could use some
>> extra work.
>
> I can enhance it to @last_finished_delalloc_end and update the comment.
>
> Thanks,
> Qu
>
>>
>>> +=C2=A0=C2=A0=C2=A0 u64 last_finished =3D page_start;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 delalloc_start =3D page_start;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 delalloc_end =3D page_end;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 delalloc_to_write =3D 0;
>>> @@ -1235,11 +1241,19 @@ static noinline_for_stack int
>>> writepage_delalloc(struct btrfs_inode *inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 found_len =3D last_delalloc_end + 1 - found_start;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret >=3D 0)=
 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Some delalloc range may be created by previous folios.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Thus we still need to clean those range up during error
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * handling.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 la=
st_finished =3D found_start;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* No errors hit so far, run the current delalloc
>>> range. */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ret =3D btrfs_run_delalloc_range(inode, folio,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_start,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_start + found_le=
n - 1,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wbc);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (ret >=3D 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 last_finished =3D found_start + found_len;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * We've hit an error during previous delalloc range,
>>> @@ -1274,8 +1288,21 @@ static noinline_for_stack int
>>> writepage_delalloc(struct btrfs_inode *inode,
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delalloc_start =
=3D found_start + found_len;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * It's possible we have some ordered extents=
 created before we hit
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * an error, cleanup non-async successfully c=
reated delalloc
>>> ranges.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (unlikely(ret < 0)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int bitmap_size =
=3D min(
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (l=
ast_finished - page_start) >> fs_info->sectorsize_bits,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs=
_info->sectors_per_page);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_set_bit(bit, &bio=
_ctrl->submit_bitmap, bitmap_size)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt=
rfs_mark_ordered_io_finished(inode, folio,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 page_start + (bit << fs_info->sectorsize_bits),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fs_info->sectorsize, false);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 out:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (last_delalloc_end)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delalloc_end =
=3D last_delalloc_end;
>>> @@ -1509,13 +1536,13 @@ static int extent_writepage(struct folio
>>> *folio, struct btrfs_bio_ctrl *bio_ctrl
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_ctrl->wbc->nr_to_write--;
>>>
>>> -done:
>>> -=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_mark_orde=
red_io_finished(BTRFS_I(inode), folio,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_start, PAGE_SIZE, !ret);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapping_set_error(folio->m=
apping, ret);
>>> -=C2=A0=C2=A0=C2=A0 }
>>>
>>> +done:
>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapping_set_error(folio->m=
apping, ret);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Only unlock ranges that are sub=
mitted. As there can be some
>>> async
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * submitted ranges inside the fol=
io.
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index c4997200dbb2..d41bb47d59fb 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -2305,7 +2305,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode
>>> *inode, struct folio *locked_fol
>>>
>>> =C2=A0 out:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_cleanup_ordered_exte=
nts(inode, locked_folio, start,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_cleanup_ordered_exte=
nts(inode, NULL, start,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 end - start + 1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> --
>>> 2.47.1
>>>
>>
>
>


