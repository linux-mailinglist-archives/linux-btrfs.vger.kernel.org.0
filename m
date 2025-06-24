Return-Path: <linux-btrfs+bounces-14929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC07AE70B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 22:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69024165EC2
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 20:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C02EBB8A;
	Tue, 24 Jun 2025 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qzoYe8VZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2F2E92D0;
	Tue, 24 Jun 2025 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750797027; cv=none; b=ZrHHdITYJwOAUjONJjymHPy5lWDVSBAH1Ch7pe5EUF+IDsHuQ9Mqb2YkezW2Yh0VLAsJoAZKxjo0WfERf9DnvwgeXncz/eKnafnat2BOsuqu6YKVlIyo4qWznhVELs7iRh51eSv8b4FcGvkcqOckEdemuXFbaAKFiufiFeWg89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750797027; c=relaxed/simple;
	bh=PyNejFBO4DO2StpTrXnd2cn7yIq8+Cs7i/ymNy4BnNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/IpNsE3ZlSPme77iyE4/D29y8kP6/abtAtIxce4YRyFuWKUlesgUAsqK4sVY6pqxLFZWr+Vq9Wt7VCbA8I6vDVpV/2MaA8njGeTeJqldcWJ4GYiyiej2r9ghxN0UR3Z1c3kvEnzFGfR206DSpeLmV0WWJdphj2BaGhB8Y1eUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qzoYe8VZ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750797016; x=1751401816; i=quwenruo.btrfs@gmx.com;
	bh=7ppGo3zQCLbcHl1LQFYeIQe1GzDLPuBEsBI4oBFVCoE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qzoYe8VZ53h8fh6JakZqK6x9ECs5Y3/qYUqSFHHEvZ2cwFKlcz6l+2/jG2Sb2LGN
	 T5NcLFYmINdQMVp5/nBm4GK9IzRK09xOTXtxGtgIntWyaaavi1GlM6KsumWyeZuHX
	 NhbNE8pIsBPlhDTb36ZVH581FjwMi/27laFspG9qpzgSAbawN/ED7QnBO+U0hpnxG
	 LFA0uJbGhw1pW/POX0b38EQ3j0phHc8IYJ0wH2JvEc55ePhydItMcvaMcw73nozIR
	 VljjLyC1o9thRex55EAiqkM/ktNd4waGy65B8utZ8QvZfptwIKtQ/SzWtjs01fqxn
	 5qwq0YRpFCkBNaAdLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1umFOa0mnf-010XM6; Tue, 24
 Jun 2025 22:30:16 +0200
