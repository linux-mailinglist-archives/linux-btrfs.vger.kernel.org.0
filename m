Return-Path: <linux-btrfs+bounces-10975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A9A12DD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 22:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59E216617B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 21:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DCA1DB13B;
	Wed, 15 Jan 2025 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="c8uKdm4d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C6156F57
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2025 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977082; cv=none; b=dvQW3BOnv/TFo2DNRMmeke5Nf7uieBKLE6kiHYbn7lLgofznjChJDOajW7RAk6uAOlIkSzCHZH4RNx5Rc3Gy9OhJXnM4h9ujODaInRBMGrmPe+EvpQvGF6K4Gm/yvcl79DGV7TboIzbJIbGN4bX3suc+9dX5Z9te7yqGbL6PmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977082; c=relaxed/simple;
	bh=lP/CHVU36iv8h1ihJB/Hs5Q7FpJ5xbencNYzXcBenDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyIxhfDNMJJ+5BCR7DKDKJUPsRyIafMF5HF5Km0KiGWetgbS/n2LkLe14SqntFajU///CGln4UDL8LvjgHKCcKByn3TC6mOT0uhPBjPo0Rt06o4w89Q/a+PFUGmGCv6qrzKw36PFW9OVpuYmIvJ/qsLHwCltW+c5HXMJAdfVjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=c8uKdm4d; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736977072; x=1737581872; i=quwenruo.btrfs@gmx.com;
	bh=1v/+jEvFxaXSVDGgP+q4ma8slm5P01VPBORaaYSH4RQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c8uKdm4d7GIqMozo4PlQmOlB/Fp/BAxYs3qn41KxxERm4EN6hMYxgbXif2rJlS3y
	 laJ8LdAUE/v5iFI+d7Ebq8KYrd/A2KmuVIBWG9RQOEqE2MeDa6JIDOsU4IVNBIB6e
	 9Oo1+rQ81ThlhKsnjMXnhu19RXoUBkK55Oq0WXgEt91MgXgu8eP/hctfacE7wMGf2
	 fAjZqMJf7xdiEBReVM7272dbVgGgm2JEmWHDkHAFIfkToYwAhp/7QMhwWuXUXqPvl
	 /0V2qvqW5JGzap4ij9vxhaoh4afg7SMhbaI+/ImOV1HaJmj825EO0JtcQyOIKyMIF
	 LKyhJJEeFAEbVu+0Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ml6qC-1t6mH52Pt6-00kd3d; Wed, 15
 Jan 2025 22:37:52 +0100
