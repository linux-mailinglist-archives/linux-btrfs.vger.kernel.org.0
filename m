Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FDB1CC490
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 22:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEIU2W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 16:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgEIU2V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 May 2020 16:28:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5673EC061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  9 May 2020 13:28:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f134so1549847wmf.1
        for <linux-btrfs@vger.kernel.org>; Sat, 09 May 2020 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IM6FbZSahtriygqgZJn+7mKN+9mno5aPtsDAQwU+m/k=;
        b=V/qYb1lk9dTinaVI77dRl/RzftHX5OlyYadXfA52OIlAW4DQAUhDIFkOFPUtRHsvJ5
         zO6l4bUZ7eP79yzGNG5ohNHckcVbxd3HaAl/v9WEox5j9uho2GFIxzVGKLHEo+V08eNB
         iTkXytsB7l7rjv1O8xTQPQ/O1sl4V0kZJwUxrRHBcGyrgdcUtSVU+B88sBHuoUWH0oqj
         3y9USoW9Og49brk+eTQRXjOAnCUuOsKsqh8bXTpuo2McymlNOV6fXAiTat2JM/WzpOGy
         7pVG1zmFJnduYhARU6jHsX99tuuRZeouJyvSSExToGSaA5fXTptw9hw8Oi3ezjs6xurS
         l7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IM6FbZSahtriygqgZJn+7mKN+9mno5aPtsDAQwU+m/k=;
        b=AGMPBwtnG2yGfJ4MLv2d7lppWArEIN2+IPradUiPxSDvgZCW47L2g46Xl0THkbpAnX
         IJ03qlbFr4/Dwt3OpgWAObgH6pL5Gq5Gl16b/zHT63SPQrClQnO4LPk1/DhEogDwH/lJ
         RwXnSln6ZrPX97sXbSi6wytcGcPD8a6Jj1KWY+UkfYu0q7J/Hr1zNezmlNZxgNQBDpa7
         9Xbii7ZZpchIa6lCDLlCP8DEgotQAcfV95PEIaOhgj2Ykdm7ElijcuHx6rvBKaxg769z
         VYj2CPXg/wsB9b1/gU0Oc+6or44wlKihC24RRO78aV6yOLVWy0CR0uedxYQycdgHbot1
         cEFw==
X-Gm-Message-State: AGi0PuYPhSl0H0x2/C6QyBxEq04FqSVKu6W9drolS5n6wRa9G5Zc9LqM
        fEuQrVtg3K5asNBdCuW3oK+0d8WowAcHYyYsI5WM7WojkkE=
X-Google-Smtp-Source: APiQypJjeHt4C/VjO8qlc7j0DeACasoyX8081qmCtDpTbSL4QgsAYyixo9EpFOaW3NY0KzpxRClka3lVo+e1ZlXAmqU=
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr22601980wmc.124.1589056100000;
 Sat, 09 May 2020 13:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au> <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au> <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au> <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au> <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au> <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au> <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au> <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au> <mu6h7cyw.fsf@gmx.com> <e1bf3b75-9a57-1c53-53f0-85d8c91e6340@sericyb.com.au>
In-Reply-To: <e1bf3b75-9a57-1c53-53f0-85d8c91e6340@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 9 May 2020 14:28:03 -0600
Message-ID: <CAJCQCtSe-QEsJcjkDwhpy+qYhYaxHhWM02z1dqB_LctaR+220Q@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Su Yue <Damenly_Su@gmx.com>, Graham Cobb <g.btrfs@cobb.uk.net>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 9, 2020 at 2:23 AM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> On 9/5/20 6:02 pm, Su Yue wrote:
> > Weird. Any operation was done since the last "interrupted" status?
>
> Just suspending and resuming the system.

OK so you haven't done a scrub from start to finish without a
cancel+suspend+resume?

I just want to be clear exactly when this bug is and isn't reproducible.


-- 
Chris Murphy
