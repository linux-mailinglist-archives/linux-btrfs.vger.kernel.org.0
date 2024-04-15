Return-Path: <linux-btrfs+bounces-4277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B128A512C
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FB9B23A2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266F7F492;
	Mon, 15 Apr 2024 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlYB9j+G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF76AF88
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186754; cv=none; b=M2Nwr9BxEUzLZlcGrAqzPoHj0G1Vj/CxaaVCb//19YOyvnQaQ2YXNCHiVdzaDOt9VUa/ddgIpuhWO5KpSpdrqdjKUsfc8s9Hj8qHu9rmjcHONXqrF3XxktfCSyLgigDHp3KE6C5nPVGeYHK7J3TFyHgCF0lCXgnYn2yNonWKzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186754; c=relaxed/simple;
	bh=c7j4Wmsja3MH4yUA+gtBXUSakLW8Q7bygPZDJjgerZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOwDbT58uDunoF5VoJ6SsSot7F2y70WEv3cXmR8WZyg8QwJiDk3TSbd+FQiiyAjfKuR32IJJC7OYFHxFHYSI6uey9uPqkHPJPsZNj+tiomkBt4cdoz+FsIDcU5YVKOdl5z7FktXWPCXhlqYcJk0DfhUGbgZdwROI2M8bk7lFYJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlYB9j+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CE1C113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713186754;
	bh=c7j4Wmsja3MH4yUA+gtBXUSakLW8Q7bygPZDJjgerZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PlYB9j+GKnHgyxRdPT8SGSN1nqVxN7cwZumFzz+/jCHHTbH8Q3/iJAIlHpYFLZa3n
	 OQ5r990RTQ6/l9reUAcnUWo4GQ1hwc96Js3ucrn16zriToaZuO0BDt/fztMJFCMBXi
	 AgVanUAq4OH55LtoqiiluIsh1yIDQgsYCewG50zDGqvRyZVju9Uvacg3hGIvugt6KY
	 dCmJeiyy4TvZBJsJmvfcIrWRzfgC6eueQhHyx5Mln8l+KQ2wuzv1bwLmBIJtfNa2le
	 TVOUKiDf4kT3/3WKb+f40sapX4FrZt9bYVav1PtZ532Wp6FUVtaMj2QtJwts5wksYL
	 TLl53p4kJPkcg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4702457ccbso396106066b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 06:12:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz9iwFhrmI3FJ4xjEyzKDTnR298CEKdnYtS0hGNN3g5kutYBQll
	TxTwQiuT9XZaovMPjE7HZAiuJXE6QI3fHgFkAPRqjDWHrcVsPB69OCWna7zyE+hoCb9lfOtnaox
	/58oNOOvsF1xATH8SQ3G1W252rag=
X-Google-Smtp-Source: AGHT+IHkRy2lYeLAgmN++u7CKnMtABZAwjf3y5XFV9mkAdTQe5kZDVY2nVp0mxPC6J4YSunYI38vT8hRy5D+87k2I0s=
X-Received: by 2002:a17:906:aec6:b0:a51:a28e:837e with SMTP id
 me6-20020a170906aec600b00a51a28e837emr6181999ejb.31.1713186752731; Mon, 15
 Apr 2024 06:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <803b5e1780c28bb432930ab7df4459c0f3d4edaf.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <803b5e1780c28bb432930ab7df4459c0f3d4edaf.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 14:11:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6kM1Fh5kv+NNiU2F8rTjd6U_6AQLFubOvSgSYwuPgHaw@mail.gmail.com>
