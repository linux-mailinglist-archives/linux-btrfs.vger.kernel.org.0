Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C970433E62
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 20:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhJSS33 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 14:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhJSS32 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 14:29:28 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DF2C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 11:27:15 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q189so6090553ybq.1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoYmwbnfurnllDQrzqgWQ6leNWBhh0pa/4fIwROpoCY=;
        b=1i8MJ9MU0NwYyc9gvizeRUhKpCGAzcdXUebYLuo4WNrGbwuNu9v1GDPZjIEB0qvHwc
         ZPmLSrh+WlCtc/L/ivYTKRR3YikCB4hFYIPRWRDukUlQippzAeGRKn7nsE9JZuh0y5G0
         RMbr9y2qmilxV117P7V3Buyqz3NMl9nS5k1h7csoXYJw6EjFSEbWI3/NfGDUg402QXvM
         GKUtVc4dxDtRLK5X3I+lsDXoSPy0HQke3hvR9YwYONZ8tA8hiqSJyjVxNM4BRPBGvAq7
         NYbXkrvIujY4F7vpop7jO8jkI/N4K+/d48A6KZttdIC8GL3zJzFq1TFhE53fEUNM+pi/
         Z8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoYmwbnfurnllDQrzqgWQ6leNWBhh0pa/4fIwROpoCY=;
        b=HBO5iZhCyuyItxWFOC/Gh8rRWymGB9munT54BGynJ72qgbMWQVuh7hx05lHSOuEcj9
         Tzf376sAf/eaT3lG1ivlRQgHYeQQeC9YLGl7lPPhmJm/VytHeo1dEykWMDTspG1iaS3k
         xsExzkEKXYGcPxQsUVeWCgNsjjxJhKG/w6tg2Ro/Rzpipo1Wj29Db9w+8TKbnLsXne1J
         VSO9NU2GkH4aqwRe+4+JyAmX2WsEHZwBZy9FfHwjOLoPIeocZOJr9ieakUvMFMWMeYVH
         bWdFwynrZqiVsw6L3br7Vg8qqkaauz9vrnLbuylp5Xmk76Q+EqK0v48MnI0GuMmD/tDC
         DDFg==
X-Gm-Message-State: AOAM531H7j4LMC6vvj6mh/nnfTli9HhN5DrrYj7JWD/PPNNW0QhTkcoz
        duia2Flosr3p7BlYSrTqRihlQD7E4vMOfbRhPZ0y2pzLjVERmP1ssB8=
X-Google-Smtp-Source: ABdhPJxXQt/IcP18POuuQgmxr0xXWCEmFw5m8OtalxtwFzdYRJE+5Lpbc8QHMfUlU/Y5QYm65EsWrcBemg0h/g6nyog=
X-Received: by 2002:a25:780e:: with SMTP id t14mr2775178ybc.470.1634668034970;
 Tue, 19 Oct 2021 11:27:14 -0700 (PDT)
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
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com> <7de9iylb.fsf@damenly.su>
In-Reply-To: <7de9iylb.fsf@damenly.su>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 19 Oct 2021 14:26:58 -0400
Message-ID: <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Su Yue <l@damenly.su>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Still working on the kernel core dump and should have something soon
(I blew up the VM and had to start over); should I run the 'crash'
command on it afterward? Or upload the dump file to e.g. google drive?

Also, I came across this ext4 issue happening on aarch64 (openstack
too), but I have no idea if it's related. And if so, whether it means
there's a common problem outside of btrfs?
https://github.com/coreos/fedora-coreos-tracker/issues/965

I mentioned this bug report up thread:
https://bugzilla.redhat.com/show_bug.cgi?id=1949334
but to summarize: it has the same btrfs call trace we've been looking
at in this email thread, but it's NOT on openstack, but actual
hardware (amberwing).



--
Chris Murphy
