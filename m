Return-Path: <linux-btrfs+bounces-4267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A79E8A4FA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 14:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7C3B22522
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 12:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4793D78C7F;
	Mon, 15 Apr 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLBiVgFm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DAE78B50
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185365; cv=none; b=P5CqykKLMV+GxCg34lXUK81Qfi3VlhFDOJqiP9Y13H7mdc946h1UZhJDmT+gE8BBFIgmmM3ubpo3i6XGMIlCtOYdPblXVywFtuRFotyJ1ugloJUFQkvOMOEz5azpX6CGL8kb05T4c2Fniv/vFOwCTHzIifVohP06fVAu7b+6IVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185365; c=relaxed/simple;
	bh=6VWowoKENrag1jXdMlIl/AyE/nZPhzyHJBr8W2coVuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETFHK859zoPLsiilHLL1MkyV6rd/HlqAmPy9KDreGuZHSjeUlJByE97J884UgcUB7B4HyTqgGYyqR1nu24cHiuAEvhS8gwxJZKY75U0VK6OV2dcSpfPLYYAJWZbOQz9jZkYzlPI8U4NsT8+9sbSbh6GvO7LqFNcSopzuB/9ZHnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLBiVgFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53190C4AF08
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185365;
	bh=6VWowoKENrag1jXdMlIl/AyE/nZPhzyHJBr8W2coVuQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JLBiVgFmtnESNG8bv7SNGMQOUo/UEnJXx39qr1Y041vBKDYOUxIRbZTAec6bxV7AK
	 LVApNHR7XDQyLRdqOWvuE++cpDGUo//e/XEII9FgzbRa8vXT+nKA1QKO0/lQQj+rNA
	 RZrqqFWwg0RmBjfkUyVxRT5wswmD2fykWO7DIlOEEsWkx/EZCjEVPArvQQqQTBJFh2
	 Ozsmk3/NS99+zMoG/2IOXplN0BroOCFhxKGwNkcEUCAgJl0XXX6nbMgISfRW85nv7X
	 yXsqzzxsxBazoyK7TwcKaa/OLtCNEd8xaePTcNVsUrsHzl9rY5eC7WFzYJgx7BZGF8
	 8QHUQrhG3B8Lg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2da08b07157so35383401fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:49:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YyP2dkDhOBXYns0m0phRKQo3lPYDYgM/djKP3hrbLBxmn/6vKS+
	maHhpIXYvJs/KnkH3xZtK1yFbcwp0ulMNvcDd2Ka5opIe5yWIps+EXFwyJvSSUUvAZyTKrCTDwR
	m8J3dlmMUetNf0kQz1ohYcM11fb4=
X-Google-Smtp-Source: AGHT+IFakN38nL6AdYUzbC9R7ygSN26ZmfPMwvKivxtx8SvCwCj/JjrXUO6iAGcNOde8oPwdehKLxiDuul0DKHqurQc=
X-Received: by 2002:a2e:8455:0:b0:2d8:8633:ff70 with SMTP id
 u21-20020a2e8455000000b002d88633ff70mr7799007ljh.30.1713185363656; Mon, 15
 Apr 2024 05:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <5ed65a5c6829fb072e20a9e58897918ca4a21f3e.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <5ed65a5c6829fb072e20a9e58897918ca4a21f3e.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 13:48:46 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5F11SNs=uRzt=A3Q7xLLET+RYTJC37K5KVPqaZDmpNmw@mail.gmail.com>
