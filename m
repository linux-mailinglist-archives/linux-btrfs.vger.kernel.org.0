Return-Path: <linux-btrfs+bounces-21847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPPiOrp8nGm6IQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21847-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 17:13:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BE51797B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58B783091961
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215C930B520;
	Mon, 23 Feb 2026 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca+7YUuO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD1309F00
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862621; cv=pass; b=WpqTa2e6SteLu4rMZlfXtKG65azwgcHmMYzQCx+470LEe0TzaEKY894aV47r4klTRAyhYJ3bqK9q41KHNR4864bBVCjyW8nV9vlAP9VFsu9PMLs6nlSC1YtLI+AKyNqndeVzMvo9r/zlpiV7Lw/QkDrOXEZ3WOQ4e1HhvsnMcnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862621; c=relaxed/simple;
	bh=ln/VgYPpdGtlm7lD6cXX1V/Z9Oa6PZx9cpmblHlnPmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRDVIl5HJAC3IenXC+MEIDcmcsA/cDGXbckGkENSjLkYtq4mp3MNTTTWEngRpVbNIrCttqlx+nnQa8W+7ucudu4UVVLNQApzK1yKDl26cuKBThW4zy/v5b6ibq5+349RMkSLa18wZhc7igrIQD18vwt8UifuRV5xOKW+hc83otY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca+7YUuO; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a79998d35aso27962835ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 08:03:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771862619; cv=none;
        d=google.com; s=arc-20240605;
        b=X+uAdpxIYNZ21UofCpA+OPmTgXUHmAD6qlL9e3LHnN8RNRUhePGufp4iS+qTjw5NUF
         z6Yo7ldz8/CEJWQqJrHvRBjNf9zYt6iKUusCRX+UL+e+j3iy8XucrrjSZas9Ka06MLBA
         VY7bRa5OA/HS6tMKjFnba0ncVVMhg4/z3JVdKrSayaTY99sYsdGUgExc9BLcRH7aQEs2
         si4uR+iWGjb0tt4VZ5tudQYZgyK93AiNQfgQGE4+RGs3VkeeIHbwcPySyoTLzB5QOsuF
         LEUOcRE17+YFhXk5nKaKaPNtPxEZWjmYBmmo3S1XJ5npZPQ8ZDdym7/V8NyTb1qtUaLP
         haKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uZwjriloqAMtBzSwkMnv3fGmFkTCM+oxNn/VsuAzww8=;
        fh=vsqg5TRIQSbJ8vkpGrnuLA+/J2re31Zxt2iK2ye2kt4=;
        b=jAlUhe/rrFPkAyVMPsB5kdKYfa/bPrcjAKcTdUgqt8HE1PrMzhuBprWl7zP5fInpI+
         w0XnU32IJbG1Q9a2dIih5KSpEJcsuyBbBohxg/PMaHx6myE0/O6eXz8w+XOD38Q3mI5H
         ReT6MPx5viSgnc7oxR+H3ncfnU8OArFQ2aUtc2eW5CH1xWqFx9tADYGL5hfoFmH3QPVI
         iQoju2X5SYj9BhunguNZmiTwtSEJPiNQ0C0xoAJ02RP1gV1BUgKfLBvhSmk9M1lcFGxM
         fTcOWeNlB4ZjFZD0ji/NKqacL4Z9jmBd65v39rnr787RPxk0PT4V2aWJWxjdwk/7mThc
         rxMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771862619; x=1772467419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZwjriloqAMtBzSwkMnv3fGmFkTCM+oxNn/VsuAzww8=;
        b=Ca+7YUuOAbAg1AM9T4BEnwKC4Yt4Uex6ztvRUFejYp+XaVlTTbn5PsJ41U7vZdr1P1
         z83q5sWRhyBR/C4Cex74BnZZPFWSPhvoWzJX5beZO6jFtMq2mGogcRVpK12iw9z6h7T4
         oSvYFv6LhXTS+Oi0s9YSSXc7fLRaYSK7JB95xt3j7nffvAaLQu81kdVraMO8lJpR9HhW
         /eOhQ3jOhZbYa+wJnEuXA2UKnHrV1BnikwEF1zbFcSgu6iXuChrI0Eu1DxVrKXtk9AZZ
         7Cd0NvE6w4tCD0GtpxZJWRi319lAfA1kgp/hvQz4dybWWWKwZy+ZsWq4+4skRYUVi8Ke
         wGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862619; x=1772467419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZwjriloqAMtBzSwkMnv3fGmFkTCM+oxNn/VsuAzww8=;
        b=G9C6r9Bz4nidnfUhrjyHcbpGrk24WaZK1ucpjvc1HEPZOqdu0b8F6JX6Zv4tlXGIxq
         RACmSlIQdZ5RFo6WwZY/7SDSNw7BeeyXQIKZrXycpLS7IehMTpT/1XJaYS14bERNUM17
         yWVJZGIM8E9dWcpaGaZ1U7DAZuKsHmTLYbRi/b02tL9US/R/cvNb2DfZSXuND28sqT99
         cDwJOTdovQ8aRL7+4GsuZHDfv8rbjGyjcrRpz+Xjl63gh4As4TOxNdU7IgMtKzTmzFag
         nTaANblmR4cNR7pPedwCcA/pxmmeVYYOleRbkElG4a01bjUYtepbFjras8uZaIozJjMi
         T79g==
