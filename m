Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601702000F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 06:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgFSEEb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 00:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFSEEa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 00:04:30 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609E8C06174E
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jun 2020 21:04:29 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id a10so2728459uan.8
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jun 2020 21:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ckbjRumNRh0OPFL4xjIwvpPzVBLfGCgG83/w1IMSPVE=;
        b=sHw39Yp9HV95zOg5Dt3VY4pxRcGBVM8Rmsig7BszFbkRv86CffVksAVE7c66k6lyt/
         jVQS9HDM/E0YrJHKH/k7ixuLU7I72gxBmzc/cD+dIbFf1M6BuIN+3Zlp0zlrprKRWAzy
         T9ZVERbN1Vh4gsiM0CPPCYgb1p4qxb9IhpCYb22Da4YT8I8lVL4g3THodvMwCpbeoTrX
         jQQKFKAeZCYXedNgIIre2GlxFMbHYb8kAFYrbb+8QwA9xTIiZW95FeBiVbDm+k35mkWV
         ZUJS3Sq5YrtdgVuZTJVCil4hGCoe2qy3HpAEPDlLH+cASKbmhJhcvMKLT2+VEQaKeunW
         5Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ckbjRumNRh0OPFL4xjIwvpPzVBLfGCgG83/w1IMSPVE=;
        b=V3dsvXzAFIHgD/UuEGI4mPbkvqvOzKSWKnUcTN96TPa9cAACjEx3e4OlyxvQm0D8LX
         B/AFex/XJ06471quiwnz3ZdfTYzGkzw1fH6gCoT2quSJSl9STv3Su5Q3NISYXHK8by5X
         zUrMui2TDzJZqZ8Yciqwtv1KNVVkrCeK4EV+nfTOP0yX21vt540i6qvTo4xoBH+wEHkp
         nN+d+AhgTWgHLTBNpE4wK/myQdGPi+A6c3fhWcitCiy+rT0rIcXdlY5h2uoxwOkpkETW
         bHa5dCgTG6E+gRdlCJ8icV7pXaIG7OmbqcPlnJEoOuQ7PTY8W9E4R3ZeDH1mCqtiLTop
         F+kw==
X-Gm-Message-State: AOAM532BQTsZAz3Y0SqzLNWLiQbqrwZ3EJtfWo7rRZx0QLoKF+9ZNtZg
        LO2XLwX3SdafEDovYXiUXbOJOyY7ergmJcXyU9pqr/vuJsI=
X-Google-Smtp-Source: ABdhPJw6mDVCcXJJ4gor7YDo1iBCEBv6ofDnSobzwxj5vP/mklRezHUm/105J6FSyob6Itkk+arc38TpGfdhdmvh+do=
X-Received: by 2002:ab0:1057:: with SMTP id g23mr1134833uab.117.1592539468519;
 Thu, 18 Jun 2020 21:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
 <20200611112031.GM27795@twin.jikos.cz> <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
 <20200611135244.GP27795@twin.jikos.cz> <CA+UqX+OcP_S6U37BHkGgzyDVNAud5vYOucL_WpNLhfU-T=+Vnw@mail.gmail.com>
 <20200612171315.GW27795@twin.jikos.cz> <CA+UqX+PxF=prEHeS_u_K2ncT1MGqdmFsQeVTkDYLS6PqhJ7ddQ@mail.gmail.com>
 <20200618123418.GV27795@twin.jikos.cz>
In-Reply-To: <20200618123418.GV27795@twin.jikos.cz>
From:   Greed Rong <greedrong@gmail.com>
Date:   Fri, 19 Jun 2020 12:04:16 +0800
Message-ID: <CA+UqX+Ow_FnHse5yNxZ=jntzxmB0dRPYf2wWbeGX21jujUmSgw@mail.gmail.com>
Subject: Re: BTRFS: Transaction aborted (error -24)
To:     dsterba@suse.cz, Greed Rong <greedrong@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have restarted the delete service. And unfortunately it happened again.
I am confuse that:
    1. When will an anon bdev be allocated in btrfs?
    2. When will an anon bdev return to the pool?
    3. Are there any tools to find out how many subvolumes have been
deleted but not committed?

Thanks

On Thu, Jun 18, 2020 at 8:34 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Jun 15, 2020 at 08:50:28PM +0800, Greed Rong wrote:
> > Does that mean about 2^20 subvolumes can be created in one root btrfs?
>
> No, subvolume ids are assigned incrementally, the amount is 2^64 so this
> shouldn't be a problem in practice.
>
> > The snapshot delete service was stopped a few weeks ago. I think this
> > is the reason why the id pool is exhausted.
> > I will try to run it again and see if it works.
>
> The patches to reclaim the anon bdevs faster is small enough to be
> pushed to older stable kernels, so you should be able to use it
> eventually.
>
> As a workaround, you can still delete the old subvolumes to get the
> space back but perhaps at a slower rate and wait until the deleted
> subvolumes are cleaned. That there's no way to get the number of used
> anon bdevs makes it harder unfortunatelly.
