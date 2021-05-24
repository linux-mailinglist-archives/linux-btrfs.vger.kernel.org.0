Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1606538E4A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 12:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhEXK54 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 06:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhEXK5z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 06:57:55 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4801C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 24 May 2021 03:56:26 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id a7so9601072qvf.11
        for <linux-btrfs@vger.kernel.org>; Mon, 24 May 2021 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZrWVkuiX03aQM0Dhq8LY1qWGI/W0i1xvB1m1uLsSAUY=;
        b=Ja1j9zd14R10CZDJqVx/2shuh/4vb0edW1hfcslLbMn5HKK5QabVDOE5o+uIvblaaI
         HLlpNef0aJRRZVFQIAHbhTsDl37ZKTBVCx0vA5PU2ZDcUl0XBIag5L0mbT/BkSV2pLcO
         cQPhiGcDGEoqOCmDTB2R159cOLIcUxVS/lUPL0qkvm9t+WZTlXWn0slRu8orSBeyfpIS
         9f0KG3U46ooUPI++c3NAgtgQqd3HT/G4MkjA2qSBJT60rXCwVZLlO98xXOJu5Tmk90rB
         He3LiGOh+umN5/5fjyvZgestlr7KDgZGjKcBhceJxJhksGznATglslGVqseR7x8gVNAq
         eE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZrWVkuiX03aQM0Dhq8LY1qWGI/W0i1xvB1m1uLsSAUY=;
        b=rMguV6dkJiVQ0du4ZpF4LbGDkARWnfwgP7yQZJk2Qazd0sS6cutbjzBK62S0Y7LzoO
         GnpDJEQ5ZGTl71UCTojsv+lyQ6rGDUa+oQg+paugXzbNV+D8jCj1YMnlls4wpAfjlGLE
         qjg+DKiiI1rOPqRw7hdxhpYEgKYRttOa1pHe/ABxyYpPxsgq0H/FLGggmmZltixyT469
         GkvjRSDaeZ9mX8JyPWFg2VCR9bHdbZi8xQYPsNYkVglwl+hk5tivXSf+fOHI7Dgp1vOf
         J4lbWhoxxT4aReg9W2sDuAuZXut57brCYSs0WfUr+kaAplFsDe20An4E1Z4ZXULJkYnH
         dzzg==
X-Gm-Message-State: AOAM531QKnJFhngRZHdXqViGaepIHZihPuMS+5CQbiTycwitopLm+oyx
        yK6tyH4GZYrQ6JVT2kLnNyl/BCDREOCDx8v+3r4=
X-Google-Smtp-Source: ABdhPJxJjofxqOhiSi6s/4Dm7znw8LiB6szk08XWpTZYgTD00LDHiCDmXzzqU9mpoD30E2EoPsH0QpLHu221TfZaQ3w=
X-Received: by 2002:a05:6214:17cb:: with SMTP id cu11mr29818986qvb.27.1621853785887;
 Mon, 24 May 2021 03:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210521064050.191164-1-wqu@suse.com> <20210521064050.191164-28-wqu@suse.com>
In-Reply-To: <20210521064050.191164-28-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 24 May 2021 11:56:15 +0100
Message-ID: <CAL3q7H7jC+WL6LnqR+6uQ_fvjBOX2-w82z9ATE8XrkXa34C7gg@mail.gmail.com>
Subject: Re: [PATCH v3 27/31] btrfs: fix a crash caused by race between
 prepare_pages() and btrfs_releasepage()
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 21, 2021 at 9:08 PM Qu Wenruo <wqu@suse.com> wrote:
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

Pasting here the tracing results form some custom tracepoints you
added for your own debugging does not add that much value IMHO, anyone
reading this will not know the exact places where the tracepoints were
added,
plus the previous explanation is clear enough.

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
> index 6ef44afa939c..a4c092028bb6 100644
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
> +                * a window where fadvice() can try to release the page.
> +                * Here we check both inode mapping and PagePrivate() to
> +                * make sure the page is not released.
> +                *
> +                * The priavte flag check is essential for subpage as we =
need
> +                * to store extra bitmap using page->private.
> +                */
> +               if (page->mapping !=3D inode->i_mapping || !PagePrivate(p=
age)) {

My comments from v1 still apply here:

https://lore.kernel.org/linux-btrfs/CAL3q7H5P79kEqWUnN2QKG92N3u7+G0uWbmeC0y=
T1LypV63MAYA@mail.gmail.com/

The code looks good.
Thanks.

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
