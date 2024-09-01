Return-Path: <linux-btrfs+bounces-7712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F39675CE
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2024 11:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280C6B214AF
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2024 09:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CBD14C581;
	Sun,  1 Sep 2024 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Hs0bsH+O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62109339AC
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Sep 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725183924; cv=none; b=tTOHnQL+WrwldMnH5P3jD+qImTnoYXaNbRs7jM/HhEMQEc0RfE5sndiZQcGR2SedfiuxePFLra6kkdOygWqlJ9kvqfimYpGq1SfQjxDwI59noUMwlecmIzO59L7cdPgCLDm8kAcQi4bVeGwnobhgAvWYStxI9qaFlLVSOn1yrjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725183924; c=relaxed/simple;
	bh=wlYo9vsTwtl0loEN+2YlPcz1rVC5Xq0HqoJmF3n7YCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cGxb+dxkBHps2mJkqn6cvYTx9IEQoSoZRzNK+XOpuMABhMDBjD03VAmUB0o+DLFf6xy3or/Z7n18OYa2ZhkEKo391lSH2PdgocXw2YnIU+deNGRq+1WaczhKfiMs/ZKNYnkTMOxD8DZcG6evVZ2uNa/Bv1SN917wJgPFch+zKeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Hs0bsH+O; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725183917; x=1725788717; i=quwenruo.btrfs@gmx.com;
	bh=2jWhTBPEv7WQEjjSMpaLlQBx7ckoEH+zbi+Xo7TU/gQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hs0bsH+OOGN68HDlN82nmbvhGuBLPIV+IvN3AkynBWETId3NkauwqRSfklipfnj9
	 ONY5dJF8hHD/OyeG1hx3Z/jfaQ/J0B1Zt/JLh3g/BEYkUh4SFaZA2VRm4SUpYUUKi
	 eTwzOhtHGgznrlgwpp8r5uC3h+/NRP2VLYVybCwE5qeQdFB1JgoiyB91k0/AEdofU
	 kllFgpQ4GBL7A3noCBBxPwBlvgxGV5Rc/440v/ep9qRnkWe+XKnycb4leJu5kaIOC
	 WboRmNQcnosRUk38aEW67SG4UkgZp94O3gnmZWXaHb3ky7uI7XXkRqj//FNJlMceT
	 dZBOX81c/SgVORTleQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYPY-1s9QSC3Rwu-00ajFx; Sun, 01
 Sep 2024 11:45:17 +0200