Message-ID: <29d889d3-3625-4178-a605-1e54efe1e3b0@gmx.com>
Date: Thu, 16 Jan 2025 08:07:49 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix assertion failure when splitting ordered
 extent after transaction abort
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <efe1ae546864e0f22b4e29794115e3cedb602c30.1736782338.git.fdmanana@suse.com>
 <ef836984-61a0-4a09-95d5-901d499aec4a@gmx.com>
 <CAL3q7H7ctFOu-naGsfxREKuN7664fXUK=Rd_V_RFk70tXJhcFA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7ctFOu-naGsfxREKuN7664fXUK=Rd_V_RFk70tXJhcFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:98p2iH4HLiccQbtx/7SFzRuAu8lnYYpOJve8Ctdu+XfxmfX0MWB
 mVX8sPwbUeUZO89YRP9wl3tGeSNOwqyLBPHVuhgNx8AfjTp51PMtyPgO4dyNXhMna1FrL8b
 PSSWMGaqBzkBuLXuqgAWpwXURg/DxSQX7JT64osUfxlWrdbUpex45SkAS5Cfcn5TjXK7GMx
 NwcC9HN1r47ltyup/HLoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nxUKBZUdIGM=;SThgtx1NzY+3osZz0Mpdxn7TxZn
 kf80lTKz04jobOfpbXo3XdZdZdGmbs91YbSBFKJpIuUUVUR2L4nAPegTwSNFgmlRZeEcS4CJ7
 b6RN9n4dLswbeRh3CyNMvgPWAd1diVmDWv6mfJcNNx53KACnT5/M9/ufoFuKG1pHHA0LkppnL
 1RTr5DYOm3+3KQqk9TdXOlk3KRP6+dqhbtdf/8cRhMgQByJCtwDuyutWK7Q8N5tBUNXvAIe2R
 iLgkz95PjzP1eoorCOE+ylF1gjJlwnB8hIveslLTjJbsj6eMgYhLuFF4e40khU1jfzq660kSd
 8XZVz6hdOdxuutxh9nUsNGakTXXECNCxMiSYod0d6Ea8PpbDoX7Hjgnm9XSvdvYspdhI1kuef
 ffaye3sskPp8ubsxOA9/6TAQimN6UtW0AkLzIHAgAVLAIDwJ3kMS/k07gDU7o7XgA7ggXUGyK
 TWMT5qBIGLN7L6iM1LISuNnqnndClPfYzE6K0+3ZeebREYBzEyUk4Fe7ukITa6aOB5yGRpbjC
 BP0xPQHPiIipe0xPe87vDO/WG1STdD0ju+fojMxdXx33iZIsB/Zjb48Rpg1M3516m6APEVbMS
 u2DDpeVR7RuxnYFj45OvHldPRONZs3bVN/290CLagzo66QqoyzBOMO+d9axEKlDRkdkn1NInm
 w0wJAGpmsOxUNyGeS72MY2neRdv2s4ZtxIBHJh5jcwaYlx2flzqQFRfy78ht/RIScJo+ywTZf
 Q2thzVmtVMFlLdZb1W3NecqdgiKdkT7Ty1+Il5JB9MwaA4t9UHJopBlqu1k4ea1z0HKaBOm7B
 DiF68ZIRdG6URSaZPf9fhOiiA5baQGJUoJzGkuszods9LGUwNU6XeL8NEAAGQqB6fN7n33JTA
 EMs/DFWTwbHrzB7SB/Uft4PHuqLWus6CnQVFowInKmqSBrwYj14CqYDq+KmC6F9c8WMvT35/h
 JfUWS9X/ojzayt4FIRcUqI+1hTACkrdB0ehGZsZkYGc9nEXzikAUx8G7yd8XVIJ2AP4olXYn9
 O+11to3veeRJwp1HlCX8FkV/wtLlLy6Bz5LBkD8oD7qKftH4Lu2xQ+nEQK3zAEfjC6VuTD4wN
 WqhmGmYH1j/IzEbVxDeK1SvalL3MQ0f5oDeEz4JUa0qU0OmWQ8IwNREaVTVYbzSP5jODewjgF
 TzsReforG1nI7TDDLqwvAow1M6gy9/rjkH3fghNEI7g==



=E5=9C=A8 2025/1/15 05:22, Filipe Manana =E5=86=99=E9=81=93:
> On Mon, Jan 13, 2025 at 9:12=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/1/14 02:02, fdmanana@kernel.org =E5=86=99=E9=81=93:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> If while we are doing a direct IO write a transaction abort happens, w=
e
>>> mark all existing ordered extents with the BTRFS_ORDERED_IOERR flag (d=
one
>>> at btrfs_destroy_ordered_extents()), and then after that if we enter
>>> btrfs_split_ordered_extent() and the ordered extent has bytes left
>>> (meaning we have a bio that doesn't cover the whole ordered extent, se=
e
>>> details at btrfs_extract_ordered_extent()), we will fail on the follow=
ing
>>> assertion at btrfs_split_ordered_extent():
>>>
>>>      ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));
>>>
>>> because the BTRFS_ORDERED_IOERR flag is set and the definition of
>>> BTRFS_ORDERED_TYPE_FLAGS is just the union of all flags that identify =
the
>>> type of write (regular, nocow, prealloc, compressed, direct IO, encode=
d).
>>>
>>> Fix this by returning an error from btrfs_extract_ordered_extent() if =
we
>>> find the BTRFS_ORDERED_IOERR flag in the ordered extent. The error wil=
l
>>> be the error that resulted in the transaction abort or -EIO if no
>>> transaction abort happened.
>>>
>>> This was recently reported by syzbot with the following trace:
>>>
>>>      FAULT_INJECTION: forcing a failure.
>>>      name failslab, interval 1, probability 0, space 0, times 1
>>>      CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzk=
aller #0
>>>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-d=
ebian-1.16.3-2~bpo12+1 04/01/2014
>>>      Call Trace:
>>>       <TASK>
>>>       __dump_stack lib/dump_stack.c:94 [inline]
>>>       dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>>>       fail_dump lib/fault-inject.c:53 [inline]
>>>       should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:154
>>>       should_failslab+0xac/0x100 mm/failslab.c:46
>>>       slab_pre_alloc_hook mm/slub.c:4072 [inline]
>>>       slab_alloc_node mm/slub.c:4148 [inline]
>>>       __do_kmalloc_node mm/slub.c:4297 [inline]
>>>       __kmalloc_noprof+0xdd/0x4c0 mm/slub.c:4310
>>>       kmalloc_noprof include/linux/slab.h:905 [inline]
>>>       kzalloc_noprof include/linux/slab.h:1037 [inline]
>>>       btrfs_chunk_alloc_add_chunk_item+0x244/0x1100 fs/btrfs/volumes.c=
:5742
>>>       reserve_chunk_space+0x1ca/0x2c0 fs/btrfs/block-group.c:4292
>>>       check_system_chunk fs/btrfs/block-group.c:4319 [inline]
>>>       do_chunk_alloc fs/btrfs/block-group.c:3891 [inline]
>>>       btrfs_chunk_alloc+0x77b/0xf80 fs/btrfs/block-group.c:4187
>>>       find_free_extent_update_loop fs/btrfs/extent-tree.c:4166 [inline=
]
>>>       find_free_extent+0x42d1/0x5810 fs/btrfs/extent-tree.c:4579
>>>       btrfs_reserve_extent+0x422/0x810 fs/btrfs/extent-tree.c:4672
>>>       btrfs_new_extent_direct fs/btrfs/direct-io.c:186 [inline]
>>>       btrfs_get_blocks_direct_write+0x706/0xfa0 fs/btrfs/direct-io.c:3=
21
>>>       btrfs_dio_iomap_begin+0xbb7/0x1180 fs/btrfs/direct-io.c:525
>>>       iomap_iter+0x697/0xf60 fs/iomap/iter.c:90
>>>       __iomap_dio_rw+0xeb9/0x25b0 fs/iomap/direct-io.c:702
>>>       btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
>>>       btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
>>>       btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
>>>       do_iter_readv_writev+0x600/0x880
>>>       vfs_writev+0x376/0xba0 fs/read_write.c:1050
>>>       do_pwritev fs/read_write.c:1146 [inline]
>>>       __do_sys_pwritev2 fs/read_write.c:1204 [inline]
>>>       __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
>>>       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>       entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>      RIP: 0033:0x7f1281f85d29
>>>      Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8=
 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d=
 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>>>      RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00148
