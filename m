Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA64F478E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbiDEVNS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457509AbiDEQDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 12:03:19 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C98E63EB
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 08:55:53 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id x4so15661573iop.7
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxCNF3RZsontLw/qJfhlzD5NAQI3uWP4qeqINIhiFWQ=;
        b=mPk/sdloH9/MeUWJvnALivqd/fxHeJOUCaX97M8orNPym3I3XQH2Wj8x56Jm3jd1Qj
         kLCbUgGqQbitU6TcXqVSpvO1FDIWwvY7aUh2+uPnMn2u0v3jo49lcJgePA+/K+97V/ZV
         d1LzCZMUnqIVdoY/vMzDslZe7kn8IacBw3xVLvAQvrUhHEKV2/G7nnN2xY5CNrn0Wh1w
         wamOZ3HlvI7hInCX81fLU4bnrXj9u4yck4/ZRMDqe7XzhGNPhIbWcSDMBd74i7YxQcOg
         BTjcA1NHpk+dXHsOPoBdeu+aPE8QZ3GS2oGDyxEZ3+K66wo2d5MpyIz0/hrOpZduL3CF
         O5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxCNF3RZsontLw/qJfhlzD5NAQI3uWP4qeqINIhiFWQ=;
        b=rwVGcuLvdw6j7uW5D6a6KMTYYz4EvJaKJljyRDlvcqXTQMZtXlJGckR9CwiQJnVhel
         fUj6Pj4uiE0FZOCpYWYnwLw9rI6wWw2y+iUIfsCaeM/2jmw06SfvaKgVPa33VWmHr8eV
         n60YbETCO5xB6onWwZThbLbqbP5kLhmGrW72Sl/RaaoMBDRwPa67rjAAzRrSTKyuAPbL
         Zq4Whrh//vkBnl1hpt0grrLCMEvIHXhfy6oSTmdYXg1K/fieHq0i41k6TKhrg7NqyIGv
         tCBU6aB2G4ILrOjUYpX5fMjD8t9tVohGUst7k0nXI1g2bcm4Hhc8ZBbfon6jVoiFUjmQ
         ZLZQ==
X-Gm-Message-State: AOAM533ZIR0Lux0mzJfTmEmDi5DCQCszK0dzsAU2jWLN/OOeEm6Lz4FY
        W+t9eGDZPsAN/jajbYPSxY1PkB2OGS0Gd12AAh+vH+5m/9U=
X-Google-Smtp-Source: ABdhPJxU+aVnuo3pVP622r1uLxY7ENKIADjkTaa/rXvy29zcGIWVpuKbA3OUV5ccx+kXAfwljFeDbkW/Rg9M3cq0Ljc=
X-Received: by 2002:a05:6602:14c7:b0:646:3bfb:7555 with SMTP id
 b7-20020a05660214c700b006463bfb7555mr2011625iow.83.1649174152573; Tue, 05 Apr
 2022 08:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220405002826.GD5566@merlins.org> <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
 <20220405005809.GE5566@merlins.org> <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
 <20220405011559.GF5566@merlins.org> <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
 <20220405014259.GG5566@merlins.org> <CAEzrpqdjLn51R++iX0_7-MRbxoNo7HL5GZFs4399KV6=RO3cyQ@mail.gmail.com>
 <20220405020729.GH5566@merlins.org> <CAEzrpqd6kePW6eiMB-R4DvMRvU=AK-jKpkBNUvSjttsSEsCwpA@mail.gmail.com>
 <20220405155311.GJ5566@merlins.org>
In-Reply-To: <20220405155311.GJ5566@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 11:55:41 -0400
Message-ID: <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
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

On Tue, Apr 5, 2022 at 11:53 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 10:11:25AM -0400, Josef Bacik wrote:
> > Ok the fs volumes are going to be trickier to put back together, so
> > first lets make sure the fs tree pointer is correct and relatively
> > intact.  Can you do
> >
> > ./btrfs inspect-internal dump-tree -b 13577799401472 /dev/whatever
> >
> > I don't need the full dump since it's all the metadata for your fs
> > tree.  What I'm looking for is if this looks sane, you'll see the
> > normal errors you see from the fs being generally fucked, but I want
> > this to spew and seem like it worked, and all have owner of FS_ROOT.
>
> Thanks. It's not too big, attached
>
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-tree -b 13577799401472 /dev/mapper/dshelf1a &>/tmp/d
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> Ignoring transid failure
> FS_INFO IS 0x55741d8f7470
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> Couldn't find the last root for 4
> Couldn't setup device tree
> FS_INFO AFTER IS 0x55741d8f7470
> btrfs-progs v5.16.2
> leaf 13577799401472 items 234 free space 2612 generation 1602242 owner EXTENT_TREE

Ok this is what I was afraid of, but I anticipated this wrinkle and
I'm writing up something special to try and put everything back
together.  I'll have something wonky to try in a couple of hours.
Thanks,

Josef
