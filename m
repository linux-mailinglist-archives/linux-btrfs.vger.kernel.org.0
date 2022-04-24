Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CB850D535
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 23:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbiDXVEw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 17:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiDXVEv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 17:04:51 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDCD6E545
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 14:01:50 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d3so8212961ilr.10
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyBC9ktQSfEMRxIARfRxifBtjoCjTNfKlBpiu2NIM3g=;
        b=vxM1Cp6LRu2TjiWi8VwKwyho28lCjOrCUyqX0FeyGI3H2AkAGvO+f9SjxUoGrU/Em+
         KR7VI8k4lhEC8YkxeywtTozKzuUF4b1Keb0YsLi0IEgrEPLHN13SR2IFLcuBQIfVibNb
         0SDS8P8bi4/GV2X8Fe2SOZodxNj+RPOfJLB9PE5Jv2fS+7kuzc282+syTJdiYQJgvoD5
         VbPbMN3/jrWxZfnDGgtCDBOVJq6qjLIPDudldY9NvZnZyRlLVE5Ng4dyDRXgibHPDx1g
         gDwbByIs+oqwUmFE2Sj4DiIrEtfC3qHTzvQ/1GsWoP+G9DCeLNsJPzxi0Jha57SqMyzq
         FSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyBC9ktQSfEMRxIARfRxifBtjoCjTNfKlBpiu2NIM3g=;
        b=OhrAxhSRa6jU3YnrDEcVZh8LpDhYo7wIcKhUq+oSeIyA++MBtfAAGA5eI5h9wjz8EV
         fvPO1msR+6ZxX4pWOWQuNGeBOq2dqjcKGDePOWg7YMo34BaHRc1Ol5DfRRFm0yQu5uV8
         Uq/5N+F8Vl337oMzjwupjrUJxIfgkGstN+WgtrLxz8uBMSbOKD1uj4BP4smnYpIaCrCK
         1EVhF5NltB9XSMn68h9H76Dg58wVlL/WD8glKbSRVoiNCBXCrQqUpYGr9R04TOc9tOUg
         PxkRfw/7p1wQcIx1zDJGRHnX9Z5UNlwU3ZmccSCk7l77em6QJVN0itRHxyapZ4VanHVv
         8/yg==
X-Gm-Message-State: AOAM533mvCRApHvZJ4fjSA3Xw74MZWuWGFKKzWUCflzHinnYZvzG8LAs
        TF1BeCDyBYG0jteIm+StOOokpymHZ7G1DwtMae7obPaXHFw=
X-Google-Smtp-Source: ABdhPJwTTSkSh8fZCMkBq6ZzbOD22eP7XfBZH40mGhgsdzPc0rrCXzf3vPl6w09B4rVAdcf6r0l21ndAbmvhm+rrvmg=
X-Received: by 2002:a05:6e02:17ce:b0:2cc:8c4:2c78 with SMTP id
 z14-20020a056e0217ce00b002cc08c42c78mr5971361ilu.153.1650834109263; Sun, 24
 Apr 2022 14:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqeo4U4SXH7LVz_Yx8ydX5BiqzFNJmAhQv1jCpjOessjHA@mail.gmail.com>
 <CAEzrpqdHAS2E1iuoSFVX-A-T-vsMoCo6CoW0ebw42vkCjqpMPw@mail.gmail.com>
 <20220424162450.GY11868@merlins.org> <CAEzrpqe6gwpF9k=Gj4=aCzkj-kW5GrZNueNnfoL8ZAAnMvwbng@mail.gmail.com>
 <20220424184341.GA1523521@merlins.org> <CAEzrpqeUJwtkMAUaxEd-qARe1aEZBx-v1-G_WY7vPr5MNL+3TQ@mail.gmail.com>
 <20220424194444.GA12542@merlins.org> <CAEzrpqeY_BAMLdL7NQmtC7ROBkZLrx=FHr=JC4KHoPF6Kwn3Kg@mail.gmail.com>
 <20220424203133.GA29107@merlins.org> <CAEzrpqemyJ8PS5-eF3iSKugy6u3UAzkwwM=o+bHPOh2_7aPHFA@mail.gmail.com>
 <20220424205454.GB29107@merlins.org>
In-Reply-To: <20220424205454.GB29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 24 Apr 2022 17:01:38 -0400
Message-ID: <CAEzrpqeVQQ+42Lnn9+3gevnRgrU=vsBEwczF41gmTukn=a2ycw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 24, 2022 at 4:54 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Apr 24, 2022 at 04:32:23PM -0400, Josef Bacik wrote:
> > On Sun, Apr 24, 2022 at 4:31 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, Apr 24, 2022 at 04:01:34PM -0400, Josef Bacik wrote:
> > > > > (gdb) run rescue init-extent-tree /dev/mapper/dshelf1
> > > > > Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
> > > > > [Thread debugging using libthread_db enabled]
> > > > > Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> > > > > FS_INFO IS 0x55555564cbc0
> > > > > JOSEF: root 9
> > > >
> > > > Huh ok, it's the UUID tree, weird.  I pushed, can you re-run
> > > > tree-recover, you can stop it after it does root 9, I just want to see
> > > > what bytenr it thinks the root node is at.  Thanks,
> > >
> > > (gdb) run rescue init-extent-tree /dev/mapper/dshelf1
> > > Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
> >
> > Sorry, I need tree-recover, not init-extent-tree.  Thanks,
>
> gdb) run rescue tree-recover /dev/mapper/dshelf1
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue
> tree-recover /dev/mapper/dshelf1

Wtf, it's reading the right bytenr, but it's not failing here but
failing when we do the init-extent-tree.  I've pushed something again
to force reads, maybe that's the problem, can you run tree-recover and
then init-extent-tree again?  Thanks,

Josef
