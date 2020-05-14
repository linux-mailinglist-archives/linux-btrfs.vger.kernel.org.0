Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF811D2383
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 02:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbgENAON (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 20:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732847AbgENAOM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 20:14:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D92DC061A0C
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 17:14:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m12so23479370wmc.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 May 2020 17:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VV+DHWs0uVldeQ/4Y401HliTqBYY2uDO7Egj1bmp/7w=;
        b=ZFAsC4GHWEVaB7HPvm3yVp4Ic8dbUMq1agqoZZZW1RK9SkF9aIS95af71RCFnsFU4R
         MEcVAIrcf8QVrTPQMbSflJTLGaY5vKTlajzgNiugdLmOAk7/nEltnUtXcIhA3u4DNaz0
         e2taVpDs976agCtmG0xfA0gM8uwr65uoVcVsK539yGVh7rzXqxlHuOqtHo/Or0U7qMn2
         Rcow0B8j6DGlYlQP1+NCtrzcifFscnsbx2rEhulq8Hjxa1JD/v/gSgBrUaTVWtLWTkg5
         tdZRrHCtysKPkFpWNFs4GQnbkUMNTRhKc3pu4I++daLbKigpfhnd6WUtwv59HTzQJHAn
         PM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VV+DHWs0uVldeQ/4Y401HliTqBYY2uDO7Egj1bmp/7w=;
        b=nAO96Bt8rttge07Ewci72T5AfMV03Ge94tH8RapeDUa+m12hOOJHlofl7yEtB0/n0t
         3oWycv68ktiloDveSyc9YeeEngvGkVwyHI+Xvbf5N7vF4YK/rFHXZcrCe+2kcXoh1S91
         fLyH4iIt2CbwzfH2xfrfJFajQp8F+s8oMxjiXDK0GarGEKl4Qq7DRRUiX9U5lya6ip7r
         QOE+q3Oh/UAYnR+xbXlNWs/ZBitELJzvKB0JFSW9Y3qELleU0O+z+hUVBG9FTJjLpyQE
         bMEz2Bb2IdNujz5enhrGG+iHntLTGuQzS/tBwg6ZW//VhSVywoL1dRYE0trKcG+yCe/k
         ykdQ==
X-Gm-Message-State: AGi0PuacwBfDjFkIHqZxex1xg7uzV4B4cW6vSTIhy3nefBHu8U8d8qGp
        7Ao2TXKvisJqqq2nnf8Twl16OwLc9lApnkkTm0B+CcY1Usk=
X-Google-Smtp-Source: APiQypIqJpmLrf1K3dQ1NpeQUSuiuuMKR7cvd5FZwQlq5hZE2JxO5Ao3j806hEiuKpSLv8VG/v5DJOoqOCIgW+5vQb8=
X-Received: by 2002:a7b:ca53:: with SMTP id m19mr38277691wml.182.1589415251110;
 Wed, 13 May 2020 17:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au> <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au> <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au> <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au> <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au> <CAJCQCtSq7Ocar4hJM0Z+Y7UeRM6Cfi_uwN=QM77F2Eg+MtnNWw@mail.gmail.com>
 <04f481fd-b8e5-7df6-d547-ece9ab6b8154@sericyb.com.au> <CAJCQCtTdSSX15Y7YX7fAg+iKncZf09ZG6KnHmmo4S77OtGWWXw@mail.gmail.com>
 <b41da576-55b2-4599-10e9-e8aeb0e9ad20@sericyb.com.au> <CAJCQCtSWwypfm2xjtJ2vP8O4LT2bFOY=omHMMPe8_Jq6jG_3qA@mail.gmail.com>
 <65cdf796-02f6-d20f-4b7f-b258d1685e2c@sericyb.com.au>
In-Reply-To: <65cdf796-02f6-d20f-4b7f-b258d1685e2c@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 13 May 2020 18:13:54 -0600
Message-ID: <CAJCQCtS3OKrM2_bEVVhTEnqtOrV4aN80bpkYa60QfB9dz97anQ@mail.gmail.com>
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

On Wed, May 13, 2020 at 12:49 AM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> On 11/5/20 2:46 pm, Chris Murphy wrote:
> > I also wonder whether the socket that Graham mentions, could get in
> > some kind of stuck or confused state due to sleep/wake cycle? My case,
> > NVMe, is maybe not the best example because that's just PCIe. In your
> > case it's real drives, so it's SCSI, block, and maybe libata and other
> > things.
>
> Could be.  When I start a new scrub and suspend the system, after a
> resume further attempts to run "btrfs scrub status -dR /home" result in
> the following:
>
> NOTE: Reading progress from status file
> UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
> scrub device /dev/sda (id 1) status
> Scrub started:    Wed May 13 16:10:12 2020
> Status:           running
> Duration:         0:00:22
>         data_extents_scrubbed: 0
>         tree_extents_scrubbed: 29238
>         data_bytes_scrubbed: 0
>         tree_bytes_scrubbed: 479035392
>         read_errors: 0
>         csum_errors: 0
>         verify_errors: 0
>         no_csum: 0
>         csum_discards: 0
>         super_errors: 0
>         malloc_errors: 0
>         uncorrectable_errors: 0
>         unverified_errors: 0
>         corrected_errors: 0
>         last_physical: 0
> scrub device /dev/sdb (id 2) status
> Scrub started:    Wed May 13 16:10:12 2020
> Status:           running
> Duration:         0:00:23
>         data_extents_scrubbed: 0
>         tree_extents_scrubbed: 27936
>         data_bytes_scrubbed: 0
>         tree_bytes_scrubbed: 457703424
>         read_errors: 0
>         csum_errors: 0
>         verify_errors: 0
>         no_csum: 0
>         csum_discards: 0
>         super_errors: 0
>         malloc_errors: 0
>         uncorrectable_errors: 0
>         unverified_errors: 0
>         corrected_errors: 0
>         last_physical: 0
>
> So it appears that the socket connection to the kernel is not able to be
> reestablished after the resume from suspend-to-RAM.  Interestingly, if I
> then manually run "btrfs scrub cancel /home" and "btrfs scrub resume -c3
> /home" then the status reports start working again.  It fails only when
> "btrfs scrub resume -c3 /home" is run from the script
> "/usr/lib/systemd/system-sleep/btrfs-scrub" as follows:
>
> #!/bin/sh
>
> case $1/$2 in
>   pre/*)
>     btrfs scrub cancel /home
>     ;;
>   post/*)
>     sleep 1
>     btrfs scrub resume -c3 /home
>     ;;
> esac
>
> Without the sleep, it does not resume the scrub.  A longer sleep (5
> seconds) does not resolve the issue with the status reports.
>
> Maybe this is some kind of systemd problem...  :(

Oof. So possibly two bugs.

Well, you could post an inquiry about it to systemd-devel@. And then
maybe try to reproduce with something that has systemd-245 to see if
it makes a difference. I ran into something that looked like races in
244 with a rust generator I was testing, that didn't happen in 245.
*shrug*

But I'm not sure testing wise how to isolate the systemd from the
socket questions.


-- 
Chris Murphy
