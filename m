Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820836EF373
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 13:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbjDZLcQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 07:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbjDZLcO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 07:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF764359E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 04:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A09629C8
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 11:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B51C433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682508732;
        bh=D3a6lA82p4952JJBqfFG+gwqqWzaDCqEtPfCPAQZizM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fNgCRGQP4qrUUT38968Qz3/TdmXLpKQME1znw7hwJf6X8FdqMjL4IYqcdR4y7CRYa
         0n76GQauiwIsuVBipTtNDHLj3AAvFuKdySOl9lqRbrXYy6yrI/danBV94X4a7fqliH
         Thlcat9WnU/4BFV+xcI+Gb35LFB3c5zG4MalaOCji3x167TMMrY7ckBJhbkiSBwE1y
         mgYi4O9DxprOeW7B2l+z++izOdowrBN/GF/D/z+BYCQzDdNE6tL/n+TKrXH1234pYw
         EW8FcdU2xUq5l2/c9img6U9akaH1UIQ4kWE2M3OpyAlKmCh47FL0WZAzNPT9wpLQQn
         kPjHAwpxIIJ6g==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-38e692c0918so4147653b6e.1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 04:32:12 -0700 (PDT)
X-Gm-Message-State: AAQBX9eo1Tdb0/6fWpRnYsa78+cvBovA7pRBTTSpATX6U2/cWY6L6oDs
        S5yWt7AOpiwMwWCrPSQWA6eA3pH9UdiqIdmto/c=
X-Google-Smtp-Source: AKy350YlcLN4ny1guu9hkm41utDteUL/om2p5JyVFhi8KHL84QxH32mCEbVDy8m8Z3CbzvaBX90dH3RxRHFWnCBD07E=
X-Received: by 2002:a05:6808:30a9:b0:38e:4a8e:d7e0 with SMTP id
 bl41-20020a05680830a900b0038e4a8ed7e0mr11620570oib.21.1682508731937; Wed, 26
 Apr 2023 04:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682505780.git.fdmanana@suse.com> <14f4089a9d26606c7a15e398536ca75f9c484c9c.1682505780.git.fdmanana@suse.com>
 <84ed9592-ac1e-8344-c0f6-4e114b2835ec@gmx.com>
In-Reply-To: <84ed9592-ac1e-8344-c0f6-4e114b2835ec@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 26 Apr 2023 12:31:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7B3Cyn9RXzT24u+x2hjgmWjNCrMBJ-WHjGP5Cs-kUFjQ@mail.gmail.com>
Message-ID: <CAL3q7H7B3Cyn9RXzT24u+x2hjgmWjNCrMBJ-WHjGP5Cs-kUFjQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: print extent buffers when sibling keys check fails
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 26, 2023 at 12:21=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> On 2023/4/26 18:51, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When trying to move keys from one node/leaf to another sibling node/lea=
f,
> > if the sibling keys check fails we just print an error message with the
> > last key of the left sibling and the first key of the right sibling.
> > However it's also useful to print all the keys of each sibling, as it
> > may provide some clues to what went wrong, which code path may be
> > inserting keys in an incorrect order. So just do that, print the siblin=
gs
> > with btrfs_print_tree(), as it works for both leaves and nodes.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> However my concern is, printing two tree blocks may be a little too large=
.
> Definitely not something can be capture by one screen.

What?
If I check syslog/dmesg, I can certainly access hundreds, thousands of line=
s...

I suppose by "capture by one screen" you mean a screenshot?

>
> Although dumping single tree block is already too large for a single
> screen, I don't have any better way...
>
> Thanks,
> Qu
> > ---
> >   fs/btrfs/ctree.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index a0b97a6d075a..a061d7092369 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -2708,6 +2708,10 @@ static bool check_sibling_keys(struct extent_buf=
fer *left,
> >       }
> >
> >       if (btrfs_comp_cpu_keys(&left_last, &right_first) >=3D 0) {
> > +             btrfs_crit(left->fs_info, "left extent buffer:");
> > +             btrfs_print_tree(left, false);
> > +             btrfs_crit(left->fs_info, "right extent buffer:");
> > +             btrfs_print_tree(right, false);
> >               btrfs_crit(left->fs_info,
> >   "bad key order, sibling blocks, left last (%llu %u %llu) right first =
(%llu %u %llu)",
> >                          left_last.objectid, left_last.type,
