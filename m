Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647821CC5EF
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 May 2020 03:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgEJBOp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 21:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726565AbgEJBOp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 May 2020 21:14:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C06C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  9 May 2020 18:14:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so6402828wrn.6
        for <linux-btrfs@vger.kernel.org>; Sat, 09 May 2020 18:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPTrcYvDTV3XYu0DL5kyusrWBJyPV14wiZusTn9gp3M=;
        b=hOAySApmaAVfrpVCfLXVAJFlyV+ORjPjfiQjXHLU/eRDLD90xFTl4V0GdGbspv/AEh
         qCQQ/ALAxvGw1kjeiB4Wsn+u4cKbgbjNmpjzGj1WFIIVSNtkVtdGNKuhd2d/i9c6eLff
         iTWiiDUMYsJeOhKZ3RJp4vgpm8ESxU/adDwaxfvDPMwsgwO8tglKadoEiaue4eUC+483
         JbddKDkpPNKtug99QykKZ+lQFtXhu2cBX4whxpRLzfJnfMjgyL3nZeOkIKmfmFss4rfe
         M9DavlbvqL4xsTBaImzhSmkH/15Bm3peeY9cgVRikefgRpkxH9Llxm8bpRWv319twnB7
         lT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPTrcYvDTV3XYu0DL5kyusrWBJyPV14wiZusTn9gp3M=;
        b=K8sMoyJAhAmcoTijpFGE60sWzTsPMU9Qk6gyMKLsdRH1mLzABS9i7vU/cvH8Pw0BQX
         ivhHDsfOAKey4m1KYiABQNj9iR0JhykrmioQkDUu4t3/cmvMLtw7A3fErw9d9nL3GX6F
         yigMDr/zAFuICpbH9fhvkJS5SnDs3CN9yR4HnSL+35/k0q2vHSfGaEoSeM0zzWmlAqPV
         XvNUm5+FGWrKrcTnPprcn9Rgc1yuCL9xQqapFXtJQLkOBCkXAhlYYNvsWxTpiu4E3xAZ
         PXlZqIFAbOk6r06B/DqYDq/Yyzlx6Rm3gVpovikBb4Sj5zoKzA8BkO3DojrZ5gEKQklp
         YsHw==
X-Gm-Message-State: AGi0PubAroqF76P4QbVeYYb7Dh3DoTbf2Xl+AKKfhbbfv4cVg4/6vApZ
        dam/KZz1B2uno4ZF9s7hfatmIFULe9qyw2HoC6r4/w==
X-Google-Smtp-Source: APiQypI7tdPypA7CWzBcyMnip33szeMYXJbY2wtlzW4bBQh6nH5R6kFmFYfLLvhGDWQDCJ3n4UWYvA7XBt9HUTr3xGI=
X-Received: by 2002:a5d:51cb:: with SMTP id n11mr10618846wrv.236.1589073282104;
 Sat, 09 May 2020 18:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au> <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au> <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au> <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au> <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au> <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au> <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au> <CAJCQCtSq7Ocar4hJM0Z+Y7UeRM6Cfi_uwN=QM77F2Eg+MtnNWw@mail.gmail.com>
 <04f481fd-b8e5-7df6-d547-ece9ab6b8154@sericyb.com.au> <CAJCQCtTdSSX15Y7YX7fAg+iKncZf09ZG6KnHmmo4S77OtGWWXw@mail.gmail.com>
In-Reply-To: <CAJCQCtTdSSX15Y7YX7fAg+iKncZf09ZG6KnHmmo4S77OtGWWXw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 9 May 2020 19:14:25 -0600
Message-ID: <CAJCQCtTcwGm8WF+AKX4CBBRQ2vYjj-ZPx66So3Qxvp8Y9j5rJg@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrew Pam <andrew@sericyb.com.au>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 9, 2020 at 2:33 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sat, May 9, 2020 at 4:15 AM Andrew Pam <andrew@sericyb.com.au> wrote:
> >
> > $ uname -a
> > Linux RainbowDash 5.7.0-050700rc4-generic #202005051752 SMP Tue May 5
> > 21:56:32 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> >
> > After a couple of cancel/resumes here we are again:
>
>
> OK I didn't previously pick up on the fact that you're cancelling a
> scrub. Suspending. Then resuming.
>
> Things to verify:
>
> 1. That a scrub started, and allowed to finish without any
> interruption, does finish. This is the only experience I have, but I'm
> wondering whether you've tried this just to eliminate the possibility
> of some weird multiple device scrub bug; or possibly something unique
> about your file system state.
>
> 2. That a scrub started, then cancelled, then resumed, also does
> finish (or not).
>
> 3. That a scrub started, then cancelled, then suspend-to-RAM, then
> resumed, also does finish (or not).


I just tried all three of these on my laptop, which has NVMe and
5.7.0-0.rc4.1.fc33.x86_64+debug. And they all complete, with no odd
reporting in user space for ETA, and progress seems normal.

I do see this in dmesg, which I think coincides with the cancel/abort
[98580.937332] BTRFS info (device nvme0n1p7): scrub: not finished on
devid 1 with status: -125

I don't know how the kernel and user space communicate scrub progress.
I don't see anything in sysfs.

When you see this problem manifesting (no progress being made) the
/home file system is otherwise working normally? You can read and
write files OK?


-- 
Chris Murphy
