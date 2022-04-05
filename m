Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022A14F4799
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348713AbiDEVOJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572994AbiDERnW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 13:43:22 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E7B91A9
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 10:41:22 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 125so16055120iov.10
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMSyXgPLbmxq+I9MOvHQMJHg4StD+iuHQEMfgtUQYE8=;
        b=F+n2JB9NoYmU9ZGYgzC+rYOwaSKovVGQrhAa6G1wFDyeU/jQ9WGg0j66Uf00axi7vN
         X76I9OjNYaDSk2B+PmCV4peJ90sXhV3zYm9oO504C7LltumhKs6FJjUwqXNljM0JgXnd
         aK+ujRuZ10YwRad7xAjfZa95w+35U5iYkZ2x1GYSyKh7ecpEZeS+kIaNhuaz8S8GxQJi
         Y3sMQ+2rjbm091ifX5f5wTCNjc1hzfKyn/0hyOyw88wyUsTtg/wBWLS0KE/p3VH5+eUJ
         vsqeDZDdt6wiD9xNDDEeO3wbZzted+JaSJw4MkFxoOdBEExAt+NM95fiKLqpNSouXUbF
         1TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMSyXgPLbmxq+I9MOvHQMJHg4StD+iuHQEMfgtUQYE8=;
        b=4I5khS4ybQVUPu8dRFiVilmuJZLJzuf5HZrIxTveTT6gBQUq67PhZ7/pavPyXuKNaC
         ZCaLhczjJIxYnFg6kdi+tzDZ7lhOG9A2B6OLL0HNLRLifPrFe+wdjolO1vdNzLvVGWoe
         5gqinRo9oeeF1FUd6Xar56HEviXAx0F+j2mquQChe/WotmyPZ4yS+vsAk3HQhTidJlgC
         VWe2HZmJ35m15BAnJ7qnOQ5g/k7PKzEtM6PmmZt7i4RIs4Y3nz7EwqY153a7liuztXM0
         pdngiJaUVCoFiT2uOf0Selqo5CdsJQzSBCazlJDH1uJ4CNNj8psuU8U1P7i7eE9yZjSb
         P17g==
X-Gm-Message-State: AOAM530Zd7NKX+IOa3buK2FxhKJFHqUbzCvAwOtNxYZHdR6be8+4KIDs
        CiXAtl7TDiIACkNMJCCXHOKGwe0w8sn3fBE3XPOexA1y3Ss=
X-Google-Smtp-Source: ABdhPJyZOktsNG5V33nyTQGr2wCh4yavdw88NLFMIUlnybPv4hbV7V01D1zRS0weBEqWVIqyFwfa+TU1rlk0/DnoKC0=
X-Received: by 2002:a05:6638:b1a:b0:311:4aa1:6c36 with SMTP id
 a26-20020a0566380b1a00b003114aa16c36mr2695547jab.281.1649180481432; Tue, 05
 Apr 2022 10:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220405002826.GD5566@merlins.org> <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
 <20220405005809.GE5566@merlins.org> <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
 <20220405011559.GF5566@merlins.org> <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
 <20220405014259.GG5566@merlins.org> <CAEzrpqdjLn51R++iX0_7-MRbxoNo7HL5GZFs4399KV6=RO3cyQ@mail.gmail.com>
 <20220405020729.GH5566@merlins.org> <CAEzrpqd6kePW6eiMB-R4DvMRvU=AK-jKpkBNUvSjttsSEsCwpA@mail.gmail.com>
 <20220405155311.GJ5566@merlins.org> <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
In-Reply-To: <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 13:41:10 -0400
Message-ID: <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com>
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

On Tue, Apr 5, 2022 at 11:55 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Apr 5, 2022 at 11:53 AM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Tue, Apr 05, 2022 at 10:11:25AM -0400, Josef Bacik wrote:
> > > Ok the fs volumes are going to be trickier to put back together, so
> > > first lets make sure the fs tree pointer is correct and relatively
> > > intact.  Can you do
> > >
> > > ./btrfs inspect-internal dump-tree -b 13577799401472 /dev/whatever
> > >
> > > I don't need the full dump since it's all the metadata for your fs
> > > tree.  What I'm looking for is if this looks sane, you'll see the
> > > normal errors you see from the fs being generally fucked, but I want
> > > this to spew and seem like it worked, and all have owner of FS_ROOT.
> >
> > Thanks. It's not too big, attached
> >
> >
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-tree -b 13577799401472 /dev/mapper/dshelf1a &>/tmp/d
> > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > Ignoring transid failure
> > FS_INFO IS 0x55741d8f7470
> > parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> > parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> > parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> > Ignoring transid failure
> > parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> > Ignoring transid failure
> > parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> > Ignoring transid failure
> > parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> > Ignoring transid failure
> > Couldn't find the last root for 4
> > Couldn't setup device tree
> > FS_INFO AFTER IS 0x55741d8f7470
> > btrfs-progs v5.16.2
> > leaf 13577799401472 items 234 free space 2612 generation 1602242 owner EXTENT_TREE
>
> Ok this is what I was afraid of, but I anticipated this wrinkle and
> I'm writing up something special to try and put everything back
> together.  I'll have something wonky to try in a couple of hours.
> Thanks,
>

Ok I think I'm going to do a humpty-dumpty thing where I scan for the
best possible copies of blocks and stitch them into the tree root.
I've wired something up to find out how many bad slots we're working
with so I've got an idea of how careful I need to be, can you pull
your branch again, rebuild, and run

./btrfs-find-root -o 1 /dev/whatever

and send me the output?  I'm working on the tool right now, hoping it
takes me a couple of hours at most (mostly because I have meetings
sporadically throughout today).  Thanks,

Josef
