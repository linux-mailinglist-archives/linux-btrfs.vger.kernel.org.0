Return-Path: <linux-btrfs+bounces-22022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K+eBuKvoGnUlgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22022-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 21:41:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D831AF388
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 21:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 493BB3046A9D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB4A46AF0F;
	Thu, 26 Feb 2026 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Wzu63+BE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29546AF20
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138444; cv=none; b=p8UYkudE86mvATE1HMLcOB3gMatHIBmCDOwn0GQ3Z5I0MxHg+I7aMMR7hMCJ96G3mGq0x449tCxtfHoI2VWbQ/Wqlk2VCzWGIV9ZzjfYPSmsBn051dNMJ7+wLJeXmYMLlmI1JrXx1cHTXjVh7p4RY0Zh9KNWzz2SyFkrS/NLvF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138444; c=relaxed/simple;
	bh=4h3s3FLRCX/cTYHeWVaTlwbDfZSdBzHYTTiG5IBLUY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZWf6YkzoefDHkjnvHU/PBuOIEbxSRrHZN6gl/97c9UOjsMCxzNZmVW4a0ctnPooQ+Cq7fyaFWvvqJqIDlRJuJFbOe0HVhZBmsCF31FGhu4sxlYrQbzzUO5y+KvLrBHDLKpPzyUGGuc2+CzpVI+NRw4iAMOZmSElB+redUY+zpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Wzu63+BE; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772138439; x=1772743239; i=quwenruo.btrfs@gmx.com;
	bh=bBiFR5KTwS/hmUGz2ajn/tYr0zTh3/jUKzNZvpaKI/g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wzu63+BERIMBDC3hU/4W0BUJghcWo69Hz7VrmmZuT12FPYVzkm1Fov9fdLR6vXef
	 Rudaic32lWZqLia9VXVSoDn/C9Iv0P+6ShT5MRTdiSnGmEn28ed0rsgqXNNUNrGFo
	 LBBpdFlxBkeTv1eE8pQsXkIASEE0usMEYI3x7xOGJWVtqdkcDnTWAAJXooTmGbaSx
	 n/7UFyDssfXs1t0wODfeP87RKQRCVhr/scLyRUoJUhXhKyiTI/x40/YLdgtBW6za2
	 qQW1fq8xF7S/BRJ8wAI/LxQIWCCE6H1Ym0cD1DcpRqbzRmdRbCfZPDRAKD4nhFi3C
	 p58OOkRsK7O4LzJwZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbkp-1wKoCD1rMx-00QWRr; Thu, 26
 Feb 2026 21:40:39 +0100
Message-ID: <3abf7b28-7404-4e1d-93e4-490e610655fd@gmx.com>
Date: Fri, 27 Feb 2026 07:10:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] btrfs: fix transaction abort when snapshotting
 received subvolumes
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1772105193.git.fdmanana@suse.com>
 <b99cee6ce652b926463a080ef052a2e8e37bff33.1772105193.git.fdmanana@suse.com>
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
In-Reply-To: <b99cee6ce652b926463a080ef052a2e8e37bff33.1772105193.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bpOqRv5gpXM8wZ1v+7k1p2Y2hRDHrzfGCkb+lgZZcO2INQqQFSA
 twXLxAuxK8i0BzZMRZ86kf4aInO+oNYB1kCsFV15bBrcU9KwUfkfJ2S85J+EDOcr2AVfEMK
 3pQ86aoWNHBGw+XVt6hBeiD8/TnHxG6LYskg4JNgF6jocGOSFPLqlKg376RW8mCXYp8gtVs
 FycSfhDWRZmhwnb2i7RmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cooqE7ffyYs=;pVAMoiKoyscHmscG1T32NWAiQSf
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22022-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmx.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 46D831AF388
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/27 01:03, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Currently a user can trigger a transaction abort by snapshotting a
> previously received snapshot a bunch of times until we reach a
> BTRFS_UUID_KEY_RECEIVED_SUBVOL item overflow (the maximum item size we
> can store in a leaf). This is very likely not common in practice, but
> if it happens, it turns the filesystem into RO mode. The snapshot, send
> and set_received_subvol and subvol_setflags (used by receive) don't
> require CAP_SYS_ADMIN, just inode_owner_or_capable(). A malicious user
> could use this to turn a filesystem into RO mode and disrupt a system.
>=20
> Reproducer script:
>=20
>    $ cat test.sh
>    #!/bin/bash
>=20
>    DEV=3D/dev/sdi
>    MNT=3D/mnt/sdi
>=20
>    # Use smallest node size to make the test faster.
>    mkfs.btrfs -f --nodesize 4K $DEV
>    mount $DEV $MNT
>=20
>    # Create a subvolume and set it to RO so that it can be used for send=
.
>    btrfs subvolume create $MNT/sv
>    touch $MNT/sv/foo
>    btrfs property set $MNT/sv ro true
>=20
>    # Send and receive the subvolume into snaps/sv.
>    mkdir $MNT/snaps
>    btrfs send $MNT/sv | btrfs receive $MNT/snaps
>=20
>    # Now snapshot the received subvolume, which has a received_uuid, a
>    # lot of times to trigger the leaf overflow.
>    total=3D500
>    for ((i =3D 1; i <=3D $total; i++)); do
>        echo -ne "\rCreating snapshot $i/$total"
>        btrfs subvolume snapshot -r $MNT/snaps/sv $MNT/snaps/sv_$i > /dev=
/null
>    done
>    echo
>=20
>    umount $MNT
>=20
> When running the test:
>=20
>    $ ./test.sh
>    (...)
>    Create subvolume '/mnt/sdi/sv'
>    At subvol /mnt/sdi/sv
>    At subvol sv
>    Creating snapshot 496/500ERROR: Could not create subvolume: Value too=
 large for defined data type