Message-ID: <CAL3q7H5F11SNs=uRzt=A3Q7xLLET+RYTJC37K5KVPqaZDmpNmw@mail.gmail.com>
Subject: Re: [PATCH 09/19] btrfs: unify the btrfs_add_delayed_*_ref helpers
 into one helper
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> Now that these helpers are identical, create a helper function that
> handles everything properly and strip the individual helpers down to use
> just the common helper. This cleans up a significant amount of
> duplicated code.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/delayed-ref.c | 106 +++++++++++------------------------------
>  1 file changed, 28 insertions(+), 78 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index cc1510d7eee8..342f32ae08c9 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1054,14 +1054,10 @@ void btrfs_init_data_ref(struct btrfs_ref *generi=
c_ref, u64 ino, u64 offset,
>                 generic_ref->skip_qgroup =3D false;
>  }
>
> -/*
> - * add a delayed tree ref.  This does all of the accounting required
> - * to make sure the delayed ref is eventually processed before this
> - * transaction commits.
> - */
> -int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
> -                              struct btrfs_ref *generic_ref,
> -                              struct btrfs_delayed_extent_op *extent_op)
> +static int __btrfs_add_delayed_ref(struct btrfs_trans_handle *trans,

Please don't use a __ prefix for functions, even if private/static.
We don't do this anymore.

With that changed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


> +                                  struct btrfs_ref *generic_ref,
> +                                  struct btrfs_delayed_extent_op *extent=
_op,
> +                                  u64 reserved)
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         struct btrfs_delayed_ref_node *node;
> @@ -1069,10 +1065,9 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_=
handle *trans,
>         struct btrfs_delayed_ref_root *delayed_refs;
>         struct btrfs_qgroup_extent_record *record =3D NULL;
>         bool qrecord_inserted;
> -       bool merged;
>         int action =3D generic_ref->action;
> +       bool merged;
>
> -       ASSERT(generic_ref->type =3D=3D BTRFS_REF_METADATA && generic_ref=
->action);
>         node =3D kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS=
);
>         if (!node)
>                 return -ENOMEM;
> @@ -1087,14 +1082,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans=
_handle *trans,
>                 record =3D kzalloc(sizeof(*record), GFP_NOFS);
>                 if (!record) {
>                         kmem_cache_free(btrfs_delayed_ref_node_cachep, no=
de);
> -                       kmem_cache_free(btrfs_delayed_ref_head_cachep, he=
ad_ref);
> +                       kmem_cache_free(btrfs_delayed_ref_head_cachep,
> +                                       head_ref);
>                         return -ENOMEM;
>                 }
>         }
>
>         init_delayed_ref_common(fs_info, node, generic_ref);
> -
> -       init_delayed_ref_head(head_ref, generic_ref, record, 0);
> +       init_delayed_ref_head(head_ref, generic_ref, record, reserved);
>         head_ref->extent_op =3D extent_op;
>
>         delayed_refs =3D &trans->transaction->delayed_refs;
> @@ -1116,16 +1111,31 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans=
_handle *trans,
>          */
>         btrfs_update_delayed_refs_rsv(trans);
>
> -       trace_add_delayed_tree_ref(fs_info, node);
> +       if (generic_ref->type =3D=3D BTRFS_REF_DATA)
> +               trace_add_delayed_data_ref(trans->fs_info, node);
> +       else
> +               trace_add_delayed_tree_ref(trans->fs_info, node);
>         if (merged)
>                 kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
>
>         if (qrecord_inserted)
> -               btrfs_qgroup_trace_extent_post(trans, record);
> -
> +               return btrfs_qgroup_trace_extent_post(trans, record);
>         return 0;
>  }
>
> +/*
> + * add a delayed tree ref.  This does all of the accounting required
> + * to make sure the delayed ref is eventually processed before this
> + * transaction commits.
> + */
> +int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
> +                              struct btrfs_ref *generic_ref,
> +                              struct btrfs_delayed_extent_op *extent_op)
> +{
> +       ASSERT(generic_ref->type =3D=3D BTRFS_REF_METADATA && generic_ref=
->action);
> +       return __btrfs_add_delayed_ref(trans, generic_ref, extent_op, 0);
> +}
> +
>  /*
>   * add a delayed data ref. it's similar to btrfs_add_delayed_tree_ref.
>   */
> @@ -1133,68 +1143,8 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>                                struct btrfs_ref *generic_ref,
>                                u64 reserved)
>  {
> -       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -       struct btrfs_delayed_ref_node *node;
> -       struct btrfs_delayed_ref_head *head_ref;
> -       struct btrfs_delayed_ref_root *delayed_refs;
> -       struct btrfs_qgroup_extent_record *record =3D NULL;
> -       bool qrecord_inserted;
> -       int action =3D generic_ref->action;
> -       bool merged;
> -
> -       ASSERT(generic_ref->type =3D=3D BTRFS_REF_DATA && action);
> -       node =3D kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS=
);
> -       if (!node)
> -               return -ENOMEM;
> -
> -       init_delayed_ref_common(fs_info, node, generic_ref);
> -
> -       head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_=
NOFS);
> -       if (!head_ref) {
> -               kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
> -               return -ENOMEM;
> -       }
> -
> -       if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_q=
group) {
> -               record =3D kzalloc(sizeof(*record), GFP_NOFS);
> -               if (!record) {
> -                       kmem_cache_free(btrfs_delayed_ref_node_cachep, no=
de);
> -                       kmem_cache_free(btrfs_delayed_ref_head_cachep,
> -                                       head_ref);
> -                       return -ENOMEM;
> -               }
> -       }
> -
> -       init_delayed_ref_head(head_ref, generic_ref, record, reserved);
> -       head_ref->extent_op =3D NULL;
> -
> -       delayed_refs =3D &trans->transaction->delayed_refs;
> -       spin_lock(&delayed_refs->lock);
> -
> -       /*
> -        * insert both the head node and the new ref without dropping
> -        * the spin lock
> -        */
> -       head_ref =3D add_delayed_ref_head(trans, head_ref, record,
> -                                       action, &qrecord_inserted);
> -
> -       merged =3D insert_delayed_ref(trans, head_ref, node);
> -       spin_unlock(&delayed_refs->lock);
> -
> -       /*
> -        * Need to update the delayed_refs_rsv with any changes we may ha=
ve
> -        * made.
> -        */
> -       btrfs_update_delayed_refs_rsv(trans);
> -
> -       trace_add_delayed_data_ref(trans->fs_info, node);
> -       if (merged)
> -               kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
> -
> -
> -       if (qrecord_inserted)
> -               return btrfs_qgroup_trace_extent_post(trans, record);
> -       return 0;
> +       ASSERT(generic_ref->type =3D=3D BTRFS_REF_DATA && generic_ref->ac=
tion);
> +       return __btrfs_add_delayed_ref(trans, generic_ref, NULL, reserved=
);
>  }
>
>  int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
> --
> 2.43.0
>
>

