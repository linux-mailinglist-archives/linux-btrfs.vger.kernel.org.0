Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7291CB9CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 23:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgEHVbT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 17:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgEHVbT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 17:31:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877EC061A0C
        for <linux-btrfs@vger.kernel.org>; Fri,  8 May 2020 14:31:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so11685240wmj.1
        for <linux-btrfs@vger.kernel.org>; Fri, 08 May 2020 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITOWhMzHNg+Lp/CZlPtn9YDd1rMD0mVnbwI43AgCVKY=;
        b=2HUfhPZz7dVotKHau+Q3/AUQPlUfavBSc6uiZawu6QRBoBwR1/ROtBe+mgiNVCXBu6
         /+FuuN/3iwH/+eI+77iKbiz9o4OAxkWCkR871Fg3/v0OnYZsfpT0y2KCH3pHRN0lk0L1
         whOp30xqOMDnglRWdpVEX3fWL2MOp17RiL3433HJo914AlcYMoIlikegRDOQ74cH/7rM
         zmk8yfpyyyJAaEpkGac9L4Zm9nM/mlQycjE32qPeDYY+h+DwpK9xKAnxQppn3RoJ/ahJ
         TA3+esK6gk1fFv3udMl02CiHWW1vEHusjO4GRku8fj8LrElbDcJTjVNok4sTflGBR0Cj
         oPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITOWhMzHNg+Lp/CZlPtn9YDd1rMD0mVnbwI43AgCVKY=;
        b=g/QKXg+DawAtc6Odpv1wIgFa8ZebWzeQVIhqqdJNcnERCf7CPtIMbguy0dJmdJ+Xky
         HoFY9SpJESs14gSdBU6You+vNmll/SqnmtugovrAn4C+W6v7RAX5cVZ/4w9qmoM6d2W0
         oYwY0Sy8k+7LKozjyn+aOiNIMu04luR8HC00GGVxQV/nEKuN1sX2n3SDtgGhXHShq7NO
         PkTEvQUTfepgBxqra4xu9jP5zk0G0VrqYM6E3NE2pBRffIKkYJPMdZYzfoSSPdEwA/wh
         8WenxOLcBRMA3aX5GqbgXuo4LmyP9gzvGW0svMWXc8o7LB/Mokd8uepjI5EeC70dsz2i
         zpFQ==
X-Gm-Message-State: AGi0PuZwEx/XYK2UZ1ej9DAvVjYQn4nQ20+tHkyDH4SS45EUTwklf5EP
        NCRA7rASckpM5ys8MQ20d1k5XxGnhidDbdJwe3rxaA==
X-Google-Smtp-Source: APiQypLBJz9cck/Iz5nXrmFvv+mzV2ojuYlVzB2hOhR+6OR1Ut2C4owYj8rpty7RzWTunt3gx/Syb7LvX20N5Bzgvv0=
X-Received: by 2002:a1c:2348:: with SMTP id j69mr1441000wmj.11.1588973477862;
 Fri, 08 May 2020 14:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com>
 <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au> <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au> <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au> <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au> <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au> <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au> <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au> <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au>
In-Reply-To: <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 8 May 2020 15:31:01 -0600
Message-ID: <CAJCQCtSq7Ocar4hJM0Z+Y7UeRM6Cfi_uwN=QM77F2Eg+MtnNWw@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(gmail is super annoying sometimes, keyboard shortcuts that cause
email to be sent)

On Fri, May 8, 2020 at 11:06 AM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> And here we are again:
>
> $ sudo btrfs scrub status -d /home
> UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
> scrub device /dev/sda (id 1) status
> Scrub resumed:    Sat May  9 02:52:12 2020
> Status:           running
> Duration:         7:02:55
> Time left:        32261372:31:39
> ETA:              Fri Sep 17 23:35:41 5700
> Total to scrub:   3.66TiB
> Bytes scrubbed:   3.67TiB
> Rate:             151.47MiB/s
> Error summary:    no errors found
> scrub device /dev/sdb (id 2) status
> Scrub resumed:    Sat May  9 02:52:12 2020
> Status:           running
> Duration:         7:02:59
> Time left:        31973655:40:34
> ETA:              Mon Nov 21 19:44:36 5667
> Total to scrub:   3.66TiB
> Bytes scrubbed:   3.70TiB
> Rate:             152.83MiB/s
> Error summary:    no errors found
>
> I tried building btrfs-progs v5.6.1 from source, but it gives exactly
> the same results.

Do you have qgroups enabled?

$ sudo btrfs qgroup show /home
ERROR: can't list qgroups: quotas not enabled

What do you get for:

$ sudo btrfs insp dump-s /dev/

This dumps out the super block.

There are scrub related fixes in linux git since 5.4.0 but I can't
tell if any of them are related to this problem. My suggestion is
scrub with kernel 5.7.rc4. If the problem happens, it's a current and
unfixed bug. If it's been fixed, then it's a question of what commit
fixed it and whether it's been backported, or can be, to 5.4 series.



-- 
Chris Murphy
