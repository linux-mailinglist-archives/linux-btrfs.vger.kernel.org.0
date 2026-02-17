Return-Path: <linux-btrfs+bounces-21737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBdKC5f0lGlzJQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21737-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 00:07:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DEA151B38
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 00:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ABB83048078
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 23:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14313306D40;
	Tue, 17 Feb 2026 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cKAeXZwU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCBC288515
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369615; cv=none; b=FJkSNPrtPbNCRZbnI5CahnYCG1FMEvAHbWEy88jptgrDot27Y9l45deXe23jaLg9yt6NquM6+Vu4xEWSU8hhNNy0DGxp59mihhcqgua5cF1VLfxf8F4/3pun2kAFwrV678565VubL0iCjzUkji76EF7qd2rvr5pWBzQZ2/b2aDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369615; c=relaxed/simple;
	bh=ED/LuIFD01KHGCzqot5S/tSPW2DxXws7Wwz2v+vb+DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o/6ta+Xzw2iSsBuFbz3XdswoOcoBDJ2Hr+wvz0y30T/JlCDh7mHuZJpWfQiD0aRKys0MnIlGVrWAOlz0SuFJeCbIQeiC0yoYiKO0Zwsa0ffmh7hGU9wwNik/me8gyhX4jZiJuqmzqv/Xbd27U9W/vbtfdBc8Jbvc/QYzIPOoNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cKAeXZwU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771369611; x=1771974411; i=quwenruo.btrfs@gmx.com;
	bh=BYMMA3+xLqVuNuI0uQGoYzEH42Pqrwv93NSZok4igDs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cKAeXZwU+f4Oq1BUz3iSDy3S3F29TvW3N+kCpfby1WNbMEWPIjKzQSqGvmhxuAsE
	 MHbnB6AIvYQUOasn5BNAWq2HxvyN49gBWauzDk+E1/sxaPFKbFL5UgvRJaO7Ij92Y
	 VDGxiccgEp79H8rck7Qu5HRsWG2C70oVSq9G/0zXvgKTvOAcEqYyuz8571r32roul
	 3WFcUxi9Ld5cDLHKuAiGn/r0b/MAqbcKWUZwOuKRnHONcEHj6Qjtywd+shhe46gi4
	 Zgq/YlWhBFAb/Vqx1QHYjxnOjrnKyuEpEpFiiMkuNnKbM2Mur6m3lBBdNUm2i4oiW
	 gTFvA4Fg6kBUja+35Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1psI-1vuh4k2i5o-009IHn; Wed, 18
 Feb 2026 00:06:51 +0100
