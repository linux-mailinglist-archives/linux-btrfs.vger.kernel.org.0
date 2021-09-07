Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0329D403199
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 01:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhIGXle (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 19:41:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:32979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhIGXld (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Sep 2021 19:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631058023;
        bh=Kyym+ujUKsFT07CJc0SgmUkBrWVulUNZDSHYXhV2Dus=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jsgtAQL1eMPVk80MZpzQtJ/6X4MUe5ANx4HGP2FRne8Hn+a+h0P9FUiJilZ75jwas
         CcHbphwv8t70M+KuR9N6uYRIN19njgEuEo8JhwfJbOIhts2nDg+70dicyV934ACPcq
         O0MIi0u9oZmWE84dS+QG14v8NdpHgu6Z7g2L291k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0XCw-1n8pXu1CRY-00wUOp; Wed, 08
 Sep 2021 01:40:22 +0200
Subject: Re: [PATCH v2 00/26] btrfs: limited subpage compressed write support
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210829052458.15454-1-wqu@suse.com>
 <20210907180228.GS3379@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <56749aba-4760-0f0a-e626-b2954d61b0d5@gmx.com>
Date:   Wed, 8 Sep 2021 07:40:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907180228.GS3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XxTpmmGUFbjw2MEBURS/vJHt1yHixJwi7+uojCAjM/Br2XA1jm/
 Zw31OoY8ybiIn8niCyOkJja3Tt73R4kUG93NuvDRHmpecLoZO7yEalC/dYLeR3nwpCsRYo/
 XPl/6X57YYjcoPyi8ZDofk2aOr7oTlirqcLalXyqUcdTfKR72NOmeeKNeF49Pf/SL4Jay76
 pnG5ZCA8oIVgnfsTghRNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gWDzlgK9mVM=:0rcKlNcWAMJf8yUvGKMmGR
 vnlJP0AJXoxF2g/pd5+RsGQ7YKx2gqn/LXZWeQzGASLqrd44q0ni3YAk+X2sMtXwFlDixYxY6
 5ey7QHotTl7PnzjXlNNMbMjvgz9BWTDxpXshub57cT6dy4qTJVYtcniV1QzkeYC9aC8m3DZ0N
 IgXDk+CsT50cRXtNq3quri+fsIHxUZskH2zxpC7Dvz7nErYwMAMhkbjdJCyNMyZ+9lsmXicKB
 tzAvojHyR7VNpEaoZ+ASiTE2TBlJmEzFdSHl3UWY81Wt8UeYTCAdFJlykJfLQzoPs/4hKIGt3
 0o4Hap6XwXLI0u052d3UXZUq5KzIn1fPhYSQVwizO2/Xh8sG9/1FCdWdyJ3fekCMLgg1f3HD3
 wZhF2ctEmYTGmxsDSV4a1fVEKBDjbRPahMx8rwgSw/scbBZaKVnOSmBgKDNWz7n3PRJInnf9i
 61HsUGiZOCJyTfnRUYq1LW97cHKtjnf3SQRzhUb2taXRzl3Zt+GGcyJkXnvHG31U3M4fIFPd0
 u0DxQ2uf8QEFBE6J/FDD+HT4unKtQlMUMf9dO9czi/Ou2DpxCXdvL6ACq1Yk2EzNqJlb2R7Pc
 usQPe+k8KIV8UGTAsRUMHqrfUV9NqloGvvroh9CGL/OQpPwA6b3dsoAbmfh3AsUxy/+Tcwiny
 uHoa7Nhi0lR8JEVKZ7gqOvCBl2P1Ti+/mqtU//sxdPAPbAR+lCKd4F5BmxY/FE1/lSMW8sVNF
 lf18UQ4y6AMypIUUl+LWGzZhIC6Gk/gNLLZHk68jmTcw44+nz3DgpjXe3N3yn6yZt58g4gsYj
 fzgWESo5JyK9pnJQcG191P43/UciQCZxvJQ7XueGjyTDQjaujjLUm/XgfUgg1hdC9GMxrqru7
 CIA4ECGceHZm5b/cPQCghnJR4eNL3sLWLiqsAGWuqtxbGRTpwyCmkc3I+bDLRyktg3xGl5SV5
 lvNgHJpp0+dCVdpbhbDwOaW+w770HgRSJXaj+aPDsa5EyI6ewm8itsjScarSmtHVp4XztAZVl
 kqAG6FyHmCDERPj73ZwiWVzV1GxFwOgG7Lm5k25XwlFipaqZqdjdyTif7OaNAaB+PTfRgLdv7
 A4tcHjSqU0uFEEJG2JXsQA0UYjw9auKZaXO4fNli6PEel22S+6op2QMMw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/8 =E4=B8=8A=E5=8D=882:02, David Sterba wrote:
> Crash in btrfs/138

Any reproducibility?

I retried a dozen runs, no reproduce yet.

Although it's x86_64, I also tried on aarch64 with 64K page size, the same=
.

My current base is:

commit 23fe0a532654a92093f4fb59845d40bdcf74c1a6 (david/misc-next)
Author: Kari Argillander <kari.argillander@gmail.com>
Date:   Tue Aug 31 00:51:52 2021 +0300

     btrfs: use correct header for div_u64 in misc.h


>
> btrfs/138		[17:47:31][ 3286.600120] run fstests btrfs/138 at 2021-09-07 =
17:47:31
> [ 3286.932138] BTRFS: device fsid 438a1e94-63da-4e19-a479-3bc7d9b9b93a d=
evid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (22121)
> [ 3286.958963] BTRFS info (device vdb): flagging fs with big metadata fe=
ature
> [ 3286.960269] BTRFS info (device vdb): disk space caching is enabled
> [ 3286.961378] BTRFS info (device vdb): has skinny extents
> [ 3286.965129] BTRFS info (device vdb): checking UUID tree
> [ 3334.373345] BTRFS info (device vdb): flagging fs with big metadata fe=
ature
> [ 3334.374919] BTRFS info (device vdb): disk space caching is enabled
> [ 3334.376099] BTRFS info (device vdb): has skinny extents
> [ 3334.456496] BTRFS info (device vdb): setting incompat feature flag fo=
r COMPRESS_LZO (0x8)
> [ 3334.708351] BUG: kernel NULL pointer dereference, address: 0000000000=
000000
> [ 3334.709746] #PF: supervisor read access in kernel mode
> [ 3334.710727] #PF: error_code(0x0000) - not-present page
> [ 3334.711741] PGD 0 P4D 0
> [ 3334.712341] Oops: 0000 [#1] PREEMPT SMP
> [ 3334.713178] CPU: 2 PID: 22182 Comm: kworker/u8:7 Not tainted 5.14.0-r=
c7-default+ #1561
> [ 3334.714773] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [ 3334.716942] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
> [ 3334.718197] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrfs=
]

Any code context for the RIP?

Thanks,
Qu

> [ 3334.723372] RSP: 0018:ffffa7c44a0c7c20 EFLAGS: 00010293
> [ 3334.724418] RAX: 0000000000000000 RBX: 0000000000000fff RCX: 00000000=
00000000
> [ 3334.725777] RDX: 0000000000000b3d RSI: 0000000000016000 RDI: 00000000=
00000000
> [ 3334.727117] RBP: ffffa7c44a0c7cc4 R08: 0000000000000b3d R09: ffff9f1d=
45f34000
> [ 3334.728517] R10: ffff9f1d7de00000 R11: 0000000000000000 R12: ffff9f1d=
5a812000
> [ 3334.729878] R13: 0000000000000000 R14: ffffa7c44a0c7cc4 R15: 00000000=
00000000
> [ 3334.731211] FS:  0000000000000000(0000) GS:ffff9f1d7da00000(0000) knl=
GS:0000000000000000
> [ 3334.732756] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3334.733821] CR2: 0000000000000000 CR3: 0000000076a0f002 CR4: 00000000=
00170ea0
> [ 3334.735253] Call Trace:
> [ 3334.735873]  lzo_compress_pages+0x182/0x320 [btrfs]
> [ 3334.736901]  btrfs_compress_pages+0xbc/0x130 [btrfs]
> [ 3334.737910]  compress_file_range+0x3ae/0x820 [btrfs]
> [ 3334.738876]  ? rcu_read_lock_sched_held+0x12/0x70
> [ 3334.739943]  ? submit_compressed_extents+0xc0/0xc0 [btrfs]
> [ 3334.741058]  async_cow_start+0x12/0x30 [btrfs]
> [ 3334.741933]  btrfs_work_helper+0xd6/0x1d0 [btrfs]
> [ 3334.742987]  process_one_work+0x262/0x5e0
> [ 3334.743869]  ? exit_to_user_mode_prepare+0x1b2/0x1c0
> [ 3334.744869]  ? process_one_work+0x5e0/0x5e0
> [ 3334.745780]  worker_thread+0x55/0x3c0
> [ 3334.746598]  ? process_one_work+0x5e0/0x5e0
> [ 3334.747456]  kthread+0x144/0x170
> [ 3334.748139]  ? set_kthread_struct+0x40/0x40
> [ 3334.748995]  ret_from_fork+0x1f/0x30
> [ 3334.749787] Modules linked in: dm_flakey dm_mod btrfs blake2b_generic=
 libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compr=
ess lzo_decompress raid6_pq loop
> [ 3334.752514] CR2: 0000000000000000
> [ 3334.753164] ---[ end trace f1f62e4293ace345 ]---
> [ 3334.753177] BUG: kernel NULL pointer dereference, address: 0000000000=
000000
> [ 3334.753887] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrfs=
]
> [ 3334.754968] #PF: supervisor read access in kernel mode
> [ 3334.756704] #PF: error_code(0x0000) - not-present page
> [ 3334.759238] RSP: 0018:ffffa7c44a0c7c20 EFLAGS: 00010293
> [ 3334.760011] PGD 0 P4D 0
> [ 3334.760787] RAX: 0000000000000000 RBX: 0000000000000fff RCX: 00000000=
00000000
> [ 3334.760790] RDX: 0000000000000b3d RSI: 0000000000016000 RDI: 00000000=
00000000
> [ 3334.761227] Oops: 0000 [#2] PREEMPT SMP
> [ 3334.762222] RBP: ffffa7c44a0c7cc4 R08: 0000000000000b3d R09: ffff9f1d=
45f34000
> [ 3334.763228] CPU: 1 PID: 30809 Comm: kworker/u8:10 Tainted: G      D  =
         5.14.0-rc7-default+ #1561
> [ 3334.763828] R10: ffff9f1d7de00000 R11: 0000000000000000 R12: ffff9f1d=
5a812000
> [ 3334.764833] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [ 3334.766165] R13: 0000000000000000 R14: ffffa7c44a0c7cc4 R15: 00000000=
00000000
> [ 3334.767166] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
> [ 3334.769097] FS:  0000000000000000(0000) GS:ffff9f1d7da00000(0000) knl=
GS:0000000000000000
> [ 3334.770482]
> [ 3334.771422] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3334.772857] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrfs=
]
> [ 3334.773201] CR2: 0000000000000000 CR3: 0000000076a0f002 CR4: 00000000=
00170ea0
> [ 3334.779303] RSP: 0018:ffffa7c446f47c20 EFLAGS: 00010293
> [ 3334.780739] RAX: 0000000000000000 RBX: 0000000000000fff RCX: 00000000=
00000000
> [ 3334.783079] RDX: 0000000000000b47 RSI: 0000000000016000 RDI: 00000000=
00000000
> [ 3334.784979] RBP: ffffa7c446f47cc4 R08: 0000000000000b47 R09: ffff9f1d=
1d088000
> [ 3334.786059] R10: ffff9f1d7de00000 R11: 0000000000000000 R12: ffff9f1d=
249ba000
> [ 3334.786654] R13: 0000000000000000 R14: ffffa7c446f47cc4 R15: 00000000=
00000000
> [ 3334.787216] FS:  0000000000000000(0000) GS:ffff9f1d7d800000(0000) knl=
GS:0000000000000000
> [ 3334.788178] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3334.788721] CR2: 0000000000000000 CR3: 0000000026af4005 CR4: 00000000=
00170ea0
> [ 3334.789281] Call Trace:
> [ 3334.789527]  lzo_compress_pages+0x182/0x320 [btrfs]
> [ 3334.790013]  btrfs_compress_pages+0xbc/0x130 [btrfs]
> [ 3334.790468]  compress_file_range+0x3ae/0x820 [btrfs]
> [ 3334.790921]  ? rcu_read_lock_sched_held+0x12/0x70
> [ 3334.791327]  ? submit_compressed_extents+0xc0/0xc0 [btrfs]
> [ 3334.792104]  async_cow_start+0x12/0x30 [btrfs]
> [ 3334.792615]  btrfs_work_helper+0xd6/0x1d0 [btrfs]
> [ 3334.793059]  process_one_work+0x262/0x5e0
> [ 3334.793440]  ? process_one_work+0x5e0/0x5e0
> [ 3334.793807]  worker_thread+0x55/0x3c0
> [ 3334.794131]  ? process_one_work+0x5e0/0x5e0
> [ 3334.794489]  kthread+0x144/0x170
> [ 3334.794787]  ? set_kthread_struct+0x40/0x40
> [ 3334.795151]  ret_from_fork+0x1f/0x30
> [ 3334.795537] Modules linked in: dm_flakey dm_mod btrfs blake2b_generic=
 libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compr=
