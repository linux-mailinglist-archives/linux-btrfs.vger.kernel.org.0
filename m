Return-Path: <linux-btrfs+bounces-14852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA34AE3B6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 12:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BF7189824F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9AE239581;
	Mon, 23 Jun 2025 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sCFN64Or"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405032192EC;
	Mon, 23 Jun 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672771; cv=none; b=ZGssl2em4nPu0myou8bG5eYdGkscLjsNi6j7xnFzliuI3Pq+MCkkjTCPCEZqKy59s2jifQWYizVRzpPNuEDFjmPa+B6IJIn9gHvC7nB5EkCKvdz/sNlFCC9e8yBh6Qpi0rQ/5vNX7upBCdNp4o7hdMi2Ehqph45Ytd7KfstDKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672771; c=relaxed/simple;
	bh=x4DCYT+BJ5+MD9ALf2c1NxnwnezyUJ+9+EA9VYzFP3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlhNKcFvgUHghODtuKaHhIj3Xq5v7D0wsDvWPuRpquNlZ7E0rEyd9s8ZUxpsDTYTyLcqPQd/GrXM7Es2yoRijH0KyNJKkU+uJBCgg70/yJiI2ThPkCxwApijNpCX3okfWNzVwnJdFzhF66lQZee0gA1UTkJHWz5op1p/ubcwrpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sCFN64Or; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750672733; x=1751277533; i=quwenruo.btrfs@gmx.com;
	bh=3TLTsW0uu++jW1ibzFZf44ibWD3Lm+loYM9E0n0ZYfg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sCFN64OrlU3Dydn5gg5nKX/WVwJDKE9JWDluWzpQot3rjmEcHukqtHBtMgtf6f/v
	 ri9BhiqqlKDfxwlSc48Zkr7jte688EUNw1ELfbFom9Lb1riBTfMzLBTbkrT3JaXRe
	 EEVXDVSdDMEKlPsIGkR9lSKc7UF/ms0+IOMoXN2zDtr6B0DBuFI5kkzgz99tslENE
	 wjSDBoQNJavdsxp/oBvKO/0EOF5Kj3hOxNCGDQiUz55hvJMqiQ6ZsXVGCqSTO5lzE
	 xKS9kQxUf9rP+upA5nfRgzC+vEicj+K+cpK/+06i8Vj1zHi96pibpkV3fmrM0thrt
	 2TtnkJAjqb9iaYJM6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1v4LoR2J9T-00lpeb; Mon, 23
 Jun 2025 11:58:53 +0200
Message-ID: <a93738a1-57af-4eef-9a32-edfc60c7e7b4@gmx.com>
Date: Mon, 23 Jun 2025 19:28:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] DEPT report on around btrfs, unlink, and truncate
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, linux-btrfs@vger.kernel.org, kernel_team@skhynix.com,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 yeoreum.yun@arm.com, yunseong.kim@ericsson.com, gwan-gyeong.mun@intel.com,
 harry.yoo@oracle.com, ysk@kzalloc.com
References: <20250623032152.GB70156@system.software.com>
 <55c8b839-e844-49fe-bedc-948e60f681c7@gmx.com>
 <20250623081919.GA53365@system.software.com>
 <474347bb-bbba-4238-8964-299f87de664a@gmx.com>
 <20250623095250.GA3199@system.software.com>
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
In-Reply-To: <20250623095250.GA3199@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4WxVheuQIcm+gpjh2YDq7q1X4KtD44rxyaZ5DRk/s2Lql/XAHuU
 sbeKTy9OzenJVmfMxTmHJFCgKu95BOHcLid0e+KCL/tT5CrHCT/7z+BeoOSBsI4XrwxqakS
 MTF80Z8BZLMaopCpdcKwhhXPFx7qveCH27+ev4bjkVIXsFuhqIFUuWop5mRb+0Y8Tl3gQzG
 BQZB/gVzDZOJxLOjuaj7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xQC4rBLWRXQ=;6WtYqQ5j5Zta8mL6sGIUavQwiaz
 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



=E5=9C=A8 2025/6/23 19:22, Byungchul Park =E5=86=99=E9=81=93:
> On Mon, Jun 23, 2025 at 06:22:44PM +0930, Qu Wenruo wrote:
>> =E5=9C=A8 2025/6/23 17:49, Byungchul Park =E5=86=99=E9=81=93:
>>> On Mon, Jun 23, 2025 at 03:20:43PM +0930, Qu Wenruo wrote:
>>>> =E5=9C=A8 2025/6/23 12:51, Byungchul Park =E5=86=99=E9=81=93:
>>>>> Hi folks,
>>>>>
>>>>> Thanks to Yunseong, we got two DEPT reports in btrfs.  It doesn't me=
an
>>>>> it's obvious deadlocks, but after digging into the reports, I'm
>>>>> wondering if it could happen by any chance.
>>>>>
>>>>> 1) The first scenario that I'm concerning is:
>>>>>
>>>>>      context A            context B
>>>>>
>>>>>                           do_truncate()
>>>>>                             ...
>>>>>                               btrfs_do_readpage() // with folio lock=
 held
