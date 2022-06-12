Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3E547BEF
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jun 2022 22:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiFLUFg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jun 2022 16:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiFLUFf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jun 2022 16:05:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F25E098
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 13:05:34 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y12so4218077ior.7
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWaBuiuZMLlp3pRxR6qGXdMwK7BVdAoAu4qo6NS/waU=;
        b=KzkU3yXscE6Z3Z+KtTFKfHMQ2kvh0hhvO6Av1tQ8BPtweB9DmGR3DT15/K2fwwp95n
         Ui3BycRE6zojQr9TzffJYofgJTH0k2SH8WB3B9O7LRq7qY6tWqCHLm3aWMmjjaAJXqkw
         Vo2QK7ib7Grb5GU12x6EdgFSA/9vNJmRvBWkW42yJOBSceCObiInLb2/33MkgncFrDG9
         WkZrmG9p2c1K1+GHyKhJuzLRw7tUbphJ00TZGGNAfrLRxnoqwD/6Cm/FDiG9BpZGN5SP
         GPy8gTOEi2hNZFBBrp162raWHH4PqzuzJ5EJPhtkvip2IGSCr6Xe7i5cYt75pbiE+JKr
         YBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWaBuiuZMLlp3pRxR6qGXdMwK7BVdAoAu4qo6NS/waU=;
        b=0fM5jkXeJal/JAlT4hKNF4AawKkyGD9Waeu+U38tGzEM6SPOHUCFDpF7qgH45vI+G7
         acagyWOw0WdZvsZaduVbXzXfY/UpQqqC2lDtBD7cGx+VbDyQae9jjyaS/t2d1K2P+3Wt
         Rx4CTrNQfTwhHhwlxiWycvKuM1UkRE/ekeDYZG1sdmGIXyWtTli5bKD4mGmQONq0xhmE
         1f6bT+9VQpUc/BJ3Mf3clWkBBGhf/y9pZaFN+Hvx0NVjTA4VOzHtBu64M0ninjSujnQR
         rcrsOqvWlyOQokpYMGv7WX0PXZKQ9sFeLNupDzWIYgx47nusuUYuNzW7e18QC6KAuSWx
         1wmw==
X-Gm-Message-State: AOAM533NFlAgRvCtMAr7fcFxmtEyZHGh/7/cMo1rUUAXsod5WPW9Tsgk
        llurUoKMDH/YZFXabewcShaXoD3lPX6ba8DV3haT4qwQzXI=
X-Google-Smtp-Source: ABdhPJzZ3hzeN0v17cCmrrGz4O2trP7kqI3JYGRzGfkJNzDk0mpZetwINQWnjDv8QSgdvFtU/6EYThrEoy1Mo5hG/E0=
X-Received: by 2002:a05:6602:1695:b0:665:8390:fcf with SMTP id
 s21-20020a056602169500b0066583900fcfmr26262830iow.83.1655064333627; Sun, 12
 Jun 2022 13:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220608213845.GH22722@merlins.org> <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org> <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org> <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org> <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220611001404.GM22722@merlins.org> <CAEzrpqda3=rDV8eLPsSDHbvmbyTnceecNkQUNA6mfOMmik=xDw@mail.gmail.com>
 <20220612170605.GI1664812@merlins.org>
In-Reply-To: <20220612170605.GI1664812@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 12 Jun 2022 16:05:22 -0400
Message-ID: <CAEzrpqf=i064fiZpnbnTL+R7TS5cGa0QO1HXs-9KbRji1buu+A@mail.gmail.com>
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

On Sun, Jun 12, 2022 at 1:06 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sat, Jun 11, 2022 at 10:59:15AM -0400, Josef Bacik wrote:
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> > > FS_INFO IS 0x559bd17b9bc0
> > > Couldn't find the last root for 8
> > > FS_INFO AFTER IS 0x559bd17b9bc0
> > > Walking all our trees and pinning down the currently accessible blocks
> > > Found missing chunk in super block 20971520-29360128 type 34
> > > adding bg for 20971520 8388608
> > > kernel-shared/extent-tree.c:2829: btrfs_add_block_group: BUG_ON `ret` triggered, value -17
> > > ./btrfs(+0x29f27)[0x559bd01a8f27]
> > > ./btrfs(btrfs_add_block_group+0x1e0)[0x559bd01ad700]
> > > ./btrfs(btrfs_find_recover_chunks+0x4fe)[0x559bd020fc44]
> > > ./btrfs(+0x848ce)[0x559bd02038ce]
> > > ./btrfs(handle_command_group+0x49)[0x559bd019717b]
> > > ./btrfs(main+0x94)[0x559bd0197275]
> > > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7fe20f24a7fd]
> > > ./btrfs(_start+0x2a)[0x559bd0196e1a]
> > > Aborted
> >
> > Oops, sorry about that, fixed it up.  My wife is travelling this week
> > so I'm going to be a little slower than normal, but hopefully we're
> > getting close to the end here.  Thanks,
>
> No worries. Same?
>

Yeah I missed we were BUG_ON(ret), so my change does the right thing
if we get a failure, but I needed to update the core code to return
the error.  Should work this time, thanks,

Josef