Message-ID: <8f21282d-eabe-4784-8417-6a97c3ea282b@gmx.com>
Date: Wed, 18 Feb 2026 09:36:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reserve transaction space for qgroup ioctls
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <6b9fa2e018d777f48b3d6ed4b8160d932616297b.1771002477.git.fdmanana@suse.com>
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
In-Reply-To: <6b9fa2e018d777f48b3d6ed4b8160d932616297b.1771002477.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u/PVY4iFgnzUUZ2MckyTtM86uPu08HLamy1NrZCwHLlI7TyTvDC
 nUUjcJPad9vYCkV9CMbyWExJ510OeEfegeGqjMguCB1Sbx/uEBdAT0nfZrqCnwtIhbyRHOT
 COA9b7AxJ2un1fxb/SEPfJA0G9q0Us9D0gjZIzeoPbM+xjZhMaSZs0++90DGPwmJrOPmYdg
 BR6oASI/fC1Ry4E2exQcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C0cM8GXLE2c=;qv+HSTlU3pkLQBr05g0/rptZkr5
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[test.sh:url];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_ANON_DOMAIN(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21737-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_ALLOW(0.00)[gmx.com:s=s31663417];
	DMARC_POLICY_ALLOW(0.00)[gmx.com,quarantine];
	DKIM_TRACE(0.00)[gmx.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qemu.org:url,test.sh:url,gmx.com:mid,gmx.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 93DEA151B38
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/18 05:05, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Currently our qgroup ioctls don't reserve any space, they just do a
> transaction join, which does not reserve any space, neither for the quot=
a
> tree updates nor for the delayed refs generated when updating the quota
> tree. The quota root uses the global block reserve, which is fine most o=
f
> the time since we don't expect a lot of updates to the quota root, or to
> be too close to -ENOSPC such that other critical metadata updates need t=
o
> resort to the global reserve.
>=20
> However this is not optimal, as not reserving proper space may result in=
 a
> transaction abort due to not reserving space for delayed refs and then
> abusing the use of the global block reserve.
>=20
> For example, the following reproducer (which is unlikely to model any
> real world use case, but just to illustrate the problem), triggers such =
a
> transaction abort due to -ENOSPC when running delayed refs:
>=20
>    $ cat test.sh
>    #!/bin/bash
>=20
>    DEV=3D/dev/nullb0
>    MNT=3D/mnt/nullb0
>=20
>    umount $DEV &> /dev/null
>    # Limit device to 1G so that it's much faster to reproduce the issue.
>    mkfs.btrfs -f -b 1G $DEV
>    mount -o commit=3D600 $DEV $MNT
>=20
>    fallocate -l 800M $MNT/filler
>    btrfs quota enable $MNT
>=20
>    for ((i =3D 1; i <=3D 400000; i++)); do
>        btrfs qgroup create 1/$i $MNT
>    done
>=20
>    umount $MNT
>=20
> When running this, we can see in dmesg/syslog that a transaction abort
> happened:
>=20
>    [160436.490890] BTRFS error (device nullb0): failed to run delayed re=
f for logical 30408704 num_bytes 16384 type 176 action 1 ref_mod 1: -28
>    [160436.493276] ------------[ cut here ]------------
>    [160436.494166] BTRFS: Transaction aborted (error -28)
>    [160436.495088] WARNING: fs/btrfs/extent-tree.c:2247 at btrfs_run_del=
ayed_refs+0xd9/0x110 [btrfs], CPU#4: umount/2495372
>    [160436.497219] Modules linked in: btrfs loop (...)
>    [160436.508357] CPU: 4 UID: 0 PID: 2495372 Comm: umount Tainted: G   =
     W           6.19.0-rc8-btrfs-next-225+ #1 PREEMPT(full)
>    [160436.510497] Tainted: [W]=3DWARN
>    [160436.511085] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)=
, BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>    [160436.513260] RIP: 0010:btrfs_run_delayed_refs+0xdf/0x110 [btrfs]
>    [160436.514515] Code: 0f 82 ea (...)
>    [160436.518476] RSP: 0018:ffffd511850b7d78 EFLAGS: 00010292
>    [160436.519544] RAX: 00000000ffffffe4 RBX: ffff8f120dad37e0 RCX: 0000=
000002040001
>    [160436.520893] RDX: 0000000000000002 RSI: 00000000ffffffe4 RDI: ffff=
ffffc090fd80
>    [160436.522245] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff=
ffffc04d1867
>    [160436.523612] R10: ffff8f18dc1fffa8 R11: 0000000000000003 R12: ffff=
8f173aa89400
>    [160436.524960] R13: 0000000000000000 R14: ffff8f173aa89400 R15: 0000=
000000000000
>    [160436.526289] FS:  00007fe59045d840(0000) GS:ffff8f192e22e000(0000)=
 knlGS:0000000000000000
>    [160436.527812] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [160436.528868] CR2: 00007fe5905ff2b0 CR3: 000000060710a002 CR4: 0000=
000000370ef0
>    [160436.530096] Call Trace:
>    [160436.530527]  <TASK>
>    [160436.530916]  btrfs_commit_transaction+0x73/0xc00 [btrfs]
>    [160436.531753]  ? btrfs_attach_transaction_barrier+0x1e/0x70 [btrfs]
>    [160436.532557]  sync_filesystem+0x7a/0x90
>    [160436.533025]  generic_shutdown_super+0x28/0x180
>    [160436.533584]  kill_anon_super+0x12/0x40
>    [160436.534083]  btrfs_kill_super+0x12/0x20 [btrfs]
>    [160436.534560]  deactivate_locked_super+0x2f/0xb0
>    [160436.534983]  cleanup_mnt+0xea/0x180
>    [160436.535388]  task_work_run+0x58/0xa0
>    [160436.535804]  exit_to_user_mode_loop+0xed/0x480
>    [160436.536308]  ? __x64_sys_umount+0x68/0x80
>    [160436.536764]  do_syscall_64+0x2a5/0xf20
>    [160436.537196]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    [160436.537780] RIP: 0033:0x7fe5906b6217
>    [160436.538192] Code: 0d 00 f7 (...)
>    [160436.540303] RSP: 002b:00007ffcd87a61f8 EFLAGS: 00000246 ORIG_RAX:=
 00000000000000a6
>    [160436.541133] RAX: 0000000000000000 RBX: 00005618b9ecadc8 RCX: 0000=
7fe5906b6217
>    [160436.541886] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000=
5618b9ecb100
>    [160436.542704] RBP: 0000000000000000 R08: 00007ffcd87a4fe0 R09: 0000=
0000ffffffff
>    [160436.544022] R10: 0000000000000103 R11: 0000000000000246 R12: 0000=
7fe59081626c
>    [160436.544950] R13: 00005618b9ecb100 R14: 0000000000000000 R15: 0000=
5618b9ecacc0
>    [160436.545729]  </TASK>
>    [160436.545988] ---[ end trace 0000000000000000 ]---
>=20
> Fix this by changing the qgroup ioctls to use start transaction instead =
of
> joining so that proper space is reserved for the delayed refs generated
> for the updates to the quota root. This way we don't get any transaction
> abort.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ioctl.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 38d93dae71ca..9fa4eca4c788 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3680,7 +3680,8 @@ static long btrfs_ioctl_qgroup_assign(struct file =
*file, void __user *arg)
>   		}
>   	}
>  =20
> -	trans =3D btrfs_join_transaction(root);
> +	/* 2 BTRFS_QGROUP_RELATION_KEY items. */
> +	trans =3D btrfs_start_transaction(root, 2);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
>   		goto out;
> @@ -3752,7 +3753,11 @@ static long btrfs_ioctl_qgroup_create(struct file=
 *file, void __user *arg)
>   		goto out;
>   	}
>  =20
> -	trans =3D btrfs_join_transaction(root);
> +	/*
> +	 * 1 BTRFS_QGROUP_INFO_KEY item.
> +	 * 1 BTRFS_QGROUP_LIMIT_KEY item.
> +	 */
> +	trans =3D btrfs_start_transaction(root, 2);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
>   		goto out;
> @@ -3801,7 +3806,8 @@ static long btrfs_ioctl_qgroup_limit(struct file *=
file, void __user *arg)
>   		goto drop_write;
>   	}
>  =20
> -	trans =3D btrfs_join_transaction(root);
> +	/* 1 BTRFS_QGROUP_LIMIT_KEY item. */
> +	trans =3D btrfs_start_transaction(root, 1);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
>   		goto out;


