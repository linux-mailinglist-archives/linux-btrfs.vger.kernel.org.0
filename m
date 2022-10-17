Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B68600E1E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJQLs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiJQLsr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:48:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DD659258;
        Mon, 17 Oct 2022 04:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43311B8104C;
        Mon, 17 Oct 2022 11:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0096CC43470;
        Mon, 17 Oct 2022 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666007312;
        bh=HP4XeBwhzzfRODTCqrcEZm4j48kl6FVUtIqnjwkTnN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NfnkRygm7zsT4l4iAjw5WX3EiM7mqytDFaPWBl1ZG0AaZksd+Jp/HxqEZgEUrbvcp
         1tkFBfoYeG3VMtPfCiynvBAozoopMQMhx+mJX6dgzq0SnLHSYjEOPEdE2sp3xp6ECf
         VAnxgcH9Ww577t+0Pe+3h92zYcvJIUSlaEDf4ehC6cBXB6tsu4Jp1mVfSs0Bj5NRGz
         FJsWUtNKtauKjQr8Eyfv2M4l/L7OpBPwUImrC6kmHvPEFZYzCmF6TmgzgTcv4COGpB
         uuenFRFpkEJHruTXwie0Ueexs5LSISOM82WFJNiGgN3P7nIXzYZEOJkoR00NI3r7SA
         awfsoWODlKjvw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1364357a691so12909591fac.7;
        Mon, 17 Oct 2022 04:48:31 -0700 (PDT)
X-Gm-Message-State: ACrzQf1r+OanXUqsGgMB9xyAvOsqd/lSHSc1pu4CjVzN4rHGm/Bm36nI
        HjJaKu3Xeo+glkRyyKQju3nV97bR2vh1vaumXvE=
X-Google-Smtp-Source: AMsMyM71RbymNmpADSzXueK2qfrYw0uqs03kEAUw8sKggyNY4XvntT3f6u+bg/cYQljnPZUXaeAyj2r61Fij55Ihwrk=
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id
 l18-20020a056870205200b0013207b22fe6mr5417466oad.98.1666007311105; Mon, 17
 Oct 2022 04:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221016153346.2794-1-bingjingc@synology.com>
In-Reply-To: <20221016153346.2794-1-bingjingc@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 17 Oct 2022 12:47:54 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6G8X73Bndwj5PF46Nn=E9U7VHJBjwKtFQnWDu=spTWPw@mail.gmail.com>
Message-ID: <CAL3q7H6G8X73Bndwj5PF46Nn=E9U7VHJBjwKtFQnWDu=spTWPw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: send: fix send failure of a subcase of orphan inodes
To:     bingjingc <bingjingc@synology.com>
Cc:     josef@toxicpanda.com, dsterba@suse.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        bxxxjxxg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 16, 2022 at 4:34 PM bingjingc <bingjingc@synology.com> wrote:
>
> From: BingJing Chang <bingjingc@synology.com>
>
> Commit 9ed0a72e5b35 ("btrfs: send: fix failures when processing inodes with
> no links") tries to fix all incremental send cases of orphan inodes the
> send operation will meet. However, there's still a bug causing the corner
> subcase fails with a ENOENT error.
>
> Here's shortened steps of that subcase:
>
>   $ btrfs subvolume create vol
>   $ touch vol/foo
>
>   $ btrfs subvolume snapshot -r vol snap1
>   $ btrfs subvolume snapshot -r vol snap2
>
>   # Turn the second snapshot to RW mode and delete the file while
>   # holding an open file descriptor on it
>   $ btrfs property set snap2 ro false
>   $ exec 73<snap2/foo
>   $ rm snap2/foo
>
>   # Set the second snapshot back to RO mode and do an incremental send
>   # with an unusal reverse order
>   $ btrfs property set snap2 ro true
>   $ btrfs send -p snap2 snap1 > /dev/null
>   At subvol snap1
>   ERROR: send ioctl failed with -2: No such file or directory
>
> It's subcase 3 of BTRFS_COMPARE_TREE_CHANGED in the commit 9ed0a72e5b35
> ("btrfs: send: fix failures when processing inodes with no links"). And
> it's not a common case. We still have not met it in the real world.
> Theoretically, this case can happen in a batch cascading snapshot backup.
> In cascading backups, the receive operation in the middle may cause orphan
> inodes to appear because of the open file descriptors on the snapshot files
> during receiving. And if we don't do the batch snapshot backups in their
> creation order, then we can have an inode, which is an orphan in the parent
> snapshot but refers to a file in the send snapshot. Since an orphan inode
> has no paths, the send operation will fail with a ENOENT error if it
> tries to generate a path for it.
>
> In that patch, this subcase will be treated as an inode with a new
> generation. However, when the routine tries to delete the old paths in
> the parent snapshot, the function process_all_refs() doesn't check whether
> there are paths recorded or not before it calls the function
> process_recorded_refs(). And the function process_recorded_refs() try
> to get the first path in the parent snapshot in the beginning. Since it has
> no paths in the parent snapshot, the send operation fails.
>
> To fix this, we can easily put a link count check to avoid entering the
> deletion routine like what we do a link count check to avoid creating a
> new one. Moreover, we can assume that the function process_all_refs()
> can always collect references to process because we know it has a
> positive link count.
>
> Signed-off-by: BingJing Chang <bingjingc@synology.com>

Looks good.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Please add a test case for fstests later if you can.
Thanks!

> ---
>  fs/btrfs/send.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 4ef4167072b8..1568fa977ca1 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6665,17 +6665,19 @@ static int changed_inode(struct send_ctx *sctx,
>                         /*
>                          * First, process the inode as if it was deleted.
>                          */
> -                       sctx->cur_inode_gen = right_gen;
> -                       sctx->cur_inode_new = false;
> -                       sctx->cur_inode_deleted = true;
> -                       sctx->cur_inode_size = btrfs_inode_size(
> -                                       sctx->right_path->nodes[0], right_ii);
> -                       sctx->cur_inode_mode = btrfs_inode_mode(
> -                                       sctx->right_path->nodes[0], right_ii);
> -                       ret = process_all_refs(sctx,
> -                                       BTRFS_COMPARE_TREE_DELETED);
> -                       if (ret < 0)
> -                               goto out;
> +                       if (old_nlinks > 0) {
> +                               sctx->cur_inode_gen = right_gen;
> +                               sctx->cur_inode_new = false;
> +                               sctx->cur_inode_deleted = true;
> +                               sctx->cur_inode_size = btrfs_inode_size(
> +                                               sctx->right_path->nodes[0], right_ii);
> +                               sctx->cur_inode_mode = btrfs_inode_mode(
> +                                               sctx->right_path->nodes[0], right_ii);
> +                               ret = process_all_refs(sctx,
> +                                               BTRFS_COMPARE_TREE_DELETED);
> +                               if (ret < 0)
> +                                       goto out;
> +                       }
>
>                         /*
>                          * Now process the inode as if it was new.
> --
> 2.37.1
>
