Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A554F6C36
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 23:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiDFVLj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 17:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiDFVLS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 17:11:18 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5654158568
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 12:53:46 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id d3so2694249ilr.10
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Apr 2022 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6zfysJgvZERnxM2mCtWsEoF3y+zSGYBlNstf5iSXXw=;
        b=W9tKqUj6+hvsHwKykYOfZ09DI0/zd2REKXsQ+xx20IPXLz/faHZ8dytuCi9CFAHDXh
         rlthYPRKCEq2h2Uuebb6+xhGm70wHYXTP+pM7YbzYEeP9mnYwIeZa9lCknS+e27h5801
         DJDTAS3KO5D051krVY7vEBI1eMtLPzjZB23WjDterZ8Aq9CNyWnN3tq1e1hwYF2sZRiG
         frpVNcKuXKIsqAJJPKcwfOmM8o6fE2OYS4qOSy4aQX9fr2B4YLwQL3EUgL9yGtERzXF3
         OI8gVPgPhQIR4FKNCncxtcwLJhF3s5MrQAQoalD5jG6TFr0d4Qc8YdRz8nYhFpVynU7l
         cDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6zfysJgvZERnxM2mCtWsEoF3y+zSGYBlNstf5iSXXw=;
        b=yjVpIQAXw2miO7BUzsliek6GDU55WjtTkswGSVYcrZlHT19AVWgwIT9PcBQy4iphUd
         pv+LZrrAWeDxC2UYEbEkLxmXHM7SgtJtvdMDKVAJSW/2EhZZD3iB2V2ssEZjM+5qqsXU
         9z53tQS4C850Q+y14QzABUBpLeUcyFXLOnsfQRaWTzIFjUhYkaScYNNt7yRwg7dUAvkS
         9YY1T7xiZh19oDCXn+fNIF/m1un+BchZ+aWqXsA/1/mXT6j5q4ZKj5bbAMcgGEmJBVXR
         S1NF5eLSlSdPlsnB16fUn3i2rZp3XU68X1SHOVL0XoW9BC13r6dOE1EGa1NMMrqUk/O8
         UIoA==
X-Gm-Message-State: AOAM531y/pNwK9EOowrM/lNEfchA8LwdpLBJk38NRRNytm8dC9IX5LgM
        51mFofwllHPNMeIF8KV92sOfjj1opcyL7kc9ZpCXhc+RQMU=
X-Google-Smtp-Source: ABdhPJx1aHe3/tK7t9cl+6S0xRZYkTDsxT4evZTF+FTzRP39xy/WWFUOkL15i6c7JsU4QRE4nLrM6yw/9KrEAJGVJ/I=
X-Received: by 2002:a05:6e02:170a:b0:2c9:f038:7f2e with SMTP id
 u10-20020a056e02170a00b002c9f0387f2emr5007769ill.127.1649274825528; Wed, 06
 Apr 2022 12:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220405225808.GJ28707@merlins.org> <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
 <20220406003521.GM28707@merlins.org> <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
 <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
 <20220406031255.GO28707@merlins.org> <20220406033404.GQ28707@merlins.org>
 <CAEzrpqfnGCvE36-r-0OkN7yoA7j9XPCNqQVOnLrgA+cQZNoR3A@mail.gmail.com>
 <20220406185431.GB14804@merlins.org> <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
 <20220406191636.GD14804@merlins.org>
In-Reply-To: <20220406191636.GD14804@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 6 Apr 2022 15:53:34 -0400
Message-ID: <CAEzrpqf0Vz=6nn-iMeyFsB0qLX+X48zO26Ero-3R6FLCqnzivg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 6, 2022 at 3:16 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 06, 2022 at 02:57:03PM -0400, Josef Bacik wrote:
> > Yeah lets go for that, I saw some errors on your fs tree's earlier, I
> > may need to adapt this to fix that tree, or if it's a snapshot we can
> > just delete it.  We can burn that bridge when we get to it, thanks,
>
> Sounds good. Is mode=lowmem a thing of the past by the way?
> (I remember that the old regular repair would eat up my 32GB of RAM and
> take the machine down)
>
> The current one failed quickly though
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --repair /dev/mapper/dshelf1a
> enabling repair mode
> WARNING:
>
>         Do not use --repair unless you are advised to do so by a developer
>         or an experienced user, and then only after having accepted that no
>         fsck can successfully repair all types of filesystem corruption. Eg.
>         some software or hardware bugs can fatally damage a volume.
>         The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> FS_INFO IS 0x55e2e75defc0
> parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
> parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
> parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
> parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
> parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
> parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
> parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
> parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
> Couldn't find the last root for 8
> checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
> parent transid verify failed on 15645261971456 wanted 1602297 found 1600989
> checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
> bad tree block 15645261971456, bad level, 127 > 8
> ERROR: failed to read block groups: Input/output error
> FS_INFO AFTER IS 0x55e2e75defc0
> Checking filesystem on /dev/mapper/dshelf1a
> UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
> [1/7] checking root items
> checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
> parent transid verify failed on 15645261971456 wanted 1602297 found 1600989
> checksum verify failed on 15645261971456 wanted 0x10a0c9b9 found 0x08b85944
> bad tree block 15645261971456, bad level, 127 > 8
> ERROR: failed to repair root items: Input/output error
>

Alright so it's up to you, clearly my put the tree back together stuff
takes forever, you can use --init-extent-tree with --lowmem if you'd
like, I have no idea what the time on that is going to look like.  You
still may run into problems with that if your subvols are screwed, but
then I just have to do the work to put subvols back together.  I
*think* the --init-extent-tree thing will be faster, but let me know
what you want to do.  Thanks,

Josef
