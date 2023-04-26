Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A836EF3E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbjDZMBC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 08:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbjDZMBB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 08:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C058C4C3C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 05:00:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FBDC63119
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 12:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3F7C433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682510458;
        bh=aRSJX38kD8mUlI74KN31C8TQdXhbRZhy+37NzCjWDzU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bgjGyVlB9qT1MXvl/imVdr/CgibHUjO7Ie61tqw/jqaL/n54U6WkXrJGejYR6QYTu
         8S37RcYwDqAVe9f1WLhJ+xMl+Tlx+Hhbxq21lkUxqatlMBSXTld3YGqxDNSeM4i/YE
         i2UKb2ucCSycMMHG1fWZlluwlJ1hExZQWF7+RhiUvBfiz9ZrXfRp4bt/lXB2ItmNRi
         vhBB5uEoFUiD6208L4MOCCpc/shtn3LDFYlzmMEdQql72xJ+hWFLbbeEe5mqMlSb/C
         iKl49uutGHklR3N8p6WYMq9VuRD9q7E3hUoyp0WPaOwMc55tn+LwjYh8XLizScXHfN
         ud2Zzoj6B6YAw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-38bef0af6e9so3837060b6e.1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 05:00:58 -0700 (PDT)
X-Gm-Message-State: AAQBX9fs+JvhCxrLXhJZOrQZzPxietQPD7BFLcyZBXbuYfYLxjI6qKkd
        llfqYdtOKxB8WY1Y8nznm6xssd6ADFfm7k/DwAk=
X-Google-Smtp-Source: AKy350ZXcLdRmijzdfBX3sWP0LNyqob0PqTI9gHlxodTo576olPBeg1y/+sx5x6FAKes8NhVN+ee5khSq7pRCHUYFUM=
X-Received: by 2002:aca:be55:0:b0:38e:3eb6:91d3 with SMTP id
 o82-20020acabe55000000b0038e3eb691d3mr8703422oif.21.1682510457723; Wed, 26
 Apr 2023 05:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682505780.git.fdmanana@suse.com> <14f4089a9d26606c7a15e398536ca75f9c484c9c.1682505780.git.fdmanana@suse.com>
 <84ed9592-ac1e-8344-c0f6-4e114b2835ec@gmx.com> <CAL3q7H7B3Cyn9RXzT24u+x2hjgmWjNCrMBJ-WHjGP5Cs-kUFjQ@mail.gmail.com>
 <6377fb9d-fec9-6c2a-1f38-6ffd775eb773@suse.com> <CAL3q7H64Gk9hXNgtgH2CAha=EpS9oFirgoyFjVCsqusa6hCJzQ@mail.gmail.com>
 <2936900a-a62e-8d27-1098-9505cc95a890@gmx.com>
In-Reply-To: <2936900a-a62e-8d27-1098-9505cc95a890@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 26 Apr 2023 13:00:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6S1bOH2d1G+YPHEQUgiibf8fP3ST7iOcV0kc3j5QUtaA@mail.gmail.com>
Message-ID: <CAL3q7H6S1bOH2d1G+YPHEQUgiibf8fP3ST7iOcV0kc3j5QUtaA@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: print extent buffers when sibling keys check fails
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
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

On Wed, Apr 26, 2023 at 12:50=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> On 2023/4/26 19:44, Filipe Manana wrote:
> > On Wed, Apr 26, 2023 at 12:40=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote=
:
> >>
> >>
> >>
> >> On 2023/4/26 19:31, Filipe Manana wrote:
> >>> On Wed, Apr 26, 2023 at 12:21=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gm=
x.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2023/4/26 18:51, fdmanana@kernel.org wrote:
> >>>>> From: Filipe Manana <fdmanana@suse.com>
> >>>>>
> >>>>> When trying to move keys from one node/leaf to another sibling node=
/leaf,
> >>>>> if the sibling keys check fails we just print an error message with=
 the
> >>>>> last key of the left sibling and the first key of the right sibling=
.
> >>>>> However it's also useful to print all the keys of each sibling, as =
it
> >>>>> may provide some clues to what went wrong, which code path may be
> >>>>> inserting keys in an incorrect order. So just do that, print the si=
blings
> >>>>> with btrfs_print_tree(), as it works for both leaves and nodes.
> >>>>>
> >>>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>>>
> >>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>>>
> >>>> However my concern is, printing two tree blocks may be a little too =
large.
> >>>> Definitely not something can be capture by one screen.
> >>>
> >>> What?
> >>> If I check syslog/dmesg, I can certainly access hundreds, thousands o=
f lines...
> >>>
> >>> I suppose by "capture by one screen" you mean a screenshot?
> >>
> >> Yep, mostly a phone shot of a physical monitor, which a lot of end use=
rs
> >> choose to use to report their initial trans abort.
> >>
> >> E.g.
> >> https://lore.kernel.org/linux-btrfs/f057bdd1-bdd9-459f-b25f-6a2faa6524=
99@betaapp.fastmail.com/
> >>
> >> I guess the reason is, if the trans abort happens on the root fs, ther=
e
> >> will be no persistent log files anyway.
> >> (Although it's still possible to pass the dmesg to another machine or =
go
> >> netconsole, but not everyone has such setup ready).
> >
> > So what?
> > I don't see how that invalidates printing extent buffers... Many users
> > are able to access dmesg/syslog
> > and paste what they get there... It's also useful for development
> > where we can certainly access everything...
>
> That's why I gave the reviewed-by tag.
>
> Maybe we can shrink the output to the first several and last several
> items in the future.

That's not really useful for most cases, and I've certainly run into key
ordering bugs in the past where having an entire leaf printed made the
problem easier to debug,
sometimes it made it immediately obvious where the bug happened and why.

We are avoiding printing useful stuff just because we assume people will ta=
ke
a photo from their phone... For those with access to dmesg/syslog, we
lose useful
information.

>
> But for now since it's just a trans abort, it should be mostly fine for
> the end uesrs to access the full dump.
>
> Thanks,
> Qu
> >
> >
> >>
> >> Thanks,
> >> Qu
> >>>
> >>>>
> >>>> Although dumping single tree block is already too large for a single
> >>>> screen, I don't have any better way...
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>> ---
> >>>>>     fs/btrfs/ctree.c | 4 ++++
> >>>>>     1 file changed, 4 insertions(+)
> >>>>>
> >>>>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> >>>>> index a0b97a6d075a..a061d7092369 100644
> >>>>> --- a/fs/btrfs/ctree.c
> >>>>> +++ b/fs/btrfs/ctree.c
> >>>>> @@ -2708,6 +2708,10 @@ static bool check_sibling_keys(struct extent=
_buffer *left,
> >>>>>         }
> >>>>>
> >>>>>         if (btrfs_comp_cpu_keys(&left_last, &right_first) >=3D 0) {
> >>>>> +             btrfs_crit(left->fs_info, "left extent buffer:");
> >>>>> +             btrfs_print_tree(left, false);
> >>>>> +             btrfs_crit(left->fs_info, "right extent buffer:");
> >>>>> +             btrfs_print_tree(right, false);
> >>>>>                 btrfs_crit(left->fs_info,
> >>>>>     "bad key order, sibling blocks, left last (%llu %u %llu) right =
first (%llu %u %llu)",
> >>>>>                            left_last.objectid, left_last.type,