X-Gm-Message-State: AOJu0YwkE8N0To4AzWYmOqTH9mDJp7QdQTS9Nmn3wP8m6rbErd+sWPPR
	6rFjhqoC9tnb07hAeLpdjaN0q55yYLZgs/psqh0hqO+sAN+wNnwMmrFBi3R0bz655dTXu5/+0VY
	DN6ubYNDIhhMVGzzHLvxQptN7KfHYV646ZpAt
X-Gm-Gg: ATEYQzzRAB1910oFD7OxSFxVFOGtqWFC09xe0p0yeH9jpVsJTy5QPr+Xy7Vt4oHKvRj
	b7c/S6+9DBWj+yZ9Qi5SkLjZWruAvtoSAKtG1YOiBAg9nLEsb8U1WEiwK22XOF/cq19Fp2XQ5RS
	BSR13hm6e9xBLB80fE7RWTr5rlCT9h5JFrxw+yYf4wxj+lE840+U3+kLITdBNZ1PBIuVkjeT4zT
	dLptt3VXkypUOrIhGU4obc3CTqvy47q2/4WfoAA59BXPDB6AfMuUJYym/+/gQRAXxnX4Gyr+/ov
	JjqpfFHDck9/Q4YKPgn+WpinOJfenQtn8ZAqPkE=
X-Received: by 2002:a17:90b:4b87:b0:356:2540:bdb3 with SMTP id
 98e67ed59e1d1-358ae7ff6eemr7340198a91.10.1771862619056; Mon, 23 Feb 2026
 08:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHzMYBSfK7Ms9W9rc1mzsyP0aRkXg=3G6VXuur15jm7OE2JoCA@mail.gmail.com>
 <6e46e258-4589-4cb8-8548-036ad36884b5@wdc.com>
In-Reply-To: <6e46e258-4589-4cb8-8548-036ad36884b5@wdc.com>
From: Jorge Bastos <jorge.mrbastos@gmail.com>
Date: Mon, 23 Feb 2026 16:03:27 +0000
X-Gm-Features: AaiRm51G4VXKuV0ROkEc7TcuENPqKvMNxVPNUpjqH3fLHEov9-kvywU3yQl8kKQ
Message-ID: <CAHzMYBSCtpHamhBCCgPf4WNDmY5-DOdnXJ8NMLf4C-CLL09oiA@mail.gmail.com>
Subject: Re: Btrfs with zoned devices
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-21847-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jorgemrbastos@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,wdc.com:email]
X-Rspamd-Queue-Id: 81BE51797B9
X-Rspamd-Action: no action

Thanks for the reply, I'm afraid I'm using a built kernel, and
building my own with debug info is beyond my knowledge.

