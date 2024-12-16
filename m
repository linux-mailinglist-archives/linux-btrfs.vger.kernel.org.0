Return-Path: <linux-btrfs+bounces-10421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EAF9F37B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73049188C585
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C856207679;
	Mon, 16 Dec 2024 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAfZRE03"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1342066D3;
	Mon, 16 Dec 2024 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370573; cv=none; b=lqQtBAh5NCmduGkd6ijanqIJU9EFDMlmFnesiiR1GnoIKomudOvTe14GWQZPrGfQ3wum/SWiDRs6+9CVTM50O7B5CaE6X57/gYyX48EE782unDtKpTtLkCHlGPOF1SszrXpoHD3QGy4eKD0X2w//5vqxCYFts1fM6/+8XdkjTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370573; c=relaxed/simple;
	bh=Qv0t6tpGNYa6f8J/zR6XvTBwVdfwFgoVP5PjdWFUFms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Il/cDZc1zIQUkgJW1UVcGtu9wT+9Ew9mA4kgTSC1BalRhzgk49xenJxo+yDRzIT9TH1ihV1iIh2Ef858IZyrsM4PSYMCC+uhYEjQ1RonsMEzejVvbFby/VxyK9VK61BDyhrmMNwYObgbAFN2ZZQJonJb7XngSEoxHAtpWUMc4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAfZRE03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0637FC4CEDD;
	Mon, 16 Dec 2024 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734370573;
	bh=Qv0t6tpGNYa6f8J/zR6XvTBwVdfwFgoVP5PjdWFUFms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cAfZRE03PqAE3DBotjQMDddNvMWfoiaGd+Fy9G7gGzuJh1NtxnTCHfFL9l9uRpQuz
	 NraURnLY8ybzb1wx5MYyP36f0a2gdaUkzmyTWPqbMrW9JX+Q0bPuSxBH+wP22JzwNM
	 dxRdYjg2R6zOMziSq406rBGPReFIAPVGWnUoGbnMO68jp8V/20LycBbDRqCLMfXOY+
	 LjR6ME+4rOoAP4PHq0SzBLZwMNJ8Jy+0TQCdYKYarncMeSW0wMmPqKbs/S2Bd1axJT
	 MkgRfHnOY0c5nV1obyhSIr8j7WPatMBO2R//hutQKhp0QRJba0bJPLU3PRV3yEh7I3
	 NEHSSGwkucAzg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa66c1345caso172020566b.3;
        Mon, 16 Dec 2024 09:36:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxQ2hAConQqPDESUI1ucbpwrBY6g8S+djnSZkq661fxdI5d+URrK32gF6SyhiHABsB+DTam0YhwCxlCRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQYQdtzP3jsrdXVMnU1GPwLdOZxOspm4W9SrACPrVhdxBjb+5
	F437pVWXXAsmSkNtmHuSMz3/RtJibNBhaqe15hQH2E+1EjrcHz1S+OtG6TesIB6U8X79ErMzH7r
	t4Hm0YUAuIu7CNxT8SdSrL6hmr6A=
X-Google-Smtp-Source: AGHT+IFvsvFR2nNzqTPrYxmfz5NBJwJ6kgq/k0PrR/IZbbs7fir04svob/E6wFM4O+s14SnNghZVrvFC1INvTSDd7RQ=
X-Received: by 2002:a17:907:7e8b:b0:aa6:5f72:7cc8 with SMTP id
 a640c23a62f3a-aab778f700fmr1314024766b.13.1734370571385; Mon, 16 Dec 2024
 09:36:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211111315.65007-1-sunjunchao2870@gmail.com>
In-Reply-To: <20241211111315.65007-1-sunjunchao2870@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Dec 2024 17:35:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5DhmjX_G7PGQQ40O7wtaV7TqFp_7L9yL7asjLA27J8pA@mail.gmail.com>
Message-ID: <CAL3q7H5DhmjX_G7PGQQ40O7wtaV7TqFp_7L9yL7asjLA27J8pA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix an assertion failure related to squota feature.
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, clm@fb.com, 
	josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:13=E2=80=AFAM Julian Sun <sunjunchao2870@gmail.c=
om> wrote:
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

Fixes: 182940f4f4db ("btrfs: qgroup: add new quota mode for simple quotas")
Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.
We should also turn the reproducer into a test case for fstests.

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
>

