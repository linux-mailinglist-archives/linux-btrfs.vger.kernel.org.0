Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF9051F1E0
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 May 2022 23:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiEHVxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 May 2022 17:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiEHVxU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 May 2022 17:53:20 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517C5120AC
        for <linux-btrfs@vger.kernel.org>; Sun,  8 May 2022 14:49:29 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f4so13494337iov.2
        for <linux-btrfs@vger.kernel.org>; Sun, 08 May 2022 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXXPZ4HkV+0x2jlKaqCS/4Og6mpUCCY2SPpqrsR3PDA=;
        b=7mGTsrK2tYyvz9H+x2ZUjt5X3ZfDoTzEvbeqZS499ERXWd1g2u3Gdfll4dE3idxCht
         8RsOKN588AzK9sKrGtv+TiznnewtZ/ypmLC0DcuF4MSRE3aH98PyV/LjWQ0BYU29z8jo
         H3Phy9LuXI+baZAg9CM+6jo2syrbERNrKHGbwj33958hUQAc3HqiLPyVR/lfhGVUGsQ1
         ClsFuknsQXldvXXTWmM17RzAtNz0Cnq+OTtMOuySaAM9i9xhNpGWT3Hgg7oH5wjPPrmx
         GgPKCEy+jla9/stYUrVlXFTJexvJhSwRe8BWZDIAfDIRFqKccSzU2NjqsCrQibVjuTsx
         3vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXXPZ4HkV+0x2jlKaqCS/4Og6mpUCCY2SPpqrsR3PDA=;
        b=v9g7w8j27zjqzjfM7KYGH1m2UifoaDBFiGaz95P6fIE0trxnghrMcfK3gp4FeCvvre
         6vtpBfTGdJhCEuJCSfBfVZihICf0rkGVrwoUpgUQYGkmG9IBgt9e5Si1IRxpzAKSM1Tb
         sn4x+DDiLp6lPLrK4rM4q6ikNPOfjIqyYf+X6SIUMiwoS1q4G8JuV7h31ocHgiP1qj0R
         OO03sjH2TztsQmJHS0sEPG6wPK5LcSuR5LjMcfnyzfQh5Awk09JsJ3vQqUvaB2E+9+dk
         osGmTwpctkk0FPyRjIJpBJZuE2oR+4YLVHxkAlbwf8eRiS96IBnkGIOXWQBkPUmUtZuN
         ASPA==
X-Gm-Message-State: AOAM532y+ksDukzAX141GfQW5ccr1B64Z4HeihzCpPzdM61IciGb7HVZ
        Azqiy7YaZV3TsBORn4Rzhhu/P0hEqVtzDgJZFHvY+DgiOaA=
X-Google-Smtp-Source: ABdhPJyBlkmCoLFkrH22hwA2xoZpIFqsLT4c28kAzlKnb7JulgjFmjhgDcozXeSe5EcDkj5Z+tGf8vU+yW1iWKGWq8I=
X-Received: by 2002:a05:6638:3793:b0:32b:6d57:c811 with SMTP id
 w19-20020a056638379300b0032b6d57c811mr5897038jal.102.1652046568570; Sun, 08
 May 2022 14:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfx3_BxSFPOByo5NY43pWOsQbhcCqU1+JqGAQpz+dgo7A@mail.gmail.com>
 <20220506031910.GH12542@merlins.org> <CAEzrpqfHzZrMuWrMERM-m4ASsuJAsijU9tpk_e5OML8dpgMeKg@mail.gmail.com>
 <CAEzrpqdzdimQvXyhpDomvPgDXx5Dn9QCEKQMiXofTFb3WvWUJQ@mail.gmail.com>
 <20220507153921.GG1020265@merlins.org> <CAEzrpqcRT6CqJJPYqW5AH+x0XvUCMd-EMEq-=SwtTL-Fn4pcvQ@mail.gmail.com>
 <20220507193628.GO12542@merlins.org> <20220508194557.GP12542@merlins.org>
 <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
 <20220508205224.GQ12542@merlins.org> <20220508212050.GR12542@merlins.org>
