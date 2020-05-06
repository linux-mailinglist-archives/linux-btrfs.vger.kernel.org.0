Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7728A1C7E35
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 01:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgEFXzS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 19:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgEFXzS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 May 2020 19:55:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4E4C061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 16:55:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so3757205wrx.10
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQ1vuMuhV5zRUe/0OFKOZxdhFSScnYmdn1HRum7uZKo=;
        b=H2Uq+HNgMsl3g3vvk4OHIByg58dGrPJvlV8Bd3YtBo7kwcJYWFqPqEgE9K5PRqhpBF
         cc9d1A0nbcgK+VWI52PhC6bYyPM8xAIzHKshXV1sKFivbQuHXBhBW3AnOEcLP+9OhIbR
         3GZulZOw51K1bWf0ShAGtOdDgNPQZMQMEPN1eP41KB+qHqXnvIPrrz8umqomvbWuSEIq
         to7vcsRbWY3ou050BJcwmcsPIw6Pu1lrYre5LMyT16E7wrZvnTglCyJ/PaCELquqyRJL
         jt9FsXBgqbJJPe62dbS2aMDC0cVL1rQC7TYb+wVO6NHiiF01woMfQ3TNXsUnFXFQpo1s
         SMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQ1vuMuhV5zRUe/0OFKOZxdhFSScnYmdn1HRum7uZKo=;
        b=Ev7IPenGEJR5mBPu9Aah5lxOaAMvVPkB+wbNq4/Vl04tX55ysDnr0cw97O0U/BZNEq
         RL68WGfQyIhwq9Yxm+hAYZT2urRgiXyq2DcGo3U+KztAMkEnykCuJxBZtIFcrPGIV15v
         p01VAaL3gQ7eBCQHKDRIKwJJHqC7MlyehYDhXYMcSbDT6aV8tb6QnXX/1CdCVKFc4ii6
         Z4atQxELRlhuw/tM2UDg2Is8yBxuioNnwHr0frv18GKU1M3Uj1ZvDaUIzAj07SmnDOCG
         UuIVlATVnd7rchqMe/MJ3HnKTG3wGqzF+OzvA7OTuswsCDHipIP5nNczQWGse7BJtAl/
         xnyQ==
X-Gm-Message-State: AGi0PubN7SVUAE+59GYi9NTZsFYskXJRWyByUSdmaM0hVL+V3/Aempb0
        F4WfW6Em4Ddg0ZD661bXy2hw+BPzYBRZi0nU/GMnWg7mtZkaOg==
X-Google-Smtp-Source: APiQypIeo2xtFTZ/YTIh46u5DzF6GZJo0li7W2n5/bZVSikl8P+DUK6Ye6xyDMWX2AyMrP8+kE8KFzcpEzsWxk/P5AQ=
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr9292915wrx.42.1588809316390;
 Wed, 06 May 2020 16:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
In-Reply-To: <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 6 May 2020 17:55:00 -0600
Message-ID: <CAJCQCtTqxWymZK5Bb5V8FJfur2dJUgrwZs9b1D4CNWGYjvEv_A@mail.gmail.com>
Subject: Re: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 6, 2020 at 3:54 PM Tyler Richmond <t.d.richmond@gmail.com> wrote:
>
> Hello,
>
> I looked up this error and it basically says ask a developer to
> determine if it's a false error or not. I just started getting some
> slow response times, and looked at the dmesg log to find a ton of
> these errors.
>
> [192088.446299] BTRFS critical (device sdh): corrupt leaf: root=5
> block=203510940835840 slot=4 ino=1311670, invalid inode generation:
> has 18446744073709551492 expect [0, 6875827]
> [192088.449823] BTRFS error (device sdh): block=203510940835840 read
> time tree block corruption detected
> [192088.459238] BTRFS critical (device sdh): corrupt leaf: root=5
> block=203510940835840 slot=4 ino=1311670, invalid inode generation:
> has 18446744073709551492 expect [0, 6875827]
> [192088.462773] BTRFS error (device sdh): block=203510940835840 read
> time tree block corruption detected
> [192088.464711] BTRFS critical (device sdh): corrupt leaf: root=5
> block=203510940835840 slot=4 ino=1311670, invalid inode generation:
> has 18446744073709551492 expect [0, 6875827]
> [192088.468457] BTRFS error (device sdh): block=203510940835840 read
> time tree block corruption detected
>
> btrfs device stats, however, doesn't show any errors.
>
> Is there anything I should do about this, or should I just continue
> using my array as normal?

What kernel version? This looks like relatively recent kernel
reporting format. Can you search for inode 1311670? e.g.

$ sudo btrfs insp ino -v 1311670 /mountpoint

Note that each subvolume has its own set of inodes. You need to point
the command to the correct subvolume. In this case it's root=5 which
is the default/top-level. As long as you haven't changed the default
subvolume, and you've mounted the file system without subvol or
subvolid option, it should point to the correct file that's affected
by this. And also maybe useful:

$ sudo btrfs insp dump-t -b 203510940835840 /mountpoint



-- 
Chris Murphy
