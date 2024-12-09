Return-Path: <linux-btrfs+bounces-10163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E920C9E94B2
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 13:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5BE164A42
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E623A221D9C;
	Mon,  9 Dec 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZscxaNTn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C96A217F46
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748428; cv=none; b=mY2vRMSEFAx5CT8iL7RYQVUi5pzCE+5AfqB6V0IoJHGG57djfTS6P+QWtOffW2YeXSnCNvexA46mZNTfUF9oliVX4Fb+NZRy9CQg2WMkpqlcb9HdEW5GLusiY1B1IPt5KL+QO6HECQYEzxsdb37t3xNfnZ/K3qSsmp/ShBaNBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748428; c=relaxed/simple;
	bh=cNE0zYlFPByIb5G5SfSOVcwpwasEP3WE64Ss2J1Z6ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/1KFVP6+bRcRJLh89ftuhAgrHc01y1XMNmzZe8a31/Zj1Vnc2Jhb8KFalHd5HBC3zJfvohkvBEn55L80ehQwbW7PRUI9lM4QfnKCQYgZ66nVPx/TkNlhvNac4KEQkxKjRvLkNgPNg1GZ5+sDFc/2l50ylpim3DB39gwbDSt+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZscxaNTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880FFC4CEDE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 12:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733748427;
	bh=cNE0zYlFPByIb5G5SfSOVcwpwasEP3WE64Ss2J1Z6ZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZscxaNTnTJz8D79PFN1SOe2yrILqF2OcBcdpcucye7Bq1hd3GnxjOIks1cPTLNymj
	 zUzGYWTI275734ZIMHWtqT+AEnpB1tgyPDDmd2fMvhSNrQfiQ6pJ1yEeQTvo50Uf3X
	 7FYlfdqr5UCoGULwjfJcWiLN/Lbqp4P3Ht+fCDRMrUuyjDfIiM6FEBsVY1gqZU1UZJ
	 cWGwBtbPELQ8mWwRqfKK+LnWgxK1K+AQEkMTPfp1KCnvABFhsQWmCpzZTi+/90fUVU
	 rn4RKHq4df/i403kNtPuAAWND3/0QjBaSY/YU8/sSQVCAJCqC3Du1Yzkp8ZhTw85ZB
	 26KLGiGO+DfqA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa543c4db92so14236966b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2024 04:47:07 -0800 (PST)
X-Gm-Message-State: AOJu0Yw4VyeElRTHR8xf+9+eKEy6JqtV2Ni1GrMElydOhKLDAw85Rigz
	opqS8MmXTwMaH0BDMbRrFeIg5b7M09mRQPXPQZRPFkMHGeX1AEDlPIGAP9pFr1ytyj5a8oW/jfu
	HWF7bwtjNpYJ2cbmnBgEEA2driDs=
X-Google-Smtp-Source: AGHT+IH0a/nm4HEdPn1dWk/wwoWd9kUgwXsbbFo/fyqQg7sQHghGg8t6LqWG3AxUE8s6tWyvvDAlnSiUcMwqaM2XMIA=
X-Received: by 2002:a17:906:1db1:b0:aa6:6c08:dc79 with SMTP id
 a640c23a62f3a-aa69cd675f8mr19776066b.35.1733748426093; Mon, 09 Dec 2024
 04:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733695544.git.beckerlee3@gmail.com> <5e023dcf8f086296da987f8ba2b43be0aca15b86.1733695544.git.beckerlee3@gmail.com>
In-Reply-To: <5e023dcf8f086296da987f8ba2b43be0aca15b86.1733695544.git.beckerlee3@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Dec 2024 12:46:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4VveC67u1FoP11vQKm=41thMZw3UwNr=PAiggurr6bsw@mail.gmail.com>
Message-ID: <CAL3q7H4VveC67u1FoP11vQKm=41thMZw3UwNr=PAiggurr6bsw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: edits tree_insert() to use rb helpers
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 10:39=E2=80=AFPM Roger L. Beckermeyer III
<beckerlee3@gmail.com> wrote:
>
> Edits tree_insert() to use rb_find_add_cached(). Also adds a
> comparison function for use in rb_find_add_cached() to compare.
>
> Reviewed-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> Tested-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> ---
>  fs/btrfs/delayed-ref.c | 43 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 30f7079fa28e..d77ac8d05b2a 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -317,34 +317,33 @@ static int comp_refs(struct btrfs_delayed_ref_node =
*ref1,
>         return 0;
>  }
>
> +static int comp_refs_node(struct rb_node *node, const struct rb_node *no=
de2)
> +{
> +       struct btrfs_delayed_ref_node *ref1;
> +       struct btrfs_delayed_ref_node *ref2;
> +
> +       ref1 =3D rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
> +       ref2 =3D rb_entry(node2, struct btrfs_delayed_ref_node, ref_node)=
;
> +
> +       bool check_seq =3D true;
> +       int ret;

Please don't use this style of declaring variables in the middle of the cod=
e.
The style we use is to declare them at the top of a scope.

> +
> +       ret =3D comp_refs(ref1, ref2, check_seq);
> +       return ret;

For this just do:

return comp_refs(ref1, ref2, check_seq);

> +}
> +
>  static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached =
*root,
>                 struct btrfs_delayed_ref_node *ins)
>  {
> -       struct rb_node **p =3D &root->rb_root.rb_node;
>         struct rb_node *node =3D &ins->ref_node;
> -       struct rb_node *parent_node =3D NULL;
> +       struct rb_node *exist;
>         struct btrfs_delayed_ref_node *entry;
> -       bool leftmost =3D true;
> -
> -       while (*p) {
> -               int comp;
> -
> -               parent_node =3D *p;
> -               entry =3D rb_entry(parent_node, struct btrfs_delayed_ref_=
node,
> -                                ref_node);
> -               comp =3D comp_refs(ins, entry, true);
> -               if (comp < 0) {
> -                       p =3D &(*p)->rb_left;
> -               } else if (comp > 0) {
> -                       p =3D &(*p)->rb_right;
> -                       leftmost =3D false;
> -               } else {
> -                       return entry;
> -               }
> -       }
>
> -       rb_link_node(node, parent_node, p);
> -       rb_insert_color_cached(node, root, leftmost);
> +       exist =3D rb_find_add_cached(node, root, comp_refs_node);
> +       if (exist !=3D NULL) {
> +               entry =3D rb_entry(exist, struct btrfs_delayed_ref_node, =
ref_node);
> +               return entry;

return rb_entry(exist, struct btrfs_delayed_ref_node, ref_node);

Thanks.

> +       }
>         return NULL;
>  }
>
> --
> 2.45.2
>
>

