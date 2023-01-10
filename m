Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CAD663FB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 13:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbjAJMDB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 07:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbjAJMC7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 07:02:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5394058331
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 04:02:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4D0F615F1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 12:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E52C43398
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 12:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673352177;
        bh=5UMeuxDxBHhgBLyGVOL7HhNUI4+kZ3ByMP8HYmgiQH8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mPFOlrIf0LQmXR6aWBCyluPZLqpv2nowh33ZgO82aYAi2Rh5yGlwkUc5tuy58Djbx
         S2xZFS+socUdIrUeajh2d1I+y3wgyqWTnVW3ZCRSgvW911MtQg62hFxnK+tJGtZL+D
         aBs9OcIQjz4XEoHu3VBKfqjiKZ+AL0AVsnkmSnFKme/F2quS8DA9IPloS1LNOqnBSI
         7KS0FRL2HjgEyPo5UMZ5Shyfl+KxB3LwpWR3pKVCnndgURoPBabyDJgC5/bpYlSj65
         ZibTSPer1UrPfQA3uYVUgvdMZiry8V44AbKuCiih+dRlHBCUZ9dioMbwhxmDwJ9bEo
         V1fmOwhjDyYGQ==
Received: by mail-oi1-f177.google.com with SMTP id v134so2161892oie.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 04:02:57 -0800 (PST)
X-Gm-Message-State: AFqh2krwFNmCAv2uius+phO/+mYgv5f3oewYiU9912h1GMWy3BYIgw1w
        2J2R0lX48Yhg6FaANDEoZVWEgfLcLk+WvriCHbs=
X-Google-Smtp-Source: AMrXdXsI8ooB3m+iZRZYIngb3tpnyMDg1OgcJrwkTVbRGZ5W8RK8yy3oVFMWFwWKXcBo+zevoGfPDtfyJudgOzNhl1Y=
X-Received: by 2002:a05:6808:1387:b0:35b:75b:f3b9 with SMTP id
 c7-20020a056808138700b0035b075bf3b9mr4194160oiw.98.1673352176328; Tue, 10 Jan
 2023 04:02:56 -0800 (PST)
MIME-Version: 1.0
References: <de9535cd9d3b5b020190bbfc751c3705fee8d55d.1673334821.git.wqu@suse.com>
In-Reply-To: <de9535cd9d3b5b020190bbfc751c3705fee8d55d.1673334821.git.wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 10 Jan 2023 12:02:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6dpWRHMxLpU2Nv6z2_2K3w+yG6JjJqUFVUhAAFqdaMJA@mail.gmail.com>
Message-ID: <CAL3q7H6dpWRHMxLpU2Nv6z2_2K3w+yG6JjJqUFVUhAAFqdaMJA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: do not warn on record without @old_roots populated
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Lukas Straub <lukasstraub2@web.de>,
        HanatoK <summersnow9403@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 10, 2023 at 7:18 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is some reports from the mailing list that since v6.1 kernel, the
> WARN_ON() inside btrfs_qgroup_account_extent() get triggered during
> rescan:
>
>  ------------[ cut here ]------------
>  WARNING: CPU: 3 PID: 6424 at fs/btrfs/qgroup.c:2756 btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
>  CPU: 3 PID: 6424 Comm: snapperd Tainted: P           OE      6.1.2-1-default #1 openSUSE Tumbleweed 05c7a1b1b61d5627475528f71f50444637b5aad7
>  RIP: 0010:btrfs_qgroup_account_extents+0x1ae/0x260 [btrfs]
>  Call Trace:
>   <TASK>
>  btrfs_commit_transaction+0x30c/0xb40 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
>   ? start_transaction+0xc3/0x5b0 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
>  btrfs_qgroup_rescan+0x42/0xc0 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
>   btrfs_ioctl+0x1ab9/0x25c0 [btrfs c39c9c546c241c593f03bd6d5f39ea1b676250f6]
>   ? __rseq_handle_notify_resume+0xa9/0x4a0
>   ? mntput_no_expire+0x4a/0x240
>   ? __seccomp_filter+0x319/0x4d0
>   __x64_sys_ioctl+0x90/0xd0
>   do_syscall_64+0x5b/0x80
>   ? syscall_exit_to_user_mode+0x17/0x40
>   ? do_syscall_64+0x67/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  RIP: 0033:0x7fd9b790d9bf
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
>
> [CAUSE]
> Since commit e15e9f43c7ca ("btrfs: introduce
> BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting"), if
> our qgroup is already in inconsistent status, we will no longer do the
> time-consuming backref walk.
>
> This can leave some qgroup records without a valid old_roots ulist.
> Normally this is fine, as btrfs_qgroup_account_extents() would also skip
> those records if we have NO_ACCOUNTING flag set.
>
> But there is a small window, if we have NO_ACCOUNTING flag set, and
> inserted some qgroup_record without a old_roots ulist, but then the user
> triggered a qgroup rescan.
>
> During btrfs_qgroup_rescan(), we firstly clear NO_ACCOUNTING flag, then
> commit current transaction.
>
> And since we have a qgroup_record with old_roots = NULL, we trigger the
> WARN_ON() during btrfs_qgroup_account_extents().
>
> [FIX]
> Unfortunately due to the introduce of NO_ACCOUNTING flag, the assumption
> that every qgroup_record would has its old_roots populated is no longer
> correct.
>
> So to fix the false alerts, just change the WARN_ON() to unlikely().
>
> Reported-by: Lukas Straub <lukasstraub2@web.de>
> Reported-by: HanatoK <summersnow9403@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/2403c697-ddaf-58ad-3829-0335fc89df09@gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

So missing a

Fixes: e15e9f43c7ca ("btrfs: introduce
BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting")

Or a

CC: stable@vger.kernel.org # 6.1+

No?

> ---
>  fs/btrfs/qgroup.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index d275bf24b250..6a1aedf0dc72 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2765,9 +2765,19 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
>
>                         /*
>                          * Old roots should be searched when inserting qgroup
> -                        * extent record
> +                        * extent record.
> +                        *
> +                        * But for INCONSISTENT (NO_ACCOUNTING) -> rescan case,
> +                        * we may have some record inserted during
> +                        * NO_ACCOUNTING (thus no old_roots populated), but
> +                        * later we start rescan, which clears NO_ACCOUNTING,
> +                        * leaving some inserted records without old_roots
> +                        * populated.
> +                        *
> +                        * Those cases are rare and should not cause too much
> +                        * time spent during commit_transaction().
>                          */
> -                       if (WARN_ON(!record->old_roots)) {
> +                       if (unlikely(!record->old_roots)) {
>                                 /* Search commit root to find old_roots */
>                                 ret = btrfs_find_all_roots(&ctx, false);
>                                 if (ret < 0)
> --
> 2.39.0
>
