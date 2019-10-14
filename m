Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE72ED5958
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 03:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfJNBqG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Oct 2019 21:46:06 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38979 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfJNBqG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Oct 2019 21:46:06 -0400
Received: by mail-wr1-f50.google.com with SMTP id r3so17699318wrj.6
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Oct 2019 18:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+sInzwh126vD0mjy7QlqsAueTOvL34l2FbJNcyMFc8=;
        b=z2ZzOq4Z/eQzTUaDuFEwQ73kLuUBgcF/H5sRMyZEZV9/P90QhXM9C/L/tz0OwRJkGt
         trH9kMDw0T2cFL4rHnhRA8eGVbNRZ8rt/CjPgx8PktUoMGCiwmxl9fgG5jVcIC33XV5F
         N1DODMsEArrV5IvTI177EzueFF7qrGicmUvQXM7brfPv6tFFa3OLi22iEapBt1D25hZi
         x6e6ssEeuWf3l2Gl41CAyxICSIkazd/L/5qxCIvYjDzEp9uN2+ldBl8S3oIAY13mIx+L
         XTztz5yo8H1EsjRrs8VIfRjCpsusPp7a/nZEcgC1NJutMEupWQUdrLkxKxLah+UTDBw8
         HfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+sInzwh126vD0mjy7QlqsAueTOvL34l2FbJNcyMFc8=;
        b=cnarZZoDbkKpVBmjqMGbNxW+UBN6+E4n24jGPYAU3YQhQbtZt3gClU8vNVI9FXzVE2
         QVEu1MoQAnfv0O5iLcdsDRR8hXAYpaJmTLPPN81/3NLC/zdJcMQqorbTLw1Zb9gQMPwQ
         Xy/GuYnV1w1C5QyBo5acnKtTP/EIPRhqeW9+3iiuwXv8Qr+h0V2qftm39zwTtT/nmiTD
         0hUVsB4cdDQRyXQ3KQgEkwUJRnOSFPE7K3mP9RDGgG5tXp8QYXi9lkWKD7Qy4Ne8A48d
         4WSMxBfQhR7sSdknOCZbHLtsre2cNhz52BSMc6MwMtKAsgzDrc8kTtYHnKLIg1TeU6fy
         TuEA==
X-Gm-Message-State: APjAAAXKpo/VVLudUV2/TIsQpopjXUbFGLJmNFMLiky5L1ITjmIRarxb
        p1UOvnd/KBuwU1+ZDq1fS7t2eP2NTbYvK9Jmwc5AWQ==
X-Google-Smtp-Source: APXvYqze5XSIiJL38Z/CW/IlZ6KEu9baJNFuikQTDELoLh9GrMQOZzYDOX9wzDnmhnKHilBtS897QAoywdJJc7P0wjM=
X-Received: by 2002:adf:fe8b:: with SMTP id l11mr23539056wrr.167.1571017564047;
 Sun, 13 Oct 2019 18:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn72nYqoMLLHAUZeO43_rLL9c=zwjDYG9MKV+rcZ7x6SXw@mail.gmail.com>
In-Reply-To: <CA+X5Wn72nYqoMLLHAUZeO43_rLL9c=zwjDYG9MKV+rcZ7x6SXw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 13 Oct 2019 19:45:47 -0600
Message-ID: <CAJCQCtT6=msmaMJg-GrV8x=oPUEwuMjHxtXLQMrtSDHkq-DDZw@mail.gmail.com>
Subject: Re: 5.3.0 deadlock: btrfs_sync_file / btrfs_async_reclaim_metadata_space
 / btrfs_page_mkwrite
To:     James Harvey <jamespharvey20@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 12, 2019 at 5:29 PM James Harvey <jamespharvey20@gmail.com> wrote:
>
> Was using a temporary BTRFS volume to compile mongodb, which is quite
> intensive and takes quite a bit of time.  The volume has been
> deadlocked for about 12 hours.
>
> Being a temporary volume, I just used mount without options, so it
> used the defaults:  rw,relatime,ssd,space_cache,subvolid=5,subvol=/
>
> Apologies if upgrading to 5.3.5+ will fix this.  I didn't see
> discussions of a deadlock looking like this.

I think it's a bug in any case, in particular because its all default
mount options, but it'd be interesting if any of the following make a
difference:

- space_cache=v2
- noatime



-- 
Chris Murphy
