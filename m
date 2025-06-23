Return-Path: <linux-btrfs+bounces-14845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796BCAE352F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 07:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E6E3B14B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 05:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAF91D88D7;
	Mon, 23 Jun 2025 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ppW5tDbk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1DD1C862B;
	Mon, 23 Jun 2025 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750657877; cv=none; b=qH9rNPeQEGDDDR8taejltjNLjpwKsHMV4BnBvWnbbf2z7dcD+fas74AzNKdpYtZWcavYmNTzh897hTsyBQHrL+mSav2OLeXfYxKU39vUkrCLY6gXxqRd59erT+5xv2vzP0KfSyel6r5wELyDjg5q9bHKPnf8kw4uSj0qdddYWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750657877; c=relaxed/simple;
	bh=W9uwQoYw0YTbjz/35hZfFK3sYCCCdJSJqXLSMfmgecs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aO+Kh3iu6V9tWLaNfk54tw1fmYkFETYojnA+C0Sm1gL+ZbW2wYItwIdZ0Ddj2q/vf80ytTXSXxnxjIfV8yaxT5uzldnFUkiP63F2rp0qD6dHpg5QJe6GApooCgk/l1iM6zsFUUCb/e/kSJj1PrUozGVHekBK/j/HAL4tCf8oAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ppW5tDbk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750657856; x=1751262656; i=quwenruo.btrfs@gmx.com;
	bh=vTYRi7SsIOfrGQaEKPHppvlqcuX9j6RcjWAPG4EX80s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ppW5tDbklJJ4TRjijQUnGn703dfQeyHE0Ede6BDEMaRYgysp5dgfxBN3uWrFrYMr
	 9E2wK3fHovPe4J9jAKBY7+chssxwgMsXbtAdkhj+ApK1joo2+MeS7+cvQpNfSojzQ
	 JVs89BjCq1U5hDI1NFVvvv02qVIMxljqvfK10KN60Lg689Fop8FgyGmCCLGMaRWkc
	 EAEMwyrMGmugH2YHaRWkQjfvW1xuo/BNggZK1T2+yei2KPwXUbCoZD4ddgaCaWYff
	 fmc4bO1b7ESJVH/EjJUNFENyo4JUkHhkDliMAuMtuRcToUwMegOfdk37t9GAEfo58
	 7vH1KwuMSN8u+vB7Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ml6m4-1vAIoF2zz2-00bOwM; Mon, 23
 Jun 2025 07:50:56 +0200
Message-ID: <55c8b839-e844-49fe-bedc-948e60f681c7@gmx.com>
Date: Mon, 23 Jun 2025 15:20:43 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] DEPT report on around btrfs, unlink, and truncate
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
 clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org
Cc: kernel_team@skhynix.com, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, yeoreum.yun@arm.com, yunseong.kim@ericsson.com,
 gwan-gyeong.mun@intel.com, harry.yoo@oracle.com, ysk@kzalloc.com
References: <20250623032152.GB70156@system.software.com>
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
In-Reply-To: <20250623032152.GB70156@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iJhBABkkSVYjkvZtUcSeHuK119lRVUsMI9KOz1fq3F1/R9wu+mg
 GxcMHnKuTtDI5s7YsXXTgv9JlVRKhZP33Pko2QLVympmiRveIqOMFM8Bic91ZC3dND1bx0a
 dS4D04WL2hP6v5qH42h+YXZIWMLCBbpYJJPNhgGVTMVn1wS9YsLnO0s6B3INR6yphfsibrk
 hdpXR/HZwIJhkxwI3mJrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dVF9Cxwd460=;HIqEMToi43dRwD3F0rtWGtrzJ76
 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
 rDeZa7n5waGj6qI2



=E5=9C=A8 2025/6/23 12:51, Byungchul Park =E5=86=99=E9=81=93:
> Hi folks,
>=20
> Thanks to Yunseong, we got two DEPT reports in btrfs.  It doesn't mean
> it's obvious deadlocks, but after digging into the reports, I'm
> wondering if it could happen by any chance.
>=20
> 1) The first scenario that I'm concerning is:
>=20
>    context A		  context B
>=20
> 			  do_truncate()
> 			    ...
> 			      btrfs_do_readpage() // with folio lock held

				This one is for data.>    do_unlinkat()
