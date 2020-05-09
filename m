Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7E1CC4C5
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 23:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgEIVql (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 17:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgEIVqk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 May 2020 17:46:40 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73829C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  9 May 2020 14:46:40 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id i16so2967833ybq.9
        for <linux-btrfs@vger.kernel.org>; Sat, 09 May 2020 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cl4p9F7SQnwxo5GotGgSTOIgscAX+sTfdVaI45M5BGM=;
        b=Qo8BIomNvogjgk7F41sRMq8MlffT2lSvBdsYUmKkWWiIdRWowe8d/SshK32YASXQmy
         Vy9tmk6LhyNT00ID19AhQ8hsK7vVdnWD3IeLYBO54qe8aG/KOxpRdkEy6082i0UM1+k4
         2rq7btWuBx0tOd9jA/nMztcv4QGJOIVO3R+qnzYFDlb+U4qz7zVuri4xOY3ilubOOXaS
         fTrTE6kvg9UjPOUSPj7zjpENDVJPE5u+vKBeahEYHGpwjMFOemFlVmqZU3fz1fTVvHQz
         oO8bIWoJ14OEP+gukJ0bAXbDkAjcNdujLZtlVnH4I95uMFle2JCOE+jwFPBj/S2pEi+L
         n5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cl4p9F7SQnwxo5GotGgSTOIgscAX+sTfdVaI45M5BGM=;
        b=EETqNVSXf0g8IFHZA/SaKagBeFkiy3ZBolqoTJx3AIwFvZONKN6TlmgZ4T7F3um3ue
         mUWE7w7fSrsDN0RtWZnFRE1K+yVBg+sBFysqmWU92OrUfEP4rg4YjpnoM9GDQ+L33pmM
         n12a9hp81D+hNmA6t/4i2oj7VNwU3JUKfGHOL3v5wuDN16WLmyLNNyeMBBdjcdEmUpha
         gkBxQ1DQFiMMBXbqqObtaCyB5zH7JDvIu7E+ste4Fj3dz+4jA7tw7OwALXO0Orz9VgsH
         yz+c72tVqfjoGGNc8KGxrojS0oKTGdMIRD/9LtSlRkYjxg1k0QFfK2kjVveEg2I32fE2
         X9FQ==
X-Gm-Message-State: AGi0PuZHWQ871ERP78yxX42UslqBh1XkaJ2CkkIXs1LlCiKey09TB/1Y
        UoSAlnv0Ey/7PWJBrkiAaFJNUq+uUylyebwa/AoTEiI0
X-Google-Smtp-Source: APiQypL1JQegQj7UnbgGEiCwUwJNXSxL2EZXxTun63anzGMgtyNFgjYAukvl9RybwpVIRhp0PPYYgfk1QTV3ccpTWms=
X-Received: by 2002:a25:9848:: with SMTP id k8mr14305345ybo.102.1589060799205;
 Sat, 09 May 2020 14:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org> <f7ae0b64-048d-3898-6e2d-5702e2f79f47@ka9q.net>
In-Reply-To: <f7ae0b64-048d-3898-6e2d-5702e2f79f47@ka9q.net>
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Sat, 9 May 2020 22:46:27 +0100
Message-ID: <CAG_8rEcdEK4XAx4D3Xg=O38zfs85YNk-xhT_cVtqZybnKXBkQg@mail.gmail.com>
Subject: Re: Western Digital Red's SMR and btrfs?
To:     Phil Karn <karn@ka9q.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Rich Rauenzahn <rrauenza@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 9 May 2020 at 22:02, Phil Karn <karn@ka9q.net> wrote:
> My understanding is that large sequential writes can go directly to the
> SMR areas, which is an argument for a more conventional RAID array. How
> hard does btrfs try to do large sequential writes?

Ok, so I had not heard of SMR before it was mentioned here and
immediate read the links.  It did occur to me that large sequential
writes could, in theory, go straight to SMR zones but it also occurred
to be that it isn't completely straight forward.

1. If the drive firmware is not declaring that the drive uses SMR, and
therefore the host doesn't send a specific command to begin a
sequential write, how many sectors in a row does the drive wait to
receive before conclusion this is a large sequential operation?

2. What happens if the sequential operation does not begin a the start
of an SMR zone?

The only thing that would make it easy is if the drive had a
battery-backed RAM cache at least as big as an SMR zone, ideally about
twice as big, so it could accumulate the data for one zone and then
start writing that while accepting data for the next.  As I have no
idea how big these zones are I have no idea how feasible that is.
