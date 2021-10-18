Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9C7432029
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhJROv4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhJROvz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 10:51:55 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700FCC06161C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 07:49:44 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id q189so3524498ybq.1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyyPwR+pIsltN/H9fMrF/aavJhTvUWVFS1oJkuPfGsk=;
        b=NXaqgbs+lb9g39Hwj6BTWTiNqMymSEHMcDmcOeIxaHGPZFDmxmLqELf6q3Znsl78by
         NZCvmJUHUyIfTLhKTchM4iVAWPSkR/4R+F/QOIhJnSmg+EdBKIeKZG+D1K1INl1Dyrd/
         m5wkBCecXwiPOY2dVZo0vzF2AeklQYk7MF2cxqfWKUZJLAOJ7GTSltEZjVbdu3Y8/Hs4
         G22UKrutWUSw9/bdmYbCpNA/7sOzQX4cA0xmzPTdXpVKXzNws1ujKWm6Z7nod0g5K8Wu
         +019rH5CeneiD11jhq/fCKZkRfLiqaqPfjMPD6sGmipp8fAphdVbzFrDQfGgtGOQEPgz
         H+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyyPwR+pIsltN/H9fMrF/aavJhTvUWVFS1oJkuPfGsk=;
        b=Lv+2bkGUW9g4lMQf0EpeohmsHAhInDivo0+I3HNqrBp0K9j6pNQT3oNEt73QF6haaS
         G6zid6r7MFLhV7ZbF3cYqBKFQNuQeXt4CD9+7sV21B9QfwBPpXIfqTaL5bAd6kJYp7Ln
         nggHLz1dVTYa+7Uu9hmyUiafEFp5iG8bfhyhxgaeGjF1dPFuYWpAzKbWGDLiB1TqeMzW
         4cU6bkCg4Kdsam/EoatcWCKobIfqW3mXki4uXHuDjCOL4+Z5Gjx1+TeQJBQy8jJLpVlO
         t8C3tPO/CQ/lT8B3UFfyEyVWBruQ0G6uHST9SGJe+4ILygJuorIrMnvcJWmklrmyX/Be
         KWZQ==
X-Gm-Message-State: AOAM531B6HmVkAYQM/yReLcACX0Bp27QewSa5oO2C/fNHNF9KdwRBynC
        ArLnjv78TBzwD9TtaAzgk/kqv3P5tvmUtDzWx0DYZA==
X-Google-Smtp-Source: ABdhPJxlXLL60yEXWyr16HnUVmbi2HCbUJf5Pj6zJbOaHNvTRvlG8r5erWwTi8FcFrY/q8PBqXd25PO4ord3RsFIgAM=
X-Received: by 2002:a25:db91:: with SMTP id g139mr28899870ybf.391.1634568583554;
 Mon, 18 Oct 2021 07:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com> <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com> <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com> <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
In-Reply-To: <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 18 Oct 2021 10:49:27 -0400
Message-ID: <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Chris Murphy <lists@colorremedies.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 18, 2021 at 9:28 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/10/18 19:32, Su Yue wrote:
> >
> > On Sun 17 Oct 2021 at 21:57, Chris Murphy <lists@colorremedies.com> wrote:
> >
> >> Any update on this problem and whether+what more info is needed?
> >>
> > It's interesting the OOPS only happens in openstack environment.
>
> Or the toolchain?

In the earliest known instance so far, from April 2021, it was this kernel:

Apr 13 20:47:35 fedora kernel: Linux version 5.11.12-300.fc34.aarch64
(mockbuild@buildvm-a64-10.iad2.fedoraproject.org) (gcc (GCC) 11.0.1
20210324 (Red Hat 11.0.1-0), GNU ld version 2.35.1-41.fc34) #1 SMP Wed
Apr 7 16:12:21 UTC 2021

> > Is it possiable to provide the kernel core dump?

I'll look into it.

-- 
Chris Murphy
