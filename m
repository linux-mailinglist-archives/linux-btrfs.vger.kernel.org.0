Return-Path: <linux-btrfs+bounces-18037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D577BF01C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 11:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8C14017C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDA92EDD41;
	Mon, 20 Oct 2025 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZYk2Mq2l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2202ED873
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951473; cv=none; b=IMej/i2dMfnTiQ95MAR1T5xYExMUiVx3EbmZiXEfSP9Nf00W+oQ7u8x0l+CBV36mNpbS0vRuiQCT4dHIk2+ZbSH5HjSYyxs1P0R37tpMh+adJsvl5znetd+Hd1vfLeS4eLz8fFPKAyF9YMcFKKD22CafDomqMRrKDjdhoRPJ1vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951473; c=relaxed/simple;
	bh=+MVn/KANdxfr+wnC5xul0Irc104ORCNZGqQXZk8i154=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RCyCevF6H1MKwIltB2i83BY74xIMk/zR7pOkeMwZKu3lmKJZa5h/400pIDBvzXu9ar6rz2mpZM9Iq/B1MzgZ6fyqcHrJGiF5Jjp2L049Sg/NACOi4Yt9Y2ST8SOOY8TByCa1LdNt84gw6K+/DXbixLivfeqk/qUGxTuFahAI0FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZYk2Mq2l; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760951467; x=1761556267; i=quwenruo.btrfs@gmx.com;
	bh=/lP/o1TfmLBQR+wZVLKSHBH/uD+HP4k6RmsS9CmebYk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZYk2Mq2lT0IsSlbVMHI9nYjeW5E8y2sKtMNwtNneDS7oBVjwlY8HsRAXR3uElE14
	 lI3b3SEn9lsuse/GcqYlhTUQz7AYXKVosXozTjsY6cqtd1ox/cO256FM7wuMkQMy6
	 cA/wlRoujqqcbHwl/AbVRd3Mh663EVlVdc4ZGvUWNbjc7mLjvIeGxylSr2qla1Ieb
	 Zv1rQWh8oWGwosCpWnvZKOZvs+3V0CikaliRxgQYwhKCbStlcL/v3LF9Y88/Rk1vA
	 kTSx3j0D8eV1nQvCtUmAhKV28mQxLEAhSqzy37mGVkojG6qe4TagRQ47bahJdi2hG
	 KNCzjCEtDt8KmWAW7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2V4P-1uCIfF2Q2R-017INB; Mon, 20
 Oct 2025 11:11:07 +0200
Message-ID: <9093d4c3-b707-4ef1-be48-36578ac1d2f3@gmx.com>
Date: Mon, 20 Oct 2025 19:41:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs/071 is unhappy on 6.18-rc2
To: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
References: <aPXjTw8WN5Jlv2ho@infradead.org>
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
In-Reply-To: <aPXjTw8WN5Jlv2ho@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:si220JJQjWTsQAok3vJ1NCbWq/gqSBmf1mt7TjgBci5bnH38KVr
 Pjt1UCTDPq049dWJtw00dUF+NLVIGUGYmWnDsopkdWRvvPxMSXEJVdI4N3t1qiuWyq5fnwW
 ukkUKoLoaTwq7/HvKWjvqxlQ9FF09e5pc2kWrg7sCpgInFWff9zd3JuG/P2uBBmTtMNgXEm
 Rvu+Ao4gOPxC3kK+54B3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HZOsDzZGFrY=;Qg+zBDFU+6T0GTeyLqCxYnA9am1
 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
 XWHX3JiWxvPWFA==



=E5=9C=A8 2025/10/20 17:52, Christoph Hellwig =E5=86=99=E9=81=93:
> I just kicked off a baseline run with the xfstests volume group and
> a SCRATCH_DEV_POOL with 5 virtual nvme devices to test a VFS change that
> affects =D1=96t a little, and it does not seem too happy.
>=20
> btrfs/071 gets into slab poisoning:
>=20
> [  279.241695] BTRFS info (device nvme1n1 state M): use zlib compression=
, level 3
> [  279.247651] Oops: general protection fault, probably for non-canonica=
l address 0x6b6b6b6b6b6b6d73:I
> [  279.250656] CPU: 1 UID: 0 PID: 82037 Comm: btrfs-cleaner Tainted: GN =
 6.18.0-rc2
> [  279.250656] Tainted: [N]=3DTEST
> [  279.250656] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
1.16.3-debian-1.16.3-2 04/01/4
> [  279.250656] RIP: 0010:btrfs_kill_all_delayed_nodes+0x145/0x1e0

Any line number/context and reproducibility?


> [  279.250656] Code: 08 48 c1 e5 03 4b 8b 5c 3d 00 48 89 df e8 23 d0 ff =
ff 48 85 db 74 0f 4a 8d 54 3c0
> [  279.250656] RSP: 0018:ffffc9000138bdc0 EFLAGS: 00010246
> [  279.250656] RAX: 6b6b6b6b6b6b6b6b

This looks like POISON_FREE, so some use-after-free bug?

If you're able to reproduce, mind to try KASAN?
As I just checked my logs, no failures on btrfs/071 recorded yet (but=20
not on upstream rc2 yet)

Thanks,
Qu

>  RBX: ffff88810dad3d58 RCX: 0000000000000000
> [  279.250656] RDX: 0000000000000001 RSI: 0000000000000286 RDI: 00000000=
ffffffff
> [  279.250656] RBP: 0000000000000008 R08: ffff88810dad3f60 R09: ffff8881=
0dad3f10
> [  279.250656] R10: 000000000000000d R11: ffff88810dad3d58 R12: ffff8881=
1bdfbc18
> [  279.250656] R13: ffffc9000138bdc8 R14: ffff88811bdfb800 R15: 00000000=
00000000
> [  279.250656] FS:  0000000000000000(0000) GS:ffff8883ef66a000(0000) knl=
GS:0000000000000000
> [  279.250656] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  279.250656] CR2: 00007fcba10194c8 CR3: 00000001217a3002 CR4: 00000000=
00772ef0
> [  279.250656] PKRU: 55555554
> [  279.250656] Call Trace:
> [  279.250656]  <TASK>
> [  279.250656]  ? __schedule+0x52c/0xb60
> [  279.250656]  btrfs_clean_one_deleted_snapshot+0x72/0x100
> [  279.250656]  cleaner_kthread+0xd3/0x150
> [  279.250656]  ? __pfx_cleaner_kthread+0x10/0x10
> [  279.250656]  kthread+0x109/0x220
> [  279.250656]  ? __pfx_kthread+0x10/0x10
> [  279.250656]  ? __pfx_kthread+0x10/0x10
> [  279.250656]  ret_from_fork+0x120/0x160
> [  279.250656]  ? __pfx_kthread+0x10/0x10
> [  279.250656]  ret_from_fork_asm+0x1a/0x30
> [  279.250656]  </TASK>
> [  279.250656] Modules linked in: kvm_intel kvm irqbypass
> [  279.277534] ---[ end trace 0000000000000000 ]---
>=20
> similar things repeat a few times, and then it loops basically forever
> doing device replacements, I waited for 30 minutes before killing it.
>=20