Message-ID: <2e81c9bf-64ea-4d6b-a771-1befd4c319c8@gmx.com>
Date: Wed, 25 Jun 2025 06:00:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] btrfs: fix deadlock in btrfs_read_chunk_tree
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, wqu@suse.com
References: <685aa401.050a0220.2303ee.0009.GAE@google.com>
 <tencent_C857B761776286CB137A836B096C03A34405@qq.com>
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
In-Reply-To: <tencent_C857B761776286CB137A836B096C03A34405@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nft31E/Dvu8u2s8Mb0y80JLUtB2Rc7+ngFWFR1R/cdI6YOEIVoI
 RERtNzL9FlyRNUkJQfaNM5T8XS8dFSWRy/fPeKdAVoZWzM9SeaFlMP+0poV+59jjghi+dWk
 py3t+KPWinbfA+MX1x+rA4Z3NdunttteGDBMnxmDNoNWBSp70bv+gkx+EsiDBzXP6ISsMeV
 0AxbQtAH7gjSlFURRVjeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:khRzlRoIn6k=;Mi4hfelf3kv27v1QO8fGhuWTSXS
 Q/CNS+ZRarIGtsRuHgh2o4oLjNpg20lL5/Ik/qeEuc25mJoZQZQ052lTY8MtpEMpPr0tPclqh
 8Pr/7q1jmyv+xtPYnDA8Yvgbvgkh3lEZf5ThheB0hagsS2k8coXW3fVNX1z9eyT50PwaqSuf4
 cUihAXlK3eQwZd4ZLh8WF9V8wGAZgg2Ob+hgIed58vRAGXd9yt30xYqG8zSBqFqJloh7jzyMs
 SRPrmNRqe4RvJIalsSNz90dawFBsIZYicYilxu+vpDvZdt9NQFVAtxLYRXhF6xx7fnKj4WHAH
 LUK7JR1/JSRcCcXtIcKpTppenvg+klXaYmHBIxG1cyV2HVzs7BrKTRysGNR/q/tJqzCyABNkY
 dC2zVSuSN7+SRnFklETutbUR+TEiucYILMZ6rMpaYDMjXRqwSm2F5ZyMc74QqMC4XO//PhyNn
 Xl9Lo6Fsz8+/i2btEkzv8BAJhEgShU9+YQ/YlX+TWJQX7bbf+nolk5QVcJ8bB0TXpHXkr5Fka
 qZcoFPXALuz7NP8y4fOxFxbkNJKG2Lw4TdKzkNWkgkvVMyjgBPxZt6i2XCHgAfUf4wvGJXa+F
 uJcyyAAoP+FgKw5BvHv2FdXYkPKyV8Ga4zYEUFHkQv3HG5d3SQsYCErJ4jT0owSx5PWQ2Nvea
 iDMiaAWbWrmrpVm5c3oaBZ0BWVf6vZVXHK6PAW89FluJAAYmQ+UaYEgz7DrODDQXu6xO8nb7A
 ofNQgnbmvShRPzi3FIeWO4VI4PB4FwuFnj8TzfxDEpQuWVmGgVcr/zSVs0I0xZKruCota1hkg
 GSwJY+DB3BrHrMgWZQShWxlegyCNTdbjieNZeswBuak0n2KlM+IXBI+MmPc7t22+t0ojksD31
 b+h4OiW0dOMjtlfqr6UI1wrD/Hc8J1fbKwbQEmrILAasy8bEp6BJUBFCRuSLicghnx25U3Y+z
 x+UT56lQY0BWRPy5go8EJFUeGE82XcSyu4ITCikMEoulNB961A3shapFmNWOtl12s1FdcPsQ6
 itFxMEBtiQgM6CscHRdnziFuw//ZdMhGgEyAPtA9xh8eV2RfRBjnd/BX9FBGzYz4cVGVmq++b
 KfxdxelrChVyNd50dliN34fe8P2gS7pKc7EFvXsVXMfg1SnX6GYz62m1ff3B8ais9eUUivX6O
 tLBNEOq4k849JLQuJHits2qiZ6bgDEU+TpbT6DCFHjA3GGzhQVitV9xs/HO8wnoIQH5eSLXHv
 5Cj4bgaBop+pidiVkJfFn+resFBfJEWq/siur4ntPztN5XxrPFLyy2mbBTfJcaZn/edDZpi2Y
 swjBjJSDDwmlRJUuA3VZhLyOj030eBCnlGxlreOsP3hZAVFrvKsVecS78I6eXNy+UsiuEluT/
 r1xWf3g6SfCJoAvGcLeNrCo6vRYiCJ/zTIj0Ah5RYNRf561m0rxLxFBqqwc9Qpyf3MRXPP6m4
 L9C+YnEXY5pL7g3Fs21nv0lo2++ZmY0qBbofI59oySZ3SF50pWxyA4NnNRH1xgTwm6jBAIN1z
 H+Gii+ns77rmQOKtmSG/CxQ7v4ltFpts2/1GgIOLqvGiUk4vxfDd+5NOm00OW0rxHS6wZ+WDC
 3ktBoxpz+o/5XtbSJin/mH3Orp5oA5V8erFoD0C29/EzoUTWmuehaCsOp5hWbZhqDLOC7hUdB
 X+bOdmRrgkvNnyTNnOqm31ByVyteWNRt5+xKNqKOqN6XHgxwKyp7PruebXA0NGc/l0E9GDUel
 QsRUkuDQAbUN1pzK1Hk/3Q9DJ9y09kgUnNMXKdSbsfk56XcdREFxpJYIL9jX+ugddsofHtdKx
 yVfFwBHXtV1XSZ4tTfo0aWRxjACgt9Zw1rmUpuK9Ec61jytrp2RMO9mSiTE4JMu/a4sY73FyN
 RSV/WuusGeVrWnurbPFlmNIgmHTH87Dw1woEGDLlP6edYn/fq09R66GK80svLyUxcs6e/+NIH
 OEFVwmMB+UBkRSXwTFhbVDFJV+raQFh/XANTmVHK0W2zELdx7+UHlCA9IWZTfQeNN5x4X6xBV
 2Evw68/GYWbXBUhyMdws7Do2b9Mi1TKgQK4t/5Aqvu8LYZXb2cefHjADCi2ur7yqa6hGNcrI/
 1KIm8pdVdIypXO8OwiaAPnEm4krmNas7pqvGaw5rjlR7G5nUKFyt7YFICKhNcUYeeuEr4NcLY
 lKWll6szCFpeQXJywL0cY1B4hTWptYDOASz7+IPz+BOidghTOy/fD7hcUukvd5rIGzbFL1HSa
 W5SI8lZC5Srdabn4T7AVXjgkwGc50A8wi/RdDHx37V+8eZRXQKoJhSfOJ+csdKSTOcZ0OrSPy
 l0GQRGmocZXiUzd5iWhBEzVZQzpXD4ESjqmK//j584q2lpOt+sCdSpWC1Y83Gbexiv/S0kr9w
 9JLX/OWrwaPSexHV8o4VVV/CHl6bU9DdKF4BuIPzVEcrA5kWIK1ubrdB2ruRFEqy5NRAcErXZ
 GoXIK1e6GIQvdaV6J60Zmbtopfr5nN1qFAyIO2FVGkYjXTSQEfvh+qU0ndGLTjQM0Umc58mSi
 Ziphu0Mp83yyAxGKwIDSMx012uxFA4wEQ02Ydo2RrtsyMKAtmki1L8tdGjzxsJ5b/NYV1hNA3
 xGEgwr8xBOYNICpPaG5S+hAdvv3WxLdtlEVC1zw5rv1UwLV1iJndrz/SpvBAzrbXx3EtKxG4u
 hLDoj0xcGuX9aAAcBc2GVY1L2GQYU976SYzsbH3vqeduNVOLGEFT+BDq1shuc7NN59ML7TW13
 kmxyejACWMFBWpovrURGf9z3HQLv5W/u8hkWu4zHYgeEPT8g72HFRomGBDVo11imgYQsg+O5O
 rJIPVvCgqbJdPXGpzL5teZGcgunbgVwmcooRXpXWuV+8Ab7is6vCINibnWZHzXqCd45yWvIcB
 JOV7K7XZn6nkUOYnGZRUsQQdp9zCpv6gyfwGCp+ctnNn0FKMXWFE59i1I8g7lzBId82mhXPKS
 YNRDZvkd9LvimZJERql+/QVRiD07uXXegiJR1OokP00SngsgvOvr21nFu9frsWgO+OuQsYnIo
 Z79BWWdG0zNHnzrzjBw9s7h5qb4CJvS6pD7bAqlERlh5pxADbOuF9isOlgu1vefynuaE6J6+q
 kK7exyBetAvsUUiQTb/x1NQ/VdJB3cwBVZ2h4kNUbYaXrMOpMWRCAy9ea91HUbSzU8i3LHoIi
 EzGmBxOVwYNDGmFl21ir74JkVmOXB9O32ObMnaEUWeWmL3wV6RGBAY7kJo42y3sfpOFNK9QG8
 GA89vJiQElGrz2HPrCFSyVUkfPcw1BLi51PRjGy6YtPP2snu2ecTMiXldj8bjIW+Hk6Jlmadp
 GmH5WhOuQzoOeruT7QOOXcLiUChFFuVCpakzlwmHRWphSsEQJzCaV3mdLoIdtQWx/r41w9C0K
 rbLyDT7kaopDa1/+gX77rsWC3LDRtw2GzyQjt5AtozHp2jWIss2DfvwGM+w6gNKtDcBKsp8bo
 ntBWb51Jrq1+sJ3R9wUQfarq8wbScJnZDMex2oKvzV6qbLpz9bMTw



