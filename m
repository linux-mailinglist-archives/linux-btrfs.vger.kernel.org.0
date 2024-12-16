Return-Path: <linux-btrfs+bounces-10408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D81D9F30EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 13:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C983166930
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 12:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381242054E6;
	Mon, 16 Dec 2024 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvMZJqzE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D0204C2B;
	Mon, 16 Dec 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353575; cv=none; b=lyQ6+PQmiz6T8042SsoRF1yKWI/yIECpCkBlJjE5kSH5//SlkDRboucpaG3WiJ5TRwuMKrDdpxuYEk6Lm/+JEnjtfNSPV5s1OsJI9R+NOvFEdE5PXowLfCSMtyslDrPNLqlUf4gAJsxD52LEwymYakcYJrlnP/DYaY/ZHa6/oWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353575; c=relaxed/simple;
	bh=HjFYd6BndnpoiCRd2oyS549xr1ezPodTGI6FzDIpkfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdRZjqLiNXQ6SJ+5s3KGhMtfub48wuslinOLHCPi3v6ti8svjT9p+53lYzteON8YOInfpv/vtkvmn5xM+RPVIOqiYOHslQ9iu9kAmQomvekp7Kt0u2QW82dBttX23ObBNSS+jpzKBLoSrOcVVH+c8l9G/HTwOcsE7X0kbWtrErs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvMZJqzE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54025432becso4124809e87.1;
        Mon, 16 Dec 2024 04:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734353571; x=1734958371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+26SMdialOSb6Rf0bIvmxpAwyXCSbvy4Gbj4G/lVa8=;
        b=kvMZJqzEIysldsdwruplbgb7jTWqkYzNkDiAk6avZyN5LhEXGaYpJJTI8uEav+MMKD
         Vmhqm/MdStY026iPsnVHKn+FS4pXrEZVOqGpcu0XnV8DjQGdIxlCKyzc8fFwHw9BlLy7
         ljvWJBWR/l4DUuqH4S2b+01XhRCxU8jLJ45wxBP9s8CfBDVBV1H0xe8RC2hkahw084fu
         25YsBPxQVIPkLzHxGPBMYvAFPiq4QYVquzBD8eeY8sdZKaekctkFmTEdoWWe2bxlN+De
         BQUmfRNMC5q0CA/7B4Ew83a5zb7vBpleCi4dTCPhwWV7H1hfv9SsUBbmUujhQtVmDozZ
         lJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734353571; x=1734958371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+26SMdialOSb6Rf0bIvmxpAwyXCSbvy4Gbj4G/lVa8=;
        b=VFFY0DftIG9FNrmk0junI+lAC7jnk9WJxxUdMXNnEkvHsec7oY4rQQEX9QlFp6GuyP
         jBz+vEBqIFprmJMwHfzcttmwG5ZsEZLWmDFkZiJZH/YKfUg1fQOKq/NHVEl9KIb18lAp
         lqxN+q6Y5MA8DKTjiXVz++nW0bOodhEQ9+qwSJkiFPhiX6leghIeCLMZZtiZDUqZUvCE
         MvtML++SxH13k3UiN3taVv+xy9WgI06HuwqAoerqN+WDU8draSTtHWHCUPshVDyFEQwW
         lhNthFqCu+YwhO/qCeiER9Q91Bhv0WP0SMutd/VnsH+XVuK4TOktkpJIZSX+IJVmmXLB
         LSng==
X-Forwarded-Encrypted: i=1; AJvYcCUYojpQkZC/6WGcNDQ7huxQjY2rr0UBDS0BAcpMl1Nt+6HaZFbd+nur1OjSFR4mpeVnuie23+fJQtlvVeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHINnMGWAXKqaTrTBELGc/BFApUlXP59DWlI2+j/mQFdX14PGp
	XRkoC4jZsgSHSD7BW4BAk+bUldMN7vEVTuZMG4j8UPbvHBQY+sI7CLQI5BFcbyG3BYn3Dyzp9S7
	Hz6gFWFiNuz5ZYS27oL63RL5k6lA12pjaZhfDRw==
X-Gm-Gg: ASbGncvfCGn5YJTH+CdzGq3rw0Rhxn6JnIviGD2Djz0fiLhRP5vkvL5mLCAXmD8Gun2
	p6kZQf2wkSuFmw1kLDoD0PuTG7BJzIoeMu6YyEHir
