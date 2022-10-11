Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21645FAF8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 11:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJKJoP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 05:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJKJoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 05:44:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F0D2AC75
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 02:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A82606115A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 09:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163DFC43470
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 09:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665481450;
        bh=6+ivgBOlD/0LavD8vok7XRI77/wFJMR4wz7DxA+B4fw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bq9BJET86qGyjjn1/JFFrXdOm5/+Q+bfYEi3603vdyHJ3Jyx5V+uOynbTxLdExeGk
         S8Q8mbJDQaK9opygZwwjVqHRo4ZzL/S23aZpeGswM27/1fLqIeR82+kHDdt0RF89vW
         S26pg7M0PG5kKCD2KuODHt0QdwpCUtaCAk2nWGb20gEkODaLjOjpOz9MHQGimL/rKD
         Q9U9x/uKPL64mWOHyX/wKtV4lLPQiXKGXOdAvpGVM8E2yAgPU73sg2iAunaNFibY+E
         cHIFiYcsM39RRYVscParjMAhXAX9nsV548zWgCA/81pbLemdftlKUl0H+EdtnOsLJn
         XYYSmcDR3tk1A==
Received: by mail-oi1-f171.google.com with SMTP id g130so15256462oia.13
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 02:44:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Sxq/w2W09+OnpAGc8rZx7iqWyouupwLpU7iFH1HpfmItbhRNW
        qtskwkNb5cXyBgWQrjpXiIoMeww2+R87ttC1wR4=
X-Google-Smtp-Source: AMsMyM5mkWwQpJLBDiSM2fXdPDGO0v99HvCnmTSFuix5QeHq6SPTDuKbx2BHbPuzlc0rS4PgqhPCMQijMUP6O9/6nD4=
X-Received: by 2002:a05:6808:1691:b0:351:48da:62e0 with SMTP id
 bb17-20020a056808169100b0035148da62e0mr11757700oib.98.1665481449125; Tue, 11
 Oct 2022 02:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <8f825fce9d2968034da43e09a4ebc38ec19a2e49.1665427766.git.boris@bur.io>
In-Reply-To: <8f825fce9d2968034da43e09a4ebc38ec19a2e49.1665427766.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 11 Oct 2022 10:43:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4L6ST88RpTojMmb-nQ82Y7ZYY-80Z+GSyLkMJ7zzVkDg@mail.gmail.com>
Message-ID: <CAL3q7H4L6ST88RpTojMmb-nQ82Y7ZYY-80Z+GSyLkMJ7zzVkDg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: skip reclaim if block_group is empty
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 10, 2022 at 8:25 PM Boris Burkov <boris@bur.io> wrote:
>
> As we delete extents from a block group, at some deletion we cross below
> the reclaim threshold. It is possible we are still in the middle of
> deleting more extents and might soon hit 0. If that occurs, we would
> leave the block group on the reclaim list, not in the care of unused
> deletion or async discard.
>
> It is pointless and wasteful to relocate empty block groups, so if we do

Hum? Why pointless and wasteful?
Relocating an empty block group results in deleting it.

In fact, before we tracked unused block groups and had the cleaner
kthread remove them, that was the only
way to delete unused block groups - trigger relocation from user space.

btrfs_relocate_chunk() explicitly calls btrfs_remove_chunk() at the
end, and the relocation itself
will do nothing except:

1) commit the current transaction when it starts
2) search the extent tree for extents in this block group - here it
will not find anything, and therefore do nothing.
3) commit another transaction

So I don't quite understand what this patch is trying to accomplish.

At the very least the changelog needs to be more detailed.

As it is, it gives the wrong idea that the relocation will leave the
block group around.
If your goal is to avoid the 2 transaction commits and the search on
the extent tree, then please be explicit in
the changelog.

Thanks.

> notice that case (we might not if the reclaim worker runs *before* we
> finish emptying it), don't bother with relocating the block group.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 11fd52657b76..c3ea627d2457 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1608,6 +1608,25 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>                         up_write(&space_info->groups_sem);
>                         goto next;
>                 }
> +               if (bg->used == 0) {
> +                       /*
> +                        * It is possible that we trigger relocation on a block
> +                        * group as its extents are deleted and it first goes
> +                        * below the threshold, then shortly goes empty. In that
> +                        * case, we will do relocation, even though we could
> +                        * more cheaply just delete the unused block group. Try
> +                        * to catch that case here, though of course it is
> +                        * possible there is a delete still coming the future,
> +                        * so we can't avoid needless relocation of this sort
> +                        * altogether. We can at least avoid relocating empty
> +                        * block groups.
> +                        */
> +                       if (!btrfs_test_opt(fs_info, DISCARD_ASYNC))
> +                               btrfs_mark_bg_unused(bg);
> +                       spin_unlock(&bg->lock);
> +                       up_write(&space_info->groups_sem);
> +                       goto next;
> +               }
>                 spin_unlock(&bg->lock);
>
>                 /* Get out fast, in case we're unmounting the filesystem */
> --
> 2.37.2
>
