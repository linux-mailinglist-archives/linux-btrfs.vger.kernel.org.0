Return-Path: <linux-btrfs+bounces-16864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FE9B59F66
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 19:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE0946569D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647212820DB;
	Tue, 16 Sep 2025 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWZhDepa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA872F5A17
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044164; cv=none; b=Lv8pVmTaX7GAgsBAgFsGjarVqleiz6yMcRJM9AgF6TUmqgB4yTW8wDjPmhyBh+I3jq124XpfXLLhTxoc6rRzz18xQigiwRNOCr0C/5d2DYzOOHgPnBE70JptheRAgd3akADba4bEIK/Wt8FE0OQF0shizB2Wj42bQtDkLemH49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044164; c=relaxed/simple;
	bh=XMYmd2G7zZqS/8EObfS7zYK1XlITnOtWGeMZwuTPb3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cK3KY1hIAsyW3Y5ph1L5ISicmS/iEUub7kRA/486erSmQ/3z2DlIVavGvqskeY3cNpNFvq7v1j16zvvkV7UD8lFtn33WZiuAL+lI2R/RlZUHTHPyuUXE3JgMMyadbk/QYp9672atDRciT5im1Lp7QocF03jTPAvyzI/Hc9Vub5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWZhDepa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5834C4CEF9
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758044163;
	bh=XMYmd2G7zZqS/8EObfS7zYK1XlITnOtWGeMZwuTPb3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nWZhDepa3JkpssLSQARR5M80UVUbR3Yo54tTLbSGg4aHOpEKgE3TEDvF+w0cwWE3w
	 qEm3l+WhXiCNWY4656RVIx/SHzBaPVOv09eXEwmVJl5n/86Ab6mOw9rOMLFzoqIRcE
	 xobpCEmhtK/M60PlVRCY9w4FYX/P4H5XjBTU7h7+ZDVw6DzLC359fl5CWFQmNybOWk
	 SaRSDc9hEmbGhwxSv09F4I2+wnDeWQt9yYBvlg6m9L/SbHBaxlXqe2mw1t07XF5ELZ
	 Qgn+uUCINfFobDppwvqgOTBjlTL538xOp0lmR0Nu+7fPkImP7Ml3UubItOwtdLd7At
	 8mjWGP24L6VNw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so951658866b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 10:36:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YyoRcZPlnubXDDA1m5zbjsONMdCMY55H/gPycct9rA/ugZedVeV
	tuKmzpBLjf+nxGqVOjJ+HjFEd3uu2Z1wTfcdpyE/APmRwTXAm6I0SZgLmA1Dzl2jNdy92bR061C
	vrVKFeVpn01T8zf96TouXEUNwKYiMLvI=
X-Google-Smtp-Source: AGHT+IGRg0r5lgzSwfUpbRPPhEz+JizVDotthOfEKgbH5f4x8s8ZHHpX0USu18o2Pqj4ih2HFq+yLg2GJvcgly2rMJ4=
X-Received: by 2002:a17:907:3faa:b0:b04:3629:b00e with SMTP id
 a640c23a62f3a-b07c35cd75fmr1676509466b.29.1758044162540; Tue, 16 Sep 2025
 10:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bce5bcbbb1f0bb0b6b10700714ef7169f7d57082.1757977422.git.wqu@suse.com>
In-Reply-To: <bce5bcbbb1f0bb0b6b10700714ef7169f7d57082.1757977422.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Sep 2025 18:35:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H76Tm=yg4tu683n7caXMS55s=fVW_c=jrJPUrA5dMPKBg@mail.gmail.com>
X-Gm-Features: AS18NWDq3XIC-LCy_2dXoEHsvMBCQBAo7xAbaX59wP_vxdAndon8BscIxwfO1sY
Message-ID: <CAL3q7H76Tm=yg4tu683n7caXMS55s=fVW_c=jrJPUrA5dMPKBg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: add inode extref checks
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:04=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Like inode refs, inode extrefs have a variable length name, which means
> we have to do a proper check to make sure no header nor name can exceed
> the item limits.
>
> The check itself is very similar to check_inode_ref(), just a different
> structure (btrfs_inode_extref vs btrfs_inode_ref).
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tree-checker.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index c2aac08055fb..ca30b15ea452 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -183,6 +183,7 @@ static bool check_prev_ino(struct extent_buffer *leaf=
,
>         /* Only these key->types needs to be checked */
>         ASSERT(key->type =3D=3D BTRFS_XATTR_ITEM_KEY ||
>                key->type =3D=3D BTRFS_INODE_REF_KEY ||
> +              key->type =3D=3D BTRFS_INODE_EXTREF_KEY ||
>                key->type =3D=3D BTRFS_DIR_INDEX_KEY ||
>                key->type =3D=3D BTRFS_DIR_ITEM_KEY ||
>                key->type =3D=3D BTRFS_EXTENT_DATA_KEY);
> @@ -1782,6 +1783,39 @@ static int check_inode_ref(struct extent_buffer *l=
eaf,
>         return 0;
>  }
>
> +static int check_inode_extref(struct extent_buffer *leaf,
> +                             struct btrfs_key *key, struct btrfs_key *pr=
ev_key,
> +                             int slot)
> +{
> +       unsigned long ptr =3D btrfs_item_ptr_offset(leaf, slot);
> +       unsigned long end =3D ptr + btrfs_item_size(leaf, slot);
> +
> +       if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
> +               return -EUCLEAN;
> +
> +       while (ptr < end) {
> +               struct btrfs_inode_extref *extref =3D (struct btrfs_inode=
_extref *)ptr;
> +               u16 namelen;
> +
> +               if (unlikely(ptr + sizeof(*extref)) > end) {
> +                       inode_ref_err(leaf, slot,
> +                       "inode extref overflow, ptr %lu end %lu inode_ext=
ref size %zu",
> +                                     ptr, end, sizeof(*extref));
> +                       return -EUCLEAN;
> +               }
> +
> +               namelen =3D btrfs_inode_extref_name_len(leaf, extref);
> +               if (unlikely(ptr + sizeof(*extref) + namelen > end)) {
> +                       inode_ref_err(leaf, slot,
> +                               "inode extref overflow, ptr %lu end %lu n=
amelen %u",
> +                               ptr, end, namelen);
> +                       return -EUCLEAN;
> +               }
> +               ptr +=3D sizeof(*extref) + namelen;
> +       }
> +       return 0;
> +}
> +
>  static int check_raid_stripe_extent(const struct extent_buffer *leaf,
>                                     const struct btrfs_key *key, int slot=
)
>  {
> @@ -1893,6 +1927,9 @@ static enum btrfs_tree_block_status check_leaf_item=
(struct extent_buffer *leaf,
>         case BTRFS_INODE_REF_KEY:
>                 ret =3D check_inode_ref(leaf, key, prev_key, slot);
>                 break;
> +       case BTRFS_INODE_EXTREF_KEY:
> +               ret =3D check_inode_extref(leaf, key, prev_key, slot);
> +               break;
>         case BTRFS_BLOCK_GROUP_ITEM_KEY:
>                 ret =3D check_block_group_item(leaf, key, slot);
>                 break;
> --
> 2.50.1
>
>

