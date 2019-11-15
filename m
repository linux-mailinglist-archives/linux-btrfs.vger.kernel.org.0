Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01424FE744
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 22:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKOVjf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 16:39:35 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44961 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKOVjf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 16:39:35 -0500
Received: by mail-ua1-f68.google.com with SMTP id r22so3456313uam.11
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2019 13:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CMQGKz6d+YGXnNcYKP/5TqaaTZqIzBG0e3qT/ApfJM0=;
        b=tvYiF+uT6A18gG+8WCkg1EHI70YK8KLzkDAW2gcaPBUMdsZW4mXDgT5RqQXHMjat8i
         zUUiFAU40DFwoT27oIDiU4lH5vxXEKsGrbOrI6IG0mYG/3mPHYNZCoCh3UN+gxUdCPcX
         62FOXNt4KK7joNXn19MxxAaOl69otZzbDrys91MJ82920ds6gMfKJMcdv03AESZl2pT3
         NgA/8DfoYlNXXVF8WqnQ3TRMj9y5nHngoVOpboRxys8AXQpoThR+VATjBO1RK+wZk06x
         gOk0TOcAMsUyHe1kwXNU+s0yrMftqdtGmYkPsnHBSwWfew9iMTXDWZeYCn+SaiTHcKRK
         +0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=CMQGKz6d+YGXnNcYKP/5TqaaTZqIzBG0e3qT/ApfJM0=;
        b=hgw5L3lIFaRqlwhy8leawvBNnk+IO8H/89sooO6MviuLMEwgeA+SuHpWGRGqQcdSe5
         4+7tJ7Y4W/JOxO0wJxqsb6k29r4wfQUTVx7TXJ/La5Ei//7/EzMlyy+0uuJk7lsO46X5
         mTi9dx+ce/XbY0Kt21WiCQamn3X6PXJxGl382/3W9CF+I1sm9tf1HmqFItrcqsH0qY0Z
         sZsmdsBnUPmVAghwg5LJJdsDzDeit3/4BA2xk1nSLG5E3O06ZvRK7NHPC1gOc2sHnNNZ
         uXRJveDOwjzor9tozzi2x3sklqcYiv2x9/3FThGPrY/wu7kVKy6+m1RneVuQWARhZgjL
         ORIw==
X-Gm-Message-State: APjAAAVOPJfgAAN6Iii686Y4AWqmGQ8tq2ztlq/QaDQq4IYcX1FaGlqF
        cOD4HNy19vRFh2Cu9ZF6h3CQoY5A+/HFWxmEwsIj8w==
X-Google-Smtp-Source: APXvYqzaSoPWZ4om1eVQ9SyTYt6rvFFp7FqjxuIESRxUmZuH2ZnhMvNqFOdAqbAz+o8TPl11DmspdaEzYLONtsveOMo=
X-Received: by 2002:ab0:300c:: with SMTP id f12mr861674ual.135.1573853972547;
 Fri, 15 Nov 2019 13:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20191115204306.3446-1-josef@toxicpanda.com>
In-Reply-To: <20191115204306.3446-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 15 Nov 2019 21:39:21 +0000
Message-ID: <CAL3q7H6T3uTHBizHUSgZZ+=BzZLV3PN7aJkEkjK94XCUDuDnAw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not corrupt the fs with rename exchange on a subvol
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 15, 2019 at 8:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Testing with the new fsstress support for subvolumes uncovered a pretty
> bad problem with rename exchange on subvolumes.  We're modifying two
> different subvolumes, but we only start the transaction on one of them,
> so the other one is not added to the dirty root list.  This is caught by
> btrfs_cow_block() with a warning because the root has not been updated,
> however if we do not modify this root again we'll end up pointing at an
> invalid root because the root item is never updated.
>
> Fix this by making sure we add the destination root to the trans list,
> the same as we do with normal renames.  This fixes the corruption.
>
> Fixes: cdd1fedf8261 ("btrfs: add support for RENAME_EXCHANGE and RENAME_W=
HITEOUT")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f6fc47525a52..56032c518b26 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9575,6 +9575,9 @@ static int btrfs_rename_exchange(struct inode *old_=
dir,
>                 goto out_notrans;
>         }
>
> +       if (dest !=3D root)
> +               btrfs_record_root_in_trans(trans, dest);
> +
>         /*
>          * We need to find a free sequence number both in the source and
>          * in the destination directory for the exchange.
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
