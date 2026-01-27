Return-Path: <linux-btrfs+bounces-21118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM8VNlHZeGmwtgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21118-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 16:27:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A45F96AC4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 16:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A20DF309B6E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A735D61D;
	Tue, 27 Jan 2026 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouW/+1Yy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED235CBCB
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526981; cv=none; b=D9JX0sdV5Cau2P0o2Eba0iYMl3BMUpceUP8VCn5mFhrXt+7dwdoSgV4jmbvZUsCPRsW1UWBfi1Nfuq0GrA1iZRohTLHrr/9Mi/1LB0GuQuerCJ+B364Hzvrt149u3fjvF0T8jI9ZoTlBvlVFTCsW0U8ED9DVmTbCas9E5xQnYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526981; c=relaxed/simple;
	bh=KehIpJYrVYOMnGrF1rvIXwfNj/idiL18FoUh6S0XvN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8ItFVU7N8GtgJinU9lK6WIpYH/1fiPOcl7cSTZV3ylTRBduLd7JMle7S+VQ1Owg32RDT2rEBsEft2z5qRBUv1A7tL/dLUsRMkkUm4TJ4aT401/CwfpxPMA1CYOcj4/8s02z+JGbi86kvkZ1/E9K2iZVQq5YRVpfCdY+vW2AR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouW/+1Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF57CC116C6
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769526980;
	bh=KehIpJYrVYOMnGrF1rvIXwfNj/idiL18FoUh6S0XvN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ouW/+1Yyo5trAA78RfzPvkr1ihMRFk7Gub7N1EMLP46PyCEfYWt2GAlq9BJr20RLk
	 AW6ck1zjimDfKhxSW1qHHuqHd6lWYJ+3LHtVCFJOHtC2TJ2hD87Nr1UQftUewz53l4
	 02w6Y4DHJIKwJZFAE6zn5BXFHHblvhfv77HykyZbiV1NsfwMlJsMlGU4Fq0sCi+C+O
	 bIRX6qPcjneOvoVpVkqN53fABJOG3gCvaVnszR1i+n8jUhgnJgS0wPv1IWS9O5nmxD
	 8u+UaACkFhMIKIZsbo1NoNgkf6lAC0LIh08PiOptO1+ckt1S52nRpOtCX84qkgC067
	 NikKq8IRWxAeQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b88455e6663so878551366b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 07:16:20 -0800 (PST)
X-Gm-Message-State: AOJu0YzQ9SsSDpyRXNCA4l1i6bx5N9W/rf2A52ogMxOmqhd4EF5MOYt+
	rI6/dUniY7poMYKmRcpi1s7nUfy/g+3ifRD5qNJv06MwWpQyktByBfPvLvPDYCGEQTT9TANSvS6
	9Tr+p01XjAQ9Ly/FdQ5vX6mUtbTz1Wuc=
X-Received: by 2002:a17:907:944e:b0:b83:37eb:34f8 with SMTP id
 a640c23a62f3a-b8dab345a05mr177116366b.35.1769526979424; Tue, 27 Jan 2026
 07:16:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3fd15bae79aae6bb366ecffced32775e8cb4f55a.1769468599.git.boris@bur.io>
