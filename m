Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703092A95D8
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKFLzY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgKFLzX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:55:23 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1912C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:55:23 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id i21so730404qka.12
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QAqo29/7yDXYPo6X4+XlWr/Lw4ZP0o4YPe1cIfFAmYk=;
        b=qdophHzVg6Lxknb/NkKh82k/o0CEZ4Oj0gHEjWhi02nHEFtJV60drIKm8gVHfhPr9r
         MstCX/PKAYUVgII17pCJGMPwLydb781AroMMnoryLQuRbdp3XPpShx0IvZhqhGLGi0lc
         s8K8o2ut8TYQNbC/ogOwNT79+wdnue5QHs9x9cVwveCAJuiSL10HbOUs5nGDnviEHHr9
         G/aioT+PN1jOg/IqCciRtdwl/jBUIyXscgXDqlBtdLrtKUZl10IMY7Smk8zGCYyk/IJi
         vDVC+QorVBkZvaJR3DoZuEM8JeDIdEH7JTN8dBk+o2abVJdVNNmTu/Ogejwb74AtNLne
         f3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=QAqo29/7yDXYPo6X4+XlWr/Lw4ZP0o4YPe1cIfFAmYk=;
        b=sHSYajlgyCvN4ZTgjyTo0JTExf+DSjyMzbqX6cn4gi1hSGcMydxx1DjUjdTE7+p/BR
         kT7BbBHPktnjUEClGpf2UInfOxHgMi46xD2Bh1fGNl73ShqcW82HBhoXEMI0AvoovPzT
         wjQyOdFG1WauPpj+PyQd+gmU6D8W8pJElieHP7qSg0/+ShtQV9ZeNVg4qwa9hephAfbS
         nChrQcUs8gGnjRiGVVc+SiBCcGFFBVRcH/KzTLu34UBQBCM64rGsPR9TPkCuBXXKO15Z
         40mXFklgEgx5+PclQ7lSRAJ187eNiAysP4riGZEp14sFT61eJbSqjesuSZ4KrPuo3sNZ
         eqEA==
X-Gm-Message-State: AOAM5309PS2TqV4DN3Gv8aGv2L04isKrZXow83UMOwo/Of7wfaqv5F6i
        BcXApqywfdVLCdz+TKIlSrCAhqPAePuFy8J8ee07jwdNOtA=
X-Google-Smtp-Source: ABdhPJyWjyodI/mC9ReqmoEEpB4I2vkBjGfLkH5GpNS9rxcdWBdnY48ankAi7NJVMTpwWO9Vapqz8awfEXgJSXFt+is=
X-Received: by 2002:a37:4117:: with SMTP id o23mr749972qka.479.1604663723038;
 Fri, 06 Nov 2020 03:55:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <4e8c871927bd508d2226eefc65c977b252377aa0.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <4e8c871927bd508d2226eefc65c977b252377aa0.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:55:12 +0000
Message-ID: <CAL3q7H6HyacuDFm2+vDxQtgBTv=YE6-20e1QqX6rDEwLoN0JFQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] btrfs: use btrfs_read_node_slot in btrfs_qgroup_trace_subtree
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
>  fs/btrfs/qgroup.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 8d112ff7b5ae..25e3b7105e8a 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2182,30 +2182,21 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans=
_handle *trans,
>         level =3D root_level;
>         while (level >=3D 0) {
>                 if (path->nodes[level] =3D=3D NULL) {
> -                       struct btrfs_key first_key;
>                         int parent_slot;
> -                       u64 child_gen;
>                         u64 child_bytenr;
>
>                         /*
> -                        * We need to get child blockptr/gen from parent =
before
> -                        * we can read it.
> +                        * We need to get child blockptr from parent befo=
re we
> +                        * can read it.
>                           */
>                         eb =3D path->nodes[level + 1];
>                         parent_slot =3D path->slots[level + 1];
>                         child_bytenr =3D btrfs_node_blockptr(eb, parent_s=
lot);
> -                       child_gen =3D btrfs_node_ptr_generation(eb, paren=
t_slot);
> -                       btrfs_node_key_to_cpu(eb, &first_key, parent_slot=
);
>
> -                       eb =3D read_tree_block(fs_info, child_bytenr, chi=
ld_gen,
> -                                            level, &first_key);
> +                       eb =3D btrfs_read_node_slot(eb, parent_slot);
>                         if (IS_ERR(eb)) {
>                                 ret =3D PTR_ERR(eb);
>                                 goto out;
> -                       } else if (!extent_buffer_uptodate(eb)) {
> -                               free_extent_buffer(eb);
> -                               ret =3D -EIO;
> -                               goto out;
>                         }
>
>                         path->nodes[level] =3D eb;
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
