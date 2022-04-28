Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C76513F05
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 01:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353257AbiD1X1v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 19:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiD1X1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 19:27:50 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872CBC870
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 16:24:34 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id f5so2962548ilj.13
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6mJENeC/sI+4Rm8WGBSnBJLRjBWRd1C/kmsRoGzoFQ=;
        b=w0S5PaGKsFfGl7OqhUZZTztpIfMeaJy5l/jdEDUD+2hlEuQC6TlxdbR6J3iTGKqhzL
         gfsibjS6N4Nyo2/bZ2kCnZw1Dwc2lDfF6U1n3mXkic+OfPWugA4HuJozKjWZMun9IMBH
         L3FHa8MfghIttehJ0cNQsGq1hzFDaKcuYY6cd7kIMfOhM07PBuySqWmk6dKlOBuUo7NQ
         0D3ccgE/x0zcMysaqWN7o1We0QcQ/EKqfbIKiY1pXDGTNC82Mj6iYR0XeFyGkwDwLhR+
         3sNVDpaveDiodkCFNHLsRh9Uu00oUOLvZcW5NZi49Cgz/N5NgeXKHwf8K+wI5nunOPun
         gNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6mJENeC/sI+4Rm8WGBSnBJLRjBWRd1C/kmsRoGzoFQ=;
        b=N3q37cJwgqN7BAUyjtFisIBANQ/87yuhY8xi8VyzculBNqMZRRFWeLgRvWJlBIyLwN
         kXgEwRCMf+5W24vIR0bj+2waEVn7bQ/1ZsBxtu6HcxLAxlyybU8ewdh9qZJ4s9VfdZpO
         15XnJlJOI4vRZqzSb75Y2xFuc1UwcoFeQ01T4LnRJsKP3XepMPJEdhSe7TWt3X8JtyUs
         lNlfRTWQSxPyfIHSfnflYEoxIeYoHAbH+npZr9mQDKI9WQGsjw5pGsukiyuCCqhuV+Kg
         VJ5314PlMrdauyjsnGNrcPbPedBK6GMPw8vWqsIrdffa4RWTbn4MSw10nv9NQp1V4xTv
         rKXw==
X-Gm-Message-State: AOAM533Hqb6UEMNr4b/kWqFy/6HzDSJ7cZDl5YcRlV/kiS+2vcy+Y/yW
        rrygF8d2n2DvY2FlQltaI5cG3coXDO55cl0U0Aw5RWAxzJE=
X-Google-Smtp-Source: ABdhPJz006Lli+rIJi91s08ypP4SL1t4XqGCKZldByvf5GfWybK9ro96otX+DT7H0AVGNoOZP24CmguLf8/oWwiA6PM=
X-Received: by 2002:a05:6e02:17ce:b0:2cc:8c4:2c78 with SMTP id
 z14-20020a056e0217ce00b002cc08c42c78mr15004066ilu.153.1651188273628; Thu, 28
 Apr 2022 16:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220428041245.GP29107@merlins.org> <CAEzrpqcJLgPqarv_ejmV2aqVkJvythz9sgEeqD+d_TEDeFMwUA@mail.gmail.com>
 <20220428162746.GR29107@merlins.org> <CAEzrpqcL_ZyvenVuO4re9qCS2rLnGbsiz0Wx9zUH_UaZY9uVDA@mail.gmail.com>
 <20220428202205.GT29107@merlins.org> <CAEzrpqfHjAn7X9tMm6jAw8NJiv3vsvYioXj9=cjMqNcXjFhSdA@mail.gmail.com>
 <20220428205716.GU29107@merlins.org> <CAEzrpqduAKibaDJPJ6s7dCAfQHeynwG6zJwgVXVS_Uh=cQq2dw@mail.gmail.com>
 <20220428214241.GW29107@merlins.org> <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
 <20220428222705.GX29107@merlins.org>
In-Reply-To: <20220428222705.GX29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 28 Apr 2022 19:24:22 -0400
Message-ID: <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
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

On Thu, Apr 28, 2022 at 6:27 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Apr 28, 2022 at 05:54:46PM -0400, Josef Bacik wrote:
> > Oooh I'm stupid, I thought the key it was printing out was the extent
> > we needed to delete, but it's the extent in the extent tree.  You cut
> > off the part I need, but that's because I'm printing the leaf when I
> > don't need to.
> >
> > I've fixed the output so it should print out something like
> >
> > [number, 108, number] dumping paths
> >
> > that's what you want to feed into btrfs-corrupt-block, that should
> > delete the problematic item and then we can continue.  Thanks,
>
> inserting block group 15835070464000
> inserting block group 15836144205824
> inserting block group 15837217947648
> inserting block group 15838291689472
> inserting block group 15839365431296
> inserting block group 15840439173120
> inserting block group 15842586656768
> processed 1556480 of 0 possible bytes
> processed 49152 of 0 possible bytesadding a bytenr that overlaps our
> thing, dumping paths for [4088, 108, 0]

Oh huh, we must not have a free space object for this, in that case lets do

./btrfs-corrupt-block -d "4088,108,0" -r 2 /dev/whatever

and then do the init.  Thanks,

Josef
