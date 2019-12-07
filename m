Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4E3115DB5
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 18:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLGRQX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Dec 2019 12:16:23 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46213 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLGRQX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Dec 2019 12:16:23 -0500
Received: by mail-vs1-f65.google.com with SMTP id t12so7350923vso.13;
        Sat, 07 Dec 2019 09:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=fv2VocPZa+NTPGDaoTSLQUtwO0St7yGYFGMsw/ZDHX8=;
        b=UCPL97fki2BRqCTclNHm7WJ1MCOgYnD3qF+O/qPNrN8hbd8UUH+TanuK8fnkbXUVLL
         NFJ+u1JUbklRYI0mzyDogNRpbF2DSuW3N0LPwD4o79IkN3h3ir202qs+Aqw8RRDJ7a5L
         tGXglbbJbjd8dMsCa2+lWDieZOfTaNfqG6LNjDn0VSsBvZWfiTkkNTw7h29Gyeqe4mpR
         75FDxrvLfo74ybLifBaR+DAoe6V0xuJKjX8DORl0dMekfvGHEUgY4QuVIo1CyK9nxSz+
         /HnbMB6w9xB6laDs6QkAHIl9H2vVFDAYY3hEdj1xWXjj4LxpLZ45lIKNoWzAqw8rsR9V
         FckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=fv2VocPZa+NTPGDaoTSLQUtwO0St7yGYFGMsw/ZDHX8=;
        b=ghPHEZk7LJY0rUJbG54F+dYxE6dE/Afx7RcGChERwp9X8R+jl10SY7J5C7Ga6QVAII
         M+CVNVR25MwoUQ6XO9MoQlbvNIpjVYbrfup/tqmbcQxzouOoYKHTAZqLN7pMULFhh2Ap
         67+IjAwVdjW8hQxGstYZ7kNW/YT386YPnNFXwAVrLAdko4P6oQMNf2utBCCEW9Pea1qD
         XKxgXDu2z/OzCtYXScSkfBc8U4F9PeaMGNIVtOaKy4jy5EiuNjAjnTtVxVHCPHRpNx9e
         TL/FCtncn2fisqmG40XU844lcy3+Wi8u7hGPhdvsj6mwfCyGssu5pZQM/54TpaUnWQhp
         Zk7w==
X-Gm-Message-State: APjAAAVMm5eY/IK307jL5lB8O1ffO1UjHxRpbnIxXaTOn6suATKXAqhg
        n8qBYNPBb3JlJZ3WywAaR98coiQQ9YrCQ45jsNM=
X-Google-Smtp-Source: APXvYqy78Bz6j/LjqlaXz7HF8BhLRlmuB2RInRa+D3etpDSbE/UBNdTUsRu3qDinxD1lJ7AETehudMylEAtfTeskuN0=
X-Received: by 2002:a67:8010:: with SMTP id b16mr14115611vsd.90.1575738981848;
 Sat, 07 Dec 2019 09:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20191207144126.14320-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20191207144126.14320-1-dinghao.liu@zju.edu.cn>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sat, 7 Dec 2019 17:16:10 +0000
Message-ID: <CAL3q7H48ObWGwY=C=L45CKkC4D1nLUr0s3_YUwHPSCmirKmidA@mail.gmail.com>
Subject: Re: [PATCH] fs: Fix a missing check bug
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, pakki001@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 7, 2019 at 3:03 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> The return value of link_free_space(ctl, info) is checked out-sync. Only =
one branch of an if statement checks this return value after WARN_ON(ret).
>
> Since this path pair is similar in semantic, there might be a missing che=
ck bug.
>
> Fix this by simply adding a check on ret.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  fs/btrfs/free-space-cache.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 3283da419200..acbb3a59d344 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2437,6 +2437,8 @@ int btrfs_remove_free_space(struct btrfs_block_grou=
p *block_group,
>                         if (info->bytes) {
>                                 ret =3D link_free_space(ctl, info);
>                                 WARN_ON(ret);
> +                               if (ret)

I think the WARN_ON() can go away as well.
The only possible error is -EEXIST, coming from tree_insert_offset().
When that happens tree_insert_offset() already emits a warning.

Also, the free space entry needs to be freed, otherwise we leak
memory. So it should be something like this:

if (ret) {
    kmem_cache_free(btrfs_free_space_cachep, info);
    goto out_unlock;
}

Further the subject should be prefixed with "btrfs: " and not "fs: ",
since this is a btrfs specific patch.
Something like the following for example:

"btrfs: add missing error handling when removing free space"

Thanks.

> +                                       goto out_lock;
>                         } else {
>                                 kmem_cache_free(btrfs_free_space_cachep, =
info);
>                         }
> --
> 2.21.0 (Apple Git-122)
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
