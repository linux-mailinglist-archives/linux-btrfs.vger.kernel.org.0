Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F93511902
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 16:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiD0Oru (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiD0Ort (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 10:47:49 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A937A96
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:44:38 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o5so97681ils.11
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YA8hZxqsey1AEQxmfsJTmUJGzZMw1A+bcEglZTQuW48=;
        b=691YWncFA01/QliHwvaB7BvkOq5IZFgxTLgSoXHIT2HbNXc6Xji6o61x/+47G/1O0p
         1NDHk8nND0czClXYdUhm6WplBD3IsDgDzmQirSTj3jYxKw3A+QAAC3HyXLd/dAqxp/LI
         1xAdt2VS4f1YC3PR8hiPUTXGPk+LKFEMa7D18nf7LzNy79S8cAimVk5qlYNp4jftVs8L
         76TZod4/anZ1/976Yl1H2oaAd9AMKUvshsDbI7hUoABTzP3yPOTUGMRr7ac1L2nO+Hnl
         RKXjRWvWa+heD4nrEiMs++VeUfrmw8U0RyDvYXn+oarf9WjqiFV5j8hPiPj8Ek3eIg7N
         WcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YA8hZxqsey1AEQxmfsJTmUJGzZMw1A+bcEglZTQuW48=;
        b=xJ7ZioHGwFD+JWqgKkER7RetQfLHHXNMzKaD55vjkTon4k1qXd8g8WncBEkqXgADWz
         rm5LZP0rPb6WtkkAjgd6cekS2H1iMYcuiW/K4z8rzbHx5BcNlQHYFGxq1rse+DUJbyrb
         cw/PkINspI1j/Lb7pgjWIp3mqSMHo3QDO8IoNkP2c/d10qkhRK8TgNGUWm+Ow/VhpP0o
         JOjugBqHOr5gHnqr/nHDLHVvAWb3S0ytKLNwKzy834itR6mymSwtelzx50TtM4C75t/x
         5grknLJ33EWix8Mot62tA5eewdRy+G3ccN0x7I4mWnHVKlpfBXCHv6wXyRTYiQlAAh7u
         MWvQ==
X-Gm-Message-State: AOAM530Gc7NsDAkrObTrWfOTAzFnhoHvjvt96h7DB8FCsbR0BCkcClDU
        SyYueme1hDiZKkQbQtm0wl+66Jlo4TFvVxXT+1eqHOhA1CA=
X-Google-Smtp-Source: ABdhPJxjarfdimukTR+mS4uHRlwHitp1hN51XCgHz6yoO06aHi+KXJUsKxDhjwamrYbdez5wuhhjQTm6t1vh5FwArIo=
X-Received: by 2002:a05:6e02:17ce:b0:2cc:8c4:2c78 with SMTP id
 z14-20020a056e0217ce00b002cc08c42c78mr11841032ilu.153.1651070677589; Wed, 27
 Apr 2022 07:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220424223819.GE29107@merlins.org> <CAEzrpqdBWMcai2uMe=kPxYshUe8wV0YX3Ge1pZW8aG_BSO-i-w@mail.gmail.com>
 <20220424231446.GF29107@merlins.org> <CAEzrpqcGy3aac6Lb7PKux+nA2KzDgbPSMyjYG6B-0TbgXXP=-A@mail.gmail.com>
 <20220425002415.GG29107@merlins.org> <CAEzrpqcQkiMJt1B4Bx9NrCcRys1MD+_5Y3riActXYC6RQrkakw@mail.gmail.com>
 <20220426002804.GI29107@merlins.org> <20220426204326.GK12542@merlins.org>
 <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
 <CAEzrpqdKTrP_USiq9sKTXv1=uY1JVWRD5bVfdU_inGMhboxQdg@mail.gmail.com> <20220427035451.GM29107@merlins.org>
In-Reply-To: <20220427035451.GM29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 27 Apr 2022 10:44:26 -0400
Message-ID: <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 26, 2022 at 11:54 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 26, 2022 at 05:36:28PM -0400, Josef Bacik wrote:
> > On Tue, Apr 26, 2022 at 5:20 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > On Tue, Apr 26, 2022 at 4:43 PM Marc MERLIN <marc@merlins.org> wrote:
> > > >
> > > > Generally would you say we're still on the right path and helping your
> > > > recovery tools getting better, or is it getting close or to the time
> > > > where I should restore from backups?
> > > >
> > >
> > > Yup sorry for the radio silence, loads of meetings today, but good
> > > news is I've reproduced your problem locally, so I'm trying to hammer
> > > it out.  I hope to have something useful for you today.  Thanks,
> >
> > Sigh I'm dumb as fuck, can you pull and re-run tree-recover just to
> > make sure any stupidity I've caused is undone, and then run rescue
> > init-extent-tree and then we can go from there?  Thanks,
>

Ok back to this problem again, I've added some debugging.
Unfortunately the real bytenr is getting lost, so the new debugging
will print the actual bytenr we're trying to add, and then I can add
more targeted debugging to figure out whats going on.  Thanks,

Josef
