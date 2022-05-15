Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A794E52787F
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiEOPfn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 11:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiEOPfl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 11:35:41 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A911DA
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 08:35:39 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id n6so8959895ili.7
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T67KgcwuQTgUtgIu+mVEq6Vap/S+jqGamg/zdGr5WSg=;
        b=szMQ5gAM8R/JHOQpJAABFceD1PHEMWw1fs68Ml26juvHY4wdJwThtHx7w6E+bm8Vp5
         s1OeF7GwKeYwR7/PTfaldh5uNLzjsWXyQ3sAv9qKy6IeVU2baMKDQCn8tNeP2+NsGPJU
         MoxU+1GaPfR2CWKBiSm9OrcXGX4uZipc3OId5Y3mknzbGQljwcpCMLnlh4eJU+JAiu+q
         3m5WNgxVf4ncPAsX84fxpnZg4sFeXKuMdMH7xOTTQq3zHokfSfqhqtOgyhyZA48dsp/I
         kamKwPXBmwE+auEl9i+UvFT9sfciMjMQOsqNF7w44yFLSK/8JT4y+Q30rtRHZb5oVFKj
         sBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T67KgcwuQTgUtgIu+mVEq6Vap/S+jqGamg/zdGr5WSg=;
        b=B0+WFxKQLK/4b/Db1gtLHPZOPw8sH/ECofTOTA1I+H5m1BiKW2WSzXawlsfmCDhTzo
         /tHTGb496Cdr3hC+WaftsbyofJp1IEvLOYTkDb4TTxFfLdvyGcUDI1P7L9GJl46Q8y7L
         dc13oCH9pPCYiQ9vAgALTN5DZFY8AhC/zHvA8Mho03kTx5vPmMhIsLztGyuwI9t6ncyO
         0Q/NwkXvRz5NTBEdfGI4j6zWJhR+o8SxWhmGtMFbC0PbO+o86+oDXeq3GHLoJIc8bwYN
         na2U80+69WEZOga0QGZ2z8EDIwnVa0XCpHEgo4dDACtup093DJv0RCmeKuyrYXH4MYr8
         XNwQ==
X-Gm-Message-State: AOAM533T+WQUKhntluF6Eh+vwGhnIhXa8Fl6re/KRy9wSTolexITvCNk
        A8NC6XXONrhmaQC/6xZ+eu5MOHLkD/dVOm8PdMZkO6N45LE=
X-Google-Smtp-Source: ABdhPJxW9CdJ9C+A+OJDEPbNJs7U/I4doaZbLzfh5RpcUKOJ0HNW3FrPLhcIqmO/QiIsjeZLl7fSYkOlqLEMj56ZQdM=
X-Received: by 2002:a92:ca0d:0:b0:2cf:3bb8:f1a5 with SMTP id
 j13-20020a92ca0d000000b002cf3bb8f1a5mr7216701ils.152.1652628939047; Sun, 15
 May 2022 08:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220511150319.GM29107@merlins.org> <CAEzrpqcT0fObDa8XFWtvzeqCKom42t5o+xE9atmFjWyHCHmb=g@mail.gmail.com>
 <20220511160009.GN12542@merlins.org> <CAEzrpqdO4FX0A1b9xYycJQuMsvzUegSLcze4hpkMOD9dn2F-pQ@mail.gmail.com>
 <20220513144113.GA16501@merlins.org> <CAEzrpqfYg=Zf_GYjyvc+WZsnoCjiPTAS-08C_rB=gey74DGUqA@mail.gmail.com>
 <20220515025703.GA13006@merlins.org> <CAEzrpqfpXVBoWdAzXEYG+RdhOMZFUbWBf6GKcQ6AwL77Mtzjgg@mail.gmail.com>
 <20220515144145.GB13006@merlins.org> <CAEzrpqcVRJFS6HN4L7=tu0Z8SA+E2GsLJzWEADRK3iJvdVy4EA@mail.gmail.com>
 <20220515153347.GA8056@merlins.org>
In-Reply-To: <20220515153347.GA8056@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 15 May 2022 11:35:28 -0400
Message-ID: <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
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

On Sun, May 15, 2022 at 11:33 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 15, 2022 at 11:24:34AM -0400, Josef Bacik wrote:
> > Ok I pushed something new, but completely untested as I'm sitting at a
> > park with the kids and my kdevops thing is broken on my laptop.  You
> > should be able to do
> >
> > btrfs rescue init-csum-tree <device>
> >
> > and it'll rebuild the csum tree.  It'll give you a progress bar as
> > well.  I expect the normal amount of back and forth before it actually
> > works, but it should work faster for you.  Thanks,
>
> Thanks. Actually I'm past that, I'm doing
> ./btrfs check --init-csum-tree /dev/mapper/dshelf1
> that's the one that's been running for days.
>
> Are you saying init-csum-tree was moved to rescue which does run faster,
> and after that I should run the last step, check --repair, that you
> suggested?
>

Yes, I've replaced the rescue --init-csum-tree with rescue
init-csum-tree, which will repopulate the csum extents.

So you should cancel what you're doing, and then run

btrfs rescue init-csum-tree <device>
btrfs check --repair <device>

and then you should be good to go.  Thanks,

Josef
