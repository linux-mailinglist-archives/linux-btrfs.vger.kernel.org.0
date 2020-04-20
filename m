Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B471B1339
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 19:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgDTRgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 13:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTRgI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 13:36:08 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F5DC061A0C;
        Mon, 20 Apr 2020 10:36:07 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id m24so3520470vsq.10;
        Mon, 20 Apr 2020 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=5n0ZpPXe9GxzwLdXMf5YrkeqFKsYHpJZC/15y27E0lk=;
        b=BolIF1k99WxEtleR/CBlGdyEsqXp4swwaSKBcOQaUgaoJUNm0ZUQm8WA88c3s/GZ5B
         lAi65pA+eL4ky0bHhoLXE8dP+PugBA9in2FEmJL6hyUAPunN23n+A/0tCjZLsvw+uJjB
         zfV3TBNOelZIlrxq1qlG+L91XVSXROfnTE9MRBMqFKnN+Ie0ZCP+o+Pp0X2YV2yIhIWO
         o1z/2bbFFw5m4Ev2/Eb0vxuIXFU3SEw1jxAf1RwIzhJcn0R+EEggMt4PYnNhQyEjx67q
         eAH4SrGvbk2xiX1wNT/d5XUEp/lZpBpB3uLNWGdN8bt/o04VKkyTPnsXCSfoXLijOqsZ
         4F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=5n0ZpPXe9GxzwLdXMf5YrkeqFKsYHpJZC/15y27E0lk=;
        b=TepofHGogsC8jBy1R8pN6im9mj/2npxvkwuf8pc6tYHndOvQRKqT8lQb/07eTQzZ6O
         H7dW8OGOPBJaIgp1HFrbXNa9xpUnySondGzBj+/K6PMs53OyzkDuWIpdHMwWb5OxN32f
         4LF7MOwdz5lvcMhwueexKF10a4Hh5YktMn7I2a7mh6nUa1S27oO3FIcYgw8Yqr8Ri8Ca
         7Ze04JVuR8MF45Yzled6LigiyOVy0HzvO57f7poIa9FPqd4aHfB+fX9BejJ+LkvYedA6
         abSKWvc2wpHnLm9LxhRw5vu6pMUPqqzEv5TDqOZ91/8BvvbxIab3F2TNMt039s2mEXY5
         ILqA==
X-Gm-Message-State: AGi0PuaFgjCQ33QQBXjwilBpzl4WS/pGisDTeYYfCRX4Uje5hY9NF0gE
        51u5QGeAiCuFNJ2qKwcrm7gMGCicA/zJR6bGPZI=
X-Google-Smtp-Source: APiQypJbt8ZGxFo0BWjlMluppj+6UrrFJXI1pGmutZw7wZmR+DQWrTrdFfgZWiyRzDNqaOE9XPpiD+egiMMb6leQRS4=
X-Received: by 2002:a67:f4ce:: with SMTP id s14mr10626206vsn.99.1587404167159;
 Mon, 20 Apr 2020 10:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <1587361180-83334-1-git-send-email-xiyuyang19@fudan.edu.cn> <CAL3q7H4hoSF6=S_ZqTCiKNed0NkFymemGZh4vrRNQ3Nrf9xwkA@mail.gmail.com>
In-Reply-To: <CAL3q7H4hoSF6=S_ZqTCiKNed0NkFymemGZh4vrRNQ3Nrf9xwkA@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 20 Apr 2020 18:35:56 +0100
Message-ID: <CAL3q7H4Yr2cdEgLWVAR2N_hPYEsra8yLA89meUMcvxH1VjtA6A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Fix refcnt leak in btrfs_recover_relocation
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 20, 2020 at 6:34 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Mon, Apr 20, 2020 at 6:50 AM Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote=
:
> >
> > btrfs_recover_relocation() invokes btrfs_join_transaction(), which join=
s
> > a btrfs_trans_handle object into transactions and returns a reference o=
f
> > it with increased refcount to "trans".
> >
> > When btrfs_recover_relocation() returns, "trans" becomes invalid, so th=
e
> > refcount should be decreased to keep refcount balanced.
> >
> > The reference counting issue happens in one exception handling path of
> > btrfs_recover_relocation(). When read_fs_root() failed, the refcnt
> > increased by btrfs_join_transaction() is not decreased, causing a refcn=
t
> > leak.
> >
> > Fix this issue by calling btrfs_end_transaction() on this error path
> > when read_fs_root() failed.
> >
> > Fixes: 79787eaab461 ("btrfs: replace many BUG_ONs with proper error
> > handling")
> > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Looks good, thanks.

Btw, the subject could be more clear.
Instead of

"btrfs: Fix refcnt leak in btrfs_recover_relocation"

something like

"btrfs: fix transaction leak in ..."

David can probably fixup that when he picks the patch.

Thanks.

>
> > ---
> >  fs/btrfs/relocation.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index 995d4b8b1cfd..46a451594c7a 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -4606,6 +4606,7 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
> >                 if (IS_ERR(fs_root)) {
> >                         err =3D PTR_ERR(fs_root);
> >                         list_add_tail(&reloc_root->root_list, &reloc_ro=
ots);
> > +                       btrfs_end_transaction(trans);
> >                         goto out_free;
> >                 }
> >
> > --
> > 2.7.4
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
