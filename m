Return-Path: <linux-btrfs+bounces-11353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A928A2E288
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 04:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618CA3A1A47
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 03:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D079B81741;
	Mon, 10 Feb 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Rrho+h8g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2A43AA1;
	Mon, 10 Feb 2025 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739157028; cv=none; b=q6zgKoSFGgecnbcfMYjbPZ2Ij7FoLxQXvWxPfYqSaMozFKyIABGRCPoAvJ8cLjfCaLf5clkUZfm/gvCdX3bGtRa9rwMsRGxBT3dZ/RyHArb3zq81E3i7hSU2zDhsi9Sj7hcfjKFV0XxOnOA5ccLZeWjlHnauzJ4MRuBzOjlp7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739157028; c=relaxed/simple;
	bh=yjY+exSJE7/JJWUq4WXCjI9L2fthXIkctkXXnAjLGxg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=tCX52/fk6oTJ04sxcXnCcB/ehfCoa134FEtfi4iyw5j8P4GtVoiPk2uQ/9kufMiJhvQR+qGUhBzjekah2tSLxbd/ZJrm9w51872Ol1zgjv7ltPDp+IRBO9CB2nycWsdNtTYDVBo/O/5MTW/0VwUMT+gw+4b3KgPZF9DV50OhioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Rrho+h8g; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739157020; x=1739761820; i=quwenruo.btrfs@gmx.com;
	bh=VOe4tqgObHcmWI3rA8gKQInJDknjCN0wZBan3/Th4h0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Rrho+h8g5T3wl2BYZ+PsVd6BNEeA9PUvxcC5YibX3CPMg+ZRq+mBPOa+qD1YMteJ
	 Vo0reCLHyv2kegnOL/23WYEAnc777b7SNkwHqGBU0w7Fmmrxp10DU9192BAozzQBx
	 bhiBRw/95S3FoXyq7hpL3RWF4oyfH0EADR1/6ub09Gjecpe/vClv+7Nmf/bGcOV+C
	 EQ5+bs4hlVjam4fGKMkEk4A8GWDtyBx7hxKJS6qDQnJwFx7KGUp9ecR8BVzj/pTnq
	 TPcEyaXExRf4mtKIpLnHIG1SoAZfkeCLja7ACZblxQ1Rp1ElAzx/XwacPcwBUEdiy
	 9xFSrVOVrARfUD61wA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lc9-1thbAW2lYR-006HDR; Mon, 10
 Feb 2025 04:10:20 +0100
Message-ID: <152296f3-5c81-4a94-97f3-004108fba7be@gmx.com>
Date: Mon, 10 Feb 2025 13:40:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Memory Management List <linux-mm@kvack.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Btrfs crash on generic/437 on x86_64
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FKdjXnbhO3oXfvLjg7aO36NNzYnwS9Zu6pXKTG6A0iiomdfisti
 CMimevxMnCLAEY2lLVNjv0hJWCDw9bkWztKAMfZUF45upqwo9YoJckjU6CUwBCBaaFQrVdq
 sd6mY4CXNufsBaCmfqfsuI1RGHwhooM8LxjIwsChTGE5tLPaNGJJiS1mAzQO4I878GRZneF
 4z3mtosfBu46Ogt4gC7Pg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kt/27wSjG70=;WHtqESjoTGbqh0t60bLCdzwpJtk
 GH0f4fjobMjnJoZK3HCqnEtFCGHKlEctnrNDn6hp9+YHCoK2vCPpPDrINrbA2H2QJmxjCr+yj
 PrlZqeFpcg+xI4K/Y1//Yf0zk1e/3n6t81PcR0faBsVo9OGwhGopubBYnYeHCc5YCbo8eB421
 6xw+jSOyyX41jn1UyJMs2xZuCDNypuJkJDMoQm60CDDuRap31TyfXsn8gqEIVF23/u+Ln71O6
 zYd/B5BAZJdTNfZgC0anyWHlVDFwHtmbMwGKjiGM5BFdlr22+hwAzdhb5S7Ac5qvZxzb9bptU
 1XvymWEH0ijWfXvMdDKQUbwKR3trBI1ErpOqBWwwxLj14pAwqPQLhzLf68MeJInaLOGUiK0er
 YEujcl2k8aW2aSRn3/WLFzW8KBzsci8qqo6vONYaydHbct/vjdpiJvzbGlC+xd/QHc5ejdOEQ
 7SdXdjcxxgR+7e+N33U6OEAw3+CO1/+ZBs2/qCLkr/R6fNf2OBIDV0fHZNZgPaTB0PW9E5ihw
 +U9R0AkJfvUQ1cV4UvVB2Abr/maPFRY9KMvdeu/WFNJ+H+FhIkzH8qboeU/Ja1ZIjmooTwxwj
 h4yqg1v7skj1aZjU+zevQE+uE/ltweh7N3h9H01G+PQqvEMimNrHxMQzVfLA9FSTmFzsD2kaX
 v1MsHPH+VxAclPOW0dY5TBwRbmnMBmWoKprPzhrN5glw33TsndV9bXiD0PwQZTID5M0tslDBD
 mC8W4zXbp/4yLhbC9sCVki6gWAWfD/x5rtQxt9BoqEgHl88DTU5tMPmjSg3LqW5Aak9ePGUVv
 xvEPJt2BIvq+IKHt39xFyJ+/vYj3iondInyxzpKQVgFQY9zoBRNI7vsPVERYpa9NttsYDVAxI
 a7FVq2qCjn1wpJxERoheR0Ml0YjvF94NS1WfmoqnriS4nAkk8ZMhTgYzP2dyNY8Hfsr+MS/Jr
 /0VdY2+QQqUeN1VitqwtWf0H7A8orsa+YvdiNHpNjXBaNllmJlIyA5Z/mXEgs320nG0SRhHCP
 jR20OYNWZW2RvPGTBtJ074yJcxrtmCPSgYV4NbMSF2WujuoaFM6QvsUudfPR9YL6ButjvbMIa
 OxWMgDSfyILTtP4vcXs9gE7aMyLVf5J56FqatjR2xej9MUYO2kpC9PO6LqR9OX3yPiQ4uXsIE
 kUFGWmbP5r1frn1MGhVWEe1oANkfCqYhz0fiWURnpDq/SV77j+5C1HX7/3yRY4+PguulpbxWA
 kkILhxG9+cMTNxLES7uL7ZyV+foeJQY+XHmHGFl0mlxO5TxSlSyZ3uljV1XNYy5thAbFny27q
 gZpTTiQnXM8APLbTVcV8dk6nQgSHZLwbLpmwS2rhrUrOddNgHVLYkVe16LegEUB3Jr2Kk6Tx3
 iRyh+Nuv1Gf+q0V4zTNZyYHuwjdRLhndOyoVlNjaWQ8t4bnY+EZOJxJC4F

