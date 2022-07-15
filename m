Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A557576724
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 21:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiGOTIb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 15:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGOTIa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 15:08:30 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C648E94
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:08:28 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31c89653790so55546017b3.13
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjnjmWegb6B51c2v1Uq4pezCb2kWtc0QsCHn7cTDtsE=;
        b=qtYZWbLcBbgL1vJ9cBJ5KVKFsieGT2JeCJvqrlo3dcXQaXx8q1J0UFt0J0QrQ/LA/E
         JF6joVLfOMYVgNoxzLDTcIym0lA1stXln0rbd/xyvefxZtp/qaJdAMq8e8VNQgTQkC/c
         1Uf1DBXiHAlexxBH8cWDxn724XYUPoGv2ZhBB1R5QAWarvZZ0oGHhiR0MYNttpy688Ek
         Ka87zvOeJL7oGzoBQddg3lsg1UtktqD/4O+UrBdq6wycu8L4VkXNunA7LVVmKh0w9AlQ
         hYR+QjDannBfP3RJzjZRa394m54DvyvMnfKL9QxieQ2RYr0Rl3eugpKqDIsirtMW6vdm
         vnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjnjmWegb6B51c2v1Uq4pezCb2kWtc0QsCHn7cTDtsE=;
        b=aQYRt5SbL13mDNOsZ0Oekebmn6Jz4E58+KD7LTkC43lmtk2sM8IYngKoBFoNIfd6kP
         vwVm+yxNa8ff+gDaiJFAwPP+Md4s8/ztkGnC3SuPZ79eWrD/J7C1zvw4r/uUmaI5aYnd
         5/pY7LFubMYaMMVRFFc/xlhKTXFY06xtzyRQKmfN8WS9kem4dGKYIRs9ggcpZx/KadbU
         xdr1+5qvX8Mfsr4CVQafixFWe0wytuAEL0ySelLCgjfue7W3kxnSHdkf+QLYERmyX4yW
         dpvKdvcj+AThagz1wq1G9QV4S/DBm3MIg0iF2o4C3UfywF17o6+UVebUKIVxAIyaYEX+
         odlg==
X-Gm-Message-State: AJIora+RGE/YbNnyw0jF4QEJlJ4Y/muYr9yuvXOaUDGeHBHiTcFiD4dY
        cv8Rptdu/fpYv10Hqs8kVzpLZxsAh5P6R5x/hTc=
X-Google-Smtp-Source: AGRyM1svR6asuCkgOe/3+MYQEKDroOZIWLKATTQaqM32mtALoO5gousVRRfAhAWns+dzO59NnKVxKoR7cO1MnTcHkEc=
X-Received: by 2002:a81:53c1:0:b0:31d:825d:949e with SMTP id
 h184-20020a8153c1000000b0031d825d949emr17870617ywb.413.1657912107726; Fri, 15
 Jul 2022 12:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com> <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com> <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com> <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com> <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com> <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
In-Reply-To: <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
From:   Thiago Ramon <thiagoramon@gmail.com>
Date:   Fri, 15 Jul 2022 16:08:16 -0300
Message-ID: <CAO1Y9woJUhuQ+Q2yWSvscnBJb9D5cYiBaY-WG3Re=7V=OzWVhw@mail.gmail.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
To:     kreijack@inwind.it
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As a user of RAID6 here, let me jump in because I think this
suggestion is actually a very good compromise.

With stripes written only once, we completely eliminate any possible
write-hole, and even without any changes on the current disk layout
and allocation, there shouldn't be much wasted space (in my case, I
have a 12-disk RAID6, so each full stripe holds 640kb, and discounting
single-sector writes that should go into metadata space, any
reasonable write should fill that buffer in a few seconds).

The additional suggestion of using smaller stripe widths in case there
isn't enough data to fill a whole stripe would make it very easy to
reclaim the wasted space by rebalancing with a stripe count filter,
which can be easily automated and run very frequently.

On-disk format also wouldn't change and be fully usable by older
kernels, and it should "only" require changes on the allocator to
implement.

On Fri, Jul 15, 2022 at 2:58 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>
> On 14/07/2022 09.46, Johannes Thumshirn wrote:
> > On 14.07.22 09:32, Qu Wenruo wrote:
> >>[...]
> >
> > Again if you're doing sub-stripe size writes, you're asking stupid things and
> > then there's no reason to not give the user stupid answers.
> >
>
> Qu is right, if we consider only full stripe write the "raid hole" problem
> disappear, because if a "full stripe" is not fully written it is not
> referenced either.
>
>
> Personally I think that the ZFS variable stripe size, may be interesting
> to evaluate. Moreover, because the BTRFS disk format is quite flexible,
> we can store different BG with different number of disks. Let me to make an
> example: if we have 10 disks, we could allocate:
> 1 BG RAID1
> 1 BG RAID5, spread over 4 disks only
> 1 BG RAID5, spread over 8 disks only
> 1 BG RAID5, spread over 10 disks
>
> So if we have short writes, we could put the extents in the RAID1 BG; for longer
> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by length
> of the data.
>
> Yes this would require a sort of garbage collector to move the data to the biggest
> raid5 BG, but this would avoid (or reduce) the fragmentation which affect the
> variable stripe size.
>
> Doing so we don't need any disk format change and it would be backward compatible.
>
>
> Moreover, if we could put the smaller BG in the faster disks, we could have a
> decent tiering....
>
>
> > If a user is concerned about the write or space amplicfication of sub-stripe
> > writes on RAID56 he/she really needs to rethink the architecture.
> >
> >
> >
> > [1]
> > S. K. Mishra and P. Mohapatra,
> > "Performance study of RAID-5 disk arrays with data and parity cache,"
> > Proceedings of the 1996 ICPP Workshop on Challenges for Parallel Processing,
> > 1996, pp. 222-229 vol.1, doi: 10.1109/ICPP.1996.537164.
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>
