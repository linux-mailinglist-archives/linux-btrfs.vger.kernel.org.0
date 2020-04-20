Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF531B1333
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 19:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDTReT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 13:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDTReT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 13:34:19 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF3C061A0C;
        Mon, 20 Apr 2020 10:34:19 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id f59so3562261uaf.9;
        Mon, 20 Apr 2020 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=gcB23t+jScaSb8EiQ7ZHe/5VkN2VlLAEfN9UOZ8SFc0=;
        b=YkcOT4mjV3/A2UoHDoE9luwx2zPUDK2aNbV1JyfOBa61OpBYzbxxQYtP29Y0UPSfII
         f4fZcvqZz0UBDUKQmUzYg8c0ciBtUduKgfj9GH9LfQLSxHYVSbrVdiaepqm7lPibNmlf
         OaYpAiHYup4Ip9SHpQZ2SDalm1jlq+MrppsymQ/rGlqs0hVTS3L1ObZ1uW4YTe9SgK5t
         /3k6sbyHk1JJzVOJvEXEpKSXEYaae9evx+VNdKViJ2GW9aQ8C66TnrFPaIdUKM+e6l1W
         dTkn37zEB9A3+VgAlAUmQS8C+cD8O/PQoGBXXs1kso4v2xvjwgct/H/2CCRMiYj0VYPn
         hhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=gcB23t+jScaSb8EiQ7ZHe/5VkN2VlLAEfN9UOZ8SFc0=;
        b=EZMPbPDML/knpHV9rYReEzWR5grXgrEXXbUvjJ4886e53EHkFVk3CkqFQMnywAdneV
         TMrD3pfm7NYtVTe43ZEe9K/4fZEyW4iNw+Bed6AB0pGqEJadb9yJhJ6B9EQkVTRjdp15
         VoSrh+aBukaRxcOYRp2vzpXt3dLyfScqSol8vhFf2I9d/fE8n1eja96z4B3Ae4hthLgF
         QvXahtJGKoiIyvmgBsVihT2aQRcXprRhotcRVBFSI600TyxbQ55lEi2mSddh5mqsRuqO
         y1uSMhGLnCu8FKCk5xCynVmd2LZNmdJjZRIOlPIzyBGBQI+Vgh6kxFwTssI/cQ9n8qsW
         w1yA==
X-Gm-Message-State: AGi0PuaYo2JbPx19IqqdnI0i/L2IgrjSH+dciJZczcIqgZ3/fQxR8r/2
        VhpIt3A3kcU3X6Zv9nVIvQ82yvQr+1UL+9Ww9p0=
X-Google-Smtp-Source: APiQypLNysbe9yuR0MbpWcNR+bPpOu7NAeI/3OFly57qrqiEolZbBiK8TkDqIjBP+5bAYnjml937X9skdZSZ0GofJj8=
X-Received: by 2002:ab0:5bcc:: with SMTP id z12mr8937701uae.135.1587404058411;
 Mon, 20 Apr 2020 10:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <1587361180-83334-1-git-send-email-xiyuyang19@fudan.edu.cn>
In-Reply-To: <1587361180-83334-1-git-send-email-xiyuyang19@fudan.edu.cn>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 20 Apr 2020 18:34:07 +0100
Message-ID: <CAL3q7H4hoSF6=S_ZqTCiKNed0NkFymemGZh4vrRNQ3Nrf9xwkA@mail.gmail.com>
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

On Mon, Apr 20, 2020 at 6:50 AM Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote:
>
> btrfs_recover_relocation() invokes btrfs_join_transaction(), which joins
> a btrfs_trans_handle object into transactions and returns a reference of
> it with increased refcount to "trans".
>
> When btrfs_recover_relocation() returns, "trans" becomes invalid, so the
> refcount should be decreased to keep refcount balanced.
>
> The reference counting issue happens in one exception handling path of
> btrfs_recover_relocation(). When read_fs_root() failed, the refcnt
> increased by btrfs_join_transaction() is not decreased, causing a refcnt
> leak.
>
> Fix this issue by calling btrfs_end_transaction() on this error path
> when read_fs_root() failed.
>
> Fixes: 79787eaab461 ("btrfs: replace many BUG_ONs with proper error
> handling")
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/relocation.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 995d4b8b1cfd..46a451594c7a 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4606,6 +4606,7 @@ int btrfs_recover_relocation(struct btrfs_root *roo=
t)
>                 if (IS_ERR(fs_root)) {
>                         err =3D PTR_ERR(fs_root);
>                         list_add_tail(&reloc_root->root_list, &reloc_root=
s);
> +                       btrfs_end_transaction(trans);
>                         goto out_free;
>                 }
>
> --
> 2.7.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
