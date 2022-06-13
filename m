Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C3554A202
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 00:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiFMWTS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 18:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiFMWTR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 18:19:17 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F276B2DAAF
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 15:19:16 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y12so7604754ior.7
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=anXaF3A+rbZgNPxwv2wtFAEo5zeUFDdVuvtBZsALhx8=;
        b=jajOqGUL3YH6XRPfNwe2HMCCyEhZpEVb6GMmpAoQMcxElrOo6fuc37AD2zodxIIbQq
         5tf34fnnA44rGmdQOt2VA2RafvFIElN01FtS2HolFQkUFKqpgTwTiHFiuoVgSIV9nlrd
         ruXMKyJ0iUzOOmZhYogzewmRncUUC5Mvv4glk1f6UcymTr2AiNLsPAZ7h2QYxkV71Id6
         QiwFY8g1HMbqcdwvLqgQhkK8dKSRKaR7YbRrLi6cn4HrF/rE7d3eT3FAAYxtxTJCqmgs
         1fhuu4WwAAhQj+2cW0Ij9tK7agPyEJhErEF9MSfZjqtBdlHDDpR3L0wQPgeU94y6r3mg
         CT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anXaF3A+rbZgNPxwv2wtFAEo5zeUFDdVuvtBZsALhx8=;
        b=hUUw2bQXrB3JWiPvWClpBq5T2zmsiRT7TifZkQSRywu3JUNA2E/QnUUDIl39C+ZDJz
         KVea6og34PfBx5EIE8CJOAyjSpfqsxnBYTt8lmU7wHcthAuyBPFJaDCMkjcxfp8V/bpR
         o/9zuo9AMhD/aAARNJdVaEmWBhXXy3sLURyfPDtABZGc335H1j9h1oN35raVlrhH5Bso
         ZquLJoS/FYS2pOmHLDEi5bponsc9BecShzOcd9JTYQlPlYps2FjrBUmEc3bxb6ZjwEap
         AjXHQoVtPYDesg9yCwgvxMgszbnfmvLCMqMywgzPPnVNisANn0kF/0PTr7J8bQS3srrf
         1koQ==
X-Gm-Message-State: AOAM532MeiBPc2QvHujA4FMYiu4p4swIdD00fwgVtZ2DeW5B17Mdw1O4
        Ge7MHbGuLtT3zx2+r3mpN9nSCpYIwtPgfAlNxxVQggV+8Uo=
X-Google-Smtp-Source: ABdhPJze8b4aahrlRln9+xhMANClPJcPHMAbhjbUXs+0KH7w7qQIHDQCf0RmB7FWfzmDkbVvnlIdSLvLED/+IZnJMKk=
X-Received: by 2002:a05:6602:1695:b0:665:8390:fcf with SMTP id
 s21-20020a056602169500b0066583900fcfmr935012iow.83.1655158756216; Mon, 13 Jun
 2022 15:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220608213845.GH22722@merlins.org> <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org> <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org> <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org> <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org> <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
 <20220613204647.GO22722@merlins.org>
In-Reply-To: <20220613204647.GO22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 13 Jun 2022 18:19:05 -0400
Message-ID: <CAEzrpqdRiG9_O=JTy2LOtp4m470hMj1Ev-bk6RE_ArdRKauLGQ@mail.gmail.com>
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

On Mon, Jun 13, 2022 at 4:46 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Jun 13, 2022 at 02:29:30PM -0400, Josef Bacik wrote:
> > Alright so we have the missing csum things, which can be fixed with
> >
> > btrfs rescue init-csum-tree <device>
>
> (gdb) run rescue init-csum-tree /dev/mapper/dshelf1
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-csum-tree /dev/mapper/dshelf1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> FS_INFO IS 0x555555652bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x555555652bc0
> processed 0 of 21907435520 possible data bytes, 0%
> Program received signal SIGSEGV, Segmentation fault.
> 0x00005555555e351a in record_csums_eb (eb=0x5555556f1890, processed=processed@entry=0x7fffffffdbe8) at ./kernel-shared/ctree.h:1762
> 1762    BTRFS_SETGET_FUNCS(inode_flags, struct btrfs_inode_item, flags, 64);
> (gdb) bt
> #0  0x00005555555e351a in record_csums_eb (eb=0x5555556f1890, processed=processed@entry=0x7fffffffdbe8) at ./kernel-shared/ctree.h:1762
> #1  0x00005555555e3906 in record_csums (root=root@entry=0x5555556f15d0, processed=processed@entry=0x7fffffffdbe8) at cmds/rescue-init-csum-tree.c:292
> #2  0x00005555555e3f0f in foreach_root (cb=0x5555555e38fa <record_csums>, fs_info=0x555555652bc0) at cmds/rescue-init-csum-tree.c:338
> #3  btrfs_init_csum_tree (path=path@entry=0x7fffffffe1ce "/dev/mapper/dshelf1") at cmds/rescue-init-csum-tree.c:408
> #4  0x00005555555d88b1 in cmd_rescue_init_csum_tree (cmd=<optimized out>, argc=<optimized out>, argv=<optimized out>) at cmds/rescue.c:102
> #5  0x000055555556c17b in cmd_execute (argv=0x7fffffffdeb8, argc=2, cmd=0x555555648ce0 <cmd_struct_rescue_init_csum_tree>) at cmds/commands.h:125
> #6  handle_command_group (cmd=<optimized out>, argc=2, argv=0x7fffffffdeb8) at btrfs.c:152
> #7  0x000055555556c275 in cmd_execute (argv=0x7fffffffdeb0, argc=3, cmd=0x555555649cc0 <cmd_struct_rescue>) at cmds/commands.h:125
> #8  main (argc=3, argv=0x7fffffffdeb0) at btrfs.c:405

Hmm that's not good, I've pushed a patch to see if what I think is
happening is actually happening.  Thanks,

Josef
