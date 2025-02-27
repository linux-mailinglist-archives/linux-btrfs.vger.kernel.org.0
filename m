Return-Path: <linux-btrfs+bounces-11904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B744A47E1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 13:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04568188BB22
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB9922F14C;
	Thu, 27 Feb 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIphWxY+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD422DFB5;
	Thu, 27 Feb 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660205; cv=none; b=rmg0fwUNgufSmxzLuSCFV71yiUcrvIoC5X87SneYX19m5rD1htOEN4t1VacwePQtYEn4fWp66hIsDCKxaezxQZNOPwZZCLOCi+EUtbdarL1NVrlDlpVLNL6QOYucBbAEbbaHkqBnZeamdXMd51ACCMurhcwc/xo0ClrscDSMoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660205; c=relaxed/simple;
	bh=dKN388JV0swg+t8dphtxvO5GGLGFtSivyHmqGlUHhlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrF2YXaJkihUK68qQolgln6M98dbXEnPHqlsneBvQ4wP5ulcXAfSlvp0a3K8ZkmqRK1eBC/x+xqaKTwzE/+d5KrVcW3NG0DSRlZ4mue4XvDpwoRxJkOXFqOYHee+ylNbsj47ZkAg9EeYMTXrBoM3HqiPhd2jWlH0aprYebtKPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIphWxY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69158C4CEE6;
	Thu, 27 Feb 2025 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740660204;
	bh=dKN388JV0swg+t8dphtxvO5GGLGFtSivyHmqGlUHhlo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sIphWxY+Rga+WjE3CeVe9L0gjvY2yIRO2rG65j4J+gCKJKqEbeVYR72KTZ4pP1SKe
	 SMLddOY272tg0BJzRp75qeakvlGb+vaU+oadTIZIgCzoPhkfdh99J2r15hyK2Vh++z
	 5RRBtUuZ+XeLs29yLAWPao8WcsoNjVW/uc6EMEDu8uqLVVMcn9M8WAtjPbKXn/wMrx
	 ftgCAZYu/r8d5vYMa1RFaOv3fy6MOpZk9AQoW7JJN91YtkmyQHWSXBCyh3oxtDXKGZ
	 OTzfMCxyO0bg0FMGHal13lvyE2S+Ros0FBvMffltn12dfJa6yn0dkD5CP8n8w317OP
	 8c4n/5nvM+G3w==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso1374194a12.2;
        Thu, 27 Feb 2025 04:43:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWztWuk7cVkYYDsjmlOkKEdN9tCJTAAddVs7t2UqQHafUXry6Ji1nKAq1enBA+mbvMQmIbP9BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCLXCuQfQphnEEPZJLLu3l81yTG2yxV8BBw26PXgWMCxKrw8S
	FsxpIG5eCOKil+SQnC6LT8BN6ik7Qm6ulR2yu6XyHCQ7pS4I4b5OxvzHEdJcogJJD8GrN3GFfnn
	wUFJkz8nK33fSmiggbmfJkIZubv4=
X-Google-Smtp-Source: AGHT+IGViTn69mq+quOe95OM2Bb41JZ27BQuy3vIaCx9pOuz3KXd9XM5aRtEbLAumcFRGrHpGFrpgYy4wH+/meI8MsQ=
X-Received: by 2002:a17:906:3119:b0:abb:b092:dae0 with SMTP id
 a640c23a62f3a-abeeed0d608mr742704466b.11.1740660202989; Thu, 27 Feb 2025
 04:43:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740635497.git.wqu@suse.com> <5d724635289a10a39164b767bdbee81e9e82e7d7.1740635497.git.wqu@suse.com>
In-Reply-To: <5d724635289a10a39164b767bdbee81e9e82e7d7.1740635497.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 27 Feb 2025 12:42:45 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7_MLhKpyQB0BcU2v2rxZD8UCaABSXcS-5XDKYN5vLLBQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoujxYgEfQgDu2g02Aa7DkZmOewugMQTslglWavPx71B7NBP9BiAXrLlNk
Message-ID: <CAL3q7H7_MLhKpyQB0BcU2v2rxZD8UCaABSXcS-5XDKYN5vLLBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] btrfs: subpage: do not hold subpage spin lock when
 clearing folio writeback
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:56=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When testing subpage block size btrfs (block size < page size), I hit
> the following spin lock hang on x86_64, with the experimental 2K block
> size support:
>
>   <TASK>
>   _raw_spin_lock_irq+0x2f/0x40
>   wait_subpage_spinlock+0x69/0x80 [btrfs]
>   btrfs_release_folio+0x46/0x70 [btrfs]
>   folio_unmap_invalidate+0xcb/0x250
>   folio_end_writeback+0x127/0x1b0
>   btrfs_subpage_clear_writeback+0xef/0x140 [btrfs]
>   end_bbio_data_write+0x13a/0x3c0 [btrfs]
>   btrfs_bio_end_io+0x6f/0xc0 [btrfs]
>   process_one_work+0x156/0x310
>   worker_thread+0x252/0x390
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xef/0x250
>   ? finish_task_switch.isra.0+0x8a/0x250
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x34/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>
> [CAUSE]
> It's a self deadlock with the following sequence:
>
>  btrfs_subpage_clear_writeback()
>  |- spin_lock_irqsave(&subpage->lock);
>  |- folio_end_writeback()
>     |- folio_end_dropbehind_write()
>        |- folio_unmap_invalidate()
>           |- btrfs_release_folio()
>              |- wait_subpage_spinlock()
>                 |- spin_lock_irq(&subpage->lock);
>                    !! DEADLOCK !!
>
> We're trying to acquire the same spin lock already held by ourselves.
>
> [FIX]
> Move the folio_end_writeback() call out of the spin lock critical
> section.
>
> And since we no longer have all the bitmap operation and the writeback
> flag clearing happening inside the critical section, we must do extra
> checks to make sure only the last one clearing the writeback bitmap can
> clear the folio writeback flag.
>
> Fixes: 3470da3b7d87 ("btrfs: subpage: introduce helpers for writeback sta=
tus")
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/subpage.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index ebb40f506921..bedb5fac579b 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -466,15 +466,21 @@ void btrfs_subpage_clear_writeback(const struct btr=
fs_fs_info *fs_info,
>         struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, folio,
>                                                         writeback, start,=
 len);
> +       bool was_writeback;
> +       bool last =3D false;
>         unsigned long flags;
>
>         spin_lock_irqsave(&subpage->lock, flags);
> +       was_writeback =3D !subpage_test_bitmap_all_zero(fs_info, folio, w=
riteback);
>         bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectors=
ize_bits);
> -       if (subpage_test_bitmap_all_zero(fs_info, folio, writeback)) {
> +       if (subpage_test_bitmap_all_zero(fs_info, folio, writeback) &&
> +           was_writeback) {
>                 ASSERT(folio_test_writeback(folio));
> -               folio_end_writeback(folio);
> +               last =3D true;
>         }
>         spin_unlock_irqrestore(&subpage->lock, flags);
> +       if (last)
> +               folio_end_writeback(folio);
>  }
>
>  void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
> --
> 2.48.1
>
>