Message-ID: <CAL3q7H6kM1Fh5kv+NNiU2F8rTjd6U_6AQLFubOvSgSYwuPgHaw@mail.gmail.com>
Subject: Re: [PATCH 19/19] btrfs: replace btrfs_delayed_*_ref with btrfs_*_ref
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:55=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> Now that these two structs are the same, move the btrfs_data_ref and
> btrfs_tree_ref up and use these in the btrfs_delayed_ref_node.  Then
> remove the btrfs_delayed_*_ref structs.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/delayed-ref.c | 10 +++-----
>  fs/btrfs/delayed-ref.h | 57 ++++++++++++++++++------------------------
>  2 files changed, 28 insertions(+), 39 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 397e1d0b4010..582660833c1b 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -982,12 +982,10 @@ static void init_delayed_ref_common(struct btrfs_fs=
_info *fs_info,
>         RB_CLEAR_NODE(&ref->ref_node);
>         INIT_LIST_HEAD(&ref->add_list);
>
> -       if (generic_ref->type =3D=3D BTRFS_REF_DATA) {
> -               ref->data_ref.objectid =3D generic_ref->data_ref.objectid=
;
> -               ref->data_ref.offset =3D generic_ref->data_ref.offset;
> -       } else {
> -               ref->tree_ref.level =3D generic_ref->tree_ref.level;
> -       }
> +       if (generic_ref->type =3D=3D BTRFS_REF_DATA)
> +               ref->data_ref =3D generic_ref->data_ref;
> +       else
> +               ref->tree_ref =3D generic_ref->tree_ref;
>  }
>
>  void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 m=
od_root,
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 84bc990e34fd..dfacbafb1b00 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -30,13 +30,30 @@ enum btrfs_delayed_ref_action {
>         BTRFS_UPDATE_DELAYED_HEAD,
>  } __packed;
>
> -struct btrfs_delayed_tree_ref {
> -       int level;
> +struct btrfs_data_ref {
> +       /* For EXTENT_DATA_REF */
> +
> +       /* Inode which refers to this data extent */
> +       u64 objectid;
> +
> +       /*
> +        * file_offset - extent_offset
> +        *
> +        * file_offset is the key.offset of the EXTENT_DATA key.
> +        * extent_offset is btrfs_file_extent_offset() of the EXTENT_DATA=
 data.
> +        */
> +       u64 offset;
>  };
>
> -struct btrfs_delayed_data_ref {
> -       u64 objectid;
> -       u64 offset;
> +struct btrfs_tree_ref {
> +       /*
> +        * Level of this tree block

Add missing punctuation at the end of the sentence.

Otherwise it looks good, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


> +        *
> +        * Shared for skinny (TREE_BLOCK_REF) and normal tree ref.
> +        */
> +       int level;
> +
> +       /* For non-skinny metadata, no special member needed */
>  };
>
>  struct btrfs_delayed_ref_node {
> @@ -84,8 +101,8 @@ struct btrfs_delayed_ref_node {
>         unsigned int type:8;
>
>         union {
> -               struct btrfs_delayed_tree_ref tree_ref;
> -               struct btrfs_delayed_data_ref data_ref;
> +               struct btrfs_tree_ref tree_ref;
> +               struct btrfs_data_ref data_ref;
>         };
>  };
>
> @@ -222,32 +239,6 @@ enum btrfs_ref_type {
>         BTRFS_REF_LAST,
>  } __packed;
>
> -struct btrfs_data_ref {
> -       /* For EXTENT_DATA_REF */
> -
> -       /* Inode which refers to this data extent */
> -       u64 objectid;
> -
> -       /*
> -        * file_offset - extent_offset
> -        *
> -        * file_offset is the key.offset of the EXTENT_DATA key.
> -        * extent_offset is btrfs_file_extent_offset() of the EXTENT_DATA=
 data.
> -        */
> -       u64 offset;
> -};
> -
> -struct btrfs_tree_ref {
> -       /*
> -        * Level of this tree block
> -        *
> -        * Shared for skinny (TREE_BLOCK_REF) and normal tree ref.
> -        */
> -       int level;
> -
> -       /* For non-skinny metadata, no special member needed */
> -};
> -
>  struct btrfs_ref {
>         enum btrfs_ref_type type;
>         enum btrfs_delayed_ref_action action;
> --
> 2.43.0
>
>

