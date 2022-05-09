Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABFF51F24A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 03:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiEIBac (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 May 2022 21:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiEIA0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 May 2022 20:26:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296512673
        for <linux-btrfs@vger.kernel.org>; Sun,  8 May 2022 17:22:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z26so13718082iot.8
        for <linux-btrfs@vger.kernel.org>; Sun, 08 May 2022 17:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9Zbk/ZFfu+K5Y3/26OG73RgJYYbTiAn1TqKVvCBAc4=;
        b=sMuvQLNS02y2Hj0i57GcIyg9VYcOY9L4V029Rhuv7Xz6Lg5UdqveKDyZs9wumjFmMk
         SnXqCooCtOAAXcpvz/1VsEXqWpyR1Q9cSXtNiPPANAWNHMhRc7E6RpuvvRIuaGjLkS/y
         GOdYM1bEx30rEgOtKXdmSyYmr9+I9boFg4Y5rN38jp2PYktRtQ1jQzWfBoEXsBnwu/M/
         7goVW8hTqaSVOP/o0KTodLIxO3+l2f70NtZYK2i84i/YhYtnm0OabzwQ+R64PMuGnAs+
         i+eCteEP3EnbkMdAOPIsdMcBPpY+1g47BhoGrQPC5gv8VSq1LHXOfEvZI0BNRPsY+V0T
         2RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9Zbk/ZFfu+K5Y3/26OG73RgJYYbTiAn1TqKVvCBAc4=;
        b=hCZDyvuLd6j+Ymf62aUuv2T7UuS2AnVZbqSNJCU7zZD79c6uAjLQv8TZY3LcM2m8yt
         CxA3KFvrpF98r//nLZW0U/nGmO+ygWO1+6TGtEIDdJ6y244aLM1UhxW1ET/B1dcx6K3U
         hNOl1pL6gPJ7oDsp2cdVDdCr8D/DG1V0ZRYhGh2z1BwyThT0JGjQPSLcJHx+5k1Utenh
         b2mK3Mnl/ZuouavIzO9oMYITVQkn5pMSMrLoiNPR5wla9eXA5aVFibrAp/3Tvc3K676s
         n7xII4SzaLZHKe12vHctNqwOEn3RudBVYgZcGcsOOPkSPpccEyADcLBsSJREGHwNFTkt
         SUnw==
X-Gm-Message-State: AOAM533hpz95z066/x63lAw8/koxtTuPcmYB5BU/h/4om9D4h15XGDYA
        J+ffrtNJ5CdyrkjRiwqnIA73/S2SOJw9rAVazlGobYbTquI=
X-Google-Smtp-Source: ABdhPJw6eTEQsZQQFzRy3jwqMH0NdDhGfuDPd7hSgi26cxT7MxpBJXazmw97hlf/dHY/LA2qKX5ArVmzEaXVH5WkPRQ=
X-Received: by 2002:a05:6602:1545:b0:65a:c88e:4dfc with SMTP id
 h5-20020a056602154500b0065ac88e4dfcmr4426717iow.134.1652055750528; Sun, 08
 May 2022 17:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfHzZrMuWrMERM-m4ASsuJAsijU9tpk_e5OML8dpgMeKg@mail.gmail.com>
 <CAEzrpqdzdimQvXyhpDomvPgDXx5Dn9QCEKQMiXofTFb3WvWUJQ@mail.gmail.com>
 <20220507153921.GG1020265@merlins.org> <CAEzrpqcRT6CqJJPYqW5AH+x0XvUCMd-EMEq-=SwtTL-Fn4pcvQ@mail.gmail.com>
 <20220507193628.GO12542@merlins.org> <20220508194557.GP12542@merlins.org>
 <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
 <20220508205224.GQ12542@merlins.org> <20220508212050.GR12542@merlins.org>
 <CAEzrpqdMFJ2cm0URWqwFehkQQzmrgYO+CdoibSUqqfN1hkGOvQ@mail.gmail.com> <20220508221444.GS12542@merlins.org>
In-Reply-To: <20220508221444.GS12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 8 May 2022 20:22:19 -0400
Message-ID: <CAEzrpqe=qUMdC-8UTeuSy7niO9i8PhFGa6auMmQk_ave30gKUw@mail.gmail.com>
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

On Sun, May 8, 2022 at 6:14 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 08, 2022 at 05:49:17PM -0400, Josef Bacik wrote:
> > Yeah this is the divide by 0, the error you posted earlier is likely
> > because of the code refactor I did to make the delete thing work.
> > I've added some more debugging to see if we're not deleting this
> > problem bytenr during the search for bad extents.  Thanks,
>

Ooooh right this is the other problem, overlapping extents.  This is
going to be trickier to work out, I'll start writing it up, but I want
to make it automatic as well, so probably won't have anything until
the morning.  Thanks,

Josef