>      ...
>        push_leaf_right()
> 	btrfs_tree_lock_nested()
> 	  down_write_nested(&eb->lock) // hold
> 			        btrfs_get_extent()
> 			          btrfs_lookup_file_extent()
> 			            btrfs_search_slot()
> 			              down_read_nested(&eb->lock) // stuck

					This one is for metadata.

Data and metadata page cache will never cross into each other.

Thanks,
Qu

> 	  __push_leaf_right()
> 	    ...
> 	      folio_lock() // stuck
>=20
> 2) The second scenario that I'm concerning is:
>=20
>    context A		  context B
>=20
> 			  do_truncate()
> 			    ...
> 			      btrfs_do_readpage() // with folio lock held
>    do_unlinkat()
>      ...
>        btrfs_truncate_inode_items()
> 	btrfs_lock_root_node()
> 	  down_write_nested(&eb->lock) // hold
> 	btrfs_del_items()
> 	  push_leaf_right()
> 	    __push_leaf_right()
> 			        btrfs_get_extent()
> 			          btrfs_lookup_file_extent()
> 			            btrfs_search_slot()
> 			              btrfs_read_lock_root_node()
> 			                down_read_nested(&eb->lock) // stuck
> 	      ...
> 	        folio_lock() //stuck
>=20
> Am I missing something?
>=20
> FYI, the followings are the DEPT reports we got.
>=20
> 	Byungchul
>=20
> ---
>   [  304.343395][ T7488] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   [  304.343446][ T7488] DEPT: Circular dependency has been detected.
>   [  304.343462][ T7488] 6.15.0-rc6-00043-ga83a69ec7f9f #5 Not tainted
>   [  304.343477][ T7488] -----------------------------------------------=
=2D---
>   [  304.343488][ T7488] summary
>   [  304.343498][ T7488] -----------------------------------------------=
=2D---
>   [  304.343509][ T7488] *** DEADLOCK ***
>   [  304.343509][ T7488]
>   [  304.343520][ T7488] context A
>   [  304.343531][ T7488]    [S] lock(btrfs-tree-00:0)
>   [  304.343545][ T7488]    [W] dept_page_wait_on_bit(pg_locked_map:0)
>   [  304.343559][ T7488]    [E] unlock(btrfs-tree-00:0)
>   [  304.343572][ T7488]
>   [  304.343581][ T7488] context B
>   [  304.343591][ T7488]    [S] (unknown)(pg_locked_map:0)
>   [  304.343603][ T7488]    [W] lock(btrfs-tree-00:0)
>   [  304.343616][ T7488]    [E] dept_page_clear_bit(pg_locked_map:0)
>   [  304.343629][ T7488]
>   [  304.343637][ T7488] [S]: start of the event context
>   [  304.343647][ T7488] [W]: the wait blocked
>   [  304.343656][ T7488] [E]: the event not reachable
>   [  304.343666][ T7488] -----------------------------------------------=
=2D---
>   [  304.343676][ T7488] context A's detail
>   [  304.343686][ T7488] -----------------------------------------------=
=2D---
>   [  304.343696][ T7488] context A
>   [  304.343706][ T7488]    [S] lock(btrfs-tree-00:0)
>   [  304.343718][ T7488]    [W] dept_page_wait_on_bit(pg_locked_map:0)
>   [  304.343731][ T7488]    [E] unlock(btrfs-tree-00:0)
>   [  304.343744][ T7488]
>   [  304.343753][ T7488] [S] lock(btrfs-tree-00:0):
>   [  304.343764][ T7488] [<ffff8000824f41d8>] btrfs_tree_lock_nested+0x3=
8/0x324
>   [  304.343796][ T7488] stacktrace:
>   [  304.343805][ T7488]       down_write_nested+0xe4/0x21c
>   [  304.343826][ T7488]       btrfs_tree_lock_nested+0x38/0x324
>   [  304.343865][ T7488]       push_leaf_right+0x23c/0x628
>   [  304.343896][ T7488]       btrfs_del_items+0x974/0xaec
>   [  304.343916][ T7488]       btrfs_truncate_inode_items+0x1c5c/0x2b00
>   [  304.343938][ T7488]       btrfs_evict_inode+0xa4c/0xd38
>   [  304.343968][ T7488]       evict+0x340/0x7b0
>   [  304.343993][ T7488]       iput+0x4ec/0x840
>   [  304.344011][ T7488]       do_unlinkat+0x444/0x59c
>   [  304.344038][ T7488]       __arm64_sys_unlinkat+0x11c/0x260
>   [  304.344057][ T7488]       invoke_syscall+0x88/0x2e0
>   [  304.344084][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
>   [  304.344104][ T7488]       do_el0_svc+0x44/0x60
>   [  304.344123][ T7488]       el0_svc+0x50/0x188
>   [  304.344151][ T7488]       el0t_64_sync_handler+0x10c/0x140
>   [  304.344172][ T7488]       el0t_64_sync+0x198/0x19c
>   [  304.344189][ T7488]
>   [  304.344198][ T7488] [W] dept_page_wait_on_bit(pg_locked_map:0):
>   [  304.344211][ T7488] [<ffff8000823b1d20>] __push_leaf_right+0x8f0/0x=
c70
>   [  304.344232][ T7488] stacktrace:
>   [  304.344241][ T7488]       __push_leaf_right+0x8f0/0xc70
>   [  304.344260][ T7488]       push_leaf_right+0x408/0x628
>   [  304.344278][ T7488]       btrfs_del_items+0x974/0xaec
>   [  304.344297][ T7488]       btrfs_truncate_inode_items+0x1c5c/0x2b00
>   [  304.344314][ T7488]       btrfs_evict_inode+0xa4c/0xd38
>   [  304.344335][ T7488]       evict+0x340/0x7b0
>   [  304.344352][ T7488]       iput+0x4ec/0x840
>   [  304.344369][ T7488]       do_unlinkat+0x444/0x59c
>   [  304.344388][ T7488]       __arm64_sys_unlinkat+0x11c/0x260
>   [  304.344407][ T7488]       invoke_syscall+0x88/0x2e0
>   [  304.344425][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
>   [  304.344445][ T7488]       do_el0_svc+0x44/0x60
>   [  304.344463][ T7488]       el0_svc+0x50/0x188
>   [  304.344482][ T7488]       el0t_64_sync_handler+0x10c/0x140
>   [  304.344503][ T7488]       el0t_64_sync+0x198/0x19c
>   [  304.344518][ T7488]
>   [  304.344527][ T7488] [E] unlock(btrfs-tree-00:0):
>   [  304.344539][ T7488] (N/A)
>   [  304.344549][ T7488] -----------------------------------------------=
=2D---
>   [  304.344559][ T7488] context B's detail
>   [  304.344568][ T7488] -----------------------------------------------=
=2D---
>   [  304.344578][ T7488] context B
>   [  304.344588][ T7488]    [S] (unknown)(pg_locked_map:0)
>   [  304.344600][ T7488]    [W] lock(btrfs-tree-00:0)
>   [  304.344613][ T7488]    [E] dept_page_clear_bit(pg_locked_map:0)
>   [  304.344625][ T7488]
>   [  304.344634][ T7488] [S] (unknown)(pg_locked_map:0):
>   [  304.344646][ T7488] (N/A)
>   [  304.344655][ T7488]
>   [  304.344663][ T7488] [W] lock(btrfs-tree-00:0):
>   [  304.344675][ T7488] [<ffff8000824f3b48>] btrfs_tree_read_lock_neste=
d+0x38/0x330
>   [  304.344694][ T7488] stacktrace:
>   [  304.344703][ T7488]       down_read_nested+0xc8/0x368
>   [  304.344720][ T7488]       btrfs_tree_read_lock_nested+0x38/0x330
>   [  304.344737][ T7488]       btrfs_search_slot+0x1204/0x2dc8
>   [  304.344756][ T7488]       btrfs_lookup_file_extent+0xe0/0x128
>   [  304.344773][ T7488]       btrfs_get_extent+0x2cc/0x1e24
>   [  304.344789][ T7488]       btrfs_do_readpage+0x628/0x1258
>   [  304.344810][ T7488]       btrfs_read_folio+0x310/0x450
>   [  304.344828][ T7488]       btrfs_truncate_block+0x2c0/0xb24
>   [  304.344854][ T7488]       btrfs_cont_expand+0x11c/0xba8
>   [  304.344870][ T7488]       btrfs_setattr+0x8d8/0x10f4
>   [  304.344885][ T7488]       notify_change+0x900/0xfbc
>   [  304.344906][ T7488]       do_truncate+0x154/0x210
>   [  304.344937][ T7488]       vfs_truncate+0x55c/0x66c
>   [  304.344957][ T7488]       __arm64_sys_truncate+0x16c/0x1e4
>   [  304.344978][ T7488]       invoke_syscall+0x88/0x2e0
>   [  304.344997][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
>   [  304.345017][ T7488]
>   [  304.345025][ T7488] [E] dept_page_clear_bit(pg_locked_map:0):
>   [  304.345037][ T7488] [<ffff80008249c284>] end_folio_read+0x3e4/0x590
>   [  304.345056][ T7488] stacktrace:
>   [  304.345065][ T7488]       folio_unlock+0x8c/0x160
>   [  304.345099][ T7488]       end_folio_read+0x3e4/0x590
>   [  304.345116][ T7488]       btrfs_do_readpage+0x830/0x1258
>   [  304.345132][ T7488]       btrfs_read_folio+0x310/0x450
>   [  304.345149][ T7488]       btrfs_truncate_block+0x2c0/0xb24
>   [  304.345164][ T7488]       btrfs_cont_expand+0x11c/0xba8
>   [  304.345179][ T7488]       btrfs_setattr+0x8d8/0x10f4
>   [  304.345194][ T7488]       notify_change+0x900/0xfbc
>   [  304.345213][ T7488]       do_truncate+0x154/0x210
>   [  304.345232][ T7488]       vfs_truncate+0x55c/0x66c
>   [  304.345252][ T7488]       __arm64_sys_truncate+0x16c/0x1e4
>   [  304.345272][ T7488]       invoke_syscall+0x88/0x2e0
>   [  304.345291][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
>   [  304.345310][ T7488]       do_el0_svc+0x44/0x60
>   [  304.345328][ T7488]       el0_svc+0x50/0x188
>   [  304.345347][ T7488]       el0t_64_sync_handler+0x10c/0x140
>   [  304.345369][ T7488] -----------------------------------------------=
=2D---
>   [  304.345379][ T7488] information that might be helpful
>   [  304.345388][ T7488] -----------------------------------------------=
=2D---
>   [  304.345402][ T7488] CPU: 1 UID: 0 PID: 7488 Comm: syz-executor Not =
tainted 6.15.0-rc6-00043-ga83a69ec7f9f #5 PREEMPT
>   [  304.345416][ T7488] Hardware name: QEMU KVM Virtual Machine, BIOS 2=
025.02-8 05/13/2025
>   [  304.345422][ T7488] Call trace:
>   [  304.345426][ T7488]  show_stack+0x34/0x80 (C)
>   [  304.345452][ T7488]  dump_stack_lvl+0x104/0x180
>   [  304.345476][ T7488]  dump_stack+0x20/0x2c
>   [  304.345490][ T7488]  cb_check_dl+0x1080/0x10ec
>   [  304.345504][ T7488]  bfs+0x4d8/0x630
>   [  304.345514][ T7488]  add_dep+0x1cc/0x364
>   [  304.345526][ T7488]  __dept_wait+0x60c/0x16e0
>   [  304.345537][ T7488]  dept_wait+0x168/0x1a8
>   [  304.345548][ T7488]  btrfs_clear_buffer_dirty+0x420/0x820
>   [  304.345561][ T7488]  __push_leaf_right+0x8f0/0xc70
>   [  304.345575][ T7488]  push_leaf_right+0x408/0x628
>   [  304.345589][ T7488]  btrfs_del_items+0x974/0xaec
>   [  304.345603][ T7488]  btrfs_truncate_inode_items+0x1c5c/0x2b00
>   [  304.345616][ T7488]  btrfs_evict_inode+0xa4c/0xd38
>   [  304.345632][ T7488]  evict+0x340/0x7b0
>   [  304.345644][ T7488]  iput+0x4ec/0x840
>   [  304.345657][ T7488]  do_unlinkat+0x444/0x59c
>   [  304.345671][ T7488]  __arm64_sys_unlinkat+0x11c/0x260
>   [  304.345685][ T7488]  invoke_syscall+0x88/0x2e0
>   [  304.345698][ T7488]  el0_svc_common.constprop.0+0xe8/0x2e0
>   [  304.345713][ T7488]  do_el0_svc+0x44/0x60
>   [  304.345726][ T7488]  el0_svc+0x50/0x188
>   [  304.345741][ T7488]  el0t_64_sync_handler+0x10c/0x140
>   [  304.345756][ T7488]  el0t_64_sync+0x198/0x19c
>   [  304.345857][ T7488] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   [  304.345995][ T7488] DEPT: Circular dependency has been detected.
>   [  304.346006][ T7488] 6.15.0-rc6-00043-ga83a69ec7f9f #5 Not tainted
>   [  304.346019][ T7488] -----------------------------------------------=
=2D---
>   [  304.346029][ T7488] summary
>   [  304.346038][ T7488] -----------------------------------------------=
=2D---
>   [  304.346049][ T7488] *** DEADLOCK ***
>   [  304.346049][ T7488]
>   [  304.346058][ T7488] context A
>   [  304.346069][ T7488]    [S] lock(btrfs-tree-01:0)
>   [  304.346082][ T7488]    [W] dept_page_wait_on_bit(pg_locked_map:0)
>   [  304.346095][ T7488]    [E] unlock(btrfs-tree-01:0)
>   [  304.346108][ T7488]
>   [  304.346117][ T7488] context B
>   [  304.346126][ T7488]    [S] (unknown)(pg_locked_map:0)
>   [  304.346139][ T7488]    [W] lock(btrfs-tree-01:0)
>   [  304.346151][ T7488]    [E] dept_page_clear_bit(pg_locked_map:0)
>   [  304.346164][ T7488]
>   [  304.346173][ T7488] [S]: start of the event context
>   [  304.346183][ T7488] [W]: the wait blocked
>   [  304.346192][ T7488] [E]: the event not reachable
>   [  304.346201][ T7488] -----------------------------------------------=
=2D---
>   [  304.346211][ T7488] context A's detail
>   [  304.346221][ T7488] -----------------------------------------------=
=2D---
>   [  304.346231][ T7488] context A
>   [  304.346240][ T7488]    [S] lock(btrfs-tree-01:0)
>   [  304.346253][ T7488]    [W] dept_page_wait_on_bit(pg_locked_map:0)
>   [  304.346266][ T7488]    [E] unlock(btrfs-tree-01:0)
>   [  304.346278][ T7488]
>   [  304.346287][ T7488] [S] lock(btrfs-tree-01:0):
>   [  304.346299][ T7488] [<ffff8000824f41d8>] btrfs_tree_lock_nested+0x3=
8/0x324
>   [  304.346321][ T7488] stacktrace:
>   [  304.346330][ T7488]       down_write_nested+0xe4/0x21c
>   [  304.346347][ T7488]       btrfs_tree_lock_nested+0x38/0x324
>   [  304.346363][ T7488]       btrfs_lock_root_node+0x70/0xac
>   [  304.346379][ T7488]       btrfs_search_slot+0x3f8/0x2dc8
>   [  304.346399][ T7488]       btrfs_truncate_inode_items+0x2ec/0x2b00
>   [  304.346417][ T7488]       btrfs_evict_inode+0xa4c/0xd38
>   [  304.346438][ T7488]       evict+0x340/0x7b0
>   [  304.346456][ T7488]       iput+0x4ec/0x840
>   [  304.346473][ T7488]       do_unlinkat+0x444/0x59c
>   [  304.346492][ T7488]       __arm64_sys_unlinkat+0x11c/0x260
>   [  304.346511][ T7488]       invoke_syscall+0x88/0x2e0
>   [  304.346530][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
>   [  304.346550][ T7488]       do_el0_svc+0x44/0x60
>   [  304.346568][ T7488]       el0_svc+0x50/0x188
>   [  304.346588][ T7488]       el0t_64_sync_handler+0x10c/0x140
>   [  304.346608][ T7488]       el0t_64_sync+0x198/0x19c
>   [  304.346623][ T7488]
>   [  304.346632][ T7488] [W] dept_page_wait_on_bit(pg_locked_map:0):
>   [  304.346644][ T7488] [<ffff8000823b1d20>] __push_leaf_right+0x8f0/0x=
c70
>   [  304.346665][ T7488] stacktrace:
>   [  304.346674][ T7488]       __push_leaf_right+0x8f0/0xc70
>   [  304.346692][ T7488]       push_leaf_right+0x408/0x628
>   [  304.346711][ T7488]       btrfs_del_items+0x974/0xaec
>   [  304.346729][ T7488]       btrfs_truncate_inode_items+0x1c5c/0x2b00
>   [  304.346747][ T7488]       btrfs_evict_inode+0xa4c/0xd38
>   [  304.346767][ T7488]       evict+0x340/0x7b0
>   [  304.346785][ T7488]       iput+0x4ec/0x840
>   [  304.346802][ T7488]       do_unlinkat+0x444/0x59c
>   [  304.346820][ T7488]       __arm64_sys_unlinkat+0x11c/0x260
>   [  304.346850][ T7488]       invoke_syscall+0x88/0x2e0
>   [  304.346871][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
>   [  304.346891][ T7488]       do_el0_svc+0x44/0x60
>   [  304.346909][ T7488]       el0_svc+0x50/0x188
>   [  304.346928][ T7488]       el0t_64_sync_handler+0x10c/0x140
>   [  304.346949][ T7488]       el0t_64_sync+0x198/0x19c
>   [  304.346963][ T7488]
>   [  304.346972][ T7488] [E] unlock(btrfs-tree-01:0):
>   [  304.346984][ T7488] (N/A)
>   [  304.346994][ T7488] -----------------------------------------------=
=2D---
>   [  304.347004][ T7488] context B's detail
>   [  304.347013][ T7488] -----------------------------------------------=
=2D---
>   [  304.347023][ T7488] context B
>   [  304.347033][ T7488]    [S] (unknown)(pg_locked_map:0)
>   [  304.347046][ T7488]    [W] lock(btrfs-tree-01:0)
>   [  304.347058][ T7488]    [E] dept_page_clear_bit(pg_locked_map:0)
>   [  304.347071][ T7488]
>   [  304.347080][ T7488] [S] (unknown)(pg_locked_map:0):
>   [  304.347092][ T7488] (N/A)
>   [  304.347101][ T7488]
>   [  304.347109][ T7488] [W] lock(btrfs-tree-01:0):
>   [  304.347121][ T7488] [<ffff8000824f3b48>] btrfs_tree_read_lock_neste=
d+0x38/0x330
>   [  304.347140][ T7488] stacktrace:
>   [  304.347149][ T7488]       down_read_nested+0xc8/0x368
>   [  304.347165][ T7488]       btrfs_tree_read_lock_nested+0x38/0x330
>   [  304.347181][ T7488]       btrfs_read_lock_root_node+0x70/0xb4
>   [  304.347198][ T7488]       btrfs_search_slot+0x34c/0x2dc8
>   [  304.347217][ T7488]       btrfs_lookup_file_extent+0xe0/0x128
>   [  304.347233][ T7488]       btrfs_get_extent+0x2cc/0x1e24
>   [  304.347248][ T7488]       btrfs_do_readpage+0x628/0x1258
>   [  304.347270][ T7488]       btrfs_read_folio+0x310/0x450
>   [  304.347287][ T7488]       btrfs_truncate_block+0x2c0/0xb24
>   [  304.347302][ T7488]       btrfs_cont_expand+0x11c/0xba8
>   [  304.347317][ T7488]       btrfs_setattr+0x8d8/0x10f4
>   [  304.347332][ T7488]       notify_change+0x900/0xfbc
>   [  304.347352][ T7488]       do_truncate+0x154/0x210
>   [  304.347374][ T7488]       vfs_truncate+0x55c/0x66c
>   [  304.347394][ T7488]       __arm64_sys_truncate+0x16c/0x1e4
>   [  304.347414][ T7488]       invoke_syscall+0x88/0x2e0
>   [  304.347433][ T7488]
>   [  304.347441][ T7488] [E] dept_page_clear_bit(pg_locked_map:0):
>   [  304.347453][ T7488] [<ffff80008249c284>] end_folio_read+0x3e4/0x590
>   [  304.347471][ T7488] stacktrace:
>   [  304.347480][ T7488]       folio_unlock+0x8c/0x160
>   [  304.347504][ T7488]       end_folio_read+0x3e4/0x590
>   [  304.347520][ T7488]       btrfs_do_readpage+0x830/0x1258
>   [  304.347536][ T7488]       btrfs_read_folio+0x310/0x450
>   [  304.347553][ T7488]       btrfs_truncate_block+0x2c0/0xb24
>   [  304.347568][ T7488]       btrfs_cont_expand+0x11c/0xba8
>   [  304.347583][ T7488]       btrfs_setattr+0x8d8/0x10f4
>   [  304.347598][ T7488]       notify_change+0x900/0xfbc
>   [  304.347617][ T7488]       do_truncate+0x154/0x210
>   [  304.347636][ T7488]       vfs_truncate+0x55c/0x66c
>   [  304.347656][ T7488]       __arm64_sys_truncate+0x16c/0x1e4
>   [  304.347676][ T7488]       invoke_syscall+0x88/0x2e0
>   [  304.347695][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
>   [  304.347714][ T7488]       do_el0_svc+0x44/0x60
>   [  304.347732][ T7488]       el0_svc+0x50/0x188
>   [  304.347751][ T7488]       el0t_64_sync_handler+0x10c/0x140
>   [  304.347772][ T7488] -----------------------------------------------=
=2D---
>   [  304.347782][ T7488] information that might be helpful
>   [  304.347791][ T7488] -----------------------------------------------=
=2D---
>   [  304.347803][ T7488] CPU: 1 UID: 0 PID: 7488 Comm: syz-executor Not =
tainted 6.15.0-rc6-00043-ga83a69ec7f9f #5 PREEMPT
>   [  304.347815][ T7488] Hardware name: QEMU KVM Virtual Machine, BIOS 2=
025.02-8 05/13/2025
>   [  304.347821][ T7488] Call trace:
>   [  304.347825][ T7488]  show_stack+0x34/0x80 (C)
>   [  304.347852][ T7488]  dump_stack_lvl+0x104/0x180
>   [  304.347870][ T7488]  dump_stack+0x20/0x2c
>   [  304.347884][ T7488]  cb_check_dl+0x1080/0x10ec
>   [  304.347897][ T7488]  bfs+0x4d8/0x630
>   [  304.347906][ T7488]  add_dep+0x1cc/0x364
>   [  304.347917][ T7488]  __dept_wait+0x60c/0x16e0
>   [  304.347928][ T7488]  dept_wait+0x168/0x1a8
>   [  304.347940][ T7488]  btrfs_clear_buffer_dirty+0x420/0x820
>   [  304.347952][ T7488]  __push_leaf_right+0x8f0/0xc70
>   [  304.347967][ T7488]  push_leaf_right+0x408/0x628
>   [  304.347980][ T7488]  btrfs_del_items+0x974/0xaec
>   [  304.347994][ T7488]  btrfs_truncate_inode_items+0x1c5c/0x2b00
>   [  304.348007][ T7488]  btrfs_evict_inode+0xa4c/0xd38
>   [  304.348023][ T7488]  evict+0x340/0x7b0
>   [  304.348036][ T7488]  iput+0x4ec/0x840
>   [  304.348048][ T7488]  do_unlinkat+0x444/0x59c
>   [  304.348062][ T7488]  __arm64_sys_unlinkat+0x11c/0x260
>   [  304.348076][ T7488]  invoke_syscall+0x88/0x2e0
>   [  304.348090][ T7488]  el0_svc_common.constprop.0+0xe8/0x2e0
>   [  304.348105][ T7488]  do_el0_svc+0x44/0x60
>   [  304.348118][ T7488]  el0_svc+0x50/0x188
>   [  304.348132][ T7488]  el0t_64_sync_handler+0x10c/0x140
>   [  304.348148][ T7488]  el0t_64_sync+0x198/0x19c
>   [  304.386144][ T8054] BTRFS info (device loop0): first mount of files=
ystem 3a492a15-ac49-4ce6-945e-cef7a687c6c9
>   [  304.389687][ T8054] BTRFS info (device loop0): using crc32c (crc32c=
-arm64) checksum algorithm
>   [  304.389788][ T8054] BTRFS info (device loop0): using free-space-tre=
e
>   [  304.701202][ T7488] BTRFS info (device loop3): last unmount of file=
system 3a492a15-ac49-4ce6-945e-cef7a687c6c9
>=20