>>>>
>>>>                                  This one is for data.
>>>
>>> Do you mean this folio is for data?  Thanks for the confirmation.
>>
>> Yes, only data folios will go through btrfs_do_readpage().
>>
>> For metadata, we never go through btrfs_do_readpage(), but
>> read_extent_buffer_pages_nowait().
>>
>>
>>>
>>>>>      do_unlinkat()
>>>>>        ...
>>>>>          push_leaf_right()
>>>>>         btrfs_tree_lock_nested()
>>>>>           down_write_nested(&eb->lock) // hold
>>>
>>> This is struct extent_buffer's rw_sem.  Right?
>>>
>>>>>                                 btrfs_get_extent()
>>>>>                                   btrfs_lookup_file_extent()
>>>>>                                     btrfs_search_slot()
>>>>>                                       down_read_nested(&eb->lock) //=
 stuck
>>>>
>>>>                                          This one is for metadata.
>>>                                                ^
>>>                                        I don't get this actually.
>>>
>>> This is struct extent_buffer's rw_sem, too.  Cannot this rw_sem be the
>>> same as the rw_sem above in context A?
>>
>> My bad, I thought you're talking about that down_read_nested()
>> conflicting with folio lock.
>>
>> But if you're talking about extent_buffer::lock, then the one in contex=
t
>> B will wait for the one in context A, and that's expected.
>=20
> Sounds good.
>=20
>>>> Data and metadata page cache will never cross into each other.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>           __push_leaf_right()
>>>>>             ...
>>>>>               folio_lock() // stuck
>>>
>>> Did you mean this folio is always for metadata?
>>
>> Can you explain more on where this folio_lock() comes from?
>=20
> I should also rely on the following stacktrace in the dept report.  I
> asked Yunseong who reported this issue, for the decoded stacktrace, so
> that I can interpret that better.  I will get back once I figure out
> where the wait on PG_locked comes from.
>=20
>     [  304.344198][ T7488] [W] dept_page_wait_on_bit(pg_locked_map:0):
>     [  304.344211][ T7488] [<ffff8000823b1d20>] __push_leaf_right+0x8f0/=
0xc70

I believe it's from btrfs_clear_buffer_dirty():

As we have a for() loop iterating all the folios of a an extent buffer=20
(aka, metadata structure), then clear the dirty flags.

The same applies to btrfs_mark_buffer_dirty() -> set_extent_buffer_dirty()=
.

In that case, the folio is 100% belonging to btree inode thus metadata.

Thus the folio lock can not conflict with a data folio, thus there=20
should be no deadlock.

Thanks,
Qu


>     [  304.344232][ T7488] stacktrace:
>     [  304.344241][ T7488]       __push_leaf_right+0x8f0/0xc70
>     [  304.344260][ T7488]       push_leaf_right+0x408/0x628
>     [  304.344278][ T7488]       btrfs_del_items+0x974/0xaec
>     [  304.344297][ T7488]       btrfs_truncate_inode_items+0x1c5c/0x2b0=
0
>     [  304.344314][ T7488]       btrfs_evict_inode+0xa4c/0xd38
>     [  304.344335][ T7488]       evict+0x340/0x7b0
>     [  304.344352][ T7488]       iput+0x4ec/0x840
>     [  304.344369][ T7488]       do_unlinkat+0x444/0x59c
>     [  304.344388][ T7488]       __arm64_sys_unlinkat+0x11c/0x260
>     [  304.344407][ T7488]       invoke_syscall+0x88/0x2e0
>     [  304.344425][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
>     [  304.344445][ T7488]       do_el0_svc+0x44/0x60
>     [  304.344463][ T7488]       el0_svc+0x50/0x188
>     [  304.344482][ T7488]       el0t_64_sync_handler+0x10c/0x140
>     [  304.344503][ T7488]       el0t_64_sync+0x198/0x19c
>=20
> Thanks.
>=20
> 	Byungchul
>=20
>> I didn't see any location where __push_leaf_right() is locking a folio
>> nor the original do_unlinkat().
>>
>> So here I can only guess the folio is from __push_leaf_right() context,
>> that means it can only be a metadata folio.
>>
>>>
>>> If no, it could lead a deadlock in my opinion.  If yes, dept should
>>> assign different classes to folios between data data and metadata.
>>
>> So far I believe the folio belongs to metadata.
>>
>> And since btrfs has very different handling of metadata folios, and it'=
s
>> a little confusing that, we also have a btree_inode to handle the
>> metadata page cache, but do not have read_folio() callbacks, it can be =
a
>> little confusing to some automatic tools.
>>
>> Thanks,
>> Qu




