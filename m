Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6DC2A95DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgKFL4O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgKFL4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:56:14 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E2C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:56:14 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id g17so525658qts.5
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kPxJm7kYnNIO28bUIt4Aw5z29DCdvQiaH/U5u01p/YU=;
        b=hjBXOq1rVdCh0w3t2uDKgsa4APgssK6rS9JqfLyx7khTXWzPgW52pNqe6+1MS80tQ+
         XLS2If6El7GFMHikVV57NTe8dBxxVhnrAS35pJmvleybpE+5FJqnC9DLhknw4YHM3aQq
         n5/moGfjA4UsmDJQ0zZgEMKggUUyJ/z61beJYdm52UNmvWL1TOh6434ChaV2Zr9DgmTu
         huQlN4bVZ8cIdGb3VQBDN3ka3ujQFz4bGoMYsehYso5AV0hUvm4ZyTj8ByKKJxcievah
         7X3C439zcDipNqvPtbPW0N/EJ9/8FQBB1dc+WGub84OhXVA4YObKJPVQq7MOHR3UhEMr
         UZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kPxJm7kYnNIO28bUIt4Aw5z29DCdvQiaH/U5u01p/YU=;
        b=rf12/LEQbHQLsCzXTbzQzZaARCbbRHlUWFOh+jpd3sSUSlQBX1m+ph2kn/qCbBt3Zh
         U/5UzG0XCvYbltkFUbwjoPjkjbOngI20eNU78wdkYPqJaWJ9QrD6qfVy/JDPDF26suSM
         kP2xui2UeSmh11JL1KalFXvNkD4nJXkXFg9FLkJkuhh5X3jlrsklQYUumyouI79tXD43
         RBlQG8elVQVweqH3+ssrYAqy1RQ3j5lR3UkCtgURtR1OlGGRKCVI/qqBhi1cKGWCZTQC
         Xan5hAnJVCKymcQfHIcf8MCpJJhOS8++E5V+iH52sDkqDSvM55/0eiOGkdSHCPDe4Zop
         Nw2A==
X-Gm-Message-State: AOAM531FuMvcM6yYgzljCoM/pWEVOghSbYJNY28IWr6y1RZNSMWl7gJF
        7BOWOcyTv3Y6TxKcxIE7ntvcePdkWjPbShZJm6jFtd7C1yY=
X-Google-Smtp-Source: ABdhPJxsdAv3S2k/m1+vxaZSUbjTIG1vof1+uwQLYNv33l3beqw0LaAtQPqqM0uCvGJLnKVKjjIlazwWiyILv9GKF8Y=
X-Received: by 2002:ac8:5942:: with SMTP id 2mr1063827qtz.183.1604663773530;
 Fri, 06 Nov 2020 03:56:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <d9e961bc71196e5c1baa807759259231aa132b57.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <d9e961bc71196e5c1baa807759259231aa132b57.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:56:02 +0000
