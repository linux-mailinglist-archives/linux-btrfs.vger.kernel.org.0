Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90D4F5698
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 08:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiDFGkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1841203AbiDFFgt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 01:36:49 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0B323575F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 18:08:44 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id t4so832441ilo.12
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 18:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssilonMdOYgyl+hopbx1XcedPip0yNZ0jqgccnMl9cU=;
        b=jOKxnklPMw0BJvmy9U4/TotyUeY16estoPz04t6aekiCjnLaB1LzCpXHqsb7te5FoY
         AV+L6LLNcZxBSUXZzCx9lefjsUfAm8v8EL7nc+VNujTuKh3dw010Nwi/FAI3QqrmG82W
         fkJvswzyn/hMQS3f8F4Uke9TUIqT1IKlQHgoSLlLR2MWlNSd2JuRrhciY+PBB18YsjDg
         EGeEW3ZVBG91d4LhGMagMp6iAvkX5b5tiMEd94iOBKDyKACszSJbTyyG7xWLHEu7HnL5
         ATXUkFM6A09sRwPCn4V035T90y7491rpi0oPLRn2CB09F704YiF9JVfS5pOJhb8+m3VJ
         iwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssilonMdOYgyl+hopbx1XcedPip0yNZ0jqgccnMl9cU=;
        b=SaTJ3gb070XqXY89tuZRCZR8r8Pdr1zIewQI0zvl3snMAGp7RAIX79SKn0sJ0e6mna
         mP2SCRzRLBu2E969Foo7AA2WGoku2BZT94XGd1rCYBA1dg9jf0K5zl6myYZzSikHAQw1
         N+N3oRUoFMwZUA6+iU2vAXQ2lER4bk2P48vqhgVASITQnd4Vm9HR0vjyRKjubhxlskFm
         43B5MCz5JaYeV6kSmOuoAWJ1LMLWtxCnvmlWrXdnI6z1Cbp0t5fBkVbADdxZtJbNNK6j
         y75DQNeWIylLoGjqRE8DJ2WInJsj8KD661NJOZIhZXjVw1LXG8/7USFkubat4taih9x4
         bZfw==
X-Gm-Message-State: AOAM533qioUr22+10/wUu5CRbPz8OLA1KM5VNmGRfj+ULVlssCsh6BDU
        b/lV0iYavG5GoB2WU811hnxodh3o9kceSNlTl38XcCTFWCM=
X-Google-Smtp-Source: ABdhPJyHjMoU8gqznHHCJOqfRZUsInhj1Zk2vPBy+SJReSfM66c2yR9vZ6ZlfvAyihdPdsN6EdJdAeh2hEFxb2xr8K0=
X-Received: by 2002:a92:c56c:0:b0:2c9:db11:98d2 with SMTP id
 b12-20020a92c56c000000b002c9db1198d2mr3209584ilj.152.1649207323511; Tue, 05
 Apr 2022 18:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220405203737.GE28707@merlins.org> <CAEzrpqemQ2Uzi+ZJHtQtbF62=hZMTmuPT3HxwkYedUvAsXhdvQ@mail.gmail.com>
 <20220405211412.GF28707@merlins.org> <CAEzrpqeZoUF3+Pgyaup1DGFENs6zDKtRqHiJQ6sx_CoXE2HOOA@mail.gmail.com>
 <20220405212655.GH28707@merlins.org> <CAEzrpqc0Ss+J6oTqNPfTgWOwyhPAF2uHnRELmc6AO6je6Ht88w@mail.gmail.com>
 <20220405214309.GI28707@merlins.org> <CAEzrpqeDZxjbis5kPWH3khiOALyFqUoTuh5eojFtWHPcwj-Ygw@mail.gmail.com>
 <20220405225808.GJ28707@merlins.org> <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
 <20220406003521.GM28707@merlins.org> <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
In-Reply-To: <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 21:08:32 -0400
Message-ID: <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
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

On Tue, Apr 5, 2022 at 8:39 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Apr 5, 2022 at 8:35 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Tue, Apr 05, 2022 at 08:23:42PM -0400, Josef Bacik wrote:
> > > Alright it's time for the crazy.  Go ahead and pull and start running.
> > > This is going to take a while to run, we're basically going to walk
> > > and check all the node pointers in the tree root, if it doesn't look
> > > right we're going to search the metadata for the best copy to use, and
> > > then update the block to point at the new block.  It has to do the
> > > full search every time, because we don't have time for me to properly
> > > implement a cache, so don't be worried if it takes a while.
> > >
> > > It may print out stuff, if it looks like it's looping stop it and let
> > > me know, but I don't think I fucked it up.  You're going to see a lot
> > > "fixed root <id>", "fixed slot <whatever>", if you see it repeating
> > > the same slot or root then we know we have a problem.
> >
> > I assume this is not good?
> > ERROR: failed to write bytenr 13577814573056 length 16384 devid 1 dev_bytenr 13439981355008: Operation not permitted
> >
> > I am running as root of course.
> >
>
> Yeah I'm just a dumbass, try again please. Thanks,
>

Also keep in mind this isn't the final fix, this is the pre-repair so
hopefully fsck can put the rest of it back together.  Thanks,

Josef
