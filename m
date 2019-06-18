Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB09B4AA5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 20:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfFRSxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 14:53:39 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35388 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfFRSxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 14:53:39 -0400
Received: by mail-wr1-f44.google.com with SMTP id m3so664698wrv.2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYrfJgIBZpaY2LB2TiakWSj63xDeV3BumXGgCFW3lRI=;
        b=GgWeiH4ofiOOPn2ZK6HJrPXPjARpvIESWqUAzqRP0JvPn+aUZ+5mmPJ1n5E+Ed5UiS
         X04a/mFWYeeq1ja6gjFMXoSeq4r+vQPTDk/xHyFqzWBzQ3nYL+YH49Gi/W1zqJSsqYJq
         UDGKgGGOm/xP6YXzXkfQiBU/dLpnuS5CUOz0Vsn8TCnDz9keYWrYWH0hDNW1tGQluh0w
         nRKA2YA4aLHWY1RQ+hJNqt6oLbQqfzMt5gnnTISSChMdnueghajofHk5nXFNXAvbpepy
         2M/cpGBZYH/t2VUWwNHl7ZB0R1bzwGlktBVd/R5nBMBY6HBaTn9oXJaTqa2BRIGSKg+/
         C34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYrfJgIBZpaY2LB2TiakWSj63xDeV3BumXGgCFW3lRI=;
        b=eRoBt1Csbgg/O+O8QmEiuygzaHvkeQloy5LSBrk8KYqluLSojNdklqGnNajWRFgjJg
         MnQsjHO25dhHDRbilZ3dAK1ZUHwVB40YOjqAUXoUvFQQsE9+AksdlOk5RuMZajdh6Xs6
         4abJriYReB6SDkSqEtazuVCFzePtNb73ZvP7umYtbs1UHV5A67wyRI08Z9XkEgOK2jqE
         ACtc/kOJBatJ4mPvr0ep0dxOYC0Ihv7xmkyoyUXauTJgf5AYxx4DRSUmpEa3bHaaT50N
         SjKBnVwjz/Qnm0wO4lVh0hI6+zSObuH/XPhjQPuj/Apg26x1k5uPv/ZXatRpHO+RA+8a
         evVg==
X-Gm-Message-State: APjAAAVGX8giX7+RpTWElyHrIusaYxPWB4PAgY4QHjHBNYJyJm54Ncz+
        3NlbiusrQd8yGMZ8nlj3cXjgktiFhuWxkXUJk9EyIPMK6Jg=
X-Google-Smtp-Source: APXvYqwDwy6yUD5W1DnvS6xfdjlgkugX1xphZzlr1eDod4eDhfrGoh44aCt6J0NplfQyz8V0N9pW34O08RtsAdN3xFM=
X-Received: by 2002:a5d:4843:: with SMTP id n3mr31119021wrs.77.1560884017346;
 Tue, 18 Jun 2019 11:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtS4PRWU=QUY87FRd4uGE_wA+KSSLW+2e_9XDs5m+RYzsQ@mail.gmail.com>
 <20190617104539.GF24827@gardel-login> <CAJCQCtQT+PJR14Z6iMmiw63LaPqrn0cWjdU6daNhF=D_67eALg@mail.gmail.com>
In-Reply-To: <CAJCQCtQT+PJR14Z6iMmiw63LaPqrn0cWjdU6daNhF=D_67eALg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 18 Jun 2019 12:53:26 -0600
Message-ID: <CAJCQCtT6NgAmZkiWuTLD1Js-bvDHL-LeVo+wgbhdSNW4cmsD1A@mail.gmail.com>
Subject: Re: 5.2.0 rc5, circular lock warning systemd-journal and btrfs_page_mkwrite
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 18, 2019 at 11:45 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> This still happens on RC5, attaching full dmesg to this email.
>
> [    8.432777] BTRFS info (device sda6): use zstd compression, level 3
> [    8.432791] BTRFS info (device sda6): using free space tree
> [    8.581762] systemd-journald[649]: Received request to flush
> runtime journal from PID 1
>
> [    8.639535] ======================================================
> [    8.641452] WARNING: possible circular locking dependency detected
> [    8.643283] 5.2.0-0.rc5.git0.1.fc31.x86_64+debug #1 Not tainted
> [    8.645060] ------------------------------------------------------
> [    8.646765] systemd-journal/649 is trying to acquire lock:
> [    8.648393] (____ptrval____) (&fs_info->reloc_mutex){+.+.}, at:
> btrfs_record_root_in_trans+0x44/0x70 [btrfs]
> [    8.650111]
>                but task is already holding lock:
> [    8.653475] (____ptrval____) (sb_pagefaults){.+.+}, at:
> btrfs_page_mkwrite+0x69/0x570 [btrfs]
> [    8.655238]
>                which lock already depends on the new lock.

It would not attach so here it is:
https://drive.google.com/open?id=1KahsVcP88CpJprMe6aCFilpj22uGo0Nn

-- 
Chris Murphy
