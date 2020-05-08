Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24F01CA1BA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 05:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgEHDzj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 23:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgEHDzj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 May 2020 23:55:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110AC05BD43
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 20:55:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s8so207239wrt.9
        for <linux-btrfs@vger.kernel.org>; Thu, 07 May 2020 20:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aV7cU1Ej0eEVUbcMjz+/HM8ot/gPSCtIGRQdoyCk/DE=;
        b=d0hVYMoLATv5TpbAE9f9f7a9juUEPhY3jSvbVJ22DwboxBhF7f+TCU3RM6H867C0Gt
         /8Kk9WImSvHv5Puat1a8RPOJsZ7qz/w6boPEtR7M4l/TK3bb7px2N3AkC8LaWEq4ET6P
         rMwBJJIcLL5d6uks+l6Hvus7BP7G/L5m+cO72pI2BSK14cnB0eBf/mLK6xMJuCgD8ftT
         LwlD1kt7CsgEXdwZR0m2niAWCFY7cHADHXosfKDIXkTQ4KSlC59H8uEPbLKcGGzUge0F
         pyYcANZKwF1/p06A0h6YP2QQbsZN0UFLDmlAh5vxraLJWgLWfw5eOfm2w05CSzow1nQQ
         4AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aV7cU1Ej0eEVUbcMjz+/HM8ot/gPSCtIGRQdoyCk/DE=;
        b=bGYI5kBguz7HKQvH5i6Ew9zHaJRKzwFU/9FspHkg21WR/JcIauOePryc6V0wqbouE5
         MnMmgjr99IdjHN9wpkync99H24xZbY803eSj+A+pKnMkcZZRud9uvpWd3kiARzzRgiwH
         r0k32qFpkFXXmpD8ggs8EjyTS3yYfSukP4AGR7TcFbXsRGS+jYCP1EtAzANWoVUGeg1I
         4igKvZNINSw0ys9IpsrhVpV7q8uoLfShANo+i04zkX68jRuRBW5+XxHGvKL5jsEbeDTy
         yWTHa0FThWiOgITrXZl6tu89HIhrs35EepovyM/CBFAbRJDr6UiLzY7eVaUoCMOdvf/f
         NnNg==
X-Gm-Message-State: AGi0PualOQWKNpqBnCt+Ux6AMdqpJ0qb6+vdq7XsXQenQecRmr/kwg6m
        jzcB2WoejI4qm7RoHzRa71h4p+sOXGHqRUALTBmeul+TmF+NhQ==
X-Google-Smtp-Source: APiQypIfi+e78RJvyz8Fos49K5BOXaX9FNxgBH2gg1cw9ziUW2K9vjjxaMQ/XSYyD5luv0oXl/p6ynJCvdBinj0eF2I=
X-Received: by 2002:a5d:5346:: with SMTP id t6mr432727wrv.274.1588910134942;
 Thu, 07 May 2020 20:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net> <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
 <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com>
 <9b763f5f-3e42-c26d-296c-e7a7d9cde036@sericyb.com.au> <CAJCQCtTorye5PTcH6crVYES4eAwVphhx3Au6xd7tijef1HU8uA@mail.gmail.com>
 <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com>
 <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au> <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au> <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au>
In-Reply-To: <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 7 May 2020 21:55:18 -0600
Message-ID: <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 7, 2020 at 8:54 PM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> On 8/5/20 12:48 pm, Chris Murphy wrote:
> >> Rate:             112.16MiB/s
> >> Rate:             111.88MiB/s
> >
> > These are hard drives? Those are reasonable rates. It's typical for
> > drives to differ ~50% from outer most to inner most tracks. Depending
> > on the chunk layout and progress, the rate may vary, including between
> > drives.
>
> It's not the rate I'm concerned about - it's that the "Bytes scrubbed"
> barely increases, the "Time left" doesn't decrease, and the "ETA"
> recedes ever further into the future.

OK what's the current output from
$ sudo btrfs scrub status -d /home

21 hours ago, the report was that it'd take 9 hours to scrub.


-- 
Chris Murphy