>    Creating snapshot 497/500ERROR: Could not create subvolume: Read-only=
 file system
>    Creating snapshot 498/500ERROR: Could not create subvolume: Read-only=
 file system
>    Creating snapshot 499/500ERROR: Could not create subvolume: Read-only=
 file system
>    Creating snapshot 500/500ERROR: Could not create subvolume: Read-only=
 file system
>=20
> And in dmesg/syslog:
>=20
>    $ dmesg
>    (...)
>    [251067.627338] BTRFS warning (device sdi): insert uuid item failed -=
75 (0x4628b21c4ac8d898, 0x2598bee2b1515c91) type 252!
>    [251067.629212] ------------[ cut here ]------------
>    [251067.630033] BTRFS: Transaction aborted (error -75)
>    [251067.630871] WARNING: fs/btrfs/transaction.c:1907 at create_pendin=
g_snapshot.cold+0x52/0x465 [btrfs], CPU#10: btrfs/615235
>    [251067.632851] Modules linked in: btrfs dm_zero (...)
>    [251067.644071] CPU: 10 UID: 0 PID: 615235 Comm: btrfs Tainted: G    =
    W           6.19.0-rc8-btrfs-next-225+ #1 PREEMPT(full)
>    [251067.646165] Tainted: [W]=3DWARN
>    [251067.646733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)=
, BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>    [251067.648735] RIP: 0010:create_pending_snapshot.cold+0x55/0x465 [bt=
rfs]
>    [251067.649984] Code: f0 48 0f (...)
>    [251067.653313] RSP: 0018:ffffce644908fae8 EFLAGS: 00010292
>    [251067.653987] RAX: 00000000ffffff01 RBX: ffff8e5639e63a80 RCX: 0000=
0000ffffffd3
>    [251067.655042] RDX: ffff8e53faa76b00 RSI: 00000000ffffffb5 RDI: ffff=
ffffc0919750
>    [251067.656077] RBP: ffffce644908fbd8 R08: 0000000000000000 R09: ffff=
ce644908f820
>    [251067.657068] R10: ffff8e5adc1fffa8 R11: 0000000000000003 R12: ffff=
8e53c0431bd0
>    [251067.658050] R13: ffff8e5414593600 R14: ffff8e55efafd000 R15: 0000=
0000ffffffb5
>    [251067.659019] FS:  00007f2a4944b3c0(0000) GS:ffff8e5b27dae000(0000)=
 knlGS:0000000000000000
>    [251067.660115] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [251067.660943] CR2: 00007ffc5aa57898 CR3: 00000005813a2003 CR4: 0000=
000000370ef0
>    [251067.661972] Call Trace:
>    [251067.662292]  <TASK>
>    [251067.662653]  create_pending_snapshots+0x97/0xc0 [btrfs]
>    [251067.663413]  btrfs_commit_transaction+0x26e/0xc00 [btrfs]
>    [251067.664257]  ? btrfs_qgroup_convert_reserved_meta+0x35/0x390 [btr=
fs]
>    [251067.665238]  ? _raw_spin_unlock+0x15/0x30
>    [251067.665837]  ? record_root_in_trans+0xa2/0xd0 [btrfs]
>    [251067.666531]  btrfs_mksubvol+0x330/0x580 [btrfs]
>    [251067.667145]  btrfs_mksnapshot+0x74/0xa0 [btrfs]
>    [251067.667827]  __btrfs_ioctl_snap_create+0x194/0x1d0 [btrfs]
>    [251067.668595]  btrfs_ioctl_snap_create_v2+0x107/0x130 [btrfs]
>    [251067.669479]  btrfs_ioctl+0x1580/0x2690 [btrfs]
>    [251067.670093]  ? count_memcg_events+0x6d/0x180
>    [251067.670849]  ? handle_mm_fault+0x1a0/0x2a0
>    [251067.671652]  __x64_sys_ioctl+0x92/0xe0
>    [251067.672406]  do_syscall_64+0x50/0xf20
>    [251067.673129]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    [251067.674096] RIP: 0033:0x7f2a495648db
>    [251067.674812] Code: 00 48 89 (...)
>    [251067.678227] RSP: 002b:00007ffc5aa57840 EFLAGS: 00000246 ORIG_RAX:=
 0000000000000010