X-Google-Smtp-Source: AGHT+IFNQpdcFgvzgPCArT7asNvaiEBS5RdaRAoiNuFcO4e6j8/ODGkRopUfvTV1xxc0f0tgRt8ofRgliLZE0+eaBv0=
X-Received: by 2002:a05:6512:a8c:b0:53e:391c:e96c with SMTP id
 2adb3069b0e04-5408ad80ba1mr3770191e87.8.1734353571087; Mon, 16 Dec 2024
 04:52:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211111315.65007-1-sunjunchao2870@gmail.com>
In-Reply-To: <20241211111315.65007-1-sunjunchao2870@gmail.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Mon, 16 Dec 2024 20:52:40 +0800
Message-ID: <CAHB1NaiY-DfZzaofQ82XMJW75V-tcaN0dHLD-LC5UH-766EQ7A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix an assertion failure related to squota feature.
To: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com, 
	boris@bur.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping...
[+cc Boris]

Julian Sun <sunjunchao2870@gmail.com> =E4=BA=8E2024=E5=B9=B412=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=B8=89 19:13=E5=86=99=E9=81=93=EF=BC=9A
>
> With the config CONFIG_BTRFS_ASSERT enabled, an assertion
> failure occurs regarding the simple quota feature.
>
> [    5.596534] assertion failed: btrfs_fs_incompat(fs_info, SIMPLE_QUOTA)=
, in fs/btrfs/qgroup.c:365
> [    5.597098] ------------[ cut here ]------------
> [    5.597371] kernel BUG at fs/btrfs/qgroup.c:365!
> [    5.597946] CPU: 1 UID: 0 PID: 268 Comm: mount Not tainted 6.13.0-rc2-=
00031-gf92f4749861b #146
> [    5.598450] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.16.2-debian-1.16.2-1 04/01/2014
> [    5.599008] RIP: 0010:btrfs_read_qgroup_config+0x74d/0x7a0
> [    5.604303]  <TASK>
> [    5.605230]  ? btrfs_read_qgroup_config+0x74d/0x7a0
> [    5.605538]  ? exc_invalid_op+0x56/0x70
> [    5.605775]  ? btrfs_read_qgroup_config+0x74d/0x7a0
> [    5.606066]  ? asm_exc_invalid_op+0x1f/0x30
> [    5.606441]  ? btrfs_read_qgroup_config+0x74d/0x7a0
> [    5.606741]  ? btrfs_read_qgroup_config+0x74d/0x7a0
> [    5.607038]  ? try_to_wake_up+0x317/0x760
> [    5.607286]  open_ctree+0xd9c/0x1710
> [    5.607509]  btrfs_get_tree+0x58a/0x7e0
> [    5.608002]  vfs_get_tree+0x2e/0x100
> [    5.608224]  fc_mount+0x16/0x60
> [    5.608420]  btrfs_get_tree+0x2f8/0x7e0
> [    5.608897]  vfs_get_tree+0x2e/0x100
> [    5.609121]  path_mount+0x4c8/0xbc0
> [    5.609538]  __x64_sys_mount+0x10d/0x150
>
> The issue can be easily reproduced using the following reproduer:
> root@q:linux# cat repro.sh
> set -e
>
> mkfs.btrfs -f /dev/sdb > /dev/null
> mount /dev/sdb /mnt/btrfs
> btrfs quota enable -s /mnt/btrfs
> umount /mnt/btrfs
> mount /dev/sdb /mnt/btrfs
>
> The root cause of this issue is as follows:
> When simple quota is enabled, the BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA
> flag is set after btrfs_commit_transaction(), whereas the
> BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE flag is set before btrfs_commit_tran=
saction(),
> which led to the first flag not being flushed to disk, and the second
> flag is successfully flushed. Finally causes this assertion failure
> after umount && mount again.
>
> To resolve this issue, the BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA flag
> is set immediately after setting the BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE=
.
> This ensures that both flags are flushed to disk within the same
> transaction.
>
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/btrfs/qgroup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index a6f92836c9b1..f9b214992212 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1121,6 +1121,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_inf=
o,
>         fs_info->qgroup_flags =3D BTRFS_QGROUP_STATUS_FLAG_ON;
>         if (simple) {
>                 fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_SIMPL=
E_MODE;
> +               btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
>                 btrfs_set_qgroup_status_enable_gen(leaf, ptr, trans->tran=
sid);
>         } else {
>                 fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCON=
SISTENT;
> @@ -1254,8 +1255,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_inf=
o,
>         spin_lock(&fs_info->qgroup_lock);
>         fs_info->quota_root =3D quota_root;
>         set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> -       if (simple)
> -               btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
>         spin_unlock(&fs_info->qgroup_lock);
>
>         /* Skip rescan for simple qgroups. */
> --
> 2.39.5
>


--=20
Julian Sun <sunjunchao2870@gmail.com>

