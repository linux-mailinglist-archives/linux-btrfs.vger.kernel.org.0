Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8B61CA1FE
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 06:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgEHEV6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 00:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgEHEV6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 00:21:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80FC05BD43
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 21:21:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u127so9151384wmg.1
        for <linux-btrfs@vger.kernel.org>; Thu, 07 May 2020 21:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHA6dN+NUgzwGg4bOR/siOWK3pyuYcl8Dwnif/bWEiQ=;
        b=yUJ6xOnpegN8k113T+vAdnC99Vj2p138l5fOyTtng13HMwAxcXNeO+pKlc7pVqk1KJ
         2/ozbAqX1H6l6OseVMQ9ohtc+QxlKWZi9MpQ3V5v3kzPqxYCmTW+8l3yqzBkCiTQ2xkK
         biTtAAC7wLMui9nLSy8jvUVSnJUvlB1VugN0veXX7tTvoR9VgsgFu5J4vrwSpNfELw9B
         IasOyxnqgGLyh1jr7kd/YSycQ3BOMjohGhNY/826Zduf1IyIDrIZ7CVhr1kJfU+7nqc/
         2JIdd8/Ucefnm7wwjxBlPGAg4wOAZ4CA5odbp1poLBerOkw7RU6waWBFrnuV3R1/Qj1n
         Vp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHA6dN+NUgzwGg4bOR/siOWK3pyuYcl8Dwnif/bWEiQ=;
        b=eSp3Gwuo2gjD57nkA3o1mBtEScb2ddZ4z+Q5qk9r6kWa9t9jAYfn5iDQ/hyjcwRhKv
         r7SJ6q3RK7VUMlsRFqyxmK9n1MKHjbw9SCs5vw3NJOirVu3gWoq/aw16E2umYlq6sNI6
         V4aGvibX2bKd6Nn9jHYeYaYQE6wG0rgys6THgxzEpmSfvoGpII4yKxIAdaEac/3YJ4Sd
         JjlLkX7u/ij8x3ZfZjI4aHQvxuSfpjoJK5hGdZJ4mP8nx4dKUvfk9wZ6BfaHu22+Y55G
         j0yhXwtHD+CvN2ti8WXx3lzgFdfMviAoBUcjYz6AirNfedImLt+P9+kXM3RchbGQGAN4
         OUYQ==
X-Gm-Message-State: AGi0PubiWjfVITlx8weU73ElqcQfHpE9Jeq5IGmmpp5vkHohsIhuozCT
        8LWrvd3GEhze92HnWRjN8EWh/AoEg0gWv+rlgB3XTw==
X-Google-Smtp-Source: APiQypKtn5INmB84dIcJX5fjjrZo0tw2gGcsr55YDv77Pbtm0CiMbxDCE5ELuwpve2MaNaJpfKNVQCFHoSvLDUh9WAo=
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr13720680wmc.124.1588911716382;
 Thu, 07 May 2020 21:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net> <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
 <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com>
 <9b763f5f-3e42-c26d-296c-e7a7d9cde036@sericyb.com.au> <CAJCQCtTorye5PTcH6crVYES4eAwVphhx3Au6xd7tijef1HU8uA@mail.gmail.com>
 <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com>
 <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au> <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au> <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au> <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au>
In-Reply-To: <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 7 May 2020 22:21:40 -0600
Message-ID: <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 7, 2020 at 10:04 PM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> On 8/5/20 1:55 pm, Chris Murphy wrote:
> > OK what's the current output from
> > $ sudo btrfs scrub status -d /home
> >
> > 21 hours ago, the report was that it'd take 9 hours to scrub.
>
> UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
> scrub device /dev/sda (id 1) status
> Scrub started:    Thu May  7 15:44:21 2020
> Status:           running
> Duration:         5:40:13
> Time left:        1:22:58
> ETA:              Fri May  8 15:25:44 2020
> Total to scrub:   3.66TiB
> Bytes scrubbed:   2.94TiB
> Rate:             151.16MiB/s

What does 'iotop -d 10 -o' report? I'm expecting around 300MB/s reads.

The ETA is +14 hours what you posted 21 hours ago. So yeah that's
fakaked, but at least it's not saying it'll be done in year 5544!

I've always seen the ETAs be pretty accurate so I don't know what's going on.

3082813.44MB to go divided by 300MB/s is 171 minutes. Or just under 3
hours. So the time left / ETA is wrong based on this rate, if it's a
stable rate, which it might not be.

The gotcha if the rate is changing due to concurrent load or a decent
amount of free space fragmentation, could be to blame. Hence iotop.

What are the current mount options for this file system?



-- 
Chris Murphy