ess lzo_decompress raid6_pq loop
> [ 3334.797011] CR2: 0000000000000000
> [ 3334.797315] ---[ end trace f1f62e4293ace346 ]---
> [ 3334.797341] BUG: kernel NULL pointer dereference, address: 0000000000=
000000
> [ 3334.797704] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrfs=
]
> [ 3334.803174] #PF: supervisor read access in kernel mode
> [ 3334.804664] #PF: error_code(0x0000) - not-present page
> [ 3334.806086] RSP: 0018:ffffa7c44a0c7c20 EFLAGS: 00010293
> [ 3334.806515] PGD 0
> [ 3334.806515]
> [ 3334.806516] P4D 0
> [ 3334.806939] RAX: 0000000000000000 RBX: 0000000000000fff RCX: 00000000=
00000000
> [ 3334.807153]
> [ 3334.807331] RDX: 0000000000000b3d RSI: 0000000000016000 RDI: 00000000=
00000000
> [ 3334.807703] Oops: 0000 [#3] PREEMPT SMP
> [ 3334.808689] RBP: ffffa7c44a0c7cc4 R08: 0000000000000b3d R09: ffff9f1d=
45f34000
> [ 3334.808921] CPU: 2 PID: 12629 Comm: kworker/u8:16 Tainted: G      D  =
         5.14.0-rc7-default+ #1561
> [ 3334.809492] R10: ffff9f1d7de00000 R11: 0000000000000000 R12: ffff9f1d=
5a812000
> [ 3334.809831] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [ 3334.810388] R13: 0000000000000000 R14: ffffa7c44a0c7cc4 R15: 00000000=
00000000
> [ 3334.811138] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
> [ 3334.812090] FS:  0000000000000000(0000) GS:ffff9f1d7d800000(0000) knl=
GS:0000000000000000
> [ 3334.814225]
> [ 3334.814227] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrfs=
]
> [ 3334.815124] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3334.817404] CR2: 0000000000000000 CR3: 0000000026af4005 CR4: 00000000=
00170ea0
> [ 3334.817643] RSP: 0018:ffffa7c4462a7c20 EFLAGS: 00010293
> [ 3334.823627] RAX: 0000000000000000 RBX: 0000000000000fff RCX: 00000000=
00000000
> [ 3334.824686] RDX: 0000000000000b20 RSI: 0000000000013000 RDI: 00000000=
00000000
> [ 3334.825690] RBP: ffffa7c4462a7cc4 R08: 0000000000000b20 R09: ffff9f1d=
0e25c000
> [ 3334.826514] R10: ffff9f1d7de00000 R11: 0000000000000000 R12: ffff9f1d=
16c9a000
> [ 3334.827798] R13: 0000000000000000 R14: ffffa7c4462a7cc4 R15: 00000000=
00000000
> [ 3334.829022] FS:  0000000000000000(0000) GS:ffff9f1d7da00000(0000) knl=
GS:0000000000000000
> [ 3334.831687] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3334.832449] CR2: 0000000000000000 CR3: 0000000076a0f002 CR4: 00000000=
00170ea0
> [ 3334.833424] Call Trace:
> [ 3334.833856]  lzo_compress_pages+0x182/0x320 [btrfs]
> [ 3334.834594]  btrfs_compress_pages+0xbc/0x130 [btrfs]
> [ 3334.835428]  compress_file_range+0x3ae/0x820 [btrfs]
> [ 3334.836500]  ? rcu_read_lock_sched_held+0x12/0x70
> [ 3334.837485]  ? submit_compressed_extents+0xc0/0xc0 [btrfs]
> [ 3334.838699]  async_cow_start+0x12/0x30 [btrfs]
> [ 3334.839737]  btrfs_work_helper+0xd6/0x1d0 [btrfs]
> [ 3334.840694]  process_one_work+0x262/0x5e0
> [ 3334.841483]  ? process_one_work+0x5e0/0x5e0
> [ 3334.842355]  worker_thread+0x55/0x3c0
> [ 3334.843458]  ? process_one_work+0x5e0/0x5e0
> [ 3334.844679]  kthread+0x144/0x170
> [ 3334.848139]  ? set_kthread_struct+0x40/0x40
> [ 3334.849036]  ret_from_fork+0x1f/0x30
> [ 3334.849753] Modules linked in: dm_flakey dm_mod btrfs blake2b_generic=
 libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compr=
