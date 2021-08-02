Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACCC3DD4AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 13:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhHBL2n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 07:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbhHBL2m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Aug 2021 07:28:42 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA0CC06175F
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Aug 2021 04:28:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d2so11364063qto.6
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Aug 2021 04:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ERwib7j9Wiu8pwR8UBUpB7bLsek4jz0KOl8CMA+X5og=;
        b=tYoTYcVGH6ZqIrMkUHIhbBtuTBrn/2VTR1VX0RKfTHNeGI9/cO00AtFqV94vSH0Izx
         FoWSdiVsILZY71aCSC6nOl3ulx8EJxobTv9ZskH0BxW2VG2BRouOpwq+XAckEcGNWfNV
         Et9X5sPNM1TBS+6Gi3dEDdNcxSXuryfRBI1ISD6xkHrM82eUaRwj0j3zX0VyRPTkMWdx
         UkGmwO9SCqqOqaoTu6aADi2XkhY62nvJ6StMBpuL8aPYTc6n61A81hxAJSoWrNv42PKw
         Tp+LMZ3jFCx1K48LuuSnRSxkbD9xbXfxA2RMy5yQc3LWhCsy/SLezGLcUVQrC/iiF+Eo
         ImkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ERwib7j9Wiu8pwR8UBUpB7bLsek4jz0KOl8CMA+X5og=;
        b=VZjIeZTTxz+4hRJppATdlm3370G3QvC6bd0uF8Wj1zKZQ71sFkZIHviTuEzj1bsoeI
         suhxsaWSz7gzRBB9/XG+GUPGZtsSi45o+DQHLoSCa2ZA7YQ+WLqIq+sc80PoZ4BzSYzS
         Z2AfPULnCJYBSaVl612APBHv1J58hXGgU6+GqkL49/RESUxzl9yMriiVMve6FK//raYy
         54va8CVXEMcnrV4d6IwkGmYxNkxTMyXeu5vtTtPlz1OFDGokgnW+onL0VP6mbqNRQ3pI
         cO0e/VnVncBgg9ArSESuXtbCeqp5wVD8xfm/tWcWqaSxkj34AOP2Q2SFqh62H0k80LJB
         h9XQ==
X-Gm-Message-State: AOAM533+egdqrvjUXen2NVvPI4atTtOhKMY13B8jU89tK1Vg5NPqTXRU
        NOUifGZNMYxmQk+kLdEXm5HnK5ngXGoXBv/q/pM=
X-Google-Smtp-Source: ABdhPJwQzwCc5RuPA63QebKfdGFzQ6gBslAT7D6Sq5MdY5BvA65E4zN2sTq/1cD5GzNE3EtK7aGMHFKzolRPcsQRzgs=
X-Received: by 2002:ac8:7c85:: with SMTP id y5mr14029576qtv.376.1627903712508;
 Mon, 02 Aug 2021 04:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210802104004.733-1-robbieko@synology.com>
In-Reply-To: <20210802104004.733-1-robbieko@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 2 Aug 2021 12:28:21 +0100
Message-ID: <CAL3q7H6BpnTLqugMh7NrSSqdB4NE4HnuWPYmKOV79UD3v3UBsA@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix root drop key mismatch when drop snapshot fails
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 2, 2021 at 11:41 AM robbieko <robbieko@synology.com> wrote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> When walk down/up tree fails, we did not abort the transaction,
> nor did modify the root drop key, but the refs of some tree blocks
> may have been removed in the transaction.
>
> Therefore, when we retry to delete subvol in the future, and
> missing reference occurs when lookup extent info.

This sentence is confusing, it took me some time to understand it.

Something like:

Therefore when we retry to delete the subvolume in the future, we will
fail due to
the fact that some references were deleted in the previous attempt:

>
> ------------[ cut here ]------------
> WARNING: at fs/btrfs/extent-tree.c:898 btrfs_lookup_extent_info+0x40a/0x4=
c0 [btrfs]()
> CPU: 2 PID: 11618 Comm: btrfs-cleaner Tainted: P
> Hardware name: Synology Inc. RS3617xs Series/Type2 - Board Product Name1,=
 BIOS M.017 2019/10/16
> ffffffff814c2246 ffffffff81036536 ffff88024a911d08 ffff880262de45b0
> ffff8802448b5f20 ffff88024a9c1ad8 0000000000000000 ffffffffa08eb05a
> 000008f84e72c000 0000000000000000 0000000000000001 0000000100000000
> Call Trace:
> [<ffffffff814c2246>] ? dump_stack+0xc/0x15
> [<ffffffff81036536>] ? warn_slowpath_common+0x56/0x70
> [<ffffffffa08eb05a>] ? btrfs_lookup_extent_info+0x40a/0x4c0 [btrfs]
> [<ffffffffa08ee558>] ? do_walk_down+0x128/0x750 [btrfs]
> [<ffffffffa08ebab4>] ? walk_down_proc+0x314/0x330 [btrfs]
> [<ffffffffa08eec42>] ? walk_down_tree+0xc2/0xf0 [btrfs]
> [<ffffffffa08f2bce>] ? btrfs_drop_snapshot+0x40e/0x9a0 [btrfs]
> [<ffffffffa09096db>] ? btrfs_clean_one_deleted_snapshot+0xab/0xe0 [btrfs]
> [<ffffffffa08fe970>] ? cleaner_kthread+0x280/0x320 [btrfs]
> [<ffffffff81052eaf>] ? kthread+0xaf/0xc0
> [<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
> [<ffffffff814c8c0d>] ? ret_from_fork+0x5d/0xb0
> [<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
> ------------[ end trace ]------------
> BTRFS error (device dm-1): Missing references.
> BTRFS: error (device dm-1) in btrfs_drop_snapshot:9557: errno=3D-5 IO fai=
lure
>
> We fix this problem by abort trnasaction when walk down/up tree fails.

Typo in "trnasaction". Also "by aborting the transaction".

Finally you should be more explicit about the problem, something like:

By not aborting the transaction, every future attempt to delete the
subvolume fails and we
end up never freeing all the extents used by the subvolume/snapshot.
By aborting the transaction we have a least the possibility to
succeeded after unmounting
and mounting again the filesystem.

Also use "btrfs: " instead of "Btrfs: " in the subject.

Now my question is, why can't the problem be solved by ensuring we
persist a correct drop progress key?

That is, if walk up or walk down fails, still try to update the drop
progress and the root item with the new drop progress - aborting the
transaction only if we get an error updating the root item.

Is there a reason why that can't be done? If that does not work, it
should be mentioned in the change log.

Thanks.


>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/btrfs/extent-tree.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 268ce58d4569..49cdb7eeccb3 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5659,8 +5659,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, i=
nt update_ref, int for_reloc)
>                 }
>         }
>         btrfs_release_path(path);
> -       if (err)
> +       if (err) {
> +               btrfs_abort_transaction(trans, err);
>                 goto out_end_trans;
> +       }
>
>         ret =3D btrfs_del_root(trans, &root->root_key);
>         if (ret) {
> --
> 2.17.1
>


--
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
