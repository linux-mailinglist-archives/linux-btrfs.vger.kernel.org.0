Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A186AC240
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 23:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404805AbfIFV41 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Sep 2019 17:56:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37191 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404615AbfIFV40 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Sep 2019 17:56:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so7422389wro.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Sep 2019 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sfmAhjDDvKglfpukNd4+2Xk4zEwbSmYlXycBa4UscY=;
        b=0Jaqh6Mzjiw8xinY7VlDEoe4Iix/bXwL5ZT2xPijz31oliYuEVFQFUKA5B+K8aEQfK
         C0TiIBhnProreretQaOlvdDJWN7IxzHfGdiy0apFEh1HmnlHPrJ4YKKkW3g+SJJx6uwF
         9W6mGYxc13fTj4ymjn8S3M62NH0rLXJ5xFyhxlIuCc+mKXCNHnV8hmQwAEWYTrtcQbFB
         m4qCNn01ddDDxFl5LtyXW1y2RRBj6h/4+KOrCi1vQ7OsHxQLhvJJ8XEp0K9/qihQZhzR
         lfpr3no9662K7TuqQWVx8nATW+vrD198ANNW/qpXZVM4Do8DN6YdNJCMH/lO+lsjSXiw
         o1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sfmAhjDDvKglfpukNd4+2Xk4zEwbSmYlXycBa4UscY=;
        b=Sw0WLM+ZsVu9j4dX86Ofae5mf20+oHMlbwtWyGK4LT4Mq2IpTJUDZrn4LhnyjuKRoj
         JhjFta76AysPV9VX5TjrczdD80rZb3Vj2inZuRU9ZZXINu+kEOQ0hRrtUo4IkFTbN7MV
         by9hvdoJCEMu+30q3jhZ0pW/HH1K6lcOWdHxl9WZ7+ABFDcCca9dz5zFKRKZrNjaGpOP
         IDwBrObXWQEIbVw7u5rG8bb/v0A4f1RhiiGdilGMLet6tgppW4yho3uHo/kih800fLn2
         MIMvEuG01fNLLhqB9CEq0nTulcKais9mRzQtctAzBLtnscq9m+vUSvvO2HRZAyCgbHAl
         GQwQ==
X-Gm-Message-State: APjAAAV1iJv/JK38nezkZ9BJ3kyJRk8BKivoBb6MvMig7X85mGWl3k4R
        DB9MPcHDaep/JpBolol16+pdpqCf0LFdMbfyli7qcQ==
X-Google-Smtp-Source: APXvYqx0cYAG5eNzatE3l2zSy8c+C7TMoRzbw2NBhOzfMKRErQZW87zrCo1i6EuRmLl2LZdUVDIzP6caUH73809snSo=
X-Received: by 2002:adf:e390:: with SMTP id e16mr9280799wrm.29.1567806984645;
 Fri, 06 Sep 2019 14:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <4d97a9bb-864a-edd1-1aff-bdc9c8204100@redhat.com> <CAJCQCtSm0rv=-zoAReP7+kjdvV1ihgi7tx1sh9YM=on_fZLKNg@mail.gmail.com>
In-Reply-To: <CAJCQCtSm0rv=-zoAReP7+kjdvV1ihgi7tx1sh9YM=on_fZLKNg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 6 Sep 2019 15:56:13 -0600
Message-ID: <CAJCQCtS0=-9RouGbn-hWKJrUT56mJT=3ij5_wC5jujLwrS95=g@mail.gmail.com>
Subject: Re: LTP fs_fill test results in BTRFS warning (device loop0): could
 not allocate space for a delete; will truncate on mount warnings
To:     Rachel Sibley <rasibley@redhat.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 6, 2019 at 3:35 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Fri, Sep 6, 2019 at 1:21 PM Rachel Sibley <rasibley@redhat.com> wrote:
> >
> > Hello,
> >
> > While running LTP [1] as part of CKI [2] testing, we noticed the fs_fill
> > test fails pretty
> > consistently with BTRFS warnings seen below, this is seen with recent
> > kernel (5.2.12).
> > I have included the logs below for reference.
>
> I'm only 6 for 6, but  so far can't get it to trigger with 5.3.0-rc7

Also cannot reproduce, 10 for 10 with 5.2.13-200.fc30.x86_64 which was
just built in koji, same as 5.2.12 which was quickly replaced with a
single unrelated revert for touchpads.

But comparing fs_fill logs, yours has a ton more writer threads (~6x)
and ENOSPC counts. Possibly related?

-- 
Chris Murphy
