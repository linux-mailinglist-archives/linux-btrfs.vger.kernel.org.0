Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB877F160
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 09:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348499AbjHQHku (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 03:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348568AbjHQHkW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 03:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278502D66
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 00:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FC1B61DE7
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 07:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00403C113CA
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 07:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692258020;
        bh=hN+/o8RT8dikTYGTgp0tgvIvpnPKpxJfpptQgOPrcbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OEAm9F435ZJoqGUy9tIGkm24EMGRPVL4PZ/0vdNVEehVY/S7do52I+aGoF3NPpqdA
         QQDieMJLWOhv3enyFPA8+ncFfe58NtsblyOF8TriWMPNHNt+PTl5zrEKe08WU8ioW7
         CjhTGUjJPOgEaRl6HKi7u7dXvapkUc3qG+SYFZuUVjB1nxZ+mVwkfCKOrpGMSEs9iV
         CCDTgEPWMdcryybuPYpKpXykRACgvL6n4DGen3GtgAnUWp/BGthQP/9eh3i7LTQhWX
         zTNhoDfFuh3PHC4vPP6jd+UjdZcMz7jpthPmJxdsqFrnpzpRt5GjbiyhEsTCqVy9g5
         3h/qngRRZsusA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1bfca0ec8b9so5335851fac.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 00:40:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YzadhEPIpNKgfdrolU2etjuMGqivvlqSLctZ+EA09ZdRGtpqp0t
        7AVTC3H274vt+1SdFoqi/C9p9uksWigFexxbSyE=
X-Google-Smtp-Source: AGHT+IEX7ovKvl9j3g/MtTc02CChx1mJuvAxUIX+izgcrqx2QpE/1XB/p/IkfCwnJ4L2rylvEwFG8F1QCCrM4ZK9HXE=
X-Received: by 2002:a05:6870:3516:b0:1bb:5480:4b4 with SMTP id
 k22-20020a056870351600b001bb548004b4mr5179097oah.8.1692258019070; Thu, 17 Aug
 2023 00:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <77ec19769e75c704cb260b98b41e33340a51c40c.1692181669.git.wqu@suse.com>
 <ZNzE6CFOzu9kDG+G@debian0.Home> <d34414eb-8ad1-4e9c-bb4d-6167ace2e480@gmx.com>
In-Reply-To: <d34414eb-8ad1-4e9c-bb4d-6167ace2e480@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 17 Aug 2023 08:39:42 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5g1E8ZWqtAA6Ltb+_aWAqOm6iR57ojnGCyskZZrFDMuQ@mail.gmail.com>
Message-ID: <CAL3q7H5g1E8ZWqtAA6Ltb+_aWAqOm6iR57ojnGCyskZZrFDMuQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: retry flushing for del_balance_item() if the
 transaction is interrupted
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 16, 2023 at 10:54=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> On 2023/8/16 20:45, Filipe Manana wrote:
> > On Wed, Aug 16, 2023 at 06:28:16PM +0800, Qu Wenruo wrote:
> >> [BUG]
> >>
> >> There is an internal bug report that there are only 3 lines of btrfs
> >> errors, then btrfs falls read-only:
> >>
> >>   [358958.022131] BTRFS info (device dm-9): balance: canceled
> >>   [358958.022148] BTRFS: error (device dm-9) in __cancel_balance:4014:=
 errno=3D-4 unknown
> >>   [358958.022150] BTRFS info (device dm-9): forced readonly
> >>
> >> [CAUSE]
> >> The error number -4 is -EINTR, and according to the code line (althoug=
h
> >> backported kernel, the code is still relevant upstream), it's the
> >> btrfs_handle_fs_error() call inside reset_balance_state().
> >>
> >> This can happen when we try to start a transaction which requires
> >> metadata flushing.
> >>
> >> This metadata flushing can be interrupted by signal, thus it can retur=
n
> >> -EINTR.
> >>
> >> For our case, the -EINTR is deadly because we don't handle the error a=
t
> >> all, and immediately mark the fs read-only in the following call chain=
:
> >>
> >> reset_balance_state()
> >> |- del_balance_item()
> >> |  `- btrfs_start_transation_fallback_global_rsv()
> >> |     `- start_transaction()
> >> |     `- btrfs_block_rsv_add()
> >> |        `- __reserve_bytes()
> >> |           `- handle_reserve_ticket()
> >> |              `- wait_reserve_ticket()
> >> |                 `- prepare_to_wait_event()
> >> |                    This wait has TASK_KILLABLE, thus can be
> >> |                    interrupted.
> >> |                    Thus we return -EINTR.
> >> |
> >> |- IS_ERR(trans) triggered
> >> |- btrfs_handle_fs_error()
> >>     The fs is marked read-only.
> >>
> >> [FIX]
> >> For this particular call site, we can not afford just erroring out wit=
h
> >> -EINTR.
> >>
> >> This patch would fix the error by retry until either we got a valid
> >> transaction handle, or got an error other than -EINTR.
> >>
> >> Since we're here, also enhance the error message a little to make it
> >> more readable.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/volumes.c | 12 ++++++++++--
> >>   1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index 189da583bb67..e83711fe31bb 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -3507,7 +3507,15 @@ static int del_balance_item(struct btrfs_fs_inf=
o *fs_info)
> >>      if (!path)
> >>              return -ENOMEM;
> >>
> >> -    trans =3D btrfs_start_transaction_fallback_global_rsv(root, 0);
> >> +    do {
> >> +            /*
> >> +             * The transaction starting here can be interrupted, but =
if we
> >> +             * just error out we would mark the fs read-only.
> >> +             * Thus here we try to start the transaction again if it'=
s
> >> +             * interrupted.
> >> +             */
> >> +            trans =3D btrfs_start_transaction_fallback_global_rsv(roo=
t, 0);
> >> +    } while (IS_ERR(trans) && PTR_ERR(trans) =3D=3D -EINTR);
> >
> > This condition can be simply:  trans =3D=3D ERR_PTR(-EINTR)
> >
> > My only concern is if this can turn into an infinite loop due to a high=
 enough rate of
> > signals being sent to the process...
>
> Yep, that's indeed a concern.
>
> The other solution is to introduce a flag to disallow signal for the
> ticket system (aka non-killable wait), which can get rid of the frequent
> signal problems.
>
> In fact, we may not want certain reclaim to be interrupted at all,
> especially for BTRFS_RESERVE_FLUSH_ALL_STEAL, which are only utilized
> for very critical operations like unlink and other deletion operations.

We shouldn't need to call
btrfs_start_transaction_fallback_global_rsv() because we don't need to
reserve space.
A join transaction would be enough, because:

1) We pass 0 items to the start transaction call;

2) More importantly, we are updating the root tree and the root tree
uses the global block reserve, see btrfs_init_root_block_rsv().

So the start transaction call should not be reserving any space
because "num_items =3D=3D 0" and "flush !=3D BTRFS_RESERVE_FLUSH_ALL".
Are you sure the -EINTR is coming from the
btrfs_start_transaction_fallback_global_rsv() and not from the
btrfs_search_slot() call at del_balance_item() for example?

Nothing in the partial log you pasted can tell the -EINTR comes from
btrfs_start_transaction_fallback_global_rsv(), which would be very
surprising
because it's not reserving any space for those reasons mentioned above.

>
> >
> > Instead of this I would make reset_balance_state() just print a warning=
, and not
> > call btrfs_handle_fs_error()  and then change insert_balance_item() to =
not fail in
> > case the item already exists - instead just overwrite it.
>
> This means, if a unlucky interruption happened, the left balance item
> can cause us to resume a balance on the next mount, which can be
> unexpected for the end user.

Yes, but maybe not much work is done unless after that some block
groups got fragmented enough to trigger the stored balance filters in
the item.
The worst case is without filters, where all block groups are always reloca=
ted.
Not ideal, yes.

But having had a closer look, my concern is that I don't see how
btrfs_start_transaction_fallback_global_rsv() can return -EINTR, and I
suspect
it comes from somewhere else.

Thanks.

>
> Thanks,
> Qu
> >
> > Thanks.
> >
> >
> >>      if (IS_ERR(trans)) {
> >>              btrfs_free_path(path);
> >>              return PTR_ERR(trans);
> >> @@ -3594,7 +3602,7 @@ static void reset_balance_state(struct btrfs_fs_=
info *fs_info)
> >>      kfree(bctl);
> >>      ret =3D del_balance_item(fs_info);
> >>      if (ret)
> >> -            btrfs_handle_fs_error(fs_info, ret, NULL);
> >> +            btrfs_handle_fs_error(fs_info, ret, "failed to delete bal=
ance item");
> >>   }
> >>
> >>   /*
> >> --
> >> 2.41.0
> >>
