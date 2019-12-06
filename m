Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F82A1155B1
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 17:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFQrM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 11:47:12 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38850 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLFQrL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 11:47:11 -0500
Received: by mail-vs1-f65.google.com with SMTP id y195so5485955vsy.5
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 08:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=r2BRr5SAYmxghPLetCJgg2jivq3Lug3xlMMm9GGcE1Y=;
        b=f2aCii/JTyOdLPWBxB/8njU34HXdu/oKtYkyy6oBVbID0QED9Mfun39kc3uHgugYMS
         ZzCRcl8X0ov4ixk53tfp00KIKZrA8awA0H9UvFUprBLimE5w51QTY62y7e1tnDcV0HLm
         K6w8ad/46EAv1fAynOgjmW0CDLCA3dHfdTBhjw8U8X4wdIChulBO+PRfYXdTgPWD7mgl
         MNCaW7wrvaZVDtk5UgOqlYhUDtueXLOdYDM3u7CstgKkEjviL1MWdSv2+eBzjw/3bfTe
         8fRnSVp/RMrgzdNY7GIPUYSpyp5mz089hNJs4+yD+avVs2SBdPbvHcAHiyHI8HiBPCU9
         Crvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=r2BRr5SAYmxghPLetCJgg2jivq3Lug3xlMMm9GGcE1Y=;
        b=gpkjiFVyKwdBXnQdorcp7GAY0az4nR2uO/1NpFH4XMWzmeOsUmvjPYNBDOQFoeFFB1
         f00yyd4oBqPGNwgSu7cOikN0V5W0puRS3+WQ/agBnPxLZvloqT6uRWKdLuPD82Y2YVBq
         P4W5KhW2BT1BRLP+ejLnEcWGMveN+nMMKYznP+XPNv8/PzsFKDbN8UQTN5QPkmJuhp1K
         tv+FsRncueoxZLaa1+pNZlzTeA4kdjyssbJOuNE+YfGvkWiIR5XOEAJYbNjLzMRzEgYh
         ol9/rU+/qFa2q3bCV3P2hvSmcPud08rp4sCkavBvzFxAe+Pt0uLBaMcxA0Bs3O2zElUj
         EeOg==
X-Gm-Message-State: APjAAAU9tOKKLX6N0RiqpGMW4mcVRS6iKUoPFDUwuSVTzK5nJSNLUeLe
        GI9K8HvcJW46LZs/khsPl7t5fokpvtCW+dRxc8Y=
X-Google-Smtp-Source: APXvYqxBRbFT4MMcqiO8gHmOhF1jxQUMqStkum4uT0tEHpCYSFTfPubZZ47ZxcaFEGBJMCgWYcplonZWHuQAZyvwuqk=
X-Received: by 2002:a67:8703:: with SMTP id j3mr9605222vsd.99.1575650830729;
 Fri, 06 Dec 2019 08:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20191206143718.167998-4-josef@toxicpanda.com> <20191206163900.168465-1-josef@toxicpanda.com>
In-Reply-To: <20191206163900.168465-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Dec 2019 16:46:59 +0000
Message-ID: <CAL3q7H6yqLhfTJbpBVKg3NTC1Z17or7Hfs=5xyWDxTay_z=Ziw@mail.gmail.com>
Subject: Re: [PATCH 3/5][v2] btrfs: handle ENOENT in btrfs_uuid_tree_iterate
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 6, 2019 at 4:39 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> If we get an -ENOENT back from btrfs_uuid_iter_rem when iterating the
> uuid tree we'll just continue and do btrfs_next_item().  However we've
> done a btrfs_release_path() at this point and no longer have a valid
> path.  So increment the key and go back and do a normal search.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Now it looks good, thanks.

> ---
> v1->v2:
> - increase key.offset instead of key.objectid so we don't skip over a bun=
ch of
>   keys.
>
>  fs/btrfs/uuid-tree.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
> index 91caab63bdf5..76b84f2397b1 100644
> --- a/fs/btrfs/uuid-tree.c
> +++ b/fs/btrfs/uuid-tree.c
> @@ -324,6 +324,8 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_=
info,
>                                 }
>                                 if (ret < 0 && ret !=3D -ENOENT)
>                                         goto out;
> +                               key.offset++;
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