Message-ID: <5fdb905b-20ee-4978-ba81-10b1fc4ac475@gmx.com>
Date: Sun, 1 Sep 2024 19:15:13 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs balance broke filesystem
To: Fergus Dall <fergus@beware.dropbear.id.au>, linux-btrfs@vger.kernel.org
References: <b9b86b32095ba924fb8c7eec4d8ec024113d9ff4.camel@beware.dropbear.id.au>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <b9b86b32095ba924fb8c7eec4d8ec024113d9ff4.camel@beware.dropbear.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uK07A5cEY9eKM+98jn6luEkLS+3GES5jSon60XjRo6cm72D9nUt
 49RdJFQPL2j93RQaDFwHw8moUOEBnfTH7WvOA0d/r+XkNAmIFfScJ2fDTa4ONUOjY141LL8
 ReOIf04u4IP2tVQTfFa1f6UIkS5QkXavwg31QN0t+6E79Q18P49XNDVtLMnArZ+UMmAT0SH
 R8ldtOyOq+rvTkXyd0Wgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wZwIWXkP5go=;NhmYiUnjlhHtVSXjQFaeJwu+eWq
 R87CnfzAHfvrAmsoW5jh1Mf4hHomHdxgVnZNSgvo2gqNbR+frrdTe+oqva2E5ZmuSxegHPn+T
 JiSCHZQc2ymKAVuYKtUVbuQqk3QYyTjxfttvnoEJEuz8n9bRGvseeNqrcJR78Odx6U1H3WG6b
 hPaUvilA78VFnf1QdKAOmsWKwLheK6tbKvwJBKAwHwputRU0fcqOOa00XgS/pWS5EA2E19ZDX
 6Fe9i2jcW5+e8L1czivxwfKaOvWxg0rDX4gGmGpkAkAKUF1rWoN1fSl+ivURtq2xdIhGgtfpg
 cOpcShZ2PDClq6h9bVTu0n9mx72yg8r27399q7Q64KyO2aGxZX0HzkZ49Pdph5HU24Lze+KTN
 aLoYshdFvK7mfw1GLW2ulwzFHxE7tobuU3zptahQCEh8XtyKMW+fo8U6wnhXiYyC4N+nBjCLJ
 QKRgUB3MUg2Nj2yLIB1eX8q7OiLTI2QFVGUj86fvPk4z1r+eDaKpDC/QSsMdyHm5g3/4zyBrD
 z2AMbVK+XVaI0cPtA4Cq5I4khrcZLEiziWxItjnqUxyW4d1hJM6+Z+7KhSA7Him/9MGgct2Fv
 rCBQEx9gRN52/smxCTX7nSE7erYdGE8Xa8q3c5VwsiFovgI8OX3/ipYgnhPNNjJUz3qjRZiXq
 IAbWsyUZXoAupZg8x1ocaQrq674c3/aJnflqsMxVsxQFssZNIxtv6djzx/g+ewr4l0IoCRmG/
 IFJZ6vLPymuofpjOWd6R3m/UOSjIVX8GIZgSgZR4XoAR+C76sZXMNqECglcwEdJELIskCKLZN
 sWfgE7ZWCvIg2kBwIuZBFV5Q==



=E5=9C=A8 2024/9/1 18:37, Fergus Dall =E5=86=99=E9=81=93:
> I recently tried to add a new disk to my existing, nearly full, btrfs
> filesystem. I then tried running "btrfs balance -mconvert=3Draid1,soft"
> to duplicate the metadata to the new disk and, like seemingly many
> people trying similar things, got an ENOSPC error followed by the
> filesystem becoming read-only.

Convert/balance is only recommended if you have unallocated space (shown
in `btrfs fi show`) to fulfill at least a metadata block group (1G in
size for most cases).

In your case, doing the covert with one full disk and one empty disk is
the worst thing you can do, because there is a known btrfs bug that such
unbalance disk usage can trick btrfs into a illusion that there are
plenty space, specially for RAID1 metadata.

Years ago I tried to push a patchset with better calculation for such
unbalanced case for all profiles, but not merged.

In that case, the first thing you should do is to at least do a metadata
balance, then try to convert to raid1.

>
> The standard advice for this situation seems to be to add a new device
> to the filesystem, then mount with "-o skip_balance", then cancel the
> existing balance operation, and finally run "btrfs balance -musage=3D0"
> to clear the allocated but unused metadata. However, in my case the
> filesystem encounters an error and becomes read-only during mount, and
> all these operations seem to require a read-write filesystem. There
> don't appear to be any mount options to skip the failing operation, or
> offline tools that can perform the necessary operations on an unmounted
> filesystem.

In that case please provide the full dmesg, especially if there is
anything before the transaction abort.

You can also try mount the fs RO first, then remount to rw, and add
device immediately.

>
> Additionally, the stack trace from the aborted transaction in the
> kernel logs appears different that has been previously reported, so
> this may be a new, or previously unreported, bug.

It's just a different timing. For this RAID1 metadata ENOSPC, it can
happen at any timing, thus the call trace is different.

Thanks,
Qu