Message-ID: <CAL3q7H4x7vV8o10BM4SURsTPH5Ym_V-uQ=ni=eCUX8iMf2qK-Q@mail.gmail.com>
Subject: Re: [PATCH 12/14] btrfs: pass the root owner and level around for reada
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> The reada infrastructure does raw reads of extent buffers, but we're
> going to need to know their owner and level in order to set the lockdep
> key properly, so plumb in the infrastructure that we'll need to have
> this information when we start allocating extent buffers.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before (after
applying the whole patchset of course), it used to happen very often
with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/reada.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
> index 6e33cb755fa5..83f4e6c53e46 100644
> --- a/fs/btrfs/reada.c
> +++ b/fs/btrfs/reada.c
> @@ -52,6 +52,7 @@ struct reada_extctl {
>
>  struct reada_extent {
>         u64                     logical;
> +       u64                     owner_root;
>         struct btrfs_key        top;
>         struct list_head        extctl;
>         int                     refcnt;
> @@ -59,6 +60,7 @@ struct reada_extent {
>         struct reada_zone       *zones[BTRFS_MAX_MIRRORS];
>         int                     nzones;
>         int                     scheduled;
> +       int                     level;
>  };
>
>  struct reada_zone {
> @@ -87,7 +89,8 @@ static void reada_start_machine(struct btrfs_fs_info *f=
s_info);
>  static void __reada_start_machine(struct btrfs_fs_info *fs_info);
>
>  static int reada_add_block(struct reada_control *rc, u64 logical,
> -                          struct btrfs_key *top, u64 generation);
> +                          struct btrfs_key *top, u64 owner_root,
> +                          u64 generation, int level);
>
>  /* recurses */
>  /* in case of err, eb might be NULL */
> @@ -165,7 +168,9 @@ static void __readahead_hook(struct btrfs_fs_info *fs=
_info,
>                         if (rec->generation =3D=3D generation &&
>                             btrfs_comp_cpu_keys(&key, &rc->key_end) < 0 &=
&
>                             btrfs_comp_cpu_keys(&next_key, &rc->key_start=
) > 0)
> -                               reada_add_block(rc, bytenr, &next_key, n_=
gen);
> +                               reada_add_block(rc, bytenr, &next_key,
> +                                               btrfs_header_owner(eb), n=
_gen,
> +                                               btrfs_header_level(eb) - =
1);
>                 }
>         }
>
> @@ -298,7 +303,8 @@ static struct reada_zone *reada_find_zone(struct btrf=
s_device *dev, u64 logical,
>
>  static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_i=
nfo,
>                                               u64 logical,
> -                                             struct btrfs_key *top)
> +                                             struct btrfs_key *top,
> +                                             u64 owner_root, int level)
>  {
>         int ret;
>         struct reada_extent *re =3D NULL;
> @@ -331,6 +337,8 @@ static struct reada_extent *reada_find_extent(struct =
btrfs_fs_info *fs_info,
>         INIT_LIST_HEAD(&re->extctl);
>         spin_lock_init(&re->lock);
>         re->refcnt =3D 1;
> +       re->owner_root =3D owner_root;
> +       re->level =3D level;
>
>         /*
>          * map block
> @@ -548,14 +556,15 @@ static void reada_control_release(struct kref *kref=
)
>  }
>
>  static int reada_add_block(struct reada_control *rc, u64 logical,
> -                          struct btrfs_key *top, u64 generation)
> +                          struct btrfs_key *top, u64 owner_root,
> +                          u64 generation, int level)
>  {
>         struct btrfs_fs_info *fs_info =3D rc->fs_info;
>         struct reada_extent *re;
>         struct reada_extctl *rec;
>
>         /* takes one ref */
> -       re =3D reada_find_extent(fs_info, logical, top);
> +       re =3D reada_find_extent(fs_info, logical, top, owner_root, level=
);
>         if (!re)
>                 return -1;
>
> @@ -947,6 +956,7 @@ struct reada_control *btrfs_reada_add(struct btrfs_ro=
ot *root,
>         u64 start;
>         u64 generation;
>         int ret;
> +       int level;
>         struct extent_buffer *node;
>         static struct btrfs_key max_key =3D {
>                 .objectid =3D (u64)-1,
> @@ -969,9 +979,11 @@ struct reada_control *btrfs_reada_add(struct btrfs_r=
oot *root,
>         node =3D btrfs_root_node(root);
>         start =3D node->start;
>         generation =3D btrfs_header_generation(node);
> +       level =3D btrfs_header_level(node);
>         free_extent_buffer(node);
>
> -       ret =3D reada_add_block(rc, start, &max_key, generation);
> +       ret =3D reada_add_block(rc, start, &max_key,
> +                             root->root_key.objectid, generation, level)=
;
>         if (ret) {
>                 kfree(rc);
>                 return ERR_PTR(ret);
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
