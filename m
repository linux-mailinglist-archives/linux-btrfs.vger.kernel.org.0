Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D751B2102
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 10:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgDUIFq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 04:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgDUIFp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 04:05:45 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E935E2071C
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Apr 2020 08:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587456345;
        bh=c6cbnjvRoGorzGP+pdkHMCQVlwoBdIjxfPe0g4Nfr0c=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=DSwOcm1JaxUjvJkKbzzpE8pAWz+WKFYmpiEulLaE+SGH2+WhGoOw3KjmV6khiZstm
         3c2dbfoK/AoEgmlqogM2C9A8gPcnP4rlWsEriRTmxmHxvA6qzy/Ckqa0dNL4J+WDLa
         uaPzpUDANZLlm5ReRnK4MimzhPVGqDKmS9CHHrUM=
Received: by mail-ua1-f53.google.com with SMTP id c24so4721441uap.13
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Apr 2020 01:05:44 -0700 (PDT)
X-Gm-Message-State: AGi0PuYJFJb0lsizzNaBRDrwx30YXXNEWNIO2+wlilvfd38/MeR6pzHx
        9sTiy7IVm+NH9Vr4skj48T87oQ2kCTW3ahIfOMs=
X-Google-Smtp-Source: APiQypI9no9cV4EJwSwAnX1qHWC7h79SDcJmyCygQlBe8v/THZ58Qxi2DtziMNASav3L6jZbQF3GQuTxCa+r7NnjWzc=
X-Received: by 2002:ab0:5bcc:: with SMTP id z12mr11013836uae.135.1587456343997;
 Tue, 21 Apr 2020 01:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200417144012.9269-1-fdmanana@kernel.org> <20200417153615.23832-1-fdmanana@kernel.org>
In-Reply-To: <20200417153615.23832-1-fdmanana@kernel.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 21 Apr 2020 09:05:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H47_MMqwT8-VLGDWJ-GJMoP1yOpwG8_+qE+ntaq_3xYDQ@mail.gmail.com>
Message-ID: <CAL3q7H47_MMqwT8-VLGDWJ-GJMoP1yOpwG8_+qE+ntaq_3xYDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Btrfs: fix memory leak of transaction when
 deleting unused block group
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 4:38 PM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> When cleaning pinned extents right before deleting an unused block group,
> we check if there's still a previous transaction running and if so we
> increment its reference count before using it for cleaning pinned ranges
> in its pinned extents iotree. However we ended up never decrementing the
> reference count after using the transaction, resulting in a memory leak.
>
> Fix it by decrementing the reference count.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Fixes: fe119a6eeb6705 ("btrfs: switch to per-transaction pinned extents")

And missed that in v2, but had it in v1.

> ---
>
> V2: Use btrfs_put_transaction() and not refcount_dec(), otherwise we are
>     not really releasing the memory used by the transaction in case its
>     refcount is 1. Stupid mistake.
>
>  fs/btrfs/block-group.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 47f66c6a7d7f..af9e9a008724 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1288,11 +1288,15 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
>         if (ret)
>                 goto err;
>         mutex_unlock(&fs_info->unused_bg_unpin_mutex);
> +       if (prev_trans)
> +               btrfs_put_transaction(prev_trans);
>
>         return true;
>
>  err:
>         mutex_unlock(&fs_info->unused_bg_unpin_mutex);
> +       if (prev_trans)
> +               btrfs_put_transaction(prev_trans);
>         btrfs_dec_block_group_ro(bg);
>         return false;
>  }
> --
> 2.11.0
>