>
> Is there any way to recover this filesystem, short of copying all the
> files somewhere else?
>
> Kernel version is 6.10.7-arch1-1, dmesg and btrfs allocation
> information below:
>
> [   42.886920] BTRFS warning (device dm-1 state M): Skipping commit of
> aborted transaction.
> [   42.886924] ------------[ cut here ]------------
> [   42.886925] BTRFS: Transaction aborted (error -28)
> [   42.886933] WARNING: CPU: 0 PID: 595 at fs/btrfs/transaction.c:1999
> btrfs_commit_transaction.cold+0x103/0x356 [btrfs]
> [   42.886975] Modules linked in: ip6t_REJECT nf_reject_ipv6 xt_hl
> ip6t_rt ipt_REJECT nf_reject_ipv4 xt_LOG nf_log_syslog xt_comment
> xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter i2c_dev
> crypto_user loop nfnetlink ip_tables x_tables btrfs blake2b_generic
> libcrc32c crc32c_generic xor raid6_pq dm_crypt cbc encrypted_keys
> trusted asn1_encoder tee hid_generic usbhid dm_mod crct10dif_pclmul
> crc32_pclmul crc32c_intel polyval_clmulni polyval_generic gf128mul
> ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 nvme
> aesni_intel nvme_core crypto_simd ccp cryptd xhci_pci nvme_auth
> xhci_pci_renesas
> [   42.887019] CPU: 0 PID: 595 Comm: btrfs-transacti Not tainted
> 6.10.7-arch1-1 #1 2b2df360fbb0436393dc89f6589e9eeea2964ecb
> [   42.887022] Hardware name: To Be Filled By O.E.M. X570 Phantom
> Gaming 4/X570 Phantom Gaming 4, BIOS P5.60 01/18/2024
> [   42.887024] RIP: 0010:btrfs_commit_transaction.cold+0x103/0x356
> [btrfs]
> [   42.887055] Code: f3 ff 4c 89 ef e8 c3 15 09 ce e9 a5 f3 f3 ff 0f 0b
> e9 6e ff ff ff 45 31 c0 eb 9f 44 89 f6 48 c7 c7 10 c0 81 c0 e8 83 7b 34
> cd <0f> 0b eb 86 49 3b 9c 24 40 02 00 00 75 2a c7 43 20 03 00 00 00 48
> [   42.887057] RSP: 0018:ffffbfa78430fe30 EFLAGS: 00010282
> [   42.887059] RAX: 0000000000000000 RBX: ffff9d080c959e00 RCX:
> 0000000000000027
> [   42.887061] RDX: ffff9d16fea219c8 RSI: 0000000000000001 RDI:
> ffff9d16fea219c0
> [   42.887062] RBP: ffff9d080d0c9150 R08: 0000000000000000 R09:
> ffffbfa78430fcb0
> [   42.887064] R10: ffffffff8fab21e8 R11: 0000000000000003 R12:
> ffff9d080eb3e000
> [   42.887065] R13: ffff9d080d0c90a0 R14: 00000000ffffffe4 R15:
> ffff9d080d0c90a0
> [   42.887066] FS:  0000000000000000(0000) GS:ffff9d16fea00000(0000)
> knlGS:0000000000000000
> [   42.887068] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.887070] CR2: 00007f01caa5a168 CR3: 0000000106234000 CR4:
> 0000000000f50ef0
> [   42.887071] PKRU: 55555554
> [   42.887073] Call Trace:
> [   42.887075]  <TASK>
> [   42.887076]  ? btrfs_commit_transaction.cold+0x103/0x356 [btrfs
> f3cde2e054b00a9dbda089e3ed25c43789a01aae]
> [   42.887103]  ? __warn.cold+0x8e/0xe8
> [   42.887107]  ? btrfs_commit_transaction.cold+0x103/0x356 [btrfs
> f3cde2e054b00a9dbda089e3ed25c43789a01aae]
> [   42.887134]  ? report_bug+0xff/0x140
> [   42.887138]  ? handle_bug+0x3c/0x80
> [   42.887141]  ? exc_invalid_op+0x17/0x70
> [   42.887143]  ? asm_exc_invalid_op+0x1a/0x20
> [   42.887149]  ? btrfs_commit_transaction.cold+0x103/0x356 [btrfs
> f3cde2e054b00a9dbda089e3ed25c43789a01aae]
> [   42.887176]  ? __pfx_autoremove_wake_function+0x10/0x10
> [   42.887181]  transaction_kthread+0x159/0x1c0 [btrfs
> f3cde2e054b00a9dbda089e3ed25c43789a01aae]
> [   42.887216]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs
> f3cde2e054b00a9dbda089e3ed25c43789a01aae]
> [   42.887244]  kthread+0xd2/0x100
> [   42.887247]  ? __pfx_kthread+0x10/0x10
> [   42.887250]  ret_from_fork+0x34/0x50
> [   42.887253]  ? __pfx_kthread+0x10/0x10
> [   42.887256]  ret_from_fork_asm+0x1a/0x30
> [   42.887261]  </TASK>
> [   42.887262] ---[ end trace 0000000000000000 ]---
> [   42.887264] BTRFS info (device dm-1 state MA): dumping space info:
> [   42.887267] BTRFS info (device dm-1 state MA): space_info DATA has
> 50215018496 free, is not full
> [   42.887269] BTRFS info (device dm-1 state MA): space_info
> total=3D907277959168, used=3D857062809600, pinned=3D0, reserved=3D0, may=
_use=3D0,
> readonly=3D131072 zone_unusable=3D0
> [   42.887272] BTRFS info (device dm-1 state MA): space_info METADATA
> has -537264128 free, is full
> [   42.887274] BTRFS info (device dm-1 state MA): space_info
> total=3D77317799936, used=3D3742138368, pinned=3D0, reserved=3D0,
> may_use=3D537264128, readonly=3D73575661568 zone_unusable=3D0
> [   42.887276] BTRFS info (device dm-1 state MA): space_info SYSTEM has
> 0 free, is not full
> [   42.887278] BTRFS info (device dm-1 state MA): space_info
> total=3D33554432, used=3D114688, pinned=3D0, reserved=3D0, may_use=3D0,
> readonly=3D33439744 zone_unusable=3D0
> [   42.887280] BTRFS info (device dm-1 state MA): global_block_rsv:
> size 536870912 reserved 536870912
> [   42.887282] BTRFS info (device dm-1 state MA): trans_block_rsv: size
> 0 reserved 0
> [   42.887284] BTRFS info (device dm-1 state MA): chunk_block_rsv: size
> 0 reserved 0
> [   42.887285] BTRFS info (device dm-1 state MA): delayed_block_rsv:
> size 0 reserved 0
> [   42.887287] BTRFS info (device dm-1 state MA): delayed_refs_rsv:
> size 0 reserved 0
> [   42.887290] BTRFS: error (device dm-1 state MA) in
> cleanup_transaction:1999: errno=3D-28 No space left
> [   42.887298] BTRFS error (device dm-1 state MA): Error removing
> orphan entry, stopping orphan cleanup
> [   42.887712] BTRFS error (device dm-1 state EMA): could not do orphan
> cleanup -28
>
> $ btrfs filesystem df
> Data, single: total=3D844.97GiB, used=3D798.20GiB
> System, single: total=3D32.00MiB, used=3D112.00KiB
> Metadata, single: total=3D72.01GiB, used=3D3.48GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> $ btrfs filesystem show
> Label: none  uuid: 031d5f75-700a-4e42-b4e5-51a2f841d68c
> 	Total devices 2 FS bytes used 801.69GiB
> 	devid    1 size 915.01GiB used 915.01GiB path
> /dev/mapper/cryptroot-1
> 	devid    2 size 1.82TiB used 2.00GiB path
> /dev/mapper/cryptroot-2
>
> $ btrfs device usage
> /dev/mapper/cryptroot-1, ID: 1
>     Device size:           915.01GiB
>     Device slack:            3.50KiB
>     Data,single:           842.97GiB
>     Metadata,single:        72.01GiB
>     System,single:          32.00MiB
>     Unallocated:             1.00MiB
>
> /dev/mapper/cryptroot-2, ID: 2
>     Device size:             1.82TiB
>     Device slack:              0.00B
>     Data,single:             2.00GiB
>     Unallocated:             1.82TiB
>
>
>

