Return-Path: <linux-btrfs+bounces-10959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4B3A0C35A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 22:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B4C3A2721
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6A1D515D;
	Mon, 13 Jan 2025 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gRy3r3En"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A01C5F0F
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802760; cv=none; b=q2qib5vfBsDI62iSzlzvoiRQvP4RgI1TJTeSLhqo8MK0uykQ2Ly4yqCMQ+g+tm3Kkvg9l7dTJWKuSkFV1ltyA5SCHpeoPIVLXY5lMIYOtzO11lNY6WgBOan9XE8YixK4f4rMygk5psN//w7i8FMNo2aCgILYwTwBx6F4nJhliaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802760; c=relaxed/simple;
	bh=1S9qKu3DXa8n4xu7SArNLbHDZCsETSxOQ186CGe9YDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JDlZj8vMd/u2vY7xsxn22x52J/kSnrTGqGc6R5Qi/rhvC54cQRc/0DqhN3rjQgZJzWuRznn1wm4ctrdBhDBoF5C65L+Dmm4UX2UwRuWs4OR8rqvzRtGCJOBzmUVhpYAnFBRbt3tDBu3iDyk4vPdBZ1Ay7Nnt3DmTjWy4R6vLYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gRy3r3En; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736802751; x=1737407551; i=quwenruo.btrfs@gmx.com;
	bh=the4ZmvSL3efr+y/z3nRgPLqT0NLnJJkuDQ2fhZ/OmM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gRy3r3EnuhPTQcsHHgS25hFdYXFT7yOVsUUJdg80U+klRA5CEjNWlZC5TsL551oL
	 MqVbwrf9+KyV07CMWjkmS9e3ZHlodnb/9d5WahnsoNUxOrfbuO7m577Ey9NYLTffm
	 wKsslamF177kxkc8Lj/54ds3AmuPVOhX73DPVBGEFImLMlBdmmIvIGkrbIrvUz/cs
	 g+FZWw4hQnvA8a7GiD1BxJfN9Tai5SdtB75IoudehNNdIdWnwYjvOtifp32ukNEiC
	 mh6OW3bGtGGx0cP2vBpCYApyVbJ/J3KiDNZDAUhz6Hc94/ywp+el1pwnHkoKRAU4B
	 IyekA/L0HneN55Ht0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKKX-1tmd4Z1UiX-002iGT; Mon, 13
 Jan 2025 22:12:30 +0100
Message-ID: <ef836984-61a0-4a09-95d5-901d499aec4a@gmx.com>
Date: Tue, 14 Jan 2025 07:42:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix assertion failure when splitting ordered
 extent after transaction abort
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <efe1ae546864e0f22b4e29794115e3cedb602c30.1736782338.git.fdmanana@suse.com>
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
In-Reply-To: <efe1ae546864e0f22b4e29794115e3cedb602c30.1736782338.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TkZv31rSK3bwUUCoz8bRZ6afpbBTFIN22QOBGwG0zDuJg6diTWI
 iNUaRNlbKSRnIl67F5S1jNLXom29QOMWA3JUIEofOfmXvL/Y4sUAti762i6HZ9ImSQUewiE
 QD1BnSgGt0nx8R6iQC1jvnnO/ddwBbvDocPvXUgA+tg39K2xHMDJqlzfhEw5T8RbWQq2J4h
 HJ2UPAft89c5TjFzR2MVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tCWSyfPBXqI=;AGkj93NzcTkUfUOTurOYKWL4pwG
 d8sJbkZnMujdJNrsotlbhw/QGl7/iB5YsIWLemdvIJwjxHAFopaxLe3zPPk6jwY6JMMXCV7EX
 yCeqlqkF98IZybPLpTz+I2eRVhNEswQ/rJUCymhiuLeB8lKxvUH6+vj4UJdW3ikTRvhb3ioPU
 3HiZ+BbDUFmS66YjOkTQnK0AmxxoxudJIx3UNIZu9fCFSCcrJeBlRN3JjLgj5XjKoCHv7LHDQ
 HrJGj55HU6qmGxW2JHEuBGmbeQBVA/iHXRT8WDQhRoarhq43uZgny6pcCDTRV1GxCzORZDGVA
 bubdLjX8fPupX6zvlP/v5PPStbhmdrJBEv5wQDZLdcP8FVqGmMULQX1LRbAbhLawH1AglQKdq
 LctvHhdggsnqg9Anvj6E40CuCcwZ+PqWjIlYpvC/YTDB5z/3kIOwft9P2WRrxeGpm+yudV36j
 xDLJXtmvIItJVoFtVytuSGyRvSHNodLs5I/ktLYPRgjOIU/Aj60npFx/RYha2D0JeSkYcr2Ml
 LplXkSNzUfZ0CTXgX8AfpedqArd9IF43JJrgE8qNTkaZj+YneVQFOy2Wj0tC3nTH2fmVVkWxV
 MNCmqvrBztem6lAhemm17TM2ykKfPu0NGGHHLi0dn2eTtnwBOyCAl9cvpgP7ygOY923Ay84Wk
 vAAwL7BP8lsJobtwaMIXQbdb3zSe2MLHcSBpKhedsOyHcyZLuiWH5CVhWioQ9GDSFTTODZOLm
 pdBb9KhJHKTb9B7tBwxKKMK4y8saN+sl5yh9v5UCFIF8/olVbKABiV3Bmvva1LGn8OpNFtvd9
 KRnndT6Eezro10bYeC/yukeue0svtYlw544QYLI97ax87E8DnnDsqqS2/YYmBH9IwP+8/eVa5
 QuFjnYEJtsgSIpFk3/J51uvfa5Q4jWN4QB2k/3G+xNoY55UMsFQSPO8eSrXbV8R67O9Qc60G4
 8GxuqjMg2FEzlQD9j/5zZt4n4yiipT54groHgnNNo6Pkv+vMBWFsJSjuJp2tYa59qTpMCE6KK
 /UCYXOAqnvWcnkOKu87B4r4pMFq9kLEJLPT5V2ATMR9pQwLXSTG9nnA/0hvmiuY/cA94k5vad
 Zu8pkjGz0f9yZadU1/SRDLDHYfrkVL



