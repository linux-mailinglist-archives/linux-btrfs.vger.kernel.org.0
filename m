Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E37B291175
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Oct 2020 12:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437306AbgJQKpt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Oct 2020 06:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437163AbgJQKps (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Oct 2020 06:45:48 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE7AC061755;
        Sat, 17 Oct 2020 03:45:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 188so3964267qkk.12;
        Sat, 17 Oct 2020 03:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ShD8p5s4Y60axKd8xtWZy6rUlfIF3hhWDGzsjMlOGAs=;
        b=dwFO7YcwOCF15GUSVfip+TEkrlFEgIqn4/dfA3IsGhZDzhRb/W28+jS+s8t3FsFujj
         qOySerufPVHaERAtrAIu4YpjP3FV3CniV+DoDUMjMwQ0vQxfGg/AwuY3aRU4ITQ2Vpab
         TXTTyJ2ZOzHtjYN9d0R2ElGERgZ/Q+bPh+SUWWbHJsW9qGzQYGlIVhlfdcv7Ti3aB5wq
         PGnDelya/9vwvqqf9PNIzQ4/H1aSW5PgprqtJ53a7IAsZuMMLWNEU2AFWMB76TRD0CHv
         mug5G1xhK8mI6mn34ObL11EUb/59rkktgaH+cUT7AevdzwHy7I5P5o5qMyDnEwzbdIwD
         RlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ShD8p5s4Y60axKd8xtWZy6rUlfIF3hhWDGzsjMlOGAs=;
        b=uEklS+lgn2ZmeLPJywmKvT6r/IFCUSKVARxUKHssx2CEgC3tb0T28oZ6rSQIKTepSm
         cc/lAwbcISyd/OiRkD6ODW7agS8qK5wX1z4rcJ6UR3liqbiBwFa+OqJCNM2nAIcO7FYJ
         UpE5DrfH5YGrimciT31iRIB6028eu0TpR3IlRR0sLs9VoMLQ0UTIib01O84sF7DOglJx
         8UF5wq3qHW0PBpjJWVX94Iy6ISQ8LYt5n3KRI4mGNgzTwidhym4KdTf3m5ol67GBRy/A
         56Njknz3iZ0WVL3WJwb2pR1aHC6sH4RMFLj/wPuTRhvtroSyQQqfanJXdkjjvaWg72aW
         rNSg==
X-Gm-Message-State: AOAM533reHy9K0yLkfgT1hdTPH7E28flFDcjMO0gjABOkbTchQzzZntW
        yFvxZftnTqy6L+hzY+JP5sVuntBJ+//uvtqMPmc=
X-Google-Smtp-Source: ABdhPJwQ7BalEBF2dfrCXZc4wvE4+PdCbeqwZtdIEIinPhNkiHMQSVdzwo/OTT4W/KKdJxQ/TuEwSqBGdQIJrzjccEM=
X-Received: by 2002:a37:9cd3:: with SMTP id f202mr7690762qke.479.1602931546258;
 Sat, 17 Oct 2020 03:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201014032419.1268-1-shipujin.t@gmail.com>
In-Reply-To: <20201014032419.1268-1-shipujin.t@gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sat, 17 Oct 2020 11:45:35 +0100
Message-ID: <CAL3q7H5DOX=RWr=ftwCX=8PTshdLr-UPOaL79oxA+Aqw+Dyk+A@mail.gmail.com>
Subject: Re: [PATCH] fs: btrfs: Fix incorrect printf qualifier
To:     Pujin Shi <shipujin.t@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 14, 2020 at 10:24 AM Pujin Shi <shipujin.t@gmail.com> wrote:
>
> This patch addresses a compile warning:
> fs/btrfs/extent-tree.c: In function '__btrfs_free_extent':
> fs/btrfs/extent-tree.c:3187:4: warning: format '%lu' expects argument of =
type 'long unsigned int', but argument 8 has type 'unsigned int' [-Wformat=
=3D]
>
> Fixes: 3b7b6ffa4f8f ("btrfs: extent-tree: kill BUG_ON() in __btrfs_free_e=
xtent()")

Btw, that commit id does not exist in Linus' tree, should be 1c2a07f598d5 [=
1].

> Signed-off-by: Pujin Shi <shipujin.t@gmail.com>

Other than that it looks good,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D1c2a07f598d526e39acbf1837b8d521fc0dab9c5

> ---
>  fs/btrfs/extent-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 3b21fee13e77..5fd60b13f4f8 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3185,7 +3185,7 @@ static int __btrfs_free_extent(struct btrfs_trans_h=
andle *trans,
>                 struct btrfs_tree_block_info *bi;
>                 if (item_size < sizeof(*ei) + sizeof(*bi)) {
>                         btrfs_crit(info,
> -"invalid extent item size for key (%llu, %u, %llu) owner %llu, has %u ex=
pect >=3D %lu",
> +"invalid extent item size for key (%llu, %u, %llu) owner %llu, has %u ex=
pect >=3D %zu",
>                                    key.objectid, key.type, key.offset,
>                                    owner_objectid, item_size,
>                                    sizeof(*ei) + sizeof(*bi));
> --
> 2.18.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
