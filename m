Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8102D904BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfHPPfz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 11:35:55 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34328 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfHPPfy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 11:35:54 -0400
Received: by mail-ua1-f67.google.com with SMTP id r10so1655988uam.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Incy9kFWWtAF1qB9fN1m3LV4B/THxnZ/qrSQgvoX/Io=;
        b=l83pwP5yW8Fx5XWTe67t9It5AkEVscqKVcAggegmTiBkY0XGnxYftaub50kjc+LYF6
         3l0iFAY0zg79M+rXvICKYXmWj+75UlQl7S/1PEraxqUjTkgBq0OaOl4pBo5FmiaL9g0w
         EBCAyUFI3vXC4wlXo5/tjuoBqphqtlSZVu+nph5nuspMypmvK6Uua/TqzwSBN4QL0ya0
         wX2+KI1SAsX0dcnvsr2hjvDqWxeEt9c9F/gV9aGYse20KtmrN9KE6lwlO6j5emxwZOUB
         BLqZUlvyX4TNyYSc1ypC+wNaoYuF0dv6q0gGCWdtZSai+YHOZM6dwAzia1aacw+N8Fbx
         /4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Incy9kFWWtAF1qB9fN1m3LV4B/THxnZ/qrSQgvoX/Io=;
        b=iF8U3GPHBNi86Xaz/zeWgnYZLseNJz5z9PEdhmiOpHIyXUqyvrKOmnAJ6of44OXwAM
         Uru32KOMdbtC0oChxf8bv+XmQXHRN9ivrr6ijJgJG/m2HcE7ztG1E327kBGpkchpghZX
         vw4bFcZaa3BbBHNS4l3Mk0et5ooA2+JDSWJ1v4ssTjcq4BNeVv+nF3S/zeL5czSzC3JU
         z+yVslOmHwaIrytcvwTXdZF4cqRBZa8+ydPFDTgI7IeTK80VeBJZ6O29ZR/uYWenDV4n
         FANxCzF8CbVo27otNeLzDLcYrCEOwnQN6fPMueUEv+QLTG88mhzucmQZpya/NjUsn/+t
         IsaA==
X-Gm-Message-State: APjAAAWmzPHuF+ycrYmMbtSsoRdoxtGs9MeC5xawc08dODg7loW7FJd7
        sgeM/E0EIPCjxJfU8apN/8M3oY6x0YnSnbfoJks=
X-Google-Smtp-Source: APXvYqzmhE10Me2tUFXyEhCNE0S49UfkUqXKTtS6trHOFN9+VHKE3iwKxMD3SE2h+kU7g8oZ0DOAtiF1K6O1z3yom6I=
X-Received: by 2002:ab0:7811:: with SMTP id x17mr1501778uaq.83.1565969753359;
 Fri, 16 Aug 2019 08:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190816150600.9188-1-josef@toxicpanda.com> <20190816150600.9188-4-josef@toxicpanda.com>
In-Reply-To: <20190816150600.9188-4-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 16 Aug 2019 16:35:42 +0100
Message-ID: <CAL3q7H54WZOceHpcFQmADiuHFqWNAQOqbxN9o5J22qfHbx68HQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: global reserve fallback should use metadata_size
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 16, 2019 at 4:08 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We only use the global reserve fallback for truncates, so use

For truncates?
I would say only for unlinks, rmdir and removing empty block groups.
Or did some of your previous patches changed that, and I missed it,
and now only truncates use it?

> calc_metadata_size instead of calc_insert_metadata_size.

I wouldn't hurt to be less vague and mention why we do this change (if
this is still used for unlinks/bg removal, we still need to insertion
orphan item, not just remove items).

Thanks.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/transaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index f21416d68c2c..cc1a3000a344 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -636,7 +636,7 @@ struct btrfs_trans_handle *btrfs_start_transaction_fa=
llback_global_rsv(
>         if (IS_ERR(trans))
>                 return trans;
>
> -       num_bytes =3D btrfs_calc_insert_metadata_size(fs_info, num_items)=
;
> +       num_bytes =3D btrfs_calc_metadata_size(fs_info, num_items);
>         ret =3D btrfs_cond_migrate_bytes(fs_info, &fs_info->trans_block_r=
sv,
>                                        num_bytes, min_factor);
>         if (ret) {
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