=E5=9C=A8 2025/6/25 00:00, Edward Adam Davis =E5=86=99=E9=81=93:
> Remove the lock uuid_mutex outside of sget_fc() to avoid the deadlock
> reported by [1].
>=20
> [1]
> -> #1 (&type->s_umount_key#41/1){+.+.}-{4:4}:
>         lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>         down_write_nested+0x9d/0x200 kernel/locking/rwsem.c:1693
>         alloc_super+0x204/0x970 fs/super.c:345
>         sget_fc+0x329/0xa40 fs/super.c:761
>         btrfs_get_tree_super fs/btrfs/super.c:1867 [inline]
>         btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
>         btrfs_get_tree+0x4c6/0x12d0 fs/btrfs/super.c:2093
>         vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
>         do_new_mount+0x24a/0xa40 fs/namespace.c:3902
>         do_mount fs/namespace.c:4239 [inline]
>         __do_sys_mount fs/namespace.c:4450 [inline]
>         __se_sys_mount+0x317/0x410 fs/namespace.c:4427
>         do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>         do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> -> #0 (uuid_mutex){+.+.}-{4:4}:
>         check_prev_add kernel/locking/lockdep.c:3168 [inline]
>         check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>         validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
>         __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
>         lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>         __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>         __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
>         btrfs_read_chunk_tree+0xef/0x2170 fs/btrfs/volumes.c:7462
>         open_ctree+0x17f2/0x3a10 fs/btrfs/disk-io.c:3458
>         btrfs_fill_super fs/btrfs/super.c:984 [inline]
>         btrfs_get_tree_super fs/btrfs/super.c:1922 [inline]
>         btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
>         btrfs_get_tree+0xc6f/0x12d0 fs/btrfs/super.c:2093
>         vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
>         do_new_mount+0x24a/0xa40 fs/namespace.c:3902
>         do_mount fs/namespace.c:4239 [inline]
>         __do_sys_mount fs/namespace.c:4450 [inline]
>         __se_sys_mount+0x317/0x410 fs/namespace.c:4427
>         do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>         do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> other info that might help us debug this:
>=20
>   Possible unsafe locking scenario:
>=20
>         CPU0                    CPU1
>         ----                    ----
>    lock(&type->s_umount_key#41/1);
>                                 lock(uuid_mutex);
>                                 lock(&type->s_umount_key#41/1);
>    lock(uuid_mutex);
>=20
>   *** DEADLOCK ***
>=20
> Fixes: 7aacdf6feed1 ("btrfs: delay btrfs_open_devices() until super bloc=
k is created")
> Reported-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfa90fcaa28f5cd4b1fc1
> Tested-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/btrfs/super.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 237e60b53192..c2ce1eb53ad7 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1864,11 +1864,10 @@ static int btrfs_get_tree_super(struct fs_contex=
t *fc)
>   	fs_devices =3D device->fs_devices;
>   	fs_info->fs_devices =3D fs_devices;
>  =20
> +	mutex_unlock(&uuid_mutex);

No, you can not unlock uuid_mutex without opening the devices.

Just run the test case generic/604.

>   	sb =3D sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
> -	if (IS_ERR(sb)) {
> -		mutex_unlock(&uuid_mutex);
> +	if (IS_ERR(sb))
>   		return PTR_ERR(sb);
> -	}
>  =20
>   	set_device_specific_options(fs_info);
>  =20
> @@ -1887,6 +1886,7 @@ static int btrfs_get_tree_super(struct fs_context =
*fc)
>   		 * But the fs_info->fs_devices is not opened, we should not let
>   		 * btrfs_free_fs_context() to close them.
>   		 */
> +		mutex_lock(&uuid_mutex);
>   		fs_info->fs_devices =3D NULL;
>   		mutex_unlock(&uuid_mutex);
>  =20
> @@ -1906,6 +1906,7 @@ static int btrfs_get_tree_super(struct fs_context =
*fc)
>   		 */
>   		ASSERT(fc->s_fs_info =3D=3D NULL);
>  =20
> +		mutex_lock(&uuid_mutex);
>   		ret =3D btrfs_open_devices(fs_devices, mode, sb);
>   		mutex_unlock(&uuid_mutex);
>   		if (ret < 0) {