=E5=9C=A8 2025/1/14 02:02, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> If while we are doing a direct IO write a transaction abort happens, we
> mark all existing ordered extents with the BTRFS_ORDERED_IOERR flag (don=
e
> at btrfs_destroy_ordered_extents()), and then after that if we enter
> btrfs_split_ordered_extent() and the ordered extent has bytes left
> (meaning we have a bio that doesn't cover the whole ordered extent, see
> details at btrfs_extract_ordered_extent()), we will fail on the followin=
g
> assertion at btrfs_split_ordered_extent():
>
>     ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));
>
> because the BTRFS_ORDERED_IOERR flag is set and the definition of
> BTRFS_ORDERED_TYPE_FLAGS is just the union of all flags that identify th=
e
> type of write (regular, nocow, prealloc, compressed, direct IO, encoded)=
.
>
> Fix this by returning an error from btrfs_extract_ordered_extent() if we
> find the BTRFS_ORDERED_IOERR flag in the ordered extent. The error will
> be the error that resulted in the transaction abort or -EIO if no
> transaction abort happened.
>
> This was recently reported by syzbot with the following trace:
>
>     FAULT_INJECTION: forcing a failure.
>     name failslab, interval 1, probability 0, space 0, times 1
>     CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkall=
er #0
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debi=
an-1.16.3-2~bpo12+1 04/01/2014
>     Call Trace:
>      <TASK>
>      __dump_stack lib/dump_stack.c:94 [inline]
>      dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>      fail_dump lib/fault-inject.c:53 [inline]
>      should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:154
>      should_failslab+0xac/0x100 mm/failslab.c:46
>      slab_pre_alloc_hook mm/slub.c:4072 [inline]
>      slab_alloc_node mm/slub.c:4148 [inline]
>      __do_kmalloc_node mm/slub.c:4297 [inline]
>      __kmalloc_noprof+0xdd/0x4c0 mm/slub.c:4310
>      kmalloc_noprof include/linux/slab.h:905 [inline]
>      kzalloc_noprof include/linux/slab.h:1037 [inline]
>      btrfs_chunk_alloc_add_chunk_item+0x244/0x1100 fs/btrfs/volumes.c:57=
42
>      reserve_chunk_space+0x1ca/0x2c0 fs/btrfs/block-group.c:4292
>      check_system_chunk fs/btrfs/block-group.c:4319 [inline]
>      do_chunk_alloc fs/btrfs/block-group.c:3891 [inline]
>      btrfs_chunk_alloc+0x77b/0xf80 fs/btrfs/block-group.c:4187
>      find_free_extent_update_loop fs/btrfs/extent-tree.c:4166 [inline]
>      find_free_extent+0x42d1/0x5810 fs/btrfs/extent-tree.c:4579
>      btrfs_reserve_extent+0x422/0x810 fs/btrfs/extent-tree.c:4672
>      btrfs_new_extent_direct fs/btrfs/direct-io.c:186 [inline]
>      btrfs_get_blocks_direct_write+0x706/0xfa0 fs/btrfs/direct-io.c:321
>      btrfs_dio_iomap_begin+0xbb7/0x1180 fs/btrfs/direct-io.c:525
>      iomap_iter+0x697/0xf60 fs/iomap/iter.c:90
>      __iomap_dio_rw+0xeb9/0x25b0 fs/iomap/direct-io.c:702
>      btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
>      btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
>      btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
>      do_iter_readv_writev+0x600/0x880
>      vfs_writev+0x376/0xba0 fs/read_write.c:1050
>      do_pwritev fs/read_write.c:1146 [inline]
>      __do_sys_pwritev2 fs/read_write.c:1204 [inline]
>      __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     RIP: 0033:0x7f1281f85d29
>     Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48=
 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>     RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 00000000000001=