Hi,

Normally such crash should not be worth reporting, and we would just
digging to fix it.

But this one is a little weird, we got a folio which is still mapped
during filemap_unaccount_folio().

I can reproduce it with default mount option with generic/437, so far 32
runs are enough to trigger it reliably.

And I'm not yet able to reproduce it on aarch64 (64K page size, 4K page
size so far).

I'm already trying to bisect the bug, it so far it's still reproducible
at 6.14-rc1.

Any advice/clue would be appreciated.

Dmesg:

[   58.305921] BTRFS info (device dm-0): using free-space-tree
[   58.319296] run fstests generic/437 at 2025-02-10 13:24:19
[   59.283069] BUG: Bad rss-counter state mm:0000000048578720
type:MM_FILEPAGES val:1
[   59.296485] page: refcount:3 mapcount:1 mapping:00000000828f872f
index:0x0 pfn:0x13ab4f
[   59.297223] memcg:ffff888105a32000
[   59.297533] aops:btrfs_aops [btrfs] ino:1031b
[   59.298188] flags:
0x2ffff800000002d(locked|referenced|uptodate|lru|node=3D0|zone=3D2|lastcpu=
pid=3D0x1ffff)
[   59.298955] raw: 02ffff800000002d ffffea0004184948 ffffea0004c40c88
ffff888107c7a2b8
[   59.299607] raw: 0000000000000000 0000000000000000 0000000300000000
ffff888105a32000
[   59.300261] page dumped because: VM_BUG_ON_FOLIO(folio_mapped(folio))
[   59.300846] ------------[ cut here ]------------
[   59.301256] kernel BUG at mm/filemap.c:154!
[   59.301635] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   59.302144] CPU: 4 UID: 0 PID: 17354 Comm: umount Tainted: G
  OE      6.14.0-rc1-custom+ #211
