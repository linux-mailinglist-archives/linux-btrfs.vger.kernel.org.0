Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F62A95CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgKFLxy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgKFLxy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:53:54 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E7C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:53:54 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b18so735434qkc.9
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WDmf+qUUZN5aSZrrI2I2J/AcVOtZJadBbrjWgWgfhLU=;
        b=IAUALUnTf/1ZlO/us29NeGFtIKGxphgEEGP8ZC7Cpo89hi8jW+3V/OfPKMivKNj6uy
         WJUHDvMvPbtgG5Yv/6XCQeH6jQYZrizXZ/rMQWhEQH7+4h4u7EBFj0udcV/t8A7QVLm0
         TDnXmYHj2EVGDzdjF9eWVMpieAzTknkmHmtz00KbkTUn2J7QEYvtojZWA4RQeIChR8Or
         ZKRZ2WTIY4DL/FzyeVR9k8Ofvn9MANluLWeqMGM1d9wiLzbInB8IAFQwoN+zUkmeKL2M
         SC0DaGr3pFiX4wO7JaVcFSYfOYH+H7/r6T49/ke0VXd/eWZYi4Koys9+wOxSsRTfPUv7
         z/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WDmf+qUUZN5aSZrrI2I2J/AcVOtZJadBbrjWgWgfhLU=;
        b=JX5EgNoFplhhNslBzqiyA3IiyXMcFVy7/4Lt5D3qTsOUfZZAZ5jbnLmjegcPVsqdt7
         vyZvK+XFrXxbcfU2ZlrOSUm+OuLl01fqehw73AUIgmUzXQ4dun9mHvHQxo+U5ibuJnGv
         h89Zp7l7e4jc1hKnU2UUvmYZN27wtSvm92x6ZaadJMC+EwvHp50QFUiwQX7eHtFwylkI
         OZsKCF4FInAs18zqD1YW5MGKXayMaMDW25MoIdz8jVyEvdfMr++lxdUqtWfLiWr/jQ+w
         3RbEI8rE/nJqVEarYm6YeMMGKyT0lZflwZZdnMed8EkdOwpq66JSCc8YUavHs9S1lfmP
         l47A==
X-Gm-Message-State: AOAM533e1dumUkJyXmuE4WpPvIDpPLI45tU/BfSyFVCQLN/aAXLvFxFM
        LTgRNTvJ272raKvTlx2u2urcZt9eetvPD9iZRaw=
X-Google-Smtp-Source: ABdhPJwwdBGZFZjWDfkyQBe0jjAXR/0imAxIX8+/DxT9mOqvq9tGVPznws7zhqTsfhr9k6XbDUUPIGavfbuJC03V/cc=
X-Received: by 2002:a37:7c81:: with SMTP id x123mr971775qkc.383.1604663633519;
 Fri, 06 Nov 2020 03:53:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <145f1008e1f813a6a23677e9fe5b64f780824c3d.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <145f1008e1f813a6a23677e9fe5b64f780824c3d.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:53:42 +0000
Message-ID: <CAL3q7H4JOtr5++cwqQoG9kGnApsCP8X4+uuMCXA-ck1daDbAZw@mail.gmail.com>
Subject: Re: [PATCH 07/14] btrfs: use btrfs_read_node_slot in walk_down_tree
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We're open-coding btrfs_read_node_slot() here, replace with the helper.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before (after
applying the whole patchset of course), it used to happen very often
with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/ref-verify.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index 488bc3dd3c2b..4b9b6c52a83b 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -551,29 +551,15 @@ static int process_leaf(struct btrfs_root *root,
>  static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *pa=
th,
>                           int level, u64 *bytenr, u64 *num_bytes)
>  {
> -       struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct extent_buffer *eb;
> -       u64 block_bytenr, gen;
>         int ret =3D 0;
>
>         while (level >=3D 0) {
>                 if (level) {
> -                       struct btrfs_key first_key;
> -
> -                       block_bytenr =3D btrfs_node_blockptr(path->nodes[=
level],
> -                                                          path->slots[le=
vel]);
> -                       gen =3D btrfs_node_ptr_generation(path->nodes[lev=
el],
> -                                                       path->slots[level=
]);
> -                       btrfs_node_key_to_cpu(path->nodes[level], &first_=
key,
> -                                             path->slots[level]);
> -                       eb =3D read_tree_block(fs_info, block_bytenr, gen=
,
> -                                            level - 1, &first_key);
> +                       eb =3D btrfs_read_node_slot(path->nodes[level],
> +                                                 path->slots[level]);
>                         if (IS_ERR(eb))
>                                 return PTR_ERR(eb);
> -                       if (!extent_buffer_uptodate(eb)) {
> -                               free_extent_buffer(eb);
> -                               return -EIO;
> -                       }
>                         btrfs_tree_read_lock(eb);
>                         path->nodes[level-1] =3D eb;
>                         path->slots[level-1] =3D 0;
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