48
>     RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d29
>     RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
>     RBP: 00007f12819fe090 R08: 0000000000000000 R09: 0000000000000003
>     R10: 0000000000007000 R11: 0000000000000246 R12: 0000000000000002
>     R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e23328
>      </TASK>
>     BTRFS error (device loop0 state A): Transaction aborted (error -12)
>     BTRFS: error (device loop0 state A) in btrfs_chunk_alloc_add_chunk_i=
tem:5745: errno=3D-12 Out of memory
>     BTRFS info (device loop0 state EA): forced readonly
>     assertion failed: !(flags & ~BTRFS_ORDERED_TYPE_FLAGS), in fs/btrfs/=
ordered-data.c:1234
>     ------------[ cut here ]------------
>     kernel BUG at fs/btrfs/ordered-data.c:1234!
>     Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
>     CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkall=
er #0
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debi=
an-1.16.3-2~bpo12+1 04/01/2014
>     RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordered-da=
ta.c:1234
>     Code: 43 fd 90 0f 0b e8 43 c4 db fd 48 c7 c7 20 0c 4c 8c 48 c7 c6 80=
 0f 4c 8c 48 c7 c2 e0 0b 4c 8c b9 d2 04 00 00 e8 04 57 43 fd 90 <0f> 0b e8=
 1c c4 db fd eb 5b e8 15 c4 db fd 48 c7 c7 20 0c 4c 8c 48
>     RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
>     RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c4195300
>     RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
>     RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf4
>     R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f401
>     R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a000
>     FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:00000000=
00000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>      <TASK>
>      btrfs_extract_ordered_extent fs/btrfs/direct-io.c:702 [inline]
>      btrfs_dio_submit_io+0x4be/0x6d0 fs/btrfs/direct-io.c:737
>      iomap_dio_submit_bio fs/iomap/direct-io.c:85 [inline]
>      iomap_dio_bio_iter+0x1022/0x1740 fs/iomap/direct-io.c:447
>      __iomap_dio_rw+0x13b7/0x25b0 fs/iomap/direct-io.c:703
>      btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
>      btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
>      btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
>      do_iter_readv_writev+0x600/0x880
>      vfs_writev+0x376/0xba0 fs/read_write.c:1050
>      do_pwritev fs/read_write.c:1146 [inline]
>      __do_sys_pwritev2 fs/read_write.c:1204 [inline]
>      __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     RIP: 0033:0x7f1281f85d29
>     Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48=
 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>     RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 00000000000001=
48
>     RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d29
>     RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
>     RBP: 00007f12819fe090 R08: 0000000000000000 R09: 0000000000000003
>     R10: 0000000000007000 R11: 0000000000000246 R12: 0000000000000002
>     R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e23328
>      </TASK>
>     Modules linked in:
>     ---[ end trace 0000000000000000 ]---
>     RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordered-da=
ta.c:1234
>     Code: 43 fd 90 0f 0b e8 43 c4 db fd 48 c7 c7 20 0c 4c 8c 48 c7 c6 80=
 0f 4c 8c 48 c7 c2 e0 0b 4c 8c b9 d2 04 00 00 e8 04 57 43 fd 90 <0f> 0b e8=
 1c c4 db fd eb 5b e8 15 c4 db fd 48 c7 c7 20 0c 4c 8c 48
>     RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
>     RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c4195300
>     RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
>     RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf4
>     R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f401
>     R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a000
>     FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:00000000=
00000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
> In this case the transaction abort was due to (an injected) memory
> allocation failure when attempting to allocate a new chunk.
>
> Reported-by: syzbot+f60d8337a5c8e8d92a77@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/6777f2dd.050a0220.178762.0045.=
GAE@google.com/
> Fixes: 52b1fdca23ac ("btrfs: handle completed ordered extents in btrfs_s=
plit_ordered_extent")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ordered-data.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 30eceaf829a7..3cf95a801086 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -1229,6 +1229,18 @@ struct btrfs_ordered_extent *btrfs_split_ordered_=
extent(
>   	 */
>   	if (WARN_ON_ONCE(len >=3D ordered->num_bytes))
>   		return ERR_PTR(-EINVAL);
> +	/*
> +	 * If our ordered extent had an error there's no point in continuing.
> +	 * The error may have come from a transaction abort done either by thi=
s
> +	 * task or some other concurrent task, and the transaction abort path
> +	 * iterates over all existing ordered extents and sets the flag
> +	 * BTRFS_ORDERED_IOERR on them.
> +	 */
> +	if (unlikely(flags & BTRFS_ORDERED_IOERR)) {
> +		const int fs_error =3D BTRFS_FS_ERROR(fs_info);
> +
> +		return fs_error ? ERR_PTR(fs_error) : ERR_PTR(-EIO);
> +	}
>   	/* We cannot split partially completed ordered extents. */
>   	if (ordered->bytes_left) {
>   		ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));


