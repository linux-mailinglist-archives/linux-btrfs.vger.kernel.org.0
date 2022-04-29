Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CD75154D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380381AbiD2To2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 15:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347079AbiD2To1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 15:44:27 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DED922B13
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 12:41:05 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f4so10846767iov.2
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 12:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TaWCVFZTHB9BPPQe+Y4RRbkypKaU05IfjlyRy7ChGpI=;
        b=CEm69dudqMUtmmUfRRQoWJntVPVlBwnCN8VnvJPJCI1LYnk00e45o6u6jhAPTZuOIq
         XovCZZFSHwQQftHQX4imGrRtIjgLU1k2CIbtmPebMTL8eSQfdWzBr9qoGJ5rtIJxDQoE
         p+9kYwZQRd+ANjlLe8jK9tgmpxE0TXjhYZQyKoYpUecystihiRZ0kT4JLyV0z8fywz/1
         ao4o10cmwnfhGX79o7HPRb7HDlocNPP/QtsUCpOQaS55LCVj4lBv06L6bqD0dkvmzuPm
         fTk1p6P46rzI699NYzuWYwew1OB56R5j7CAPwLWXQMKfsSsJimadYY6mmj5XDD5cdW5N
         1lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TaWCVFZTHB9BPPQe+Y4RRbkypKaU05IfjlyRy7ChGpI=;
        b=YMgf4lK7EYLWITvdXRTzfWtHr4/eZckcGfQdrr8O1fy9DUGUsFGUoiBEQNkgz9VrFy
         hpUXPkNd5kaTeARl47SY1FCx6Rkv6WFgvzw7lUJAtASYABagxMoOw6RHxvhdKuO4VZpB
         3g8hGS2dByzit8MRCuh/HnslXx4gSffNnwohCg2QoUOFUQz5ZtN+6FrhT6lKwkWrCKGy
         HVLSrInOVSZJUjEKRiW3oljeV9oyBarjQr6YdFMbYcqTdhWRdU4/GK39uVsrLQkufYYK
         yfY5Okk7zN61GgGD3iiRF6OwHauvXNcgZYlFfxDmFMlEWRAnoNb6AR41TBF7RDI5OhZD
         I1KA==
X-Gm-Message-State: AOAM532ENqD+pCjDfOg1PDRoGBbSDDzTtybmkZt1Wip9HllN4A6IWhkF
        tQ500OT2WBA8poKpkrujCDB7SJkTcG6NdDb6pmKpcsZgBGE=
X-Google-Smtp-Source: ABdhPJwC/zXV7w8y5GI3/wWF1ygLHWOuf3IeHJcH6FEgdxM+GfryLNEdVNTahljf756CgR1PVj1nN9cDiWlfhtearQ0=
X-Received: by 2002:a05:6602:29ca:b0:649:558a:f003 with SMTP id
 z10-20020a05660229ca00b00649558af003mr398929ioq.160.1651261264536; Fri, 29
 Apr 2022 12:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220429005624.GY29107@merlins.org> <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
 <20220429013409.GD12542@merlins.org> <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
 <20220429040335.GE12542@merlins.org> <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
 <20220429151653.GF12542@merlins.org> <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
 <20220429171619.GG12542@merlins.org> <CAEzrpqdTzbpUZR-+UV1_fx9p_pq188cQbGOqraHP=2Vpdi89Mw@mail.gmail.com>
 <20220429185839.GZ29107@merlins.org>
In-Reply-To: <20220429185839.GZ29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 29 Apr 2022 15:40:53 -0400
Message-ID: <CAEzrpqdpTXvDCmo-7H6QU1BKXM+fcG6ZdfHzQj0+=+7kcgkuOw@mail.gmail.com>
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

On Fri, Apr 29, 2022 at 2:58 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, Apr 29, 2022 at 01:52:13PM -0400, Josef Bacik wrote:
> > It did, now we're on a different root, you can do
> >
> > btrfs-corrupt-block -d "76300,108,0" -r 161197 <device>
>
> So, it looks like this is going to be long manual process, I went through iterations and
> keep getting new roots. When I clear one, it goes to the next.
> Any way to automate this?
>

I'm afraid it'll be longer/less safe for me to work out the kinks than
to continue manually removing stuff.  If you have to do it say 10 more
times let me know and I can try and rig up something that can dump
root ids that you can just feed into btrfs-corrupt-block to clear
everything out at once.  Thanks,

Josef
