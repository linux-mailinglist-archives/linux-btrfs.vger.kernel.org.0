Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965E453F182
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 23:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiFFVTy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiFFVTx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 17:19:53 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A409A180
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 14:19:52 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id a15so12828930ilq.12
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jun 2022 14:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwA1WX/oIZEUVJE4Xj2VBtL9rTSPpU2Aj6E73rVqCyQ=;
        b=vH6UHUxVbZ14izf4GTbaU9dWXQ35ai2UiQhcre6PcpArvU2KkSqrpO477OLEYSAuDX
         reJXsIc7lF2tW3PJkfsMz3NOxa1Fu7GNRNUVnWJdCsT/9y8PzN8d+xsUA102Bre/A3JI
         8LKijf4zE1O47sQP24fuUQcUi9+K4iy2u5himShKimk7qIy9ZqRxZbmzfTh/PUIscWxh
         ERfeg/uQv+u8crEtxTutYn/KzKDhpGKDpdWZIk4mA4/U2ilqAI0ZQVe1TtPrJo6IcKlt
         5Zs9RMqsiBz8+zh42/hJf8J/j4gChOp8iNk7brnH39kPQln2VJeJk8e5OWvOfpoYlmRe
         XYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwA1WX/oIZEUVJE4Xj2VBtL9rTSPpU2Aj6E73rVqCyQ=;
        b=EX6Nzfe1hVmhx4eTAwfE5/p+fvN9lGiVYfNyPRGyw0/C2wCytmY6uwRd+h4A8PZ38Y
         IfsN1BSPvHuOlYfq+fE5pv8BpLQCTnDLkSSWh2Xhi+wem+2vIHgYJIQKGk4Db7ty1gYZ
         ZZG4YgqzhPdWZAWI8Qg4SpKA8IG91OFrl+hMICUTn/W8nPeVoJmDQ7ed8p/aqcw70QxM
         oUohc6bv/HnberxrUILTnCwquYRDOx63K2rBsrQqnp1yRbpdlnXudI8HItRA9ecjt14T
         aVex20VxPMi+3/jNR2BDyyCyG8AF68CAe5ALJm0MC6CY2VAyBuOhvrtQjV1I5KHrzFEO
         3BMA==
X-Gm-Message-State: AOAM5310tUEyml+NHG0F4iQdYSz2nS5WiW/0tXuvet3MZptVvEYAdhyL
        eLafMeonmBMoo6MpZZhP4jvSpZNHIMzARIymb9ZZRpuTdqg=
X-Google-Smtp-Source: ABdhPJxA6o8xA7ObcfKn8uyIIQXhQHCpnHMCdg3tYyXOSadgbv+bAprzqq3xtbOgTScYyAgw92EhjuB5B5CWmPAkDxY=
X-Received: by 2002:a92:d1c6:0:b0:2d3:96da:426e with SMTP id
 u6-20020a92d1c6000000b002d396da426emr15278575ilg.152.1654550391511; Mon, 06
 Jun 2022 14:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220605201112.GN1745079@merlins.org> <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
 <20220605212637.GO1745079@merlins.org> <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
 <20220605215036.GE22722@merlins.org> <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
 <20220606000548.GF22722@merlins.org> <CAEzrpqdL6rK+-OUhW2AR3jXhK8TTsTM77A1CUkh=-+Y7Q1av9Q@mail.gmail.com>
 <20220606012204.GP1745079@merlins.org> <CAEzrpqeOb4XnGxbeMXNcDHn+wMNC7sBS7eFdsTbUj8c7BUgcuA@mail.gmail.com>
 <20220606210855.GL22722@merlins.org>
In-Reply-To: <20220606210855.GL22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 6 Jun 2022 17:19:40 -0400
Message-ID: <CAEzrpqe1_vbZ=+3C5=YPDJOCJGLAX9e4cmO_a+F1P3sdg9ubwQ@mail.gmail.com>
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

On Mon, Jun 6, 2022 at 5:08 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Jun 06, 2022 at 04:42:30PM -0400, Josef Bacik wrote:
> > On Sun, Jun 5, 2022 at 9:22 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, Jun 05, 2022 at 09:11:28PM -0400, Josef Bacik wrote:
> > > > On Sun, Jun 5, 2022 at 8:05 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > >
> > > > > On Sun, Jun 05, 2022 at 07:03:31PM -0400, Josef Bacik wrote:
> > > > > > I wonder if our delete thing is corrupting stuff.  Can you re-run
> > > > > > tree-recover, and then once that's done run init-extent-tree?  I put
> > > > > > some stuff to check block all the time to see if we're introducing the
> > > > > > problem.  Thanks,
> > > > >
> > > > >
> > > > >
> > > > > gargamel:/var/local/src/btrfs-progs-josefbacik# gdb./btrfs rescue tree-recover /dev/mapper/dshelf1
> > > >
> > > > Ok more targeted debugging to figure out where the problem is coming
> > > > from specifically, but hooray I was right.  Thanks,
> > >
> > > searching 164623 for bad extents
> > > processed 311296 of 63193088 possible bytes, 0%
> > > searching 164624 for bad extents
> > >
> > > Found an extent we don't have a block group for in the file
> > > file
> > > corrupt node: root=164624 root bytenr 15645019570176 commit bytenr 15645019602944 block=15645019586560 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> > > corrupt node: root=164624 root bytenr 15645019570176 commit bytenr 15645019602944 block=15645019586560 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> > > cmds/rescue-init-extent-tree.c:197: delete_item: BUG_ON `check_path(&path)` triggered, value -5
> >
> > Cool, must be in balance, lets try this again.  Thanks,
>
> Same?
>

Nope different spot, I added some more printf's to narrow down which
path is messing up the key order.  Thanks,

josef
