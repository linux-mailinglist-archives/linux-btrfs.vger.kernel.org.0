Return-Path: <linux-btrfs+bounces-22062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDblGUyJoWmtuAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22062-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 13:08:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE331B6F11
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 13:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78E563045200
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D023A3A1E6C;
	Fri, 27 Feb 2026 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D270IKmJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0EB279DC3
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194110; cv=none; b=Wml+ML5vZKCb38N5wMd6ALT7jw7xwxhuucuSYOGaC0DKHS//7Gjc61BGvW6kENPyabh52xf6vD9Ok4ely7z7x6RFppiTcS+eYDHzKfykbmgpwwLBxCfDmK/eC3wMsM16CPIPAa1nN/iJN5QXJn+0/HWaZ85dCYVDC5pxy0+po6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194110; c=relaxed/simple;
	bh=BQ2Y+mj74yH8RtSvd09Ea7KnuW2MUqrW8AXJMJUS8v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwlqEyFzeZkqETtCoXHcHD7ZDj0hspHVRUj/SOX3jASjeo43I3flTtG9IurseP1cvzRIFi4/XFP+1CNq3wRCcSwJnNJryohafdJNMV2kQAtElLKl/B0zVGoQ1N8GspXE/gZsFLX6qIjpHkAdsMShOAwjvrGbiPWyBsa9Qn3tij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D270IKmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C627FC19425
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 12:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772194109;
	bh=BQ2Y+mj74yH8RtSvd09Ea7KnuW2MUqrW8AXJMJUS8v8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D270IKmJXtuKAPm7v0CoKW07xYzbf/YZJXGZa92qVdyD7kCzbhJTQ3dxRwHngAb5P
	 wlX7zLZ22CB7ysUnhzfXjxSWiGplGHFOKv5wFAGU++drsoUH7nZhK5/Ncheg+c8y+0
	 xiT96uL9MuRcY13XMjzZYrDpiH93bWrWET8b/S+seK1aV1dj+4qrOJsMGbh/xCoccL
	 vKIIAr98RS4GhAgpKIcf7lquQ409H1jOlpfapPvQCJFnDYvIPpPEutfY508lrcYUM6
	 M+hdgAglnqsp9tfz7bC4BSxm+c2PlxK/HQgup5K2O9mN+tSEyWpuT3bHNOaXk2LBX8
	 I8EBLSBF9QiVA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so278072566b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 04:08:29 -0800 (PST)
X-Gm-Message-State: AOJu0YwfJZqgZxFVFAyWu7ZLJrTGjNaaFobhs9GjBrKRl2otWN+tuy78
	s1TfmC3QjbSo2CBUbx+N0Zr0df3AszwkJuyEYX0++KCRyESrkAF9lwSU/6xr8upHwjPx79Ja+VS
	keULBZZ22V/CrhGgFWLeSg/MsF6ilm4M=
X-Received: by 2002:a17:907:787:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-b937637a6c6mr123089366b.9.1772194108214; Fri, 27 Feb 2026
 04:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227115051.136255-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260227115051.136255-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Feb 2026 12:07:50 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4EC2EChn+JBc-CMOmfrVzqFMnwMSWV9AUO0iHb8zp--A@mail.gmail.com>
