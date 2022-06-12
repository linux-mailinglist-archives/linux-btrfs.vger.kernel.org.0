Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F706547CC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 00:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbiFLWdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jun 2022 18:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiFLWdA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jun 2022 18:33:00 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF213F84
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 15:32:56 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h18so3128574ilj.7
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UkADnyZPRKo7ydWk9XibGh6ZfJkB+175QBrMFyPHfIQ=;
        b=jW/3XBwkcuS3MDQrRii/LCmqSGBO3Efb31+X9+m095rt7CLdnxaqpdAABwp1sPnark
         Kal9dCvhqEhrboXgx5Ej6ounQRVUIIiXk0kMPzibVnuAp3etjIYdeos37chV8BlaIKRI
         j9OQ233ywgN+ZdlIpH4oo5PqQlnhd6Ae0qAxwHLkejGtKfp19OOwuTClqQ/j/MBc485j
         PL43w1GobJWa0EddGMCM7ibXEZqIn3OcNOPz0OORWMWDRIclSS0np87rtexjE+Jgcn6T
         69yotizUVFFzj8V7tyJwVrN2lNFvVqmC37Raa84AqSjmULFf/2Jb41O4w8jB85z7c7fF
         tWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkADnyZPRKo7ydWk9XibGh6ZfJkB+175QBrMFyPHfIQ=;
        b=C7G+hOoeISAJNOktnjhrq8jP9DOdXxow61/qSl7E4s40nfYnGbewiTXqH9d9UdT0Xk
         TLVTkExh3/0uOUBNOsKEwlRyfT3yf9X6LzO58kQeSVpUbv58x3npQ7wL4YNZNgt77qqa
         QMe1Hm1dTjV+sryBjojykW7QoQmtYgorbMU2V2BPhlUAkXraiYAnBDOdQEbznJVh+RaV
         h5mNfxMDyo6tutrQuWKLP2ogzifeD4I1PY+vr3tgdiAs6nt881B7wnN4rb1VsL9TyByX
         XTCPtjBGJ9Aa+zo8N2nTuOaSMdjSIQKxwVaJ1rG4EIk2V47lbOESdmjh5emjWw+JWYRr
         NwLA==
X-Gm-Message-State: AOAM530Lozzt69RiZbHsUWhgvM0B96nhZtay+T6JLMRpDRY6nesqIADG
        /5urtmKzHHtNMe10k4vgt5W1meGGtwdwd6enNk0dtFsIDq0=
X-Google-Smtp-Source: ABdhPJw83RX55lbrVlwKYVlBos9bkviDPfI1d8zqS/o57On4VeU75n8M8mnx7BoC+u5kP8T+XC5nTRIPB2sKJKAgeFY=
X-Received: by 2002:a05:6e02:156e:b0:2d1:c265:964f with SMTP id
 k14-20020a056e02156e00b002d1c265964fmr33002952ilu.153.1655073176056; Sun, 12
 Jun 2022 15:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220609030128.GJ22722@merlins.org> <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org> <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org> <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220611001404.GM22722@merlins.org> <CAEzrpqda3=rDV8eLPsSDHbvmbyTnceecNkQUNA6mfOMmik=xDw@mail.gmail.com>
 <20220612170605.GI1664812@merlins.org> <CAEzrpqf=i064fiZpnbnTL+R7TS5cGa0QO1HXs-9KbRji1buu+A@mail.gmail.com>
 <20220612211904.GK1664812@merlins.org>
In-Reply-To: <20220612211904.GK1664812@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 12 Jun 2022 18:32:45 -0400
Message-ID: <CAEzrpqeW9gRTRCjFva0F0=boSmJYg4OYavVBkP3hMCaiMQ0kgA@mail.gmail.com>
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

On Sun, Jun 12, 2022 at 5:19 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Jun 12, 2022 at 04:05:22PM -0400, Josef Bacik wrote:
> > Yeah I missed we were BUG_ON(ret), so my change does the right thing
> > if we get a failure, but I needed to update the core code to return
> > the error.  Should work this time, thanks,
>
>
> (gdb) run rescue recover-chunks /dev/mapper/dshelf1
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue recover-chunks /dev/mapper/dshelf1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> FS_INFO IS 0x555555652bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x555555652bc0
> Walking all our trees and pinning down the currently accessible blocks
> Found missing chunk in super block 20971520-29360128 type 34
> adding bg for 20971520 8388608
>
> Program received signal SIGSEGV, Segmentation fault.
> setup_free_space (fs_info=0x555555652bc0) at cmds/rescue-recover-chunks.c:500
> 500                     bg->cached = 1;

Lord 3 stupid things in a row, maybe now we're good?  Thanks,

Josef
