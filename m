Return-Path: <linux-btrfs+bounces-4276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D488A510D
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 15:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D03028448C
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B48E12BEBA;
	Mon, 15 Apr 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw9G9muP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9C7691F
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186429; cv=none; b=QP5DTVR8u7YWCtmqODNE6tr4IDIQ9u6uXdMN3NPJQXk6CUbuiCFhbUWbDegBXSInhc0ryp6+Cb2zmlsrS0RFXGahIoJei080rY1PuDiMmzNr1EggdWFH45mYSe2MgRk+R1bF4Ye4ijSjTm+gET0YgHMtE+n7nNxS+eOiQhBGy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186429; c=relaxed/simple;
	bh=4RlLa0MPapOx7pnJ6oSSmrAiFh7XUhKlsUV9IIKsf94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0l2Wwt3sdZLYtbrZetTb6GGwwAY9V/jft03lzfW7J9S7w0ssr0MmPdJ1ZIuVfmZYcUTUCMXrUQrNUbAnO7/b6D/yUuWOsZmFmdENGHaZ954jKSu3IEDivEK7cGoYg6VUlZkSiw0VtVM0qulZwz2obL5ADWYVheMyVUBcKd7cNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw9G9muP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED8DC113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713186429;
	bh=4RlLa0MPapOx7pnJ6oSSmrAiFh7XUhKlsUV9IIKsf94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gw9G9muPFfL+Crxq7Hkm66th+gJ3tjcSx54o8fO//g/NNoOaQ/VAEIkoYc3QQfwiP
	 kue9JW/H4QKkiki6zDJEIJcAH/zg/p2frCdbIgxHRNLKXrnasqMflaOgNGSf+2tDDC
	 pc8OLTdhzbqP18QmthZRIC3ry1uWS2zFJYqI6m79H9rFo7+XGhngj7/Ry4EImBaNQk
	 ka8a7glQkhXEOBg61NXZ6Lrgmv+BdtR7MrMbbi9e3ndzKEqjqzGpTuUgeIrb91zQlV
	 xBcx4wNnT+H6rbLWl4KRZBNPGeWhWPxIGltEfGA0d09l8iojtGHGRJJlaYoHjkFDqY
	 q0LTz1AOGDPEg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso394078266b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 06:07:09 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzz2zWBPXYVXL5S4K8tKM5ZZSBFawE7QgKQ1JmCcc+zS8WTlYWP
	zSWkCB/VMFga0hJDefoLqgcYLvhNOTarlmu3ggFvbX8eB4CN4Qj/CfT8uDkfwcculJvUOxyxOiX
	N2gVUxb5u6cC7Q80diiUNrkkAM2k=
X-Google-Smtp-Source: AGHT+IGanqozWWoKkA/3RO91YgBDrIENlOjhhyQdSljDWMubaPMSOzX7d+RvmC6Flr1vlI9vzfC/4fWOaXzcdBeZu2s=
X-Received: by 2002:a17:907:1c0d:b0:a4e:7a36:4c38 with SMTP id
 nc13-20020a1709071c0d00b00a4e7a364c38mr9036726ejc.20.1713186427861; Mon, 15
 Apr 2024 06:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <1d1242ed8cf7fb5705b55e5ee6a7a88faa392ef4.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <1d1242ed8cf7fb5705b55e5ee6a7a88faa392ef4.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 14:06:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5HwmPG0awqkxQBCGPS1u+6Teq2jOQCBcOSOcrCW6D6aw@mail.gmail.com>
Message-ID: <CAL3q7H5HwmPG0awqkxQBCGPS1u+6Teq2jOQCBcOSOcrCW6D6aw@mail.gmail.com>
Subject: Re: [PATCH 18/19] btrfs: remove the btrfs_delayed_ref_node container helpers
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:55=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> Now that we don't use these helpers anywhere, remove them.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.


> ---
>  fs/btrfs/delayed-ref.h | 27 ---------------------------
>  1 file changed, 27 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 0bc80ed8b2c7..84bc990e34fd 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -399,33 +399,6 @@ void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_=
fs_info *fs_info,
>                                        u64 num_bytes);
>  bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
>
> -/*
> - * helper functions to cast a node into its container
> - */
> -static inline struct btrfs_delayed_tree_ref *
> -btrfs_delayed_node_to_tree_ref(struct btrfs_delayed_ref_node *node)
> -{
> -       return &node->tree_ref;
> -}
> -
> -static inline struct btrfs_delayed_data_ref *
> -btrfs_delayed_node_to_data_ref(struct btrfs_delayed_ref_node *node)
> -{
> -       return &node->data_ref;
> -}
> -
> -static inline struct btrfs_delayed_ref_node *
> -btrfs_delayed_tree_ref_to_node(struct btrfs_delayed_tree_ref *ref)
> -{
> -       return container_of(ref, struct btrfs_delayed_ref_node, tree_ref)=
;
> -}
> -
> -static inline struct btrfs_delayed_ref_node *
> -btrfs_delayed_data_ref_to_node(struct btrfs_delayed_data_ref *ref)
> -{
> -       return container_of(ref, struct btrfs_delayed_ref_node, data_ref)=
;
> -}
> -
>  static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_node =
*node)
>  {
>         if ((node->type =3D=3D BTRFS_EXTENT_DATA_REF_KEY) ||
> --
> 2.43.0
>
>