In-Reply-To: <20220508212050.GR12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 8 May 2022 17:49:17 -0400
Message-ID: <CAEzrpqdMFJ2cm0URWqwFehkQQzmrgYO+CdoibSUqqfN1hkGOvQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 8, 2022 at 5:20 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 08, 2022 at 01:52:24PM -0700, Marc MERLIN wrote:
> > On Sun, May 08, 2022 at 03:55:01PM -0400, Josef Bacik wrote:
> > > > searching 165298 for bad extents
> > > > processed 108756992 of 108756992 possible bytes, 100%
> > > > searching 165299 for bad extents
> > > > processed 75792384 of 75792384 possible bytes, 100%
> > > > searching 18446744073709551607 for bad extents
> > > > processed 16384 of 16384 possible bytes, 100%
> > > > Recording extents for root 3
> > > > Floating point exception
> > >
> > > Oops that's probably a divide by 0 for my fancy pct thing, I fixed it
> > > up and pushed.  Thanks,
> > >
> > Mmmh, got worse? Failed on the first file to delete
> > processed 491520 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
> > inode ref info failed???
> > misc/add0/new/file
> > Failed to find [10467695652864, 168, 8675328]
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd540, comp=comp@entry=0x55555559afa1 <cache_tree_comp_range>,
> >     next_ret=next_ret@entry=0x7fffffffd558) at common/rbtree-utils.c:48
> > 48              struct rb_node *n = root->rb_node;
> > (gdb) bt
> > #0  rb_search (root=root@entry=0x100000060, key=key@entry=0x7fffffffd540, comp=comp@entry=0x55555559afa1 <cache_tree_comp_range>,
> >     next_ret=next_ret@entry=0x7fffffffd558) at common/rbtree-utils.c:48
> > #1  0x000055555559b1a5 in search_cache_extent (tree=tree@entry=0x100000060, start=start@entry=15645169139712)
> >     at common/extent-cache.c:179
> > #2  0x0000555555584d33 in set_extent_bits (tree=0x100000060, start=15645169139712, end=15645169139711, bits=bits@entry=1)
> >     at kernel-shared/extent_io.c:380
>
> I tried the old code, and here is the output
>
> processed 108756992 of 108756992 possible bytes, 100%
> searching 165299 for bad extents
> processed 75792384 of 75792384 possible bytes, 100%
> searching 18446744073709551607 for bad extents
> processed 16384 of 16384 possible bytes, 100%
> Recording extents for root 3
>
> Program received signal SIGFPE, Arithmetic exception.
> 0x00005555555e08ad in process_eb (trans=trans@entry=0x55555930f1a0, root=root@entry=0x55555564e030, eb=eb@entry=0x555555654c10,
>     current=current@entry=0x7fffffffdae8) at /usr/include/x86_64-linux-gnu/bits/stdio2.h:112
> 112       return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
> (gdb) bt
> #0  0x00005555555e08ad in process_eb (trans=trans@entry=0x55555930f1a0, root=root@entry=0x55555564e030, eb=eb@entry=0x555555654c10,
>     current=current@entry=0x7fffffffdae8) at /usr/include/x86_64-linux-gnu/bits/stdio2.h:112
> #1  0x00005555555e0745 in process_eb (trans=trans@entry=0x55555930f1a0, root=root@entry=0x55555564e030, eb=0x555555650b90,
>     current=current@entry=0x7fffffffdae8) at cmds/rescue-init-extent-tree.c:941
> #2  0x00005555555e09ea in record_root (root=0x55555564e030) at cmds/rescue-init-extent-tree.c:1014
> #3  0x00005555555e0d11 in btrfs_init_extent_tree (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1")
>     at cmds/rescue-init-extent-tree.c:1086
> #4  0x00005555555d7b65 in cmd_rescue_init_extent_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>)
>     at cmds/rescue.c:65
> #5  0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555643d40 <cmd_struct_rescue_init_extent_tree>)
>     at cmds/commands.h:125
> #6  handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
> #7  0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555644cc0 <cmd_struct_rescue>) at cmds/commands.h:125
> #8  main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405
>

Yeah this is the divide by 0, the error you posted earlier is likely
because of the code refactor I did to make the delete thing work.
I've added some more debugging to see if we're not deleting this
problem bytenr during the search for bad extents.  Thanks,

Josef
