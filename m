Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A9B2A95C7
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKFLwl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFLwl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:52:41 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F716C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:52:41 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 140so754056qko.2
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZS3vvmq2jxBqPbsV7sXUXyL2suSzQ8SdIBFNBW1mJyw=;
        b=oUDnbAOhYcPUbOHQUV4JYtertavgxqywdMJpMRs5WVA3gbQ3BCTuI5Ki4vejdRRaSC
         xI12tF8BPkPncmTGK3whQ88+rm5HERWB93zKwCmjpojVW5lLUmCvTFYWwdGk+zt0Js1j
         hoX8KqkfklBUBcKJufOP1gxitfNgVRv8UvE+m1XAG9HEL01LEkEcx02YloihXkoU2rUi
         Nq+f1InGQSiXr70f1PW9cfE17XmsBdqmDTrXAR8qyZTASY+izs8T/orNnQcjMqDmo4uZ
         G+CSbR2wIp9Rj30nqB1vAp4FUZUzDIIAXHW39paAHhTxUBDv96j5fzgjtDysvPIGhWkW
         QoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZS3vvmq2jxBqPbsV7sXUXyL2suSzQ8SdIBFNBW1mJyw=;
        b=FT/QhL0rYMsnNxtTndzMhaqMQIDIS0r9XMbLH0xNSfXOSUhDT4uPGZaXbGW+xU6V3+
         ORAVFUzc8hHJpnXtbOxr425aJFduD1rCr61lWTFFwzLRkqkF2b5HPEIb8XiteFAtR+AB
         Wtxi27nOKUIAvEhGm8r0eljpfOXY61X/f/9rqQ7wJQrzxV72pcnnIKaEl1lR/FaxbKaO
         eISiwAdXU3BTl6xX66fUBJq8W0EP8BaSTT1fSer9UwHBILduK5i68apnFWQwQvCTYJjN
         aqUD9GsmaypyGrDOo4vvt6Ujl1gO31Kea/owXl8zjlOScj05LgE1UUggFd1Bj5PT8G7I
         aM2w==
X-Gm-Message-State: AOAM531pcfSCxErU89M3HpR29whMEc5No+h9/mQxPtVGchxe7Sn5hbjD
        uqNi8h7fRW2t5ARQ5XpVKZhmWDB7nmUhLR1bDX1rSxJGhJw=
X-Google-Smtp-Source: ABdhPJyKJ89l+myr6ajY6K5xwhsmV3BHNQFhTCKwaMpg+WJfKTGoKZCZs7UpDppCgpsCkLTEiMn1t7YIxQrmQ7BJN5g=
X-Received: by 2002:a05:620a:1426:: with SMTP id k6mr1088241qkj.438.1604663560429;
 Fri, 06 Nov 2020 03:52:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <bd9bfdf69f8a03c17b35e0142e693c4bb08a03bd.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <bd9bfdf69f8a03c17b35e0142e693c4bb08a03bd.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:52:29 +0000
Message-ID: <CAL3q7H5sqK5PnDm7CVVb+5-eSsgyo11OBe323b5DjdjKn0BgaA@mail.gmail.com>
Subject: Re: [PATCH 04/14] btrfs: use btrfs_read_node_slot in walk_down_reloc_tree
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We do not need to call read_tree_block() here, simply use the
> btrfs_read_node_slot helper.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before (after
applying the whole patchset of course), it used to happen very often
with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/relocation.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 0e2dd7cf87f6..d327b5b4f1cd 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1415,10 +1415,8 @@ static noinline_for_stack
>  int walk_down_reloc_tree(struct btrfs_root *root, struct btrfs_path *pat=
h,
>                          int *level)
>  {
> -       struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct extent_buffer *eb =3D NULL;
>         int i;
> -       u64 bytenr;
>         u64 ptr_gen =3D 0;
>         u64 last_snapshot;
>         u32 nritems;
> @@ -1426,8 +1424,6 @@ int walk_down_reloc_tree(struct btrfs_root *root, s=
truct btrfs_path *path,
>         last_snapshot =3D btrfs_root_last_snapshot(&root->root_item);
>
>         for (i =3D *level; i > 0; i--) {
> -               struct btrfs_key first_key;
> -
>                 eb =3D path->nodes[i];
>                 nritems =3D btrfs_header_nritems(eb);
>                 while (path->slots[i] < nritems) {
> @@ -1447,16 +1443,9 @@ int walk_down_reloc_tree(struct btrfs_root *root, =
struct btrfs_path *path,
>                         return 0;
>                 }
>
> -               bytenr =3D btrfs_node_blockptr(eb, path->slots[i]);
> -               btrfs_node_key_to_cpu(eb, &first_key, path->slots[i]);
> -               eb =3D read_tree_block(fs_info, bytenr, ptr_gen, i - 1,
> -                                    &first_key);
> -               if (IS_ERR(eb)) {
> +               eb =3D btrfs_read_node_slot(eb, path->slots[i]);
> +               if (IS_ERR(eb))
>                         return PTR_ERR(eb);
> -               } else if (!extent_buffer_uptodate(eb)) {
> -                       free_extent_buffer(eb);
> -                       return -EIO;
> -               }
>                 BUG_ON(btrfs_header_level(eb) !=3D i - 1);
>                 path->nodes[i - 1] =3D eb;
>                 path->slots[i - 1] =3D 0;
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
