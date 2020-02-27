Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6F170D75
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 01:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgB0ArW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 19:47:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39956 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgB0ArW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 19:47:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id r17so1168399wrj.7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 16:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ir3nFId8X4nGE3DC65SYCT1SO9SyR7sSUMERsIscc8=;
        b=WSZQKk0OdJRJLkRlxOH9aT28ybZ4FMkb0sz9R3K0uPOrmjRzIXOTkPoLEt+WRIrT3M
         eQX2asVudGPWHrGdHNtEMf67EBVwlMyzNoLiC4Yop3sUxyFxsKY/ofooPvXm33LteZ1U
         yiqNe9XCFXjHnhIzUvltYjf9Ouq4syVuFVGUEO3pC2HGcGIbb/4Tu4f7akHxUBcP93TH
         r5CWuaOfZFz6rHG6vtPu3wy9zFM9QHXT0rDJSmo5Ax76g0p/qy04F//jqp8yqlgsjkso
         3+dA5izq+bQcvhMeRCZgXGMi2RY/3QEWE+oqYHObzXc/TzkwjAfxTrTLiVhTnBGoPxHe
         BVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ir3nFId8X4nGE3DC65SYCT1SO9SyR7sSUMERsIscc8=;
        b=m1dQNelbytWZuYsQp4OwBRNaGRW5lcfECQYFCPT+rWpNlaUqTqzES09xIO3rjSTNJW
         2AW9l/UFSvqpPkVGV3WLYlHT01WKNs2O5AG8FuW2Ijg4orCIF6lxnFx+a8GFc/meunMW
         f6jdc7QTiCkyJpO1QKR5yMEQ/PJwSkxaJRFnl17Y3xTzln2cfq5uavjAt4aIIOcpb46R
         w7ocK9owUkjA223I4/JlmyqYSz76o1vcVA4+TSxNvlTBsSlS7GI5kK/AwSWP/rGf72PX
         dhgD0G0qVL26pypF8jRxSX0/1jGsjO2lyhGSgBRIeVobsVHKLOTgLPs+CM6P9G+H8IH1
         4ddw==
X-Gm-Message-State: APjAAAUzxWkExTJc1U/x1GKyh3PKUsVszkDLqS5JfflLaAyBJ1Ww1+ek
        CZDCzFmPP/9Nn3TbNgAtcJYo3Qt3ajnWgw1J2NoJqCcFCVM=
X-Google-Smtp-Source: APXvYqwA1g6Mxbjh1FRNlb1G92btja3kTY5G552GG9YPZ27Nujq9k0huYhTBmVzAXV/pFFvhpvPY8Jnp8u2dN3qbg4I=
X-Received: by 2002:a5d:4dce:: with SMTP id f14mr1338615wru.65.1582764440334;
 Wed, 26 Feb 2020 16:47:20 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com> <CAJCQCtTYBOUDmWBAA4BAenkyZS6uY+f6Ao33uHMmr_16M_1Buw@mail.gmail.com>
In-Reply-To: <CAJCQCtTYBOUDmWBAA4BAenkyZS6uY+f6Ao33uHMmr_16M_1Buw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Feb 2020 17:47:04 -0700
Message-ID: <CAJCQCtRjsfMiFRvz8rO1-VEUcNwU68Ah7FOGsRz_bmPwav9qtA@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Steven Fosdick <stevenfosdick@gmail.com>,
        Jonathan H <pythonnut@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 26, 2020 at 5:39 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> > Feb 10 19:38:36 meije kernel: BTRFS info (device sda): disk added /dev/sdb
> > Feb 10 19:39:18 meije kernel: BTRFS info (device sda): relocating
> > block group 10045992468480 flags data|raid5
> > Feb 10 19:39:27 meije kernel: BTRFS info (device sda): found 19 extents
> > Feb 10 19:39:34 meije kernel: BTRFS info (device sda): found 19 extents
> > Feb 10 19:39:39 meije kernel: BTRFS info (device sda): clearing
> > incompat feature flag for RAID56 (0x80)
> > Feb 10 19:39:39 meije kernel: BTRFS info (device sda): relocating
> > block group 10043844984832 flags data|raid5
>
> I'm not sure what's going on here. This is a raid6 volume and raid56
> flag is being cleared? That's unexpected and I dn't know why you have
> raid5 block groups on a raid6 array.


OK part of my confusion is that you sorta threadjacked, while still
being on topic, and didn't realize you weren't the original poster. So
you started out with a raid5 from the get go. Original poster had a
raid6.

I still don't know why you're getting messages:

clearing incompat feature flag for RAID56 (0x80)

I think that's confusing if you haven't asked for a conversion from
raid5 to a non-raid56 profile.



-- 
Chris Murphy
