Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB72E4810
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 12:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502350AbfJYKCq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 06:02:46 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35163 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502347AbfJYKCp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 06:02:45 -0400
Received: by mail-vs1-f67.google.com with SMTP id k15so1074890vsp.2;
        Fri, 25 Oct 2019 03:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1dpvdESdNNZO8A0QegOAAzPsITBcaZ7esH282Ku6EX8=;
        b=ZgWgLuM7ky9Hb071dcQHEoh48trt9DDpLaHsoG3YtszTbD0999wLaeWAXExggv61/U
         C9IxJJarXlbeB3So5vK+3Ue3oDeM7qUMAHtWY+3mH5/P9CAQdo1Tozz9KlpPV/ZFipyX
         /ok2HIgoU42Hi0+qK2FQX1gEyCjE1r0qw+J0MEI3PZ7JfehpYxWhHHtNBQ0PjsOVDppb
         wLs4eJ3hdzfO1c/cMpOcC+w2u9+eF1EOxHPkPUyG/yvFoJezlynrS/vkHSaxB9vJjZ8P
         e5hi+mvgBcft8Sp95+kTGDgIzP+T9X3ZvWV0VnYETsOaJN+A+mAUYzzTpSqkGNyUVeQY
         mgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1dpvdESdNNZO8A0QegOAAzPsITBcaZ7esH282Ku6EX8=;
        b=CuXppzIIjKTZOc/nkqfwPLCi5LD2EejfmmNa/aUjmCkxAJIXe3q9x8Eq76C1yRc9td
         JyPZe6A1sdwVnRBb4zyA2fO/elGSf1jP6fMpLvxGuQ9/GEWDcEzhJPp6jIaF/lI0KTu2
         SfzAxmWavWw/rCG08/7Vz7sqadA0htIE3AT9NzOVjnSB5BJohzSQLBqnVr0GM1ZOLgEa
         sL9G+e/f1p2cLiKNim1UyajaWgUSMzRjGZK/fhSi/+Wqeat+XJfGFS9xPECfu1ljJheP
         Vp4hoqpO892PsB9OH+PR9JawYtSX+W08sWXCnOB32Wr8OZxfNCaMzHB9jSPo7Q/QW/ju
         K8Xg==
X-Gm-Message-State: APjAAAVXIO+tmBeV075s8Y7bGhFTx97Kforwv1xZ3tjSKTtd/1jUahkt
        WpDLc4J01/JqdbcGTnLOMMsAkn6iw6RB/aCGx4A=
X-Google-Smtp-Source: APXvYqyLIdQE9Pj9ftdOICpGGvJTw/M8UeZ9FfEWQVy/HsnXX0GhKnMNjJ2pssy2HzeCxxW09zXv03R+LjoagMxsdU4=
X-Received: by 2002:a67:fe8f:: with SMTP id b15mr1456846vsr.90.1571997764415;
 Fri, 25 Oct 2019 03:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191024023636.21124-1-marcos.souza.org@gmail.com> <20191024023636.21124-5-marcos.souza.org@gmail.com>
In-Reply-To: <20191024023636.21124-5-marcos.souza.org@gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 25 Oct 2019 11:02:33 +0100
Message-ID: <CAL3q7H63xK8DP84gUFjuK02tsUt_RX_R310Gdw6wjA6FD5rbwA@mail.gmail.com>
Subject: Re: [PATCH 4/5] btrfs: ctree.h: Add btrfs_is_snapshot function
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, mpdesouza@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 24, 2019 at 7:56 PM Marcos Paulo de Souza
<marcos.souza.org@gmail.com> wrote:
>
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>
> This new function takes a btrfs_root as argument, and returns true is
> root_key.offset is bigger than 0, meaning that this tree is a snapshot.
>
> This new function will be used by the next patch.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/ctree.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 19d669d12ca1..8502e9082914 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3411,6 +3411,20 @@ static inline int btrfs_defrag_cancelled(struct bt=
rfs_fs_info *fs_info)
>         return signal_pending(current);
>  }
>
> +/*
> + * btrfs_is_snapshot() - Verify is a tree is a snapshot
> + * @root: btrfs_root
> + *
> + * When the key.offset field of btrfs_root is bigger than 0 it means the=
 referred
> + * tree is a snapshot.
> + *
> + * Returns true if @root refers to a snapshot.
> + */
> +static inline bool btrfs_is_snapshot(struct btrfs_root *root)
> +{
> +       return root->root_key.offset > 0;

So this is not true for all roots. For log roots and relocation roots
for example, which are not snapshots,
the offset corresponds to the objectid of the root they are associated to.
So this isn't generic enough to have in ctree.h, and will create
confusion or potential bugs if anyone tries to use it in the future.

Since you only use this function in a later patch at the
subvolume/deletion ioctl, I would suggest using this directly in that
code only,
as there this assumption is true, since user space can't reference a
log or relocation tree in the ioctl call.

Thanks.


> +}
> +
>  #define in_range(b, first, len) ((b) >=3D (first) && (b) < (first) + (le=
n))
>
>  /* Sanity test specific functions */
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