ess lzo_decompress raid6_pq loop
> [ 3334.853981] CR2: 0000000000000000
> [ 3334.854724] ---[ end trace f1f62e4293ace347 ]---
> [ 3334.855728] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrfs=
]
> [ 3334.861741] RSP: 0018:ffffa7c44a0c7c20 EFLAGS: 00010293
> [ 3334.862726] RAX: 0000000000000000 RBX: 0000000000000fff RCX: 00000000=
00000000
> [ 3334.863989] RDX: 0000000000000b3d RSI: 0000000000016000 RDI: 00000000=
00000000
> [ 3334.865758] RBP: ffffa7c44a0c7cc4 R08: 0000000000000b3d R09: ffff9f1d=
45f34000
> [ 3334.867185] R10: ffff9f1d7de00000 R11: 0000000000000000 R12: ffff9f1d=
5a812000
> [ 3334.868428] R13: 0000000000000000 R14: ffffa7c44a0c7cc4 R15: 00000000=
00000000
> [ 3334.869858] FS:  0000000000000000(0000) GS:ffff9f1d7da00000(0000) knl=
GS:0000000000000000
> [ 3334.871360] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3334.872497] CR2: 0000000000000000 CR3: 0000000076a0f002 CR4: 00000000=
00170ea0
> [ 3334.873307] BUG: sleeping function called from invalid context at inc=
lude/linux/percpu-rwsem.h:49
> [ 3334.874422] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 12=
629, name: kworker/u8:16
> [ 3334.875559] INFO: lockdep is turned off.
> [ 3334.876390] irq event stamp: 0
> [ 3334.876962] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [ 3334.877656] hardirqs last disabled at (0): [<ffffffff9d066794>] copy_=
process+0x514/0x17e0
> [ 3334.878434] softirqs last  enabled at (0): [<ffffffff9d066794>] copy_=
process+0x514/0x17e0
> [ 3334.879105] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 3334.879748] CPU: 2 PID: 12629 Comm: kworker/u8:16 Tainted: G      D  =
         5.14.0-rc7-default+ #1561
