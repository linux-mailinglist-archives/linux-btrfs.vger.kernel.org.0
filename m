Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B94551E2BB
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 May 2022 02:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378733AbiEGA3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 May 2022 20:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiEGA3P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 May 2022 20:29:15 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C3411A01
        for <linux-btrfs@vger.kernel.org>; Fri,  6 May 2022 17:25:29 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z18so9770591iob.5
        for <linux-btrfs@vger.kernel.org>; Fri, 06 May 2022 17:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13aheHbYsrYXXbaaAciQZqdsOi2q80HdyTIgtAenPH8=;
        b=mMvjT2bM51eSw9nZnXmCg5NJyYZ10DI7ATXYqHe17UALvRO8KxFws68RiUeumziLOi
         x9pXWmG9jo2S08Kq0yYy14ymH/jbt3vmXiJu5eiahkl1Y5y57G6K/mrKsMm50tFbixMj
         FIwy20Fo+NkAHNvZDnAhrmfHr2OXopLlF41ebWZOaCqtVNVK4OMcJOtfKZ3Q671KiAN9
         w3UDdSkhyE7/tnwE5pEhZ/Ykr9It90PVmLm1S0TRXi8xd+lCSbcjc0VnW1oF//vVqwYC
         +xiaM87d/xIRRQguNkcIWFUYDADq3i2JAUNnAZ/Ifwxi7LnnwR3jP4h8oGzZ2aFgdbru
         QAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13aheHbYsrYXXbaaAciQZqdsOi2q80HdyTIgtAenPH8=;
        b=hgfVuY9+25FuDbmos4VPZSBZHPNdcMneSAu3HX29EB68cAx245SjOnQEJ2zFFRcgP6
         gMRj2gGzkpQkyqgxS/XSrUsq228knBkrcc20ZDGyKDYWo1/ohfOyc/jzJI3y4jXlR0Pu
         sEca02fDsUGS3m64BkxdTGcLwx1E6zDFEbEAEur9OM2VW3VeGFiydqp84A2x1ddrNxVl
         686scq5SicBz1HikAzvsdFrgb2cIOcDWokeYUxbpoNNIasbm4S8oxkhGsLXdIkFdcMNo
         xYhFXIT9b3SyvKcDJPYj9ldFLsBQc0DEUTvlB10LarsR4YK/eO0RhORmA5Web6jorYlu
         pRbQ==
X-Gm-Message-State: AOAM530UroRx/V+jm+m9ZPyzUacgPO8omD+AjHwwwXRAzP6ESOHTW85Z
        GvIQajdp1i5IdL8ml5IWXB6KN18RS9FTErMfwkoxODbAdfo=
X-Google-Smtp-Source: ABdhPJwnbLuox/TdQIu4afRylY6PUxD0BzWbaDcj/fhgBP92UOVlLVH7i81EPEQqL8ukQKS+OhAJB1S34GR1r4A++Zg=
X-Received: by 2002:a05:6638:2501:b0:32b:6083:ca39 with SMTP id
 v1-20020a056638250100b0032b6083ca39mr2671546jat.281.1651883129076; Fri, 06
 May 2022 17:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
 <20220503012602.GT12542@merlins.org> <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
 <20220503040250.GW12542@merlins.org> <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
 <20220503045553.GY12542@merlins.org> <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
 <20220503172425.GA12542@merlins.org> <20220505150821.GB1020265@merlins.org>
 <CAEzrpqfx3_BxSFPOByo5NY43pWOsQbhcCqU1+JqGAQpz+dgo7A@mail.gmail.com> <20220506031910.GH12542@merlins.org>
In-Reply-To: <20220506031910.GH12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 6 May 2022 20:25:18 -0400
Message-ID: <CAEzrpqfHzZrMuWrMERM-m4ASsuJAsijU9tpk_e5OML8dpgMeKg@mail.gmail.com>
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

On Thu, May 5, 2022 at 11:19 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, May 05, 2022 at 11:27:32AM -0400, Josef Bacik wrote:
> > Sorry Marc I was busy with the conference and completely misread what
> > you did.  Cancel the btrfs check now, and then do
> >
> > btrfs rescue tree-recover <device> // This should succeed without
> > doing anything but just in case
> > btrfs rescue init-extent-tree <device> // I'm hoping this will succeed
> > this time, if not of course tell me
> > btrfs check --repair <device>
>
> Got it. Note that check --repair faile
>
> ./gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> FS_INFO IS 0x55fbfe283bc0
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55fbfe283bc0
> Checking root 2 bytenr 29442048
> Checking root 4 bytenr 15645196861440
> Checking root 5 bytenr 13577660252160
> Checking root 7 bytenr 15645018521600
> Checking root 9 bytenr 15645878108160
> Checking root 11221 bytenr 13577562996736
> Checking root 11222 bytenr 15645261905920
> Checking root 11223 bytenr 13576823635968
> Checking root 11224 bytenr 13577126182912
> Checking root 159785 bytenr 6781490577408
> Checking root 159787 bytenr 15645908385792
> Checking root 160494 bytenr 6781245882368
> Checking root 160496 bytenr 11822309965824
> Checking root 161197 bytenr 6781245865984
> Checking root 161199 bytenr 13576850833408
> Checking root 162628 bytenr 15645764812800
> Checking root 162632 bytenr 6781245898752
> Checking root 162645 bytenr 5809981095936
> Checking root 163298 bytenr 15645124263936
> Checking root 163302 bytenr 6781245915136
> Checking root 163303 bytenr 15645018505216
> Checking root 163316 bytenr 6781245931520
> Checking root 163318 bytenr 15645980491776
> Checking root 163916 bytenr 11822437826560
> Checking root 163920 bytenr 11970640084992
> Checking root 163921 bytenr 11971073802240
> Checking root 164620 bytenr 15645434036224
> Checking root 164624 bytenr 15645502210048
> Checking root 164633 bytenr 15645526884352
> Checking root 165098 bytenr 11970640101376
> Checking root 165100 bytenr 11970733621248
> Checking root 165198 bytenr 12511656394752
> Checking root 165200 bytenr 12511677972480
> Checking root 165294 bytenr 13576901328896
> Checking root 165298 bytenr 13577133326336
> Checking root 165299 bytenr 13577191505920
> Checking root 18446744073709551607 bytenr 13576823717888
> Tree recovery finished, you can run check now
>
>
> The delete block bit should be automated somehow, it's quite slow and painful to do by hand (hours again here)

Agreed, I'm going to wire something up now.  Thanks,

Josef
