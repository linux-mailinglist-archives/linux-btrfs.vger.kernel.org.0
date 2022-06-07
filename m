Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA154253F
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384331AbiFHA3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 20:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588573AbiFGXys (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 19:54:48 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72E36330
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 16:41:43 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id f12so15425952ilj.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 16:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32yAaEAAoSHcwUYgFPnCV//IJPvnLvQPuSQTiYBjyyc=;
        b=KmxlTrmNvppqV7l/zcoWeh0QpGVfC4MOX2RTFmZx7ZnPu8YzWSupZynpNSxMGtRGJa
         cCG+eech6xMIXKcXfsqUnX6jzw0a53g7gsFqtPVl73/EoQ2oHpnLn0XPywVfkvfSP44d
         XsgOFRZqhmmz5OFlEToXFLovtPKNkYRAew5sA6f/zz3W4lW/7l+hq6jaBgxMEt103nmt
         fiLrmxTi4KxFOWE2XK04HZorn2FGx9lBNu8beMe4JQp+ej19B1EIhwj41XqElLeBwYwV
         KMxcp/tSSNBjF2OFsc6SH80Sw+ceygvA2BRZX/WnxSB15OYsPzgMK7vefzlLhLpIJBgZ
         7ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32yAaEAAoSHcwUYgFPnCV//IJPvnLvQPuSQTiYBjyyc=;
        b=oda2miXKIGKKkGUjCYH4u4F071ImlBWWNDLSY2il7BQKVxmvCa4XGWMxQXEKCNGD1+
         UZS8tggJ2zMWAdG7R86r0Hb8bNHUKyMrhcIyXBRYVMv9bAMzOhUDHyJNMPFVlMozNzux
         4XtatoER4APOku2i5PMmhlCJ7DZ9a8Sl7UEljKH8fbkYXt7dwNoKyIJ+0IP2gpbhsg91
         TT41zaylNZr8xTVaWMUzhzVyNoq7JIuc+wWY+gAqMI6GnWQnaebCOuC7RPdICqMbGK4e
         Xabxux2Cmbjky9HI6IO/PGi1J4BwZHOz/9BvbYsFEld1L8WXK6vFUC5kR1YSXTqS7rLR
         hExg==
X-Gm-Message-State: AOAM531J07J5mJZRyFA/5M7ueTszhYlOcHy/TVMZGThbSaO0QuGrCZ56
        MnPZOKZJN0FhdiAYsdHLSXP9ab+kjwgx74jIhgzG1P7HDCc=
X-Google-Smtp-Source: ABdhPJxv2Hm0WJOtD71ySDLA3NB1a52zD8/87prlME11wK5jhTp6vaW4s5n7x3LLK3FAY3ljzVzBUf20vLcXKp3VwIo=
X-Received: by 2002:a05:6e02:158a:b0:2d3:f198:9f39 with SMTP id
 m10-20020a056e02158a00b002d3f1989f39mr14303007ilu.206.1654645303047; Tue, 07
 Jun 2022 16:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153257.GR1745079@merlins.org> <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
 <20220607182737.GU1745079@merlins.org> <CAEzrpqd335YbHi2U07nxnt62OSL8R60nx2XAUpMXE+RQjACSZQ@mail.gmail.com>
 <20220607195744.GV22722@merlins.org> <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
 <20220607204406.GX22722@merlins.org> <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
 <20220607212523.GZ22722@merlins.org> <CAEzrpqex0PRGZA3_gaoUhpPb-7cpi-gi_mo1S3F=0xxKNptpEA@mail.gmail.com>
 <20220607233734.GA22722@merlins.org>
In-Reply-To: <20220607233734.GA22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 7 Jun 2022 19:41:32 -0400
Message-ID: <CAEzrpqcVO99HbrhmtABUENRCm4HEsyg3+T3oK33DZFuXamwqgA@mail.gmail.com>
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

On Tue, Jun 7, 2022 at 7:37 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Jun 07, 2022 at 07:33:00PM -0400, Josef Bacik wrote:
> > On Tue, Jun 7, 2022 at 5:25 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Tue, Jun 07, 2022 at 04:58:57PM -0400, Josef Bacik wrote:
> > > > Ok I think I fixed that, but I also updated the loop to bulk delete as
> > > > many bad items in a leaf at a time, hopefully this will make it go
> > > > much faster.  Expect more fireworks with the new code.  Thanks,
> > >
> > > Found an extent we don't have a block group for in the file 10741731311616
> > > ref to path failed
> > > Couldn't find any paths for this inode
> > > Deleting [73101, 108, 0] root 15645020241920 path top 15645020241920 top slot 49 leaf 15645020766208 slot 26 nr 73
> > >
> > > searching 164629 for bad extents
> > > processed 802816 of 108838912 possible bytes, 0%
> > > Found an extent we don't have a block group for in the file 10741731311616
> > >
> > > Found an extent we don't have a block group for in the file 743378268160
> > >
> > > Found an extent we don't have a block group for in the file 946736541696
> > > ref to path failed
> > > Couldn't find any paths for this inode
> > > Deleting [73101, 108, 427687936] root 15645019537408 path top 15645019537408 top slot 49 leaf 15645020766208 slot 26 nr 148
> > >
> > > searching 164629 for bad extents
> > > processed 802816 of 108838912 possible bytes, 0%
> > > Found an extent we don't have a block group for in the file 946736541696
> > > ref to path failed
> > > Couldn't find any paths for this inode
> > > Deleting [73101, 108, 1747189760] root 15645020241920 path top 15645020241920 top slot 49 leaf 15645020782592 slot 26 nr 1
> > >
> > > searching 164629 for bad extents
> > > processed 835584 of 108838912 possible bytes, 0%
> > > corrupt leaf: root=164629 root bytenr 15645020241920 commit bytenr 0 block=15645020438528 physical=15054974140416 slot=0 level 0, invalid level for node, have 0 expect [1, 7]
> > > kernel-shared/ctree.c:148: btrfs_release_path: BUG_ON `ret` triggered, value -5
> >
> > Ugh come on, this must get triggered because we clean up some stuff
> > and then the corrupt blocks are suddenly right next to eachother.  Can
> > you re-run tree-recover and see if it deletes those keys?  Thanks,
>
> Sorry :(
>

Ok I think it's just the check is wrong, I removed the check, maybe
I'll get lucky for once?  Thanks,

Josef