>>>      RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d29
>>>      RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
>>>      RBP: 00007f12819fe090 R08: 0000000000000000 R09: 0000000000000003
>>>      R10: 0000000000007000 R11: 0000000000000246 R12: 0000000000000002
>>>      R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e23328
>>>       </TASK>
>>>      BTRFS error (device loop0 state A): Transaction aborted (error -1=
2)
>>>      BTRFS: error (device loop0 state A) in btrfs_chunk_alloc_add_chun=
k_item:5745: errno=3D-12 Out of memory
>>>      BTRFS info (device loop0 state EA): forced readonly
>>>      assertion failed: !(flags & ~BTRFS_ORDERED_TYPE_FLAGS), in fs/btr=
fs/ordered-data.c:1234
>>>      ------------[ cut here ]------------
>>>      kernel BUG at fs/btrfs/ordered-data.c:1234!
>>>      Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
>>>      CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzk=
aller #0
>>>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-d=
ebian-1.16.3-2~bpo12+1 04/01/2014
>>>      RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordered=
-data.c:1234
>>>      Code: 43 fd 90 0f 0b e8 43 c4 db fd 48 c7 c7 20 0c 4c 8c 48 c7 c6=
 80 0f 4c 8c 48 c7 c2 e0 0b 4c 8c b9 d2 04 00 00 e8 04 57 43 fd 90 <0f> 0b=
 e8 1c c4 db fd eb 5b e8 15 c4 db fd 48 c7 c7 20 0c 4c 8c 48
>>>      RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
>>>      RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c4195300
>>>      RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
>>>      RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf4
>>>      R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f401
>>>      R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a000
>>>      FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:00000=
00000000000
>>>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>      CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef0
>>>      DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>      DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>      Call Trace:
>>>       <TASK>
>>>       btrfs_extract_ordered_extent fs/btrfs/direct-io.c:702 [inline]
>>>       btrfs_dio_submit_io+0x4be/0x6d0 fs/btrfs/direct-io.c:737
>>>       iomap_dio_submit_bio fs/iomap/direct-io.c:85 [inline]
>>>       iomap_dio_bio_iter+0x1022/0x1740 fs/iomap/direct-io.c:447
>>>       __iomap_dio_rw+0x13b7/0x25b0 fs/iomap/direct-io.c:703
>>>       btrfs_dio_write fs/btrfs/direct-io.c:775 [inline]
>>>       btrfs_direct_write+0x610/0xa30 fs/btrfs/direct-io.c:880
>>>       btrfs_do_write_iter+0x2a0/0x760 fs/btrfs/file.c:1397
>>>       do_iter_readv_writev+0x600/0x880
>>>       vfs_writev+0x376/0xba0 fs/read_write.c:1050
>>>       do_pwritev fs/read_write.c:1146 [inline]
>>>       __do_sys_pwritev2 fs/read_write.c:1204 [inline]
>>>       __se_sys_pwritev2+0x196/0x2b0 fs/read_write.c:1195
>>>       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>       entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>      RIP: 0033:0x7f1281f85d29
>>>      Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8=
 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d=
 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>>>      RSP: 002b:00007f12819fe038 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00148
