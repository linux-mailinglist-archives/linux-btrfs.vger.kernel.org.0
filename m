Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5847C2F30C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 14:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbhALNKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 08:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbhALNKt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 08:10:49 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F4AC061575
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 05:10:09 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id h16so836870qvu.8
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 05:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/eSsD/IINuGZWdC9eYz8X4AyHQtiDe3Tjifcuep0+Vc=;
        b=uVvCKPb2yFkmxH0WpqgTAuAOInUdpcrhublX+B9JO4JeA5kCOhD54MM4ZkPU/u6/ib
         cWAbklTlJDi00idT6Iyr2AM9nEbkcBmCYIuGhPbvc4jqRmibknP1+KCdAIlyjQz2hPg0
         nfi+A+glrXZtd5b4QdXooTuToiCscHVeZCaE6IKSEasNY377lGNnGcD82sGgdkBqjj4a
         wCxgGiiF0xeok0WR2xwYBGd78Q0GdrJJndwM4dgdYAWDVf/JghVijOvDeR2CFXOiWtPk
         AV8IsxPZwMUM6gXCLb+effO4SkHT42VzXzs9DLKPQ4D+niY60TsoxZt5lGcJB+DWyBZp
         q/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/eSsD/IINuGZWdC9eYz8X4AyHQtiDe3Tjifcuep0+Vc=;
        b=kznzqz9KkM6HT/o3vic1Or2Kj2tefUG5W6EGiPcUUjAOM9NveQhfWMOAH5qnlC7N0R
         Lzh2YjjXWlh1iUmex6TQ26jbIQRU0BzFR8LeOGh0NtaWs3UJXhQDth+HPdKBLpSviDHc
         0dyD/oJCV9ie0vHgtOxSuGTBGRaGpelW9bVEOcQgHfwIZ1fcnYdYdkOdeltwNB4n8N1u
         JVNdtWq+4GRZdr4CY4z5CNV+I9HDjbNX5+39b2MZBHSgk/c3iDdImsk6KZ3lh/ozjGMA
         GbiTfbTD4kbEhEX2erkTDMhtxV+ZNtJoI/kgq0tRiqd1QDu3Lfq0H/gYCemLIhWjJ10X
         JssQ==
X-Gm-Message-State: AOAM530D8D4jeuaNrKLKQOQCQGil7OtwHNmcCwlZ9V9HcMOrzIkexIWl
        Xg29sjCklnchZBMdnRwWg2UkRc2AA7I6kGfPvmLRCdm9j2w=
X-Google-Smtp-Source: ABdhPJzht6XXsHnkZr4Rqm56kzrJ+BB86OV6s/0QBuyfqK/Ts6u1m2VtmP98l6HEeR5j+STvXTIYVeihKC7AVfQtlDY=
X-Received: by 2002:a0c:da87:: with SMTP id z7mr4630485qvj.41.1610457007820;
 Tue, 12 Jan 2021 05:10:07 -0800 (PST)
MIME-Version: 1.0
References: <169ba15cd316c181042bbe25e7d10c7963e3b7e8.1610444879.git.anand.jain@oracle.com>
In-Reply-To: <169ba15cd316c181042bbe25e7d10c7963e3b7e8.1610444879.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 12 Jan 2021 13:09:56 +0000
Message-ID: <CAL3q7H7Ks-A5AO76rS2pW9QGspcSA0JpBJdLymHaapuPAR=VgQ@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: no need to transition to rdonly for ENOSPC error
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 12, 2021 at 1:01 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> In the current kernel both scrub and balance fails due to ENOSPC,
> however there is no reason that it should be transitioned to the
> RDONLY and making free spaces difficult.

No way.

There are plenty of places where ignoring an ENOSPC would leave the
filesystem in an inconsistent state.
Like anything that needs to do a series of btree modifications, we
want to make sure no one is able to commit the transaction if we do
the first update but fail the second for example.
For example, btrfs_finish_ordered_io() (delete and insert new extent
in subvolume tree, add checksums, etc).

Thanks.

>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/super.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 12d7d3be7cd4..8c1b858f55c4 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -172,6 +172,9 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs=
_info, const char *function
>         if (sb_rdonly(sb))
>                 return;
>
> +       if (errno =3D=3D -ENOSPC)
> +               return;
> +
>         btrfs_discard_stop(fs_info);
>
>         /* btrfs handle error by forcing the filesystem readonly */
> --
> 2.18.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
