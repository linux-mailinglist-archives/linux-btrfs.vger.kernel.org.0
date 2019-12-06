Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 153AD1153FF
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 16:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLFPNe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 10:13:34 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36894 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFPNe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 10:13:34 -0500
Received: by mail-vs1-f67.google.com with SMTP id x18so5260876vsq.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 07:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7xlzARSx3nOb2fCc4ZlAC7E6r+O9JNiGfs8KLdtlRYA=;
        b=WfzR97nhikliKdXiQQLPYgyyeB60u4gSLEiWsbqQHBDVskvErBEIWlQMDn/OCDKqBn
         Kas/Gq+43VwLTrekNexKqchnZD/NzKpsbfegtj5nwD/dluK06CHrNAxqnzVu30GaAe30
         w1cRyCfU5gH0cTwdQbWpjLl3/tl0zVsFtPpvOc4e8blEuOHmGaVBun/0v3zLsNN8DjkR
         w57VxiqZFVF5wYFcHrNh+LwpS6LUMcIPxr9v6u3IsXcyRe4J75IX/4NiGphIiQHW2Oil
         evrVL2IU5FCLJb2BdFEb5swBuRJ44WK2zJiMACqwLfAwkdhqJC1zwo78JBDfg+GpMYYf
         3AVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7xlzARSx3nOb2fCc4ZlAC7E6r+O9JNiGfs8KLdtlRYA=;
        b=h7lpD7uUmoas1Nzoc60khnOzVQw2n1anmV2dSaaKQj2kEDVGvz8yFlyrfadazrF0iG
         XmekId909XSSAvQXBL2RdVX/pRAmIFzkhtJvyMmmNSXHl4JKmO8xgzGpquMQ3tR1XAcy
         A5DCuNxi9KpR/DVJIRXocn6vEGv3fRiSykLXxd5Cc0Y9m4Tyu7tbq7Pe45Rq29as8vHF
         9QELV5zOEmO6upLZPMICUJVIviOCqQPP06SHy54NNffgiKjC0w7MyLoMiYNH7fFV8xch
         6JDdp1YGLPBOr10GDPaqGfyPlj3fEb6YML+1g77jSTJsrEgsr8sgmxuP881MNT4WbAv0
         ooIw==
X-Gm-Message-State: APjAAAXyZj8SOsVoDO92q/l4ciSlJSj7wpsN17/z+WMHc3sjAD40HILj
        hJkSnAMY3WBM0hNJ6z9fxXDlLraII4SuYsOQk5g=
X-Google-Smtp-Source: APXvYqxco4LiY4FQoPPeYsMppGj+Dpc/29QqFqNsULQp7liYRJzsVsidQjNQaSeMdpXCpzJN2/iy+WMlpasmIa0wXHU=
X-Received: by 2002:a67:7acd:: with SMTP id v196mr9287382vsc.95.1575645213116;
 Fri, 06 Dec 2019 07:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20191206143718.167998-1-josef@toxicpanda.com> <20191206143718.167998-4-josef@toxicpanda.com>
In-Reply-To: <20191206143718.167998-4-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Dec 2019 15:13:21 +0000
Message-ID: <CAL3q7H6BfCF1fN8Wtn=k2-oWFoqojiGjkKZ5q2O=wWXbuEyfYg@mail.gmail.com>
Subject: Re: [PATCH 3/5] btrfs: handle ENOENT in btrfs_uuid_tree_iterate
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 6, 2019 at 2:38 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> If we get an -ENOENT back from btrfs_uuid_iter_rem when iterating the
> uuid tree we'll just continue and do btrfs_next_item().  However we've
> done a btrfs_release_path() at this point and no longer have a valid
> path.  So increment the key and go back and do a normal search.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/uuid-tree.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
> index 91caab63bdf5..8871e0bb3b69 100644
> --- a/fs/btrfs/uuid-tree.c
> +++ b/fs/btrfs/uuid-tree.c
> @@ -324,6 +324,8 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_=
info,
>                                 }
>                                 if (ret < 0 && ret !=3D -ENOENT)
>                                         goto out;
> +                               key.objectid++;

Why not key.offset++ instead?
By incrementing the objectid it seems we can skip the key for another
subvolume with an uuid having the same value for its first 8 bytes as
the current one, no?

thanks

> +                               goto again_search_slot;
>                         }
>                         item_size -=3D sizeof(subid_le);
>                         offset +=3D sizeof(subid_le);
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
