Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE44539B24
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 04:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbiFACLD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 22:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiFACLB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 22:11:01 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1FF8BD08
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 19:11:01 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p74so321356iod.8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 19:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i70vQQSB1S1Bd5HbEcgdWO7meVBbtPaIL5th9B0G/Gc=;
        b=dCoZ5j63cnKqH/wLgBWTYSTEDeKb+fB4j9EOOVqhjJcK4Ndf11GKQlanQeaYgVWzfH
         U6ifCvwQwNl7hiq/u0zsv/OjvlUayeU8k9Z5LiWYh6ua5isahjlhWKXRP1vPVURY059W
         wUEW1YLoieY3PDZemkawbO1ogjHitrJTxqjFiRTVCo4GzhiOTHpN0BVVbNURyU0kk3oE
         lgua2IBfRWWmdVzhWS1bI0Jdv3l0ACsblvNK2i8GVNCngQwy9HAT28x46P/5+EjVrqgs
         NjcvLZt4jV9ZpHHSbaxkaehz6uIDMLNkmMSP3K+GrHp99oOk4NeODgyR3coRMmspERHj
         CyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i70vQQSB1S1Bd5HbEcgdWO7meVBbtPaIL5th9B0G/Gc=;
        b=lvcGvjhLkoiVQqlk/x0rlaZ6d4WFg5FlxshYPt9GHTwFGf1Pdq84Qh1hX+HGmAOkYp
         R3dJKUNvlSVEKwDF9bZYSg+3hs04o+UBPfCOKY0E/iVtN81ZdIhTTt25eMovLEt2auI/
         2dlEnyYCNoqKdmGank2U3WsM/zABK2ELoCZcEgq1Ma0RcIR3o/oAMN8Zn2D0kZTrcbpK
         h37gvGpGvky6tcetGM9UN+MWHxoVvDp2UNAWQWJj3vbkhZ3QuKKbOxxfQ/y3E5GhYb6P
         HXZEEHM2pWjj1qF8S239GZqXyQuVbSQLOYef2/nea4I0Jm4qSKSnu9CX9sE9D419k1Ur
         Osbw==
X-Gm-Message-State: AOAM530qO2VVM1HIUB41QRg66a04Mr56uNLuclJ+2MI/o+xK2mcNOeI5
        0mihsi3lGn1ZjmAGUIr8IWAYOYjtYtAmT5O9/bqJ8t6ibCI=
X-Google-Smtp-Source: ABdhPJwdjuwu/g5tE9V7JWh+k+sugDKP+AAsQVwmElK3c19M2F0i/BUe84iUiftxN4dhrTdr65zYwwFG0IXbN5VOPTc=
X-Received: by 2002:a05:6602:29ca:b0:649:558a:f003 with SMTP id
 z10-20020a05660229ca00b00649558af003mr28777991ioq.160.1654049460347; Tue, 31
 May 2022 19:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220530003701.GJ24951@merlins.org> <CAEzrpqcPirk3AOi1vy+N_V3VY49mvUCiwYL4A_0XoT_jxjgOrg@mail.gmail.com>
 <20220530191834.GK24951@merlins.org> <CAEzrpqdRV8nYFshj85Cahj4VMQ+F0n6WOQ6Y8g7=Kq7X_1xMgw@mail.gmail.com>
 <20220531011224.GA1745079@merlins.org> <CAEzrpqco_RyUBK=dngrv54u8WE2uhSGrJaB9aRY5nUmKNzN32Q@mail.gmail.com>
 <20220531224951.GC22722@merlins.org> <CAEzrpqcui3A42ogkas9pQfMqX0qE+MApPuiUw12uwpqhNq2RHg@mail.gmail.com>
 <20220601002552.GD22722@merlins.org> <CAEzrpqfkrD4aYA3vMToi+vfYeoyj=h4JAx+xnGQj836FP+pbjg@mail.gmail.com>
 <20220601012919.GE22722@merlins.org>
In-Reply-To: <20220601012919.GE22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 31 May 2022 22:10:49 -0400
Message-ID: <CAEzrpqc_sCu18+tfP9E1Z3+kj70ss7nH-YTnEu0Rw_QQxPWTUQ@mail.gmail.com>
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

On Tue, May 31, 2022 at 9:29 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 31, 2022 at 09:26:03PM -0400, Josef Bacik wrote:
> > On Tue, May 31, 2022 at 8:25 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Tue, May 31, 2022 at 08:14:27PM -0400, Josef Bacik wrote:
> > > > Wtf, we're clearly writing the chunk root properly because I have to
> > > > re-open it to recover the tree root, and that's where it fails, but
> > > > then the chunk restore can't open the root, despite it being correctly
> > > > read in the tree recover.  I've pushed new code, try tree-recover and
> > > > then recover-chunks again and capture the output please.  Thanks,
> > >
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> >
> > Ah ok, I wasn't actually updating the pointer, fixed that, lets try
> > the same sequence again.  Thanks,
>

Ok backup roots don't work if we didn't read them, try again please.  Thanks,

Josef