X-Gm-Features: AaiRm51iW4JM7PLC-czuPCU4XbqvE46ZQE5pmelQ2EupXkiia6o6IjWf3hUggl4
Message-ID: <CAL3q7H4EC2EChn+JBc-CMOmfrVzqFMnwMSWV9AUO0iHb8zp--A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: take rcu_read_lock before dereferencing device->name
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22062-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,wdc.com:email]
X-Rspamd-Queue-Id: BDE331B6F11
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 11:51=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> When mounting a zoned filesystem with lockdep enabled, the following spla=
t
> is emitted:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: suspicious RCU usage
>  7.0.0-rc1+ #351 Not tainted
>  -----------------------------
>  fs/btrfs/zoned.c:594 suspicious rcu_dereference_check() usage!
>
>  other info that might help us debug this:
>
>  rcu_scheduler_active =3D 2, debug_locks =3D 1
>  3 locks held by mount/459:
>   #0: ffff8881014dec78 (&fc->uapi_mutex){+.+.}-{4:4}, at: __do_sys_fsconf=
ig+0x2ae/0x680
>   #1: ffff888101ddd0e8 (&type->s_umount_key#31/1){+.+.}-{4:4}, at: alloc_=
super+0xc0/0x3e0
>   #2: ffff888101e294e0 (&fs_devs->device_list_mutex){+.+.}-{4:4}, at: btr=
fs_get_dev_zone_info_all_devices+0x45/0x90
>
>  stack backtrace:
>  CPU: 2 UID: 0 PID: 459 Comm: mount Not tainted 7.0.0-rc1+ #351 PREEMPT(f=
ull)
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc4=
3 06/10/2025
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5b/0x80
>   lockdep_rcu_suspicious.cold+0x4e/0xa3
>   btrfs_get_dev_zone_info+0x434/0x9d0
>   btrfs_get_dev_zone_info_all_devices+0x62/0x90
>   open_ctree+0xcd2/0x1677
>   btrfs_get_tree.cold+0xfc/0x1e3
>   ? rcu_is_watching+0x18/0x50
>   vfs_get_tree+0x28/0xb0
>   __do_sys_fsconfig+0x324/0x680
>   do_syscall_64+0x92/0x4f0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f88d294c40e
>  Code: 73 01 c3 48 8b 0d f2 29 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f =
84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 f=
f ff 73 01 c3 48 8b 0d c2 29 0f 00 f7 d8 64 89 01 48
>  RSP: 002b:00007ffd642d05e8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
>  RAX: ffffffffffffffda RBX: 000055c860d48b10 RCX: 00007f88d294c40e
>  RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
>  RBP: 00007ffd642d0730 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>  R13: 000055c860d49c40 R14: 00007f88d2acca60 R15: 000055c860d49d08
>   </TASK>
>  BTRFS info (device vda): host-managed zoned block device /dev/vda, 64 zo=
nes of 268435456 bytes
>  BTRFS info (device vda): zoned mode enabled with zone size 268435456
>  BTRFS info (device vda): checking UUID tree
>
> Fix it by holding the rc_read_lock before calling into rcu_dereference()
> to dereference the rcu protected device->name pointer.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index ab330ec957bc..e69a05f492a6 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include "linux/rcupdate.h"
>  #include <linux/bitops.h>
>  #include <linux/slab.h>
>  #include <linux/blkdev.h>
> @@ -401,17 +402,22 @@ int btrfs_get_dev_zone_info(struct btrfs_device *de=
vice, bool populate_cache)
>
>         /* We reject devices with a zone size larger than 8GB */
>         if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {
> -               btrfs_err(fs_info,
> -               "zoned: %s: zone size %llu larger than supported maximum =
%llu",
> -                                rcu_dereference(device->name),
> -                                zone_info->zone_size, BTRFS_MAX_ZONE_SIZ=
E);
> +               rcu_read_lock();
> +               btrfs_err(
> +                       fs_info,
> +                       "zoned: %s: zone size %llu larger than supported =
maximum %llu",
> +                       rcu_dereference(device->name), zone_info->zone_si=
ze,
> +                       BTRFS_MAX_ZONE_SIZE);
> +               rcu_read_unlock();

This shouldn't be needed.

The btrfs_* print helpers are defined as:

#define btrfs_err(fs_info, fmt, args...) \
    btrfs_printk_in_rcu(fs_info, LOGLEVEL_ERR, fmt, ##args)

#define btrfs_printk_in_rcu(fs_info, level, fmt, args...) \
do { \
   rcu_read_lock(); \
   _btrfs_printk(fs_info, level, fmt, ##args); \
   rcu_read_unlock(); \
} while (0)

So I think you ran into that in a for-next branch that had a patch
that was dropped yesterday:

https://lore.kernel.org/linux-btrfs/202602130950.db059ac8-lkp@intel.com/



>                 ret =3D -EINVAL;
>                 goto out;
>         } else if (zone_info->zone_size < BTRFS_MIN_ZONE_SIZE) {
> +               rcu_read_lock();
>                 btrfs_err(fs_info,
>                 "zoned: %s: zone size %llu smaller than supported minimum=
 %u",
>                                  rcu_dereference(device->name),
>                                  zone_info->zone_size, BTRFS_MIN_ZONE_SIZ=
E);
> +               rcu_read_unlock();
>                 ret =3D -EINVAL;
>                 goto out;
>         }
> @@ -427,10 +433,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *de=
vice, bool populate_cache)
>         if (!max_active_zones && zone_info->nr_zones > BTRFS_DEFAULT_MAX_=
ACTIVE_ZONES)
>                 max_active_zones =3D BTRFS_DEFAULT_MAX_ACTIVE_ZONES;
>         if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES=
) {
> +               rcu_read_lock();
>                 btrfs_err(fs_info,
>  "zoned: %s: max active zones %u is too small, need at least %u active zo=
nes",
>                                  rcu_dereference(device->name), max_activ=
e_zones,
>                                  BTRFS_MIN_ACTIVE_ZONES);
> +               rcu_read_unlock();
>                 ret =3D -EINVAL;
>                 goto out;
>         }
> @@ -469,9 +477,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device *dev=
ice, bool populate_cache)
>                 zone_info->zone_cache =3D vcalloc(zone_info->nr_zones,
>                                                 sizeof(struct blk_zone));
>                 if (!zone_info->zone_cache) {
> +                       rcu_read_lock();
>                         btrfs_err(device->fs_info,
>                                 "zoned: failed to allocate zone cache for=
 %s",
>                                 rcu_dereference(device->name));
> +                       rcu_read_unlock();
>                         ret =3D -ENOMEM;
>                         goto out;
>                 }
> @@ -507,10 +517,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *de=
vice, bool populate_cache)
>         }
>
>         if (unlikely(nreported !=3D zone_info->nr_zones)) {
> +               rcu_read_lock();
>                 btrfs_err(device->fs_info,
>                                  "inconsistent number of zones on %s (%u/=
%u)",
>                                  rcu_dereference(device->name), nreported=
,
>                                  zone_info->nr_zones);
> +               rcu_read_unlock();
>                 ret =3D -EIO;
>                 goto out;
>         }
> @@ -522,10 +534,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *de=
vice, bool populate_cache)
>                                 zone_info->max_active_zones =3D 0;
>                                 goto validate;
>                         }
> +                       rcu_read_lock();
>                         btrfs_err(device->fs_info,
>                         "zoned: %u active zones on %s exceeds max_active_=
zones %u",
>                                          nactive, rcu_dereference(device-=
>name),
>                                          max_active_zones);
> +                       rcu_read_unlock();
>                         ret =3D -EIO;
>                         goto out;
>                 }
> @@ -591,10 +605,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *de=
vice, bool populate_cache)
>                 emulated =3D "emulated ";
>         }
>
> +       rcu_read_lock();
>         btrfs_info(fs_info,
>                 "%s block device %s, %u %szones of %llu bytes",
>                 model, rcu_dereference(device->name), zone_info->nr_zones=
,
>                 emulated, zone_info->zone_size);
> +       rcu_read_unlock();
>
>         return 0;
>
> --
> 2.53.0
>
>

