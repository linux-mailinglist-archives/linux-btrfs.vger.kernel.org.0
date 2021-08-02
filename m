Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F933DD5F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 14:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhHBMrb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 08:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbhHBMra (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Aug 2021 08:47:30 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2BFC06175F
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Aug 2021 05:47:20 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id p38so8761330qvp.11
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Aug 2021 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mJuH2tsU6ToXHAl0zz5QYVTRnli73X/7rz2Dhv2Ya+g=;
        b=GxgkDGD/NXYBq+nAF+ao9JjhNOh3FCiAZw9/XPJ5Q3OKK4EN7CUBhMWMvUBPBO3Hhy
         dTll/wJx0GQaRv7X/JOS8ZXpHVbpjyFTPQbgBxZeF3wUBWPETUmk80KuOU9hrOMEx1pa
         VZF8so/WrjvzD+UBhrbUu+rpyO7YY3MhoPH6vE+G0OcXRqFABVCyQKtCwRbjwFuiDzay
         jxqc0rDOQZfCcsgMaHwvzvxCxoDuPBd32dZzeyt8NKjK2TJlp0peaRloUTwJrHVM1Dqh
         92C4G3c8p7zPNccJA0D8q0gv+14VxxHgsqxtPzP2/4w0TbPQalz71vEKvVZV+VxmHaMt
         jzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mJuH2tsU6ToXHAl0zz5QYVTRnli73X/7rz2Dhv2Ya+g=;
        b=pSMRTHN8UWa4sOu3DpD2xmZ5k+xbRMj7IPf5OK+o9i/EBU1yIUUrgSm9IJF5jKaERL
         Ad+1eqmobgRai+ZeKc120K/n+d96uFlb+lKIdlzYwrHPipihoQWuU2S62V3wYb2+XwtS
         6eemkO47Q+59xVVpt3zKOmY7pMmB1IIhEPHZ8H/l9wtcevEZMp0cjDLQ147QLkPgiJ9g
         03+YLgm0UTNiZbfQjrTRoSYMnRI69YvQQtp6DWg23zfHAv1HDDjJTqTAxeFOhCBWCjaT
         8IHyiQN8sEoghoMHkJuN1sShxxRICpBu11whKOQi1RwcBjrlCDhrY0hTxKSzz1cqkYcd
         Sm0w==
X-Gm-Message-State: AOAM531K9p8R/+nbM5r6QkgGz2jZkvvRmTzG0YJN6kxPhA1cJGSTjliO
        qAhaujfwcAd+3j4L82a6ZKKxZnZPHHWEWK4Vcak=
X-Google-Smtp-Source: ABdhPJxmDQ12NAS/rQwclTyKaMh+BM3sQF8s88pjj+lMdM0gF3BXZeLLjOqbBsxULVfRqpkzLp4/kGRYu5ZVnv13ETY=
X-Received: by 2002:a05:6214:a93:: with SMTP id ev19mr16373389qvb.27.1627908439623;
 Mon, 02 Aug 2021 05:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210802123400.2687-1-mpdesouza@suse.com>
In-Reply-To: <20210802123400.2687-1-mpdesouza@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 2 Aug 2021 13:47:08 +0100
Message-ID: <CAL3q7H56u9wPQa2XS+s7VOAXnyjk9gwBjpdpROJHxAHW2OA5aQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-log: Check btrfs_lookup_data_extent return value
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 2, 2021 at 1:35 PM Marcos Paulo de Souza <mpdesouza@suse.com> w=
rote:
>
> Function btrfs_lookup_data_extent calls btrfs_search_slot to verify if
> the EXTENT_ITEM exists in the extent tree. btrfs_search_slot can return
> values bellow zero if an error happened.
>
> Function replay_one_extent currently check if the search found something
> (0 returned) and increments the reference, and if not, it seems to evalua=
te as
> 'not found'.
>
> Fix the condition by checking if the value was bellow zero and return ear=
ly.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

That's fine, thanks.

> ---
>
>  Found while inspecting some btrfs_search_slot call sites.
>
>  fs/btrfs/tree-log.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 567adc3de11a..867ea0be0665 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -753,7 +753,9 @@ static noinline int replay_one_extent(struct btrfs_tr=
ans_handle *trans,
>                          */
>                         ret =3D btrfs_lookup_data_extent(fs_info, ins.obj=
ectid,
>                                                 ins.offset);
> -                       if (ret =3D=3D 0) {
> +                       if (ret < 0) {
> +                               goto out;
> +                       } else if (ret =3D=3D 0) {
>                                 btrfs_init_generic_ref(&ref,
>                                                 BTRFS_ADD_DELAYED_REF,
>                                                 ins.objectid, ins.offset,=
 0);
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