In-Reply-To: <3fd15bae79aae6bb366ecffced32775e8cb4f55a.1769468599.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 27 Jan 2026 15:15:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7SoLUDhUcQN=nvhKppb3eYWGCcLaa-Tg401DrVRMHQHA@mail.gmail.com>
X-Gm-Features: AZwV_Qg7a64Ufz0lNDYOu1gT6cjaGQdaPaKhZucKvJYkN8J9qWQPB4d8rskoeGw
Message-ID: <CAL3q7H7SoLUDhUcQN=nvhKppb3eYWGCcLaa-Tg401DrVRMHQHA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix block_group_tree dirty_list corruption
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21118-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 6A45F96AC4
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 11:05=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> When the incompat flag EXTENT_TREE_V2 is set, we unconditionally add the
> block group tree to the switch_commits list before calling
> switch_commit_roots, as we do for the tree root and the chunk root.
> However, the block group tree uses normal root dirty tracking and in any
> transaction that does an allocation and dirties a block group, the block
> group root will already be linked to a list by the dirty_list field and
> this use of list_add_tail() is invalid and corrupts the prev/next
> members of block_group_root->dirty_list.
>
> This is apparent on a subsequent list_del on the prev if we enable
> CONFIG_DEBUG_LIST:
> [   32.157161] ------------[ cut here ]------------
> [   32.157298] list_del corruption. next->prev should be
> ffff958890202538, but was ffff9588992bd538. (next=3Dffff958890201538)
> [   32.157538] WARNING: lib/list_debug.c:65 at 0x0, CPU#3: sync/607
> [   32.157712] Modules linked in: btrfs libblake2b xor zlib_deflate
> zstd_compress raid6_pq xfs ahci libahci libata virtio_scsi scsi_mod nvme
> virtio_net net_failover bsg nvme_core failover scsi_common evdev
> sch_fq_codel loop dm_mod configfs nfnetlink bpf_preload dmi_sysfs
> qemu_fw_cfg vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common
> vsock virtio_rng rng_core ipv6 crc_ccitt autofs4
> [   32.158368] CPU: 3 UID: 0 PID: 607 Comm: sync Not tainted 6.18.0 #24
> PREEMPT(none)
> [   32.158527] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.17.0-4.fc41 04/01/2014
> [   32.158708] RIP: 0010:__list_del_entry_valid_or_report+0x108/0x120
> [   32.158870] Code: e9 48 89 ee 67 48 0f b9 3a 31 c0 e9 67 ff ff ff 4c
> 89 e7 e8 3a fb c5 ff 48 8d 3d 03 f8 10 01 49 8b 54 24 08 4c 89 e1 48 89
> ee <67> 48 0f b9 3a 31 c0 e9 41 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00
> [   32.159309] RSP: 0018:ffffaa288287fdd0 EFLAGS: 00010202
> [   32.159430] RAX: 0000000000000001 RBX: ffff95889326e800 RCX:
> ffff958890201538
> [   32.159609] RDX: ffff9588992bd538 RSI: ffff958890202538 RDI:
> ffffffff82a41e00
> [   32.159781] RBP: ffff958890202538 R08: ffffffff828fc1e8 R09:
> 00000000ffffefff
> [   32.159973] R10: ffffffff8288c200 R11: ffffffff828e4200 R12:
> ffff958890201538
> [   32.160153] R13: ffff95889326e958 R14: ffff958895c24000 R15:
> ffff958890202538
> [   32.160355] FS:  00007f0c28eb5740(0000) GS:ffff958af2bd2000(0000)
> knlGS:0000000000000000
> [   32.160574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   32.160723] CR2: 00007f0c28e8a3cc CR3: 0000000109942005 CR4:
> 0000000000370ef0
> [   32.160967] Call Trace:
> [   32.161054]  <TASK>
> [   32.161119]  switch_commit_roots+0x82/0x1d0 [btrfs]
> [   32.161521]  btrfs_commit_transaction+0x968/0x1550 [btrfs]
> [   32.161803]  ? btrfs_attach_transaction_barrier+0x23/0x60 [btrfs]
> [   32.162114]  __iterate_supers+0xe8/0x190
> [   32.162217]  ? __pfx_sync_fs_one_sb+0x10/0x10
> [   32.162342]  ksys_sync+0x63/0xb0
> [   32.162443]  __do_sys_sync+0xe/0x20
> [   32.162535]  do_syscall_64+0x73/0x450
> [   32.162641]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   32.162760] RIP: 0033:0x7f0c28d05d2b
> [   32.162881] Code: c3 66 0f 1f 44 00 00 48 8b 15 e9 40 0f 00 f7 d8 64
> 89 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 f3 0f 1e fa b8 a2 00 00 00 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bd 40 0f 00 f7 d8 64 89 01 48
> [   32.163278] RSP: 002b:00007ffc9d988048 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a2
> [   32.163452] RAX: ffffffffffffffda RBX: 00007ffc9d988228 RCX:
> 00007f0c28d05d2b
> [   32.163614] RDX: 00007f0c28e02301 RSI: 00007ffc9d989b21 RDI:
> 00007f0c28dba90d
> [   32.163780] RBP: 0000000000000001 R08: 0000000000000001 R09:
> 0000000000000000
> [   32.163954] R10: 0000000000000000 R11: 0000000000000246 R12:
> 000055b96572cb80
> [   32.164111] R13: 000055b96572b19f R14: 00007f0c28dfa434 R15:
> 000055b96572b034
> [   32.164337]  </TASK>
> [   32.164404] irq event stamp: 0
> [   32.164490] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [   32.164649] hardirqs last disabled at (0): [<ffffffff81298817>]
> copy_process+0xb37/0x2260
> [   32.164809] softirqs last  enabled at (0): [<ffffffff81298817>]
> copy_process+0xb37/0x2260
> [   32.165029] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   32.165222] ---[ end trace 0000000000000000 ]---
>
> Furthermore, this list corruption eventually (when we happen to add a
> new block group) results in getting the switch_commits and
> dirty_cowonly_roots lists mixed up and attempting to call update_root
> on the tree root which can't be found in the tree root, resulting in a
> transaction abort:
>
> [   87.826960] BTRFS critical (device nvme1n1): unable to find root key (=
1 0 0) in tree 1
> [   87.827271] ------------[ cut here ]------------
> [   87.827418] BTRFS: Transaction aborted (error -117)
> [   87.827540] WARNING: fs/btrfs/root-tree.c:153 at 0x0, CPU#4: sync/703
> [   87.827722] Modules linked in: btrfs libblake2b xor zlib_deflate zstd_=
compress raid6_pq xfs ahci libahci libata virtio_scsi scsi_mod nvme nvme_co=
re virtio_net bsg net_failover scsi_common failover evdev sch_fq_codel loop=
 dm_mod configfs nfnetlink bpf_preload dmi_sysfs qemu_fw_cfg vmw_vsock_virt=
