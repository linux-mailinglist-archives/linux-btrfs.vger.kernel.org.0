Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162C045326
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 05:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfFNDzS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 23:55:18 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52443 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFNDzS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 23:55:18 -0400
Received: by mail-wm1-f52.google.com with SMTP id s3so806536wms.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2019 20:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjCH91tUMtumOd/elvBghAm7+kHoBDmq/6nZAoQbWdQ=;
        b=KKPlnk2Pi6Wcm44bRM6poJq2orDDgySsvg8vMXe5mo0SKLXXKPlQU+pcuGI0J6EtZi
         XTIZgKcmFf4yTw4d9apJyjpDHL3xGRO1dsntefYMaai5il6QPRE2+BOgmFpOs659mkCZ
         cRZt9lQnHsrmJrTW+XeJv5qX3+a0YzIK+TsMiHnX+EaxFLD8yoqwQLXuBB/dhC9ePrVc
         zkdJWJHUQ/Y1H5aJO+a8N2H9pDeVSwsffnFz0LyGFgPemIHC69+T7xgIvMbNSMGSbClR
         vFuMhaAZsmJSKcD8hwtkBBvBXukZuuOTNVTr/stgmO6b3EogYvqyy7Wnj8E05yBY/64d
         RZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjCH91tUMtumOd/elvBghAm7+kHoBDmq/6nZAoQbWdQ=;
        b=JuHNiEOS94A77BLpckdd7ZXpCLtPR1soR14m5ZQlROdT8L2JQ0hi706q5GR2FycBCN
         UVr0mtdMKWehwVVy5yg9jQ2ESzj6FDCTuK/sWjMR0lX4+zHXkJHXglPwE92dXR1nGzGE
         UxaL8U0EY0gf0XrcS145p4ZmAUjd6IdpCHdWYFf/PxB2SCiinvBsUGobsmooyjKZvIHi
         80plDGPZkAN3n1BxR7oErkAb49qpB+5E5K+cxxrASoyFwAIPu3RAgB1ZqX+THkJJrYIM
         oyzargTjddOziQEkyIKfEzcVY19yi+wnJfmlnJ0R+f37ziBTUZ4AJS41fKYa3a8TOM2I
         FQaA==
X-Gm-Message-State: APjAAAVUpAjHDeHgvvOevMWRfrR7Kv2DQvjXOcO13zB6YtcVaK4RSVqX
        Y3/u6W307nMB2iiXfbHu1KrFZqkQCAhsuAvOPT+cCw==
X-Google-Smtp-Source: APXvYqz55DU6LniYJykPy8IHf1fLl4MyibZ4bjbUv6rteXdZbPUzhHDTjgAWaCU/oM4wXoh1dnh0n12mDLRp5/o/Kig=
X-Received: by 2002:a1c:b684:: with SMTP id g126mr5852825wmf.176.1560484516019;
 Thu, 13 Jun 2019 20:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
 <2331470.mWhmLaHhuV@supermario.mushroomkingdom> <b2bba48e-a759-cb99-cf2c-04e89bce171e@gmail.com>
 <97541737.v72oTHCfnW@supermario.mushroomkingdom>
In-Reply-To: <97541737.v72oTHCfnW@supermario.mushroomkingdom>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 13 Jun 2019 21:55:05 -0600
Message-ID: <CAJCQCtRfADiHjG+r-1Gr=1bFw+c-u8-zi+bkLCO=jd5HnxjFDQ@mail.gmail.com>
Subject: Re: Issues with btrfs send/receive with parents
To:     Eric Mesa <eric@ericmesa.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 13, 2019 at 3:23 PM Eric Mesa <eric@ericmesa.com> wrote:
>
> On Thursday, June 13, 2019 2:26:10 AM EDT Andrei Borzenkov wrote:
> >
> > All your snapshots on source have the same received_uuid (I have no idea
> > how is it possible). If received_uuid exists, it is sent to destination
> > instead of subvolume UUID to identify matching snapshot. All your backup
> > sbapshots on destination also have the same received_uuid which is
> > matched against (received_)UUID of source subvolume. In this case
> > receive command takes the first found subvolume (probably the most
> > recent, i.e. with the smallest generation number). So you send
> > differential stream against one subvolume and this stream is applied to
> > another subvolume which explains the error.
>
> Yup. Any idea of how to fix?

Maybe 'cp -a --relink' into a new subvolume on the source. It won't
complete immediately like a snapshot. But it'll complete way faster
than a normal data copy. From that point, this new subvolume becomes
"master" where all changes occur, and all the other snapshots are made
from it.

Also, you should do incrementals between the most recent two
snapshots. i.e. the snapshot that follows -p should be the snapshot
most recently successfully received on the destination. That
represents the least amount of increment needed to update the
destination. It will work the way you're doing it now, with -p being
an older snapshot, but you're unnecessarily sending a lot more data
every time.


-- 
Chris Murphy