Gemini believes the issue may be caused by too many open zones. I've
monitored blkzone report output, and there are typically >100 zones in
the 'Implicitly Open' or 'Explicitly Open' state, and I've seen it go
over 120 before.

I checked the queue limits for the device and
/sys/block/sdb/queue/max_active_zones reports 0
but
/sys/block/sdb/queue/max_open_zones reports 128

Could it be that btrfs is hitting the max_open_zones limit and
receiving EAGAIN (-11) during btrfs_commit_transaction, possibly
because it isn't self-limiting based on the max_open_zones value when
max_active_zones is 0."

Thanks,
Jorge

On Mon, Feb 23, 2026 at 3:15=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 2/23/26 3:59 PM, Jorge Bastos wrote:
> > Hi,
> >
> > I'm using a zoned device for the first time; it's a 27TB WD Ultrastar
> > HC680, formatted with single data and DUP metadata.
> >
> > This will be used for non-critical WORM media data, but during the
> > initial data load, using a single rsync thread, the filesystem crashed
> > twice, 1st time after copying around 1.25T, 2nd time around 2.5T
> > total.
> >
> > I'm now using some mount options suggested by LLMs, and it hasn't
> > crashed so far, but it's not been long; currently at 3.58T used.
> >
> > mount -o rw,noatime,commit=3D60,flushoncommit,discard=3Dasync
>
> discard=3Dasync doesn't make a lot of sense on zoned and it will be ignor=
ed.
>
>
> > My question is, are these mount options good for HM-SMR or do you
> > recommend different ones, and could they help with the crashing?
> >
> >
> > These were the crashes I saw, they look similar to me, and after
> > unmounting and remounting, it worked again:
>
>
> Yes these errors are transient (luckily).
>
>
> > Kernel 6.18.9
> > btrfs-progs v6.17.1
> >
> > 1st one:
> >
> > Feb 22 21:35:56 Tower7 kernel: BTRFS: error (device sdb) in
> > btrfs_commit_transaction:2536: errno=3D-11 unknown (Error while writing
> > out transaction)
> > Feb 22 21:35:56 Tower7 kernel: BTRFS info (device sdb state E): forced =
readonly
> > Feb 22 21:35:56 Tower7 kernel: BTRFS warning (device sdb state E):
> > Skipping commit of aborted transaction.
> > Feb 22 21:35:56 Tower7 kernel: ------------[ cut here ]------------
> > Feb 22 21:35:56 Tower7 kernel: BTRFS: Transaction aborted (error -11)
> > Feb 22 21:35:56 Tower7 kernel: WARNING: CPU: 8 PID: 109946 at
> > fs/btrfs/transaction.c:2021 btrfs_commit_transaction+0x994/0xb20
> > Feb 22 21:35:56 Tower7 kernel: Modules linked in: md_mod br_netfilter
> > nft_compat af_packet veth nf_conntrack_netlink xt_nat iptable_raw
> > xt_conntrack bridge stp llc xfrm_user xfrm_algo xt_set ip_set
> > xt_addrtype xt_MASQUERADE xt_tcpudp xt_mark tun nf_tables nfnetlink
> > ip6table_nat iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
> > nf_defrag_ipv4 ipmi_devintf ip6table_filter ip6_tables iptable_filter
> > ip_tables x_tables macvtap macvlan tap mlx5_core mlxfw tls igb
> > intel_rapl_msr amd64_edac edac_mce_amd edac_core intel_rapl_common
> > kvm_amd ast kvm drm_shmem_helper drm_client_lib drm_kms_helper
> > ipmi_ssif ghash_clmulni_intel aesni_intel drm rapl acpi_cpufreq
> > backlight i2c_algo_bit input_leds joydev led_class ccp i2c_piix4
> > i2c_smbus acpi_ipmi ses enclosure i2c_core k10temp ipmi_si button
> > zfs(PO) spl(O) [last unloaded: md_mod]
> > Feb 22 21:35:56 Tower7 kernel: CPU: 8 UID: 0 PID: 109946 Comm:
> > btrfs-transacti Tainted: P        W  O        6.18.9-Unraid #4
> > PREEMPT(voluntary)
> > Feb 22 21:35:56 Tower7 kernel: Tainted: [P]=3DPROPRIETARY_MODULE,
> > [W]=3DWARN, [O]=3DOOT_MODULE
> > Feb 22 21:35:56 Tower7 kernel: Hardware name: Supermicro Super
> > Server/H11SSL-i, BIOS 2.4 12/27/2021
> > Feb 22 21:35:56 Tower7 kernel: RIP: 0010:btrfs_commit_transaction+0x994=
/0xb20
> > Feb 22 21:35:56 Tower7 kernel: Code: ba ff 49 8b 7c 24 60 89 da 48 c7
> > c6 2a 81 57 82 e8 81 14 a9 ff e8 2c ef ba ff eb 10 89 de 48 c7 c7 4b
> > 81 57 82 e8 6c d5 b1 ff <0f> 0b 41 b0 01 41 83 e0 01 89 d9 ba e5 07 00
> > 00 4c 89 e7 48 c7 c6
> > Feb 22 21:35:56 Tower7 kernel: RSP: 0018:ffffc9003cac7de0 EFLAGS: 00010=
282
> > Feb 22 21:35:56 Tower7 kernel: RAX: 0000000000000000 RBX:
> > 00000000fffffff5 RCX: 0000000000000002
> > Feb 22 21:35:56 Tower7 kernel: RDX: 0000000000000027 RSI:
> > ffffffff825f9e70 RDI: 00000000ffffffff
> > Feb 22 21:35:56 Tower7 kernel: RBP: ffff88826a27d000 R08:
> > 0000000000000000 R09: 0000000000000000
> > Feb 22 21:35:56 Tower7 kernel: R10: 0000000000000000 R11:
> > 00000000312d2072 R12: ffff888290a1b7e0
> > Feb 22 21:35:56 Tower7 kernel: R13: ffff888249304c00 R14:
> > ffff88826a27d000 R15: ffff888100ec6300
> > Feb 22 21:35:56 Tower7 kernel: FS:  0000000000000000(0000)
> > GS:ffff88a04997c000(0000) knlGS:0000000000000000
> > Feb 22 21:35:56 Tower7 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
> > Feb 22 21:35:56 Tower7 kernel: CR2: 00007ffcad620af8 CR3:
> > 00000001f5915000 CR4: 0000000000350ef0
> > Feb 22 21:35:56 Tower7 kernel: Call Trace:
> > Feb 22 21:35:56 Tower7 kernel: <TASK>
> > Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
> > Feb 22 21:35:56 Tower7 kernel: ? start_transaction+0x46e/0x5e0
> > Feb 22 21:35:56 Tower7 kernel: ? hrtimer_nanosleep_restart+0x50/0x60
> > Feb 22 21:35:56 Tower7 kernel: transaction_kthread+0xf0/0x170
> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_transaction_kthread+0x10/0x10
> > Feb 22 21:35:56 Tower7 kernel: kthread+0x1ce/0x1e0
> > Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
> > Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
> > Feb 22 21:35:56 Tower7 kernel: ? finish_task_switch.isra.0+0x139/0x210
> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> > Feb 22 21:35:56 Tower7 kernel: ret_from_fork+0x24/0x130
> > Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
> > Feb 22 21:35:56 Tower7 kernel: ret_from_fork_asm+0x1a/0x30
> > Feb 22 21:35:56 Tower7 kernel: </TASK>
> > Feb 22 21:35:56 Tower7 kernel: ---[ end trace 0000000000000000 ]---
> > Feb 22 21:35:56 Tower7 kernel: BTRFS: error (device sdb state EA) in
> > cleanup_transaction:2021: errno=3D-11 unknown
>
> The FS is trying to commit a transaction and something down the path is
> returning EAGAIN. Would be interesting who did it.
>
> Do you have the debug info for this kernel, so we can find out where it
> breaks?
>