>    [251067.679691] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000=
7f2a495648db
>    [251067.681145] RDX: 00007ffc5aa588b0 RSI: 0000000050009417 RDI: 0000=
000000000004
>    [251067.682511] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000=
000000000000
>    [251067.683842] R10: 000000000000000a R11: 0000000000000246 R12: 0000=
7ffc5aa59910
>    [251067.685176] R13: 00007ffc5aa588b0 R14: 0000000000000004 R15: 0000=
000000000006
>    [251067.686524]  </TASK>
>    [251067.686972] ---[ end trace 0000000000000000 ]---
>    [251067.687890] BTRFS: error (device sdi state A) in create_pending_s=
napshot:1907: errno=3D-75 unknown
>    [251067.689049] BTRFS info (device sdi state EA): forced readonly
>    [251067.689054] BTRFS warning (device sdi state EA): Skipping commit =
of aborted transaction.
>    [251067.690119] BTRFS: error (device sdi state EA) in cleanup_transac=
tion:2043: errno=3D-75 unknown
>    [251067.702028] BTRFS info (device sdi state EA): last unmount of fil=
esystem 46dc3975-30a2-4a69-a18f-418b859cccda
>=20
> Fix this by ignoring -EOVERFLOW errors from btrfs_uuid_tree_add() in the
> snapshot creation code when attempting to add the
> BTRFS_UUID_KEY_RECEIVED_SUBVOL item. This is ok because it's not critica=
l
> and we are still able to delete the snapshot, as snapshot/subvolume
> deletion ignores if a BTRFS_UUID_KEY_RECEIVED_SUBVOL is missing (see
> inode.c:btrfs_delete_subvolume()). As for send/receive, we can still do
> send/receive operations since it always peeks the first root ID in the
> existing BTRFS_UUID_KEY_RECEIVED_SUBVOL (it could peek any since all
> snapshots have the same content), and even if the key is missing, it
> fallsback to searching by BTRFS_UUID_KEY_SUBVOL key.
>=20
> A test case for fstests will be sent soon.
>=20
> Fixes: dd5f9615fc5c ("Btrfs: maintain subvolume items in the UUID tree")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/transaction.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>=20
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 3112bd5520b7..1a0daf2c68fb 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1902,6 +1902,22 @@ static noinline int create_pending_snapshot(struc=
t btrfs_trans_handle *trans,
>   		ret =3D btrfs_uuid_tree_add(trans, new_root_item->received_uuid,
>   					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
>   					  objectid);

I'm just checking all other btrfs_uuid_tree_add() callsites, and=20
wondering if other call sites are also affected:

- _btrfs_ioctl_set_received_subvol()

   Would this be affected too?

Thanks,
Qu

> +		/*
> +		 * We are creating of lot of snapshots of the same root that was
> +		 * received (has a received UUID) and reached a leaf's limit for
> +		 * an item. We can safefly ignore this and avoid a transaction
> +		 * abort. A deletion of this snapshot will still work since we
> +		 * ignore if an item with a BTRFS_UUID_KEY_RECEIVED_SUBVOL key
> +		 * is missing (see btrfs_delete_subvolume()). Send/receive will
> +		 * work too since it peeks the first root id from the existing
> +		 * item (it could peek any), and in case it's missing it
> +		 * falls back to search by BTRFS_UUID_KEY_SUBVOL keys.
> +		 * Creation of a snapshot does not require CAP_SYS_ADMIN, so
> +		 * we don't want users triggering transaction aborts, either
> +		 * intentionally or not.
> +		 */
> +		if (ret =3D=3D -EOVERFLOW)
> +			ret =3D 0;
>   		if (unlikely(ret && ret !=3D -EEXIST)) {
>   			btrfs_abort_transaction(trans, ret);
>   			goto fail;