>>>      RAX: ffffffffffffffda RBX: 00007f1282176080 RCX: 00007f1281f85d29
>>>      RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
>>>      RBP: 00007f12819fe090 R08: 0000000000000000 R09: 0000000000000003
>>>      R10: 0000000000007000 R11: 0000000000000246 R12: 0000000000000002
>>>      R13: 0000000000000000 R14: 00007f1282176080 R15: 00007ffcb9e23328
>>>       </TASK>
>>>      Modules linked in:
>>>      ---[ end trace 0000000000000000 ]---
>>>      RIP: 0010:btrfs_split_ordered_extent+0xd8d/0xe20 fs/btrfs/ordered=
-data.c:1234
>>>      Code: 43 fd 90 0f 0b e8 43 c4 db fd 48 c7 c7 20 0c 4c 8c 48 c7 c6=
 80 0f 4c 8c 48 c7 c2 e0 0b 4c 8c b9 d2 04 00 00 e8 04 57 43 fd 90 <0f> 0b=
 e8 1c c4 db fd eb 5b e8 15 c4 db fd 48 c7 c7 20 0c 4c 8c 48
>>>      RSP: 0018:ffffc9000d1df2b8 EFLAGS: 00010246
>>>      RAX: 0000000000000057 RBX: 000000000006a000 RCX: 9ce21886c4195300
>>>      RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
>>>      RBP: 0000000000000091 R08: ffffffff817f0a3c R09: 1ffff92001a3bdf4
>>>      R10: dffffc0000000000 R11: fffff52001a3bdf5 R12: 1ffff1100a45f401
>>>      R13: ffff8880522fa018 R14: dffffc0000000000 R15: 000000000006a000
>>>      FS:  00007f12819fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:00000=
00000000000
>>>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>      CR2: 0000557750bd7da8 CR3: 00000000400ea000 CR4: 0000000000352ef0
>>>      DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>      DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>
>>> In this case the transaction abort was due to (an injected) memory
>>> allocation failure when attempting to allocate a new chunk.
>>>
>>> Reported-by: syzbot+f60d8337a5c8e8d92a77@syzkaller.appspotmail.com
>>> Link: https://lore.kernel.org/linux-btrfs/6777f2dd.050a0220.178762.004=
5.GAE@google.com/
>>> Fixes: 52b1fdca23ac ("btrfs: handle completed ordered extents in btrfs=
_split_ordered_extent")
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks,
>> Qu
>>
>>> ---
>>>    fs/btrfs/ordered-data.c | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>>
>>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>>> index 30eceaf829a7..3cf95a801086 100644
>>> --- a/fs/btrfs/ordered-data.c
>>> +++ b/fs/btrfs/ordered-data.c
>>> @@ -1229,6 +1229,18 @@ struct btrfs_ordered_extent *btrfs_split_ordere=
d_extent(
>>>         */
>>>        if (WARN_ON_ONCE(len >=3D ordered->num_bytes))
>>>                return ERR_PTR(-EINVAL);
>>> +     /*
>>> +      * If our ordered extent had an error there's no point in contin=
uing.
>>> +      * The error may have come from a transaction abort done either =
by this
>>> +      * task or some other concurrent task, and the transaction abort=
 path
>>> +      * iterates over all existing ordered extents and sets the flag
>>> +      * BTRFS_ORDERED_IOERR on them.
>>> +      */
>>> +     if (unlikely(flags & BTRFS_ORDERED_IOERR)) {
>
> This should be:
>
> flags & (1U << BTRFS_ORDERED_IOERR)

Sorry I didn't mention before merging, you can use test_bit() instead.

Thanks,
Qu
>
> I'll fix it up when committing to for-next, thanks.
>
>>> +             const int fs_error =3D BTRFS_FS_ERROR(fs_info);
>>> +
>>> +             return fs_error ? ERR_PTR(fs_error) : ERR_PTR(-EIO);
>>> +     }
>>>        /* We cannot split partially completed ordered extents. */
>>>        if (ordered->bytes_left) {
>>>                ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));
>>


