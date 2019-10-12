Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160FBD5350
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Oct 2019 01:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfJLXcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Oct 2019 19:32:31 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:37951 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfJLXca (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Oct 2019 19:32:30 -0400
Received: by mail-vs1-f51.google.com with SMTP id b123so8598142vsb.5
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Oct 2019 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5OHUUay1kCYmDF2uE+HGbWXO6PqBJFTXNEGv/s7Br7o=;
        b=ZlnR3mNudiFd1LJt7kphIqiS7McLt5rzFZ1dTpe7+D5rXPmSzg9QmbJ935Y1MbElml
         V42NTcx5LL+utP9TKpTz5HgFTqtT2DJEdnB/fwyRAoTSGUBzLeN0Ey8QloMs+F0N4DTv
         17saSMWEd5yXWNpPqnUzLS2WYgCf3cVrbQjHbEvRgdRbL67JQ60hxFYbvg1WkVaDD5uB
         yGciBcjzUlwwTSgKdaGS4sPqAgDj22Mhqtyy12tJJNSrSFWcg/oVDQ3cp53vzBJXLziF
         PPLnI7ZlZRF3iRHfymtjmu7aBnjKcoqjQuPTchvlGSzWofFkRX1PtGGdUyL/zvDYkcnm
         uUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5OHUUay1kCYmDF2uE+HGbWXO6PqBJFTXNEGv/s7Br7o=;
        b=Kh4D6bQjWHF/q/6PSn0zYzRjQVHiV4WnLVvq2t4mm31qW/zYxyl3O/jcuLB0DUOfUI
         gJjCHoI6kQORUGqGReHweER+mpHd5zzZZdZA2xHqdZ1nMouvwRhF4tTyVk1nnUqaXcb/
         RnUmAEXyeiIq9lXXVLhyXhWSx5rU4qCEOmiACLWcquBsvkgxMol6/2l7fPfctDPjaBza
         TZSMiHMKUYEmok4ekyPx3m385ny792X5U9bYfnaqC1gfpEiSSXo2QuYnz3eOXsrf0UzY
         u/IOdkgvLxWQ5iGmzXbHT0tCdcQmwRnPO9XBel8aD6Vhp2TB25SAwHrXAV5I/3nHf4YB
         gM9w==
X-Gm-Message-State: APjAAAVxl2XvBdIPhslCjLzemBzD/PvNoT19beBikZmLOM7EzhleS38c
        5pO4y3mofPeiEjdRwXQUziHYZL6+dVH+KoalPw38Vg==
X-Google-Smtp-Source: APXvYqxvDm6ZDx5HkVGX/9m6VyZC24mHaX3H3E3HHKJWtSi7AUMnlC0KOl6dugWd4Bah4txC5V6juza5PYf9yixKzas=
X-Received: by 2002:a67:f703:: with SMTP id m3mr12794843vso.204.1570923148150;
 Sat, 12 Oct 2019 16:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn72nYqoMLLHAUZeO43_rLL9c=zwjDYG9MKV+rcZ7x6SXw@mail.gmail.com>
In-Reply-To: <CA+X5Wn72nYqoMLLHAUZeO43_rLL9c=zwjDYG9MKV+rcZ7x6SXw@mail.gmail.com>
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Sat, 12 Oct 2019 19:32:16 -0400
Message-ID: <CA+X5Wn7YTu_xc2n8aAO1S37HUDxW2Trst3iau-YiZnNC3SpacA@mail.gmail.com>
Subject: Re: 5.3.0 deadlock: btrfs_sync_file / btrfs_async_reclaim_metadata_space
 / btrfs_page_mkwrite
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 12, 2019 at 7:29 PM James Harvey <jamespharvey20@gmail.com> wrote:
>
> Was using a temporary BTRFS volume to compile mongodb, which is quite
> intensive and takes quite a bit of time.  The volume has been
> deadlocked for about 12 hours.
>
> ...

Surprisingly, I was able to touch an unrelated file on the volume
while the deadlock was ongoing.  I was able to CTRL+C the process, and
all of the uninterruptible sleep processes quit.  I was able to delete
the partial compilation and restart.  All without having to remount
the volume or reboot.
