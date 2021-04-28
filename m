Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A61936D602
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 12:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbhD1K5Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 06:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbhD1K5Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 06:57:16 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3993C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 03:56:30 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id q4so17979428qtn.5
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=OD6Hi4nLGg76PuWCpjxTWVENAfu0hGMuqrkJmSY6k1I=;
        b=sn3UxI+MMm+mi8Yw4toWiz+EvMARHA6b5nnCF8ARpsvZmN5Ybbj1Jew4w2govg/kBu
         t239TM2iIG4Q8cjvcyYw7Qz/OOe0+bfYUNZYLzyankSXHMekaWk6c8wjY+zcFhmfg0jR
         I5Li1Z2AUOeYBwZ7DXzRPeYAIM10LgOUUUQa+kBSZyJhEbMbkQyP/1fvo2E5GffT0oum
         zFxH8v0GkzpvotDtJ1NY54h1jlJkS6oXH0ZE6/TTuTdXPECHTwzpBtC+CBlkutTqPHVU
         0jvl0IIUqVOn6c5N8I2O2aZLXIKYjKxeI1WggGRhAiZrlSH2X7WV11uJfy5D5oZiQAiB
         klyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=OD6Hi4nLGg76PuWCpjxTWVENAfu0hGMuqrkJmSY6k1I=;
        b=NMLn/fWtdbu1PLiuS/s1E1L+5q+guRqVXg0lXG5S6sxWdi2jTHwS553f1sEP2DhGwO
         POosgR8rgqayIUA+EBtnzaX9UcKeU6FQE8e75E9d91+trKj8JxSpw7/1OHynBRGU+z8k
         gypLs4DVwDtmoYpblLjGzYejR8oHTCzuwMBaPTnaM9XbO04oNkZx+eVX/F6eYqtZLli9
         zZpIV8WeVHw1g8fXZIHVp/lV+FUxHa80dQVbUi/EPfU+5HSzjt8xg6opsIcf0mBH4OWj
         1X29awrLml23O2mYw6ac18yc+U4y9rV6mux4O1foDRy3XVIJZoadWeVT0XK2XXCYJJ5a
         3FZg==
X-Gm-Message-State: AOAM531ddKDIddUFDrQDm5TnSCS/AvL7H7BPC5BJTiKRVgoG0t7MG4S2
        RRdOzuflm1+HVxERh4nEWOhSveDC4U3tAYwKCAc=
X-Google-Smtp-Source: ABdhPJwpNbiK8YYFpL1apX+O5647TzI76pc0o0oYE2P75RRYEXd+C5ij8tcmNH4xPiGbQQS9YeFXVpMe+T0r1Pwz9mE=
X-Received: by 2002:ac8:5b81:: with SMTP id a1mr5524160qta.259.1619607389734;
 Wed, 28 Apr 2021 03:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210427230349.369603-1-wqu@suse.com> <20210427230349.369603-41-wqu@suse.com>
In-Reply-To: <20210427230349.369603-41-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 28 Apr 2021 11:56:18 +0100
Message-ID: <CAL3q7H5P79kEqWUnN2QKG92N3u7+G0uWbmeC0yT1LypV63MAYA@mail.gmail.com>
Subject: Re: [Patch v2 40/42] btrfs: fix a crash caused by race between
 prepare_pages() and btrfs_releasepage()
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 12:06 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running generic/095, there is a high chance to crash with subpage
> data RW support:
>  assertion failed: PagePrivate(page) && page->private, in fs/btrfs/subpag=
e.c:171
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/ctree.h:3403!
>  Internal error: Oops - BUG: 0 [#1] SMP
>  CPU: 1 PID: 3567 Comm: fio Tainted: G         C O      5.12.0-rc7-custom=
+ #17
>  Hardware name: Khadas VIM3 (DT)
>  Call trace:
>   assertfail.constprop.0+0x28/0x2c [btrfs]
>   btrfs_subpage_assert+0x80/0xa0 [btrfs]
>   btrfs_subpage_set_uptodate+0x34/0xec [btrfs]
>   btrfs_page_clamp_set_uptodate+0x74/0xa4 [btrfs]
>   btrfs_dirty_pages+0x160/0x270 [btrfs]
>   btrfs_buffered_write+0x444/0x630 [btrfs]
>   btrfs_direct_write+0x1cc/0x2d0 [btrfs]
>   btrfs_file_write_iter+0xc0/0x160 [btrfs]
>   new_sync_write+0xe8/0x180
>   vfs_write+0x1b4/0x210
>   ksys_pwrite64+0x7c/0xc0
>   __arm64_sys_pwrite64+0x24/0x30
>   el0_svc_common.constprop.0+0x70/0x140
>   do_el0_svc+0x28/0x90
>   el0_svc+0x2c/0x54
>   el0_sync_handler+0x1a8/0x1ac
>   el0_sync+0x170/0x180
>  Code: f0000160 913be042 913c4000 955444bc (d4210000)
>  ---[ end trace 3fdd39f4cccedd68 ]---
>
> [CAUSE]
> Although prepare_pages() calls find_or_create_page(), which returns the
> page locked, but in later prepare_uptodate_page() calls, we may call
> btrfs_readpage() which unlocked the page.
>
> This leaves a window where btrfs_releasepage() can sneak in and release
> the page.
>
> This can be proven by the dying ftrace dump:
>  fio-3567 : prepare_pages: r/i=3D5/257 page_offset=3D262144 private=3D1 a=
fter set extent map
>  fio-3536 : __btrfs_releasepage.part.0: r/i=3D5/257 page_offset=3D262144 =
private=3D1 clear extent map
>  fio-3567 : prepare_uptodate_page.part.0: r/i=3D5/257 page_offset=3D26214=
4 private=3D0 after readpage
>  fio-3567 : btrfs_dirty_pages: r/i=3D5/257 page_offset=3D262144 private=
=3D0  NOT PRIVATE
>
> [FIX]
> In prepare_uptodate_page(), we should not only check page->mapping, but
> also PagePrivate() to ensure we are still hold a correct page which has
> proper fs context setup.
>
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 45ec3f5ef839..70a36852b680 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct inode *ino=
de,
>                         unlock_page(page);
>                         return -EIO;
>                 }
> -               if (page->mapping !=3D inode->i_mapping) {
> +
> +               /*
> +                * Since btrfs_readpage() will get the page unlocked, we =
have

I find the phrasing slightly confusing - saying btrfs_readpage() will
get the page unlocked, gives the idea we pass it an unlocked page.
Saying that btrfs_readpage() unlocks the page before it returns is more cle=
ar.

> +                * a window where fadvice() can try to release the page.

The race is far more generic and is related to another task calling
btrfs_releasepage() before we are able to lock the page again.
Can happen due to memory pressure, page migration, etc - certainly not
specific to a concurrent fadvise() (and not fadvice) call.

So I would mention a concurrent btrfs_releasepage() call and not fadvise().

> +                * Here we check both inode mapping and PagePrivate() to
> +                * make sure the page is not released.
> +                *
> +                * The priavte flag check is essential for subpage as we =
need

priavte -> private

Other than that it looks good.
Thanks.

> +                * to store extra bitmap using page->private.
> +                */
> +               if (page->mapping !=3D inode->i_mapping || !PagePrivate(p=
age)) {
>                         unlock_page(page);
>                         return -EAGAIN;
>                 }
> --
> 2.31.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