[   59.302953] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[   59.303447] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
unknown 02/02/2022
[   59.304291] RIP: 0010:filemap_unaccount_folio+0x153/0x1f0
[   59.305224] Code: b0 f0 00 00 00 e9 5d f6 00 00 48 c7 c6 80 1b 43 82
48 89 df e8 ae 89 04 00 0f 0b 48 c7 c6 10 d8 44 82 48 89 df e8 9d 89 04
00 <0f> 0b 48 8b 06 a8 40 74 4c 8b 43 50 e9 ce fe ff ff 48 c7 c6 80 1b
[   59.308807] RSP: 0018:ffffc90005387a18 EFLAGS: 00010046
[   59.309382] RAX: 0000000000000039 RBX: ffffea0004ead3c0 RCX:
0000000000000027
[   59.310313] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
ffff888277c21880
[   59.311856] RBP: ffff888107c7a2b8 R08: ffffffff82cad0a8 R09:
00000000fffff000
[   59.312879] R10: ffffffff82c55100 R11: 6d75642065676170 R12:
0000000000000001
[   59.313607] R13: ffffffffffffffff R14: ffffc90005387ad8 R15:
ffff888107c7a2c0
[   59.314347] FS:  00007ff0455f2b80(0000) GS:ffff888277c00000(0000)
knlGS:0000000000000000
[   59.315159] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.315744] CR2: 000055e761f94f58 CR3: 0000000166a44000 CR4:
00000000000006f0
[   59.316476] Call Trace:
[   59.316749]  <TASK>
[   59.316986]  ? __die_body.cold+0x19/0x24
[   59.317401]  ? die+0x2e/0x50
[   59.317704]  ? do_trap+0xca/0x110
[   59.318062]  ? do_error_trap+0x6a/0x90
[   59.318464]  ? filemap_unaccount_folio+0x153/0x1f0
[   59.318990]  ? exc_invalid_op+0x50/0x70
[   59.319416]  ? filemap_unaccount_folio+0x153/0x1f0
[   59.319933]  ? asm_exc_invalid_op+0x1a/0x20
[   59.320395]  ? filemap_unaccount_folio+0x153/0x1f0
[   59.320918]  ? filemap_unaccount_folio+0x153/0x1f0
[   59.321408]  delete_from_page_cache_batch+0x95/0x3c0
[   59.321912]  truncate_inode_pages_range+0x142/0x570
[   59.322413]  btrfs_evict_inode+0x8b/0x390 [btrfs]
[   59.323055]  evict+0x14f/0x2d0
[   59.323374]  evict_inodes+0x19c/0x240
[   59.323748]  generic_shutdown_super+0x42/0x100
[   59.324203]  kill_anon_super+0x16/0x40
[   59.324588]  btrfs_kill_super+0x16/0x20 [btrfs]
[   59.325094]  deactivate_locked_super+0x33/0xb0
[   59.325564]  cleanup_mnt+0xba/0x150
[   59.325926]  task_work_run+0x5c/0x90
[   59.326299]  syscall_exit_to_user_mode+0x129/0x140
[   59.326781]  do_syscall_64+0x5b/0x120
[   59.327162]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   59.327676] RIP: 0033:0x7ff0457471cb
[   59.328056] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f
1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 11 cb 0c 00 f7 d8
[   59.329814] RSP: 002b:00007ffc65f95d28 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[   59.330475] RAX: 0000000000000000 RBX: 000055e761f87420 RCX:
00007ff0457471cb
[   59.331077] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
000055e761f8cb00
[   59.331690] RBP: 00007ffc65f95e00 R08: 000055e761f87010 R09:
0000000000000007
[   59.332297] R10: 0000000000000000 R11: 0000000000000246 R12:
000055e761f87528
[   59.332896] R13: 0000000000000000 R14: 000055e761f8cb00 R15:
000055e761f87830
[   59.333507]  </TASK>
[   59.333700] Modules linked in: crc32c_generic btrfs(OE) vfat fat
blake2b_generic xor zstd_compress iTCO_wdt iTCO_vendor_support psmouse
i2c_i801 pcspkr i2c_smbus lpc_ich intel_agp joydev intel_gtt mousedev
agpgart raid6_pq drm fuse loop qemu_fw_cfg ext4 crc16 mbcache jbd2
dm_mod virtio_net net_failover virtio_rng failover virtio_balloon
virtio_scsi virtio_console rng_core virtio_blk virtio_pci serio_raw
virtio_pci_legacy_dev usbhid virtio_pci_modern_dev [last unloaded: btrfs]
[   59.337352] Dumping ftrace buffer:
[   59.337715]    (ftrace buffer empty)
[   59.338098] ---[ end trace 0000000000000000 ]---
[   59.351979] pstore: backend (efi_pstore) writing error (-28)
[   59.352590] RIP: 0010:filemap_unaccount_folio+0x153/0x1f0
[   59.353182] Code: b0 f0 00 00 00 e9 5d f6 00 00 48 c7 c6 80 1b 43 82
48 89 df e8 ae 89 04 00 0f 0b 48 c7 c6 10 d8 44 82 48 89 df e8 9d 89 04
00 <0f> 0b 48 8b 06 a8 40 74 4c 8b 43 50 e9 ce fe ff ff 48 c7 c6 80 1b
[   59.355140] RSP: 0018:ffffc90005387a18 EFLAGS: 00010046
[   59.355702] RAX: 0000000000000039 RBX: ffffea0004ead3c0 RCX:
0000000000000027
[   59.356429] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
ffff888277c21880
[   59.357131] RBP: ffff888107c7a2b8 R08: ffffffff82cad0a8 R09:
00000000fffff000
[   59.357847] R10: ffffffff82c55100 R11: 6d75642065676170 R12:
0000000000000001
[   59.358558] R13: ffffffffffffffff R14: ffffc90005387ad8 R15:
ffff888107c7a2c0
[   59.359274] FS:  00007ff0455f2b80(0000) GS:ffff888277c00000(0000)
knlGS:0000000000000000
[   59.360073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.360676] CR2: 000055e761f94f58 CR3: 0000000166a44000 CR4:
00000000000006f0
[   59.361445] Kernel panic - not syncing: Fatal exception
[   59.362127] Dumping ftrace buffer:
[   59.362498]    (ftrace buffer empty)
[   59.362891] Kernel Offset: disabled
[   59.376221] Rebooting in 5 seconds..

