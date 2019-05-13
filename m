Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691FF1BADB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfEMQSv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 12:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfEMQSu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 12:18:50 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EAF821473
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557764329;
        bh=0UX0s8ilBpzxpcuxyrjeslYUzggUf+mgdVYnNHm3g9o=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=DVg+gBDRuhaoCvDSRe8uEurbd2sAWLqvgaSyC9RAkG8/VseRGdVaco6LXqcma91N3
         tbZXE6iRgH3kPeVI41aP+WevuBOH9IBiKmLxJOA6XI+NynFROE3Hn/NyjTST1LCSaM
         EDSe5Db/5YHxOsCRBZEUwhrdBLGE8a4a0v9cWGDg=
Received: by mail-vk1-f169.google.com with SMTP id d7so3464326vkf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 09:18:49 -0700 (PDT)
X-Gm-Message-State: APjAAAVhFxIx8RscIeZsLuO/9mXfgCGnYUuzZ8V9sK3db8rLtBDQpFVm
        /WabHtaZZ1jgyHykrcPf9nTinJl9d/Rgm0xh5BI=
X-Google-Smtp-Source: APXvYqwI/5Bh3rt2l+/qy4GhQai3mYWLA945f34NtHLwGE89fsTxBd72humD04AiNihLSFkZ5t0VXKIfc/x+ITR36T4=
X-Received: by 2002:a1f:206:: with SMTP id 6mr7975040vkc.81.1557764328439;
 Mon, 13 May 2019 09:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190415083018.2224-1-fdmanana@kernel.org> <20190422154342.11873-1-fdmanana@kernel.org>
 <20190513155607.GD3138@twin.jikos.cz> <20190513160704.GE3138@twin.jikos.cz>
In-Reply-To: <20190513160704.GE3138@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 13 May 2019 17:18:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7SQEr-jm9tvM8LM_tt6xqSNUU6DLnx3Mmg7n86_y6z1A@mail.gmail.com>
Message-ID: <CAL3q7H7SQEr-jm9tvM8LM_tt6xqSNUU6DLnx3Mmg7n86_y6z1A@mail.gmail.com>
Subject: Re: [PATCH v2] Btrfs: fix race between send and deduplication that
 lead to failures and crashes
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 5:06 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, May 13, 2019 at 05:56:07PM +0200, David Sterba wrote:
> > On Mon, Apr 22, 2019 at 04:43:42PM +0100, fdmanana@kernel.org wrote:
> > > +           btrfs_warn_rl(root_dst->fs_info,
> > > +"Can not deduplicate to root %llu while send operations are using it (%d in progress)",
> > > +                         root_dst->root_key.objectid,
> > > +                         root_dst->send_in_progress);
> >
> > The test btrfs/187 stresses this code and the logs are flooded by the
> > messages, even ratelimited.
> >
> > I wonder if the test is rather artificail (and that's fine for the testing
> > purposes) or if the number of messages would repeat under normal conditions.
> >
> > We don't need to print the message each time the dedup tries to acces a
> > snapshot under send, so keeping track if the message has been sent already
> > would be less intrusive and still provide the information.
>
> Untested:
>
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1205,6 +1205,8 @@ enum {
>         BTRFS_ROOT_DEAD_RELOC_TREE,
>         /* Mark dead root stored on device whose cleanup needs to be resumed */
>         BTRFS_ROOT_DEAD_TREE,
> +       /* Track if dedupe was attempted under a current send */
> +       BTRFS_ROOT_NOTIFIED_DEDUPE_DURING_SEND,
>  };
>
>  /*
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6dafa857bbb9..23677cf12afc 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3263,7 +3263,9 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
>
>         spin_lock(&root_dst->root_item_lock);
>         if (root_dst->send_in_progress) {
> -               btrfs_warn_rl(root_dst->fs_info,
> +               if (!test_and_set_bit(BTRFS_ROOT_NOTIFIED_DEDUPE_DURING_SEND,
> +                                       &root_dst->state))
> +                       btrfs_warn(root_dst->fs_info,
>  "cannot deduplicate to root %llu while send operations are using it (%d in progress)",
>                               root_dst->root_key.objectid,
>                               root_dst->send_in_progress);
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index dd38dfe174df..cc85ae903368 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6637,6 +6637,8 @@ static void btrfs_root_dec_send_in_progress(struct btrfs_root* root)
>                 btrfs_err(root->fs_info,
>                           "send_in_progress unbalanced %d root %llu",
>                           root->send_in_progress, root->root_key.objectid);
> +       if (root->send_in_progress == 0)
> +               clear_bit(BTRFS_ROOT_NOTIFIED_DEDUPE_DURING_SEND, &root->state);
>         spin_unlock(&root->root_item_lock);

I would leave it as it is unless users start to complain. Yes, the
test does this on purpose.
Adding such code/state seems weird to me, instead I would change the
rate limit state so that the messages would repeat much less
frequently.

>  }
>
