Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA0A1E12CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgEYQiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 12:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgEYQiQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 12:38:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263F1C061A0E
        for <linux-btrfs@vger.kernel.org>; Mon, 25 May 2020 09:38:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so519514wmh.2
        for <linux-btrfs@vger.kernel.org>; Mon, 25 May 2020 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+taEBbntBIey2kxpE3hppjU9begMPWR13852w8Zq978=;
        b=fP8R+pCXgRV5Dt4VjphuS/OKAPEEMb5lZORSiU9CCrAFcTRfavxvkmT3+kC/Shgn9s
         ezQDME7nqq9ien6dDiX03kEWcRlUQFlDF5rQO52RKK1ggr8ZXaBtHjmruQOCFo/9i/H3
         D2GzqF4YZhvjlvuL4WigjjBzHAwZe7pWe2nhKSA13mrRzSJUzW4h3QRCS2aWXgPouMJv
         vkx8kxAfuNPnn1y3Slpjo62SB9+0YGz/5Uiul/YtMKlFWtwEoOkyZvWHU3W0H5d4vL/k
         8d8CH95eLYKbbEOvCai4M7kqNuFz9lny9vP6SkRriGJ0idFepW5H3Pec1c6yae0pM6OO
         f9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+taEBbntBIey2kxpE3hppjU9begMPWR13852w8Zq978=;
        b=DjDirVtTM4aTR+j5QhiPOl+cXg/2jeP07jp0adSl6St5by+79v8oHovhwfWof8olIt
         gtti8d+w9AHbt1KxqLk3rNMvfwbq0/t7vANmV5aaOt+NEJ4pAHtBhVAo53jHlmNz24vC
         fqJy6QPn5BgQA5kiSluMJjXecCTTYNogvQ4Hbz9Iu2y4kCYr9QPyJvwzvao24+XtZlcW
         dWGtWF7Y0D9PVTRNUtpW9f2p8jfz8bvEs6fUtXcZHWP1pwws1kjR6w2Vi4XoTWvdkEQ5
         XsQkTwjSMISWwPbkVc0sksLhT3CsWsQcLVAYbw+Wqk4y0raYMcOMRBTg6qozswRx9OL0
         uhBQ==
X-Gm-Message-State: AOAM532FLDSj9HFyVJSiNsm2ljC5Id1/MTnfn7jxHLfam8b828RZ802P
        IqZRVyaAUGZjgYMTKcsAEzqA3TEk0ghOYDR2pIKqIiDPm2Q=
X-Google-Smtp-Source: ABdhPJxsZOuwptfwzSR3+MGohclrMi0QFhwRwWIeFM04JH0CDMvVFHrWg3ClBdNcMEKxUxB87jMjzUDrRHC1sbj3Vmo=
X-Received: by 2002:a05:600c:228d:: with SMTP id 13mr27127771wmf.182.1590424694867;
 Mon, 25 May 2020 09:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200524213059.GI23519@merlins.org>
In-Reply-To: <20200524213059.GI23519@merlins.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 25 May 2020 10:37:58 -0600
Message-ID: <CAJCQCtTWkRijC51qny+gLqFO=z-Jek4mbKN0O6udLKzzeNe_vw@mail.gmail.com>
Subject: Re: 5.5 kernel and btrfs-progs v5.6 create and cannot fix 'root
 204162 inode 14058737 errors 1000, some csum missing'
To:     Marc MERLIN <marc@merlins.org>
Cc:     Su Yue <Damenly_Su@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 24, 2020 at 3:31 PM Marc MERLIN <marc@merlins.org> wrote:
>
> My data is fine, it's double backed up and the filesystem is still mountable without issues.
> But I had an error that broke btrfs send, and after fixing it with repair, I'm stuck with thses 'csum missing'

I'm not following the sequence of events. The send|receive failed? Did
you try deleting the failed received snapshot?


> which I was able to fix with the repair below, but now I'm stuck with the 'some csum missing'.
> Checking filesystem on /dev/mapper/cr
> UUID: 4cb82363-e833-444e-b23e-1597a14a8aab
> [1/7] checking root items
> [2/7] checking extents
> data backref 2694234112 root 356 owner 14058737 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 2694234112 root 356 owner 14058737 offset 0 found 1 wanted 0 back 0x55e7383a3a00
> incorrect local backref count on 2694234112 root 2147484004 owner 14058737 offset 0 found 0 wanted 1 back 0x55e733d1c2b0
> backref disk bytenr does not match extent record, bytenr=2694234112, ref bytenr=0
> backpointer mismatch on [2694234112 8192]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 356 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192
> root 203332 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192


Is no-holes enabled on either file system?


-- 
Chris Murphy
