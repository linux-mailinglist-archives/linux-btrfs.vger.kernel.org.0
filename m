Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5444D6EF396
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjDZLpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 07:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbjDZLpW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 07:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81D35261
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 04:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 778DA615D3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 11:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF57C433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682509518;
        bh=LiABAmLsbkqNhze+igR2w3cwfLkjsB8ZYtU8C3jDr/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bcKfEmRMEpMxPZl64a8EHDFA5Xfb46i//DgcoirsfHSR6p2bPgyzyA25hjIquLrT0
         7ql2ZBmqiSxeKMo/AAN9mJfKTKsNiAr45z12LOJAFrp+Hpz4DPmr5qXnbgCOU4JmSV
         qiaahKN/s9f24tVJnFJQDNBneQcrP8OYgElZHC/Kgv51tWCzS3LGzzdcG00/4oy640
         4ULFPiOBZj8Tt8yoaDKWRl5xw0RcwwciS0a8tMyaDZvnYJSAEvS4MUKcPzU4+AFN5z
         xoDMDNYuz+pxYIg9rglYH3X7a4UwcYbVAK+9zHJ/6r4KJ8AyylT/hLRrhswbliWSa7
         /RHzLQ+PAd4MQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-38ede2e0e69so1883727b6e.2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 04:45:18 -0700 (PDT)
X-Gm-Message-State: AAQBX9fVvHEswAO220w3XdCPWJyp/EOi6fAecN0Q/X3CUFyrpzHpAxRY
        +FWCjUdxoDSnFAWJ+89O3iqubaMoGQMbwT5Mnw8=
X-Google-Smtp-Source: AKy350YEWcUJt/zEHV2YLAdXkVv6Gg/3vOum46PnvyqTO7xjHvDqWSp4yyFNtsdb7D/3ILYys1FNO6HNem2uxxZNVEs=
X-Received: by 2002:a05:6808:14c7:b0:38e:7fe:2cad with SMTP id
 f7-20020a05680814c700b0038e07fe2cadmr11015183oiw.30.1682509518048; Wed, 26
 Apr 2023 04:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682505780.git.fdmanana@suse.com> <14f4089a9d26606c7a15e398536ca75f9c484c9c.1682505780.git.fdmanana@suse.com>
 <84ed9592-ac1e-8344-c0f6-4e114b2835ec@gmx.com> <CAL3q7H7B3Cyn9RXzT24u+x2hjgmWjNCrMBJ-WHjGP5Cs-kUFjQ@mail.gmail.com>
 <6377fb9d-fec9-6c2a-1f38-6ffd775eb773@suse.com>
In-Reply-To: <6377fb9d-fec9-6c2a-1f38-6ffd775eb773@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 26 Apr 2023 12:44:41 +0100
X-Gmail-Original-Message-ID: <CAL3q7H64Gk9hXNgtgH2CAha=EpS9oFirgoyFjVCsqusa6hCJzQ@mail.gmail.com>
Message-ID: <CAL3q7H64Gk9hXNgtgH2CAha=EpS9oFirgoyFjVCsqusa6hCJzQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: print extent buffers when sibling keys check fails
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
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

On Wed, Apr 26, 2023 at 12:40=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2023/4/26 19:31, Filipe Manana wrote:
> > On Wed, Apr 26, 2023 at 12:21=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
> >>
> >>
> >>
> >> On 2023/4/26 18:51, fdmanana@kernel.org wrote:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> When trying to move keys from one node/leaf to another sibling node/l=
eaf,
> >>> if the sibling keys check fails we just print an error message with t=
he
> >>> last key of the left sibling and the first key of the right sibling.
> >>> However it's also useful to print all the keys of each sibling, as it
> >>> may provide some clues to what went wrong, which code path may be
> >>> inserting keys in an incorrect order. So just do that, print the sibl=
ings
> >>> with btrfs_print_tree(), as it works for both leaves and nodes.
> >>>
> >>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>
> >> However my concern is, printing two tree blocks may be a little too la=
rge.
> >> Definitely not something can be capture by one screen.
> >
> > What?
> > If I check syslog/dmesg, I can certainly access hundreds, thousands of =
lines...
> >
> > I suppose by "capture by one screen" you mean a screenshot?
>
> Yep, mostly a phone shot of a physical monitor, which a lot of end users
> choose to use to report their initial trans abort.
>
> E.g.
> https://lore.kernel.org/linux-btrfs/f057bdd1-bdd9-459f-b25f-6a2faa652499@=
betaapp.fastmail.com/
>
> I guess the reason is, if the trans abort happens on the root fs, there
> will be no persistent log files anyway.
> (Although it's still possible to pass the dmesg to another machine or go
> netconsole, but not everyone has such setup ready).

So what?
I don't see how that invalidates printing extent buffers... Many users
are able to access dmesg/syslog
and paste what they get there... It's also useful for development
where we can certainly access everything...


>
> Thanks,
> Qu
> >
> >>
> >> Although dumping single tree block is already too large for a single
> >> screen, I don't have any better way...
> >>
> >> Thanks,
> >> Qu
> >>> ---
> >>>    fs/btrfs/ctree.c | 4 ++++
> >>>    1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> >>> index a0b97a6d075a..a061d7092369 100644
> >>> --- a/fs/btrfs/ctree.c
> >>> +++ b/fs/btrfs/ctree.c
> >>> @@ -2708,6 +2708,10 @@ static bool check_sibling_keys(struct extent_b=
uffer *left,
> >>>        }
> >>>
> >>>        if (btrfs_comp_cpu_keys(&left_last, &right_first) >=3D 0) {
> >>> +             btrfs_crit(left->fs_info, "left extent buffer:");
> >>> +             btrfs_print_tree(left, false);
> >>> +             btrfs_crit(left->fs_info, "right extent buffer:");
> >>> +             btrfs_print_tree(right, false);
> >>>                btrfs_crit(left->fs_info,
> >>>    "bad key order, sibling blocks, left last (%llu %u %llu) right fir=
st (%llu %u %llu)",
> >>>                           left_last.objectid, left_last.type,
