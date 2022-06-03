Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D582A53D1A6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347322AbiFCSiZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 14:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347625AbiFCShz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 14:37:55 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9422533
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 11:34:49 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h7so398438ila.10
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvOQVPRLwiqpnv17h+bnCAVdNY8bphg66I2Qrg33ED8=;
        b=Mt1I0PRzP3c4M+MBjiM6ys1IWxhQ0UUr4EMB8NFbJ7rrkfrHvkB+0XquJ5vBZ/w7gF
         Evm8oGSzxO13rBlWrCUyRsqR8m1OHjqx7QLbBLysH+Yw8z3tTeWzzxPFBig57sHRGVCj
         s5/tm9FsP0NUJhm0wkBp8A4rT3faQLXURPxRVzQNIb0P+2BIv2o0zb1J+JPn97lp99Y/
         kLCXarMA2SCju2digbxjPMSw43uhN6swvksercWaoOtumm8bZlJBsDpyKDV9Zw8bLv6e
         +pn170rX/CttEuaWNG6mFx0eW2xp1zK8YMwYxuOAz0HxIic+XczApMThQSGPbtrNPuHL
         xnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvOQVPRLwiqpnv17h+bnCAVdNY8bphg66I2Qrg33ED8=;
        b=dJi+vI/XAKRzLNJ24rC//MOfVprudzyX27Kgo2BMmcZWrgUNNFyoURlfTCEWjmUP14
         hY+SbYItG+/ZZTI/nMYtabmTtjAeDi6es9kPR94bDp1lBS4KkDTUbM7DL/9RDqfpGCD4
         7ln3EQShIysiybJqTxzvZrWJ74i0XJciwA/Rh9xIYQK/WwI9BFXhF5Xu3IvWRwDxuoMX
         6iY3aZ9kVjfODgs5rwlUGbTLGV4hm97EHDzx+fzH3guLYLrit2hOUqjhwsCee+bszEWj
         BH3IqpWZwKWTpqBYBR0wW3A7Ugq/wdmVE+TXjiwDG4VPIY1GLcL6ia5kR/hdCz7j4UQh
         datg==
X-Gm-Message-State: AOAM532QRXP/qHyVbGNXinkfmmVbZ0GMTwXB+z8eRxQjSFdG1aqSEopT
        dYOtJsOuDrereINFLZljta3pqJEPDf2bAl+wXeQE8te9ZFQ=
X-Google-Smtp-Source: ABdhPJz1Ox8dYvyAjS18htbiS3Z5sP1W16xJ/BgceuVw8G3WGDFfepCH6Oj6EwFsHYxxCiS9Z7Y1cvy/NvA1zcVSuhg=
X-Received: by 2002:a92:d1c6:0:b0:2d3:96da:426e with SMTP id
 u6-20020a92d1c6000000b002d396da426emr6865637ilg.152.1654281288368; Fri, 03
 Jun 2022 11:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqdKjjPW5Bvqkt2=U1_jmiBMGui775BC=Mdx6Ei5FWL1AQ@mail.gmail.com>
 <20220602195134.GT22722@merlins.org> <CAEzrpqciXfV0NZMTJoMjX_E_TzQ-j5sEpsACnEhnJdAXzbVOEg@mail.gmail.com>
 <20220602195623.GU22722@merlins.org> <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
 <20220602203224.GV22722@merlins.org> <CAEzrpqdBHuJr85+TfSyRbXEOVY6jqKqZNJo42d8afATr=b9Gow@mail.gmail.com>
 <20220603144732.GG1745079@merlins.org> <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
 <20220603164252.GH1745079@merlins.org> <20220603170700.GX22722@merlins.org>
In-Reply-To: <20220603170700.GX22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 3 Jun 2022 14:34:37 -0400
Message-ID: <CAEzrpqf122toMdEAx2audiusW3kKM6d36df13ARJ+SjbVf7TFw@mail.gmail.com>
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

On Fri, Jun 3, 2022 at 1:07 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, Jun 03, 2022 at 09:42:52AM -0700, Marc MERLIN wrote:
> > searching 1 for bad extents
> > processed 81920 of 18446744073709518848 possible bytes, 0%
> > Found an extent we don't have a block group for in the file
> > Couldn't find any paths for this inode
> > Deleting [4483, 108, 0] root 15645018226688 path top 15645018226688 top slot 5 leaf 15645018243072 slot 11
> >
> > searching 1 for bad extents
> > processed 81920 of 18446744073709518848 possible bytes, 0%
> > Found an extent we don't have a block group for in the file
> > Couldn't find any paths for this inode
> > Deleting [4484, 108, 0] root 15645018161152 path top 15645018161152 top slot 5 leaf 15645018177536 slot 12
>
> finished with
>
> searching 164623 for bad extents
> processed 278528 of 63193088 possible bytes, 0%
> Found an extent we don't have a block group for in the file
> ref to path failed
> Couldn't find any paths for this inode
> Deleting [72784, 108, 0] root 15645019226112 path top 15645019226112 top slot 17 leaf 11160502550528 slot 12
>
> searching 164623 for bad extents
> processed 311296 of 63193088 possible bytes, 0%
> searching 164624 for bad extents
>
> Found an extent we don't have a block group for in the file
> Couldn't find any paths for this inode
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=25, bad key order, current (7819 1 0) next (7819 1 0)

Hmm tree-recover is supposed to catch this, can you re-run
tree-recover and see if it finds this block and gets rid of it?
Thanks,

Josef