> [ 3334.882202] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [ 3334.884399] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
> [ 3334.885295] Call Trace:
> [ 3334.885608]  ? wake_up_klogd+0x29/0x90
> [ 3334.886045]  dump_stack_lvl+0x45/0x59
> [ 3334.886405]  ___might_sleep.cold+0x107/0x132
> [ 3334.887080]  exit_signals+0x1d/0x360
> [ 3334.887534]  do_exit+0xa2/0x4a0
> [ 3334.888203]  rewind_stack_do_exit+0x17/0x17
> [ 3334.889005] RIP: 0000:0x0
> [ 3334.889588] Code: Unable to access opcode bytes at RIP 0xffffffffffff=
ffd6.
> [ 3334.890916] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 000=
0000000000000
> [ 3334.892556] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000=
00000000
> [ 3334.893452] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000=
00000000
> [ 3334.894030] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000=
00000000
> [ 3334.894607] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000000
> [ 3334.895181] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000=
00000000
> [ 3334.940770] BUG: kernel NULL pointer dereference, address: 0000000000=
000000
> [ 3334.942068] #PF: supervisor read access in kernel mode
> [ 3334.942907] #PF: error_code(0x0000) - not-present page
> [ 3334.943832] PGD 0 P4D 0
> [ 3334.944322] Oops: 0000 [#4] PREEMPT SMP
> [ 3334.944956] CPU: 3 PID: 12136 Comm: kworker/u8:13 Tainted: G      D W=
         5.14.0-rc7-default+ #1561
> [ 3334.946320] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [ 3334.949150] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
> [ 3334.950820] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrfs=
]
> [ 3334.956308] RSP: 0018:ffffa7c4456bfc20 EFLAGS: 00010293
> [ 3334.957453] RAX: 0000000000000000 RBX: 0000000000000fff RCX: 00000000=
00000000
> [ 3334.958890] RDX: 0000000000000b56 RSI: 0000000000007000 RDI: 00000000=
00000000
> [ 3334.960140] RBP: ffffa7c4456bfcc4 R08: 0000000000000b56 R09: ffff9f1d=
09658000
> [ 3334.961348] R10: ffff9f1d7de00000 R11: 0000000000000000 R12: ffff9f1d=
248aa000
> [ 3334.963742] R13: 0000000000000000 R14: ffffa7c4456bfcc4 R15: 00000000=
00000000
> [ 3334.969393] FS:  0000000000000000(0000) GS:ffff9f1d7dc00000(0000) knl=
GS:0000000000000000
> [ 3334.971288] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3334.973754] CR2: 0000000000000000 CR3: 00000000117ee006 CR4: 00000000=
00170ea0
> [ 3334.975493] Call Trace:
> [ 3334.976151]  lzo_compress_pages+0x182/0x320 [btrfs]
> [ 3334.977397]  btrfs_compress_pages+0xbc/0x130 [btrfs]
> [ 3334.978906]  compress_file_range+0x3ae/0x820 [btrfs]
> [ 3334.980271]  ? rcu_read_lock_sched_held+0x12/0x70
> [ 3334.981391]  ? submit_compressed_extents+0xc0/0xc0 [btrfs]
> [ 3334.982740]  async_cow_start+0x12/0x30 [btrfs]
> [ 3334.983962]  btrfs_work_helper+0xd6/0x1d0 [btrfs]
> [ 3334.986359]  process_one_work+0x262/0x5e0
> [ 3334.987320]  worker_thread+0x55/0x3c0
> [ 3334.988282]  ? process_one_work+0x5e0/0x5e0
> [ 3334.989283]  kthread+0x144/0x170
> [ 3334.990107]  ? set_kthread_struct+0x40/0x40
> [ 3334.991160]  ret_from_fork+0x1f/0x30
> [ 3334.992044] Modules linked in: dm_flakey dm_mod btrfs blake2b_generic=
 libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compr=
