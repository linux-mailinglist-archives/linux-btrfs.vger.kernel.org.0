Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8AA27CCC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 14:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgI2Mij (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 08:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733253AbgI2MiX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 08:38:23 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B40C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 05:38:23 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c18so3359752qtw.5
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 05:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=phAEXEWmAdVM3SW4+RCxauQ6YqHXY90cPcXhqc8d3nc=;
        b=NXUveywkg2/nQrcV9/OWXZWgmDiy5xscULBiDh/3aqYMbVO1/+o3mKyazqXpBz0imK
         VmD3iFhgAlEzEeiQDEGZ5RCB1i+gGOkBKmnzHDQ3AKbUXIJXCL9kyxszAxjbnWdp7LeY
         WY2g8NEkJVRPxZ/Nlgc11aLumCyWp+VIfdfyCtrPF6qHSWuafjyLZqmNLycMIYPNsOMm
         q3QUYWpx0hWn4ZELQVDexl/dmGj61gZZlu0IIZYspLDOrjkSDrWrF9L+EHsPrNeRMjZe
         SMKMs04hNwr+Frgw5PmB5Pip4GCI0dhhGLrsQ/qFRRQGFRuns0myQ7fU/XUm8+L2l45r
         MT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=phAEXEWmAdVM3SW4+RCxauQ6YqHXY90cPcXhqc8d3nc=;
        b=ooK1yV/hvzuAyj67e6mtBwLlWMxn3XzbuyTZavTcmD7XDUkvve0teB664Z08qXCklK
         rrUjIH8VVaEC9ZS3guYIhE9+8C9j+W+m/iahqLcmhg+sCjAfjygr36qN+YNh7/CCKN2n
         KgUAjFKovD/aMgiw2fl398q9SqHuISwyiKkLGVaq+sfnBFBMsyeYR8HXUYeXNvQSJBfa
         NUhHu10lVG3MN43KV2eF/RTDZ3E5OpriTnY1xH1P//HYtXlu5wVGQMXzzw4ZeHqITxn5
         sHSBKgebTZVlnCJsBpX45wylQE1ySmwiBANwuc2rmVK0ssILrguS8LLwWHuqKOVm5Sg1
         lgmw==
X-Gm-Message-State: AOAM530RaAyvcjmu2+y0jAs8rBWrbkGVn4uO8gaOElxkLXm6OssuG5TH
        hKARYu0vPAiyl6+6Jv7E3uxikFNs11RI4IFFnnI=
X-Google-Smtp-Source: ABdhPJyEjc5iiYt5+zN6vka/jHODxAdOAKLI7gFVqwY0j7udLOJmIISEjA+uWoOmPcifW4ks4dCBFGMh1wHlvAxg9uU=
X-Received: by 2002:ac8:7613:: with SMTP id t19mr3127117qtq.259.1601383102433;
 Tue, 29 Sep 2020 05:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <7706fb8d62576840c3e7dd69b326b1ae9e6d3ab7.1601304541.git.josef@toxicpanda.com>
In-Reply-To: <7706fb8d62576840c3e7dd69b326b1ae9e6d3ab7.1601304541.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 29 Sep 2020 13:38:11 +0100
Message-ID: <CAL3q7H4rnyY5pcwb9uUt6tob_+JfJS6P+J4A9OrAtEncquc3gg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: unlock the cow block on error
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 28, 2020 at 3:52 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> With my automated fstest runs I noticed one of my workers didn't report
> results.  Turns out it was hung trying to write back inodes, and the
> write back thread was stuck trying to lock an extent buffer
>
> [root@xfstests2 xfstests-dev]# cat /proc/2143497/stack
> [<0>] __btrfs_tree_lock+0x108/0x250
> [<0>] lock_extent_buffer_for_io+0x35e/0x3a0
> [<0>] btree_write_cache_pages+0x15a/0x3b0
> [<0>] do_writepages+0x28/0xb0
> [<0>] __writeback_single_inode+0x54/0x5c0
> [<0>] writeback_sb_inodes+0x1e8/0x510
> [<0>] wb_writeback+0xcc/0x440
> [<0>] wb_workfn+0xd7/0x650
> [<0>] process_one_work+0x236/0x560
> [<0>] worker_thread+0x55/0x3c0
> [<0>] kthread+0x13a/0x150
> [<0>] ret_from_fork+0x1f/0x30
>
> This is because we got an error while cow'ing a block, specifically here
>
>         if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
>                 ret =3D btrfs_reloc_cow_block(trans, root, buf, cow);
>                 if (ret) {
>                         btrfs_abort_transaction(trans, ret);
>                         return ret;
>                 }
>         }
>
> The problem here is that as soon as we allocate the new block it is
> locked and marked dirty in the btree inode.  This means that we could
> attempt to writeback this block and need to lock the extent buffer.
> However we're not unlocking it here and thus we deadlock.
>
> Fix this by unlocking the cow block if we have any errors inside of
> __btrfs_cow_block.
>
> Fixes: 65b51a009e29 ("btrfs_search_slot: reduce lock contention by cowing=
 in two stages")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ctree.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a165093739c4..a6b6d1f74f23 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1064,6 +1064,7 @@ static noinline int __btrfs_cow_block(struct btrfs_=
trans_handle *trans,
>
>         ret =3D update_ref_for_cow(trans, root, buf, cow, &last_ref);
>         if (ret) {
> +               btrfs_tree_unlock(cow);
>                 btrfs_abort_transaction(trans, ret);
>                 return ret;
>         }
> @@ -1071,6 +1072,7 @@ static noinline int __btrfs_cow_block(struct btrfs_=
trans_handle *trans,
>         if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
>                 ret =3D btrfs_reloc_cow_block(trans, root, buf, cow);
>                 if (ret) {
> +                       btrfs_tree_unlock(cow);
>                         btrfs_abort_transaction(trans, ret);
>                         return ret;
>                 }
> @@ -1103,6 +1105,7 @@ static noinline int __btrfs_cow_block(struct btrfs_=
trans_handle *trans,
>                 if (last_ref) {
>                         ret =3D tree_mod_log_free_eb(buf);
>                         if (ret) {
> +                               btrfs_tree_unlock(cow);
>                                 btrfs_abort_transaction(trans, ret);
>                                 return ret;
>                         }
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
