Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046631C2753
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 19:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgEBRxq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 13:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728343AbgEBRxq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 13:53:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB01C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 10:53:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g12so3839968wmh.3
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 10:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjBNuYX1BrX2SEQfqCCfgNlcwCtTbW3FAWXXTaE5/E0=;
        b=MN/Ab6r1t23XPRkPdYy/XtZvXbXgkvJNzQSgaF5TembX2/XgyN58amZfQNjDGPHLZl
         LAVsQTZC3iIwS3kRvpInvR/0NWXDDR5Zwo+B9vrz3hY651BrpSloFMJZJtiWcHyaHeHv
         gNGo8E83JfPRHRWP9QvAvXORKH4VkMmCmOsfNag2O6BbvknY39tou8REQJdZFq8gFo21
         gqlITOdIynInGw5Eg1FiPNJ4FunKmNkaHw7XJE0i6pyJ/T8AfUYA8km5lOqkZ/aqFGbK
         mdKwSBlqdHmugTLyn6mpFBsPVC+ZVtfbS94NW3hs+GCVO/kWh51ff2B+lsvVznFL/X3i
         cmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjBNuYX1BrX2SEQfqCCfgNlcwCtTbW3FAWXXTaE5/E0=;
        b=Kr8bS93inAgs3y4Xu/dpZT/e5jnAQP53IjfhFR+aIPDIFCVmz9cTFNhgTRaTraWCUZ
         S8APavHMmvavX9UWja8RCmkmEzXAeb9Dfb5zOHo8Gt6OmAf2Aj2h4cLY+qsjQE28Nxzs
         EiylA8nvldcbaauueLYHsEnC+X7FrQY8ACLVVv65Lx9RWJL05K7QJ7VXHbDQ/RYDB9dr
         e/YWqowAB026fALIF+SdjfXLaI/DNbe8+o9l1R9q3VrWQWq7NiuY1yQG2gyGjlrzC3LU
         bXMQ9wY1V3ccpA7FdHql6/zv7jxTsSnnpnI8HKS6ywKSz8S+1/CWgXHqr6PS07gGUp5H
         3UbQ==
X-Gm-Message-State: AGi0PuY4YISPsyQShrmvbEneXh6BeBv3JiuXpQeUCtnDcyoOsevsrNbI
        VuA5Tgknc3nUvIfX0xLW/BCa4OtX7AbnhpqMUBkBEg==
X-Google-Smtp-Source: APiQypL6SdFnqkxY9whyO22IyWWU2NLrDwwzNQWMWS5WBv26t0UFhVsJCBG9kkmzIhsXQ7KfApznCO4swcJ1ZcXN6LU=
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr5699775wmc.11.1588442024627;
 Sat, 02 May 2020 10:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
 <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
 <CAJCQCtT0mSYvN7FeCavsmKP9j_69JmZ0JdGz8ommhqag=GiM=Q@mail.gmail.com>
 <NmjvBWGDb0a1ZnPep0UnBmeFG4uSUMrxyiYDCir6RRsMyZzizVtCH_8tdd6Y_glmPbbusrKtVBCgGvV7Cc5UFCDqcvJ1PTgWi87x-0FacQ4=@protonmail.com>
 <CAJCQCtRWdovSOQd8r7YzxsQa4fxT9feB_R-nvG7BjvB-u1m2ew@mail.gmail.com>
 <XzvzKWYVgWGlgX7GSa5XGfQcMuM4od6BMpG63kC2X3thsAfl0i__swcKuMF3TcdiInqnifyiphevLoacMdYlEn7YDqj8JDLKFaZRZsoQx1Q=@protonmail.com>
 <CAJCQCtQ=hwE-wwPXEw_r+VOe36zsHYmpx7updj4JOMmQqQeM8w@mail.gmail.com>
 <ZL8K9EyQa7EnOmd3WjfSsNFy8hYbikAq4lO6CTK1vc-HoXoqpY9CKKcYd2xFCwEDvry2aLuZvbwK91-2_J-Zu6tDL6sovvr4jRIATnhmyMQ=@protonmail.com>
 <DQCllnVeUApb40W6_xKaNlAxRJlhCTeYnZEP5r3dZvF0AZejwemvJK-CWfNtV56zb5-LZaPuH-4WgD_-SxDeE2b_TYCRDeTo-2aN4atItbY=@protonmail.com>
In-Reply-To: <DQCllnVeUApb40W6_xKaNlAxRJlhCTeYnZEP5r3dZvF0AZejwemvJK-CWfNtV56zb5-LZaPuH-4WgD_-SxDeE2b_TYCRDeTo-2aN4atItbY=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 2 May 2020 11:53:28 -0600
Message-ID: <CAJCQCtTjWc=Z4mE604Pfc1tKbWcrJNT6qmPB=HVmM4N8MhFW3g@mail.gmail.com>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read
 block groups
To:     Nouts <nouts@protonmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 2, 2020 at 9:51 AM Nouts <nouts@protonmail.com> wrote:
>
> Well, I changed my mind. I'll wait a few more days, for the beginning of the next week, if you have any magical command left :)
> I'm not sure to understand it but can a "restore" command dump all of the data in a new readable disc ?

Yes, that's the only way it works. It's an offline scraping tool. It
is possible for recovered files to be corrupt, the point of the tool
is to improve the chance of recovery. So it doesn't have the same
safeguards that Btrfs has, where EIO happens upon corruption being
detected.

https://btrfs.wiki.kernel.org/index.php/Restore


-- 
Chris Murphy
