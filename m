Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AF7651FFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 12:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiLTL5j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 06:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTL5h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 06:57:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0EF10FFE
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 03:57:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B12F26135D
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 11:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201F9C433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671537456;
        bh=OZopsgfSj381NhLnyw5I1Yy0V/FMr6yBHwjh4ttwQqA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kSpueUkY/Zz+ukfbB6Gua63UVFzmliJBgm4+Vjl4I1zw4Wwu2dJVmgWD6L+Ja14xf
         Z81s8spUmpIOSOqkyqVCOgl2YVy7c9VZVJfFH2fQqw7ZknRur7kJVTHBuDbJnak/2R
         OjDOEGcFJoko0iw6/kfeWOfmzHycET702RIYVic0NclLGdVAp8MTuBk8lJ6HcvIGDw
         bVOIUNnqo+b5vBHf5s6mz9EKoHRxGa8bSEWFGmPs/c55MFm5dtup0jjsYIOBmhfmbl
         4m7PZvLYVck9Z/WgeB0kh/HFkKkDucV5JJdXnz/wPNqXjueczFolZa9PjiBxKN10he
         hirK4ZntSI3+A==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-142b72a728fso15090037fac.9
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 03:57:36 -0800 (PST)
X-Gm-Message-State: AFqh2kpQh2B7G+UC9H9i3Ni7enRAokMgPVxfFJGjM8J568JVTnKWdllY
        /+vgv9i22Ek0kbjxr10yUVK0qXNLK0wpPAoB79Q=
X-Google-Smtp-Source: AMrXdXuaFqNI/4w7KHdoNZSe2sTgTpLoCIIz3gO+68eJphlnzlh85J6nPyrW0zpEDw4M6U6FZkYeAUq0ridLopFxsTE=
X-Received: by 2002:a05:6871:4496:b0:14c:667e:4620 with SMTP id
 ne22-20020a056871449600b0014c667e4620mr16729oab.92.1671537455237; Tue, 20 Dec
 2022 03:57:35 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBewVqdWU8O4jBqneexYKZGHLSDEhFCwKj+mL5+OjcWeYg@mail.gmail.com>
 <e4491c53-1869-9a85-f656-f2e35acd8b65@suse.com>
In-Reply-To: <e4491c53-1869-9a85-f656-f2e35acd8b65@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 20 Dec 2022 11:56:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5uWor=cWiVAvDtkQNa_OrDFe7eq89_RZroTD4Mn8r0wA@mail.gmail.com>
Message-ID: <CAL3q7H5uWor=cWiVAvDtkQNa_OrDFe7eq89_RZroTD4Mn8r0wA@mail.gmail.com>
Subject: Re: Doing anything with the external disk except mounting causes
 whole system lockup
To:     Qu Wenruo <wqu@suse.com>
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 20, 2022 at 11:52 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2022/12/20 01:32, Cerem Cem ASLAN wrote:
> > I've been using my scripts for mounting partitions, unmounting, btrfs
> > send|receive etc. while I'm dealing with my external/backup hard
> > disks.
> >
> > Recently I had trouble so I reformatted my external spinning disk and
> > transferred all snapshots to it (~800GB).
> >
> > At the end of transfer, there was an error (I might have modified the
> > bash script that is currently running) so after finishing the `btrbk
> > ...` command, my script gave an error (that's normal), so I restarted
> > it. From this moment on, I could mount my partitions but I never did a
> > btrfs send|receive or scrub or unmount again because the system was
> > simply getting locked up.
> >
> > I run `dmesg -w` command on another terminal but I didn't save it
> > (because the system was locked), so I took a photo of it:
> > https://imgur.com/LJfgjbY
>
> RCU stall, then it can be anything, I doubt if it's really btrfs causing
> the problem.

Nop, it's a btrfs problem.
This was caused by a bad backport to 6.0.3, which is what Cerem is
running according to the screenshot.

This has been reported before, for example at:

https://lore.kernel.org/linux-btrfs/2291416ef48d98059f9fdc5d865b0ff040148237.camel@scientia.org/
https://lore.kernel.org/linux-btrfs/1c531dd5de7477c8b6ec15d4aebb8e42ae460925.camel@scientia.org/

This was eventually fixed in 6.0.5:

https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.0.5

by commit:

commit 217fd7557896d990c3dd8beea83a6feeb504f235
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed Oct 26 12:24:13 2022 +0200

    Revert "btrfs: call __btrfs_remove_free_space_cache_locked on
cache load failure"

    This reverts commit 3ea7c50339859394dd667184b5b16eee1ebb53bc which is
    commit 8a1ae2781dee9fc21ca82db682d37bea4bd074ad upstream.

    It causes many reported btrfs issues, so revert it for now.

    Cc: Josef Bacik <josef@toxicpanda.com>
    Cc: David Sterba <dsterba@suse.com>
    Cc: Sasha Levin <sashal@kernel.org>
    Reported-by: Tobias Powalowski <tobias.powalowski@googlemail.com>
    Link: https://lore.kernel.org/r/CAHfPjO8G1Tq2iJDhPry-dPj1vQZRh4NYuRmhHByHgu7_2rQkrQ@mail.gmail.com
    Reported-by: Ernst Herzberg <earny@net4u.de>
    Link: https://lore.kernel.org/r/8196dd88-4e11-78a7-8f96-20cf3e886e68@net4u.de
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

So just upgrade the kernel in your distro, the latest 6.0 stable
release is 6.0.14, so anything between 6.0.5 and that should be fine.


>
> In fact, I hit similar problems before, very randomly, sometimes when
> playing some steam games, sometimes just random crash/lockup.
>
> At least if you can setup a netconsole, we can have better view of the
> whole situation.
>
> In my case, netconsole also sometimes points to RCU, sometimes some
> random generic protection error.
>
> I tried replacing my RAM, no help. Finally I brought a new mobo and CPU
> (switched from 5900X + B450I to 13700K + B660I) and no crash anymore.
>
> Thus if you're hitting RCU stalls, I'd strongly recommend to test the
> same fs on other systems.
>
> Thanks,
> Qu
> >
> > I haven't lost any data and I still have another backup disk, so no
> > worries. I'm just keeping the disk just in case you may require some
> > more information this week.
> >
> > * Linux erik3 6.0.0-0.deb11.2-amd64 #1 SMP PREEMPT_DYNAMIC Debian
> > 6.0.3-1~bpo11+1 (2022-10-29) x86_64 GNU/Linux
> > * btrfs-progs v5.10.1
> > * mount options I'm using: rw,noatime