ess lzo_decompress raid6_pq loop
> [ 3334.995615] CR2: 0000000000000000
> [ 3334.996498] ---[ end trace f1f62e4293ace348 ]---
> [ 3334.997623] RIP: 0010:copy_compressed_data_to_page+0x1f7/0x2b0 [btrfs=
]
> [ 3335.003578] RSP: 0018:ffffa7c44a0c7c20 EFLAGS: 00010293
> [ 3335.004802] RAX: 0000000000000000 RBX: 0000000000000fff RCX: 00000000=
00000000
> [ 3335.006422] RDX: 0000000000000b3d RSI: 0000000000016000 RDI: 00000000=
00000000
> [ 3335.008009] RBP: ffffa7c44a0c7cc4 R08: 0000000000000b3d R09: ffff9f1d=
45f34000
> [ 3335.009396] R10: ffff9f1d7de00000 R11: 0000000000000000 R12: ffff9f1d=
5a812000
> [ 3335.010622] R13: 0000000000000000 R14: ffffa7c44a0c7cc4 R15: 00000000=
00000000
> [ 3335.011865] FS:  0000000000000000(0000) GS:ffff9f1d7dc00000(0000) knl=
GS:0000000000000000
> [ 3335.013416] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3335.014513] CR2: 0000000000000000 CR3: 00000000117ee006 CR4: 00000000=
00170ea0
>
