Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18253C342
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 04:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiFCCU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 22:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiFCCU0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 22:20:26 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57828369D5
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 19:20:25 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h18so4602619ilj.7
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chD4S16zL7iRKSjVjNeHP5S+HLst8wo9vFBdg+FbcxI=;
        b=PFwECKRESvFszfooN28DovF8+c6fF7vmcPCu1q+AaF4LbWNiOT6+foGQOy5hZhvy+a
         QPaXdt8R5rrOFNOA9KuiOkwlmuF+QDTf3nIgzK5NTgJfNDQhl6R2pvPNUQYE0P8ja6M+
         /lcrP+acmN4HEDODDFvu1GwrQ4ShZveyh1T24t/etVGZbuHOvCasg8U68VxbqZr+GSJk
         /DY6tMWEbEUpRtYX65B98pYtZPL9iiZrwPiRoxC7QIgFODI3625AtaA1gGBEds9DXbUw
         I+epqNgkDMV+jAIUu4nkg2p1my4MUAWn035jLaD9y8MzC4AvzbJvX1aXryuxQ502WzEj
         AUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chD4S16zL7iRKSjVjNeHP5S+HLst8wo9vFBdg+FbcxI=;
        b=iEUpBAH/SpcD4W+nj7lTQ7rmcHcpfCyIGdfIFPwGIc6X8NTPhTYe0ub8AKGHiZc1+7
         NpBZ/A1vvQeeEGEUHyC3zcMXkUAWfnHr/nJe3V+Dl7m5aME1dIJJdNkdypTwB7zsxCLR
         zNlK7p+vIYGQ5AwqMgEeC/NWNdsX6kBbwzGyGUGefPwdpKDs4/rgdH6eqZesWnD0XSHc
         gXBRm7LMN3kOCIayA5H81JQGUdiJHg142s0AaLsTyokBPz6VuRk4gVtGaczBlKinxDTC
         7Gvh43BWAJrD0Mnj8Ih9qwJc2GleN2X89Yw+C0uBedNX5JuNGR19Wj1odvr+BKqTsSG6
         N2eA==
X-Gm-Message-State: AOAM530E7gcizGKHsO3N73YBHFJI+0teVCSBAQ9PctN8S4FKC9/o72cW
        a6BhYvr+8IVzmsEOep8cp3Kb/CN8C1URGvYsk2s0gKplF18=
X-Google-Smtp-Source: ABdhPJx4Jlf2TOneVkDARM4QS9dOso/vxiT0/m0AhWcEZaPKVi+lqlSXqaIDpnYmzva7GH2IfAcR53FpWUivtxRJYYI=
X-Received: by 2002:a92:d1c6:0:b0:2d3:96da:426e with SMTP id
 u6-20020a92d1c6000000b002d396da426emr4872205ilg.152.1654222824330; Thu, 02
 Jun 2022 19:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220602142112.GQ22722@merlins.org> <CAEzrpqdJHDte6jc7-ykD-wnuFe8_xB-Y4e97C-o5B-G-1Nnksw@mail.gmail.com>
 <20220602143606.GR22722@merlins.org> <CAEzrpqdADZbOcz0iSoiYvOX=UVsbWybiRdcdtc4GJ-tmpJqdRg@mail.gmail.com>
 <20220602190848.GS22722@merlins.org> <CAEzrpqdKjjPW5Bvqkt2=U1_jmiBMGui775BC=Mdx6Ei5FWL1AQ@mail.gmail.com>
 <20220602195134.GT22722@merlins.org> <CAEzrpqciXfV0NZMTJoMjX_E_TzQ-j5sEpsACnEhnJdAXzbVOEg@mail.gmail.com>
 <20220602195623.GU22722@merlins.org> <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
 <20220602203224.GV22722@merlins.org>
In-Reply-To: <20220602203224.GV22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 2 Jun 2022 22:20:13 -0400
Message-ID: <CAEzrpqdBHuJr85+TfSyRbXEOVY6jqKqZNJo42d8afATr=b9Gow@mail.gmail.com>
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

On Thu, Jun 2, 2022 at 4:32 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Jun 02, 2022 at 04:06:00PM -0400, Josef Bacik wrote:
> > On Thu, Jun 2, 2022 at 3:56 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Thu, Jun 02, 2022 at 03:53:00PM -0400, Josef Bacik wrote:
> > > > Ok it seems like we're still missing some chunks, hopefully re-running
> > > > btrfs rescue recover-chunks <device> will find the remaining, there
> > > > must have been system chunks that got discovered.  Thanks,
> > >
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> > > FS_INFO IS 0x55f3efdd3bc0
> > > Couldn't find the last root for 8
> > > FS_INFO AFTER IS 0x55f3efdd3bc0
> > > Walking all our trees and pinning down the currently accessible blocks
> > > Invalid mapping for 11822437826560-11822437842944, got 14271702368256-14272776110080
> > > Couldn't map the block 11822437826560
> > > Couldn't map the block 11822437826560
> > > Error reading root block
> > > ERROR: Couldn't pin down excluded extents, if there were errors run btrfs rescue tree-recover
> > > doing close???
> > > Recover chunks tree failed
> >
> > Pushed, try again please.  Thanks,
>
> That worked:
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue
> recover-chunks /dev/mapper/dshelf1
> FS_INFO IS 0x5594c8305bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x5594c8305bc0
> Walking all our trees and pinning down the currently accessible blocks
> No missing chunks, we're all done
> doing close???
> Recover chunks succeeded, you can run check now
>
>

Sorry daughters graduation thing took forever, I've updated the code,
it should work now.  Thanks,

Josef