io_transport vmw_vsock_virtio_transport_common vsock virtio_rng rng_core ip=
v6 crc_ccitt autofs4
> [   87.828568] CPU: 4 UID: 0 PID: 703 Comm: sync Not tainted 6.18.0 #25 P=
REEMPT(none)
> [   87.828760] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.17.0-4.fc41 04/01/2014
> [   87.828974] RIP: 0010:btrfs_update_root+0x296/0x790 [btrfs]
> [   87.829218] Code: 99 00 00 00 48 c7 c6 10 5d e0 c0 4c 89 ef e8 81 7c 0=
1 00 41 bc 8b ff ff ff e9 1a ff ff ff 48 8d 3d ff e9 ee ff be 8b ff ff ff <=
67> 48 0f b9 3a 41 b8 01 00 00 00 eb c3 e8 f8 c6 b4 d8 84 c0 75 8a
> [   87.829583] RSP: 0018:ffffa58d035dfd60 EFLAGS: 00010282
> [   87.829704] RAX: ffff9a59126ddb68 RBX: ffff9a59126dc000 RCX: 000000000=
0000000
> [   87.829958] RDX: 0000000000000000 RSI: 00000000ffffff8b RDI: ffffffffc=
0b28270
> [   87.830168] RBP: ffff9a5904aec000 R08: 0000000000000000 R09: 00000000f=
fffefff
> [   87.830324] R10: ffffffff9ac8c200 R11: ffffffff9ace4200 R12: 000000000=
0000001
> [   87.830550] R13: ffff9a59041740e8 R14: ffff9a5904aec1f7 R15: ffff9a590=
fdefaf0
> [   87.830750] FS:  00007f54cde6b740(0000) GS:ffff9a5b5a81c000(0000) knlG=
S:0000000000000000
> [   87.830924] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   87.831078] CR2: 00007f54cde403cc CR3: 0000000112902004 CR4: 000000000=
0370ef0
> [   87.831274] Call Trace:
> [   87.831370]  <TASK>
> [   87.831466]  ? _raw_spin_unlock+0x23/0x40
> [   87.831575]  commit_cowonly_roots+0x1ad/0x250 [btrfs]
> [   87.831787]  ? btrfs_commit_transaction+0x79b/0x1560 [btrfs]
> [   87.832016]  btrfs_commit_transaction+0x8aa/0x1560 [btrfs]
> [   87.832258]  ? btrfs_attach_transaction_barrier+0x23/0x60 [btrfs]
> [   87.832523]  __iterate_supers+0xf1/0x170
> [   87.832621]  ? __pfx_sync_fs_one_sb+0x10/0x10
> [   87.832736]  ksys_sync+0x63/0xb0
> [   87.832835]  __do_sys_sync+0xe/0x20
> [   87.832940]  do_syscall_64+0x73/0x450
> [   87.833035]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   87.833174] RIP: 0033:0x7f54cdd05d2b
> [   87.833277] Code: c3 66 0f 1f 44 00 00 48 8b 15 e9 40 0f 00 f7 d8 64 8=
9 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 f3 0f 1e fa b8 a2 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bd 40 0f 00 f7 d8 64 89 01 48
> [   87.833697] RSP: 002b:00007fff1b58ff78 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000a2
> [   87.833896] RAX: ffffffffffffffda RBX: 00007fff1b590158 RCX: 00007f54c=
dd05d2b
> [   87.834072] RDX: 00007f54cde02301 RSI: 00007fff1b592b66 RDI: 00007f54c=
ddba90d
> [   87.834272] RBP: 0000000000000001 R08: 0000000000000001 R09: 000000000=
0000000
> [   87.834478] R10: 0000000000000000 R11: 0000000000000246 R12: 000055e07=
ca96b80
> [   87.834646] R13: 000055e07ca9519f R14: 00007f54cddfa434 R15: 000055e07=
ca95034
> [   87.834849]  </TASK>
> [   87.834894] irq event stamp: 0
> [   87.834997] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [   87.835165] hardirqs last disabled at (0): [<ffffffff99698797>] copy_p=
rocess+0xb37/0x21e0
> [   87.835338] softirqs last  enabled at (0): [<ffffffff99698797>] copy_p=
rocess+0xb37/0x21e0
> [   87.835557] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   87.835709] ---[ end trace 0000000000000000 ]---
> [   87.835824] BTRFS: error (device nvme1n1 state A) in btrfs_update_root=
:153: errno=3D-117 Filesystem corrupted
> [   87.836040] BTRFS info (device nvme1n1 state EA): forced readonly
> [   87.836221] BTRFS warning (device nvme1n1 state EA): Skipping commit o=
f aborted transaction.
> [   87.836437] BTRFS: error (device nvme1n1 state EA) in cleanup_transact=
ion:2037: errno=3D-117 Filesystem corrupted
>
> Since the block group tree was pulled out of the extent tree and uses
> normal root dirty tracking, remove the offending extra list_add. This
> fixes the list corruption and the resulting fs corruption.
>
> Fixes: f7238e5094048 ("btrfs: add support for multiple global roots")

That's the commit that introduced the code this patch is removing,
sure, but back then things were fine because the block group root was
not getting the flag BTRFS_ROOT_TRACK_DIRTY set.

The correct commit should be the one that adds that flag to the block
group root without removing the code that is being removed in this
patch, which is:

14033b08a02916 ("btrfs: don't save block group root into super block")

> Signed-off-by: Boris Burkov <boris@bur.io>

With the Fixes tag updated:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.



> ---
>  fs/btrfs/transaction.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 8aa55cd8a0bf..0b2498749b1e 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2508,13 +2508,6 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
>         list_add_tail(&fs_info->chunk_root->dirty_list,
>                       &cur_trans->switch_commits);
>
> -       if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> -               btrfs_set_root_node(&fs_info->block_group_root->root_item=
,
> -                                   fs_info->block_group_root->node);
> -               list_add_tail(&fs_info->block_group_root->dirty_list,
> -                             &cur_trans->switch_commits);
> -       }
> -
>         switch_commit_roots(trans);
>
>         ASSERT(list_empty(&cur_trans->dirty_bgs));
> --
> 2.52.0
>
>

